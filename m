Return-Path: <neerajg@cdac.in>
Received: from mx2.cdac.in (mx1.cdac.in [203.199.132.35])
	by ozlabs.org (Postfix) with ESMTP id 828EDDE006
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jul 2008 22:03:08 +1000 (EST)
Received: from mailhub.cdac.in (mailhub [196.1.109.254])by mailhub.cdac.in
	(8.13.4/8.13.4) with ESMTP id m694pg3u020038for
	<linuxppc-embedded@ozlabs.org>; Wed, 9 Jul 2008 10:21:42 +0530
Received: from neerajg-w2p.htdg.cdac.in (neerajg-w2p.htdg.cdac.in
	[192.168.5.147])by mailhub.cdac.in (8.13.4/8.13.4) with ESMTP id
	m694pfIJ020033for <linuxppc-embedded@ozlabs.org>;
	Wed, 9 Jul 2008 10:21:42 +0530
Message-ID: <48744475.2080605@cdac.in>
Date: Wed, 09 Jul 2008 10:24:13 +0530
From: neeraj garg <neerajg@cdac.in>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Booting ML405 (Kernel panic - not syncing: No init found)
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to boot ML405 with Linux source code downloaded from 
http://www.git.xilinx.com . My cross compiler tool chain version is 
gcc-3.4.1, glibc-2.3.2 and binutils-2.15. I have also downloaded RAMDISK 
from same url (http://www.git.xilinx.com). When I download 
zImage.initrd.elf using XMD everything goes fine, untill RAMDISK is 
uncompressed, I get following messages :


loaded at:     00400000 008E519C
board data at: 008E3120 008E319C
relocated to:  00404074 004040F0
zimage at:     00404E65 00517841
initrd at:     00518000 008E2B4A
avail ram:     008E6000 02000000   //there is restriction to use 32 MB 
of memory

some of the initial messages, and then

[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     8192
[    0.000000]   Normal       8192 ->     8192
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->     8192
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 8128
[    0.000000] Kernel command line: console=ttyUL0,19200 ip=off 
root=/dev/ram rw init=/sbin/init
[    0.000000] Xilinx INTC #0 at 0x1E000000 mapped to 0xFDFFF000
[    0.000000] PID hash table entries: 128 (order: 7, 512 bytes)
[    0.000116] Console: colour dummy device 80x25
[    0.000285] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000506] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.004931] Memory: 26168k available (1740k kernel code, 576k data, 
104k init, 0k highmem)
[    0.096364] Mount-cache hash table entries: 512

few more messages, and then

[    2.218059] RAMDISK: Compressed image found at block 0
[    3.708864] VFS: Mounted root (ext2 filesystem).
[    3.716225] Freeing unused kernel memory
                                           [    3.736691] Failed to 
execute /sbin/init.  Attempting defaults...
[    3.748073] Kernel panic - not syncing: No init found.  Try passing 
init= option to kernel.
[    3.772040] Rebooting in 180 seconds..[  183.487314]   Signal: 8


[  183.487322]   Code:   0
[  183.487329]   Addr:   c0010540
[  183.488000] Oops: Exception in kernel mode, sig: 8 [#1]
[  183.488000] NIP: c0010540 LR: 00029030 CTR: c0246cec
[  183.488000] REGS: c1c17dd0 TRAP: 2007e90   Not tainted  (2.6.25-xlnx)
[  183.488000] MSR: 00000000 <>  CR: c022e764  XER: c024c0e8
[  183.488000] TASK = c1c14850[1] 'init' THREAD: c1c16000
[  183.488000] GPR00: 00000000 00000000 c0240000 c0246cec 00000000 
00000000 c0240000 c0246cec
[  183.488000] GPR08: c0250000 0002bf20 c022e764 c0250000 c1c17e80 
c0018e44 c1c14850 00000000
[  183.488000] GPR16: 0000002a b8a199a2 0000002a b87fa729 c000bc58 
b8a199a2 b873dc16 0000002a
[  183.488000] GPR24: b87fa729 c0018e44 c022e764 000000b4 c1c17e70 
00029030 00000000 00000000
[  183.488000] NIP [c0010540] cpu_clock+0x44/0x6c
[  183.488000] LR [00029030] 0x29030
[  183.488000] Call Trace:
[  183.488000] [c1c17ca0] [c0008ad8] show_stack+0x58/0x180 (unreliable)
[  183.488000] [c1c17cd0] [c0008dec] show_regs+0x1e0/0x2cc
[  183.488000] [c1c17d00] [c00031d0] die+0x6c/0x88
[  183.488000] [c1c17d20] [c000323c] _exception+0x50/0xe0
[  183.488000] [c1c17dc0] [c0002d90] ret_from_except_full+0x0/0x4c
[  183.488000] Instruction dump:
[  183.488000] XXXXXXXX XXXXXXXX XXXXXXXX 38800000 XXXXXXXX XXXXXXXX 
XXXXXXXX 7c000124
[  183.488000] XXXXXXXX XXXXXXXX XXXXXXXX 4bfffef1 XXXXXXXX XXXXXXXX 
XXXXXXXX 7d234b78
[  183.488000] Kernel panic - not syncing: Attempted to kill init!
       

--I was doubtful  about busybox version used in RAMDISK provided at git 
site. So I compiled my own busybox-1.10.3 with my cross compiler tool 
chain still I am facing the same problem. Can anybody guide me.

-- 
-----------------------------------------------------
Neeraj Garg
