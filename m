Date: Tue, 30 Mar 2004 20:57:17 -0500
From: ERIC NORTHUP <eric.northup@jhu.edu>
Subject: 4way smp on ppc32
To: linuxppc-dev@lists.linuxppc.org
Message-id: <7eb2247ee728.7ee7287eb224@jhumail.jhu.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I have been trying to get my 4-processor Daystar GenesisMP system to run Linux in smp mode, without success.  The system works reliably with a uniprocessor kernel.  But it oopses on boot with an smp kernel.  I have attached a boot log from a serial console for a 2.6 kernel, but I get similar messages  with other kernels I've tried.  Although the log is from 2.6.4, I've tried 2.6.5-pre3 which included some ppc32 fixes, though they didn't fix this problem.  I've also tried different gcc versions.

I don't understand why only 2 of the 4 cpus would respond to the smp_call_function().  Any suggestions for where to start looking?  I am not subscribed to linuxppc-dev, so please CC me on replies.  Thanks,

--Eric
Total memory = 576MB; using 2048kB for hash table (at c0400000)
Linux version 2.6.4up (eric@debian-genesismp) (gcc version 2.95.4 20011002 (Debian prerelease)) #5 SMP Mon Mar 29 13:55:55 EST 2004
Found a Grand Central mac-io controller, rev: 2, mapped at 0xfddd4000
PowerMac motherboard: PowerMac 9500/9600
Cache coherency enabled for bandit/PSX
Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Cache coherency enabled for bandit/PSX
Found Bandit PCI host bridge at 0xf4000000. Firmware bus number: 1->1
nvram: OF partition at 0x1800
nvram: XP partition at 0x1300
nvram: NR partition at 0x1400
On node 0 totalpages: 147456
  DMA zone: 147456 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/sda5 console=ttyS0 init=/bin/bash
System has 32 possible interrupts
PID hash table entries: 4096 (order 12: 32768 bytes)
GMT Delta read from XPRAM: 0 minutes, DST: off
via_calibrate_decr: ticks per jiffy = 11249 (674990 ticks)
Console: colour dummy device 80x25
Memory: 577920k available (1980k kernel code, 1080k data, 348k init, 0k highmem)
Calibrating delay loop... 358.40 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
CPU 1 done callin...
CPU 1 done setup...
CPU 1 done timebase take...
Processor 1 found.
CPU 2 done callin...
CPU 2 done setup...
CPU 2 done timebase take...
Processor 2 found.
CPU 3 done callin...
CPU 3 done setup...
CPU 3 done timebase take...
Processor 3 found.
Brought up 4 CPUs
NET: Registered protocol family 16
PCI: Probing PCI hardware
smp_call_function on cpu 0: other cpus not responding (2)
kernel BUG in smp_call_function_all_cpus at mm/slab.c:1364!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C00405E0 LR: C00405D8 SP: C0BABED0 REGS: c0babe20 TRAP: 0700    Not tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0badb40[1] 'swapper' Last syscall: 120  CPU: 0
GPR00: C00405D8 C0BABED0 C0BADB40 FFFFFFFF 000007C3 00000000 C0290000 C0255AA4
GPR08: 000007C3 00000000 C0300000 C0255A9C 42002024 003530A4 ABB20028 46200028
GPR16: 480002BD 1AC2ABCD 73637269 00000000 C0290000 C0300000 00000000 E3FFA348
GPR24: 00000008 00000010 00000020 C0BABEFC C0BABEF8 C0042760 E3FFA300 00000000
Call trace:
 [c0042858] do_tune_cpucache+0xbc/0x290
 [c0042ae0] enable_cpucache+0xb4/0xe4
 [c004027c] kmem_cache_create+0x3e4/0x6e0
 [c02af6e8] init_bio+0x2c/0xd0
 [c029a85c] do_initcalls+0x90/0x10c
 [c029a8f8] do_basic_setup+0x20/0x30
 [c0003968] init+0x4c/0x114
 [c000afc4] kernel_thread+0x44/0x60
Kernel panic: Attempted to kill init!
 smp_call_function on cpu 0: other cpus not responding (2)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
