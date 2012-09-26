Return-Path: <zinosat@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A09D2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 01:25:54 +1000 (EST)
Received: by pabkq12 with SMTP id kq12so540301pab.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2012 08:25:52 -0700 (PDT)
MIME-Version: 1.0
Sender: zinosat@gmail.com
In-Reply-To: <609C9A31-395A-4CB9-98BB-354E57E6658E@kernel.crashing.org>
References: <CAKpAL0m2XqzuYsG4-yj3WfZN88PjQXMUxFtXpx-sjsWA_Q4EUQ@mail.gmail.com>
 <89227A80-31E1-4E18-9257-6B60126E5A62@kernel.crashing.org>
 <CAKpAL0nTu9XXFgz7i5-1LmetrV05qfQcdf1zGxqHzODgQ7xjKA@mail.gmail.com>
 <CAKpAL0nk-5zz2zht6suNx+BVCQtkxPFPL33uZFSuGpxT8YFFqg@mail.gmail.com>
 <CAKpAL0m2Df6JZ=vYvhfEY5jYH9qOdMmrdmw2u2tcWAAFGv04+Q@mail.gmail.com>
 <609C9A31-395A-4CB9-98BB-354E57E6658E@kernel.crashing.org>
Date: Wed, 26 Sep 2012 17:25:52 +0200
Message-ID: <CAKpAL0mZ0zaqtJgo3NcJgpjajGV1CKnrUugR65nEDKuryHOr6A@mail.gmail.com>
Subject: Re: PCI device not working
From: Davide Viti <zinosat@tiscali.it>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=047d7b339c832b6de904ca9c70bd
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b339c832b6de904ca9c70bd
Content-Type: text/plain; charset=ISO-8859-1

Hi,
as you've suggested, I've added a printout inside fsl_pcie_check_link()
which is called twice and returns 0 both times.
Here follows the PCI-related part of dmesg with some extra printouts
enabled.

thank you,
Davide

...
Adding PCI host bridge /pcie@ffe09000
*** [/pcie@ffe09000] fsl_pcie_check_link() val=0x16 => return 0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Found FSL PCI host bridge at 0x00000000ffe09000. Firmware bus number: 0->255
 ->Hose at 0xc05a2000, cfg_addr=0xff7fd000,cfg_data=0xff7fd004
PCI host bridge /pcie@ffe09000  ranges:
 MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000
  IO 0x00000000ffc10000..0x00000000ffc1ffff -> 0x0000000000000000
PCI memory map start 0x00000000ffe09000, size 0x0000000000001000
PCI MEM resource start 0x00000000a0000000, size 0x0000000010000000.
PCI IO resource start 0x0000000000000000, size 0x0000000000010000, phy base
0x00000000ffc10000.
/pcie@ffe09000: PCICSRBAR @ 0xfff00000

Adding PCI host bridge /pcie@ffe0a000
*** [/pcie@ffe0a000] fsl_pcie_check_link() val=0x16 => return 0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Found FSL PCI host bridge at 0x00000000ffe0a000. Firmware bus number: 0->255
 ->Hose at 0xc05a20e0, cfg_addr=0xff7eb000,cfg_data=0xff7eb004
PCI host bridge /pcie@ffe0a000  ranges:
 MEM 0x00000000b0000000..0x00000000bfffffff -> 0x00000000b0000000
  IO 0x00000000ffc00000..0x00000000ffc0ffff -> 0x0000000000000000
PCI memory map start 0x00000000ffe0a000, size 0x0000000000001000
PCI MEM resource start 0x00000000b0000000, size 0x0000000010000000.
PCI IO resource start 0x0000000000000000, size 0x0000000000010000, phy base
0x00000000ffc00000.
/pcie@ffe0a000: PCICSRBAR @ 0xfff00000

...

PCI: Probing PCI hardware
PCI: Scanning PHB /pcie@ffe09000
PCI: PHB IO resource    = 00000000ff7ed000-00000000ff7fcfff [100]
PCI: PHB MEM resource 0 = 00000000a0000000-00000000afffffff [200]
PCI: PHB MEM offset     = 0000000000000000
PCI: PHB IO  offset     = ff7ed000
    probe mode: 0
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: found [1957:0100] class 000b20 header type 01
pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x54
pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x19c
pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x50
pci 0000:00:00.0: calling quirk_resource_alignment+0x0/0x1a8
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
PCI: Fixup bus devices 0 (PHB)
pci_busdev_to_OF_node(0,0x0)
 parent is /pcie@ffe09000
*** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
 result is /pcie@ffe09000/pcie@0
PCI: Try to map irq for 0000:00:00.0...
pci_busdev_to_OF_node(0,0x0)
 parent is /pcie@ffe09000
*** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
 result is /pcie@ffe09000/pcie@0
pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: found [1b65:abba] class 000280 header type 00
pci 0000:01:00.0: reg 10: [mem 0xa0000000-0xa00003ff]
pci 0000:01:00.0: reg 14: [mem 0xa0010000-0xa001ffff]
pci 0000:01:00.0: calling pcibios_fixup_resources+0x0/0x19c
PCI:0000:01:00.0 Resource 0 00000000a0000000-00000000a00003ff [40200]
fixup...
PCI:0000:01:00.0            00000000a0000000-00000000a00003ff
PCI:0000:01:00.0 Resource 1 00000000a0010000-00000000a001ffff [40200]
fixup...
PCI:0000:01:00.0            00000000a0010000-00000000a001ffff
pci 0000:01:00.0: calling quirk_resource_alignment+0x0/0x1a8
pci_bus 0000:01: fixups for bus
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x0000-0x0000] (disabled)
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xa00fffff]
pci 0000:00:00.0:   bridge window [mem 0x10000000-0x000fffff pref]
(disabled)
PCI:0000:00:00.0 Bus rsrc 1 00000000a0000000-00000000a00fffff [200] fixup...
PCI:0000:00:00.0            00000000a0000000-00000000a00fffff
PCI: Fixup bus devices 1 (0000:00:00.0)
pci_busdev_to_OF_node(1,0x0)
*** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
 parent is /pcie@ffe09000/pcie@0
 result is <NULL>
PCI: Try to map irq for 0000:01:00.0...
pci_busdev_to_OF_node(1,0x0)
*** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
 parent is /pcie@ffe09000/pcie@0
 result is <NULL>
pci_busdev_to_OF_node(0,0x0)
 parent is /pcie@ffe09000
*** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
 result is /pcie@ffe09000/pcie@0
 Got one, spec 1 cells (0x00000001 0xffffffff...) on /soc@ffe00000/pic@40000
  alloc irq_desc for 16 on node 0
  alloc kstat_irqs on node 0
irq: irq 1 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16
 Mapped to linux irq 16
pci_bus 0000:01: bus scan returning with max=01
pci_bus 0000:00: bus scan returning with max=01
PCI: Scanning PHB /pcie@ffe0a000
PCI: PHB IO resource    = 00000000ff7db000-00000000ff7eafff [100]
PCI: PHB MEM resource 0 = 00000000b0000000-00000000bfffffff [200]
PCI: PHB MEM offset     = 0000000000000000
PCI: PHB IO  offset     = ff7db000
    probe mode: 0
pci_bus 0001:02: scanning bus
pci 0001:02:00.0: found [1957:0100] class 000b20 header type 01
pci 0001:02:00.0: ignoring class b20 (doesn't match header type 01)
pci 0001:02:00.0: calling fixup_hide_host_resource_fsl+0x0/0x54
pci 0001:02:00.0: calling pcibios_fixup_resources+0x0/0x19c
pci 0001:02:00.0: calling quirk_fsl_pcie_header+0x0/0x50
pci 0001:02:00.0: calling quirk_resource_alignment+0x0/0x1a8
pci 0001:02:00.0: supports D1 D2
pci 0001:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:02:00.0: PME# disabled
pci_bus 0001:02: fixups for bus
PCI: Fixup bus devices 2 (PHB)
pci_busdev_to_OF_node(2,0x0)
 parent is /pcie@ffe0a000
*** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
 result is /pcie@ffe0a000/pcie@0
PCI: Try to map irq for 0001:02:00.0...
pci_busdev_to_OF_node(2,0x0)
 parent is /pcie@ffe0a000
*** scan_OF_for_pci_dev() reg[0]: 0x0  psize:0x14 devfn:0x0
 result is /pcie@ffe0a000/pcie@0
pci 0001:02:00.0: scanning [bus 01-01] behind bridge, pass 0
pci 0001:02:00.0: bus configuration invalid, reconfiguring
pci 0001:02:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0001:03: scanning bus
pci_bus 0001:03: fixups for bus
pci 0001:02:00.0: PCI bridge to [bus 03-ff]
pci 0001:02:00.0:   bridge window [io  0x0000-0x0000] (disabled)
pci 0001:02:00.0:   bridge window [mem 0xb0000000-0xb00fffff]
pci 0001:02:00.0:   bridge window [mem 0x10000000-0x000fffff pref]
(disabled)
PCI:0001:02:00.0 Bus rsrc 1 00000000b0000000-00000000b00fffff [200] fixup...
PCI:0001:02:00.0            00000000b0000000-00000000b00fffff
PCI: Fixup bus devices 3 (0001:02:00.0)
pci_bus 0001:03: bus scan returning with max=03
pci_bus 0001:02: bus scan returning with max=03
PCI->OF bus map (pci_bus_count=4):
0 -> 0
2 -> 0
PCI: Allocating bus resources for 0000:00...
PCI: PHB (bus 0) bridge rsrc 0: 00000000ff7ed000-00000000ff7fcfff [0x100],
parent c04cd81c (PCI IO)
PCI: PHB (bus 0) bridge rsrc 1: 00000000a0000000-00000000afffffff [0x200],
parent c04cd800 (PCI mem)
PCI: Allocating bus resources for 0000:01...
PCI: 0000:00:00.0 (bus 1) bridge rsrc 0: 00000000ff7ed000-00000000ff7fcfff
[0x100], parent c05a204c (/pcie@ffe09000)
PCI: 0000:00:00.0 (bus 1) bridge rsrc 1: 00000000a0000000-00000000afffffff
[0x200], parent c05a2068 (/pcie@ffe09000)
PCI: Allocating bus resources for 0001:02...
PCI: PHB (bus 2) bridge rsrc 0: 00000000ff7db000-00000000ff7eafff [0x100],
parent c04cd81c (PCI IO)
PCI: PHB (bus 2) bridge rsrc 1: 00000000b0000000-00000000bfffffff [0x200],
parent c04cd800 (PCI mem)
PCI: Allocating bus resources for 0001:03...
PCI: 0001:02:00.0 (bus 3) bridge rsrc 0: 00000000ff7db000-00000000ff7eafff
[0x100], parent c05a212c (/pcie@ffe0a000)
PCI: 0001:02:00.0 (bus 3) bridge rsrc 1: 00000000b0000000-00000000bfffffff
[0x200], parent c05a2148 (/pcie@ffe0a000)
PCI: Allocating 0000:01:00.0: Resource 0:
00000000a0000000..00000000a00003ff [40200]
PCI: Allocating 0000:01:00.0: Resource 1:
00000000a0010000..00000000a001ffff [40200]
Reserving legacy ranges for domain 0000
Candidate legacy IO: [io  0xff7ed000-0xff7edfff]
PCI 0000:00 Cannot reserve Legacy IO [io  0xff7ed000-0xff7edfff]
hose mem offset: 0000000000000000
hose mem res: [mem 0xa0000000-0xafffffff]
Reserving legacy ranges for domain 0001
Candidate legacy IO: [io  0xff7db000-0xff7dbfff]
PCI 0001:02 Cannot reserve Legacy IO [io  0xff7db000-0xff7dbfff]
hose mem offset: 0000000000000000
hose mem res: [mem 0xb0000000-0xbfffffff]
PCI: Assigning unassigned resources...
pci 0000:00:00.0: PCI bridge to [bus 01-01]
pci 0000:00:00.0:   bridge window [io  0xff7ed000-0xff7fcfff]
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xafffffff]
pci 0000:00:00.0:   bridge window [mem pref disabled]
pci 0000:00:00.0: enabling device (0106 -> 0107)
pci 0001:02:00.0: PCI bridge to [bus 03-03]
pci 0001:02:00.0:   bridge window [io  0xff7db000-0xff7eafff]
pci 0001:02:00.0:   bridge window [mem 0xb0000000-0xbfffffff]
pci 0001:02:00.0:   bridge window [mem pref disabled]
pci 0001:02:00.0: enabling device (0106 -> 0107)
pci_bus 0000:00: resource 0 [io  0xff7ed000-0xff7fcfff]
pci_bus 0000:00: resource 1 [mem 0xa0000000-0xafffffff]
pci_bus 0000:01: resource 0 [io  0xff7ed000-0xff7fcfff]
pci_bus 0000:01: resource 1 [mem 0xa0000000-0xafffffff]
pci_bus 0001:02: resource 0 [io  0xff7db000-0xff7eafff]
pci_bus 0001:02: resource 1 [mem 0xb0000000-0xbfffffff]
pci_bus 0001:03: resource 0 [io  0xff7db000-0xff7eafff]
pci_bus 0001:03: resource 1 [mem 0xb0000000-0xbfffffff]
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
Freescale Elo / Elo Plus DMA driver
Switching to clocksource timebase
NET: Registered protocol family 2

