Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by ozlabs.org (Postfix) with ESMTP id C21662C0150
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Apr 2013 22:45:56 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.34]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LlKzA-1V229F0dza-00b7WI for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Apr 2013 14:45:55 +0200
From: Dennis Schridde <devurandom@gmx.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell: Only iterate over online nodes in
 cbe_init_pm_irq()
Date: Tue, 23 Apr 2013 14:45:50 +0200
Message-ID: <2343936.gRCKd0qRgh@ernie>
In-Reply-To: <1366719291-29414-1-git-send-email-michael@ellerman.id.au>
References: <1366719291-29414-1-git-send-email-michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4668238.xTe0nm3jXk";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nextPart4668238.xTe0nm3jXk
Content-Type: multipart/mixed; boundary="nextPart1440802.k9IquNnYL2"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart1440802.k9IquNnYL2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello everyone!

I have been testing this patch (given to me by Grant Likely 
<grant.likely@secretlab.ca>) with various kernel versions (3.6.2, 3.6.11, 
3.8.6, 3.8.8) since November and can confirm that it solves part of the IRQ 
mapping issue on Cell (namely the one Michael mentioned) and does not cause 
any additional noticable problems.

Some problems remain after this patch, as can be seen in the attached 
dmesg.log. If further information is required to debug this, or you need some 
help in testing more patches, please contact me.

--Dennis
--nextPart1440802.k9IquNnYL2
Content-Disposition: attachment; filename="blade00-dmesg.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="utf-8"; name="blade00-dmesg.log"

[    0.000000] Allocated 20480 bytes for 32 pacas at c00000000fffb000
[    0.000000] Using Cell machine description
[    0.000000] Page orders: linear mapping = 24, virtual = 12, io = 12, vmemmap = 24
[    0.000000] Found initrd at 0xc000000004265000:0xc000000004c22964
[    0.000000] Found legacy serial port 0 for /axon@10000000000/plb5/plb4/opb/serial@40000200
[    0.000000]   mem=14540000200, taddr=14540000200, irq=0, clk=14745600, speed=19200
[    0.000000] Found legacy serial port 1 for /axon@10000000000/plb5/plb4/opb/serial@40000300
[    0.000000]   mem=14540000300, taddr=14540000300, irq=0, clk=14745600, speed=115200
[    0.000000] Found legacy serial port 2 for /axon@30000000000/plb5/plb4/opb/serial@40000200
[    0.000000]   mem=34540000200, taddr=34540000200, irq=0, clk=14745600, speed=-1
[    0.000000] Found legacy serial port 3 for /axon@30000000000/plb5/plb4/opb/serial@40000300
[    0.000000]   mem=34540000300, taddr=34540000300, irq=0, clk=14745600, speed=-1
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] CPU maps initialized for 2 threads per core
[    0.000000]  (thread shift is 1)
[    0.000000] Freed 16384 bytes for unused pacas
[    0.000000] Starting Linux PPC64 #1 SMP Tue Apr 16 10:08:12 CEST 2013
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size                = 0x0
[    0.000000] physicalMemorySize            = 0x200000000
[    0.000000] htab_address                  = 0xc000000078000000
[    0.000000] htab_hash_mask                = 0xfffff
[    0.000000] -----------------------------------------------------
[    0.000000] Linux version 3.8.6-aufs (root@blade00) (gcc version 4.7.2 (Gentoo 4.7.2-r1 p1.5, pie-0.5.5) ) #1 SMP Tue Apr 16 10:08:12 CEST 2013
[    0.000000] *** 0000 : CF000012

[    0.000000] *** 0000 : Setup Arch
[    0.000000] [boot]0012 Setup Arch
[    0.000000] Node 0 Memory: 0x0-0x100000000
[    0.000000] Node 1 Memory: 0x100000000-0x200000000
[    0.000000] mmio NVRAM, 1020k at 0x14502000000 mapped to d000080080008000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000-0x1ffffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0xffffffff]
[    0.000000]   node   1: [mem 0x100000000-0x1ffffffff]
[    0.000000] On node 0 totalpages: 1048576
[    0.000000]   DMA zone: 14336 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 1034240 pages, LIFO batch:31
[    0.000000] On node 1 totalpages: 1048576
[    0.000000]   DMA zone: 14336 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 1034240 pages, LIFO batch:31
[    0.000000] *** 0000 : CF000015

