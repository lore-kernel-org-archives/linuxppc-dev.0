Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <51DB8827D393D411BB69003048003F46FDCE83@TVESNTR>
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ELDK & MPC8272ADS. Machine check
Date: Fri, 2 Jul 2004 11:28:48 +0200 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to boot the Linux kernel from ELDK 3.0 on my MPC8272ADS board.
I have u-boot 1.1.1 in the board running ok. So I had supposed that the ELDK
would have been also ported to this board. Was I wrong?

Well, what i did, was building the kernel and a ramdisk, downloading it to
RAM
and booting with "bootm" command from U-boot. The result was a Machine
Check.
(see at the end of the mail)

I've been seeking through ELDK and through uboot 1.1.1 and I have found that
the configuration for BCSR is not the same for 8260 boards:

 - uboot:  CFG_BCSR 0xF4500000
 - kernel: BCSR_ADDR 0xF8000000

Could be this the reason for the Machine Check? Is there any ELDK port to
MPC8272ADS board, or any other tree I could use?

Thanks

Alex Bastos

----------
=> setenv bootargs root=/dev/ram rw
=> bootm 200000 F00000
## Booting image at 00200000 ...
   Image Name:   Linux-2.4.24-pre2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    603174 Bytes = 589 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00f00000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1600299 Bytes =  1.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 03a01000, end 03b87b2b ... OK
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.24-pre2 (alebas@xxxxx) (gcc version 3.2.2 20030217 (Yellow
Dog Linux 34
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
Warning: real time clock seems stuck!
Calibrating delay loop... 266.24 BogoMIPS
Memory: 61752k available (1040k kernel code, 344k data, 56k init, 0k
highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG7
ttyS1 on SCC2 at 0x8100, BRG1
pty: 256 Unix98 ptys configured
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C013CC3C XER: 20000000 LR: C013CBF8 SP: C0235ED0 REGS: c0235e20 TRAP:
0200    Not td
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0234000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 900B0000 C0235ED0 C0234000 C0236400 00000000 0000000A C010F984
00000004
GPR08: 0000001E 00000080 F0010C1C F8000004 84008044 E7FFF1BB 03FFE000
007FFF10
GPR16: 00000000 00000001 007FFF00 C00A1F14 C00A1E20 C00A1784 C00A15E0
C00A1E4C
GPR24: C00A1E40 C00A1E50 00000000 C0110000 C0129C34 C0129C34 C0236400
F0011320
Call backtrace:
C013CBF8 C013C680 C013BA68 C013BAA4 C013D140 C013B338 C013363C
C0133684 C00039D0 C0008318
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
