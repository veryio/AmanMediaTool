#!/bin/bash

# ===== COLORS =====
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
C='\033[1;36m'
W='\033[1;37m'
N='\033[0m'

# ===== FOLDERS =====
BASE="/sdcard/AmanMediaTool"
MUSIC="$BASE/Music"
VIDEO="$BASE/Videos"
HISTORY="$BASE/history.txt"

mkdir -p "$MUSIC" "$VIDEO"
touch "$HISTORY"

banner() {
clear
echo -e "${C}"
echo " █████╗ ███╗   ███╗ █████╗ ███╗   ██╗"
echo "██╔══██╗████╗ ████║██╔══██╗████╗  ██║"
echo "███████║██╔████╔██║███████║██╔██╗ ██║"
echo "██╔══██║██║╚██╔╝██║██╔══██║██║╚██╗██║"
echo "██║  ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║"
echo "╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝"
echo -e "${Y}        AMAN MEDIA TOOL${N}"
echo -e "${W}   Created by: Junoon Khan${N}"
echo -e "${W}   Email: junoon.khan17@gmail.com${N}"
echo ""
}

menu() {
echo -e "${G}1) Search Song / Video Online"
echo "2) Download MP3 from URL"
echo "3) Download Video from URL"
echo "4) View Download History"
echo "5) Open Media Folder"
echo "0) Exit${N}"
echo ""
read -p "Select option: " opt
}

search_media() {
read -p "Enter name to search: " query
echo ""
echo -e "${Y}Search Links:${N}"
echo "YouTube: https://www.youtube.com/results?search_query=$query"
echo "Spotify: https://open.spotify.com/search/$query"
echo "SoundCloud: https://soundcloud.com/search?q=$query"
echo "Archive (Free Media): https://archive.org/search.php?query=$query"
echo ""
read -p "Press enter to continue..."
}

download_mp3() {
read -p "Enter video URL: " url
yt-dlp -f bestaudio -x --audio-format mp3 -o "$MUSIC/%(title).50s.%(ext)s" "$url"
echo "$(date) | MP3 | $url" >> "$HISTORY"
echo -e "${G}Saved in Music folder${N}"
read -p "Press enter to continue..."
}

download_video() {
read -p "Enter video URL: " url
yt-dlp -f bestvideo+bestaudio -o "$VIDEO/%(title).50s.%(ext)s" "$url"
echo "$(date) | VIDEO | $url" >> "$HISTORY"
echo -e "${G}Saved in Videos folder${N}"
read -p "Press enter to continue..."
}

view_history() {
echo -e "${C}Download History:${N}"
cat "$HISTORY"
echo ""
read -p "Press enter to continue..."
}

open_folder() {
termux-open "$BASE"
}

# ===== MAIN LOOP =====
while true; do
banner
menu
case $opt in
1) search_media ;;
2) download_mp3 ;;
3) download_video ;;
4) view_history ;;
5) open_folder ;;
0) exit ;;
*) echo "Invalid option"; sleep 1 ;;
esac
done
