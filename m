Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <tschaefer@giga-stream.de>
From: =?iso-8859-1?Q?Thomas_Sch=E4fer?= <tschaefer@giga-stream.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: JFFS2 root file system crash after garbage collection
Date: Wed, 12 May 2004 11:08:42 +0200
Message-ID: <FIEJJAKAABLMHFKFECNJIEDBHBAA.tschaefer@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We are using a PPC405GPr based custom board with MontaVista Linux 3.0
(kernel 2.4.18, jffs2 version 2.1) and 2 AM29LV641DH Flash ROM chips (8MB
size per chip). The flash chips are mapped into a contiguous address space
starting at 0xFF000000. On the mtd layer, the flash chips are concatenated
and the root file system is located on one large flash partition. The kernel
gets the partition table as command line argument.

On one of our boards, we found some jffs2 CRC warings after some weeks of
operation, probably due to a power loss during garbage collection or during
a copy command. We created an image of the root file system partition and I
started some tests with the root file system in order to find a way to get
rid of the warning messages and thus 'repair' the damaged file system.

The first idea was to force a garbage collection by consecutively copying
and deleting a large file on the root file system partition. I created a
kernel with jffs2 debug level set to 1 and copied-deleted-copied my large
test file to the flash file system. The garbage collection was started and a
lot of debug messages were printed on the screen. After a quite long time
(the board was running overnight), I got a prompt back, but the board was
almost inoberatable.

I reset the board and in the following startup sequence, the board crashed
completely when mounting the jffs2 root file system. Running ksymoops shows
the following:

Oops: kernel access of bad area, sig: 11
NIP: 8000D6AC XER: 00000000 LR: 800B9E68 SP: 80A8DCE0 REGS: 80a8dc20 TRAP:
0800    Not tainted
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = 80a8c000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 80A8DCE0 80A8C000 9FF89000 A1D69FFC 00100000 9FFE221C
F4ABC53E
GPR08: 39DFB86D 800B9E48 00000000 00000017 00800000 1004CAF0 1FFF3B00
007FFC5D
GPR16: 00000000 00000001 801B0000 9FFE42C0 80A8DD48 A0089000 9FF89000
00000001
GPR24: 9FFE4340 00100000 00000000 801B0000 9FFE437C 801B1BA0 00100000
0050ADE0
Call backtrace:
801B1BA0 800B58CC 800BA5F0 800BB4FC 8008BE10 8008B6B0 8008B024
8008DE1C 8008E544 8008990C 8003F7D4 8019D214 80002440 80002468
80004CCC
Kernel panic: Aiee, killing interrupt handler!
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; 8000d6ac <memcpy+1c/9c>   <=====
Trace; 801b1ba0 <irq_stat+0/20>
Trace; 800b58cc <cfi_amdstd_read+174/1ec>
Trace; 800ba5f0 <concat_read+c8/11c>
Trace; 800bb4fc <part_read+90/a0>
Trace; 8008be10 <jffs2_scan_inode_node+1ac/604>
Trace; 8008b6b0 <jffs2_scan_eraseblock+484/744>
Trace; 8008b024 <jffs2_scan_medium+84/28c>
Trace; 8008de1c <jffs2_build_filesystem+18/1fc>
Trace; 8008e544 <jffs2_do_mount_fs+188/1d0>
Trace; 8008990c <jffs2_read_super+e0/208>
Trace; 8003f7d4 <read_super+88/15c>
Trace; 8019d214 <mount_root+2e8/620>
Trace; 80002440 <prepare_namespace+10/20>
Trace; 80002468 <init+18/1b0>
Trace; 80004ccc <kernel_thread+30/3c>

What could be the reasons for the problem? Maybe there is an error in the
mtd_concat functions? Or maybe its because of jffs2 version 2.1 used in our
kernel?

I can also provide bootlogs, System.map, kernel configuration file and the
complete file system image of our root fs partition.

Any hints would be appreciated.

Best regards,

Thomas Schäfer

____________________________________

GIGA STREAM GmbH

Konrad-Zuse-Str. 7
66115 Saarbrücken

Tel.: + 49 (0)681 / 95916 - 203
Fax:  + 49 (0)681 / 95916 - 100
E-mail: tschaefer@giga-stream.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
