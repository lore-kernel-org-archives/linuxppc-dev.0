Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040209154344.65077.qmail@web41401.mail.yahoo.com>
Date: Mon, 9 Feb 2004 07:43:44 -0800 (PST)
From: Jeff Stevens <jsteve17@yahoo.com>
Subject: SMC1 Uart Problems on 2.4.24-pre2
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to update to kernel version 2.4.24 from
linux_2_4_devel from the denx site on my MPC855T
system.  I got everything to compile, but I am having
problems getting the console to work on SMC1 with
2.4.24 (it works fine with 2.4.4).  I get the
following error when I boot:

Bytes transferred = 606591 (9417f hex)
## Booting image at 00100000 ...
   Image Name:   linux Kernel Image 2.4.24
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    606527 Bytes = 592.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.24-pre2 (root@raptor) (gcc version
2.95.4 20010319 (prerelease
/franzo/20011204)) #17 Tue Feb 10 05:28:03 GMT-14 2004
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/nfs
rw nfsroot=192.168.123.254
:/orss/software/eldk/eldk-2.1.0/ppc_8xx
ip=192.168.123.1:192.168.123.254:192.168
.123.254:255.255.255.0:::off
Decrementer Frequency = 187500000/60
Calibrating delay loop... 49.76 BogoMIPS
Memory: 30820k available (1140k kernel code, 352k
data, 60k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768
bytes)
Inode cache hash table entries: 2048 (order: 2, 16384
bytes)
Mount cache hash table entries: 512 (order: 0, 4096
bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 8192 (order: 3, 32768
bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch
(rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
CPM UART driver version 0.04
ttyS0 at 0x0280 is on SMC1 using BRpty: 256 Unix98
ptys configured
Serial driver version 5.05c (2001-07-08) with no
serial options enabled
Oops: kernel access of bad area, sig: 11
NIP: C00AC9C0 XER: C000297F LR: C00B10C4 SP: C1FF7E80
REGS: c1ff7dd0 TRAP: 0300
   Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000003F9, DSISR: 00018469
TASK = c1ff6000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C1FF7E80 C1FF6000 C1FF7E88 00000001
00000000 C01F83D8 000003F8
GPR08: 00000000 000003F8 00000000 00000000 53BC5653
100218C8 C00B0718 C00AFF60
GPR16: C00AEAA8 C00AF774 C00B0080 C00ACB64 C00ACAD8
C00AFBEC C00AEB78 C00AEAF0
GPR24: C00AF7FC C00AEA28 C00AEA10 C0147D48 C0147D48
C0173530 C01735F4 C1FF7E88
Call backtrace:
C00118C8 C0157F1C C01505CC C0150614 C00022C4 C0006D40
Kernel panic: Attempted to kill init!



Here is UART initialization from my good kernel
(2.4.4):

CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
pty: 256 Unix98 ptys configured
block: queued sectors max/low 20202kB/6734kB, 64 slots
per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize


Here are some snippets from my .config file:

#
# MPC8xx Options
#
# CONFIG_8xx_COPYBACK is not set
# CONFIG_8xx_CPU6 is not set
CONFIG_UCODE_PATCH=y
# CONFIG_MPC850_UCODE_PATCH is not set
# CONFIG_CPM_TRACK_LOAD is not set
# CONFIG_SCC_ENET is not set
# CONFIG_SCC1_ENET is not set
# CONFIG_SCC2_ENET is not set
# CONFIG_SCC3_ENET is not set
CONFIG_FEC_ENET=y
# CONFIG_USE_MDIO is not set
# CONFIG_ENET_BIG_BUFFERS is not set
CONFIG_SMC1_UART=y
CONFIG_SMC1_UART_RX_BDNUM=4
CONFIG_SMC1_UART_RX_BDSIZE=32
CONFIG_SMC1_UART_TX_BDNUM=4
CONFIG_SMC1_UART_TX_BDSIZE=32
# CONFIG_SMC2_UART is not set
# CONFIG_USE_SCC_IO is not set

#
# Character devices
#
# CONFIG_VT is not set
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256


Am I configuring something wrong?

Thanks in advance,
   Jeff Stevens


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
