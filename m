Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Linux on 8260 using ELDK..Help?!?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 4 Sep 2002 09:37:18 +0200
Message-ID: <1E354700654661418593A0D6B5A9D41008943B@mail.azisa.co.za>
From: "Flavio Pereira" <fpereira@azisa.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All
 
I'm a _newbie_ to Linux and am busy porting Linux to a MPC8260ADS board. PPCBoot is working fine and the Linux kernel seems to boot up okay up and till the point where it begins to load init, it then crashes. The trace is shown below. I've also tried forcing sh and bash as the start-up but these also fail with similar errors. I'm using the binaries provided by the ELDK development package. Also my changes to the base kernel code (2.4.4) are minimal and are limited to uart.c (force SCC1 as serial port) and tty_io.c (don't call rs_8xx_init). Can anyone please point me in the right direction...? If the information above is not sufficient please let me know what more I could provide. Something tries to restart the system and then it crashes on trying to reboot. Someone please tell me what I should be looking at?

 
Dump: Cut here
 
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    458345 Bytes = 447 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
 
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.4.4 (root@gladiator) (gcc version 2.95.3 20010315 (release)) #10
Tue Sep 3 09:27:13 SAST 2002
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw console=ttyS0 nfsroot=192.168.1.58:/usr/lo
cal/eldk/ppc_82xx ip=192.168.1.246:192.168.1.58
Warning: real time clock seems stuck!
Calibrating delay loop... 87.85 BogoMIPS
Memory: 14796k available (872k kernel code, 356k data, 52k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9746kB/3248kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: FCC ENET Version 0.2, 00:00:00:40:00:01
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Guessing netmask 255.255.255.0
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.1.58
Looking up port of RPC 100005/2 on 192.168.1.58
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 52k init
reeing unused kernel memory: 52k init
Freeing unused kernel memory: 52k init
Warning: unable to open an initial console.
Restarting system.
Oops: machine check, sig: 7
NIP: 40000104 XER: 20000000 LR: 40000104 SP: C0CC1D50 REGS: c0cc1ca0 TRAP: 0200
MSR: 00041000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0cc0000[64] 'reboot' Last syscall: 162
last math c0cc0000 last altivec 00000000
GPR00: 00001032 C0CC1D50 C0CC0000 0012FE08 40000104 00001002 00003860 00000000
GPR08: F0000088 C0130000 0000C000 00000088 4422404C 10019924 00000000 100D4550
GPR16: 100D4790 00000003 7FFFFD0C 00000000 00009032 00CC1E80 00000000 C0003E2C
GPR24: C0003B60 00000001 00000001 00000000 00000000 10010000 00000000 40000104
Call backtrace:
00000003 

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
