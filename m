Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWxQc5phBzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 20:35:36 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vWxQb33yLz9s9x
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 20:35:35 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1R9YeNm034113
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 04:35:32 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28uqvmcqh4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 04:35:32 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Mon, 27 Feb 2017 15:05:28 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 21B3DE0045
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 15:07:10 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1R9ZNbE8323134
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 15:05:23 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1R9ZQw3020354
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2017 15:05:26 +0530
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_21CF2E20-6787-4665-BFA0-CCBAA7549C93"
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: [next 20170227] CPU remove DLPAR operation WARN @ lib/refcount.c:128
Date: Mon, 27 Feb 2017 15:05:25 +0530
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-Id: <6EF2976F-D000-47E9-851F-D13190492303@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_21CF2E20-6787-4665-BFA0-CCBAA7549C93
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

With Feb 27 next tree I am seeing inconsistent results on a CPU remove
DLPAR operation on a POWER8 LPAR.

After the cpu remove operation the SMT capability of the LPAR is =
disabled.=20

# uname -r
4.10.0-next-20170227
# ppc64_cpu --smt
SMT=3D8
# lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    8
Core(s) per socket:    1
Socket(s):             2
NUMA node(s):          4
Model:                 2.1 (pvr 004b 0201)
Model name:            POWER8 (architected), altivec supported
L1d cache:             64K
L1i cache:             32K
L2 cache:              512K
L3 cache:              8192K
NUMA node0 CPU(s):    =20
NUMA node1 CPU(s):     0-7
NUMA node3 CPU(s):    =20
NUMA node4 CPU(s):     8-15

After a DLPAR operation (CPU remove : 2 to 1) all the cpu seems to be
removed. at the end of it I also see a warning @lib/refcount.c:128
SMT capability is show as disabled. It should have remained at 8.

# ppc64_cpu =E2=80=94smt
Machine is not SMT capable
lscpu o/p shows 8  online cpus, with threads per core as 8.

[root@alp12 ~]# lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                8
On-line CPU(s) list:   8-15
Thread(s) per core:    8
Core(s) per socket:    1
Socket(s):             1
NUMA node(s):          4
Model:                 2.1 (pvr 004b 0201)
Model name:            POWER8 (architected), altivec supported
L1d cache:             64K
L1i cache:             32K
NUMA node0 CPU(s):    =20
NUMA node1 CPU(s):    =20
NUMA node3 CPU(s):    =20
NUMA node4 CPU(s):     8-15
[root@alp12 ~]

[  196.910677] cpu 8 (hwid 8) Ready to die...
[  197.120324] cpu 9 (hwid 9) Ready to die...
[  197.290265] cpu 10 (hwid 10) Ready to die...
[  197.490234] cpu 11 (hwid 11) Ready to die...
[  197.630110] cpu 12 (hwid 12) Ready to die...
[  197.790094] cpu 13 (hwid 13) Ready to die...
[  197.980016] cpu 14 (hwid 14) Ready to die...
[  198.098137] cpu 15 (hwid 15) Ready to die...
[  198.210074] pseries-hotplug-cpu: Failed to release drc (10000008) for =
CPU PowerPC,POWER8, rc: -17
[  199.050648] cpu 0 (hwid 0) Ready to die...
[  199.220530] cpu 1 (hwid 1) Ready to die...
[  199.370459] cpu 2 (hwid 2) Ready to die...
[  199.600322] cpu 3 (hwid 3) Ready to die...
[  199.770259] cpu 4 (hwid 4) Ready to die...
[  199.960189] cpu 5 (hwid 5) Ready to die...
[  200.140145] cpu 6 (hwid 6) Ready to die...
[  200.258067] cpu 7 (hwid 7) Ready to die...
[  200.360320] refcount_t: underflow; use-after-free.
[  200.360371] ------------[ cut here ]------------
[  200.360385] WARNING: CPU: 10 PID: 7194 at lib/refcount.c:128 =
refcount_sub_and_test+0xb8/0xf0
[  200.360398] Modules linked in: iptable_mangle ipt_MASQUERADE =
nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 =
nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 =
xt_tcpudp rpadlpar_io rpaphp tun bridge stp llc kvm iptable_filter =
vmx_crypto pseries_rng rng_core binfmt_misc nfsd ip_tables x_tables =
autofs4
[  200.360472] CPU: 10 PID: 7194 Comm: drmgr Tainted: G        W       =
4.10.0-next-20170227 #3
[  200.360478] task: c0000008b7222b00 task.stack: c0000008b72dc000
[  200.360483] NIP: c000000001b6b4b8 LR: c000000001b6b4b4 CTR: =
c000000001cefb50
[  200.360488] REGS: c0000008b72df860 TRAP: 0700   Tainted: G        W   =
     (4.10.0-next-20170227)
