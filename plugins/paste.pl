# Pasting command
#
# Usage: 
#
#   /PASTE /path/to/file (Optional) language
#


sub cmd_paste
{
    $paste_parameters = shift;
    $server = shift;
    $window = shift;
    ($path, $lang) = split(" ", $paste_parameters);
    if ($lang) {
        $lang = lc($lang);
    } else {
        $lang = "text";
    }
    $paste = sprintf("curl -s http://bpaste.net/ --data-urlencode 'code@%s' -d 'language=%s&webpage=&private=on' -D- -o/dev/null | grep http", $path, $lang);
    $url = `$paste`;
    chomp($url);
    if (!$window) {
        Irssi::print("$url");
    } else {
        $window->command("MSG $window->{name} $url");
    }
    return;
}

Irssi::command_bind('paste', 'cmd_paste');
