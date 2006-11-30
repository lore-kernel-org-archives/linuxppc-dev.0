Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15]) by ozlabs.org (Postfix) with ESMTP id 2B40E679FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Nov 2006 23:26:30 +1100 (EST)
Message-ID: <456ECDE9.2060506@computing.dundee.ac.uk>
Date: Thu, 30 Nov 2006 12:26:17 +0000
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Kernel Panic During Linux Boot on ML405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to make an uber-simple system on an ML405 board.  I used the 
BSB to create a straight forward system with a PPC, DDR RAM, 
opb_ethernet, a uartlite, and pretty much nothing else.  The BSB threw 
in an interrupt controller, some DCMs and some bridges for me.  That's 
all I have hardware-wise.  I compiled a 2.4.26 kernel because I've had 
one working already on the default hardware setup.  I chose what I think 
is the right options for the kernel, I've cut pretty much everything out 
that I don't need.  The BSP the EDK generated was *extremely* lacking.  
It only generated an xparameters_ml300.h (no other files) which was 
missing all the redefines.  I added these in myself by hand (this may be 
the cause of my woes).  A boot log is given below.  I would appreciate 
any tips that anyone can give me.  Where should I start looking?

Thanks in advance,
-- Peter

loaded at:     00400000 004881E0
board data at: 00485138 00485150
relocated to:  0040530C 00405324
zimage at:     00405811 00484D8F
avail ram:     00489000 04000000

Linux/PPC load: console=ttl0 root=/dev/xsysace/disc0/part2 rw ip=off
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.26 (gcc version 3.4.1) #1 Thu Nov 30 11:41:42 GMT 2006
Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. 
(source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttl0 root=/dev/xsysace/disc0/part2 rw ip=off
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
Calibrating delay loop... 299.82 BogoMIPS
Memory: 63528k available (936k kernel code, 248k data, 48k init, 0k highmem)
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
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Partition check:
 xsysacea: p1 p2 p3 p4
System ACE at 0x41800000 mapped to 0xC5000000, irq=29, 1000440KB
eth0: Scatter gather not supported yet.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 48k init
Oops: kernel access of bad area, sig: 11
NIP: 00000000 XER: A0000076 LR: C0065CE4 SP: C3FE1C70 REGS: c3fe1bc0 
TRAP: 0400    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c3fe0000[1] 'swapper' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000048 C3FE1C70 C3FE0000 C3FB9D80 0000E58A C01FB6B0 00000000 
C3FB9BA8
GPR08: C0120000 00000000 C3FB9D88 C00FF1E8 95000095 FFFFFFFF FFFFFFFF 
FFFFFFFF
GPR16: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF 00009032 03FE1F10 00000000 
C00038C8
GPR24: C0003620 00000002 00000004 C3FE1CD0 C3F6E440 C3FBE800 C3FB9D80 
C3FE9720
Call backtrace:
C0065C78 C0043AB0 C0044174 C0044B5C C0041100 C0041DB0 C00067A0
C000367C C00024B4 C0005E94
Kernel panic: Attempted to kill init!
Oops: kernel access of bad area, sig: 11
NIP: C0050940 XER: A0000076 LR: C00393AC SP: C3FE1980 REGS: c3fe18d0 
TRAP: 0800    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DEAR: 00000000, ESR: 00000000
TASK = c3fe0000[1] 'swapper' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: C3FBE864 C3FE1980 C3FE0000 00000000 00000002 00000000 00000008 
00000001
GPR08: C0104758 C3FBE85C 00000000 C3FBE864 59009035 FFFFFFFF FFFFFFFF 
FFFFFFFF
GPR16: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF 00009032 03FE1BB0 00000000 
C00038C8
GPR24: 00000000 0000000B 00030001 C0110000 C0104758 C0100000 C00EDA48 
00000000
Call backtrace:
C003922C C00393AC C00393E8 C00138B8 C0015968 C0003A6C C000DD54
C000DF64 C00038C8 C0065C78 C0043AB0 C0044174 C0044B5C C0041100
C0041DB0 C00067A0 C000367C C00024B4 C0005E94
Kernel panic: Attempted to kill init!
Oops: kernel access of bad area, sig: 11
<repeat ad inifitum...>
