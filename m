Message-ID: <003301c2735c$4def2960$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: my_console_write
Date: Mon, 14 Oct 2002 10:32:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi to all,

I'm currently working with the EST8260 board, were I have already linux
2.4.0-test2 running. This board has been loaded with the PPCboot 1.0.5. The
problem is arised when I have tried to configure the HHL2.0 to run with the
kernel 2.4.2.

The PPCboot starts with the following indication:
----------------------------------------------------------------------------
-----------------------
PPCBoot oFEC001A 1.0.5 may16 (May 17 2002 - 20:37:01)

MPC8260 Reset Status: External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 0, corecnf 0x0a, busdf 7, cpmdf 1, plldf 0, pllmf 3
 - vco_out  264000000, scc_clk   66000000, brg_clk   66000000
 - cpu_clk  132000000, cpm_clk  132000000, bus_clk   33000000

CPU:   MPC8260 (Rev 01, Mask A.1 1K22A-XC) at 132 MHz
Board: EST SBC8260
DRAM:  16 MB
FLASH: 16 MB
*** Warning - bad CRC, using default environment

BEDBUG Ready
In:    serial
Out:   serial
Err:   serial

Autobooting in 5 seconds, press " " to stop

PPCBoot oFEC001A 1.0.5 may16 (May 17 2002 - 20:37:01)

BOOTP broadcast 1
ARP broadcast 1
TFTP from server 10.0.0.2; our IP address is 10.0.0.20
Filename '/tftpboot/image-2.4.2'.
Load address: 0x500000
Loading: *#################################################################
  ##########################
done
Bytes transferred = 464291 (715a3 hex)
## Booting image at 00500000 ...
   Image Name:   SBC8260 HHL 2.0 Linux 2.4.2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    464227 Bytes = 453 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
----------------------------------------------------------------------------
-----------------------
After this no other messages are shown on the console and the program is
running in the infinite loop.

I have then tried to stop the PPCboot over the prompt, giving the command
"bootp" and "bootm" manually.

This is the answer of board:
----------------------------------------------------------------------------
-----------------------
EuroStudio> bootp 0x500000 /tftpboot/image-2.4.2
BOOTP broadcast 1
ARP broadcast 1
TFTP from server 10.0.0.2; our IP address is 10.0.0.20
Filename '/tftpboot/image-2.4.2'.
Load address: 0x500000
Loading: *#################################################################
  ##########################
done
Bytes transferred = 464291 (715a3 hex)
EuroStudio>



EuroStudio> bootm
## Booting image at 00500000 ...
   Image Name:   SBC8260 HHL 2.0 Linux 2.4.2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    464227 Bytes = 453 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.4.2_hhl20 (root@ProvaOS) (gcc version 2.95.3 20010315
(release/MontaVista)) #31 dom ott 13 21:41:18 CEST 2002
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
Warning: real time clock seems stuck!
Calibrating delay loop... 87.85 BogoMIPS
Memory: 14800k available (864k kernel code, 364k data, 48k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.01
ttyS00 at 0x0000 is a SMC
ttyS01 at 0x0040 is a SMC
ttyS02 at 0x8100 is a SCC
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9746kB/3248kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: SCC ENET Version 0.1, 00:a0:1e:b0:06:fe
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 10.0.0.2, my address is 10.0.0.20
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.0.2
Looking up port of RPC 100005/2 on 10.0.0.2
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 48k init 4k openfirmware
INIT: version 2.78 booting
Activating swap...
Checking all file systems...
Parallelizing fsck version 1.19 (13-Jul-2000)
Mounting local filesystems...
not mounted anything
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: done.
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd klogd.
Starting internet superserver: inetd.

MontaVista Software's Hard Hat Linux 2.0

10.0.0.20 login:
----------------------------------------------------------------------------
-----------------------

The system is up and running.
I have checked the initialization sequence and I found that the program is
looping into a procedure called "my_console_write" probably trying to send
the character out (the same procedure does not exist into 2.4.0 kernel).
I believe that the problem could be related to some initial configuration of
PPCboot, but I don't explain to myself how the program runs when I give the
command manually and why with the 2.4.0 image the same problem is not
present.
Can anybody help me?

many thanks

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
