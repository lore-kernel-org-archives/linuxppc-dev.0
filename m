Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 605EAB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 09:40:01 +1000 (EST)
Subject: Re: device not available because of BAR 0 collisions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <4DB6CAD0.5030102@harris.com>
References: <4DB5D548.7020303@harris.com>
	<1303776114.2513.152.camel@pasglop>  <4DB6CAD0.5030102@harris.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 27 Apr 2011 09:39:38 +1000
Message-ID: <1303861178.2513.171.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-04-26 at 09:38 -0400, Steven A. Falco wrote:
> On 04/25/2011 08:01 PM, Benjamin Herrenschmidt wrote:
> > On Mon, 2011-04-25 at 16:10 -0400, Steven A. Falco wrote:
> >> I'm getting an error message when trying to talk to some custom
> >> hardware:
> >>
> >> dx83xx 0001:43:00.0: device not available because of BAR 0
> >> [0xa1000000-0xa1ffffff] collisions
> >>
> >> I see in setup-res.c that this message comes out when there is no
> >> parent for
> >> a device resource.
> > 
> >  .../...
> > 
> > It mostly happens in arch/powerpc/kernel/pci-common.c and the generic
> > setup-res.c
> > 
> > Try #define DEBUG at the top (before the #includes) of pci-common.c and
> > pci_32.c (remove the exiting #undef in the last one) and send us the
> > full dmesg log, along with the output of cat /proc/iomem

Have you set any specific flags ? IE. Modified the value of
ppc_pci_flags from what the 4xx code sets originally ?

It does look to me like some of your device BARs have been setup already
by the firmware in a way that conflict with the way you configure your
ranges, and the kernel doesn't appear to detect nor try to remap that
which would happen if you have the "probe only" flag set.

IE. On your c0000000 bus, you have memory at 90000000 CPU space mapped
to 80000000 PCI space. However, when probing, the kernel finds:

pci 0001:41:00.0: reg 10 32bit mmio: [0x90000000-0x9001ffff]

IE. A BAR was already set with a value of 90000000 PCI-side which is out
of the bounds you have for your bus.

Maybe you really want to configure that second bus to have CPU 90000000
mapped to 90000000 PCI-side ? (IE. a 1:1 mapping). That would be
something to fix in your "ranges" property.

Cheers,
Ben.

> > Cheers,
> > Ben.
> > 
> > 
> > 
> 
> Thanks for the help!
> 
> PCIe 0 has an FPGA connected - it is behaving as expected.  PCIe 1 has the
> PLX PCIe switch followed by a pair of ASICs - they are the ones generating
> the error.
> 
> Here is /proc/iomem:
> 
> 90000000-9fffffff : /plb/pciex@0c0000000
>   90000000-93ffffff : PCI Bus 0001:41
>     90000000-93ffffff : PCI Bus 0001:42
>       90000000-91ffffff : PCI Bus 0001:43
>       92000000-93ffffff : PCI Bus 0001:44
>   94000000-940fffff : PCI Bus 0001:41
>     94000000-9401ffff : 0001:41:00.0
> e0000000-e7ffffff : /plb/pciex@0a0000000
>   e0000000-e5ffffff : PCI Bus 0000:01
>     e0000000-e3ffffff : 0000:01:00.0
>     e4000000-e40fffff : 0000:01:00.0
>     e4100000-e41fffff : 0000:01:00.0
> ef600200-ef600207 : serial
> ef600300-ef600307 : serial
> ef600600-ef600606 : spi_ppc4xx_of
> ef6c0000-ef6cffff : dwc_otg.0
>   ef6c0000-ef6cffff : dwc_otg
> fc000000-ffffffff : fc000000.nor_flash
> 
> And here is dmesg, captured after the failed modprobe, so you can see
> those error messages (DEBUG enabled in pci-common.c and pci_32.c):
> 
> Using Flex-AM machine description
> Linux version 2.6.30.3-00063-g0af2edc-dirty (sfalco@hw1.cs.myharris.net) (gcc version 4.2.2) #35 Tue Apr 26 09:20:23 EDT 2011
> Found initrd at 0xcfba0000:0xcfea1872
> Found legacy serial port 0 for /plb/opb/serial@ef600200
>   mem=ef600200, taddr=ef600200, irq=0, clk=33333333, speed=0
> Found legacy serial port 1 for /plb/opb/serial@ef600300
>   mem=ef600300, taddr=ef600300, irq=0, clk=33333333, speed=0
> Top of RAM: 0x10000000, Total RAM: 0x10000000
> Memory hole size: 0MB
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00010000
>   Normal   0x00010000 -> 0x00010000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00000000 -> 0x00010000
> On node 0 totalpages: 65536
> free_area_init_node: node 0, pgdat c0406bdc, node_mem_map c0443000
>   DMA zone: 512 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 65024 pages, LIFO batch:15
> MMU: Allocated 1088 bytes of context maps for 255 contexts
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line: root=/dev/sda2 rw ip=137.237.178.150:137.237.178.9:137.237.178.1:255.255.255.0:flx-am:eth0:off panic=1 console=ttyS1,115200 debug
> NR_IRQS:512
> UIC0 (32 IRQ sources) at DCR 0xc0
> UIC1 (32 IRQ sources) at DCR 0xd0
> irq: irq 30 on host /interrupt-controller mapped to virtual irq 30
> UIC2 (32 IRQ sources) at DCR 0xe0
> irq: irq 28 on host /interrupt-controller mapped to virtual irq 28
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> time_init: decrementer frequency = 400.000000 MHz
> time_init: processor frequency   = 400.000000 MHz
> clocksource: timebase mult[a00000] shift[22] registered
> clockevent: decrementer mult[6666] shift[16] cpu[0]
> I-pipe 2.7-02: pipeline enabled.
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 252092k/262144k available (3944k kernel code, 9744k reserved, 184k data, 204k bss, 164k init)
> Kernel virtual memory layout:
>   * 0xffffe000..0xfffff000  : fixmap
>   * 0xfde00000..0xfe000000  : consistent mem
>   * 0xfde00000..0xfde00000  : early ioremap
>   * 0xd1000000..0xfde00000  : vmalloc & ioremap
> SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Calibrating delay loop... 798.72 BogoMIPS (lpj=1597440)
> Mount-cache hash table entries: 512
> net_namespace: 520 bytes
> NET: Registered protocol family 16
> PCIE0: Checking link...
> PCIE0: Device detected, waiting for link...
> PCIE0: link is up !
> PCI host bridge /plb/pciex@0a0000000 (primary) ranges:
>  MEM 0x00000000e0000000..0x00000000e7ffffff -> 0x0000000080000000
>   IO 0x00000000e8000000..0x00000000e800ffff -> 0x0000000000000000
> 4xx PCI DMA offset set to 0x00000000
> PCIE0: successfully set as root-complex
> PCIE1: Checking link...
> PCIE1: Device detected, waiting for link...
> PCIE1: link is up !
> PCI host bridge /plb/pciex@0c0000000 (primary) ranges:
>  MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000080000000
>   IO 0x00000000e8010000..0x00000000e801ffff -> 0x0000000000000000
> 4xx PCI DMA offset set to 0x00000000
> PCIE1: successfully set as root-complex
> PCI: Probing PCI hardware
> PCI: Scanning PHB /plb/pciex@0a0000000
> PCI: PHB IO resource    = 00000000fffe0000-00000000fffeffff [100]
> PCI: PHB MEM resource 0 = 00000000e0000000-00000000e7ffffff [200]
> PCI: PHB MEM offset     = 0000000060000000
> PCI: PHB IO  offset     = fffe0000
> pci 0000:00:00.0: reg 10 32bit mmio: [0x000000-0x7fffffff]
> PCI:0000:00:00.0 Resource 0 0000000000000000-000000007fffffff [21208] is unassigned
> PCI: Hiding 4xx host bridge resources 0000:00:00.0
> PCI: Fixup bus devices 0 (PHB)
> pci_busdev_to_OF_node(0,0x0)
>  parent is /plb/pciex@0a0000000
>  result is <NULL>
> PCI: Try to map irq for 0000:00:00.0...
> pci_busdev_to_OF_node(0,0x0)
>  parent is /plb/pciex@0a0000000
>  result is <NULL>
> pci 0000:01:00.0: reg 10 32bit mmio: [0x80000000-0x800fffff]
> pci 0000:01:00.0: reg 14 32bit mmio: [0x80100000-0x801fffff]
> pci 0000:01:00.0: reg 18 32bit mmio: [0x84000000-0x87ffffff]
> PCI:0000:01:00.0 Resource 0 0000000080000000-00000000800fffff [20200] fixup...
> PCI:0000:01:00.0            00000000e0000000-00000000e00fffff
> PCI:0000:01:00.0 Resource 1 0000000080100000-00000000801fffff [20200] fixup...
> PCI:0000:01:00.0            00000000e0100000-00000000e01fffff
> PCI:0000:01:00.0 Resource 2 0000000084000000-0000000087ffffff [20200] fixup...
> PCI:0000:01:00.0            00000000e4000000-00000000e7ffffff
> pci 0000:00:00.0: bridge io port: [0x00-0xfff]
> pci 0000:00:00.0: bridge 32bit mmio: [0x80000000-0x87ffffff]
> PCI:0000:00:00.0 Bus rsrc 0 0000000000000000-0000000000000fff [101] fixup...
> PCI:0000:00:00.0            00000000fffe0000-00000000fffe0fff
> PCI:0000:00:00.0 Bus rsrc 1 0000000080000000-0000000087ffffff [200] fixup...
> PCI:0000:00:00.0            00000000e0000000-00000000e7ffffff
> PCI: Fixup bus devices 1 (0000:00:00.0)
> pci_busdev_to_OF_node(1,0x0)
> PCI: Try to map irq for 0000:01:00.0...
> pci_busdev_to_OF_node(1,0x0)
> pci_busdev_to_OF_node(0,0x0)
>  parent is /plb/pciex@0a0000000
>  result is <NULL>
>  Got one, spec 2 cells (0x00000000 0x00000004...) on /interrupt-controller2
> irq: irq 0 on host /interrupt-controller2 mapped to virtual irq 16
>  Mapped to linux irq 16
> PCI: Scanning PHB /plb/pciex@0c0000000
> PCI: PHB IO resource    = 0000000000000000-000000000000ffff [100]
> PCI: PHB MEM resource 0 = 0000000090000000-000000009fffffff [200]
> PCI: PHB MEM offset     = 0000000010000000
> PCI: PHB IO  offset     = 00000000
> pci 0001:40:00.0: reg 10 32bit mmio: [0x000000-0x7fffffff]
> PCI:0001:40:00.0 Resource 0 0000000000000000-000000007fffffff [21208] is unassigned
> PCI: Hiding 4xx host bridge resources 0001:40:00.0
> PCI: Fixup bus devices 64 (PHB)
> pci_busdev_to_OF_node(64,0x0)
>  parent is /plb/pciex@0c0000000
>  result is <NULL>
> PCI: Try to map irq for 0001:40:00.0...
> pci_busdev_to_OF_node(64,0x0)
>  parent is /plb/pciex@0c0000000
>  result is <NULL>
> pci 0001:41:00.0: reg 10 32bit mmio: [0x90000000-0x9001ffff]
> PCI:0001:41:00.0 Resource 0 0000000090000000-000000009001ffff [20200] fixup...
> PCI:0001:41:00.0            00000000a0000000-00000000a001ffff
> pci 0001:41:00.0: PME# supported from D0 D3hot D3cold
> pci 0001:41:00.0: PME# disabled
> pci 0001:40:00.0: bridge io port: [0x00-0xfff]
> pci 0001:40:00.0: bridge 32bit mmio: [0x90000000-0x94ffffff]
> PCI:0001:40:00.0 Bus rsrc 0 0000000000000000-0000000000000fff [101] fixup...
> PCI:0001:40:00.0            0000000000000000-0000000000000fff
> PCI:0001:40:00.0 Bus rsrc 1 0000000090000000-0000000094ffffff [200] fixup...
> PCI:0001:40:00.0            00000000a0000000-00000000a4ffffff
> PCI: Fixup bus devices 65 (0001:40:00.0)
> pci_busdev_to_OF_node(65,0x0)
> PCI: Try to map irq for 0001:41:00.0...
> pci_busdev_to_OF_node(65,0x0)
> pci_busdev_to_OF_node(64,0x0)
>  parent is /plb/pciex@0c0000000
>  result is <NULL>
>  Got one, spec 2 cells (0x0000000b 0x00000004...) on /interrupt-controller2
> irq: irq 11 on host /interrupt-controller2 mapped to virtual irq 17
>  Mapped to linux irq 17
> pci 0001:42:01.0: PME# supported from D0 D3hot D3cold
> pci 0001:42:01.0: PME# disabled
> pci 0001:42:02.0: PME# supported from D0 D3hot D3cold
> pci 0001:42:02.0: PME# disabled
> pci 0001:41:00.0: bridge 32bit mmio: [0x90100000-0x94ffffff]
> PCI:0001:41:00.0 Bus rsrc 1 0000000090100000-0000000094ffffff [200] fixup...
> PCI:0001:41:00.0            00000000a0100000-00000000a4ffffff
> PCI: Fixup bus devices 66 (0001:41:00.0)
> pci_busdev_to_OF_node(66,0x8)
> PCI: Try to map irq for 0001:42:01.0...
> pci_busdev_to_OF_node(66,0x8)
> pci_busdev_to_OF_node(65,0x0)
> pci_busdev_to_OF_node(64,0x0)
>  parent is /plb/pciex@0c0000000
>  result is <NULL>
>  Got one, spec 2 cells (0x0000000c 0x00000004...) on /interrupt-controller2
> irq: irq 12 on host /interrupt-controller2 mapped to virtual irq 18
>  Mapped to linux irq 18
> pci_busdev_to_OF_node(66,0x10)
> PCI: Try to map irq for 0001:42:02.0...
> pci_busdev_to_OF_node(66,0x10)
> pci_busdev_to_OF_node(65,0x0)
> pci_busdev_to_OF_node(64,0x0)
>  parent is /plb/pciex@0c0000000
>  result is <NULL>
>  Got one, spec 2 cells (0x0000000d 0x00000004...) on /interrupt-controller2
> irq: irq 13 on host /interrupt-controller2 mapped to virtual irq 19
>  Mapped to linux irq 19
> pci 0001:43:00.0: reg 10 32bit mmio: [0x91000000-0x91ffffff]
> pci 0001:43:00.0: reg 14 32bit mmio: [0x92000000-0x92ffffff]
> PCI:0001:43:00.0 Resource 0 0000000091000000-0000000091ffffff [21208] fixup...
> PCI:0001:43:00.0            00000000a1000000-00000000a1ffffff
> PCI:0001:43:00.0 Resource 1 0000000092000000-0000000092ffffff [21208] fixup...
> PCI:0001:43:00.0            00000000a2000000-00000000a2ffffff
> pci 0001:42:01.0: bridge 32bit mmio: [0x90100000-0x92ffffff]
> PCI:0001:42:01.0 Bus rsrc 1 0000000090100000-0000000092ffffff [200] fixup...
> PCI:0001:42:01.0            00000000a0100000-00000000a2ffffff
> PCI: Fixup bus devices 67 (0001:42:01.0)
> pci_busdev_to_OF_node(67,0x0)
> PCI: Try to map irq for 0001:43:00.0...
> pci_busdev_to_OF_node(67,0x0)
> pci_busdev_to_OF_node(66,0x8)
> pci_busdev_to_OF_node(65,0x0)
> pci_busdev_to_OF_node(64,0x0)
>  parent is /plb/pciex@0c0000000
>  result is <NULL>
>  Got one, spec 2 cells (0x0000000c 0x00000004...) on /interrupt-controller2
>  Mapped to linux irq 18
> pci 0001:44:00.0: reg 10 32bit mmio: [0x93000000-0x93ffffff]
> pci 0001:44:00.0: reg 14 32bit mmio: [0x94000000-0x94ffffff]
> PCI:0001:44:00.0 Resource 0 0000000093000000-0000000093ffffff [21208] fixup...
> PCI:0001:44:00.0            00000000a3000000-00000000a3ffffff
> PCI:0001:44:00.0 Resource 1 0000000094000000-0000000094ffffff [21208] fixup...
> PCI:0001:44:00.0            00000000a4000000-00000000a4ffffff
> pci 0001:42:02.0: bridge 32bit mmio: [0x93000000-0x94ffffff]
> PCI:0001:42:02.0 Bus rsrc 1 0000000093000000-0000000094ffffff [200] fixup...
> PCI:0001:42:02.0            00000000a3000000-00000000a4ffffff
> PCI: Fixup bus devices 68 (0001:42:02.0)
> pci_busdev_to_OF_node(68,0x0)
> PCI: Try to map irq for 0001:44:00.0...
> pci_busdev_to_OF_node(68,0x0)
> pci_busdev_to_OF_node(66,0x10)
> pci_busdev_to_OF_node(65,0x0)
> pci_busdev_to_OF_node(64,0x0)
>  parent is /plb/pciex@0c0000000
>  result is <NULL>
>  Got one, spec 2 cells (0x0000000d 0x00000004...) on /interrupt-controller2
>  Mapped to linux irq 19
> PCI: Allocating bus resources for 0000:00...
> PCI: PHB (bus 0) bridge rsrc 0: 00000000fffe0000-00000000fffeffff [0x100], parent c03de440 (PCI IO)
> PCI: PHB (bus 0) bridge rsrc 1: 00000000e0000000-00000000e7ffffff [0x200], parent c03de424 (PCI mem)
> PCI: Allocating bus resources for 0000:01...
> PCI: Allocating bus resources for 0001:40...
> PCI: PHB (bus 64) bridge rsrc 0: 0000000000000000-000000000000ffff [0x100], parent c03de440 (PCI IO)
> PCI: PHB (bus 64) bridge rsrc 1: 0000000090000000-000000009fffffff [0x200], parent c03de424 (PCI mem)
> PCI: Allocating bus resources for 0001:41...
> PCI: Allocating bus resources for 0001:42...
> PCI: Allocating bus resources for 0001:43...
> PCI: Allocating bus resources for 0001:44...
> Reserving legacy ranges for domain 0000
> Candidate legacy IO: [0xfffe0000-0xfffe0fff]
> hose mem offset: 0000000060000000
> hose mem res: [0xe0000000-0xe7ffffff]
> Reserving legacy ranges for domain 0001
> Candidate legacy IO: [0x00-0xfff]
> hose mem offset: 0000000010000000
> hose mem res: [0x90000000-0x9fffffff]
> PCI: Assigning unassigned resources...
> pci 0000:00:00.0: PCI bridge, secondary bus 0000:01
> pci 0000:00:00.0:   IO window: disabled
> pci 0000:00:00.0:   MEM window: 0x80000000-0x85ffffff
> pci 0000:00:00.0:   PREFETCH window: disabled
> pci 0001:42:01.0: PCI bridge, secondary bus 0001:43
> pci 0001:42:01.0:   IO window: disabled
> pci 0001:42:01.0:   MEM window: disabled
> pci 0001:42:01.0:   PREFETCH window: 0x00000080000000-0x00000081ffffff
> pci 0001:42:02.0: PCI bridge, secondary bus 0001:44
> pci 0001:42:02.0:   IO window: disabled
> pci 0001:42:02.0:   MEM window: disabled
> pci 0001:42:02.0:   PREFETCH window: 0x00000082000000-0x00000083ffffff
> pci 0001:41:00.0: PCI bridge, secondary bus 0001:42
> pci 0001:41:00.0:   IO window: disabled
> pci 0001:41:00.0:   MEM window: disabled
> pci 0001:41:00.0:   PREFETCH window: 0x00000080000000-0x00000083ffffff
> pci 0001:40:00.0: PCI bridge, secondary bus 0001:41
> pci 0001:40:00.0:   IO window: disabled
> pci 0001:40:00.0:   MEM window: 0x84000000-0x840fffff
> pci 0001:40:00.0:   PREFETCH window: 0x00000080000000-0x00000083ffffff
> pci_bus 0000:00: resource 0 io:  [0xfffe0000-0xfffeffff]
> pci_bus 0000:00: resource 1 mem: [0xe0000000-0xe7ffffff]
> pci_bus 0000:01: resource 0 mem: [0xfffe0000-0xfffe0fff]
> pci_bus 0000:01: resource 1 mem: [0xe0000000-0xe5ffffff]
> pci_bus 0001:40: resource 0 io:  [0x00-0xffff]
> pci_bus 0001:40: resource 1 mem: [0x90000000-0x9fffffff]
> pci_bus 0001:41: resource 0 mem: [0x0-0xfff]
> pci_bus 0001:41: resource 1 mem: [0x94000000-0x940fffff]
> pci_bus 0001:41: resource 2 pref mem [0x90000000-0x93ffffff]
> pci_bus 0001:42: resource 1 mem: [0xa0100000-0xa4ffffff]
> pci_bus 0001:42: resource 2 pref mem [0x90000000-0x93ffffff]
> pci_bus 0001:43: resource 1 mem: [0xa0100000-0xa2ffffff]
> pci_bus 0001:43: resource 2 pref mem [0x90000000-0x91ffffff]
> pci_bus 0001:44: resource 1 mem: [0xa3000000-0xa4ffffff]
> pci_bus 0001:44: resource 2 pref mem [0x92000000-0x93ffffff]
> bio: create slab <bio-0> at 0
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Switched to high resolution mode on CPU 0
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> NET: Registered protocol family 1
> Trying to unpack rootfs image as initramfs...
> Freeing initrd memory: 3078k freed
> irq: irq 26 on host /interrupt-controller mapped to virtual irq 26
> irq: irq 1 on host /interrupt-controller mapped to virtual irq 20
> irq: irq 30 on host /interrupt-controller2 mapped to virtual irq 21
> irq: irq 26 on host /interrupt-controller1 mapped to virtual irq 22
> irq: irq 12 on host /interrupt-controller mapped to virtual irq 23
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/powerpc started.
> Xenomai: real-time nucleus v2.4.10 (Flavor Crystal 7) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> fuse init (API version 7.11)
> msgmni has been set to 498
> alg: No test for stdrng (krng)
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> aer 0001:41:00.0:pcie12: service driver aer loaded
> aer 0001:42:01.0:pcie22: service driver aer loaded
> aer 0001:42:02.0:pcie22: service driver aer loaded
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0xef600200 (irq = 26) is a 16550A
> serial8250.0: ttyS1 at MMIO 0xef600300 (irq = 20) is a 16550A
> console [ttyS1] enabled
> ef600200.serial: ttyS0 at MMIO 0xef600200 (irq = 26) is a 16550A
> ef600300.serial: ttyS1 at MMIO 0xef600300 (irq = 20) is a 16550A
> brd: module loaded
> Driver 'sd' needs updating - please use bus_type methods
> PPC 4xx OCP EMAC driver, version 3.54
> irq: irq 10 on host /interrupt-controller mapped to virtual irq 24
> irq: irq 11 on host /interrupt-controller mapped to virtual irq 25
> irq: irq 0 on host /interrupt-controller1 mapped to virtual irq 27
> irq: irq 1 on host /interrupt-controller1 mapped to virtual irq 29
> irq: irq 2 on host /interrupt-controller1 mapped to virtual irq 31
> MAL v2 /plb/mcmal, 2 TX channels, 2 RX channels
> RGMII /plb/opb/emac-rgmii@ef600b00 initialized with MDIO support
> irq: irq 24 on host /interrupt-controller mapped to virtual irq 32
> irq: irq 29 on host /interrupt-controller1 mapped to virtual irq 33
> /plb/opb/emac-rgmii@ef600b00: input 0 in RGMII mode
> eth0: EMAC-0 /plb/opb/ethernet@ef600900, MAC 00:90:f9:10:1a:08
> eth0: found Marvell 88E1111 Ethernet PHY (0x04)
> irq: irq 25 on host /interrupt-controller mapped to virtual irq 34
> irq: irq 31 on host /interrupt-controller1 mapped to virtual irq 35
> /plb/opb/emac-rgmii@ef600b00: input 1 in RGMII mode
> eth1: EMAC-1 /plb/opb/ethernet@ef600a00, MAC 00:90:f9:10:1a:09
> eth1: found Marvell 88E1111 Ethernet PHY (0x05)
> fc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
>  Intel/Sharp Extended Query Table at 0x010A
> Using buffer write method
> Using auto-unlock on power-up/resume
> cfi_cmdset_0001: Erase suspend on write enabled
> erase region 0: offset=0x0,size=0x8000,blocks=4
> erase region 1: offset=0x20000,size=0x20000,blocks=511
> RedBoot partition parsing not available
> Creating 7 MTD partitions on "fc000000.nor_flash":
> 0x000000000000-0x000000800000 : "kernel0"
> 0x000000800000-0x000001000000 : "kernel1"
> 0x000001000000-0x000001800000 : "kernel2"
> 0x000001800000-0x000003f40000 : "install"
> 0x000003f40000-0x000003f60000 : "env0"
> 0x000003f60000-0x000003f80000 : "env1"
> 0x000003f80000-0x000004000000 : "u-boot"
> irq: irq 8 on host /interrupt-controller mapped to virtual irq 36
> spi_ppc4xx_of ef600600.spi: driver initialized
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> dwc_otg: version 2.60a 22-NOV-2006
> dwc_otg: Shared Tx FIFO mode
> dwc_otg: Using DMA mode
> dwc_otg dwc_otg.0: DWC OTG Controller
> dwc_otg dwc_otg.0: new USB bus registered, assigned bus number 1
> dwc_otg dwc_otg.0: irq 21, io mem 0x00000000
> dwc_otg: Init: Port Power? op_state=1
> dwc_otg: Init: Power Port (0)
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: DWC OTG Controller
> usb usb1: Manufacturer: Linux 2.6.30.3-00063-g0af2edc-dirty dwc_otg_hcd
> usb usb1: SerialNumber: dwc_otg.0
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> i2c /dev entries driver
> irq: irq 2 on host /interrupt-controller mapped to virtual irq 37
> ibm-iic ef600400.i2c: using standard (100 kHz) mode
> irq: irq 7 on host /interrupt-controller mapped to virtual irq 38
> ibm-iic ef600500.i2c: using standard (100 kHz) mode
> lm75: probe of 0-0048 failed with error -121
> hwmon-vid: Unknown VRM version of your CPU
> PowerPC Book-E Watchdog Timer Loaded
> TCP cubic registered
> Initializing XFRM netlink socket
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> All bugs added by David S. Miller <davem@redhat.com>
> usb 1-1: new high speed USB device using dwc_otg and address 2
> usb 1-1: New USB device found, idVendor=0634, idProduct=0655
> usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 1-1: Product: Real SSD eUSB 2GB
> usb 1-1: Manufacturer: Micron Technology
> usb 1-1: SerialNumber: 4BF0022700035321
> usb 1-1: configuration #1 chosen from 1 choice
> scsi0 : SCSI emulation for USB Mass Storage devices
> usb-storage: device found at 2
> usb-storage: waiting for device to settle before scanning
> eth0: link is down
> eth0: link is up, 100 HDX
> IP-Config: Complete:
>      device=eth0, addr=137.237.178.150, mask=255.255.255.0, gw=137.237.178.1,
>      host=flx-am, domain=, nis-domain=(none),
>      bootserver=137.237.178.9, rootserver=137.237.178.9, rootpath=
> Freeing unused kernel memory: 164k init
> at24 0-0050: 512 byte 24c04 EEPROM (writable)
> at24 0-0052: 512 byte 24c04 EEPROM (writable)
> scsi 0:0:0:0: Direct-Access     MICRON   eUSB DISK        1110 PQ: 0 ANSI: 0 CCS
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> usb-storage: device scan complete
> sd 0:0:0:0: [sda] 3964928 512-byte hardware sectors: (2.03 GB/1.89 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
> sd 0:0:0:0: [sda] Assuming drive cache: write through
> sd 0:0:0:0: [sda] Assuming drive cache: write through
>  sda: sda1 sda2 sda3 sda4
> sd 0:0:0:0: [sda] Attached SCSI disk
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda2, internal journal
> EXT3-fs: mounted filesystem with journal data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda1, internal journal
> EXT3-fs: mounted filesystem with journal data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda3, internal journal
> EXT3-fs: mounted filesystem with journal data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda4, internal journal
> EXT3-fs: mounted filesystem with journal data mode.
> at24 0-0050: 512 byte 24c04 EEPROM (writable)
> at24 0-0052: 512 byte 24c04 EEPROM (writable)
> dx83xx 0001:43:00.0: device not available because of BAR 0 [0xa1000000-0xa1ffffff] collisions
> dx83xx: probe of 0001:43:00.0 failed with error -22
> dx83xx 0001:44:00.0: device not available because of BAR 0 [0xa3000000-0xa3ffffff] collisions
> dx83xx: probe of 0001:44:00.0 failed with error -22
