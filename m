Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E595D2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 12:30:27 +1000 (EST)
Subject: Re: PCI device not working
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAKpAL0mZ0zaqtJgo3NcJgpjajGV1CKnrUugR65nEDKuryHOr6A@mail.gmail.com>
Date: Wed, 26 Sep 2012 21:30:26 -0500
Message-Id: <85B954F4-2C2A-4D2B-8D40-01101845337B@kernel.crashing.org>
References: <CAKpAL0m2XqzuYsG4-yj3WfZN88PjQXMUxFtXpx-sjsWA_Q4EUQ@mail.gmail.com>
 <89227A80-31E1-4E18-9257-6B60126E5A62@kernel.crashing.org>
 <CAKpAL0nTu9XXFgz7i5-1LmetrV05qfQcdf1zGxqHzODgQ7xjKA@mail.gmail.com>
 <CAKpAL0nk-5zz2zht6suNx+BVCQtkxPFPL33uZFSuGpxT8YFFqg@mail.gmail.com>
 <CAKpAL0m2Df6JZ=vYvhfEY5jYH9qOdMmrdmw2u2tcWAAFGv04+Q@mail.gmail.com>
 <609C9A31-395A-4CB9-98BB-354E57E6658E@kernel.crashing.org>
 <CAKpAL0mZ0zaqtJgo3NcJgpjajGV1CKnrUugR65nEDKuryHOr6A@mail.gmail.com>
To: Davide Viti <zinosat@tiscali.it>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 26, 2012, at 10:25 AM, Davide Viti wrote:

> Hi,
> as you've suggested, I've added a printout inside =
fsl_pcie_check_link() which is called twice and returns 0 both times.
> Here follows the PCI-related part of dmesg with some extra printouts =
enabled.
>=20
> thank you,
> Davide

So its odd that scanning of the second bus didn't report any devices.  =
Do you have code that implements ppc_md.pci_exclude_device ?

If so, what does it do?

You might also want to put some code in the indirect PCI ops =
(indirect.c) to see what actual values you are getting from various =
indirect_read_config() calls.

- k

