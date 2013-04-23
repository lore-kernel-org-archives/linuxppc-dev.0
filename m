Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Apr 2013 23:02:19 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Dennis Schridde <devurandom@gmx.net>
Subject: Re: [PATCH] powerpc/cell: Only iterate over online nodes in
 cbe_init_pm_irq()
Message-ID: <20130423130218.GD27200@concordia>
References: <1366719291-29414-1-git-send-email-michael@ellerman.id.au>
 <2343936.gRCKd0qRgh@ernie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2343936.gRCKd0qRgh@ernie>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 23, 2013 at 02:45:50PM +0200, Dennis Schridde wrote:
> Hello everyone!
> 
> I have been testing this patch (given to me by Grant Likely 
> <grant.likely@secretlab.ca>) with various kernel versions (3.6.2, 3.6.11, 
> 3.8.6, 3.8.8) since November and can confirm that it solves part of the IRQ 
> mapping issue on Cell (namely the one Michael mentioned) and does not cause 
> any additional noticable problems.
> 
> Some problems remain after this patch, as can be seen in the attached 
> dmesg.log. If further information is required to debug this, or you need some 
> help in testing more patches, please contact me.

..

This one below I really don't understand.

It's saying that the domain->ops->map() returned -22.

But as far as I can see all the map routines we have on cell return
success unconditionally. So something strange is going on. I'll have to
dig into a bit more.

> [    0.490734] irq: irq-93==>hwirq-0x5d mapping failed: -22
> [    0.522130] ------------[ cut here ]------------
> [    0.549706] WARNING: at /usr/src/linux-3.8.6-aufs/kernel/irq/irqdomain.c:467
> [    0.591895] Modules linked in:
> [    0.610126] NIP: c0000000000bdeac LR: c0000000000bdea8 CTR: c000000000025670
> [    0.652317] REGS: c0000000fe667190 TRAP: 0700   Not tainted  (3.8.6-aufs)
> [    0.692940] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 44000024  XER: 00000000
> [    0.739817] SOFTE: 1
> [    0.752840] TASK = c0000000fe668000[1] 'swapper/0' THREAD: c0000000fe664000 CPU: 0
> GPR00: c0000000000bdea8 c0000000fe667410 c000000000699cb0 000000000000002c 
> GPR04: 0000000000000000 0000000078e26d37 0000000000000008 0000000000000000 
> GPR08: 0000000078eef1c4 0000000000000000 0000000000000000 0000000000000000 
> GPR12: d000070000000000 c00000000fffb000 c00000000000a460 0000000000000000 
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR20: 0000000000000000 0000000000000000 c0000000fe006078 000000000000005e 
> GPR24: 0000000000000174 000000000000005d 000000000000005d c0000000fe65fc00 
> GPR28: c0000000fe006060 000000000000005d c000000000643be0 000000000000005d 
> [    1.119009] NIP [c0000000000bdeac] .irq_domain_associate_many+0x264/0x290
> [    1.159628] LR [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290
> [    1.199731] Call Trace:
> [    1.214318] [c0000000fe667410] [c0000000000bdea8] .irq_domain_associate_many+0x260/0x290 (unreliable)
> [    1.269528] [c0000000fe6674e0] [c0000000000be928] .irq_create_mapping+0xc8/0x1d0
> [    1.313801] [c0000000fe667580] [c0000000000bead8] .irq_create_of_mapping+0xa8/0x170
> [    1.359639] [c0000000fe667630] [c000000000290c30] .irq_of_parse_and_map+0x40/0x58
> [    1.404429] [c0000000fe6676c0] [c000000000290df0] .of_irq_count+0x30/0x58
> [    1.445057] [c0000000fe667750] [c00000000029182c] .of_device_alloc+0x1ec/0x288
> [    1.488287] [c0000000fe667850] [c00000000029191c] .of_platform_device_create_pdata+0x54/0xf8
> [    1.538810] [c0000000fe6678f0] [c000000000291b04] .of_platform_bus_create+0x144/0x1e0
> [    1.585687] [c0000000fe6679e0] [c000000000291b60] .of_platform_bus_create+0x1a0/0x1e0
> [    1.632564] [c0000000fe667ad0] [c000000000291d50] .of_platform_bus_probe+0xd0/0x140
> [    1.678404] [c0000000fe667b70] [c0000000004109e4] .__machine_initcall_cell_cell_publish_devices+0x54/0x1b0
> [    1.736219] [c0000000fe667c40] [c000000000009e70] .do_one_initcall+0x168/0x1d0
> [    1.779445] [c0000000fe667d00] [c0000000003ffb6c] .kernel_init_freeable+0x14c/0x21c
> [    1.825281] [c0000000fe667db0] [c00000000000a47c] .kernel_init+0x1c/0x108
> [    1.865907] [c0000000fe667e30] [c000000000008cd8] .ret_from_kernel_thread+0x64/0x8c
> [    1.911738] Instruction dump:
> [    1.929448] 7fa4eb78 7ca507b4 4828c965 60000000 0fe00000 3860ffea 4bffff80 e87e8020 
> [    1.975803] 7fa4eb78 7fe5fb78 4828c945 60000000 <0fe00000> 39200000 7f83e378 7f44d378 
> [    2.023213] ---[ end trace 093b23e74665976f ]---

...

> [   23.270411] Setting up PCI bus /axon@30000000000/plb5/pciex@a00000a000000000
> [   23.312464] PCI host bridge /axon@30000000000/plb5/pciex@a00000a000000000  ranges:
> [   23.357765]   IO 0x000003a100000000..0x000003a10000ffff -> 0x0000000000000000
> [   23.400470]  MEM 0x000003c080000000..0x000003c0bfffffff -> 0x0000000080000000 
> [   23.443702]  MEM 0x000003c0c0000000..0x000003c0ffffffff -> 0x00000000c0000000 Prefetch
> [   23.491188] of-pci D38000002400.pciex: PCI host bridge to bus 0004:00
> [   23.529643] pci_bus 0004:00: root bus resource [io  0x54000-0x63fff] (bus address [0x0000-0xffff])
> [   23.583289] pci_bus 0004:00: root bus resource [mem 0x3c080000000-0x3c0bfffffff] (bus address [0x80000000-0xbfffffff])
> [   23.647356] pci_bus 0004:00: root bus resource [mem 0x3c0c0000000-0x3c0ffffffff pref] (bus address [0xc0000000-0xffffffff])
> [   23.714024] pci_bus 0004:00: root bus resource [bus 00-ff]
> [   23.746836] pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to ff
> [   23.746935] pci 0004:00:00.0: [1014:032c] type 01 class 0x060400
> [   23.747035] pci 0004:00:00.0: reg 10: [mem 0x00000000-0x7fffffff 64bit pref]
> [   23.747093] pci 0004:00:00.0: reg 38: [mem 0x3c0ffff8000-0x3c0ffffffff pref]
> [   23.747163] PCI: Hiding resources on Axon PCIE RC 0004:00:00.0
> [   23.747409] pci 0004:00:00.0: supports D1 D2
> [   23.747416] pci 0004:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   23.747563] irq: no irq domain found for /axon@30000000000/plb5/pciex-utl@a00000a000004000 !

This is probably not good, but I'll have to compare to an old kernel to
be sure. Have you noticed that PCI is broken in any way?

> [   24.386274] iommu: missing iommu for <no-node> (node -1)
> [   24.423030] iommu: missing iommu for <no-node> (node -1)

This is probably bad but I'll have to dig to be sure.


cheers