[    0.000000] *** 0000 : Setup Done
[    0.000000] [boot]0015 Setup Done
[    0.000000] PERCPU: Embedded 11 pages/cpu @c000000000800000 s14848 r0 d30208 u262144
[    0.000000] pcpu-alloc: s14848 r0 d30208 u262144 alloc=1*1048576
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 2068480
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line:  ksdevice=bootif lang=  ip=eth0:dhcp root=nfs:192.168.100.1:/export/gentoo/root-ppc64 text  
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] freeing bootmem node 0
[    0.000000] freeing bootmem node 1
[    0.000000] Memory: 8058732k/8388608k available (6164k kernel code, 329876k reserved, 676k data, 398k bss, 2072k init)
[    0.000000] SLUB: Genslabs=15, HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=256
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=4.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] IIC for CPU 0 target id 0xe : /be@20000000000/interrupt-controller@508400
[    0.000000] IIC for CPU 1 target id 0xf : /be@20000000000/interrupt-controller@508400
[    0.000000] IIC for CPU 2 target id 0x1e : /be@20100000000/interrupt-controller@508400
[    0.000000] IIC for CPU 3 target id 0x1f : /be@20100000000/interrupt-controller@508400
[    0.000000] mpic: Setting up MPIC " MPIC     " version 1.2 at 0, max 4 CPUs
[    0.000000] mpic: ISU size: 128, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 128 sources
[    0.000000] /axon@10000000000/interrupt-controller: hooking up to IRQ 43
[    0.000000] mpic: Setting up MPIC " MPIC     " version 1.2 at 0, max 4 CPUs
[    0.000000] mpic: ISU size: 128, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 128 sources
[    0.000000] /axon@30000000000/interrupt-controller: hooking up to IRQ 299
[    0.000000] time_init: decrementer frequency = 26.664333 MHz
[    0.000000] time_init: processor frequency   = 3200.000000 MHz
[    0.000000] clocksource: timebase mult[2580d717] shift[24] registered
[    0.000000] clockevent: decrementer mult[6d37946] shift[32] cpu[0]
[    0.000000] Console: colour dummy device 80x25
[    0.065086] pid_max: default: 32768 minimum: 301
[    0.095333] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.151126] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.198839] Mount-cache hash table entries: 256
[    0.227727] Brought up 4 CPUs
[    0.245016] Node 0 CPUs: 0-1
[    0.245025] Node 1 CPUs: 2-3
[    0.245668] devtmpfs: initialized
[    0.316341] NET: Registered protocol family 16
[    0.342793] iommu: node 0, dynamic window 0x0-0x80000000 fixed window 0x80000000-0x280000000
[    0.344192] IOMMU: Using strong ordering for fixed mapping
[    0.378559] IOMMU table initialized, virtual merging enabled
[    0.412058] iommu: node 1, dynamic window 0x0-0x80000000 fixed window 0x80000000-0x280000000
[    0.414287] IOMMU: Using strong ordering for fixed mapping
[    0.468866] PCI: Probing PCI hardware
[    0.490341] PCI: Probing PCI hardware done
[    0.490734] irq: irq-93==>hwirq-0x5d mapping failed: -22
[    0.522130] ------------[ cut here ]------------
[    0.549706] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[    0.591895] Modules linked in:
[    0.610126] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[    0.652317] REGS: c0000000fe667190 TRAP: 0700   Not tainted  (3.8.6-aufs)
[    0.692940] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44000024  XER: 00000000
[    0.739817] SOFTE: 1
[    0.752840] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667410 c000000000699cb0 000000000000002c 
GPR04: 0000000000000000 0000000078e26d37 0000000000000008 0000000000000000 
GPR08: 0000000078eef1c4 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 000000000000005e 
GPR24: 0000000000000174 000000000000005d 000000000000005d c0000000fe65fc00 
GPR28: c0000000fe006060 000000000000005d c000000000643be0 000000000000005d 
[    1.119009] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[    1.159628] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[    1.199731] Call Trace:
[    1.214318] [c0000000fe667410] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    1.269528] [c0000000fe6674e0] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[    1.313801] [c0000000fe667580] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[    1.359639] [c0000000fe667630] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[    1.404429] [c0000000fe6676c0] [c000000000290df0] .of_irq_count+0x30/0x58
[    1.445057] [c0000000fe667750] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[    1.488287] [c0000000fe667850] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[    1.538810] [c0000000fe6678f0] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[    1.585687] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    1.632564] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[    1.678404] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    1.736219] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    1.779445] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[    1.825281] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[    1.865907] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[    1.911738] Instruction dump:
[    1.929448] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[    1.975803] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[    2.023213] ---[ end trace 093b23e74665976f ]---
[    2.051302] irq: irq-59==>hwirq-0x3b mapping failed: -22
[    2.082642] ------------[ cut here ]------------
[    2.110236] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[    2.152425] Modules linked in:
[    2.170657] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[    2.212846] REGS: c0000000fe666fb0 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[    2.259200] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44000024  XER: 00000000
[    2.306076] SOFTE: 1
[    2.319100] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667230 c000000000699cb0 000000000000002c 
GPR04: 0000000000000000 000000007b5d549f 0000000000000008 0000000000000000 
GPR08: 000000007b69dec9 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 000000000000003c 
GPR24: 00000000000000ec 000000000000003b 000000000000003b c0000000fe803100 
GPR28: c0000000fe006060 000000000000003b c000000000643be0 000000000000003b 
[    2.685263] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[    2.725888] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[    2.765991] Call Trace:
[    2.780579] [c0000000fe667230] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    2.835789] [c0000000fe667300] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[    2.880062] [c0000000fe6673a0] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[    2.925896] [c0000000fe667450] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[    2.970690] [c0000000fe6674e0] [c000000000290df0] .of_irq_count+0x30/0x58
[    3.011315] [c0000000fe667570] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[    3.054548] [c0000000fe667670] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[    3.105070] [c0000000fe667710] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[    3.151946] [c0000000fe667800] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    3.198824] [c0000000fe6678f0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    3.245701] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    3.292577] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[    3.338414] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    3.396228] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    3.439457] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[    3.485294] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[    3.525921] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[    3.571752] Instruction dump:
[    3.589461] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[    3.635817] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[    3.683216] ---[ end trace 093b23e746659770 ]---
[    3.711776] irq: irq-18==>hwirq-0x2 mapping failed: -22
[    3.742608] ------------[ cut here ]------------
[    3.770199] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[    3.812387] Modules linked in:
[    3.830618] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[    3.872808] REGS: c0000000fe666ec0 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[    3.919162] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44000024  XER: 00000000
[    3.966038] SOFTE: 1
[    3.979061] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667140 c000000000699cb0 000000000000002b 
GPR04: 0000000000000000 000000007e00bb99 0000000000000008 0000000000000000 
GPR08: 000000007e0d404e 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 0000000000000013 
GPR24: 0000000000000008 0000000000000002 0000000000000012 c0000000fe803500 
GPR28: c0000000fe006060 0000000000000012 c000000000643be0 0000000000000002 
[    4.345224] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[    4.385850] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[    4.425953] Call Trace:
[    4.440540] [c0000000fe667140] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    4.495750] [c0000000fe667210] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[    4.540023] [c0000000fe6672b0] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[    4.585858] [c0000000fe667360] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[    4.630651] [c0000000fe6673f0] [c000000000290df0] .of_irq_count+0x30/0x58
[    4.671277] [c0000000fe667480] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[    4.714509] [c0000000fe667580] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[    4.765032] [c0000000fe667620] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[    4.811908] [c0000000fe667710] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    4.858786] [c0000000fe667800] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    4.905662] [c0000000fe6678f0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    4.952539] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    4.999415] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[    5.045253] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    5.103067] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    5.146297] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[    5.192132] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[    5.232760] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[    5.278590] Instruction dump:
[    5.296299] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[    5.342655] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[    5.390054] ---[ end trace 093b23e746659771 ]---
[    5.419401] irq: irq-102==>hwirq-0x66 mapping failed: -22
[    5.451267] ------------[ cut here ]------------
[    5.478859] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[    5.521048] Modules linked in:
[    5.539279] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[    5.581470] REGS: c0000000fe6670a0 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[    5.627823] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[    5.674700] SOFTE: 1
[    5.687723] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667320 c000000000699cb0 000000000000002d 
GPR04: 0000000000000000 0000000080b79860 0000000000000008 0000000000000000 
GPR08: 0000000080c47261 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 0000000000000067 
GPR24: 0000000000000198 0000000000000066 0000000000000066 c0000000fe806f00 
GPR28: c0000000fe006060 0000000000000066 c000000000643be0 0000000000000066 
[    6.053885] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[    6.094512] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[    6.134614] Call Trace:
[    6.149201] [c0000000fe667320] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    6.204412] [c0000000fe6673f0] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[    6.248684] [c0000000fe667490] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[    6.294520] [c0000000fe667540] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[    6.339313] [c0000000fe6675d0] [c000000000290df0] .of_irq_count+0x30/0x58
[    6.379940] [c0000000fe667660] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[    6.423171] [c0000000fe667760] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[    6.473693] [c0000000fe667800] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[    6.520570] [c0000000fe6678f0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    6.567447] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    6.614324] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[    6.660160] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    6.717975] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    6.761204] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[    6.807039] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[    6.847667] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[    6.893498] Instruction dump:
[    6.911208] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[    6.957563] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[    7.004962] ---[ end trace 093b23e746659772 ]---
[    7.032744] irq: irq-110==>hwirq-0x6e mapping failed: -22
[    7.064870] ------------[ cut here ]------------
[    7.092465] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[    7.134654] Modules linked in:
[    7.152885] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[    7.195074] REGS: c0000000fe6670a0 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[    7.241429] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[    7.288306] SOFTE: 1
[    7.301328] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667320 c000000000699cb0 000000000000002d 
GPR04: 0000000000000000 0000000083483c8a 0000000000000008 0000000000000000 
GPR08: 000000008354f799 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 000000000000006f 
GPR24: 00000000000001b8 000000000000006e 000000000000006e c0000000fe806f00 
GPR28: c0000000fe006060 000000000000006e c000000000643be0 000000000000006e 
[    7.667491] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[    7.708117] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[    7.748219] Call Trace:
[    7.762807] [c0000000fe667320] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    7.818018] [c0000000fe6673f0] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[    7.862290] [c0000000fe667490] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[    7.908125] [c0000000fe667540] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[    7.952918] [c0000000fe6675d0] [c000000000290df0] .of_irq_count+0x30/0x58
[    7.993545] [c0000000fe667660] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[    8.036776] [c0000000fe667760] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[    8.087299] [c0000000fe667800] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[    8.134175] [c0000000fe6678f0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    8.181053] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    8.227929] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[    8.273765] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    8.331580] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    8.374810] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[    8.420646] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[    8.461272] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[    8.507103] Instruction dump:
[    8.524813] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[    8.571169] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[    8.618568] ---[ end trace 093b23e746659773 ]---
[    8.646369] irq: irq-39==>hwirq-0x27 mapping failed: -22
[    8.677955] ------------[ cut here ]------------
[    8.705551] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[    8.747738] Modules linked in:
[    8.765970] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[    8.808160] REGS: c0000000fe6670a0 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[    8.854513] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[    8.901390] SOFTE: 1
[    8.914413] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667320 c000000000699cb0 000000000000002c 
GPR04: 0000000000000000 0000000085d8c1ca 0000000000000008 0000000000000000 
GPR08: 0000000085e54682 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000000fe006078 0000000000000028 
GPR24: 000000000000009c 0000000000000027 0000000000000027 c0000000fe807000 
GPR28: c0000000fe006060 0000000000000027 c000000000643be0 0000000000000027 
[    9.280577] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[    9.321202] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[    9.361304] Call Trace:
[    9.375891] [c0000000fe667320] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[    9.431102] [c0000000fe6673f0] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[    9.475374] [c0000000fe667490] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[    9.521210] [c0000000fe667540] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[    9.566002] [c0000000fe6675d0] [c000000000290df0] .of_irq_count+0x30/0x58
[    9.606630] [c0000000fe667660] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[    9.649861] [c0000000fe667760] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[    9.700383] [c0000000fe667800] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[    9.747260] [c0000000fe6678f0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    9.794137] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[    9.841014] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[    9.886851] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[    9.944665] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[    9.987895] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   10.033731] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   10.074357] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   10.120188] Instruction dump:
[   10.137898] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   10.184254] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   10.231652] ---[ end trace 093b23e746659774 ]---
[   10.259697] irq: irq-93==>hwirq-0x5d mapping failed: -22
[   10.291040] ------------[ cut here ]------------
[   10.318635] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[   10.360823] Modules linked in:
[   10.379055] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[   10.421245] REGS: c0000000fe667190 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[   10.467599] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   10.514475] SOFTE: 1
[   10.527498] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667410 c000000000699cb0 000000000000002c 
GPR04: 0000000000000000 00000000886910b7 0000000000000008 0000000000000000 
GPR08: 0000000088759576 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 000000000000005e 
GPR24: 0000000000000174 000000000000005d 000000000000005d c0000001fe743100 
GPR28: c0000001fe001000 000000000000005d c000000000643be0 000000000000005d 
[   10.893662] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[   10.934287] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[   10.974389] Call Trace:
[   10.988976] [c0000000fe667410] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   11.044187] [c0000000fe6674e0] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[   11.088460] [c0000000fe667580] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[   11.134294] [c0000000fe667630] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[   11.179088] [c0000000fe6676c0] [c000000000290df0] .of_irq_count+0x30/0x58
[   11.219715] [c0000000fe667750] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[   11.262946] [c0000000fe667850] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[   11.313468] [c0000000fe6678f0] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[   11.360346] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   11.407222] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[   11.453058] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   11.510873] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   11.554103] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   11.599938] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   11.640565] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   11.686396] Instruction dump:
[   11.704106] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   11.750461] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   11.797861] ---[ end trace 093b23e746659775 ]---
[   11.825985] irq: irq-59==>hwirq-0x3b mapping failed: -22
[   11.857353] ------------[ cut here ]------------
[   11.884947] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[   11.927135] Modules linked in:
[   11.945367] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[   11.987557] REGS: c0000000fe666fb0 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[   12.033911] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   12.080787] SOFTE: 1
[   12.093810] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667230 c000000000699cb0 000000000000002c 
GPR04: 0000000000000000 000000008ae64d23 0000000000000008 0000000000000000 
GPR08: 000000008af2dcbb 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 000000000000003c 
GPR24: 00000000000000ec 000000000000003b 000000000000003b c0000001fe743600 
GPR28: c0000001fe001000 000000000000003b c000000000643be0 000000000000003b 
[   12.459974] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[   12.500599] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[   12.540701] Call Trace:
[   12.555288] [c0000000fe667230] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   12.610499] [c0000000fe667300] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[   12.654772] [c0000000fe6673a0] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[   12.700607] [c0000000fe667450] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[   12.745400] [c0000000fe6674e0] [c000000000290df0] .of_irq_count+0x30/0x58
[   12.786027] [c0000000fe667570] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[   12.829258] [c0000000fe667670] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[   12.879780] [c0000000fe667710] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[   12.926658] [c0000000fe667800] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   12.973534] [c0000000fe6678f0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   13.020411] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   13.067288] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[   13.113125] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   13.170939] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   13.214169] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   13.260005] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   13.300631] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   13.346462] Instruction dump:
[   13.364172] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   13.410527] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   13.457926] ---[ end trace 093b23e746659776 ]---
[   13.486091] irq: irq-20==>hwirq-0x2 mapping failed: -22
[   13.516898] ------------[ cut here ]------------
[   13.544492] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[   13.586680] Modules linked in:
[   13.604912] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[   13.647101] REGS: c0000000fe666ec0 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[   13.693456] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   13.740333] SOFTE: 1
[   13.753356] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667140 c000000000699cb0 000000000000002b 
GPR04: 0000000000000000 000000008d89b97c 0000000000000008 0000000000000000 
GPR08: 000000008d9612d7 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 0000000000000015 
GPR24: 0000000000000008 0000000000000002 0000000000000014 c0000001fe743900 
GPR28: c0000001fe001000 0000000000000014 c000000000643be0 0000000000000002 
[   14.119519] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[   14.160144] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[   14.200246] Call Trace:
[   14.214833] [c0000000fe667140] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   14.270044] [c0000000fe667210] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[   14.314317] [c0000000fe6672b0] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[   14.360152] [c0000000fe667360] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[   14.404945] [c0000000fe6673f0] [c000000000290df0] .of_irq_count+0x30/0x58
[   14.445571] [c0000000fe667480] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[   14.488802] [c0000000fe667580] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[   14.539325] [c0000000fe667620] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[   14.586202] [c0000000fe667710] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   14.633079] [c0000000fe667800] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   14.679956] [c0000000fe6678f0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   14.726833] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   14.773710] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[   14.819546] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   14.877361] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   14.920591] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   14.966426] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   15.007053] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   15.052885] Instruction dump:
[   15.070594] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   15.116950] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   15.164348] ---[ end trace 093b23e746659777 ]---
[   15.193877] irq: irq-108==>hwirq-0x66 mapping failed: -22
[   15.225769] ------------[ cut here ]------------
[   15.253363] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[   15.295550] Modules linked in:
[   15.313782] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[   15.355972] REGS: c0000000fe6670a0 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[   15.402326] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   15.449202] SOFTE: 1
[   15.462226] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667320 c000000000699cb0 000000000000002d 
GPR04: 0000000000000000 0000000090406ac4 0000000000000008 0000000000000000 
GPR08: 00000000904d5a9f 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 000000000000006d 
GPR24: 0000000000000198 0000000000000066 000000000000006c c0000001fe74c400 
GPR28: c0000001fe001000 000000000000006c c000000000643be0 0000000000000066 
[   15.828389] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[   15.869013] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[   15.909117] Call Trace:
[   15.923704] [c0000000fe667320] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   15.978914] [c0000000fe6673f0] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[   16.023187] [c0000000fe667490] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[   16.069022] [c0000000fe667540] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[   16.113814] [c0000000fe6675d0] [c000000000290df0] .of_irq_count+0x30/0x58
[   16.154441] [c0000000fe667660] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[   16.197673] [c0000000fe667760] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[   16.248196] [c0000000fe667800] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[   16.295072] [c0000000fe6678f0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   16.341949] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   16.388826] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[   16.434662] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   16.492476] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   16.535707] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   16.581542] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   16.622168] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   16.668000] Instruction dump:
[   16.685710] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   16.732066] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   16.779464] ---[ end trace 093b23e746659778 ]---
[   16.807242] irq: irq-110==>hwirq-0x6e mapping failed: -22
[   16.839373] ------------[ cut here ]------------
[   16.866968] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[   16.909155] Modules linked in:
[   16.927387] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[   16.969576] REGS: c0000000fe6670a0 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[   17.015931] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   17.062808] SOFTE: 1
[   17.075831] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667320 c000000000699cb0 000000000000002d 
GPR04: 0000000000000000 0000000092d124ca 0000000000000008 0000000000000000 
GPR08: 0000000092dddfc6 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 000000000000006f 
GPR24: 00000000000001b8 000000000000006e 000000000000006e c0000001fe74c400 
GPR28: c0000001fe001000 000000000000006e c000000000643be0 000000000000006e 
[   17.441994] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[   17.482619] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[   17.522722] Call Trace:
[   17.537310] [c0000000fe667320] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   17.592520] [c0000000fe6673f0] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[   17.636792] [c0000000fe667490] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[   17.682627] [c0000000fe667540] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[   17.727421] [c0000000fe6675d0] [c000000000290df0] .of_irq_count+0x30/0x58
[   17.768047] [c0000000fe667660] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[   17.811278] [c0000000fe667760] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[   17.861801] [c0000000fe667800] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[   17.908678] [c0000000fe6678f0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   17.955555] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   18.002431] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[   18.048268] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   18.106082] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   18.149312] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   18.195148] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   18.235775] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   18.281606] Instruction dump:
[   18.299315] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   18.345671] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   18.393070] ---[ end trace 093b23e746659779 ]---
[   18.420872] irq: irq-42==>hwirq-0x27 mapping failed: -22
[   18.452457] ------------[ cut here ]------------
[   18.480052] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
[   18.522241] Modules linked in:
[   18.540472] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
[   18.582662] REGS: c0000000fe6670a0 TRAP: 0700   Tainted: G        W     (3.8.6-aufs)
[   18.629016] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 84000024  XER: 00000000
[   18.675893] SOFTE: 1
[   18.688916] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
GPR00: c0000000000bdea8 c0000000fe667320 c000000000699cb0 000000000000002c 
GPR04: 0000000000000000 000000009561a9f3 0000000000000008 0000000000000000 
GPR08: 00000000956e2ec4 0000000000000000 0000000000000000 0000000000000000 
GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c0000001fe001018 000000000000002b 
GPR24: 000000000000009c 0000000000000027 000000000000002a c0000001fe74c500 
GPR28: c0000001fe001000 000000000000002a c000000000643be0 0000000000000027 
[   19.055078] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
[   19.095704] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
[   19.135807] Call Trace:
[   19.150394] [c0000000fe667320] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
[   19.205604] [c0000000fe6673f0] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
[   19.249876] [c0000000fe667490] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
[   19.295712] [c0000000fe667540] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
[   19.340505] [c0000000fe6675d0] [c000000000290df0] .of_irq_count+0x30/0x58
[   19.381131] [c0000000fe667660] [c00000000029182c] .of_device_alloc+0x1ec/0x288
[   19.424363] [c0000000fe667760] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
[   19.474886] [c0000000fe667800] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
[   19.521763] [c0000000fe6678f0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   19.568640] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
[   19.615516] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
[   19.661353] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
[   19.719167] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
[   19.762397] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
[   19.808233] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
[   19.848859] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
[   19.894691] Instruction dump:
[   19.912401] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
[   19.958756] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
[   20.006154] ---[ end trace 093b23e74665977a ]---
[   20.033998] iommu: missing iommu for <no-node> (node -1)
[   20.065580] iommu: missing iommu for <no-node> (node -1)
[   20.097448] axon_msi: setup MSIC on /axon@10000000000/plb5/msic@4000004400003000
[   20.097647] axon_msi: setup MSIC on /axon@30000000000/plb5/msic@4000004400003000
[   20.098925] bio: create slab <bio-0> at 0
[   20.122808] vgaarb: loaded
[   20.138920] Switching to clocksource timebase
[   20.171194] NET: Registered protocol family 2
[   20.197448] TCP established hash table entries: 65536 (order: 8, 1048576 bytes)
[   20.242041] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   20.284006] TCP: Hash tables configured (established 65536 bind 65536)
[   20.322737] TCP: reno registered
[   20.341968] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[   20.378547] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[   20.417767] PCI: CLS 0 bytes, default 128
[   20.417908] Unpacking initramfs...
[   20.998378] Freeing initrd memory: 9976k freed
[   21.026844] iommu: missing iommu for <no-node> (node -1)
[   21.058400] Setting up PCI bus /axon@10000000000/plb5/plb4/pcix@4000004600000000
[   21.102499] PCI host bridge /axon@10000000000/plb5/plb4/pcix@4000004600000000  ranges:
[   21.149865]   IO 0x0000014608000000..0x000001460800ffff -> 0x0000000000000000
[   21.192573]  MEM 0x0000014780000000..0x00000147bfffffff -> 0x0000000080000000 
[   21.235804]  MEM 0x00000147c0000000..0x00000147ffffffff -> 0x00000000c0000000 Prefetch
[   21.283303] of-pci 14600000000.pcix: PCI host bridge to bus 0000:00
[   21.320704] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
[   21.374351] pci_bus 0000:00: root bus resource [mem 0x14780000000-0x147bfffffff] (bus address [0x80000000-0xbfffffff])
[   21.438415] pci_bus 0000:00: root bus resource [mem 0x147c0000000-0x147ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   21.505081] pci_bus 0000:00: root bus resource [bus 00-ff]
[   21.537895] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
[   21.537995] pci 0000:00:01.0: [14e4:16a8] type 00 class 0x020000
[   21.538100] pci 0000:00:01.0: reg 10: [mem 0x14780000000-0x1478000ffff 64bit]
[   21.538535] pci 0000:00:01.0: PME# supported from D3hot D3cold
[   21.538676] pci 0000:00:01.1: [14e4:16a8] type 00 class 0x020000
[   21.538785] pci 0000:00:01.1: reg 10: [mem 0x14780010000-0x1478001ffff 64bit]
[   21.539213] pci 0000:00:01.1: PME# supported from D3hot D3cold
[   21.539379] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[   21.539606] Setting up PCI bus /axon@10000000000/plb5/pciex@a00000a000000000
[   21.581406] PCI host bridge /axon@10000000000/plb5/pciex@a00000a000000000  ranges:
[   21.626704]   IO 0x000001a100000000..0x000001a10000ffff -> 0x0000000000000000
[   21.669416]  MEM 0x000001c080000000..0x000001c0bfffffff -> 0x0000000080000000 
[   21.712642]  MEM 0x000001c0c0000000..0x000001c0ffffffff -> 0x00000000c0000000 Prefetch
[   21.760128] of-pci D18000002400.pciex: PCI host bridge to bus 0001:00
[   21.798585] pci_bus 0001:00: root bus resource [io  0x21000-0x30fff] (bus address [0x0000-0xffff])
[   21.852232] pci_bus 0001:00: root bus resource [mem 0x1c080000000-0x1c0bfffffff] (bus address [0x80000000-0xbfffffff])
[   21.916296] pci_bus 0001:00: root bus resource [mem 0x1c0c0000000-0x1c0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   21.982968] pci_bus 0001:00: root bus resource [bus 00-ff]
[   22.015778] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to ff
[   22.015874] pci 0001:00:00.0: [1014:032c] type 01 class 0x060400
[   22.015969] pci 0001:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   22.016023] pci 0001:00:00.0: reg 38: [mem 0x1c0ffff8000-0x1c0ffffffff pref]
[   22.016091] PCI: Hiding resources on Axon PCIE RC 0001:00:00.0
[   22.016322] pci 0001:00:00.0: supports D1 D2
[   22.016329] pci 0001:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.016469] irq: no irq domain found for /axon@10000000000/plb5/pciex-utl@a00000a000004000 !
[   22.066811] pci 0001:00:00.0: PCI bridge to [bus 01]
[   22.096348] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 01
[   22.096492] Setting up PCI bus /axon@10000000000/plb5/pciex@a00000a200000000
[   22.138454] PCI host bridge /axon@10000000000/plb5/pciex@a00000a200000000  ranges:
[   22.183757]   IO 0x000001a300000000..0x000001a30000ffff -> 0x0000000000000000
[   22.226467]  MEM 0x000001d080000000..0x000001d0bfffffff -> 0x0000000080000000 
[   22.269700]  MEM 0x000001d0c0000000..0x000001d0ffffffff -> 0x00000000c0000000 Prefetch
[   22.317183] of-pci D18000002800.pciex: PCI host bridge to bus 0002:00
[   22.355637] pci_bus 0002:00: root bus resource [io  0x32000-0x41fff] (bus address [0x0000-0xffff])
[   22.409286] pci_bus 0002:00: root bus resource [mem 0x1d080000000-0x1d0bfffffff] (bus address [0x80000000-0xbfffffff])
[   22.473351] pci_bus 0002:00: root bus resource [mem 0x1d0c0000000-0x1d0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   22.540019] pci_bus 0002:00: root bus resource [bus 00-ff]
[   22.572831] pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to ff
[   22.572925] pci 0002:00:00.0: [1014:032c] type 01 class 0x060400
[   22.573019] pci 0002:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   22.573072] pci 0002:00:00.0: reg 38: [mem 0x1d0ffff8000-0x1d0ffffffff pref]
[   22.573139] PCI: Hiding resources on Axon PCIE RC 0002:00:00.0
[   22.573370] pci 0002:00:00.0: supports D1 D2
[   22.573377] pci 0002:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.573513] irq: no irq domain found for /axon@10000000000/plb5/pciex-utl@a00000a200004000 !
[   22.623873] pci 0002:00:00.0: PCI bridge to [bus 01]
[   22.653403] pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to 01
[   22.653571] Setting up PCI bus /axon@30000000000/plb5/plb4/pcix@4000004600000000
[   22.697598] PCI host bridge /axon@30000000000/plb5/plb4/pcix@4000004600000000  ranges:
[   22.744978]   IO 0x0000034608000000..0x000003460800ffff -> 0x0000000000000000
[   22.787688]  MEM 0x0000034780000000..0x00000347bfffffff -> 0x0000000080000000 
[   22.830920]  MEM 0x00000347c0000000..0x00000347ffffffff -> 0x00000000c0000000 Prefetch
[   22.878412] of-pci 34600000000.pcix: PCI host bridge to bus 0003:00
[   22.915816] pci_bus 0003:00: root bus resource [io  0x43000-0x52fff] (bus address [0x0000-0xffff])
[   22.969462] pci_bus 0003:00: root bus resource [mem 0x34780000000-0x347bfffffff] (bus address [0x80000000-0xbfffffff])
[   23.033529] pci_bus 0003:00: root bus resource [mem 0x347c0000000-0x347ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   23.100200] pci_bus 0003:00: root bus resource [bus 00-ff]
[   23.133010] pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to ff
[   23.133069] pci 0003:00:01.0: [1033:0035] type 00 class 0x0c0310
[   23.133151] pci 0003:00:01.0: reg 10: [mem 0x34780000000-0x34780000fff]
[   23.133512] pci 0003:00:01.0: supports D1 D2
[   23.133520] pci 0003:00:01.0: PME# supported from D0 D1 D2 D3hot
[   23.133611] pci 0003:00:01.1: [1033:0035] type 00 class 0x0c0310
[   23.133691] pci 0003:00:01.1: reg 10: [mem 0x34780001000-0x34780001fff]
[   23.134068] pci 0003:00:01.1: supports D1 D2
[   23.134076] pci 0003:00:01.1: PME# supported from D0 D1 D2 D3hot
[   23.134167] pci 0003:00:01.2: [1033:00e0] type 00 class 0x0c0320
[   23.134247] pci 0003:00:01.2: reg 10: [mem 0x34780002000-0x347800020ff]
[   23.134605] pci 0003:00:01.2: supports D1 D2
[   23.134612] pci 0003:00:01.2: PME# supported from D0 D1 D2 D3hot
[   23.134776] pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to 00
[   23.236836] pci 0003:00:01.2: enabling device (0140 -> 0142)
[   23.270411] Setting up PCI bus /axon@30000000000/plb5/pciex@a00000a000000000
[   23.312464] PCI host bridge /axon@30000000000/plb5/pciex@a00000a000000000  ranges:
[   23.357765]   IO 0x000003a100000000..0x000003a10000ffff -> 0x0000000000000000
[   23.400470]  MEM 0x000003c080000000..0x000003c0bfffffff -> 0x0000000080000000 
[   23.443702]  MEM 0x000003c0c0000000..0x000003c0ffffffff -> 0x00000000c0000000 Prefetch
[   23.491188] of-pci D38000002400.pciex: PCI host bridge to bus 0004:00
[   23.529643] pci_bus 0004:00: root bus resource [io  0x54000-0x63fff] (bus address [0x0000-0xffff])
[   23.583289] pci_bus 0004:00: root bus resource [mem 0x3c080000000-0x3c0bfffffff] (bus address [0x80000000-0xbfffffff])
[   23.647356] pci_bus 0004:00: root bus resource [mem 0x3c0c0000000-0x3c0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   23.714024] pci_bus 0004:00: root bus resource [bus 00-ff]
[   23.746836] pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to ff
[   23.746935] pci 0004:00:00.0: [1014:032c] type 01 class 0x060400
[   23.747035] pci 0004:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   23.747093] pci 0004:00:00.0: reg 38: [mem 0x3c0ffff8000-0x3c0ffffffff pref]
[   23.747163] PCI: Hiding resources on Axon PCIE RC 0004:00:00.0
[   23.747409] pci 0004:00:00.0: supports D1 D2
[   23.747416] pci 0004:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   23.747563] irq: no irq domain found for /axon@30000000000/plb5/pciex-utl@a00000a000004000 !
[   23.797937] pci 0004:00:00.0: PCI bridge to [bus 01]
[   23.827465] pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to 01
[   23.827605] Setting up PCI bus /axon@30000000000/plb5/pciex@a00000a200000000
[   23.869564] PCI host bridge /axon@30000000000/plb5/pciex@a00000a200000000  ranges:
[   23.914870]   IO 0x000003a300000000..0x000003a30000ffff -> 0x0000000000000000
[   23.957576]  MEM 0x000003d080000000..0x000003d0bfffffff -> 0x0000000080000000 
[   24.000807]  MEM 0x000003d0c0000000..0x000003d0ffffffff -> 0x00000000c0000000 Prefetch
[   24.048303] of-pci D38000002800.pciex: PCI host bridge to bus 0005:00
[   24.086747] pci_bus 0005:00: root bus resource [io  0x65000-0x74fff] (bus address [0x0000-0xffff])
[   24.140395] pci_bus 0005:00: root bus resource [mem 0x3d080000000-0x3d0bfffffff] (bus address [0x80000000-0xbfffffff])
[   24.204462] pci_bus 0005:00: root bus resource [mem 0x3d0c0000000-0x3d0ffffffff pref] (bus address [0xc0000000-0xffffffff])
[   24.271129] pci_bus 0005:00: root bus resource [bus 00-ff]
[   24.303941] pci_bus 0005:00: busn_res: [bus 00-ff] end is updated to ff
[   24.304047] pci 0005:00:00.0: [1014:032c] type 01 class 0x060400
[   24.304146] pci 0005:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
[   24.304203] pci 0005:00:00.0: reg 38: [mem 0x3d0ffff8000-0x3d0ffffffff pref]
[   24.304272] PCI: Hiding resources on Axon PCIE RC 0005:00:00.0
[   24.304517] pci 0005:00:00.0: supports D1 D2
[   24.304524] pci 0005:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   24.304664] irq: no irq domain found for /axon@30000000000/plb5/pciex-utl@a00000a200004000 !
[   24.355200] pci 0005:01:00.0: [15b3:634a] type 00 class 0x0c0600
[   24.355378] pci 0005:01:00.0: reg 10: [mem 0x3d080000000-0x3d0800fffff 64bit]
[   24.355524] pci 0005:01:00.0: reg 18: [mem 0x3d0c0000000-0x3d0c1ffffff 64bit pref]
[   24.356526] pci 0005:00:00.0: PCI bridge to [bus 01]
[   24.385809] pci 0005:00:00.0:   bridge window [mem 0x3d080000000-0x3d0800fffff]
[   24.385844] pci 0005:00:00.0:   bridge window [mem 0x3d0c0000000-0x3d0c1ffffff 64bit pref]
[   24.385934] pci_bus 0005:00: busn_res: [bus 00-ff] end is updated to 01
[   24.386274] iommu: missing iommu for <no-node> (node -1)
[   24.423030] iommu: missing iommu for <no-node> (node -1)
[   24.463050] msgmni has been set to 15888
[   24.500072] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[   24.543980] io scheduler noop registered
[   24.567417] io scheduler deadline registered
[   24.593225] io scheduler cfq registered (default)
[   24.664957] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   24.702646] iommu: missing iommu for <no-node> (node -1)
[   24.756219] serial8250.0: ttyS0 at MMIO 0x14540000200 (irq = 16) is a U6_16550A
[   24.799650] console [ttyS0] enabled, bootconsole disabled
[   24.885615] serial8250.0: ttyS1 at MMIO 0x14540000300 (irq = 17) is a U6_16550A
[   24.950843] serial8250.0: ttyS2 at MMIO 0x34540000200 (irq = 18) is a U6_16550A
[   25.016425] serial8250.0: ttyS3 at MMIO 0x34540000300 (irq = 19) is a U6_16550A
[   25.061120] mousedev: PS/2 mouse device common for all mice
[   25.094572] cpuidle: using governor ladder
[   25.119166] cpuidle: using governor menu
[   25.143019] TCP: cubic registered
[   25.162962] Key type dns_resolver registered
[   25.191007] /usr/src/linux-3.8.6-aufs/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   25.246286] Freeing unused kernel memory: 2072k freed
[   25.598515] dracut: dracut-027-ebfd8cd
[   25.870831] RPC: Registered named UNIX socket transport module.
[   25.906410] RPC: Registered udp transport module.
[   25.934647] RPC: Registered tcp transport module.
[   25.962878] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   26.060180] NET: Registered protocol family 1
[   26.128272] NET: Registered protocol family 10
[   26.288658] systemd-udevd[143]: starting version 200
[   26.565854] pps_core: LinuxPPS API ver. 1 registered
[   26.595737] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   26.657618] PTP clock support registered
[   26.720952] tg3.c:v3.128 (December 03, 2012)
[   26.746875] tg3 0000:00:01.0: enabling device (0140 -> 0142)
[   26.812886] tg3 0000:00:01.0 eth0: Tigon3 [partno(none) rev 2100] (PCIX:100MHz:64-bit) MAC address 00:1a:64:b8:08:18
[   26.876142] tg3 0000:00:01.0 eth0: attached PHY is serdes (1000Base-SX Ethernet) (WireSpeed[0], EEE[0])
[   26.932674] tg3 0000:00:01.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[0]
[   26.942744] usbcore: registered new interface driver usbfs
[   26.942899] usbcore: registered new interface driver hub
[   27.044642] tg3 0000:00:01.0 eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
[   27.085684] usbcore: registered new device driver usb
[   27.101276] tg3 0000:00:01.1: enabling device (0140 -> 0142)
[   27.110440] tg3 0000:00:01.1 eth1: Tigon3 [partno(none) rev 2100] (PCIX:100MHz:64-bit) MAC address 00:1a:64:b8:08:19
[   27.110454] tg3 0000:00:01.1 eth1: attached PHY is serdes (1000Base-SX Ethernet) (WireSpeed[0], EEE[0])
[   27.110467] tg3 0000:00:01.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   27.110479] tg3 0000:00:01.1 eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
[   27.371083] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   27.413388] ehci-pci: EHCI PCI platform driver
[   27.444298] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   27.483890] ehci-pci 0003:00:01.2: EHCI Host Controller
[   27.515594] ehci-pci 0003:00:01.2: new USB bus registered, assigned bus number 1
[   27.561329] ehci-pci 0003:00:01.2: irq 21, io mem 0x34780002000
[   27.602979] ehci-pci 0003:00:01.2: USB 2.0 started, EHCI 1.00
[   27.639547] hub 1-0:1.0: USB hub found
[   27.662086] hub 1-0:1.0: 5 ports detected
[   27.687335] ohci_hcd 0003:00:01.0: OHCI Host Controller
[   27.718695] ohci_hcd 0003:00:01.0: new USB bus registered, assigned bus number 2
[   27.763128] ohci_hcd 0003:00:01.0: irq 21, io mem 0x34780000000
[   27.879080] hub 2-0:1.0: USB hub found
[   27.901608] hub 2-0:1.0: 3 ports detected
[   27.926261] ohci_hcd 0003:00:01.1: OHCI Host Controller
[   27.957619] ohci_hcd 0003:00:01.1: new USB bus registered, assigned bus number 3
[   27.957668] ohci_hcd 0003:00:01.1: irq 21, io mem 0x34780001000
[   28.037674] hub 3-0:1.0: USB hub found
[   28.037699] hub 3-0:1.0: 2 ports detected
[   28.932303] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   28.995421] NET: Registered protocol family 17
[   29.935487] tg3 0000:00:01.0 eth0: Link is up at 1000 Mbps, full duplex
[   29.975345] tg3 0000:00:01.0 eth0: Flow control is on for TX and on for RX
[   30.017138] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   33.536157] FS-Cache: Loaded
[   33.579120] FS-Cache: Netfs 'nfs' registered for caching
[   33.644356] NFS: Registering the id_resolver key type
[   33.674914] Key type id_resolver registered
[   33.700043] Key type id_legacy registered
[   34.603362] dracut: Mounted root filesystem 192.168.100.1:/export/gentoo/root-ppc64
[   35.043969] dracut: Switching root
[   36.916516] systemd-udevd[375]: starting version 200
[   37.676340] systemd-udevd[387]: renamed network interface eth1 to enp0s1f1
[   37.906905] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[   37.980118] mlx4_core: Mellanox ConnectX core driver v1.1 (Dec, 2011)
[   37.980232] mlx4_core: Initializing 0005:01:00.0
[   37.980484] mlx4_core 0005:01:00.0: enabling device (0140 -> 0142)
[   43.360940] mlx4_core 0005:01:00.0: command 0xc failed: fw status = 0x40
[   43.361874] mlx4_core 0005:01:00.0: command 0xc failed: fw status = 0x40
[   45.330025] <mlx4_ib> mlx4_ib_add: mlx4_ib: Mellanox ConnectX InfiniBand driver v1.0 (April 4, 2008)
[   54.036776] mlx4_core 0005:01:00.0: command 0x5a failed: fw status = 0x2

--nextPart1440802.k9IquNnYL2--

--nextPart4668238.xTe0nm3jXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlF2gn4ACgkQjqfyF1DtJW5GIwCfR3XVRR1q8M4aRuib7YhbRHMt
kY8AoIcJBPlcbQ3NaBiBW0W1+LeL5c+H
=XWci
-----END PGP SIGNATURE-----

--nextPart4668238.xTe0nm3jXk--