>=20
> ...
> Adding PCI host bridge /pcie@ffe09000
> *** [/pcie@ffe09000] fsl_pcie_check_link() val=3D0x16 =3D> return 0
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Found FSL PCI host bridge at 0x00000000ffe09000. Firmware bus number: =
0->255
>  ->Hose at 0xc05a2000, cfg_addr=3D0xff7fd000,cfg_data=3D0xff7fd004
> PCI host bridge /pcie@ffe09000  ranges:
>  MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000=20
>   IO 0x00000000ffc10000..0x00000000ffc1ffff -> 0x0000000000000000
> PCI memory map start 0x00000000ffe09000, size 0x0000000000001000
> PCI MEM resource start 0x00000000a0000000, size 0x0000000010000000.
> PCI IO resource start 0x0000000000000000, size 0x0000000000010000, phy =
base 0x00000000ffc10000.
> /pcie@ffe09000: PCICSRBAR @ 0xfff00000
>=20
> Adding PCI host bridge /pcie@ffe0a000
> *** [/pcie@ffe0a000] fsl_pcie_check_link() val=3D0x16 =3D> return 0
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Found FSL PCI host bridge at 0x00000000ffe0a000. Firmware bus number: =
0->255
>  ->Hose at 0xc05a20e0, cfg_addr=3D0xff7eb000,cfg_data=3D0xff7eb004
> PCI host bridge /pcie@ffe0a000  ranges:
>  MEM 0x00000000b0000000..0x00000000bfffffff -> 0x00000000b0000000=20
>   IO 0x00000000ffc00000..0x00000000ffc0ffff -> 0x0000000000000000
> PCI memory map start 0x00000000ffe0a000, size 0x0000000000001000
> PCI MEM resource start 0x00000000b0000000, size 0x0000000010000000.
> PCI IO resource start 0x0000000000000000, size 0x0000000000010000, phy =
base 0x00000000ffc00000.
> /pcie@ffe0a000: PCICSRBAR @ 0xfff00000
>=20
> ...
>=20
> PCI: Probing PCI hardware
> PCI: Scanning PHB /pcie@ffe09000
> PCI: PHB IO resource    =3D 00000000ff7ed000-00000000ff7fcfff [100]
> PCI: PHB MEM resource 0 =3D 00000000a0000000-00000000afffffff [200]
> PCI: PHB MEM offset     =3D 0000000000000000
> PCI: PHB IO  offset     =3D ff7ed000
>     probe mode: 0
> pci_bus 0000:00: scanning bus
> pci 0000:00:00.0: found [1957:0100] class 000b20 header type 01
> pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
> pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x54
> pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x19c
> pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x50
> pci 0000:00:00.0: calling quirk_resource_alignment+0x0/0x1a8
> pci 0000:00:00.0: supports D1 D2
> pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:00.0: PME# disabled
> pci_bus 0000:00: fixups for bus
> PCI: Fixup bus devices 0 (PHB)
> pci_busdev_to_OF_node(0,0x0)
>  parent is /pcie@ffe09000
> *** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
>  result is /pcie@ffe09000/pcie@0
> PCI: Try to map irq for 0000:00:00.0...
> pci_busdev_to_OF_node(0,0x0)
>  parent is /pcie@ffe09000
> *** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
>  result is /pcie@ffe09000/pcie@0
> pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
> pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0000:01: scanning bus
> pci 0000:01:00.0: found [1b65:abba] class 000280 header type 00
> pci 0000:01:00.0: reg 10: [mem 0xa0000000-0xa00003ff]
> pci 0000:01:00.0: reg 14: [mem 0xa0010000-0xa001ffff]
> pci 0000:01:00.0: calling pcibios_fixup_resources+0x0/0x19c
> PCI:0000:01:00.0 Resource 0 00000000a0000000-00000000a00003ff [40200] =
fixup...
> PCI:0000:01:00.0            00000000a0000000-00000000a00003ff
> PCI:0000:01:00.0 Resource 1 00000000a0010000-00000000a001ffff [40200] =
fixup...
> PCI:0000:01:00.0            00000000a0010000-00000000a001ffff
> pci 0000:01:00.0: calling quirk_resource_alignment+0x0/0x1a8
> pci_bus 0000:01: fixups for bus
> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> pci 0000:00:00.0:   bridge window [io  0x0000-0x0000] (disabled)
> pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xa00fffff]
> pci 0000:00:00.0:   bridge window [mem 0x10000000-0x000fffff pref] =
(disabled)
> PCI:0000:00:00.0 Bus rsrc 1 00000000a0000000-00000000a00fffff [200] =
fixup...
> PCI:0000:00:00.0            00000000a0000000-00000000a00fffff
> PCI: Fixup bus devices 1 (0000:00:00.0)
> pci_busdev_to_OF_node(1,0x0)
> *** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
>  parent is /pcie@ffe09000/pcie@0
>  result is <NULL>
> PCI: Try to map irq for 0000:01:00.0...
> pci_busdev_to_OF_node(1,0x0)
> *** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
>  parent is /pcie@ffe09000/pcie@0
>  result is <NULL>
> pci_busdev_to_OF_node(0,0x0)
>  parent is /pcie@ffe09000
> *** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
>  result is /pcie@ffe09000/pcie@0
>  Got one, spec 1 cells (0x00000001 0xffffffff...) on =
/soc@ffe00000/pic@40000
>   alloc irq_desc for 16 on node 0
>   alloc kstat_irqs on node 0
> irq: irq 1 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16
>  Mapped to linux irq 16
> pci_bus 0000:01: bus scan returning with max=3D01
> pci_bus 0000:00: bus scan returning with max=3D01
> PCI: Scanning PHB /pcie@ffe0a000
> PCI: PHB IO resource    =3D 00000000ff7db000-00000000ff7eafff [100]
> PCI: PHB MEM resource 0 =3D 00000000b0000000-00000000bfffffff [200]
> PCI: PHB MEM offset     =3D 0000000000000000
> PCI: PHB IO  offset     =3D ff7db000
>     probe mode: 0
> pci_bus 0001:02: scanning bus
> pci 0001:02:00.0: found [1957:0100] class 000b20 header type 01
> pci 0001:02:00.0: ignoring class b20 (doesn't match header type 01)
> pci 0001:02:00.0: calling fixup_hide_host_resource_fsl+0x0/0x54
> pci 0001:02:00.0: calling pcibios_fixup_resources+0x0/0x19c
> pci 0001:02:00.0: calling quirk_fsl_pcie_header+0x0/0x50
> pci 0001:02:00.0: calling quirk_resource_alignment+0x0/0x1a8
> pci 0001:02:00.0: supports D1 D2
> pci 0001:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0001:02:00.0: PME# disabled
> pci_bus 0001:02: fixups for bus
> PCI: Fixup bus devices 2 (PHB)
> pci_busdev_to_OF_node(2,0x0)
>  parent is /pcie@ffe0a000
> *** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
>  result is /pcie@ffe0a000/pcie@0
> PCI: Try to map irq for 0001:02:00.0...
> pci_busdev_to_OF_node(2,0x0)
>  parent is /pcie@ffe0a000
> *** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
>  result is /pcie@ffe0a000/pcie@0
> pci 0001:02:00.0: scanning [bus 01-01] behind bridge, pass 0
> pci 0001:02:00.0: bus configuration invalid, reconfiguring
> pci 0001:02:00.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0001:03: scanning bus
> pci_bus 0001:03: fixups for bus
> pci 0001:02:00.0: PCI bridge to [bus 03-ff]
> pci 0001:02:00.0:   bridge window [io  0x0000-0x0000] (disabled)
> pci 0001:02:00.0:   bridge window [mem 0xb0000000-0xb00fffff]
> pci 0001:02:00.0:   bridge window [mem 0x10000000-0x000fffff pref] =
(disabled)
> PCI:0001:02:00.0 Bus rsrc 1 00000000b0000000-00000000b00fffff [200] =
fixup...
> PCI:0001:02:00.0            00000000b0000000-00000000b00fffff
> PCI: Fixup bus devices 3 (0001:02:00.0)
> pci_bus 0001:03: bus scan returning with max=3D03
> pci_bus 0001:02: bus scan returning with max=3D03
> PCI->OF bus map (pci_bus_count=3D4):
> 0 -> 0
> 2 -> 0
> PCI: Allocating bus resources for 0000:00...
> PCI: PHB (bus 0) bridge rsrc 0: 00000000ff7ed000-00000000ff7fcfff =
[0x100], parent c04cd81c (PCI IO)
> PCI: PHB (bus 0) bridge rsrc 1: 00000000a0000000-00000000afffffff =
[0x200], parent c04cd800 (PCI mem)
> PCI: Allocating bus resources for 0000:01...
> PCI: 0000:00:00.0 (bus 1) bridge rsrc 0: =
00000000ff7ed000-00000000ff7fcfff [0x100], parent c05a204c =
(/pcie@ffe09000)
> PCI: 0000:00:00.0 (bus 1) bridge rsrc 1: =
00000000a0000000-00000000afffffff [0x200], parent c05a2068 =
(/pcie@ffe09000)
> PCI: Allocating bus resources for 0001:02...
> PCI: PHB (bus 2) bridge rsrc 0: 00000000ff7db000-00000000ff7eafff =
[0x100], parent c04cd81c (PCI IO)
> PCI: PHB (bus 2) bridge rsrc 1: 00000000b0000000-00000000bfffffff =
[0x200], parent c04cd800 (PCI mem)
> PCI: Allocating bus resources for 0001:03...
> PCI: 0001:02:00.0 (bus 3) bridge rsrc 0: =
00000000ff7db000-00000000ff7eafff [0x100], parent c05a212c =
(/pcie@ffe0a000)
> PCI: 0001:02:00.0 (bus 3) bridge rsrc 1: =
00000000b0000000-00000000bfffffff [0x200], parent c05a2148 =
(/pcie@ffe0a000)
> PCI: Allocating 0000:01:00.0: Resource 0: =
00000000a0000000..00000000a00003ff [40200]
> PCI: Allocating 0000:01:00.0: Resource 1: =
00000000a0010000..00000000a001ffff [40200]
> Reserving legacy ranges for domain 0000
> Candidate legacy IO: [io  0xff7ed000-0xff7edfff]
> PCI 0000:00 Cannot reserve Legacy IO [io  0xff7ed000-0xff7edfff]
> hose mem offset: 0000000000000000
> hose mem res: [mem 0xa0000000-0xafffffff]
> Reserving legacy ranges for domain 0001
> Candidate legacy IO: [io  0xff7db000-0xff7dbfff]
> PCI 0001:02 Cannot reserve Legacy IO [io  0xff7db000-0xff7dbfff]
> hose mem offset: 0000000000000000
> hose mem res: [mem 0xb0000000-0xbfffffff]
> PCI: Assigning unassigned resources...
> pci 0000:00:00.0: PCI bridge to [bus 01-01]
> pci 0000:00:00.0:   bridge window [io  0xff7ed000-0xff7fcfff]
> pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xafffffff]
> pci 0000:00:00.0:   bridge window [mem pref disabled]
> pci 0000:00:00.0: enabling device (0106 -> 0107)
> pci 0001:02:00.0: PCI bridge to [bus 03-03]
> pci 0001:02:00.0:   bridge window [io  0xff7db000-0xff7eafff]
> pci 0001:02:00.0:   bridge window [mem 0xb0000000-0xbfffffff]
> pci 0001:02:00.0:   bridge window [mem pref disabled]
> pci 0001:02:00.0: enabling device (0106 -> 0107)
> pci_bus 0000:00: resource 0 [io  0xff7ed000-0xff7fcfff]
> pci_bus 0000:00: resource 1 [mem 0xa0000000-0xafffffff]
> pci_bus 0000:01: resource 0 [io  0xff7ed000-0xff7fcfff]
> pci_bus 0000:01: resource 1 [mem 0xa0000000-0xafffffff]
> pci_bus 0001:02: resource 0 [io  0xff7db000-0xff7eafff]
> pci_bus 0001:02: resource 1 [mem 0xb0000000-0xbfffffff]
> pci_bus 0001:03: resource 0 [io  0xff7db000-0xff7eafff]
> pci_bus 0001:03: resource 1 [mem 0xb0000000-0xbfffffff]
> bio: create slab <bio-0> at 0
> vgaarb: loaded
> SCSI subsystem initialized
> libata version 3.00 loaded.
> Freescale Elo / Elo Plus DMA driver
> Switching to clocksource timebase
> NET: Registered protocol family 2
>=20
> pci 0000:00:00.0: calling quirk_cardbus_legacy+0x0/0x50
> pci 0000:00:00.0: calling quirk_usb_early_handoff+0x0/0x6ac
> pci 0000:01:00.0: calling quirk_cardbus_legacy+0x0/0x50
> pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x6ac
> pci 0001:02:00.0: calling quirk_cardbus_legacy+0x0/0x50
> pci 0001:02:00.0: calling quirk_usb_early_handoff+0x0/0x6ac
>=20
>=20
> 2012/9/26 Kumar Gala <galak@kernel.crashing.org>
>=20
> > 2012/9/24 Davide Viti <zinosat@tiscali.it>
> > Hi,
> > does the output I've included show anything wrong or should I post =
something else to help identifying the cause of the problem?
> >
> > thank you in advance,
> > Davide
> >
> > 2012/9/21 Davide Viti <zinosat@tiscali.it>
> > I mean there are two controllers and both of them have a device =
"subtended" (both 0x1b65:0xabba).
> > u-boot can see both devices, linux detects only the device attached =
to the first controller.
> >
> > Here's the output of lspci and /proc/iomem :
> >
> > root@(none):/# lspci -v
> >
> > 0000:00:00.0 Class 0604: Device 1957:0100 (rev 11)
> >
> >         Flags: bus master, fast devsel, latency 0
> >
> >         Memory at <ignored> (32-bit, non-prefetchable)
> >
> >         Bus: primary=3D00, secondary=3D01, subordinate=3D01, =
sec-latency=3D0
> >
> >         I/O behind bridge: 00000000-00000fff
> >
> >         Memory behind bridge: a0000000-afffffff
> >
> >         Capabilities: [44] Power Management version 2
> >
> >         Capabilities: [4c] Express Root Port (Slot-), MSI 00
> >
> >         Capabilities: [100] Advanced Error Reporting
> >
> >
> > 0000:01:00.0 Class 0280: Device 1b65:abba (rev 01)
> >
> >         Flags: bus master, fast devsel, latency 0, IRQ 16
> >
> >         Memory at a0000000 (32-bit, non-prefetchable) [size=3D1K]
> >
> >         Memory at a0010000 (32-bit, non-prefetchable) [size=3D64K]
> >
> >         Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> >
> >         Capabilities: [78] Power Management version 3
> >
> >         Capabilities: [80] Express Endpoint, MSI 00
> >
> >         Capabilities: [100] Virtual Channel <?>
> >
> >         Capabilities: [800] Advanced Error Reporting
> >
> >
> > 0001:02:00.0 Class 0604: Device 1957:0100 (rev 11)
> >
> >         Flags: bus master, fast devsel, latency 0
> >
> >         Memory at <ignored> (32-bit, non-prefetchable)
> >
> >         Bus: primary=3D00, secondary=3D03, subordinate=3D03, =
sec-latency=3D0
> >
> >         I/O behind bridge: 00000000-00000fff
> >
> >         Memory behind bridge: b0000000-bfffffff
> >
> >         Capabilities: [44] Power Management version 2
> >
> >         Capabilities: [4c] Express Root Port (Slot-), MSI 00
> >
> >         Capabilities: [100] Advanced Error Reporting
>=20
> Its possible that in linux the 2nd controller does not believe it has =
link status.  Can you see if there is a function like =
fsl_pcie_check_link() in your kernel.  If so maybe add a printk debug =
message there and see what gets return.
>=20
> Also helpful to post a full boot log.
>=20
> >
> >
> >
> >
> > root@(none):/# cat /proc/iomem
> >
> > a0000000-afffffff : /pcie@ffe09000
> >
> >   a0000000-afffffff : PCI Bus 0000:01
> >
> >     a0000000-a00003ff : 0000:01:00.0
> >
> >     a0010000-a001ffff : 0000:01:00.0
> >
> > b0000000-bfffffff : /pcie@ffe0a000
> >
> >   b0000000-bfffffff : PCI Bus 0001:03
> >
> > ef000000-efffffff : ef000000.nor
> >
> > ffe04500-ffe04507 : serial
> >
> > ffe04600-ffe04607 : serial
> >
> >
> >
> > thanx for your help,
> >
> > Davide
> >
> >
> >
> >
> > I mean that the kernel detects the first controller and the device =
attached to it, plus the second controller: the device on the second =
controller is not detected (same device as the one detected on the first =
controller)
> >
> > 2012/9/21 Kumar Gala <galak@kernel.crashing.org>
> >
> > On Sep 21, 2012, at 6:33 AM, Davide Viti wrote:
> >
> > > Hi,
> > > I'm working on a custom board based on P1020 with two (identical) =
PCI devices attached;
> > > The work is derived from another board with a single instance of =
that device.
> > > The system is based on u-boot-2009.11 and Linux 2.6.34.6
> > >
> > > The "pci" command on u-boot, shows me both the PCI controllers and
> > > the attached devices:
> > >
> > > Scanning PCI devices on bus 0
> > > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > > _____________________________________________________________
> > > 00.00.00   0x1957     0x0100     Processor               0x20
> > >
> > > Scanning PCI devices on bus 1
> > > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > > _____________________________________________________________
> > > 01.00.00   0x1b65     0xabba     Network controller      0x80
> > >
> > > Scanning PCI devices on bus 2
> > > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > > _____________________________________________________________
> > > 02.00.00   0x1957     0x0100     Processor               0x20
> > >
> > > Scanning PCI devices on bus 3
> > > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > > _____________________________________________________________
> > > 03.00.00   0x1b65     0xabba     Network controller      0x80
> > >
> > > The kernel detects only the first instance of the device.
> >
> > What do you mean by first instance of the device ?
> >
> > > Didn't get very far while looking at dts file and kernel logs, so =
I'm
> > > asking for some help on narrowing down the problem.
> > >
> > > I'm wondering if I can assume that the problem is restricted to
> > > kernel/dts and avoid concentrating on uboot.
> > > I can provide any log (didn't want to post tons of details on the =
first
> > > message)
> >
> > Probably a dts issue.
> >
> > What does lspci in linux say?
> >
> > - k
> >
> >
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
>=20