pci 0000:00:00.0: calling quirk_cardbus_legacy+0x0/0x50
pci 0000:00:00.0: calling quirk_usb_early_handoff+0x0/0x6ac
pci 0000:01:00.0: calling quirk_cardbus_legacy+0x0/0x50
pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x6ac
pci 0001:02:00.0: calling quirk_cardbus_legacy+0x0/0x50
pci 0001:02:00.0: calling quirk_usb_early_handoff+0x0/0x6ac


2012/9/26 Kumar Gala <galak@kernel.crashing.org>

>
> > 2012/9/24 Davide Viti <zinosat@tiscali.it>
> > Hi,
> > does the output I've included show anything wrong or should I post
> something else to help identifying the cause of the problem?
> >
> > thank you in advance,
> > Davide
> >
> > 2012/9/21 Davide Viti <zinosat@tiscali.it>
> > I mean there are two controllers and both of them have a device
> "subtended" (both 0x1b65:0xabba).
> > u-boot can see both devices, linux detects only the device attached to
> the first controller.
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
> >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
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
> >         Memory at a0000000 (32-bit, non-prefetchable) [size=1K]
> >
> >         Memory at a0010000 (32-bit, non-prefetchable) [size=64K]
> >
> >         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
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
> >         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
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
>
> Its possible that in linux the 2nd controller does not believe it has link
> status.  Can you see if there is a function like fsl_pcie_check_link() in
> your kernel.  If so maybe add a printk debug message there and see what
> gets return.
>
> Also helpful to post a full boot log.
>
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
> > I mean that the kernel detects the first controller and the device
> attached to it, plus the second controller: the device on the second
> controller is not detected (same device as the one detected on the first
> controller)
> >
> > 2012/9/21 Kumar Gala <galak@kernel.crashing.org>
> >
> > On Sep 21, 2012, at 6:33 AM, Davide Viti wrote:
> >
> > > Hi,
> > > I'm working on a custom board based on P1020 with two (identical) PCI
> devices attached;
> > > The work is derived from another board with a single instance of that
> device.
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
> > > Didn't get very far while looking at dts file and kernel logs, so I'm
> > > asking for some help on narrowing down the problem.
> > >
> > > I'm wondering if I can assume that the problem is restricted to
> > > kernel/dts and avoid concentrating on uboot.
> > > I can provide any log (didn't want to post tons of details on the first
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
>
>

--047d7b339c832b6de904ca9c70bd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div><div>as you&#39;ve suggested, I&#39;ve added a printout insid=
e=A0fsl_pcie_check_link() which is called twice and returns 0 both times.</=
div><div>Here follows the PCI-related part of dmesg with some extra printou=
ts enabled.</div>
<div><br></div><div>thank you,</div><div>Davide</div><div><br></div><div>..=
.</div><div>Adding PCI host bridge /pcie@ffe09000</div><div>*** [/pcie@ffe0=
9000] fsl_pcie_check_link() val=3D0x16 =3D&gt; return 0</div><div>^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^</div>
<div>Found FSL PCI host bridge at 0x00000000ffe09000. Firmware bus number: =
0-&gt;255</div><div>=A0-&gt;Hose at 0xc05a2000, cfg_addr=3D0xff7fd000,cfg_d=
ata=3D0xff7fd004</div><div>PCI host bridge /pcie@ffe09000 =A0ranges:</div><=
div>
=A0MEM 0x00000000a0000000..0x00000000afffffff -&gt; 0x00000000a0000000=A0</=
div><div>=A0 IO 0x00000000ffc10000..0x00000000ffc1ffff -&gt; 0x000000000000=
0000</div><div>PCI memory map start 0x00000000ffe09000, size 0x000000000000=
1000</div>
<div>PCI MEM resource start 0x00000000a0000000, size 0x0000000010000000.</d=
iv><div>PCI IO resource start 0x0000000000000000, size 0x0000000000010000, =
phy base 0x00000000ffc10000.</div><div>/pcie@ffe09000: PCICSRBAR @ 0xfff000=
00</div>
<div><br></div><div>Adding PCI host bridge /pcie@ffe0a000</div><div>*** [/p=
cie@ffe0a000] fsl_pcie_check_link() val=3D0x16 =3D&gt; return 0</div><div>^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^</div><div>Fo=
und FSL PCI host bridge at 0x00000000ffe0a000. Firmware bus number: 0-&gt;2=
55</div>
<div>=A0-&gt;Hose at 0xc05a20e0, cfg_addr=3D0xff7eb000,cfg_data=3D0xff7eb00=
4</div><div>PCI host bridge /pcie@ffe0a000 =A0ranges:</div><div>=A0MEM 0x00=
000000b0000000..0x00000000bfffffff -&gt; 0x00000000b0000000=A0</div><div>=
=A0 IO 0x00000000ffc00000..0x00000000ffc0ffff -&gt; 0x0000000000000000</div=
>
<div>PCI memory map start 0x00000000ffe0a000, size 0x0000000000001000</div>=
<div>PCI MEM resource start 0x00000000b0000000, size 0x0000000010000000.</d=
iv><div>PCI IO resource start 0x0000000000000000, size 0x0000000000010000, =
phy base 0x00000000ffc00000.</div>
<div>/pcie@ffe0a000: PCICSRBAR @ 0xfff00000</div><div><br></div><div>...</d=
iv><div><br></div><div>PCI: Probing PCI hardware</div><div>PCI: Scanning PH=
B /pcie@ffe09000</div><div>PCI: PHB IO resource =A0 =A0=3D 00000000ff7ed000=
-00000000ff7fcfff [100]</div>
<div>PCI: PHB MEM resource 0 =3D 00000000a0000000-00000000afffffff [200]</d=
iv><div>PCI: PHB MEM offset =A0 =A0 =3D 0000000000000000</div><div>PCI: PHB=
 IO =A0offset =A0 =A0 =3D ff7ed000</div><div>=A0 =A0 probe mode: 0</div><di=
v>pci_bus 0000:00: scanning bus</div>
<div>pci 0000:00:00.0: found [1957:0100] class 000b20 header type 01</div><=
div>pci 0000:00:00.0: ignoring class b20 (doesn&#39;t match header type 01)=
</div><div>pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x54<=
/div>
<div>pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x19c</div><div>=
pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x50</div><div>pci 0000=
:00:00.0: calling quirk_resource_alignment+0x0/0x1a8</div><div>pci 0000:00:=
00.0: supports D1 D2</div>
<div>pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold</div><div>=
pci 0000:00:00.0: PME# disabled</div><div>pci_bus 0000:00: fixups for bus</=
div><div>PCI: Fixup bus devices 0 (PHB)</div><div>pci_busdev_to_OF_node(0,0=
x0)</div>
<div>=A0parent is /pcie@ffe09000</div><div>*** scan_OF_for_pci_dev() reg[0]=
: 0x0 =A0psize:0x14 devfn:0x0</div><div>=A0result is /pcie@ffe09000/pcie@0<=
/div><div>PCI: Try to map irq for 0000:00:00.0...</div><div>pci_busdev_to_O=
F_node(0,0x0)</div>
<div>=A0parent is /pcie@ffe09000</div><div>*** scan_OF_for_pci_dev() reg[0]=
: 0x0 =A0psize:0x14 devfn:0x0</div><div>=A0result is /pcie@ffe09000/pcie@0<=
/div><div>pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0</div=
><div>
pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1</div><div>pci_=
bus 0000:01: scanning bus</div><div>pci 0000:01:00.0: found [1b65:abba] cla=
ss 000280 header type 00</div><div>pci 0000:01:00.0: reg 10: [mem 0xa000000=
0-0xa00003ff]</div>
<div>pci 0000:01:00.0: reg 14: [mem 0xa0010000-0xa001ffff]</div><div>pci 00=
00:01:00.0: calling pcibios_fixup_resources+0x0/0x19c</div><div>PCI:0000:01=
:00.0 Resource 0 00000000a0000000-00000000a00003ff [40200] fixup...</div>
<div>PCI:0000:01:00.0 =A0 =A0 =A0 =A0 =A0 =A000000000a0000000-00000000a0000=
3ff</div><div>PCI:0000:01:00.0 Resource 1 00000000a0010000-00000000a001ffff=
 [40200] fixup...</div><div>PCI:0000:01:00.0 =A0 =A0 =A0 =A0 =A0 =A00000000=
0a0010000-00000000a001ffff</div>
<div>pci 0000:01:00.0: calling quirk_resource_alignment+0x0/0x1a8</div><div=
>pci_bus 0000:01: fixups for bus</div><div>pci 0000:00:00.0: PCI bridge to =
[bus 01-ff]</div><div>pci 0000:00:00.0: =A0 bridge window [io =A00x0000-0x0=
000] (disabled)</div>
<div>pci 0000:00:00.0: =A0 bridge window [mem 0xa0000000-0xa00fffff]</div><=
div>pci 0000:00:00.0: =A0 bridge window [mem 0x10000000-0x000fffff pref] (d=
isabled)</div><div>PCI:0000:00:00.0 Bus rsrc 1 00000000a0000000-00000000a00=
fffff [200] fixup...</div>
<div>PCI:0000:00:00.0 =A0 =A0 =A0 =A0 =A0 =A000000000a0000000-00000000a00ff=
fff</div><div>PCI: Fixup bus devices 1 (0000:00:00.0)</div><div>pci_busdev_=
to_OF_node(1,0x0)</div><div>*** scan_OF_for_pci_dev() reg[0]: 0x0 =A0psize:=
0x14 devfn:0x0</div>
<div>=A0parent is /pcie@ffe09000/pcie@0</div><div>=A0result is &lt;NULL&gt;=
</div><div>PCI: Try to map irq for 0000:01:00.0...</div><div>pci_busdev_to_=
OF_node(1,0x0)</div><div>*** scan_OF_for_pci_dev() reg[0]: 0x0 =A0psize:0x1=
4 devfn:0x0</div>
<div>=A0parent is /pcie@ffe09000/pcie@0</div><div>=A0result is &lt;NULL&gt;=
</div><div>pci_busdev_to_OF_node(0,0x0)</div><div>=A0parent is /pcie@ffe090=
00</div><div>*** scan_OF_for_pci_dev() reg[0]: 0x0 =A0psize:0x14 devfn:0x0<=
/div>
<div>=A0result is /pcie@ffe09000/pcie@0</div><div>=A0Got one, spec 1 cells =
(0x00000001 0xffffffff...) on /soc@ffe00000/pic@40000</div><div>=A0 alloc i=
rq_desc for 16 on node 0</div><div>=A0 alloc kstat_irqs on node 0</div><div=
>irq: irq 1 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16</div>
<div>=A0Mapped to linux irq 16</div><div>pci_bus 0000:01: bus scan returnin=
g with max=3D01</div><div>pci_bus 0000:00: bus scan returning with max=3D01=
</div><div>PCI: Scanning PHB /pcie@ffe0a000</div><div>PCI: PHB IO resource =
=A0 =A0=3D 00000000ff7db000-00000000ff7eafff [100]</div>
<div>PCI: PHB MEM resource 0 =3D 00000000b0000000-00000000bfffffff [200]</d=
iv><div>PCI: PHB MEM offset =A0 =A0 =3D 0000000000000000</div><div>PCI: PHB=
 IO =A0offset =A0 =A0 =3D ff7db000</div><div>=A0 =A0 probe mode: 0</div><di=
v>pci_bus 0001:02: scanning bus</div>
<div>pci 0001:02:00.0: found [1957:0100] class 000b20 header type 01</div><=
div>pci 0001:02:00.0: ignoring class b20 (doesn&#39;t match header type 01)=
</div><div>pci 0001:02:00.0: calling fixup_hide_host_resource_fsl+0x0/0x54<=
/div>
<div>pci 0001:02:00.0: calling pcibios_fixup_resources+0x0/0x19c</div><div>=
pci 0001:02:00.0: calling quirk_fsl_pcie_header+0x0/0x50</div><div>pci 0001=
:02:00.0: calling quirk_resource_alignment+0x0/0x1a8</div><div>pci 0001:02:=
00.0: supports D1 D2</div>
<div>pci 0001:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold</div><div>=
pci 0001:02:00.0: PME# disabled</div><div>pci_bus 0001:02: fixups for bus</=
div><div>PCI: Fixup bus devices 2 (PHB)</div><div>pci_busdev_to_OF_node(2,0=
x0)</div>
<div>=A0parent is /pcie@ffe0a000</div><div>*** scan_OF_for_pci_dev() reg[0]=
: 0x0 =A0psize:0x14 devfn:0x0</div><div>=A0result is /pcie@ffe0a000/pcie@0<=
/div><div>PCI: Try to map irq for 0001:02:00.0...</div><div>pci_busdev_to_O=
F_node(2,0x0)</div>
<div>=A0parent is /pcie@ffe0a000</div><div>*** scan_OF_for_pci_dev() reg[0]=
: 0x0 =A0psize:0x14 devfn:0x0</div><div>=A0result is /pcie@ffe0a000/pcie@0<=
/div><div>pci 0001:02:00.0: scanning [bus 01-01] behind bridge, pass 0</div=
><div>
pci 0001:02:00.0: bus configuration invalid, reconfiguring</div><div>pci 00=
01:02:00.0: scanning [bus 00-00] behind bridge, pass 1</div><div>pci_bus 00=
01:03: scanning bus</div><div>pci_bus 0001:03: fixups for bus</div><div>
pci 0001:02:00.0: PCI bridge to [bus 03-ff]</div><div>pci 0001:02:00.0: =A0=
 bridge window [io =A00x0000-0x0000] (disabled)</div><div>pci 0001:02:00.0:=
 =A0 bridge window [mem 0xb0000000-0xb00fffff]</div><div>pci 0001:02:00.0: =
=A0 bridge window [mem 0x10000000-0x000fffff pref] (disabled)</div>
<div>PCI:0001:02:00.0 Bus rsrc 1 00000000b0000000-00000000b00fffff [200] fi=
xup...</div><div>PCI:0001:02:00.0 =A0 =A0 =A0 =A0 =A0 =A000000000b0000000-0=
0000000b00fffff</div><div>PCI: Fixup bus devices 3 (0001:02:00.0)</div><div=
>pci_bus 0001:03: bus scan returning with max=3D03</div>
<div>pci_bus 0001:02: bus scan returning with max=3D03</div><div>PCI-&gt;OF=
 bus map (pci_bus_count=3D4):</div><div>0 -&gt; 0</div><div>2 -&gt; 0</div>=
<div>PCI: Allocating bus resources for 0000:00...</div><div>PCI: PHB (bus 0=
) bridge rsrc 0: 00000000ff7ed000-00000000ff7fcfff [0x100], parent c04cd81c=
 (PCI IO)</div>
<div>PCI: PHB (bus 0) bridge rsrc 1: 00000000a0000000-00000000afffffff [0x2=
00], parent c04cd800 (PCI mem)</div><div>PCI: Allocating bus resources for =
0000:01...</div><div>PCI: 0000:00:00.0 (bus 1) bridge rsrc 0: 00000000ff7ed=
000-00000000ff7fcfff [0x100], parent c05a204c (/pcie@ffe09000)</div>
<div>PCI: 0000:00:00.0 (bus 1) bridge rsrc 1: 00000000a0000000-00000000afff=
ffff [0x200], parent c05a2068 (/pcie@ffe09000)</div><div>PCI: Allocating bu=
s resources for 0001:02...</div><div>PCI: PHB (bus 2) bridge rsrc 0: 000000=
00ff7db000-00000000ff7eafff [0x100], parent c04cd81c (PCI IO)</div>
<div>PCI: PHB (bus 2) bridge rsrc 1: 00000000b0000000-00000000bfffffff [0x2=
00], parent c04cd800 (PCI mem)</div><div>PCI: Allocating bus resources for =
0001:03...</div><div>PCI: 0001:02:00.0 (bus 3) bridge rsrc 0: 00000000ff7db=
000-00000000ff7eafff [0x100], parent c05a212c (/pcie@ffe0a000)</div>
<div>PCI: 0001:02:00.0 (bus 3) bridge rsrc 1: 00000000b0000000-00000000bfff=
ffff [0x200], parent c05a2148 (/pcie@ffe0a000)</div><div>PCI: Allocating 00=
00:01:00.0: Resource 0: 00000000a0000000..00000000a00003ff [40200]</div>
<div>PCI: Allocating 0000:01:00.0: Resource 1: 00000000a0010000..00000000a0=
01ffff [40200]</div><div>Reserving legacy ranges for domain 0000</div><div>=
Candidate legacy IO: [io =A00xff7ed000-0xff7edfff]</div><div>PCI 0000:00 Ca=
nnot reserve Legacy IO [io =A00xff7ed000-0xff7edfff]</div>
<div>hose mem offset: 0000000000000000</div><div>hose mem res: [mem 0xa0000=
000-0xafffffff]</div><div>Reserving legacy ranges for domain 0001</div><div=
>Candidate legacy IO: [io =A00xff7db000-0xff7dbfff]</div><div>PCI 0001:02 C=
annot reserve Legacy IO [io =A00xff7db000-0xff7dbfff]</div>
<div>hose mem offset: 0000000000000000</div><div>hose mem res: [mem 0xb0000=
000-0xbfffffff]</div><div>PCI: Assigning unassigned resources...</div><div>=
pci 0000:00:00.0: PCI bridge to [bus 01-01]</div><div>pci 0000:00:00.0: =A0=
 bridge window [io =A00xff7ed000-0xff7fcfff]</div>
<div>pci 0000:00:00.0: =A0 bridge window [mem 0xa0000000-0xafffffff]</div><=
div>pci 0000:00:00.0: =A0 bridge window [mem pref disabled]</div><div>pci 0=
000:00:00.0: enabling device (0106 -&gt; 0107)</div><div>pci 0001:02:00.0: =
PCI bridge to [bus 03-03]</div>
<div>pci 0001:02:00.0: =A0 bridge window [io =A00xff7db000-0xff7eafff]</div=
><div>pci 0001:02:00.0: =A0 bridge window [mem 0xb0000000-0xbfffffff]</div>=
<div>pci 0001:02:00.0: =A0 bridge window [mem pref disabled]</div><div>pci =
0001:02:00.0: enabling device (0106 -&gt; 0107)</div>
<div>pci_bus 0000:00: resource 0 [io =A00xff7ed000-0xff7fcfff]</div><div>pc=
i_bus 0000:00: resource 1 [mem 0xa0000000-0xafffffff]</div><div>pci_bus 000=
0:01: resource 0 [io =A00xff7ed000-0xff7fcfff]</div><div>pci_bus 0000:01: r=
esource 1 [mem 0xa0000000-0xafffffff]</div>
<div>pci_bus 0001:02: resource 0 [io =A00xff7db000-0xff7eafff]</div><div>pc=
i_bus 0001:02: resource 1 [mem 0xb0000000-0xbfffffff]</div><div>pci_bus 000=
1:03: resource 0 [io =A00xff7db000-0xff7eafff]</div><div>pci_bus 0001:03: r=
esource 1 [mem 0xb0000000-0xbfffffff]</div>
<div>bio: create slab &lt;bio-0&gt; at 0</div><div>vgaarb: loaded</div><div=
>SCSI subsystem initialized</div><div>libata version 3.00 loaded.</div><div=
>Freescale Elo / Elo Plus DMA driver</div><div>Switching to clocksource tim=
ebase</div>
<div>NET: Registered protocol family 2</div><div><br></div><div>pci 0000:00=
:00.0: calling quirk_cardbus_legacy+0x0/0x50</div><div>pci 0000:00:00.0: ca=
lling quirk_usb_early_handoff+0x0/0x6ac</div><div>pci 0000:01:00.0: calling=
 quirk_cardbus_legacy+0x0/0x50</div>
<div>pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x6ac</div><div>=
pci 0001:02:00.0: calling quirk_cardbus_legacy+0x0/0x50</div><div>pci 0001:=
02:00.0: calling quirk_usb_early_handoff+0x0/0x6ac</div><div><br></div>
<br><div class=3D"gmail_quote">2012/9/26 Kumar Gala <span dir=3D"ltr">&lt;<=
a href=3D"mailto:galak@kernel.crashing.org" target=3D"_blank">galak@kernel.=
crashing.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; 2012/9/24 Davide Viti &lt;<a href=3D"mailto:zinosat@tiscali.it">zinosa=
t@tiscali.it</a>&gt;<br>
&gt; Hi,<br>
&gt; does the output I&#39;ve included show anything wrong or should I post=
 something else to help identifying the cause of the problem?<br>
&gt;<br>
&gt; thank you in advance,<br>
&gt; Davide<br>
&gt;<br>
&gt; 2012/9/21 Davide Viti &lt;<a href=3D"mailto:zinosat@tiscali.it">zinosa=
t@tiscali.it</a>&gt;<br>
&gt; I mean there are two controllers and both of them have a device &quot;=
subtended&quot; (both 0x1b65:0xabba).<br>
&gt; u-boot can see both devices, linux detects only the device attached to=
 the first controller.<br>
&gt;<br>
&gt; Here&#39;s the output of lspci and /proc/iomem :<br>
&gt;<br>
&gt; root@(none):/# lspci -v<br>
&gt;<br>
&gt; 0000:00:00.0 Class 0604: Device 1957:0100 (rev 11)<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Flags: bus master, fast devsel, latency 0<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Memory at &lt;ignored&gt; (32-bit, non-prefetchable)<b=
r>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Bus: primary=3D00, secondary=3D01, subordinate=3D01, s=
ec-latency=3D0<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 I/O behind bridge: 00000000-00000fff<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Memory behind bridge: a0000000-afffffff<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [44] Power Management version 2<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [4c] Express Root Port (Slot-), MSI 00<b=
r>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [100] Advanced Error Reporting<br>
&gt;<br>
&gt;<br>
&gt; 0000:01:00.0 Class 0280: Device 1b65:abba (rev 01)<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Flags: bus master, fast devsel, latency 0, IRQ 16<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Memory at a0000000 (32-bit, non-prefetchable) [size=3D=
1K]<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Memory at a0010000 (32-bit, non-prefetchable) [size=3D=
64K]<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- =
64bit+<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [78] Power Management version 3<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [80] Express Endpoint, MSI 00<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [100] Virtual Channel &lt;?&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [800] Advanced Error Reporting<br>
&gt;<br>
&gt;<br>
&gt; 0001:02:00.0 Class 0604: Device 1957:0100 (rev 11)<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Flags: bus master, fast devsel, latency 0<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Memory at &lt;ignored&gt; (32-bit, non-prefetchable)<b=
r>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Bus: primary=3D00, secondary=3D03, subordinate=3D03, s=
ec-latency=3D0<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 I/O behind bridge: 00000000-00000fff<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Memory behind bridge: b0000000-bfffffff<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [44] Power Management version 2<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [4c] Express Root Port (Slot-), MSI 00<b=
r>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Capabilities: [100] Advanced Error Reporting<br>
<br>
</div></div>Its possible that in linux the 2nd controller does not believe =
it has link status. =A0Can you see if there is a function like fsl_pcie_che=
ck_link() in your kernel. =A0If so maybe add a printk debug message there a=
nd see what gets return.<br>

<br>
Also helpful to post a full boot log.<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; root@(none):/# cat /proc/iomem<br>
&gt;<br>
&gt; a0000000-afffffff : /pcie@ffe09000<br>
&gt;<br>
&gt; =A0 a0000000-afffffff : PCI Bus 0000:01<br>
&gt;<br>
&gt; =A0 =A0 a0000000-a00003ff : 0000:01:00.0<br>
&gt;<br>
&gt; =A0 =A0 a0010000-a001ffff : 0000:01:00.0<br>
&gt;<br>
&gt; b0000000-bfffffff : /pcie@ffe0a000<br>
&gt;<br>
&gt; =A0 b0000000-bfffffff : PCI Bus 0001:03<br>
&gt;<br>
&gt; ef000000-efffffff : ef000000.nor<br>
&gt;<br>
&gt; ffe04500-ffe04507 : serial<br>
&gt;<br>
&gt; ffe04600-ffe04607 : serial<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; thanx for your help,<br>
&gt;<br>
&gt; Davide<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I mean that the kernel detects the first controller and the device att=
ached to it, plus the second controller: the device on the second controlle=
r is not detected (same device as the one detected on the first controller)=
<br>

&gt;<br>
&gt; 2012/9/21 Kumar Gala &lt;<a href=3D"mailto:galak@kernel.crashing.org">=
galak@kernel.crashing.org</a>&gt;<br>
&gt;<br>
&gt; On Sep 21, 2012, at 6:33 AM, Davide Viti wrote:<br>
&gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt; I&#39;m working on a custom board based on P1020 with two (identi=
cal) PCI devices attached;<br>
&gt; &gt; The work is derived from another board with a single instance of =
that device.<br>
&gt; &gt; The system is based on u-boot-2009.11 and Linux 2.6.34.6<br>
&gt; &gt;<br>
&gt; &gt; The &quot;pci&quot; command on u-boot, shows me both the PCI cont=
rollers and<br>
&gt; &gt; the attached devices:<br>
&gt; &gt;<br>
&gt; &gt; Scanning PCI devices on bus 0<br>
&gt; &gt; BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 S=
ub-Class<br>
&gt; &gt; _____________________________________________________________<br>
&gt; &gt; 00.00.00 =A0 0x1957 =A0 =A0 0x0100 =A0 =A0 Processor =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 0x20<br>
&gt; &gt;<br>
&gt; &gt; Scanning PCI devices on bus 1<br>
&gt; &gt; BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 S=
ub-Class<br>
&gt; &gt; _____________________________________________________________<br>
&gt; &gt; 01.00.00 =A0 0x1b65 =A0 =A0 0xabba =A0 =A0 Network controller =A0=
 =A0 =A00x80<br>
&gt; &gt;<br>
&gt; &gt; Scanning PCI devices on bus 2<br>
&gt; &gt; BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 S=
ub-Class<br>
&gt; &gt; _____________________________________________________________<br>
&gt; &gt; 02.00.00 =A0 0x1957 =A0 =A0 0x0100 =A0 =A0 Processor =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 0x20<br>
&gt; &gt;<br>
&gt; &gt; Scanning PCI devices on bus 3<br>
&gt; &gt; BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 S=
ub-Class<br>
&gt; &gt; _____________________________________________________________<br>
&gt; &gt; 03.00.00 =A0 0x1b65 =A0 =A0 0xabba =A0 =A0 Network controller =A0=
 =A0 =A00x80<br>
&gt; &gt;<br>
&gt; &gt; The kernel detects only the first instance of the device.<br>
&gt;<br>
&gt; What do you mean by first instance of the device ?<br>
&gt;<br>
&gt; &gt; Didn&#39;t get very far while looking at dts file and kernel logs=
, so I&#39;m<br>
&gt; &gt; asking for some help on narrowing down the problem.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m wondering if I can assume that the problem is restricted =
to<br>
&gt; &gt; kernel/dts and avoid concentrating on uboot.<br>
&gt; &gt; I can provide any log (didn&#39;t want to post tons of details on=
 the first<br>
&gt; &gt; message)<br>
&gt;<br>
&gt; Probably a dts issue.<br>
&gt;<br>
&gt; What does lspci in linux say?<br>
&gt;<br>
&gt; - k<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.oz=
labs.org</a><br>
&gt; <a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_=
blank">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
<br>
</blockquote></div><br>

--047d7b339c832b6de904ca9c70bd--
