# CRD Kurulum Scripti
$ErrorActionPreference = "Stop"

# Chrome + CRD Kur
Invoke-WebRequest -Uri "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile "$env:TEMP\chrome.exe"
Start-Process "$env:TEMP\chrome.exe" -ArgumentList "/silent /install" -Wait

Invoke-WebRequest -Uri "https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi" -OutFile "$env:TEMP\crd.msi"
msiexec /i "$env:TEMP\crd.msi" /qn /quiet

# Auth komutunu GitHub'dan çek
$auth = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/USER/REPO/main/auth.txt" -UseBasicParsing
Invoke-Expression $auth

# PIN ayarla
& "${env:ProgramFiles(x86)}\Google\Chrome Remote Desktop\CurrentVersion\remoting_start_host.exe" --pin="${{ secrets.CRD_PIN }}"

Write-Host "CRD KURULDU! PIN: ${{ secrets.CRD_PIN }}"
