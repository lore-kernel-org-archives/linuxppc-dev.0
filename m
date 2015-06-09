Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3CFE1A0133
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 22:23:14 +1000 (AEST)
Message-ID: <1433852588.18194.1.camel@ellerman.id.au>
Subject: Re: [PATCH kernel v12 17/34] powerpc/spapr: vfio: Switch from
 iommu_table to new iommu_table_group
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Alex
 Williamson <alex.williamson@redhat.com>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 09 Jun 2015 22:23:08 +1000
In-Reply-To: <1433486126-23551-18-git-send-email-aik@ozlabs.ru>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
 <1433486126-23551-18-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-06-05 at 16:35 +1000, Alexey Kardashevskiy wrote:
> So far one TCE table could only be used by one IOMMU group. However
> IODA2 hardware allows programming the same TCE table address to
> multiple PE allowing sharing tables.

...

> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 84b4ea4..4b4c583 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -606,6 +606,82 @@ unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
>  	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
>  }
>  
> +struct iommu_table *pnv_pci_table_alloc(int nid)
> +{
> +	struct iommu_table *tbl;
> +
> +	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, nid);
> +	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> +
> +	return tbl;
> +}
> +
> +long pnv_pci_link_table_and_group(int node, int num,
> +		struct iommu_table *tbl,
> +		struct iommu_table_group *table_group)
> +{
> +	struct iommu_table_group_link *tgl = NULL;
> +
> +	BUG_ON(!tbl);
> +	BUG_ON(!table_group);
> +	BUG_ON(!table_group->group);


On p84 (Tuleta), my next + this series, with pseries_le_defconfig:

pci 0001:08     : [PE# 002] Assign DMA32 space
pci 0001:08     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
IOMMU table initialized, virtual merging enabled
pci 0001:08     : [PE# 002] Setting up window#0 0..7fffffff pg=1000
------------[ cut here ]------------
kernel BUG at arch/powerpc/platforms/powernv/pci.c:666!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in:
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.1.0-rc3-13721-g4c61caf #83
task: c000001ff4300000 ti: c000002ff6084000 task.ti: c000002ff6084000
NIP: c000000000067a04 LR: c00000000006b49c CTR: 000000003003e060
REGS: c000002ff6087690 TRAP: 0700   Not tainted  (4.1.0-rc3-13721-g4c61caf)
MSR: 9000000100029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 28000022  XER: 20000000
CFAR: c00000000006b498 SOFTE: 1 
GPR00: c00000000006b49c c000002ff6087910 c000000000d7cea0 0000000000000000 
GPR04: 0000000000000000 c000000fef7a0000 c000003fffb2c6d8 0000000000000000 
GPR08: 0000000000000000 0000000000000001 0000000000000000 9000000100001003 
GPR12: c00000000005d428 c000000001dc0d80 c000000000ca40f8 c000003fffb48580 
GPR16: c000000000adb4c0 c000000000adb308 c000003ffff8ca80 c000003fffb2c6a0 
GPR20: 0000000000000007 c000000000ae31b8 c0000000009136f8 0000000000080000 
GPR24: 0000000000000001 c000003fffb48850 0000000000000000 c000000fef7a0000 
GPR28: c000003fffb38580 c000000fef7a0000 c000003fffb2c6d8 0000000000000000 
NIP [c000000000067a04] pnv_pci_link_table_and_group+0x54/0xe0
LR [c00000000006b49c] pnv_pci_ioda_fixup+0x6bc/0xe30
Call Trace:
[c000002ff6087910] [c000002ff6087988] 0xc000002ff6087988 (unreliable)
[c000002ff6087950] [c00000000006b49c] pnv_pci_ioda_fixup+0x6bc/0xe30
[c000002ff6087ae0] [c000000000bef224] pcibios_resource_survey+0x2b4/0x300
[c000002ff6087bb0] [c000000000beeb6c] pcibios_init+0xa8/0xdc
[c000002ff6087c30] [c00000000000b3b0] do_one_initcall+0xd0/0x250
[c000002ff6087d00] [c000000000be422c] kernel_init_freeable+0x25c/0x33c
[c000002ff6087dc0] [c00000000000bcf4] kernel_init+0x24/0x130
[c000002ff6087e30] [c00000000000956c] ret_from_kernel_thread+0x5c/0x70
Instruction dump:
7c9f2378 7cde3378 7cbd2b78 f8010010 f821ffc1 0b090000 7cc90074 7929d182 
0b090000 e9260018 7d290074 7929d182 <0b090000> 60000000 38800000 e92294d0 
---[ end trace bfd126f01f6f6bfe ]---



Full log below:

opal: OPAL V3 detected !
Crash kernel location must be 0x2000000
Reserving 1024MB of memory at 32MB for crashkernel (System RAM: 262144MB)
Allocated 2359296 bytes for 2048 pacas at c000000001dc0000
Using PowerNV machine description
Page sizes from device-tree:
base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
base_shift=12: shift=16, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=7
base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56
base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1
base_shift=16: shift=24, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=8
base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
base_shift=34: shift=34, sllp=0x0120, avpnm=0x000007ff, tlbiel=0, penc=3
Page orders: linear mapping = 24, virtual = 16, io = 16, vmemmap = 24
Using 1TB segments
cma: Reserved 13120 MiB at 0x0000003cac000000
bootconsole [udbg0] enabled
CPU maps initialized for 8 threads per core
 (thread shift is 3)
Freed 2162688 bytes for unused pacas
 -> smp_release_cpus()
spinning_secondaries = 127
 <- smp_release_cpus()
Starting Linux ppc64le #83 SMP Tue Jun 9 15:52:08 AEST 2015
-----------------------------------------------------
ppc64_pft_size    = 0x0
phys_mem_size     = 0x4000000000
cpu_features      = 0x17fc7aed18500249
  possible        = 0x1fffffef18500649
  always          = 0x0000000018100040
cpu_user_features = 0xdc0065c7 0xee000000
mmu_features      = 0x7c000003
firmware_features = 0x0000000430000000
htab_address      = 0xc000003fe0000000
htab_hash_mask    = 0x1fffff
-----------------------------------------------------
 <- setup_system()
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 4.1.0-rc3-13721-g4c61caf (buildbot@p82-slave) (gcc version 4.9.2 (Ubuntu 4.9.2-10ubuntu12) ) #83 SMP Tue Jun 9 15:52:08 AEST 2015
Node 0 Memory: 0x0-0x1000000000
Node 1 Memory: 0x1000000000-0x2000000000
Node 16 Memory: 0x2000000000-0x3000000000
Node 17 Memory: 0x3000000000-0x4000000000
numa: Initmem setup node 0 [mem 0x00000000-0xfffffffff]
numa:   NODE_DATA [mem 0xfffff5000-0xfffffffff]
numa: Initmem setup node 1 [mem 0x1000000000-0x1fffffffff]
numa:   NODE_DATA [mem 0x1fffff5000-0x1fffffffff]
numa: Initmem setup node 16 [mem 0x2000000000-0x2fffffffff]
numa:   NODE_DATA [mem 0x2fffff5000-0x2fffffffff]
numa: Initmem setup node 17 [mem 0x3000000000-0x3fffffffff]
numa:   NODE_DATA [mem 0x3fffb81000-0x3fffb8bfff]
Initializing IODA2 OPAL PHB /pciex@3fffe40000000
PCI host bridge /pciex@3fffe40000000 (primary) ranges:
 MEM 0x00003fe000000000..0x00003fe07ffeffff -> 0x0000000080000000 
 MEM64 0x00003b0000000000..0x00003b0fffffffff -> 0x00003b0000000000
  256 (000) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x1000000000 [segment=0x10000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x800)
Initializing IODA2 OPAL PHB /pciex@3fffe40100000
PCI host bridge /pciex@3fffe40100000  ranges:
 MEM 0x00003fe080000000..0x00003fe0fffeffff -> 0x0000000080000000 
 MEM64 0x00003b1000000000..0x00003b1fffffffff -> 0x00003b1000000000
  256 (000) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x1000000000 [segment=0x10000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x1000)
Initializing IODA2 OPAL PHB /pciex@3fffe40400000
PCI host bridge /pciex@3fffe40400000  ranges:
 MEM 0x00003fe200000000..0x00003fe27ffeffff -> 0x0000000080000000 
 MEM64 0x00003b4000000000..0x00003b4fffffffff -> 0x00003b4000000000
  256 (000) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x1000000000 [segment=0x10000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x2800)
Initializing IODA2 OPAL PHB /pciex@3fffe40500000
PCI host bridge /pciex@3fffe40500000  ranges:
 MEM 0x00003fe280000000..0x00003fe2fffeffff -> 0x0000000080000000 
 MEM64 0x00003b5000000000..0x00003b5fffffffff -> 0x00003b5000000000
  256 (000) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x1000000000 [segment=0x10000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x3000)
Initializing IODA2 OPAL PHB /pciex@3fffe42000000
PCI host bridge /pciex@3fffe42000000  ranges:
 MEM 0x00003ff000000000..0x00003ff07ffeffff -> 0x0000000080000000 
 MEM64 0x00003d0000000000..0x00003d0fffffffff -> 0x00003d0000000000
  256 (000) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x1000000000 [segment=0x10000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x20800)
Initializing IODA2 OPAL PHB /pciex@3fffe42100000
PCI host bridge /pciex@3fffe42100000  ranges:
 MEM 0x00003ff080000000..0x00003ff0fffeffff -> 0x0000000080000000 
 MEM64 0x00003d1000000000..0x00003d1fffffffff -> 0x00003d1000000000
  256 (000) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x1000000000 [segment=0x10000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x21000)
Initializing IODA2 OPAL PHB /pciex@3fffe42400000
PCI host bridge /pciex@3fffe42400000  ranges:
 MEM 0x00003ff200000000..0x00003ff27ffeffff -> 0x0000000080000000 
 MEM64 0x00003d4000000000..0x00003d4fffffffff -> 0x00003d4000000000
  256 (000) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x1000000000 [segment=0x10000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x22800)
Initializing IODA2 OPAL PHB /pciex@3fffe42500000
PCI host bridge /pciex@3fffe42500000  ranges:
 MEM 0x00003ff280000000..0x00003ff2fffeffff -> 0x0000000080000000 
 MEM64 0x00003d5000000000..0x00003d5fffffffff -> 0x00003d5000000000
  256 (000) PE's M32: 0x80000000 [segment=0x800000]
                 M64: 0x1000000000 [segment=0x10000000]
  Allocated bitmap for 2040 MSIs (base IRQ 0x23000)
OPAL nvram setup, 1048576 bytes
Top of RAM: 0x4000000000, Total RAM: 0x4000000000
Memory hole size: 0MB
Zone ranges:
  DMA      [mem 0x0000000000000000-0x0000003fffffffff]
  DMA32    empty
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000fffffffff]
  node   1: [mem 0x0000001000000000-0x0000001fffffffff]
  node  16: [mem 0x0000002000000000-0x0000002fffffffff]
  node  17: [mem 0x0000003000000000-0x0000003fffffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000fffffffff]
On node 0 totalpages: 1048576
  DMA zone: 1024 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 1048576 pages, LIFO batch:1
Initmem setup node 1 [mem 0x0000001000000000-0x0000001fffffffff]
On node 1 totalpages: 1048576
  DMA zone: 1024 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 1048576 pages, LIFO batch:1
Initmem setup node 16 [mem 0x0000002000000000-0x0000002fffffffff]
On node 16 totalpages: 1048576
  DMA zone: 1024 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 1048576 pages, LIFO batch:1
Initmem setup node 17 [mem 0x0000003000000000-0x0000003fffffffff]
On node 17 totalpages: 1048576
  DMA zone: 1024 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 1048576 pages, LIFO batch:1
PERCPU: Embedded 3 pages/cpu @c000000ff9000000 s126616 r0 d69992 u262144
pcpu-alloc: s126616 r0 d69992 u262144 alloc=1*1048576
pcpu-alloc: [0] 000 001 002 003 [0] 004 005 006 007 
pcpu-alloc: [0] 008 009 010 011 [0] 012 013 014 015 
pcpu-alloc: [0] 016 017 018 019 [0] 020 021 022 023 
pcpu-alloc: [0] 024 025 026 027 [0] 028 029 030 031 
pcpu-alloc: [0] 032 033 034 035 [0] 036 037 038 039 
pcpu-alloc: [0] 040 041 042 043 [0] 044 045 046 047 
pcpu-alloc: [0] 048 049 050 051 [0] 052 053 054 055 
pcpu-alloc: [0] 056 057 058 059 [0] 060 061 062 063 
pcpu-alloc: [0] 064 065 066 067 [0] 068 069 070 071 
pcpu-alloc: [0] 072 073 074 075 [0] 076 077 078 079 
pcpu-alloc: [0] 080 081 082 083 [0] 084 085 086 087 
pcpu-alloc: [0] 088 089 090 091 [0] 092 093 094 095 
pcpu-alloc: [0] 096 097 098 099 [0] 100 101 102 103 
pcpu-alloc: [0] 104 105 106 107 [0] 108 109 110 111 
pcpu-alloc: [0] 112 113 114 115 [0] 116 117 118 119 
pcpu-alloc: [0] 120 121 122 123 [0] 124 125 126 127 
Built 4 zonelists in Node order, mobility grouping on.  Total pages: 4190208
Policy zone: DMA
Kernel command line: root=/dev/sda2 debug nosplash crashkernel=1G@1G
log_buf_len individual max cpu contribution: 4096 bytes
log_buf_len total cpu_extra contributions: 520192 bytes
log_buf_len min size: 131072 bytes
log_buf_len: 1048576 bytes
early log buf free: 120008(91%)
PID hash table entries: 4096 (order: -1, 32768 bytes)
Sorting __ex_table...
Memory: 253326464K/268435456K available (9280K kernel code, 1152K rwdata, 2848K rodata, 768K init, 1041K bss, 1674112K reserved, 13434880K cma-reserved)
SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=128, Nodes=18
Hierarchical RCU implementation.
	Additional per-CPU info printed with stalls.
	RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=128.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=128
NR_IRQS:512 nr_irqs:512 16
ICS OPAL backend registered
time_init: decrementer frequency = 512.000000 MHz
time_init: processor frequency   = 3658.000000 MHz
clocksource timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
clocksource: timebase mult[1f40000] shift[24] registered
clockevent: decrementer mult[83126e98] shift[32] cpu[0]
Console: colour dummy device 80x25
console [hvc0] enabled
console [hvc0] enabled
bootconsole [udbg0] disabled
bootconsole [udbg0] disabled
mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
pid_max: default: 131072 minimum: 1024
Dentry cache hash table entries: 33554432 (order: 12, 268435456 bytes)
Inode-cache hash table entries: 16777216 (order: 11, 134217728 bytes)
Mount-cache hash table entries: 524288 (order: 6, 4194304 bytes)
Mountpoint-cache hash table entries: 524288 (order: 6, 4194304 bytes)
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys perf_event
EEH: PowerNV platform initialized
POWER8 performance monitor hardware support registered
power8-pmu: PMAO restore workaround active.
Brought up 128 CPUs
Node 0 CPUs: 0-31
Node 1 CPUs: 32-63
Node 16 CPUs: 64-95
Node 17 CPUs: 96-127
devtmpfs: initialized
EEH: devices created
kworker/u256:0 (654) used greatest stack depth: 14080 bytes left
clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
NET: Registered protocol family 16
IBM eBus Device Driver
kworker/u256:0 (656) used greatest stack depth: 12768 bytes left
cpuidle: using governor ladder
cpuidle: using governor menu
pstore: Registered nvram as persistent store backend
PCI: Probing PCI hardware
PCI: I/O resource not set for host bridge /pciex@3fffe40000000 (domain 0)
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0x3fe000000000-0x3fe07ffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0000:00: root bus resource [mem 0x3b0010000000-0x3b0fffffffff 64bit pref]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
pci 0000:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:00.0: PCI bridge to [bus 01]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
PCI: I/O resource not set for host bridge /pciex@3fffe40100000 (domain 1)
PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [mem 0x3fe080000000-0x3fe0fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0001:00: root bus resource [mem 0x3b1010000000-0x3b1fffffffff 64bit pref]
pci_bus 0001:00: root bus resource [bus 00-ff]
pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to ff
pci 0001:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0001:00:00.0: PME# supported from D0 D3hot D3cold
pci 0001:01:00.0: [10b5:8732] type 01 class 0x060400
pci 0001:01:00.0: reg 0x10: [mem 0x3fe081800000-0x3fe08183ffff]
pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
pci 0001:00:00.0: PCI bridge to [bus 01-0d]
pci 0001:00:00.0:   bridge window [mem 0x3fe080000000-0x3fe081ffffff]
pci 0001:00:00.0:   bridge window [mem 0x3b1010000000-0x3b103fffffff 64bit pref]
pci 0001:02:01.0: [10b5:8732] type 01 class 0x060400
pci 0001:02:01.0: PME# supported from D0 D3hot D3cold
pci 0001:02:08.0: [10b5:8732] type 01 class 0x060400
pci 0001:02:08.0: PME# supported from D0 D3hot D3cold
pci 0001:02:09.0: [10b5:8732] type 01 class 0x060400
pci 0001:02:09.0: PME# supported from D0 D3hot D3cold
pci 0001:01:00.0: PCI bridge to [bus 02-0d]
pci 0001:01:00.0:   bridge window [mem 0x3fe080000000-0x3fe0817fffff]
pci 0001:01:00.0:   bridge window [mem 0x3b1010000000-0x3b103fffffff 64bit pref]
pci 0001:02:01.0: PCI bridge to [bus 03-07]
pci 0001:02:01.0:   bridge window [mem 0x3fe080000000-0x3fe0807fffff]
pci 0001:02:01.0:   bridge window [mem 0x3b1010000000-0x3b101fffffff 64bit pref]
pci 0001:08:00.0: [1014:034a] type 00 class 0x010400
pci 0001:08:00.0: reg 0x10: [mem 0x3fe080820000-0x3fe08082ffff 64bit]
pci 0001:08:00.0: reg 0x18: [mem 0x3fe080830000-0x3fe08083ffff 64bit]
pci 0001:08:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
pci 0001:08:00.0: PME# supported from D0 D3hot D3cold
pci 0001:02:08.0: PCI bridge to [bus 08]
pci 0001:02:08.0:   bridge window [mem 0x3fe080800000-0x3fe080ffffff]
pci 0001:02:08.0:   bridge window [mem 0x3b1020000000-0x3b102fffffff 64bit pref]
pci 0001:02:09.0: PCI bridge to [bus 09-0d]
pci 0001:02:09.0:   bridge window [mem 0x3fe081000000-0x3fe0817fffff]
pci 0001:02:09.0:   bridge window [mem 0x3b1030000000-0x3b103fffffff 64bit pref]
pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 0d
PCI: I/O resource not set for host bridge /pciex@3fffe40400000 (domain 2)
PCI host bridge to bus 0002:00
pci_bus 0002:00: root bus resource [mem 0x3fe200000000-0x3fe27ffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0002:00: root bus resource [mem 0x3b4010000000-0x3b4fffffffff 64bit pref]
pci_bus 0002:00: root bus resource [bus 00-ff]
pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to ff
pci 0002:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0002:00:00.0: PME# supported from D0 D3hot D3cold
pci 0002:00:00.0: PCI bridge to [bus 01]
pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to 01
PCI: I/O resource not set for host bridge /pciex@3fffe40500000 (domain 3)
PCI host bridge to bus 0003:00
pci_bus 0003:00: root bus resource [mem 0x3fe280000000-0x3fe2fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0003:00: root bus resource [mem 0x3b5010000000-0x3b5fffffffff 64bit pref]
pci_bus 0003:00: root bus resource [bus 00-ff]
pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to ff
pci 0003:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0003:00:00.0: PME# supported from D0 D3hot D3cold
pci 0003:01:00.0: [10b5:8748] type 01 class 0x060400
pci 0003:01:00.0: reg 0x10: [mem 0x3fe282800000-0x3fe28283ffff]
pci 0003:01:00.0: PME# supported from D0 D3hot D3cold
pci 0003:00:00.0: PCI bridge to [bus 01-13]
pci 0003:00:00.0:   bridge window [mem 0x3fe280000000-0x3fe282ffffff]
pci 0003:00:00.0:   bridge window [mem 0x3b5010000000-0x3b504fffffff 64bit pref]
pci 0003:02:01.0: [10b5:8748] type 01 class 0x060400
pci 0003:02:01.0: PME# supported from D0 D3hot D3cold
pci 0003:02:08.0: [10b5:8748] type 01 class 0x060400
pci 0003:02:08.0: PME# supported from D0 D3hot D3cold
pci 0003:02:09.0: [10b5:8748] type 01 class 0x060400
pci 0003:02:09.0: PME# supported from D0 D3hot D3cold
pci 0003:02:10.0: [10b5:8748] type 01 class 0x060400
pci 0003:02:10.0: PME# supported from D0 D3hot D3cold
pci 0003:02:11.0: [10b5:8748] type 01 class 0x060400
pci 0003:02:11.0: PME# supported from D0 D3hot D3cold
pci 0003:01:00.0: PCI bridge to [bus 02-13]
pci 0003:01:00.0:   bridge window [mem 0x3fe280000000-0x3fe2827fffff]
pci 0003:01:00.0:   bridge window [mem 0x3b5010000000-0x3b504fffffff 64bit pref]
pci 0003:03:00.0: [104c:8241] type 00 class 0x0c0330
pci 0003:03:00.0: reg 0x10: [mem 0x3fe280000000-0x3fe28000ffff 64bit]
pci 0003:03:00.0: reg 0x18: [mem 0x3fe280010000-0x3fe280011fff 64bit]
pci 0003:03:00.0: supports D1 D2
pci 0003:03:00.0: PME# supported from D0 D1 D2 D3hot
pci 0003:02:01.0: PCI bridge to [bus 03]
pci 0003:02:01.0:   bridge window [mem 0x3fe280000000-0x3fe2807fffff]
pci 0003:02:08.0: PCI bridge to [bus 04-08]
pci 0003:02:08.0:   bridge window [mem 0x3fe280800000-0x3fe280ffffff]
pci 0003:02:08.0:   bridge window [mem 0x3b5010000000-0x3b501fffffff 64bit pref]
pci 0003:09:00.0: [14e4:1657] type 00 class 0x020000
pci 0003:09:00.0: reg 0x10: [mem 0x3b5020000000-0x3b502000ffff 64bit pref]
pci 0003:09:00.0: reg 0x18: [mem 0x3b5020010000-0x3b502001ffff 64bit pref]
pci 0003:09:00.0: reg 0x20: [mem 0x3b5020020000-0x3b502002ffff 64bit pref]
pci 0003:09:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
pci 0003:09:00.0: PME# supported from D0 D3hot D3cold
pci 0003:09:00.1: [14e4:1657] type 00 class 0x020000
pci 0003:09:00.1: reg 0x10: [mem 0x3b5020030000-0x3b502003ffff 64bit pref]
pci 0003:09:00.1: reg 0x18: [mem 0x3b5020040000-0x3b502004ffff 64bit pref]
pci 0003:09:00.1: reg 0x20: [mem 0x3b5020050000-0x3b502005ffff 64bit pref]
pci 0003:09:00.1: reg 0x30: [mem 0x00000000-0x0007ffff pref]
pci 0003:09:00.1: PME# supported from D0 D3hot D3cold
pci 0003:09:00.2: [14e4:1657] type 00 class 0x020000
pci 0003:09:00.2: reg 0x10: [mem 0x3b5020060000-0x3b502006ffff 64bit pref]
pci 0003:09:00.2: reg 0x18: [mem 0x3b5020070000-0x3b502007ffff 64bit pref]
pci 0003:09:00.2: reg 0x20: [mem 0x3b5020080000-0x3b502008ffff 64bit pref]
pci 0003:09:00.2: reg 0x30: [mem 0x00000000-0x0007ffff pref]
pci 0003:09:00.2: PME# supported from D0 D3hot D3cold
pci 0003:09:00.3: [14e4:1657] type 00 class 0x020000
pci 0003:09:00.3: reg 0x10: [mem 0x3b5020090000-0x3b502009ffff 64bit pref]
pci 0003:09:00.3: reg 0x18: [mem 0x3b50200a0000-0x3b50200affff 64bit pref]
pci 0003:09:00.3: reg 0x20: [mem 0x3b50200b0000-0x3b50200bffff 64bit pref]
pci 0003:09:00.3: reg 0x30: [mem 0x00000000-0x0007ffff pref]
pci 0003:09:00.3: PME# supported from D0 D3hot D3cold
pci 0003:02:09.0: PCI bridge to [bus 09]
pci 0003:02:09.0:   bridge window [mem 0x3fe281000000-0x3fe2817fffff]
pci 0003:02:09.0:   bridge window [mem 0x3b5020000000-0x3b502fffffff 64bit pref]
pci 0003:02:10.0: PCI bridge to [bus 0a-0e]
pci 0003:02:10.0:   bridge window [mem 0x3fe281800000-0x3fe281ffffff]
pci 0003:02:10.0:   bridge window [mem 0x3b5030000000-0x3b503fffffff 64bit pref]
pci 0003:02:11.0: PCI bridge to [bus 0f-13]
pci 0003:02:11.0:   bridge window [mem 0x3fe282000000-0x3fe2827fffff]
pci 0003:02:11.0:   bridge window [mem 0x3b5040000000-0x3b504fffffff 64bit pref]
pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to 13
PCI: I/O resource not set for host bridge /pciex@3fffe42000000 (domain 4)
PCI host bridge to bus 0004:00
pci_bus 0004:00: root bus resource [mem 0x3ff000000000-0x3ff07ffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0004:00: root bus resource [mem 0x3d0010000000-0x3d0fffffffff 64bit pref]
pci_bus 0004:00: root bus resource [bus 00-ff]
pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to ff
pci 0004:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
pci 0004:01:00.0: [10de:13ba] type 00 class 0x030000
pci 0004:01:00.0: reg 0x10: [mem 0x3ff000000000-0x3ff000ffffff]
pci 0004:01:00.0: reg 0x14: [mem 0x3d0010000000-0x3d001fffffff 64bit pref]
pci 0004:01:00.0: reg 0x1c: [mem 0x3d0020000000-0x3d0021ffffff 64bit pref]
pci 0004:01:00.0: reg 0x24: [io  0x0000-0x007f]
pci 0004:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
pci 0004:01:00.1: [10de:0fbc] type 00 class 0x040300
pci 0004:01:00.1: reg 0x10: [mem 0x3ff001080000-0x3ff001083fff]
pci 0004:00:00.0: PCI bridge to [bus 01]
pci 0004:00:00.0:   bridge window [mem 0x3ff000000000-0x3ff0017fffff]
pci 0004:00:00.0:   bridge window [mem 0x3d0010000000-0x3d002fffffff 64bit pref]
pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to 01
PCI: I/O resource not set for host bridge /pciex@3fffe42100000 (domain 5)
PCI host bridge to bus 0005:00
pci_bus 0005:00: root bus resource [mem 0x3ff080000000-0x3ff0fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0005:00: root bus resource [mem 0x3d1010000000-0x3d1fffffffff 64bit pref]
pci_bus 0005:00: root bus resource [bus 00-ff]
pci_bus 0005:00: busn_res: [bus 00-ff] end is updated to ff
pci 0005:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0005:00:00.0: PME# supported from D0 D3hot D3cold
pci 0005:00:00.0: PCI bridge to [bus 01]
pci_bus 0005:00: busn_res: [bus 00-ff] end is updated to 01
PCI: I/O resource not set for host bridge /pciex@3fffe42400000 (domain 6)
PCI host bridge to bus 0006:00
pci_bus 0006:00: root bus resource [mem 0x3ff200000000-0x3ff27ffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0006:00: root bus resource [mem 0x3d4010000000-0x3d4fffffffff 64bit pref]
pci_bus 0006:00: root bus resource [bus 00-ff]
pci_bus 0006:00: busn_res: [bus 00-ff] end is updated to ff
pci 0006:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0006:00:00.0: PME# supported from D0 D3hot D3cold
pci 0006:00:00.0: PCI bridge to [bus 01]
pci_bus 0006:00: busn_res: [bus 00-ff] end is updated to 01
PCI: I/O resource not set for host bridge /pciex@3fffe42500000 (domain 7)
PCI host bridge to bus 0007:00
pci_bus 0007:00: root bus resource [mem 0x3ff280000000-0x3ff2fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0007:00: root bus resource [mem 0x3d5010000000-0x3d5fffffffff 64bit pref]
pci_bus 0007:00: root bus resource [bus 00-ff]
pci_bus 0007:00: busn_res: [bus 00-ff] end is updated to ff
pci 0007:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0007:00:00.0: PME# supported from D0 D3hot D3cold
pci 0007:00:00.0: PCI bridge to [bus 01]
pci_bus 0007:00: busn_res: [bus 00-ff] end is updated to 01
pci 0000:00:00.0: PCI bridge to [bus 01]
pci_bus 0000:00: resource 4 [mem 0x3fe000000000-0x3fe07ffeffff]
pci_bus 0000:00: resource 5 [mem 0x3b0010000000-0x3b0fffffffff 64bit pref]
pci 0001:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 03-07] add_size 1000
pci 0001:02:01.0: bridge window [mem 0x10000000-0x0fffffff 64bit pref] to [bus 03-07] add_size 10000000 add_align 10000000
pci 0001:02:01.0: bridge window [mem 0x00800000-0x007fffff] to [bus 03-07] add_size 800000 add_align 800000
pci 0001:02:08.0: bridge window [io  0x1000-0x0fff] to [bus 08] add_size 1000
pci 0001:02:08.0: bridge window [mem 0x10000000-0x0fffffff 64bit pref] to [bus 08] add_size 10000000 add_align 10000000
pci 0001:02:09.0: bridge window [io  0x1000-0x0fff] to [bus 09-0d] add_size 1000
pci 0001:02:09.0: bridge window [mem 0x10000000-0x0fffffff 64bit pref] to [bus 09-0d] add_size 10000000 add_align 10000000
pci 0001:02:09.0: bridge window [mem 0x00800000-0x007fffff] to [bus 09-0d] add_size 800000 add_align 800000
pci 0001:02:01.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0001:02:08.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0001:02:09.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0001:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-0d] add_size 3000
pci 0001:02:01.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:01.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:08.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:08.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:09.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:09.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:01:00.0: bridge window [mem 0x10000000-0x0fffffff 64bit pref] to [bus 02-0d] add_size 30000000 add_align 10000000
pci 0001:02:01.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0001:02:01.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0001:02:09.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0001:02:09.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0001:01:00.0: bridge window [mem 0x00800000-0x00ffffff] to [bus 02-0d] add_size 1000000 add_align 800000
pci 0001:01:00.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 3000 min_align 1000
pci 0001:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01-0d] add_size 3000
pci 0001:01:00.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0001:01:00.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0001:00:00.0: bridge window [mem 0x10000000-0x0fffffff 64bit pref] to [bus 01-0d] add_size 30000000 add_align 10000000
pci 0001:01:00.0: res[8]=[mem 0x00800000-0x00ffffff] res_to_dev_res add_size 1000000 min_align 800000
pci 0001:01:00.0: res[8]=[mem 0x00800000-0x00ffffff] res_to_dev_res add_size 1000000 min_align 800000
pci 0001:00:00.0: bridge window [mem 0x00800000-0x017fffff] to [bus 01-0d] add_size 1000000 add_align 800000
pci 0001:00:00.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0001:00:00.0: res[9]=[mem 0x10000000-0x3fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0001:00:00.0: res[8]=[mem 0x00800000-0x017fffff] res_to_dev_res add_size 1000000 min_align 800000
pci 0001:00:00.0: res[8]=[mem 0x00800000-0x027fffff] res_to_dev_res add_size 1000000 min_align 800000
pci 0001:00:00.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 3000 min_align 1000
pci 0001:00:00.0: res[7]=[io  0x1000-0x3fff] res_to_dev_res add_size 3000 min_align 1000
pci 0001:00:00.0: BAR 9: assigned [mem 0x3b1010000000-0x3b103fffffff 64bit pref]
pci 0001:00:00.0: BAR 8: assigned [mem 0x3fe080000000-0x3fe081ffffff]
pci 0001:00:00.0: BAR 7: no space for [io  size 0x3000]
pci 0001:00:00.0: BAR 7: failed to assign [io  size 0x3000]
pci 0001:00:00.0: BAR 7: no space for [io  size 0x3000]
pci 0001:00:00.0: BAR 7: failed to assign [io  size 0x3000]
pci 0001:01:00.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0001:01:00.0: res[9]=[mem 0x10000000-0x3fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0001:01:00.0: res[8]=[mem 0x00800000-0x00ffffff] res_to_dev_res add_size 1000000 min_align 800000
pci 0001:01:00.0: res[8]=[mem 0x00800000-0x01ffffff] res_to_dev_res add_size 1000000 min_align 800000
pci 0001:01:00.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 3000 min_align 1000
pci 0001:01:00.0: res[7]=[io  0x1000-0x3fff] res_to_dev_res add_size 3000 min_align 1000
pci 0001:01:00.0: BAR 9: assigned [mem 0x3b1010000000-0x3b103fffffff 64bit pref]
pci 0001:01:00.0: BAR 8: assigned [mem 0x3fe080000000-0x3fe0817fffff]
pci 0001:01:00.0: BAR 0: assigned [mem 0x3fe081800000-0x3fe08183ffff]
pci 0001:01:00.0: BAR 7: no space for [io  size 0x3000]
pci 0001:01:00.0: BAR 7: failed to assign [io  size 0x3000]
pci 0001:01:00.0: BAR 7: no space for [io  size 0x3000]
pci 0001:01:00.0: BAR 7: failed to assign [io  size 0x3000]
pci 0001:02:01.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:01.0: res[9]=[mem 0x10000000-0x1fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:08.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:08.0: res[9]=[mem 0x10000000-0x1fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:09.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:09.0: res[9]=[mem 0x10000000-0x1fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0001:02:01.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0001:02:01.0: res[8]=[mem 0x00800000-0x00ffffff] res_to_dev_res add_size 800000 min_align 800000
pci 0001:02:09.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0001:02:09.0: res[8]=[mem 0x00800000-0x00ffffff] res_to_dev_res add_size 800000 min_align 800000
pci 0001:02:01.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0001:02:01.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
pci 0001:02:08.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0001:02:08.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
pci 0001:02:09.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0001:02:09.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
pci 0001:02:01.0: BAR 9: assigned [mem 0x3b1010000000-0x3b101fffffff 64bit pref]
pci 0001:02:08.0: BAR 9: assigned [mem 0x3b1020000000-0x3b102fffffff 64bit pref]
pci 0001:02:09.0: BAR 9: assigned [mem 0x3b1030000000-0x3b103fffffff 64bit pref]
pci 0001:02:01.0: BAR 8: assigned [mem 0x3fe080000000-0x3fe0807fffff]
pci 0001:02:08.0: BAR 8: assigned [mem 0x3fe080800000-0x3fe080ffffff]
pci 0001:02:09.0: BAR 8: assigned [mem 0x3fe081000000-0x3fe0817fffff]
pci 0001:02:01.0: BAR 7: no space for [io  size 0x1000]
pci 0001:02:01.0: BAR 7: failed to assign [io  size 0x1000]
pci 0001:02:08.0: BAR 7: no space for [io  size 0x1000]
pci 0001:02:08.0: BAR 7: failed to assign [io  size 0x1000]
pci 0001:02:09.0: BAR 7: no space for [io  size 0x1000]
pci 0001:02:09.0: BAR 7: failed to assign [io  size 0x1000]
pci 0001:02:09.0: BAR 7: no space for [io  size 0x1000]
pci 0001:02:09.0: BAR 7: failed to assign [io  size 0x1000]
pci 0001:02:08.0: BAR 7: no space for [io  size 0x1000]
pci 0001:02:08.0: BAR 7: failed to assign [io  size 0x1000]
pci 0001:02:01.0: BAR 7: no space for [io  size 0x1000]
pci 0001:02:01.0: BAR 7: failed to assign [io  size 0x1000]
pci 0001:02:01.0: PCI bridge to [bus 03-07]
pci 0001:02:01.0:   bridge window [mem 0x3fe080000000-0x3fe0807fffff]
pci 0001:02:01.0:   bridge window [mem 0x3b1010000000-0x3b101fffffff 64bit pref]
pci 0001:08:00.0: BAR 6: assigned [mem 0x3fe080800000-0x3fe08081ffff pref]
pci 0001:08:00.0: BAR 0: assigned [mem 0x3fe080820000-0x3fe08082ffff 64bit]
pci 0001:08:00.0: BAR 2: assigned [mem 0x3fe080830000-0x3fe08083ffff 64bit]
pci 0001:02:08.0: PCI bridge to [bus 08]
pci 0001:02:08.0:   bridge window [mem 0x3fe080800000-0x3fe080ffffff]
pci 0001:02:08.0:   bridge window [mem 0x3b1020000000-0x3b102fffffff 64bit pref]
pci 0001:02:09.0: PCI bridge to [bus 09-0d]
pci 0001:02:09.0:   bridge window [mem 0x3fe081000000-0x3fe0817fffff]
pci 0001:02:09.0:   bridge window [mem 0x3b1030000000-0x3b103fffffff 64bit pref]
pci 0001:01:00.0: PCI bridge to [bus 02-0d]
pci 0001:01:00.0:   bridge window [mem 0x3fe080000000-0x3fe0817fffff]
pci 0001:01:00.0:   bridge window [mem 0x3b1010000000-0x3b103fffffff 64bit pref]
pci 0001:00:00.0: PCI bridge to [bus 01-0d]
pci 0001:00:00.0:   bridge window [mem 0x3fe080000000-0x3fe081ffffff]
pci 0001:00:00.0:   bridge window [mem 0x3b1010000000-0x3b103fffffff 64bit pref]
pci_bus 0001:00: resource 4 [mem 0x3fe080000000-0x3fe0fffeffff]
pci_bus 0001:00: resource 5 [mem 0x3b1010000000-0x3b1fffffffff 64bit pref]
pci_bus 0001:01: resource 1 [mem 0x3fe080000000-0x3fe081ffffff]
pci_bus 0001:01: resource 2 [mem 0x3b1010000000-0x3b103fffffff 64bit pref]
pci_bus 0001:02: resource 1 [mem 0x3fe080000000-0x3fe0817fffff]
pci_bus 0001:02: resource 2 [mem 0x3b1010000000-0x3b103fffffff 64bit pref]
pci_bus 0001:03: resource 1 [mem 0x3fe080000000-0x3fe0807fffff]
pci_bus 0001:03: resource 2 [mem 0x3b1010000000-0x3b101fffffff 64bit pref]
pci_bus 0001:08: resource 1 [mem 0x3fe080800000-0x3fe080ffffff]
pci_bus 0001:08: resource 2 [mem 0x3b1020000000-0x3b102fffffff 64bit pref]
pci_bus 0001:09: resource 1 [mem 0x3fe081000000-0x3fe0817fffff]
pci_bus 0001:09: resource 2 [mem 0x3b1030000000-0x3b103fffffff 64bit pref]
pci 0002:00:00.0: PCI bridge to [bus 01]
pci_bus 0002:00: resource 4 [mem 0x3fe200000000-0x3fe27ffeffff]
pci_bus 0002:00: resource 5 [mem 0x3b4010000000-0x3b4fffffffff 64bit pref]
pci 0003:02:08.0: bridge window [io  0x1000-0x0fff] to [bus 04-08] add_size 1000
pci 0003:02:08.0: bridge window [mem 0x10000000-0x0fffffff 64bit pref] to [bus 04-08] add_size 10000000 add_align 10000000
pci 0003:02:08.0: bridge window [mem 0x00800000-0x007fffff] to [bus 04-08] add_size 800000 add_align 800000
pci 0003:02:09.0: bridge window [io  0x1000-0x0fff] to [bus 09] add_size 1000
pci 0003:02:10.0: bridge window [io  0x1000-0x0fff] to [bus 0a-0e] add_size 1000
pci 0003:02:10.0: bridge window [mem 0x10000000-0x0fffffff 64bit pref] to [bus 0a-0e] add_size 10000000 add_align 10000000
pci 0003:02:10.0: bridge window [mem 0x00800000-0x007fffff] to [bus 0a-0e] add_size 800000 add_align 800000
pci 0003:02:11.0: bridge window [io  0x1000-0x0fff] to [bus 0f-13] add_size 1000
pci 0003:02:11.0: bridge window [mem 0x10000000-0x0fffffff 64bit pref] to [bus 0f-13] add_size 10000000 add_align 10000000
pci 0003:02:11.0: bridge window [mem 0x00800000-0x007fffff] to [bus 0f-13] add_size 800000 add_align 800000
pci 0003:02:08.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:09.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:10.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:11.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-13] add_size 4000
pci 0003:02:08.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:08.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:10.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:10.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:11.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:11.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:01:00.0: bridge window [mem 0x10000000-0x1fffffff 64bit pref] to [bus 02-13] add_size 30000000 add_align 10000000
pci 0003:02:08.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:08.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:10.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:10.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:11.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:11.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:01:00.0: bridge window [mem 0x00800000-0x017fffff] to [bus 02-13] add_size 1800000 add_align 800000
pci 0003:01:00.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 4000 min_align 1000
pci 0003:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01-13] add_size 4000
pci 0003:01:00.0: res[9]=[mem 0x10000000-0x1fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0003:01:00.0: res[9]=[mem 0x10000000-0x1fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0003:00:00.0: bridge window [mem 0x10000000-0x1fffffff 64bit pref] to [bus 01-13] add_size 30000000 add_align 10000000
pci 0003:01:00.0: res[8]=[mem 0x00800000-0x017fffff] res_to_dev_res add_size 1800000 min_align 800000
pci 0003:01:00.0: res[8]=[mem 0x00800000-0x017fffff] res_to_dev_res add_size 1800000 min_align 800000
pci 0003:00:00.0: bridge window [mem 0x00800000-0x01ffffff] to [bus 01-13] add_size 1800000 add_align 800000
pci 0003:00:00.0: res[9]=[mem 0x10000000-0x1fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0003:00:00.0: res[9]=[mem 0x10000000-0x4fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0003:00:00.0: res[8]=[mem 0x00800000-0x01ffffff] res_to_dev_res add_size 1800000 min_align 800000
pci 0003:00:00.0: res[8]=[mem 0x00800000-0x037fffff] res_to_dev_res add_size 1800000 min_align 800000
pci 0003:00:00.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 4000 min_align 1000
pci 0003:00:00.0: res[7]=[io  0x1000-0x4fff] res_to_dev_res add_size 4000 min_align 1000
pci 0003:00:00.0: BAR 9: assigned [mem 0x3b5010000000-0x3b504fffffff 64bit pref]
pci 0003:00:00.0: BAR 8: assigned [mem 0x3fe280000000-0x3fe282ffffff]
pci 0003:00:00.0: BAR 7: no space for [io  size 0x4000]
pci 0003:00:00.0: BAR 7: failed to assign [io  size 0x4000]
pci 0003:00:00.0: BAR 7: no space for [io  size 0x4000]
pci 0003:00:00.0: BAR 7: failed to assign [io  size 0x4000]
pci 0003:01:00.0: res[9]=[mem 0x10000000-0x1fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0003:01:00.0: res[9]=[mem 0x10000000-0x4fffffff 64bit pref] res_to_dev_res add_size 30000000 min_align 10000000
pci 0003:01:00.0: res[8]=[mem 0x00800000-0x017fffff] res_to_dev_res add_size 1800000 min_align 800000
pci 0003:01:00.0: res[8]=[mem 0x00800000-0x02ffffff] res_to_dev_res add_size 1800000 min_align 800000
pci 0003:01:00.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 4000 min_align 1000
pci 0003:01:00.0: res[7]=[io  0x1000-0x4fff] res_to_dev_res add_size 4000 min_align 1000
pci 0003:01:00.0: BAR 9: assigned [mem 0x3b5010000000-0x3b504fffffff 64bit pref]
pci 0003:01:00.0: BAR 8: assigned [mem 0x3fe280000000-0x3fe2827fffff]
pci 0003:01:00.0: BAR 0: assigned [mem 0x3fe282800000-0x3fe28283ffff]
pci 0003:01:00.0: BAR 7: no space for [io  size 0x4000]
pci 0003:01:00.0: BAR 7: failed to assign [io  size 0x4000]
pci 0003:01:00.0: BAR 7: no space for [io  size 0x4000]
pci 0003:01:00.0: BAR 7: failed to assign [io  size 0x4000]
pci 0003:02:08.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:08.0: res[9]=[mem 0x10000000-0x1fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:10.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:10.0: res[9]=[mem 0x10000000-0x1fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:11.0: res[9]=[mem 0x10000000-0x0fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:11.0: res[9]=[mem 0x10000000-0x1fffffff 64bit pref] res_to_dev_res add_size 10000000 min_align 10000000
pci 0003:02:08.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:08.0: res[8]=[mem 0x00800000-0x00ffffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:10.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:10.0: res[8]=[mem 0x00800000-0x00ffffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:11.0: res[8]=[mem 0x00800000-0x007fffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:11.0: res[8]=[mem 0x00800000-0x00ffffff] res_to_dev_res add_size 800000 min_align 800000
pci 0003:02:08.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:08.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:09.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:09.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:10.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:10.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:11.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:11.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
pci 0003:02:08.0: BAR 9: assigned [mem 0x3b5010000000-0x3b501fffffff 64bit pref]
pci 0003:02:09.0: BAR 9: assigned [mem 0x3b5020000000-0x3b502fffffff 64bit pref]
pci 0003:02:10.0: BAR 9: assigned [mem 0x3b5030000000-0x3b503fffffff 64bit pref]
pci 0003:02:11.0: BAR 9: assigned [mem 0x3b5040000000-0x3b504fffffff 64bit pref]
pci 0003:02:01.0: BAR 8: assigned [mem 0x3fe280000000-0x3fe2807fffff]
pci 0003:02:08.0: BAR 8: assigned [mem 0x3fe280800000-0x3fe280ffffff]
pci 0003:02:09.0: BAR 8: assigned [mem 0x3fe281000000-0x3fe2817fffff]
pci 0003:02:10.0: BAR 8: assigned [mem 0x3fe281800000-0x3fe281ffffff]
pci 0003:02:11.0: BAR 8: assigned [mem 0x3fe282000000-0x3fe2827fffff]
pci 0003:02:08.0: BAR 7: no space for [io  size 0x1000]
pci 0003:02:08.0: BAR 7: failed to assign [io  size 0x1000]
pci 0003:02:09.0: BAR 7: no space for [io  size 0x1000]
pci 0003:02:09.0: BAR 7: failed to assign [io  size 0x1000]
pci 0003:02:10.0: BAR 7: no space for [io  size 0x1000]
pci 0003:02:10.0: BAR 7: failed to assign [io  size 0x1000]
pci 0003:02:11.0: BAR 7: no space for [io  size 0x1000]
pci 0003:02:11.0: BAR 7: failed to assign [io  size 0x1000]
pci 0003:02:11.0: BAR 7: no space for [io  size 0x1000]
pci 0003:02:11.0: BAR 7: failed to assign [io  size 0x1000]
pci 0003:02:10.0: BAR 7: no space for [io  size 0x1000]
pci 0003:02:10.0: BAR 7: failed to assign [io  size 0x1000]
pci 0003:02:09.0: BAR 7: no space for [io  size 0x1000]
pci 0003:02:09.0: BAR 7: failed to assign [io  size 0x1000]
pci 0003:02:08.0: BAR 7: no space for [io  size 0x1000]
pci 0003:02:08.0: BAR 7: failed to assign [io  size 0x1000]
pci 0003:03:00.0: BAR 0: assigned [mem 0x3fe280000000-0x3fe28000ffff 64bit]
pci 0003:03:00.0: BAR 2: assigned [mem 0x3fe280010000-0x3fe280011fff 64bit]
pci 0003:02:01.0: PCI bridge to [bus 03]
pci 0003:02:01.0:   bridge window [mem 0x3fe280000000-0x3fe2807fffff]
pci 0003:02:08.0: PCI bridge to [bus 04-08]
pci 0003:02:08.0:   bridge window [mem 0x3fe280800000-0x3fe280ffffff]
pci 0003:02:08.0:   bridge window [mem 0x3b5010000000-0x3b501fffffff 64bit pref]
pci 0003:09:00.0: BAR 6: assigned [mem 0x3fe281000000-0x3fe28107ffff pref]
pci 0003:09:00.1: BAR 6: assigned [mem 0x3fe281080000-0x3fe2810fffff pref]
pci 0003:09:00.2: BAR 6: assigned [mem 0x3fe281100000-0x3fe28117ffff pref]
pci 0003:09:00.3: BAR 6: assigned [mem 0x3fe281180000-0x3fe2811fffff pref]
pci 0003:09:00.0: BAR 0: assigned [mem 0x3b5020000000-0x3b502000ffff 64bit pref]
pci 0003:09:00.0: BAR 2: assigned [mem 0x3b5020010000-0x3b502001ffff 64bit pref]
pci 0003:09:00.0: BAR 4: assigned [mem 0x3b5020020000-0x3b502002ffff 64bit pref]
pci 0003:09:00.1: BAR 0: assigned [mem 0x3b5020030000-0x3b502003ffff 64bit pref]
pci 0003:09:00.1: BAR 2: assigned [mem 0x3b5020040000-0x3b502004ffff 64bit pref]
pci 0003:09:00.1: BAR 4: assigned [mem 0x3b5020050000-0x3b502005ffff 64bit pref]
pci 0003:09:00.2: BAR 0: assigned [mem 0x3b5020060000-0x3b502006ffff 64bit pref]
pci 0003:09:00.2: BAR 2: assigned [mem 0x3b5020070000-0x3b502007ffff 64bit pref]
pci 0003:09:00.2: BAR 4: assigned [mem 0x3b5020080000-0x3b502008ffff 64bit pref]
pci 0003:09:00.3: BAR 0: assigned [mem 0x3b5020090000-0x3b502009ffff 64bit pref]
pci 0003:09:00.3: BAR 2: assigned [mem 0x3b50200a0000-0x3b50200affff 64bit pref]
pci 0003:09:00.3: BAR 4: assigned [mem 0x3b50200b0000-0x3b50200bffff 64bit pref]
pci 0003:02:09.0: PCI bridge to [bus 09]
pci 0003:02:09.0:   bridge window [mem 0x3fe281000000-0x3fe2817fffff]
pci 0003:02:09.0:   bridge window [mem 0x3b5020000000-0x3b502fffffff 64bit pref]
pci 0003:02:10.0: PCI bridge to [bus 0a-0e]
pci 0003:02:10.0:   bridge window [mem 0x3fe281800000-0x3fe281ffffff]
pci 0003:02:10.0:   bridge window [mem 0x3b5030000000-0x3b503fffffff 64bit pref]
pci 0003:02:11.0: PCI bridge to [bus 0f-13]
pci 0003:02:11.0:   bridge window [mem 0x3fe282000000-0x3fe2827fffff]
pci 0003:02:11.0:   bridge window [mem 0x3b5040000000-0x3b504fffffff 64bit pref]
pci 0003:01:00.0: PCI bridge to [bus 02-13]
pci 0003:01:00.0:   bridge window [mem 0x3fe280000000-0x3fe2827fffff]
pci 0003:01:00.0:   bridge window [mem 0x3b5010000000-0x3b504fffffff 64bit pref]
pci 0003:00:00.0: PCI bridge to [bus 01-13]
pci 0003:00:00.0:   bridge window [mem 0x3fe280000000-0x3fe282ffffff]
pci 0003:00:00.0:   bridge window [mem 0x3b5010000000-0x3b504fffffff 64bit pref]
pci_bus 0003:00: resource 4 [mem 0x3fe280000000-0x3fe2fffeffff]
pci_bus 0003:00: resource 5 [mem 0x3b5010000000-0x3b5fffffffff 64bit pref]
pci_bus 0003:01: resource 1 [mem 0x3fe280000000-0x3fe282ffffff]
pci_bus 0003:01: resource 2 [mem04:00     : [PE# 003] Secondary bus 0 associated with PE#3
pci 0004:01     : [PE# 001] Secondary bus 1 associated with PE#1
pci 0005:00     : [PE# 001] Secondary bus 0 associated with PE#1
pci 0005:01     : [PE# 002] Secondary bus 1 associated with PE#2
pci 0006:00     : [PE# 001] Secondary bus 0 associated with PE#1
pci 0006:01     : [PE# 002] Secondary bus 1 associated with PE#2
pci 0007:00     : [PE# 001] Secondary bus 0 associated with PE#1
pci 0007:01     : [PE# 002] Secondary bus 1 associated with PE#2
PCI: Domain 0000 has 8 available 32-bit DMA segments
PCI: 0 PE# for a total weight of 0
PCI: Domain 0001 has 8 available 32-bit DMA segments
PCI: 1 PE# for a total weight of 15
pci 0001:08     : [PE# 002] Assign DMA32 space
pci 0001:08     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
IOMMU table initialized, virtual merging enabled
pci 0001:08     : [PE# 002] Setting up window#0 0..7fffffff pg=1000
------------[ cut here ]------------
kernel BUG at arch/powerpc/platforms/powernv/pci.c:666!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in:
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.1.0-rc3-13721-g4c61caf #83
task: c000001ff4300000 ti: c000002ff6084000 task.ti: c000002ff6084000
NIP: c000000000067a04 LR: c00000000006b49c CTR: 000000003003e060
REGS: c000002ff6087690 TRAP: 0700   Not tainted  (4.1.0-rc3-13721-g4c61caf)
MSR: 9000000100029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 28000022  XER: 20000000
CFAR: c00000000006b498 SOFTE: 1 
GPR00: c00000000006b49c c000002ff6087910 c000000000d7cea0 0000000000000000 
GPR04: 0000000000000000 c000000fef7a0000 c000003fffb2c6d8 0000000000000000 
GPR08: 0000000000000000 0000000000000001 0000000000000000 9000000100001003 
GPR12: c00000000005d428 c000000001dc0d80 c000000000ca40f8 c000003fffb48580 
GPR16: c000000000adb4c0 c000000000adb308 c000003ffff8ca80 c000003fffb2c6a0 
GPR20: 0000000000000007 c000000000ae31b8 c0000000009136f8 0000000000080000 
GPR24: 0000000000000001 c000003fffb48850 0000000000000000 c000000fef7a0000 
GPR28: c000003fffb38580 c000000fef7a0000 c000003fffb2c6d8 0000000000000000 
NIP [c000000000067a04] pnv_pci_link_table_and_group+0x54/0xe0
LR [c00000000006b49c] pnv_pci_ioda_fixup+0x6bc/0xe30
Call Trace:
[c000002ff6087910] [c000002ff6087988] 0xc000002ff6087988 (unreliable)
[c000002ff6087950] [c00000000006b49c] pnv_pci_ioda_fixup+0x6bc/0xe30
[c000002ff6087ae0] [c000000000bef224] pcibios_resource_survey+0x2b4/0x300
[c000002ff6087bb0] [c000000000beeb6c] pcibios_init+0xa8/0xdc
[c000002ff6087c30] [c00000000000b3b0] do_one_initcall+0xd0/0x250
[c000002ff6087d00] [c000000000be422c] kernel_init_freeable+0x25c/0x33c
[c000002ff6087dc0] [c00000000000bcf4] kernel_init+0x24/0x130
[c000002ff6087e30] [c00000000000956c] ret_from_kernel_thread+0x5c/0x70
Instruction dump:
7c9f2378 7cde3378 7cbd2b78 f8010010 f821ffc1 0b090000 7cc90074 7929d182 
0b090000 e9260018 7d290074 7929d182 <0b090000> 60000000 38800000 e92294d0 
---[ end trace bfd126f01f6f6bfe ]---
