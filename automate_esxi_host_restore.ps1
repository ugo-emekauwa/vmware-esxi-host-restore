# Automated VMware ESXi Host Configuration Restore Script, written by Ugo Emekauwa (uemekauw@cisco.com or uemekauwa@gmail.com)

# Start script
Write-Output "$(Get-Date) - Starting VMware ESXi Host Configuration Restore Script." | Out-File -Append "c:\Logs\sample.log"

# Load VMware PowerShell Modules
Write-Output "$(Get-Date) - Loading VMware PowerShell Modules." | Out-File -Append "c:\Logs\sample.log"
Get-Module -Name VMware* -ListAvailable | Import-Module

# Start VMware ESXi host 1 operations
Write-Output "$(Get-Date) - Beginning VMware ESXi host 1 operations." | Out-File -Append "c:\Logs\sample.log"

# Log into VMware ESXi host 1
Write-Output "$(Get-Date) - Logging into VMware ESXi host 1." | Out-File -Append "c:\Logs\sample.log"
Connect-VIServer -Server 192.168.100.10 -User root -Password password -Force

# Shutdown virtual machines on VMware ESXi host 1
Write-Output "$(Get-Date) - Retrieving VMs on VMware ESXi host 1." | Out-File -Append "c:\Logs\sample.log"
$vms = Get-VM
Write-Output "$(Get-Date) - Shutting down VMs on VMware ESXi host 1." | Out-File -Append "c:\Logs\sample.log"
$vms | Shutdown-VMGuest -Confirm:$false

# Place VMware ESXi host 1 in maintenance mode
Write-Output "$(Get-Date) - Placing VMware ESXi host 1 in maintenance mode." | Out-File -Append "c:\Logs\sample.log"
Set-VMHost -State Maintenance

# Restore backup configuration on VMware ESXi host 1
Write-Output "$(Get-Date) - Restoring backup configuration on VMware ESXi host 1." | Out-File -Append "c:\Logs\sample.log"
Set-VMHostFirmware -VMHost 192.168.100.10 -Restore -SourcePath "C:\ESXi_Host_Backup\configBundle-esxi-host-server1.tgz" -HostUser root -HostPassword password

# Disconnect from VMware ESXi host 1
Write-Output "$(Get-Date) - Disconnecting from VMware ESXi host 1." | Out-File -Append "c:\Logs\sample.log"
Disconnect-VIServer -Confirm:$false

# Pause script for VMware ESXi host 1 reboot to complete.
Write-Output "$(Get-Date) - Pausing script for VMware ESXi host 1 reboot to complete." | Out-File -Append "c:\Logs\sample.log"
sleep 300

# Exit script
Write-Output "$(Get-Date) - ESXi Restore Script complete, exiting." | Out-File -Append "c:\Logs\sample.log"
Exit
