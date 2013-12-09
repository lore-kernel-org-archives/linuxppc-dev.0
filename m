Return-Path: <curieux.khetan@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 266692C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 19:44:15 +1100 (EST)
Received: by mail-pd0-f173.google.com with SMTP id p10so4805864pdj.18
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Dec 2013 00:44:13 -0800 (PST)
Received: from [192.168.1.17] ([122.169.140.89])
 by mx.google.com with ESMTPSA id z10sm22705339pas.6.2013.12.09.00.44.11
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 09 Dec 2013 00:44:12 -0800 (PST)
Message-ID: <52A582D5.6020205@gmail.com>
Date: Mon, 09 Dec 2013 14:14:05 +0530
From: Ashish <curieux.khetan@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC8641 BASED Custom designed Board Linux  stucks after Mounting
 cache hash table entries
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hii All,
   I am trying to port linux 2.6.34 to mpc8641d based custom designed 
board but I am facing kernel oops after mounting hash table entries. can 
anybody was facing this kind of issue while porting or can give me some 
light on this. Any pointer/direction will be very helpfull. Here I am 
showing the snapshot of the problem for more understanding this issue..

bootm 1600000 600000 1400000
## Booting kernel from Legacy Image at 01600000 ...
    Image Name:   Linux-2.6.34
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    2615699 Bytes = 2.5 MiB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 00600000 ...
    Image Name:   rootfs
    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
    Data Size:    8043648 Bytes = 7.7 MiB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
## Flattened Device Tree blob at 01400000
    Booting using the fdt blob at 0x01400000
    Uncompressing Kernel Image ... OK
    Loading Ramdisk to 1f6fb000, end 1fea6c80 ... OK
    Loading Device Tree to 007fb000, end 007ff919 ... OK
Using MPC86xx HPCN machine description
Total memory = 512MB; using 1024kB for hash table (at cff00000)
Linux version 2.6.34 (ashish@ashish-virtual-machine) (gcc version 4.7.2 
(GCC) ) #1 Fri Dec 6 10:38:44 IST 2013
Found initrd at 0xdf6fb000:0xdfea6c80
bootconsole [udbg0] enabled
setup_arch: bootmem
mpc86xx_hpcn_setup_arch()
MPC86xx HPCN board from Freescale Semiconductor
arch: exit
Zone PFN ranges:
   DMA      0x00000000 -> 0x00020000
   Normal   empty
   HighMem  empty

Movable zone start PFN for each node
early_node_map[1] active PFN ranges
     0: 0x00000000 -> 0x00020000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: mem=512m root=/dev/ram console=ttyS0,115200
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 505540k/524288k available (4976k kernel code, 18748k reserved, 
196k data, 160k bss, 192k init)
Kernel virtual memory layout:
   * 0xfffd0000..0xfffff000  : fixmap
   * 0xff800000..0xffc00000  : highmem PTEs
   * 0xff7fe000..0xff800000  : early ioremap
   * 0xe1000000..0xff7fe000  : vmalloc & ioremap
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:512 nr_irqs:512
mpic: Setting up MPIC " MPIC     " version 1.2 at f8040000, max 2 CPUs
mpic: ISU size: 256, shift: 8, mask: ff
mpic: Initializing for 256 sources
clocksource: timebase mult[2000000] shift[22] registered
Console: colour dummy device 80x25
Mount-cache hash table entries: 512
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc00179c8
Oops: Kernel access of bad area, sig: 11 [#1]
MPC86xx HPCN
last sysfs file:
Modules linked in:
NIP: c00179c8 LR: c00d69ec CTR: 00000008
REGS: c0507e40 TRAP: 0300   Not tainted  (2.6.34)
MSR: 00009032 <EE,ME,IR,DR>  CR: 84000028  XER: 00000000
DAR: 00000000, DSISR: 40000000
TASK = c04de410[0] 'swapper' THREAD: c0506000
GPR00: c00d6da0 c0507ef0 c04de410 00000064 ffffffff df01d0e0 00000000 
00000000
GPR08: 00000000 0000000d 00000000 c0503194 44000022 f8afffff ffffffff 
200c9000
GPR16: fbbfdffb 00000000 00000000 00000024 00000000 1fea8b08 1fea8d24 
00000000
GPR24: 00000000 1fffa2e4 40000000 1ffcd66c dfffed30 00000000 00000000 
df01d080
NIP [c00179c8] strcmp+0x10/0x24
LR [c00d69ec] duplicate_name+0x3c/0x74
Call Trace:
[c0507ef0] [c07fc440] 0xc07fc440 (unreliable)
[c0507f00] [c00d6da0] proc_device_tree_add_node+0xfc/0x144
[c0507f20] [c00d6ce4] proc_device_tree_add_node+0x40/0x144
[c0507f40] [c00d6ce4] proc_device_tree_add_node+0x40/0x144
[c0507f60] [c00d6ce4] proc_device_tree_add_node+0x40/0x144
[c0507f80] [c00d6ce4] proc_device_tree_add_node+0x40/0x144
[c0507fa0] [c04bdcd4] proc_device_tree_init+0x68/0x94
[c0507fb0] [c04bd6f8] proc_root_init+0xd0/0x108
[c0507fc0] [c04ac728] start_kernel+0x2b4/0x2cc
[c0507ff0] [00003444] 0x3444
Instruction dump:
2c000000 4082fff8 38a5ffff 8c040001 2c000000 9c050001 4082fff4 4e800020
38a3ffff 3884ffff 8c650001 2c830000 <8c040001> 7c601851 4d860020 4182ffec
---[ end trace 31fd0ba7d8756001 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 180 seconds..



Regards
Ashish Kumar Khetan