[  200.360494] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
[  200.360506]   CR: 22000422  XER: 00000007
[  200.360511] CFAR: c000000001faf738 SOFTE: 1=20
[  200.360511] GPR00: c000000001b6b4b4 c0000008b72dfae0 c00000000266c300 =
0000000000000026=20
[  200.360511] GPR04: c00000050fd8adb0 c00000050fda1660 0000000000419000 =
000000000000ff00=20
[  200.360511] GPR08: 0000000000000000 c00000000235143c 000000050da40000 =
00000000000001d7=20
[  200.360511] GPR12: 0000000000000000 c00000000ea82800 0000000000000000 =
0000000000000000=20
[  200.360511] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[  200.360511] GPR20: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[  200.360511] GPR24: 0000000000000000 0000000010018430 c0000005dd05f520 =
c0000008b72dfe00=20
[  200.360511] GPR28: 0000000000000000 0000000000000016 0000000000000000 =
c0000008b71ffa18=20
[  200.360570] NIP [c000000001b6b4b8] refcount_sub_and_test+0xb8/0xf0
[  200.360575] LR [c000000001b6b4b4] refcount_sub_and_test+0xb4/0xf0
[  200.360578] Call Trace:
[  200.360582] [c0000008b72dfae0] [c000000001b6b4b4] =
refcount_sub_and_test+0xb4/0xf0 (unreliable)
[  200.360588] [c0000008b72dfb40] [c000000001b4b0dc] =
kobject_put+0x3c/0xa0
[  200.360595] [c0000008b72dfbb0] [c000000001e53bf4] =
of_node_put+0x24/0x40
[  200.360602] [c0000008b72dfbd0] [c00000000165b4f4] =
dlpar_cpu_release+0x74/0xf0
[  200.360608] [c0000008b72dfc20] [c0000000015e0e28] =
arch_cpu_release+0x38/0x70
[  200.360615] [c0000008b72dfc40] [c000000001c49eb0] =
cpu_release_store+0x40/0x70
[  200.360622] [c0000008b72dfc70] [c000000001c3d994] =
dev_attr_store+0x34/0x60
[  200.360629] [c0000008b72dfc90] [c00000000191bc44] =
sysfs_kf_write+0x64/0xa0
[  200.360634] [c0000008b72dfcb0] [c00000000191aa80] =
kernfs_fop_write+0x170/0x250
[  200.360641] [c0000008b72dfd00] [c00000000187c330] =
__vfs_write+0x40/0x1c0
[  200.360645] [c0000008b72dfd90] [c00000000187dc48] =
vfs_write+0xc8/0x240
[  200.360650] [c0000008b72dfde0] [c00000000187f8b0] =
SyS_write+0x60/0x110
[  200.360656] [c0000008b72dfe30] [c0000000015cb8e0] =
system_call+0x38/0xfc
[  200.360660] Instruction dump:
[  200.360663] 7d495378 419e0044 2f89ffff 7d434850 7f0a4840 79460020 =
41de001c 4099ffbc=20
[  200.360675] 3c62ffb6 38636af8 48444249 60000000 <0fe00000> 38210060 =
38600000 e8010010=20
[  200.360686] ---[ end trace 937482186422ac36 ]---

I have attached the dmesg log.

Thanks
-Sachin


=20=

