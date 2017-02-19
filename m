Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR7rh17PqzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 01:08:04 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vR7rg2RV7z9s8T
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 01:08:03 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JE41sq013937
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 09:08:00 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28pk54m4cd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 09:08:00 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 19:37:56 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 39A95E005A
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 19:39:29 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1JE7qP526738856
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 19:37:52 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1JE7p3n024239
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 19:37:52 +0530
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_8C27D586-733D-4903-9F4E-BABA3AD02C5D"
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: next-20170217 boot on POWER8 LPAR : WARNING @kernel/jump_label.c:287
Date: Sun, 19 Feb 2017 19:37:43 +0530
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, jbaron@akamai.com
To: linux-next@vger.kernel.org
Message-Id: <E6A8A7A8-6A55-4989-BAE9-39274876CA3C@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_8C27D586-733D-4903-9F4E-BABA3AD02C5D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

While booting next-20170217 on a POWER8 LPAR following
warning is displayed.

Reverting the following commit helps boot cleanly.
commit 3821fd35b5 :  jump_label: Reduce the size of struct static_key

[   11.393008] ------------[ cut here ]------------
[   11.393031] WARNING: CPU: 5 PID: 2890 at kernel/jump_label.c:287 =
static_key_set_entries.isra.10+0x3c/0x50
[   11.393035] Modules linked in: nfsd(+) ip_tables x_tables autofs4
[   11.393043] CPU: 5 PID: 2890 Comm: modprobe Not tainted =
4.10.0-rc8-next-20170217-autotest #1
[   11.393047] task: c0000003a5692500 task.stack: c0000003a7774000
[   11.393051] NIP: c0000000017bcffc LR: c0000000017bd46c CTR: =
0000000000000000
[   11.393054] REGS: c0000003a7777800 TRAP: 0700   Not tainted  =
(4.10.0-rc8-next-20170217-autotest)
[   11.393058] MSR: 800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
[   11.393065]   CR: 48248282  XER: 00000001
[   11.393070] CFAR: c0000000017bcfcc SOFTE: 1
GPR00: c0000000017bd42c c0000003a7777a80 c00000000262ce00 =
d000000003fdd580
GPR04: d000000003fe07df 0000000100000017 c0000000017bcd50 =
0000000000000000
GPR08: 0000000000053a09 0000000000000001 c00000000254ce00 =
0000000000000001
GPR12: c000000001b56c40 c00000000ea81400 0000000000000020 =
d000000005081098
GPR16: c0000003a7777da0 c0000003a7777dec 0000000000000000 =
00000000000084a8
GPR20: d000000003fef000 d000000003fe2b28 c00000000252dc90 =
0000000000000001
GPR24: c00000000254d314 0000000000000000 c0000000025338f8 =
d000000003fe089f
GPR28: 0000000000000000 d000000003fe1400 d000000003fdd578 =
d000000003fe07df
[   11.393115] NIP [c0000000017bcffc] =
static_key_set_entries.isra.10+0x3c/0x50
[   11.393119] LR [c0000000017bd46c] =
jump_label_module_notify+0x20c/0x420
[   11.393122] Call Trace:
[   11.393125] [c0000003a7777a80] [c0000000017bd42c] =
jump_label_module_notify+0x1cc/0x420 (unreliable)
[   11.393132] [c0000003a7777b40] [c0000000016b38e0] =
notifier_call_chain+0x90/0x100
[   11.393137] [c0000003a7777b90] [c0000000016b3db0] =
__blocking_notifier_call_chain+0x60/0x90
[   11.393142] [c0000003a7777be0] [c0000000017357bc] =
load_module+0x1c1c/0x2750
[   11.393147] [c0000003a7777d70] [c000000001736550] =
SyS_finit_module+0xc0/0xf0
[   11.393152] [c0000003a7777e30] [c0000000015cb8e0] =
system_call+0x38/0xfc
[   11.393156] Instruction dump:
[   11.393158] 40c20018 e9230000 792907a0 7c844b78 f8830000 4e800020 =
3d42fff2 892a0514
[   11.393166] 2f890000 40feffe0 39200001 992a0514 <0fe00000> 4bffffd0 =
60000000 60000000
[   11.393173] ---[ end trace a5f8fbc5d8226aec ]---

