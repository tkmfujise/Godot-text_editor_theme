# Godotの画面上でテーマを「Custom」にして色をいじると、
# ~/Library/Application Support/Godot/editor_settings-4.tres
# に、
# text_editor/theme/highlighting/control_flow_keyword_color = Color(0.168627, 0, 0.992157, 1)
# のような形で格納されていた。
# "text_editor/theme/" 以下だけ抜き出すのはテキストエディタで簡単にできたが、
# "Color(1, 1, 1, 1)" のところは "#FFFFFFFF" のように16進数表記にしないといけないらしかったので以下スクリプトで変換した。

path = "~/path/to/Custom.tet.backup"

str = File.read(path)
new_str = str.gsub(/([\d.]+)/){|_|
  match = Regexp.last_match
  (match[1].to_f * 255).to_i.to_s(16).upcase.rjust(2, "0")
}.gsub(/Color\((.+)\)/){|_|
  match = Regexp.last_match
  '"' + "\##{match[1].remove(/[,\s]/)}" + '"'
}

File.write(path.remove(/\.backup$/), new_str)
