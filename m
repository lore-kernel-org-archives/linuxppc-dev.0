From: ghannon@cspi.com
To: "Flavio Pereira" <fpereira@azisa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256C2C.0056840D.00@pine.cspi.com>
Date: Fri, 6 Sep 2002 11:53:53 -0400
Subject: Re: Linux on 8260 using ELDK..Help?!?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Flavio,

>From your e-mail, it looks like your ramdisk is 5MB  and
you are sticking it into a 4 MB filesystem.
...
## Loading RAMDisk Image at ff800000 ...
   Image Name:   ERI 8260 Ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    5594536 Bytes = 5463 kB = 5 MB
   Load Address: 00000000
...
...
driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: FCC ENET Version 0.2, 00:00:00:40:00:01
RAMDISK: Compressed image found at block 0
...

gunzip the file and see how big it is uncompressed.

Look in the kernel config for CONFIG_BLK_DEV_RAM_SIZE and
see if it's 4096.    If so, doubling it may solve the problem.

Hope that helps.
Gary Hannon
CSPI





"Flavio Pereira" <fpereira@azisa.com> on 09/06/2002 04:45:35 AM

To:   wd@denx.de
cc:   linuxppc-embedded@lists.linuxppc.org (bcc: Gary Hannon/CSP)
Subject:  Linux on 8260 using ELDK..Help?!?





Hi Wolfgang

I got hold of a working ram disk image from Pete McCormick for the
MPC8260ADS Board and I still have the same problems with the intial
console. So this kinda proves that the problem is not with permissions
etc on my nfs system. The serial dump is shown below.

Ive also fixed up the uart.c functions that you had recommended (going
back to original code). If you can please give me some indication of
what I should be looking at. I've debugged that console register
functions and they all seem fine, the console is in CON_ENABLED state,
so I don't know what else could be wrong?

Regards
Flavio

bootm 100000 ff800000
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    458192 Bytes = 447 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ff800000 ...
   Image Name:   ERI 8260 Ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    5594536 Bytes = 5463 kB = 5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 00a09000, end 00f5eda8 ... OK
Total memory = 16MB; using 0kB for hash table (at 00000000) Linux
version 2.4.4 (root@gladiator) (gcc version 2.95.3 20010315 (release))
#14  Fri Sep 6 10:05:28 SAST 2002 On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
ip=192.168.1.246:192.168.1.58:fast::off
Warning: real time clock seems stuck!
Calibrating delay loop... 87.85 BogoMIPS
Memory: 9332k available (872k kernel code, 356k data, 52k init, 0k
highmem) Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes) Page-cache
hash table entries: 4096 (order: 2, 16384 bytes) Inode-cache hash table
entries: 1024 (order: 1, 8192 bytes) POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4 Based upon Swansea University Computer
Society NET3.039 Starting kswapd v1.8 CPM UART driver version 0.02 ttyS0
on SCC1 at 0x8000, BRG2 ttyS1 on SCC2 at 0x8100, BRG3 ttyS2 on SCC3 at
0x8200, BRG4 ttyS3 on SCC4 at 0x8300, BRG1
pty: 256 Unix98 ptys configured
block: queued sectors max/low 6101kB/2033kB, 64 slots per queue RAMDISK
driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: FCC ENET Version 0.2, 00:00:00:40:00:01
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 5463k freed
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Gateway not on directly connected network.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 52k init
Warning: unable to open an initial console.
attempt to access beyond end of device
01:00: rw=0, want=8210, limit=4096
EXT2-fs error (device ramdisk(1,0)): ext2_read_inode: unable to read
inode block
 - inode=2150, block=8209
attempt to access beyond end of device
01:00: rw=0, want=8198, limit=4096
EXT2-fs error (device ramdisk(1,0)): ext2_read_inode: unable to read
inode block
 - inode=2049, block=8197
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