Have attached boot log.

Thanks
-Sachin=

--Apple-Mail=_8C27D586-733D-4903-9F4E-BABA3AD02C5D
Content-Disposition: attachment;
	filename=dmesg_next_20170217.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="dmesg_next_20170217.log"
Content-Transfer-Encoding: 7bit

[    0.000000] Allocated 2097152 bytes for 2048 pacas at c00000000ea80000
[    0.000000] Page sizes from device-tree:
[    0.000000] base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
[    0.000000] base_shift=12: shift=16, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=7
[    0.000000] base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56
[    0.000000] base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1
[    0.000000] base_shift=16: shift=24, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=8
[    0.000000] base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
[    0.000000] base_shift=34: shift=34, sllp=0x0120, avpnm=0x000007ff, tlbiel=0, penc=3
[    0.000000] Page orders: linear mapping = 24, virtual = 12, io = 12, vmemmap = 24
[    0.000000] Using 1TB segments
[    0.000000] Initializing hash mmu with SLB
[    0.000000] Linux version 4.10.0-rc8-next-20170217-autotest (root@alp12.pok.stglabs.ibm.com) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Sun Feb 19 05:16:03 PST 2017
[    0.000000] Found initrd at 0xc0000000027a0000:0xc000000003ac253f
[    0.000000] Using pSeries machine description
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Partition configured for 16 cpus.
[    0.000000] CPU maps initialized for 8 threads per core
[    0.000000]  (thread shift is 3)
[    0.000000] Freed 2080768 bytes for unused pacas
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    = 0x1d
[    0.000000] phys_mem_size     = 0x3c0000000
[    0.000000] dcache_bsize      = 0x80
[    0.000000] icache_bsize      = 0x80
[    0.000000] cpu_features      = 0x27fc7aec18500249
[    0.000000]   possible        = 0x7fffffff18500649
[    0.000000]   always          = 0x0000000018100040
[    0.000000] cpu_user_features = 0xdc0065c2 0xef000000
[    0.000000] mmu_features      = 0x7c004001
[    0.000000] firmware_features = 0x00000001c45ffc5f
[    0.000000] htab_hash_mask    = 0x3fffff
[    0.000000] physical_start    = 0x15c0000
[    0.000000] -----------------------------------------------------
[    0.000000] numa: Initmem setup node 0
[    0.000000] numa:   NODE_DATA [mem 0x3bff61c80-0x3bff6bfff]
[    0.000000] numa:     NODE_DATA(0) on node 1
[    0.000000] numa: Initmem setup node 1 [mem 0x00000000-0x3bfffffff]
[    0.000000] numa:   NODE_DATA [mem 0x3bff57900-0x3bff61c7f]
[    0.000000] Section 957 and 959 (node 1) have a circular dependency on usemap and pgdat allocations
[    0.000000] PPC64 nvram contains 15360 bytes
[    0.000000] Top of RAM: 0x3c0000000, Total RAM: 0x3c0000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000003bfffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   1: [mem 0x0000000000000000-0x00000003bfffffff]
[    0.000000] Could not find start_pfn for node 0
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000000000000]
[    0.000000] On node 0 totalpages: 0
[    0.000000] Initmem setup node 1 [mem 0x0000000000000000-0x00000003bfffffff]
[    0.000000] On node 1 totalpages: 3932160
[    0.000000]   DMA zone: 61440 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3932160 pages, LIFO batch:31
[    0.000000] percpu: Embedded 32 pages/cpu @c0000003bfd00000 s93736 r0 d37336 u131072
[    0.000000] pcpu-alloc: s93736 r0 d37336 u131072 alloc=1*1048576
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 3870720
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: root=/dev/mapper/rhel_alp12-root 
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 15421408K/15728640K available (10212K kernel code, 1276K rwdata, 2844K rodata, 2608K init, 1262K bss, 307232K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=16, Nodes=2
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=16
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] pic: no ISA interrupt controller
[    0.000000] time_init: decrementer frequency = 512.000000 MHz
[    0.000000] time_init: processor frequency   = 3724.000000 MHz
[    0.000003] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.000066] clocksource: timebase mult[1f40000] shift[24] registered
[    0.000106] clockevent: decrementer mult[83126e98] shift[32] cpu[1]
[    0.000206] Console: colour dummy device 80x25
[    0.000239] console [hvc0] enabled
[    0.000264] bootconsole [udbg0] disabled
[    0.000294] ------------------------
[    0.000299] | Locking API testsuite:
[    0.000303] ----------------------------------------------------------------------------
[    0.000310]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.000317]   --------------------------------------------------------------------------
[    0.000325]                      A-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000349]                  A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000372]              A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000396]              A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000419]          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000443]          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000467]          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000492]                     double unlock:  ok  |  ok  |failed|  ok  |failed|failed|
[    0.000514]                   initialize held:failed|failed|failed|failed|failed|failed|
[    0.000534]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000555]   --------------------------------------------------------------------------
[    0.000562]               recursive read-lock:             |  ok  |             |failed|
[    0.000576]            recursive read-lock #2:             |  ok  |             |failed|
[    0.000590]             mixed read-write-lock:             |failed|             |failed|
[    0.000604]             mixed write-read-lock:             |failed|             |failed|
[    0.000637]   --------------------------------------------------------------------------
[    0.000644]      hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
[    0.000659]      soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
[    0.000674]      hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
[    0.000688]      soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
[    0.000702]        sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
[    0.000715]        sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
[    0.000730]          hard-safe-A + irqs-on/12:failed|failed|  ok  |
[    0.000744]          soft-safe-A + irqs-on/12:failed|failed|  ok  |
[    0.000758]          hard-safe-A + irqs-on/21:failed|failed|  ok  |
[    0.000772]          soft-safe-A + irqs-on/21:failed|failed|  ok  |
[    0.000786]     hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
[    0.000801]     soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
[    0.000816]     hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
[    0.000831]     soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
[    0.000845]     hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
[    0.000860]     soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
[    0.000875]     hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
[    0.000890]     soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
[    0.000904]     hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
[    0.000919]     soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
[    0.000933]     hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
[    0.000948]     soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
[    0.000963]     hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
[    0.000977]     soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
[    0.000992]     hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
[    0.001007]     soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
[    0.001022]     hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
[    0.001037]     soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
[    0.001052]     hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
[    0.001067]     soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
[    0.001082]     hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
[    0.001097]     soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
[    0.001111]     hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
[    0.001127]     soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
[    0.001142]       hard-irq lock-inversion/123:failed|failed|  ok  |
[    0.001157]       soft-irq lock-inversion/123:failed|failed|  ok  |
[    0.001172]       hard-irq lock-inversion/132:failed|failed|  ok  |
[    0.001186]       soft-irq lock-inversion/132:failed|failed|  ok  |
[    0.001201]       hard-irq lock-inversion/213:failed|failed|  ok  |
[    0.001216]       soft-irq lock-inversion/213:failed|failed|  ok  |
[    0.001230]       hard-irq lock-inversion/231:failed|failed|  ok  |
[    0.001245]       soft-irq lock-inversion/231:failed|failed|  ok  |
[    0.001260]       hard-irq lock-inversion/312:failed|failed|  ok  |
[    0.001275]       soft-irq lock-inversion/312:failed|failed|  ok  |
[    0.001290]       hard-irq lock-inversion/321:failed|failed|  ok  |
[    0.001305]       soft-irq lock-inversion/321:failed|failed|  ok  |
[    0.001320]       hard-irq read-recursion/123:  ok  |
[    0.001329]       soft-irq read-recursion/123:  ok  |
[    0.001338]       hard-irq read-recursion/132:  ok  |
[    0.001347]       soft-irq read-recursion/132:  ok  |
[    0.001356]       hard-irq read-recursion/213:  ok  |
[    0.001365]       soft-irq read-recursion/213:  ok  |
[    0.001374]       hard-irq read-recursion/231:  ok  |
[    0.001383]       soft-irq read-recursion/231:  ok  |
[    0.001392]       hard-irq read-recursion/312:  ok  |
[    0.001401]       soft-irq read-recursion/312:  ok  |
[    0.001410]       hard-irq read-recursion/321:  ok  |
[    0.001419]       soft-irq read-recursion/321:  ok  |
[    0.001428]   --------------------------------------------------------------------------
[    0.001434]   | Wound/wait tests |
[    0.001439]   ---------------------
[    0.001443]                   ww api failures:  ok  |  ok  |  ok  |
[    0.001464]                ww contexts mixing:failed|  ok  |
[    0.001475]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
[    0.001492]                locking mismatches:  ok  |  ok  |  ok  |
[    0.001506]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.001548]            spinlock nest unlocked:failed|
[    0.001556]   -----------------------------------------------------
[    0.001562]                                  |block | try  |context|
[    0.001568]   -----------------------------------------------------
[    0.001574]                           context:failed|  ok  |  ok  |
[    0.001588]                               try:failed|  ok  |failed|
[    0.001602]                             block:failed|  ok  |failed|
[    0.001615]                          spinlock:failed|  ok  |failed|
[    0.001630] --------------------------------------------------------
[    0.001636] 151 out of 253 testcases failed, as expected. |
[    0.001641] ----------------------------------------------------
[    0.001671] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.001683] pid_max: default: 32768 minimum: 301
[    0.004308] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.022131] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.030824] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.030882] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.032050] EEH: pSeries platform initialized
[    0.032059] POWER8 performance monitor hardware support registered
[    0.032532] smp: Bringing up secondary CPUs ...
[    0.280439] smp: Brought up 2 nodes, 8 CPUs
[    0.280459] numa: Node 0 CPUs:
[    0.280461] numa: Node 1 CPUs: 0-7
[    0.280758] devtmpfs: initialized
[    0.289441] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.289465] kworker/u33:0 (59) used greatest stack depth: 12384 bytes left
[    0.289486] futex hash table entries: 4096 (order: 7, 524288 bytes)
[    0.289727] NET: Registered protocol family 16
[    0.289761] EEH: No capable adapters found
[    0.290047] cpuidle: using governor menu
[    0.290072] RTAS daemon started
[    0.290138] pstore: using zlib compression
[    0.290142] pstore: Registered nvram as persistent store backend
[    0.291723] PCI: Probing PCI hardware
[    0.291727] PCI: Probing PCI hardware done
[    0.291814] pseries-rng: Registering arch random hook.
[    0.295171] HugeTLB registered 64 KB page size, pre-allocated 0 pages
[    0.295177] HugeTLB registered 16 MB page size, pre-allocated 0 pages
[    0.295180] HugeTLB registered 16 GB page size, pre-allocated 0 pages
[    0.295452] vgaarb: loaded
[    0.295511] SCSI subsystem initialized
[    0.295581] libata version 3.00 loaded.
[    0.295678] usbcore: registered new interface driver usbfs
[    0.295699] usbcore: registered new interface driver hub
[    0.295747] usbcore: registered new device driver usb
[    0.295789] pps_core: LinuxPPS API ver. 1 registered
[    0.295796] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.295811] PTP clock support registered
[    0.296047] clocksource: Switched to clocksource timebase
[    0.307839] NET: Registered protocol family 2
[    0.308002] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.308459] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[    0.309020] TCP: Hash tables configured (established 131072 bind 65536)
[    0.309074] UDP hash table entries: 8192 (order: 7, 786432 bytes)
[    0.309302] UDP-Lite hash table entries: 8192 (order: 7, 786432 bytes)
[    0.309544] NET: Registered protocol family 1
[    0.309660] RPC: Registered named UNIX socket transport module.
[    0.309663] RPC: Registered udp transport module.
[    0.309665] RPC: Registered tcp transport module.
[    0.309667] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.309671] PCI: CLS 0 bytes, default 128
[    0.309709] Trying to unpack rootfs image as initramfs...
[    0.560132] Freeing initrd memory: 19592K
[    0.560913] IOMMU table initialized, virtual merging enabled
[    0.571171] hv-24x7: read 1330 catalog entries, created 337 event attrs (0 failures), 169 descs
[    0.571692] ====[ backtrace testing ]===========
[    0.571696] Testing a backtrace from process context.
[    0.571700] The following trace is a kernel self test and not a bug!
[    0.571707] CPU: 2 PID: 1 Comm: swapper/1 Not tainted 4.10.0-rc8-next-20170217-autotest #1
[    0.571711] Call Trace:
[    0.571717] [c0000003ac9ebb30] [c000000001fb0720] dump_stack+0xb0/0xf0 (unreliable)
[    0.571722] [c0000003ac9ebb70] [c00000000173b76c] backtrace_regression_test+0x5c/0x170
[    0.571726] [c0000003ac9ebc40] [c0000000015cd660] do_one_initcall+0x60/0x1c0
[    0.571731] [c0000003ac9ebd00] [c0000000022881b8] kernel_init_freeable+0x26c/0x344
[    0.571735] [c0000003ac9ebdc0] [c0000000015cdf74] kernel_init+0x24/0x150
[    0.571739] [c0000003ac9ebe30] [c0000000015cbc60] ret_from_kernel_thread+0x5c/0x7c
[    0.571742] Testing a backtrace from irq context.
[    0.571744] The following trace is a kernel self test and not a bug!
[    0.571749] CPU: 2 PID: 23 Comm: ksoftirqd/2 Not tainted 4.10.0-rc8-next-20170217-autotest #1
[    0.571752] Call Trace:
[    0.571754] [c0000003acb33b80] [c000000001fb0720] dump_stack+0xb0/0xf0 (unreliable)
[    0.571759] [c0000003acb33bc0] [c00000000173b6e8] backtrace_test_irq_callback+0x18/0x40
[    0.571762] [c0000003acb33be0] [c000000001690148] tasklet_action+0xc8/0x1b0
[    0.571766] [c0000003acb33c40] [c00000000168f344] __do_softirq+0x164/0x3d0
[    0.571769] [c0000003acb33d30] [c00000000168f5f0] run_ksoftirqd+0x40/0xc0
[    0.571773] [c0000003acb33d60] [c0000000016b70e0] smpboot_thread_fn+0x290/0x2a0
[    0.571777] [c0000003acb33dc0] [c0000000016b17ac] kthread+0x14c/0x190
[    0.571780] [c0000003acb33e30] [c0000000015cbc60] ret_from_kernel_thread+0x5c/0x7c
[    0.571787] Testing a saved backtrace.
[    0.571789] The following trace is a kernel self test and not a bug!
[    0.571793]  backtrace_regression_test+0x124/0x170
[    0.571796]  do_one_initcall+0x60/0x1c0
[    0.571799]  kernel_init_freeable+0x26c/0x344
[    0.571801]  kernel_init+0x24/0x150
[    0.571804]  ret_from_kernel_thread+0x5c/0x7c
[    0.571806] ====[ end of backtrace testing ]====
[    0.571815] audit: initializing netlink subsys (disabled)
[    0.571856] audit: type=2000 audit(1487510438.560:1): state=initialized audit_enabled=0 res=1
[    0.575125] workingset: timestamp_bits=38 max_order=22 bucket_order=0
[    0.577647] NFS: Registering the id_resolver key type
[    0.577658] Key type id_resolver registered
[    0.577661] Key type id_legacy registered
[    0.577669] SGI XFS with ACLs, security attributes, no debug enabled
[    0.578342] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.578350] io scheduler noop registered
[    0.578355] io scheduler deadline registered
[    0.578384] io scheduler cfq registered (default)
[    0.578389] io scheduler mq-deadline registered
[    0.592648] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.595321] brd: module loaded
[    0.596859] loop: module loaded
[    0.596928] ipr: IBM Power RAID SCSI Device Driver version: 2.6.3 (October 17, 2015)
[    0.597059] ibmvscsi 30000070: SRP_VERSION: 16.a
[    7.196098] ibmvscsi 30000070: SRP_VERSION: 16.a
[    7.196270] ibmvscsi 30000070: Maximum ID: 64 Maximum LUN: 32 Maximum Channel: 3
[    7.196274] scsi host0: IBM POWER Virtual SCSI Adapter 1.5.9
[    7.196425] ibmvscsi 30000070: partner initialization complete
[    7.196464] ibmvscsi 30000070: host srp version: 16.a, host partition alp18-VIOS (100), OS 3, max io 1048576
[    7.196520] ibmvscsi 30000070: Client reserve enabled
[    7.196532] ibmvscsi 30000070: sent SRP login
[    7.201569] ibmvscsi 30000070: SRP_LOGIN succeeded
[    7.226344] scsi 0:0:1:0: Direct-Access     AIX      VDASD            0001 PQ: 0 ANSI: 3
[    7.231609] scsi 0:0:2:0: CD-ROM            AIX      VOPTA                 PQ: 0 ANSI: 4
[    7.263909] random: fast init done
[    7.265371] sd 0:0:1:0: [sda] 62914560 512-byte logical blocks: (32.2 GB/30.0 GiB)
[    7.265409] sr 0:0:2:0: [sr0] scsi-1 drive
[    7.265410] sd 0:0:1:0: [sda] Write Protect is off
[    7.265412] sd 0:0:1:0: [sda] Mode Sense: 17 00 00 08
[    7.265414] cdrom: Uniform CD-ROM driver Revision: 3.20
[    7.265454] sd 0:0:1:0: [sda] Cache data unavailable
[    7.265460] sd 0:0:1:0: [sda] Assuming drive cache: write through
[    7.265572] sr 0:0:2:0: Attached scsi CD-ROM sr0
[    7.265681] sd 0:0:1:0: Attached scsi generic sg0 type 0
[    7.265728] sr 0:0:2:0: Attached scsi generic sg1 type 5
[    7.265854] libphy: Fixed MDIO Bus: probed
[    7.265874] ibmveth: IBM Power Virtual Ethernet Driver 1.06
[    7.266024] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    7.266041] e100: Copyright(c) 1999-2006 Intel Corporation
[    7.266060] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    7.266066] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    7.266082] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    7.266087] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    7.266102] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    7.266108] ehci-pci: EHCI PCI platform driver
[    7.266124] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    7.266131] ohci-pci: OHCI PCI platform driver
[    7.266196] mousedev: PS/2 mouse device common for all mice
[    7.266317] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[    7.266382] device-mapper: uevent: version 1.0.3
[    7.266453] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[    7.266587] pseries_idle_driver registered
[    7.266604] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: max_sync_size new:4096 old:0
[    7.266609] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: max_sync_sg new:510 old:0
[    7.266613] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: max_sg_len new:4080 old:0
[    7.266931] usbcore: registered new interface driver usbhid
[    7.266937] usbhid: USB HID core driver
[    7.266942] oprofile: using timer interrupt.
[    7.267036] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    7.267188] NET: Registered protocol family 17
[    7.267211] Key type dns_resolver registered
[    7.267241] Running code patching self-tests ...
[    7.269269] Running feature fixup self-tests ...
[    7.269272] Running MSI bitmap self-tests ...
[    7.269438] registered taskstats version 1
[    7.269472] console [netcon0] enabled
[    7.269475] netconsole: network logging started
[    7.269520] rtc-generic rtc-generic: setting system clock to 2017-02-19 13:20:45 UTC (1487510445)
[    7.272124]  sda: sda1 sda2 sda3
[    7.272495] sd 0:0:1:0: [sda] Attached SCSI disk
[    7.272797] Freeing unused kernel memory: 2608K
[    7.272800] This architecture does not have kernel memory protection.
[    7.275174] systemd[1]: Failed to insert module 'autofs4'
[    7.279477] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    7.279582] systemd[1]: Detected architecture ppc64-le.
[    7.279586] systemd[1]: Running in initial RAM disk.
[    7.279824] systemd[1]: Set hostname to <localhost.localdomain>.
[    7.297261] dracut-rootfs-g (1563) used greatest stack depth: 12080 bytes left
[    7.329741] systemd[1]: Reached target Timers.
[    7.329752] systemd[1]: Starting Timers.
[    7.330103] systemd[1]: Created slice Root Slice.
[    7.330111] systemd[1]: Starting Root Slice.
[    7.330311] systemd[1]: Reached target Swap.
[    7.330319] systemd[1]: Starting Swap.
[    7.342871] gzip (1583) used greatest stack depth: 11680 bytes left
[    7.625443] scsi_id (2457) used greatest stack depth: 11488 bytes left
[    8.969488] XFS (dm-1): Mounting V5 Filesystem
[    9.056680] XFS (dm-1): Starting recovery (logdev: internal)
[    9.244298] XFS (dm-1): Ending recovery (logdev: internal)
[    9.245046] mount (2793) used greatest stack depth: 10448 bytes left
[    9.592037] systemd-journald[1580]: Received SIGTERM from PID 1 (systemd).
[    9.658626] systemd: 24 output lines suppressed due to ratelimiting
[    9.985230] systemd[1]: Inserted module 'autofs4'
[   10.004289] ip_tables: (C) 2000-2006 Netfilter Core Team
[   10.004300] systemd[1]: Inserted module 'ip_tables'
[   11.062710] systemd-readahead[2878]: Failed to create fanotify object: Function not implemented
[   11.393008] ------------[ cut here ]------------
[   11.393031] WARNING: CPU: 5 PID: 2890 at kernel/jump_label.c:287 static_key_set_entries.isra.10+0x3c/0x50
[   11.393035] Modules linked in: nfsd(+) ip_tables x_tables autofs4
[   11.393043] CPU: 5 PID: 2890 Comm: modprobe Not tainted 4.10.0-rc8-next-20170217-autotest #1
[   11.393047] task: c0000003a5692500 task.stack: c0000003a7774000
[   11.393051] NIP: c0000000017bcffc LR: c0000000017bd46c CTR: 0000000000000000
[   11.393054] REGS: c0000003a7777800 TRAP: 0700   Not tainted  (4.10.0-rc8-next-20170217-autotest)
[   11.393058] MSR: 800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
[   11.393065]   CR: 48248282  XER: 00000001
[   11.393070] CFAR: c0000000017bcfcc SOFTE: 1 
GPR00: c0000000017bd42c c0000003a7777a80 c00000000262ce00 d000000003fdd580 
GPR04: d000000003fe07df 0000000100000017 c0000000017bcd50 0000000000000000 
GPR08: 0000000000053a09 0000000000000001 c00000000254ce00 0000000000000001 
GPR12: c000000001b56c40 c00000000ea81400 0000000000000020 d000000005081098 
GPR16: c0000003a7777da0 c0000003a7777dec 0000000000000000 00000000000084a8 
GPR20: d000000003fef000 d000000003fe2b28 c00000000252dc90 0000000000000001 
GPR24: c00000000254d314 0000000000000000 c0000000025338f8 d000000003fe089f 
GPR28: 0000000000000000 d000000003fe1400 d000000003fdd578 d000000003fe07df 
[   11.393115] NIP [c0000000017bcffc] static_key_set_entries.isra.10+0x3c/0x50
[   11.393119] LR [c0000000017bd46c] jump_label_module_notify+0x20c/0x420
[   11.393122] Call Trace:
[   11.393125] [c0000003a7777a80] [c0000000017bd42c] jump_label_module_notify+0x1cc/0x420 (unreliable)
[   11.393132] [c0000003a7777b40] [c0000000016b38e0] notifier_call_chain+0x90/0x100
[   11.393137] [c0000003a7777b90] [c0000000016b3db0] __blocking_notifier_call_chain+0x60/0x90
[   11.393142] [c0000003a7777be0] [c0000000017357bc] load_module+0x1c1c/0x2750
[   11.393147] [c0000003a7777d70] [c000000001736550] SyS_finit_module+0xc0/0xf0
[   11.393152] [c0000003a7777e30] [c0000000015cb8e0] system_call+0x38/0xfc
[   11.393156] Instruction dump:
[   11.393158] 40c20018 e9230000 792907a0 7c844b78 f8830000 4e800020 3d42fff2 892a0514 
[   11.393166] 2f890000 40feffe0 39200001 992a0514 <0fe00000> 4bffffd0 60000000 60000000 
[   11.393173] ---[ end trace a5f8fbc5d8226aec ]---
[   11.393501] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   11.605959] systemd-journald[2881]: Received request to flush runtime journal from PID 1
[   12.293572] pseries_rng: Registering IBM pSeries RNG driver
[   12.421674] crypto_register_alg 'aes' = 0
[   12.421771] crypto_register_alg 'cbc(aes)' = 0
[   12.421856] crypto_register_alg 'ctr(aes)' = 0
[   12.422056] crypto_register_alg 'xts(aes)' = 0
[   12.653090] ibmveth 30000002 net0: renamed from eth0
[   13.457900] XFS (sda2): Mounting V5 Filesystem
[   13.854657] Unable to find swap-space signature
[   14.303079] XFS (sda2): Starting recovery (logdev: internal)
[   14.861448] XFS (sda2): Ending recovery (logdev: internal)
[   15.231960] random: crng init done
[   16.410256] polkitd[4821]: unhandled signal 11 at 0000000000000000 nip 00003fff8e3308a4 lr 00003fff8e33087c code 30001
[   16.617885] systemd-readahe (2885) used greatest stack depth: 10320 bytes left
[   17.311086] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   17.447515] Netfilter messages via NETLINK v0.30.
[   17.494712] polkitd[4965]: unhandled signal 11 at 0000000000000000 nip 00003fff898418a4 lr 00003fff8984187c code 30001
[   38.806749] modprobe (5496) used greatest stack depth: 10224 bytes left
[   42.497511] polkitd[6584]: unhandled signal 11 at 0000000000000000 nip 00003fffa6fe38a4 lr 00003fffa6fe387c code 30001
[   68.110279] polkitd[6589]: unhandled signal 11 at 0000000000000000 nip 00003fff91a228a4 lr 00003fff91a2287c code 30001
[   71.885459] tun: Universal TUN/TAP device driver, 1.6
[   71.885482] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   72.019145] virbr0: port 1(virbr0-nic) entered blocking state
[   72.019162] virbr0: port 1(virbr0-nic) entered disabled state
[   72.019203] device virbr0-nic entered promiscuous mode
[   93.133347] polkitd[6642]: unhandled signal 11 at 0000000000000000 nip 00003fff901458a4 lr 00003fff9014587c code 30001
[  118.151747] polkitd[6646]: unhandled signal 11 at 0000000000000000 nip 00003fff7ec8c8a4 lr 00003fff7ec8c87c code 30001
[  143.169733] polkitd[6651]: unhandled signal 11 at 0000000000000000 nip 00003fff7f4158a4 lr 00003fff7f41587c code 30001
[  168.177191] polkitd[6657]: unhandled signal 11 at 0000000000000000 nip 00003fffaa1f88a4 lr 00003fffaa1f887c code 30001
[  193.185874] polkitd[6662]: unhandled signal 11 at 0000000000000000 nip 00003fffa9fbd8a4 lr 00003fffa9fbd87c code 30001
[  218.211230] polkitd[6666]: unhandled signal 11 at 0000000000000000 nip 00003fffb6fdd8a4 lr 00003fffb6fdd87c code 30001
[  243.238575] polkitd[6691]: unhandled signal 11 at 0000000000000000 nip 00003fffa11938a4 lr 00003fffa119387c code 30001

--Apple-Mail=_8C27D586-733D-4903-9F4E-BABA3AD02C5D--
