Message-ID: <B25E2E5A003CD311B61E00902778AF2A018279E0@server1.skystream.com>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Matthias Fuchs'" <matthias.fuchs@esd-electronics.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 4MB initrd crashes linux on 405 hardhat linux
Date: Thu, 4 Jan 2001 14:17:23 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew,

You might want to try this patch.  We experienced panics for ramdisks larger
than about 12MB without it.  This code was present in the 2.3.x series, but
somehow was mising from MontaVista's 2.4.0-test2.

-Brian

===================================================================
RCS file: /home/CVS/linux/fs/buffer.c,v
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 buffer.c
*** buffer.c	2000/10/17 17:47:52	1.1.1.1
--- buffer.c	2000/10/28 21:45:15
***************
*** 2338,2344 ****
  {
  	DECLARE_WAITQUEUE(wait, current);

! 	if (current == bdflush_tsk)
  		return;

  	if (!block) {
--- 2338,2344 ----
  {
  	DECLARE_WAITQUEUE(wait, current);

! 	if (bdflush_tsk == 0 || current == bdflush_tsk)
  		return;

  	if (!block) {


-----Original Message-----
From: Matthias Fuchs [mailto:matthias.fuchs@esd-electronics.com]
Sent: Thursday, January 04, 2001 10:05 AM
To: linuxppc-embedded
Subject: 4MB initrd crashes linux on 405 hardhat linux



Hello,

I want to use an initial ramdisk (4 MB) on a IBM405 board. I am using
Monta Vistas Hardhat Linux (kernel 2.4.0-test2).
I have no problems with ramdisk with up to 2MB. They are working fine !
Here are the startup messages of my kernel, when it crashes. I put some
debug messages in the source to see where it crashes. I found out that
the kernel crashes while unpacking the compressed image.

Linux version 2.4.0-test2_mvista_001126 (matthias@pc-linux-dev) (gcc
version 2.95.2 19991024 (release)) #55 Don Jan 4 18:30:
57 CET 2001
----------  progress:  0x3eab setup_arch: enter
----------  progress:  0x3eab setup_arch: bootmem


   -----  KGDB not requested  -----

----------  progress:  0x3eab arch: exit
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram console=ttyS0,115200
Calibrating delay loop... 199.88 BogoMIPS
Memory: 13440k available (1096k kernel code, 520k data, 168k init)
[c0000000,c1000000]
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
----------  progress:  0xffff
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Starting kswapd v1.6
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=xx
cpci405ide: physical address=f0100000
cpci405ide: mapped address=da000000
ide0: CPCI405 IDE interface
phy speed read failed
phy duplex read failed
<5>eth0: PPC405 EMAC 10 Mbs Half duplex MAC 00:02:27:00:00:67
do rd_image_load
do identify_ramdisk_image
RAMDISK: Compressed image found at block 0
identify_ramdisk_image done
do crd_load
do gunzip, inbuf= c0223000
flush_window ...0
copy from c0278000 to c0224000  (these are the read an write addresses
from the copy_from_user call in the ramdisk driver)
copy done
copy from c0278400 to c0224400
copy done
copy from c0278800 to c0224800
copy done
copy from c0278c00 to c0224c00
copy done
copy from c0279000 to c0276000
copy done
copy from c0279400 to c0276400
copy done
copy from c0279800 to c0276800
copy done
copy from c0279c00 to c0276c00
copy done
copy from c027a000 to c0275000
copy done
copy from c027a400 to c0275400
copy done
copy from c027a800 to c0275800
copy done
copy from c027ac00 to c0275c00
copy done
copy from c027b000 to c0274000
copy done
copy from c027b400 to c0274400
copy done
copy from c027b800 to c0274800
copy done
copy from c027bc00 to c0274c00
copy done
copy from c027c000 to c0273000
copy done
copy from c027c400 to c0273400
copy done
copy from c027c800 to c0273800
copy done
copy from c027cc00 to c0273c00
copy done
copy from c027d000 to c0272000
copy done
copy from c027d400 to c0272400
copy done
copy from c027d800 to c0272800
copy done
copy from c027dc00 to c0272c00
copy done
copy from c027e000 to c0271000
copy done
copy from c027e400 to c0271400
copy done
copy from c027e800 to c0271800
copy done
copy from c027ec00 to c0271c00
copy done
copy from c027f000 to c0270000
copy done
copy from c027f400 to c0270400
copy done
copy from c027f800 to c0270800
copy done
copy from c027fc00 to c0270c00
copy done
written !
flush_window ...8000
copy from c0278000 to c026e000
copy done
copy from c0278400 to c026e400
copy done
...
...
copy from c027f800 to c0dee800
copy done
copy from c027fc00 to c0deec00
copy done
written !
flush_window ...278000
copy from c0278000 to c0ded000
copy done
copy from c0278400 to c0ded400
copy done
copy from c0278800 to c0ded800
copy done
copy from c0278c00 to c0dedc00
copy done
copy from c0279000 to c0dec000
copy done
copy from c0279400 to c0dec400
copy done
copy from c0279800 to c0dec800
copy done
copy from c0279c00 to c0decc00
copy done
copy from c027a000 to c0deb000
copy done
copy from c027a400 to c0deb400
copy done
copy from c027a800 to c0deb800
copy done
copy from c027ac00 to c0debc00
copy done
NIP: C00153D4 XER: 20000000 LR: C00153D0 REGS: c0219270 TRAP: 1100
MSR: 00001230 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0218000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C0219320 C0218000 00000001 00009230 C0219358 C0219378
01234567
GPR08: C0218000 C0007488 00000000 C0219368 00000000 71000000 00000000
00000400
GPR16: 00000000 00003000 00005000 00000100 00001000 C027B000 000009EC
C01A0000
GPR24: 00000000 00000000 00000400 000003FF C015B3E0 C0160000 00000000
C0219320
Call backtrace:
C019AF54 C003A234 C0037870 C003790C C003E21C C0176A2C C009885C
C00992A8 C00993F0 C009947C C0099988 C0176BA4 C01764EC C01768F0
C0174DEC C0170888 C0170924 C00024F4 C0007BD8
Kernel panic: kernel access of bad area pc c00153d4 lr c00153d0 address
40 tsk swapper/1

---------------------------
What could be the problem of this crash ?

Matthias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