--Apple-Mail=_21CF2E20-6787-4665-BFA0-CCBAA7549C93
Content-Disposition: attachment;
	filename=cpu-dlpar-dmesg.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="cpu-dlpar-dmesg.log"
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
[    0.000000] Page orders: linear mapping = 24, virtual = 16, io = 16, vmemmap = 24
[    0.000000] Using 1TB segments
[    0.000000] Initializing hash mmu with SLB
[    0.000000] Linux version 4.10.0-next-20170227 (root@alp12.pok.stglabs.ibm.com) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #3 SMP Mon Feb 27 01:02:42 PST 2017
[    0.000000] Found initrd at 0xc000000002830000:0xc000000003b48a96
[    0.000000] Using pSeries machine description
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Partition configured for 16 cpus.
[    0.000000] CPU maps initialized for 8 threads per core
[    0.000000]  (thread shift is 3)
[    0.000000] Freed 2031616 bytes for unused pacas
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    = 0x1d
[    0.000000] phys_mem_size     = 0x8c0000000
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
[    0.000000] numa: Initmem setup node 0 [mem 0x3c0000000-0x50fffffff]
[    0.000000] numa:   NODE_DATA [mem 0x50fff6280-0x50fffffff]
[    0.000000] numa: Initmem setup node 1 [mem 0x00000000-0x5dfffffff]
[    0.000000] numa:   NODE_DATA [mem 0x5dfff6280-0x5dfffffff]
[    0.000000] numa: Initmem setup node 3 [mem 0x5e0000000-0x69fffffff]
[    0.000000] numa:   NODE_DATA [mem 0x69fff6280-0x69fffffff]
[    0.000000] numa: Initmem setup node 4 [mem 0x6a0000000-0x8bfffffff]
[    0.000000] numa:   NODE_DATA [mem 0x8bff5e280-0x8bff67fff]
[    0.000000] PPC64 nvram contains 15360 bytes
[    0.000000] Top of RAM: 0x8c0000000, Total RAM: 0x8c0000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000008bfffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   1: [mem 0x0000000000000000-0x00000003bfffffff]
[    0.000000]   node   0: [mem 0x00000003c0000000-0x000000050fffffff]
[    0.000000]   node   1: [mem 0x0000000510000000-0x00000005dfffffff]
[    0.000000]   node   3: [mem 0x00000005e0000000-0x000000069fffffff]
[    0.000000]   node   4: [mem 0x00000006a0000000-0x00000008bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000003c0000000-0x000000050fffffff]
[    0.000000] On node 0 totalpages: 86016
[    0.000000]   DMA zone: 84 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 86016 pages, LIFO batch:1
[    0.000000] Initmem setup node 1 [mem 0x0000000000000000-0x00000005dfffffff]
[    0.000000] On node 1 totalpages: 299008
[    0.000000]   DMA zone: 292 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 299008 pages, LIFO batch:1
[    0.000000] Initmem setup node 3 [mem 0x00000005e0000000-0x000000069fffffff]
[    0.000000] On node 3 totalpages: 49152
[    0.000000]   DMA zone: 48 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 49152 pages, LIFO batch:1
[    0.000000] Initmem setup node 4 [mem 0x00000006a0000000-0x00000008bfffffff]
[    0.000000] On node 4 totalpages: 139264
[    0.000000]   DMA zone: 136 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 139264 pages, LIFO batch:1
[    0.000000] percpu: Embedded 3 pages/cpu @c00000050fb00000 s155048 r0 d41560 u262144
[    0.000000] pcpu-alloc: s155048 r0 d41560 u262144 alloc=1*1048576
[    0.000000] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.000000] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.000000] Built 4 zonelists in Node order, mobility grouping on.  Total pages: 572880
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: root=/dev/mapper/rhel_alp12-root 
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] Memory: 36587520K/36700160K available (10240K kernel code, 1408K rwdata, 2844K rodata, 2816K init, 1409K bss, 112640K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=16, Nodes=5
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
[    0.000105] clockevent: decrementer mult[83126e98] shift[32] cpu[1]
[    0.000287] Console: colour dummy device 80x25
[    0.000319] console [hvc0] enabled
[    0.000343] bootconsole [udbg0] disabled
[    0.000372] ------------------------
[    0.000377] | Locking API testsuite:
[    0.000381] ----------------------------------------------------------------------------
[    0.000387]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.000394]   --------------------------------------------------------------------------
[    0.000402]                      A-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000424]                  A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000447]              A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000470]              A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000493]          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000517]          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000540]          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
[    0.000564]                     double unlock:  ok  |  ok  |failed|  ok  |failed|failed|
[    0.000585]                   initialize held:failed|failed|failed|failed|failed|failed|
[    0.000605]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000625]   --------------------------------------------------------------------------
[    0.000632]               recursive read-lock:             |  ok  |             |failed|
[    0.000645]            recursive read-lock #2:             |  ok  |             |failed|
[    0.000659]             mixed read-write-lock:             |failed|             |failed|
[    0.000672]             mixed write-read-lock:             |failed|             |failed|
[    0.000686]   --------------------------------------------------------------------------
[    0.000692]      hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
[    0.000707]      soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
[    0.000722]      hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
[    0.000736]      soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
[    0.000750]        sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
[    0.000764]        sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
[    0.000778]          hard-safe-A + irqs-on/12:failed|failed|  ok  |
[    0.000792]          soft-safe-A + irqs-on/12:failed|failed|  ok  |
[    0.000807]          hard-safe-A + irqs-on/21:failed|failed|  ok  |
[    0.000821]          soft-safe-A + irqs-on/21:failed|failed|  ok  |
[    0.000840]     hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
[    0.000855]     soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
[    0.000869]     hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
[    0.000884]     soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
[    0.000898]     hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
[    0.000913]     soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
[    0.000928]     hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
[    0.000942]     soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
[    0.000957]     hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
[    0.000971]     soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
[    0.000985]     hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
[    0.001013]     hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
[    0.001028]     soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
[    0.001043]     hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
[    0.001058]     soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
[    0.001072]     hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
[    0.001087]     soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
[    0.001101]     hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
[    0.001116]     soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
[    0.001130]     hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
[    0.001145]     soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
[    0.001159]     hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
[    0.001173]     soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
[    0.001187]       hard-irq lock-inversion/123:failed|failed|  ok  |
[    0.001202]       soft-irq lock-inversion/123:failed|failed|  ok  |
[    0.001216]       hard-irq lock-inversion/132:failed|failed|  ok  |
[    0.001231]       soft-irq lock-inversion/132:failed|failed|  ok  |
[    0.001245]       hard-irq lock-inversion/213:failed|failed|  ok  |
[    0.001260]       soft-irq lock-inversion/213:failed|failed|  ok  |
[    0.001274]       hard-irq lock-inversion/231:failed|failed|  ok  |
[    0.001289]       soft-irq lock-inversion/231:failed|failed|  ok  |
[    0.001303]       hard-irq lock-inversion/312:failed|failed|  ok  |
[    0.001318]       soft-irq lock-inversion/312:failed|failed|  ok  |
[    0.001332]       hard-irq lock-inversion/321:failed|failed|  ok  |
[    0.001347]       soft-irq lock-inversion/321:failed|failed|  ok  |
[    0.001361]       hard-irq read-recursion/123:  ok  |
[    0.001370]       soft-irq read-recursion/123:  ok  |
[    0.001379]       hard-irq read-recursion/132:  ok  |
[    0.001388]       soft-irq read-recursion/132:  ok  |
[    0.001396]       hard-irq read-recursion/213:  ok  |
[    0.001406]       soft-irq read-recursion/213:  ok  |
[    0.001414]       hard-irq read-recursion/231:  ok  |
[    0.001423]       soft-irq read-recursion/231:  ok  |
[    0.001432]       hard-irq read-recursion/312:  ok  |
[    0.001441]       soft-irq read-recursion/312:  ok  |
[    0.001449]       hard-irq read-recursion/321:  ok  |
[    0.001458]       soft-irq read-recursion/321:  ok  |
[    0.001467]   --------------------------------------------------------------------------
[    0.001473]   | Wound/wait tests |
[    0.001478]   ---------------------
[    0.001482]                   ww api failures:  ok  |  ok  |  ok  |
[    0.001501]                ww contexts mixing:failed|  ok  |
[    0.001512]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
[    0.001529]                locking mismatches:  ok  |  ok  |  ok  |
[    0.001543]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.001585]            spinlock nest unlocked:failed|
[    0.001593]   -----------------------------------------------------
[    0.001599]                                  |block | try  |context|
[    0.001604]   -----------------------------------------------------
[    0.001610]                           context:failed|  ok  |  ok  |
[    0.001624]                               try:failed|  ok  |failed|
[    0.001638]                             block:failed|  ok  |failed|
[    0.001651]                          spinlock:failed|  ok  |failed|
[    0.001666] --------------------------------------------------------
[    0.001672] 151 out of 253 testcases failed, as expected. |
[    0.001677] ----------------------------------------------------
[    0.001879] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.001893] pid_max: default: 32768 minimum: 301
[    0.004623] Dentry cache hash table entries: 8388608 (order: 10, 67108864 bytes)
[    0.048929] Inode-cache hash table entries: 4194304 (order: 9, 33554432 bytes)
[    0.070899] Mount-cache hash table entries: 131072 (order: 4, 1048576 bytes)
[    0.070948] Mountpoint-cache hash table entries: 131072 (order: 4, 1048576 bytes)
[    0.073732] EEH: pSeries platform initialized
[    0.073740] POWER8 performance monitor hardware support registered
[    0.074462] smp: Bringing up secondary CPUs ...
[    0.650593] smp: Brought up 4 nodes, 16 CPUs
[    0.650607] numa: Node 0 CPUs:
[    0.650610] numa: Node 1 CPUs: 0-7
[    0.650613] numa: Node 3 CPUs:
[    0.650615] numa: Node 4 CPUs: 8-15
[    0.653391] devtmpfs: initialized
[    0.663185] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.663196] kworker/u33:0 (108) used greatest stack depth: 12384 bytes left
[    0.663207] futex hash table entries: 4096 (order: 3, 524288 bytes)
[    0.663714] NET: Registered protocol family 16
[    0.663756] EEH: No capable adapters found
[    0.664212] cpuidle: using governor menu
[    0.664248] RTAS daemon started
[    0.664324] pstore: using zlib compression
[    0.664328] pstore: Registered nvram as persistent store backend
[    0.667832] PCI: Probing PCI hardware
[    0.667840] PCI: Probing PCI hardware done
[    0.667971] pseries-rng: Registering arch random hook.
[    0.672054] HugeTLB registered 16 MB page size, pre-allocated 0 pages
[    0.672064] HugeTLB registered 16 GB page size, pre-allocated 0 pages
[    0.673429] vgaarb: loaded
[    0.673524] SCSI subsystem initialized
[    0.673622] libata version 3.00 loaded.
[    0.673728] usbcore: registered new interface driver usbfs
[    0.673750] usbcore: registered new interface driver hub
[    0.673846] usbcore: registered new device driver usb
[    0.673896] pps_core: LinuxPPS API ver. 1 registered
[    0.673907] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.673923] PTP clock support registered
[    0.674295] clocksource: Switched to clocksource timebase
[    0.687424] NET: Registered protocol family 2
[    0.687587] TCP established hash table entries: 524288 (order: 6, 4194304 bytes)
[    0.688444] TCP bind hash table entries: 65536 (order: 5, 2097152 bytes)
[    0.688704] TCP: Hash tables configured (established 524288 bind 65536)
[    0.688748] UDP hash table entries: 32768 (order: 5, 3145728 bytes)
[    0.689128] UDP-Lite hash table entries: 32768 (order: 5, 3145728 bytes)
[    0.689803] NET: Registered protocol family 1
[    0.690187] RPC: Registered named UNIX socket transport module.
[    0.690190] RPC: Registered udp transport module.
[    0.690193] RPC: Registered tcp transport module.
[    0.690195] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.690198] PCI: CLS 0 bytes, default 128
[    0.690301] Trying to unpack rootfs image as initramfs...
[    0.943625] Freeing initrd memory: 19520K
[    0.944587] IOMMU table initialized, virtual merging enabled
[    0.954824] hv-24x7: read 1330 catalog entries, created 337 event attrs (0 failures), 169 descs
[    0.955475] ====[ backtrace testing ]===========
[    0.955480] Testing a backtrace from process context.
[    0.955483] The following trace is a kernel self test and not a bug!
[    0.955488] CPU: 2 PID: 1 Comm: swapper/1 Not tainted 4.10.0-next-20170227 #3
[    0.955492] Call Trace:
[    0.955498] [c0000005dbb83b30] [c000000001fb4c64] dump_stack+0xb0/0xf0 (unreliable)
[    0.955503] [c0000005dbb83b70] [c00000000173e11c] backtrace_regression_test+0x5c/0x170
[    0.955507] [c0000005dbb83c40] [c0000000015cd660] do_one_initcall+0x60/0x1c0
[    0.955512] [c0000005dbb83d00] [c0000000022941cc] kernel_init_freeable+0x26c/0x344
[    0.955516] [c0000005dbb83dc0] [c0000000015cdf74] kernel_init+0x24/0x150
[    0.955520] [c0000005dbb83e30] [c0000000015cbc60] ret_from_kernel_thread+0x5c/0x7c
[    0.955523] Testing a backtrace from irq context.
[    0.955525] The following trace is a kernel self test and not a bug!
[    0.955530] CPU: 2 PID: 23 Comm: ksoftirqd/2 Not tainted 4.10.0-next-20170227 #3
[    0.955533] Call Trace:
[    0.955535] [c0000005dbbd7b90] [c000000001fb4c64] dump_stack+0xb0/0xf0 (unreliable)
[    0.955539] [c0000005dbbd7bd0] [c00000000173e098] backtrace_test_irq_callback+0x18/0x40
[    0.955543] [c0000005dbbd7bf0] [c000000001693298] tasklet_action+0xc8/0x1b0
[    0.955547] [c0000005dbbd7c50] [c0000000016924a4] __do_softirq+0x164/0x3d0
[    0.955550] [c0000005dbbd7d40] [c00000000169274c] run_ksoftirqd+0x3c/0xb0
[    0.955554] [c0000005dbbd7d60] [c0000000016ba1c0] smpboot_thread_fn+0x290/0x2a0
[    0.955558] [c0000005dbbd7dc0] [c0000000016b498c] kthread+0x14c/0x190
[    0.955562] [c0000005dbbd7e30] [c0000000015cbc60] ret_from_kernel_thread+0x5c/0x7c
[    0.955569] Testing a saved backtrace.
[    0.955571] The following trace is a kernel self test and not a bug!
[    0.955576]  backtrace_regression_test+0x124/0x170
[    0.955578]  do_one_initcall+0x60/0x1c0
[    0.955581]  kernel_init_freeable+0x26c/0x344
[    0.955583]  kernel_init+0x24/0x150
[    0.955586]  ret_from_kernel_thread+0x5c/0x7c
[    0.955588] ====[ end of backtrace testing ]====
[    0.955592] audit: initializing netlink subsys (disabled)
[    0.955638] audit: type=2000 audit(1488187073.950:1): state=initialized audit_enabled=0 res=1
[    0.958957] workingset: timestamp_bits=38 max_order=20 bucket_order=0
[    0.963764] NFS: Registering the id_resolver key type
[    0.963776] Key type id_resolver registered
[    0.963779] Key type id_legacy registered
[    0.963788] SGI XFS with ACLs, security attributes, no debug enabled
[    0.965835] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.965844] io scheduler noop registered
[    0.965848] io scheduler deadline registered
[    0.965981] io scheduler cfq registered (default)
[    0.965985] io scheduler mq-deadline registered
[    0.980809] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.983994] brd: module loaded
[    0.986393] loop: module loaded
[    0.986489] ipr: IBM Power RAID SCSI Device Driver version: 2.6.3 (October 17, 2015)
[    0.986661] ibmvscsi 30000070: SRP_VERSION: 16.a
[    7.584350] ibmvscsi 30000070: SRP_VERSION: 16.a
[    7.584531] ibmvscsi 30000070: Maximum ID: 64 Maximum LUN: 32 Maximum Channel: 3
[    7.584536] scsi host0: IBM POWER Virtual SCSI Adapter 1.5.9
[    7.584715] ibmvscsi 30000070: partner initialization complete
[    7.584778] ibmvscsi 30000070: host srp version: 16.a, host partition alp18-VIOS (100), OS 3, max io 1048576
[    7.584849] ibmvscsi 30000070: Client reserve enabled
[    7.584859] ibmvscsi 30000070: sent SRP login
[    7.584893] ibmvscsi 30000070: SRP_LOGIN succeeded
[    7.614680] scsi 0:0:1:0: Direct-Access     AIX      VDASD            0001 PQ: 0 ANSI: 3
[    7.615023] scsi 0:0:2:0: CD-ROM            AIX      VOPTA                 PQ: 0 ANSI: 4
[    7.616502] random: fast init done
[    7.653047] sd 0:0:1:0: [sda] 62914560 512-byte logical blocks: (32.2 GB/30.0 GiB)
[    7.653087] sr 0:0:2:0: [sr0] scsi-1 drive
[    7.653090] cdrom: Uniform CD-ROM driver Revision: 3.20
[    7.653130] sd 0:0:1:0: [sda] Write Protect is off
[    7.653137] sd 0:0:1:0: [sda] Mode Sense: 17 00 00 08
[    7.653201] sd 0:0:1:0: [sda] Cache data unavailable
[    7.653205] sd 0:0:1:0: [sda] Assuming drive cache: write through
[    7.653233] sr 0:0:2:0: Attached scsi CD-ROM sr0
[    7.653343] sd 0:0:1:0: Attached scsi generic sg0 type 0
[    7.653415] sr 0:0:2:0: Attached scsi generic sg1 type 5
[    7.653558] libphy: Fixed MDIO Bus: probed
[    7.653582] ibmveth: IBM Power Virtual Ethernet Driver 1.06
[    7.653781] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    7.653787] e100: Copyright(c) 1999-2006 Intel Corporation
[    7.653803] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    7.653809] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    7.653826] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    7.653832] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    7.653850] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    7.653856] ehci-pci: EHCI PCI platform driver
[    7.653874] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    7.653883] ohci-pci: OHCI PCI platform driver
[    7.653959] mousedev: PS/2 mouse device common for all mice
[    7.654083] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[    7.654302] device-mapper: uevent: version 1.0.3
[    7.654513] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[    7.654662] pseries_idle_driver registered
[    7.654682] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: max_sync_size new:4096 old:0
[    7.654687] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: max_sync_sg new:510 old:0
[    7.654691] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: max_sg_len new:4080 old:0
[    7.655048] usbcore: registered new interface driver usbhid
[    7.655053] usbhid: USB HID core driver
[    7.655059] oprofile: using timer interrupt.
[    7.655192] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    7.655358] NET: Registered protocol family 17
[    7.655391] Key type dns_resolver registered
[    7.655423] Running code patching self-tests ...
[    7.655713] Running feature fixup self-tests ...
[    7.655718] Running MSI bitmap self-tests ...
[    7.655936] registered taskstats version 1
[    7.655975] console [netcon0] enabled
[    7.655978] netconsole: network logging started
[    7.656041] rtc-generic rtc-generic: setting system clock to 2017-02-27 09:18:01 UTC (1488187081)
[    7.659033]  sda: sda1 sda2 sda3
[    7.659442] sd 0:0:1:0: [sda] Attached SCSI disk
[    7.659602] Freeing unused kernel memory: 2816K
[    7.659604] This architecture does not have kernel memory protection.
[    7.662164] systemd[1]: Inserted module 'autofs4'
[    7.667382] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    7.667503] systemd[1]: Detected architecture ppc64-le.
[    7.667507] systemd[1]: Running in initial RAM disk.
[    7.667753] systemd[1]: Set hostname to <localhost.localdomain>.
[    7.694031] systemd[1]: Reached target Local File Systems.
[    7.694044] systemd[1]: Starting Local File Systems.
[    7.694252] systemd[1]: Reached target Swap.
[    7.694300] systemd[1]: Starting Swap.
[    7.694670] systemd[1]: Created slice Root Slice.
[    7.694679] systemd[1]: Starting Root Slice.
[    7.795343] dracut-pre-udev (1770) used greatest stack depth: 12240 bytes left
[    7.866308] scsi_id (2786) used greatest stack depth: 12128 bytes left
[    8.304694] lvm_scan (2904) used greatest stack depth: 12080 bytes left
[    9.520357] XFS (dm-1): Mounting V5 Filesystem
[    9.602288] XFS (dm-1): Starting recovery (logdev: internal)
[    9.771881] XFS (dm-1): Ending recovery (logdev: internal)
[    9.772099] mount (2955) used greatest stack depth: 10928 bytes left
[    9.785083] random: crng init done
[   10.285432] systemd-journald[1656]: Received SIGTERM from PID 1 (systemd).
[   10.338490] systemd: 24 output lines suppressed due to ratelimiting
[   10.691137] ip_tables: (C) 2000-2006 Netfilter Core Team
[   10.691513] systemd[1]: Inserted module 'ip_tables'
[   10.789273] systemd-debug-g (3029) used greatest stack depth: 10464 bytes left
[   10.862091] systemd-sysv-generator[3036]: stat() failed on /etc/rc.d/init.d/autotest: No such file or directory
[   11.088808] kdump-dep-gener (3038) used greatest stack depth: 10416 bytes left
[   11.858600] systemd-readahead[3044]: Failed to create fanotify object: Function not implemented
[   11.858747] systemd-readahe (3044) used greatest stack depth: 10400 bytes left
[   12.005386] ------------[ cut here ]------------
[   12.005409] WARNING: CPU: 3 PID: 3052 at kernel/jump_label.c:287 static_key_set_entries.isra.10+0x3c/0x50
[   12.005412] Modules linked in: nfsd(+) ip_tables x_tables autofs4
[   12.005419] CPU: 3 PID: 3052 Comm: modprobe Not tainted 4.10.0-next-20170227 #3
[   12.005423] task: c0000005d5677800 task.stack: c0000005d452c000
[   12.005425] NIP: c0000000017bf84c LR: c0000000017bfcbc CTR: 0000000000000000
[   12.005428] REGS: c0000005d452f800 TRAP: 0700   Not tainted  (4.10.0-next-20170227)
[   12.005431] MSR: 800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
[   12.005436]   CR: 48248282  XER: 00000001
[   12.005440] CFAR: c0000000017bf81c SOFTE: 1 
GPR00: c0000000017bfc7c c0000005d452fa80 c00000000266c300 d00000000a9e28f8 
GPR04: d00000000a9e5b57 0000000100000017 c0000000017bf5a0 0000000000000000 
GPR08: 0000000000052eb3 0000000000000001 c00000000258c300 0000000000000001 
GPR12: c000000001b5b460 c00000000ea80c00 0000000000000020 d00000000a980bb0 
GPR16: c0000005d452fda0 c0000005d452fdec 0000000000000000 0000000000008580 
GPR20: d00000000aa10000 d00000000a9e7ea8 c00000000256db90 0000000000000001 
GPR24: c00000000258ca14 0000000000000000 c0000000025737f8 d00000000a9e5c17 
GPR28: 0000000000000000 d00000000a9e6780 d00000000a9e28f0 d00000000a9e5b57 
[   12.005476] NIP [c0000000017bf84c] static_key_set_entries.isra.10+0x3c/0x50
[   12.005480] LR [c0000000017bfcbc] jump_label_module_notify+0x20c/0x420
[   12.005482] Call Trace:
[   12.005485] [c0000005d452fa80] [c0000000017bfc7c] jump_label_module_notify+0x1cc/0x420 (unreliable)
[   12.005490] [c0000005d452fb40] [c0000000016b69b0] notifier_call_chain+0x90/0x100
[   12.005494] [c0000005d452fb90] [c0000000016b6e80] __blocking_notifier_call_chain+0x60/0x90
[   12.005499] [c0000005d452fbe0] [c0000000017380ec] load_module+0x1c2c/0x2760
[   12.005502] [c0000005d452fd70] [c000000001738e80] SyS_finit_module+0xc0/0xf0
[   12.005507] [c0000005d452fe30] [c0000000015cb8e0] system_call+0x38/0xfc
[   12.005509] Instruction dump:
[   12.005511] 40c20018 e9230000 792907a0 7c844b78 f8830000 4e800020 3d42fff2 892a0714 
[   12.005517] 2f890000 40feffe0 39200001 992a0714 <0fe00000> 4bffffd0 60000000 60000000 
[   12.005523] ---[ end trace 937482186422ac35 ]---
[   12.005710] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   12.021036] systemd-remount (3061) used greatest stack depth: 9744 bytes left
[   12.396212] systemd-journald[3042]: Received request to flush runtime journal from PID 1
[   12.875146] pseries_rng: Registering IBM pSeries RNG driver
[   13.027152] ibmveth 30000002 net0: renamed from eth0
[   13.051161] crypto_register_alg 'aes' = 0
[   13.051248] crypto_register_alg 'cbc(aes)' = 0
[   13.051303] crypto_register_alg 'ctr(aes)' = 0
[   13.051351] crypto_register_alg 'xts(aes)' = 0
[   13.809878] Adding 3145664k swap on /dev/mapper/rhel_alp12-swap.  Priority:-1 extents:1 across:3145664k 
[   14.390344] XFS (sda2): Mounting V5 Filesystem
[   14.936976] XFS (sda2): Starting recovery (logdev: internal)
[   15.511394] XFS (sda2): Ending recovery (logdev: internal)
[   16.120846] iprinit (5181) used greatest stack depth: 9216 bytes left
[   24.074077] systemd-sysv-generator[6583]: stat() failed on /etc/rc.d/init.d/autotest: No such file or directory
[   24.170847] systemd-sysv-generator[6648]: stat() failed on /etc/rc.d/init.d/autotest: No such file or directory
[   26.093693] tun: Universal TUN/TAP device driver, 1.6
[   26.093724] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   26.494247] virbr0: port 1(virbr0-nic) entered blocking state
[   26.494277] virbr0: port 1(virbr0-nic) entered disabled state
[   26.494398] device virbr0-nic entered promiscuous mode
[   26.557193] rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
[   27.305815] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   27.391249] virbr0: port 1(virbr0-nic) entered blocking state
[   27.391270] virbr0: port 1(virbr0-nic) entered listening state
[   27.651939] virbr0: port 1(virbr0-nic) entered disabled state
[   36.828164] cpu 8 (hwid 8) Ready to die...
[   37.035077] cpu 9 (hwid 9) Ready to die...
[   37.231287] cpu 10 (hwid 10) Ready to die...
[   37.460399] cpu 11 (hwid 11) Ready to die...
[   37.700311] cpu 12 (hwid 12) Ready to die...
[   37.940233] cpu 13 (hwid 13) Ready to die...
[   38.136553] cpu 14 (hwid 14) Ready to die...
[   38.287506] cpu 15 (hwid 15) Ready to die...
[   38.398545] pseries-hotplug-cpu: Failed to release drc (10000008) for CPU PowerPC,POWER8, rc: -17
[   39.326269] cpu 0 (hwid 0) Ready to die...
[   39.544336] cpu 1 (hwid 1) Ready to die...
[   39.729577] cpu 2 (hwid 2) Ready to die...
[   39.925883] cpu 3 (hwid 3) Ready to die...
[   40.100525] cpu 4 (hwid 4) Ready to die...
[   40.264114] cpu 5 (hwid 5) Ready to die...
[   40.460392] cpu 6 (hwid 6) Ready to die...
[   40.589509] cpu 7 (hwid 7) Ready to die...
[  196.910677] cpu 8 (hwid 8) Ready to die...
[  197.120324] cpu 9 (hwid 9) Ready to die...
[  197.290265] cpu 10 (hwid 10) Ready to die...
[  197.490234] cpu 11 (hwid 11) Ready to die...
[  197.630110] cpu 12 (hwid 12) Ready to die...
[  197.790094] cpu 13 (hwid 13) Ready to die...
[  197.980016] cpu 14 (hwid 14) Ready to die...
[  198.098137] cpu 15 (hwid 15) Ready to die...
[  198.210074] pseries-hotplug-cpu: Failed to release drc (10000008) for CPU PowerPC,POWER8, rc: -17
[  199.050648] cpu 0 (hwid 0) Ready to die...
[  199.220530] cpu 1 (hwid 1) Ready to die...
[  199.370459] cpu 2 (hwid 2) Ready to die...
[  199.600322] cpu 3 (hwid 3) Ready to die...
[  199.770259] cpu 4 (hwid 4) Ready to die...
[  199.960189] cpu 5 (hwid 5) Ready to die...
[  200.140145] cpu 6 (hwid 6) Ready to die...
[  200.258067] cpu 7 (hwid 7) Ready to die...
[  200.360320] refcount_t: underflow; use-after-free.
[  200.360371] ------------[ cut here ]------------
[  200.360385] WARNING: CPU: 10 PID: 7194 at lib/refcount.c:128 refcount_sub_and_test+0xb8/0xf0
[  200.360398] Modules linked in: iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp rpadlpar_io rpaphp tun bridge stp llc kvm iptable_filter vmx_crypto pseries_rng rng_core binfmt_misc nfsd ip_tables x_tables autofs4
[  200.360472] CPU: 10 PID: 7194 Comm: drmgr Tainted: G        W       4.10.0-next-20170227 #3
[  200.360478] task: c0000008b7222b00 task.stack: c0000008b72dc000
[  200.360483] NIP: c000000001b6b4b8 LR: c000000001b6b4b4 CTR: c000000001cefb50
[  200.360488] REGS: c0000008b72df860 TRAP: 0700   Tainted: G        W        (4.10.0-next-20170227)
[  200.360494] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
[  200.360506]   CR: 22000422  XER: 00000007
[  200.360511] CFAR: c000000001faf738 SOFTE: 1 
GPR00: c000000001b6b4b4 c0000008b72dfae0 c00000000266c300 0000000000000026 
GPR04: c00000050fd8adb0 c00000050fda1660 0000000000419000 000000000000ff00 
GPR08: 0000000000000000 c00000000235143c 000000050da40000 00000000000001d7 
GPR12: 0000000000000000 c00000000ea82800 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: 0000000000000000 0000000010018430 c0000005dd05f520 c0000008b72dfe00 
GPR28: 0000000000000000 0000000000000016 0000000000000000 c0000008b71ffa18 
[  200.360570] NIP [c000000001b6b4b8] refcount_sub_and_test+0xb8/0xf0
[  200.360575] LR [c000000001b6b4b4] refcount_sub_and_test+0xb4/0xf0
[  200.360578] Call Trace:
[  200.360582] [c0000008b72dfae0] [c000000001b6b4b4] refcount_sub_and_test+0xb4/0xf0 (unreliable)
[  200.360588] [c0000008b72dfb40] [c000000001b4b0dc] kobject_put+0x3c/0xa0
[  200.360595] [c0000008b72dfbb0] [c000000001e53bf4] of_node_put+0x24/0x40
[  200.360602] [c0000008b72dfbd0] [c00000000165b4f4] dlpar_cpu_release+0x74/0xf0
[  200.360608] [c0000008b72dfc20] [c0000000015e0e28] arch_cpu_release+0x38/0x70
[  200.360615] [c0000008b72dfc40] [c000000001c49eb0] cpu_release_store+0x40/0x70
[  200.360622] [c0000008b72dfc70] [c000000001c3d994] dev_attr_store+0x34/0x60
[  200.360629] [c0000008b72dfc90] [c00000000191bc44] sysfs_kf_write+0x64/0xa0
[  200.360634] [c0000008b72dfcb0] [c00000000191aa80] kernfs_fop_write+0x170/0x250
[  200.360641] [c0000008b72dfd00] [c00000000187c330] __vfs_write+0x40/0x1c0
[  200.360645] [c0000008b72dfd90] [c00000000187dc48] vfs_write+0xc8/0x240
[  200.360650] [c0000008b72dfde0] [c00000000187f8b0] SyS_write+0x60/0x110
[  200.360656] [c0000008b72dfe30] [c0000000015cb8e0] system_call+0x38/0xfc
[  200.360660] Instruction dump:
[  200.360663] 7d495378 419e0044 2f89ffff 7d434850 7f0a4840 79460020 41de001c 4099ffbc 
[  200.360675] 3c62ffb6 38636af8 48444249 60000000 <0fe00000> 38210060 38600000 e8010010 
[  200.360686] ---[ end trace 937482186422ac36 ]---

--Apple-Mail=_21CF2E20-6787-4665-BFA0-CCBAA7549C93--
