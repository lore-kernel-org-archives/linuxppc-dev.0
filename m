Return-Path: <dhuffman@storix.com>
Received: from storix.com (unknown [206.71.178.18])
	by ozlabs.org (Postfix) with ESMTP id 8CE74DDE3D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 11:03:30 +1000 (EST)
Received: from [192.168.1.125] (office [65.106.88.139])
	by storix.com (Postfix) with ESMTP id 94E3A1019
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 17:37:36 -0700 (PDT)
Message-ID: <46202254.1090606@storix.com>
Date: Fri, 13 Apr 2007 17:37:40 -0700
From: David Huffman <dhuffman@storix.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Kernel Panic booting cdrom
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I created a cdrom (using the same procedure that has been working for 
years), and received a kernel panic when booting a linux system on a 
System i p5 lpar. Here is a section of the boot messages, plus I added 
the output of .registers from OF. Anyone have an idea what could be the 
cause? This same CDROM works on a standalone System p 43p-170.

David Huffman
PPC Dev
Storix, Inc.


[boot]0015 Setup Done
Built 6 zonelists
Kernel command line: root=/dev/ram0 selinux=0 maxcpus=1 devfs=nomount 
load_ramdisk=1 ramdisk_blocksize=1024 ramdisk_size=65536 rw 
raid=noautodetect init=/linuxrc console=hvc0,9600
[boot]0020 XICS Init
xics:  no ISA Interrupt Controller
[boot]0021 XICS Done
PID hash table entries: 16 (order 4: 256 bytes)
CKRM Initialization
...... Initializing ClassType<taskclass> ........
...... Initializing ClassType<socketclass> ........
CKRM Initialization done
time_init: decrementer frequency = 275.070000 MHz
time_init: processor frequency   = 2197.800000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
freeing bootmem node 5
Memory: 2032640k available (0k kernel code, 0k data, 0k init) 
[c000000000000000,c000000080000000]
kdb version 4.4 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights 
Reserved
kdb_cmd[0]: defcmd archkdb "" "First line arch debugging"
kdb_cmd[6]: defcmd archkdbcpu "" "archkdb with only tasks on cpus"
kdb_cmd[12]: defcmd archkdbshort "" "archkdb with less detailed backtrace"
Security Scaffold v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
Partition configured for 8 cpus.
Brought up 1 CPUs
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 1773k freed
khelper: max 64 concurrent processes
resid is -1 name is io <NULL>
CKRM .. create res clsobj for resouce <io>class <taskclass> 
par=0000000000000000
NET: Registered protocol family 16
PCI: Probing PCI hardware
IOMMU table initialized, virtual merging disabled
PCI: Probing PCI hardware done
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA PSERIES LPAR
NIP: C00000000012F210 XER: 0000000020000010 LR: C000000000476024
REGS: c00000007ff5fab0 TRAP: 0380   Not tainted  (2.6.5-7.244-pseries64 
SLES9_SP3_BRANCH-200512121832250000)
MSR: 8000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000000000000010, DSISR: 0000000000200000
TASK: c00000007ff5b440[1] 'swapper' THREAD: c00000007ff5c000 CPU: 0
GPR00: C000000000476024 C00000007FF5FD30 C00000000071DCC8 C000000000723338
GPR04: C0000000028CC080 C0000000028CC088 C000000000954C98 C000000002692888
GPR08: 0000000000000002 0000000000000001 C000000000643160 0000000000000001
GPR12: 0000000024000042 C000000000491000 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000010 00000000001BB591 0000000001C00000
GPR24: C000000000491000 C00000000071D008 C00000000048B5F0 C0000000028CC080
GPR28: 0000000000000000 C000000000723338 C0000000006316D0 C0000000028CC088
NIP [c00000000012f210] .sysfs_create_link+0x30/0x134
LR [c000000000476024] .register_cpu+0xc8/0x104
Call Trace:
[c00000007ff5fd30] [c0000000002753cc] .sysdev_register+0x98/0x250 
(unreliable)
[c00000007ff5fdd0] [c000000000476024] .register_cpu+0xc8/0x104
[c00000007ff5fe70] [c0000000004621dc] .topology_init+0x1b4/0x290
[c00000007ff5ff00] [c00000000000c654] .init+0x1a0/0x360
[c00000007ff5ff90] [c000000000017d24] .kernel_thread+0x4c/0x68
 <0>Fatal exception: panic in 5 seconds
Kernel panic: Fatal exception



###############################################################
 Registers
###############################################################

0 > .registers
My Fix Pt Regs:
 00 800000000000b002 0000000000000000 00000000deadbeef 0000000000000001
 04 00000000ea28ef60 0000000000c4f0d8 0000000000000000 0000000000c03010
 08 0000000008000000 80000000001f9ca0 80000000001f9ca0 80000000001af548
 0c 0000000000004000 0000000000c17100 0000000000c18000 00000000000e86b0
 10 0000000000e262e5 0000000000e262e5 0000000000c457c0 0000000000c45848
 14 0000000000144078 0001f89aea28ef60 0000000000000000 0000000000000000
 18 0000000000c13000 0000000000c38000 0000000000c14f80 0000000000c16fc0
 1c 0000000000c20000 0000000000c3fdd0 0000000000c11fb0 0000000000c11000
Special Regs:
    %IV: 00000900     %CR: 22808000    %XER: 20000001  %DSISR: 00000000
  %SRR0: 0000000000c4580c   %SRR1: 800000000000b002
    %LR: 0000000000c46974    %CTR: 0000000000000004
   %DAR: 0000000000000000
Virtual PID = 0


I posted the entire boot message output at:

http://www.storix.com/p5panic.txt


 
