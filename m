Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <B0CD235912AED411B69800D0B7C9F60F1DF88A@mail>
From: "Francis Yu <francisy@luxn.com>" <francisy@luxn.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Hung inside execve
Date: Tue, 26 Nov 2002 11:55:29 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I have been going through the LinuxPPC archives, looking for answers to my
problem, but still could not proceed ahead. My problem is that the Linux
will hang after the line 'execve("bin/sh", argv_init, envp_init);' inside
the init function of the file main.c. I have added the printk statements
preceding each of the execve calls. The last prink should be right before
the panic statement but it did not get executed, therefore I suspect that
the culprit is 'execve("bin/sh", argv_init, envp_init);' .
My hardware is a custom 860T cpu with 16M RAM running at 50Mhz. I have
ported PPCboot 1.2.0 on the hardware. The linux I am trying to load is the
TMQ860L from DENX's development package. The Ramdisk image I am using is
also from DENX's ftp site. From that site there are two samples of Ramdisk,
one is "simple_ramdisk", the other is "ramdisk_2048". I have tried both and
got the same result. I am sure that I must have missed something, but I do
not know what I have overlooked. Could some body please help me out on this.
Thanks.
By the way, I can see a lot of people posting questions and receiving a lot
of answers or suggestions. But I seldom see the originator of the questions
follows up with the final solution of how the problem got fixed. In this
example, I do see that I am not the first one to ask this question, but I
just cannot find the solutions from the archives.

Francis

Captured from the screen:

Hit any key to stop autoboot:  0
=> setenv bootargs root=/dev/ram
=> imi 400000 600000

## Checking Image at 00400000 ...
   Image Name:   Linux-2.4.4 Debug
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    605902 Bytes = 591.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK

## Checking Image at 00600000 ...
   Image Name:   2048K RAMdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    506801 Bytes = 494.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
=> bootm 400000 600000
## Booting image at 00400000 ...
   Image Name:   Linux-2.4.4 Debug
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    605902 Bytes = 591.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x00F9BC18 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF0D
bd address  = 0x00F9BFC4
memstart    = 0x00000000
memsize     = 0x01000000
flashstart  = 0xFFE00000
flashsize   = 0x00200000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xFA000000
bootflags   = 0x00000001
intfreq     =     50 MHz
busfreq     =     50 MHz
ethaddr     = 00:10:EC:00:1D:0B
IP addr     = 192.168.1.65
baudrate    =   9600 bps
## Loading RAMDisk Image at 00600000 ...
   Image Name:   2048K RAMdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    506801 Bytes = 494.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0x00600040 ... 0x0067BBF0 (len=506801=0x7BBB1)
   Loading Ramdisk to 00f1f000, end 00f9abb1 ... OK
## Transferring control to Linux (at address 00000000) ...
Linux version 2.4.4 (root@localhost.localdomain) (gcc version 2.95.3
20010315 (r
elease/MontaVista)) #15 Tue Nov 26 10:13:20 PST 2002
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
Decrementer Frequency: 3125000
Calibrating delay loop... 49.76 BogoMIPS
Memory: 13848k available (1168k kernel code, 508k data, 52k init, 0k
highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
ttyS1 on SMC2 at 0x0380, BRG2
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9120kB/3040kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
PCMCIA slot @: phys mem ffffffff...00000000 (size 00000001)
PCMCIA slot has not been defined! Using A as default
No card in slot A: PIPR=ff00ff00
eth0: CPM ENET Version 0.2 on SCC1, 00:10:ec:00:1d:0b
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 494k freed
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.
CFI: Found no TQM8xxL Bank 0 device at location zero
CFI: Found no TQM8xxL Bank 1 device at location zero
CFI: Found no TQM8xxL Bank 2 device at location zero
CFI: Found no TQM8xxL Bank 3 device at location zero
TQM8xxL: No support flash chips found!
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Incomplete network configuration information.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory:  52k init
 Executing command:<NULL>			; printk statements added by
me.
 /sbini/init
 /etc/init
 /bin/init
 /bin/sh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
