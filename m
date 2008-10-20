Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1149BDDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 08:57:15 +1100 (EST)
Subject: RE: Problems with PCI-E devices not being detected with switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <AymanE@tanisys.com>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F830@tanisys-ex2.Tanisys.Local>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
	<1224202209.7654.36.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F829@tanisys-ex2.Tanisys.Local>
	<1224278340.7654.103.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F830@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain; charset=utf-8
Date: Tue, 21 Oct 2008 08:57:00 +1100
Message-Id: <1224539820.7654.173.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-20 at 16:03 -0500, Ayman El-Khashab wrote:
> Thank you Ben, I've had success with the patch, details below ...
> 
> Benjamin Herrenschmidt wrote:
> 
> > Can you try this (untested) patch and send me the resulting dmesg log
> > (along with whether it helps). 
> > 
> > Index: linux-work/drivers/pci/probe.c
> > ===================================================================
> > --- linux-work.orig/drivers/pci/probe.c	2008-10-18 08:10:25.000000000
> > +1100 +++ linux-work/drivers/pci/probe.c	2008-10-18
> > 08:14:14.000000000 +1100 @@ -536,19 +536,27 @@
> >  	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
> >  	u32 buses, i, j = 0;
> >  	u16 bctl;
> > +	int broken = 0;
> > 
> >  	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
> > 
> >  	dev_dbg(&dev->dev, "scanning behind bridge, config %06x, pass %d\n",
> >  		buses & 0xffffff, pass);
> > 
> > +	/* Check if setup is sensible at all */
> > +	if ((buses & 0xff) != bus->number ||
> > +	    ((buses >> 8) & 0xff) != <= bus->number) {
> 
> Note that I removed the <= from the above line -- I did not think it was 
> correct.  Please let me know if that was wrong.

My logic is that the current setup is incorrect if the primary bus of
the bridge doesn't match the parent bus number, or if the secondary bus
number of the bridge is not strictly superior to the parent bus number. 

What sounds incorrect ?

IE, if you have:


PHB ..(A)...RC...(B)..(switch)...(C)

IE, A is bus number of the root PHB, ie, primary bus number of root
complex virtual bridge. B is secondary number of root complex virtual
bridge, as such primary number of the switch. C is secondary number of
the switch (ie, bus where you device will reside). 

I'm checking here that for the switch, PRIMARY == B and SECONDARY > B

(And for the RC additionally that PRIMARY = A and SECONDARY > A)

Which means that this "second" check basically enforces that A <  B < C

> <snipped rest of patch>
> 
> Attached below is the dmesg output, in this case the SIL on the downstream
> switch port was detected correctly.  Advise if there is something else that
> needs to be tried.

There will be yes. The patch works, which confirm my analysis of the
problem. I will probably send this patch upstream as it makes sense to
improve the kernel robustness here, but we also probably need to add
some sort of flag for the default behaviour on 4xx. I see two options
here:

 - We can implement support in pci_4xx to do config space on the whole
range of bus numbers instead of a subset, using the fixmap logic. That
way, we no longer have limitations, we can ignore the bus ranges
specified in the device-tree and just use the existing mechanism to
re-assign all bus numbers.

 - We can add a header quirk in pci_4xx that clears out
PRIMARY/SECONDARY/SUBORDINATE in all P2P bridges other than the Root
Complex to force them to be re-assigned without having to hit the
workaround.

 - We can implement some kind of ppc_pci_flag that trigger
reconfiguration of all busses but _not_ of PHBs (ie would cause
pcibios_assign_all_busses() to be 1 but wouldn't force assign numbers in
pci_32.c for the root busses).
 
I'm not 100% sure what the best approach is at this stage, any opinion ?

Cheers,
Ben.

> Thanks
> Ayman
> 
> Kernel command line: ramdisk_size=65536 root=/dev/ram rw ip=169.254.0.199:169.20
> UIC0 (32 IRQ sources) at DCR 0xc0
> UIC1 (32 IRQ sources) at DCR 0xd0
> UIC2 (32 IRQ sources) at DCR 0xe0
> UIC3 (32 IRQ sources) at DCR 0xf0
> PID hash table entries: 2048 (order: 11, 8192 bytes)
> time_init: decrementer frequency = 800.000010 MHz
> time_init: processor frequency   = 800.000010 MHz
> clocksource: timebase mult[500000] shift[22] registered
> clockevent: decrementer mult[cccc] shift[16] cpu[0]
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> High memory: 0k
> Memory: 512640k/524288k available (3244k kernel code, 11336k reserved, 124k dat)
> SLUB: Genslabs=10, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Calibrating delay loop... 1597.44 BogoMIPS (lpj=3194880)
> Mount-cache hash table entries: 512
> net_namespace: 288 bytes
> NET: Registered protocol family 16
> 256k L2-cache enabled
> PCIE0: Checking link...
> PCIE0: No device detected.
> PCI host bridge /plb/pciex@d00000000 (primary) ranges:
>  MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000
>   IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
> 4xx PCI DMA offset set to 0x00000000
> PCIE0: successfully set as endpoint
> PCIE1: Checking link...
> PCIE1: Device detected, waiting for link...
> PCIE1: link is up !
> PCI host bridge /plb/pciex@d20000000 (primary) ranges:
>  MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
>   IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
> 4xx PCI DMA offset set to 0x00000000
> PCIE1: successfully set as root-complex
> PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
>  MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
>   IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
> 4xx PCI DMA offset set to 0x00000000
> PCI: Probing PCI hardware
> PCI: Scanning bus 0000:40
> pci 0000:40:00.0: found [eee0/fed0] class 000b20 header type 00
> PCI: 0000:40:00.0 reg 10 64bit mmio: [0, 1ffffff]
> PCI: Hiding 4xx host bridge resources 0000:40:00.0
> PCI: Fixups for bus 0000:40
> PCI: Bus scan for 0000:40 returning with max=40
> PCI: Scanning bus 0001:80
> pci 0001:80:00.0: found [aaa1/bed1] class 000604 header type 01
> PCI: 0001:80:00.0 reg 10 32bit mmio: [0, 7fffffff]
> PCI: Hiding 4xx host bridge resources 0001:80:00.0
> PCI: Fixups for bus 0001:80
> pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 0
> pci 0001:80:00.0: bus configuration doesn't match, reconfiguring
> pci 0001:80:00.0: scanning behind bridge, config 000000, pass 1
> pci 0001:80:00.0: bus configuration doesn't match, reconfiguring
> PCI: Scanning bus 0001:81
> pci 0001:81:00.0: found [10b5/8509] class 000604 header type 01
> PCI: 0001:81:00.0 reg 10 32bit mmio: [b8000000, b801ffff]
> pci 0001:81:00.0: PME# supported from D0 D3hot D3cold
> pci 0001:81:00.0: PME# disabled
> PCI: Fixups for bus 0001:81
> PCI: bridge 0001:80:00.0 io port: [0, fff]
> PCI: bridge 0001:80:00.0 32bit mmio: [b8000000, b81fffff]
> pci 0001:81:00.0: scanning behind bridge, config 060201, pass 0
> pci 0001:81:00.0: bus configuration doesn't match, reconfiguring
> pci 0001:81:00.0: scanning behind bridge, config 000000, pass 1
> pci 0001:81:00.0: bus configuration doesn't match, reconfiguring
> PCI: Scanning bus 0001:82
> pci 0001:82:01.0: found [10b5/8509] class 000604 header type 01
> pci 0001:82:01.0: PME# supported from D0 D3hot D3cold
> pci 0001:82:01.0: PME# disabled
> pci 0001:82:02.0: found [10b5/8509] class 000604 header type 01
> pci 0001:82:02.0: PME# supported from D0 D3hot D3cold
> pci 0001:82:02.0: PME# disabled
> pci 0001:82:03.0: found [10b5/8509] class 000604 header type 01
> pci 0001:82:03.0: PME# supported from D0 D3hot D3cold
> pci 0001:82:03.0: PME# disabled
> pci 0001:82:04.0: found [10b5/8509] class 000604 header type 01
> pci 0001:82:04.0: PME# supported from D0 D3hot D3cold
> pci 0001:82:04.0: PME# disabled
> PCI: Fixups for bus 0001:82
> PCI: bridge 0001:81:00.0 32bit mmio: [b8100000, b81fffff]
> pci 0001:82:01.0: scanning behind bridge, config 030302, pass 0
> pci 0001:82:01.0: bus configuration doesn't match, reconfiguring
> pci 0001:82:02.0: scanning behind bridge, config 040402, pass 0
> pci 0001:82:02.0: bus configuration doesn't match, reconfiguring
> pci 0001:82:03.0: scanning behind bridge, config 050502, pass 0
> pci 0001:82:03.0: bus configuration doesn't match, reconfiguring
> pci 0001:82:04.0: scanning behind bridge, config 060602, pass 0
> pci 0001:82:04.0: bus configuration doesn't match, reconfiguring
> pci 0001:82:01.0: scanning behind bridge, config 000000, pass 1
> pci 0001:82:01.0: bus configuration doesn't match, reconfiguring
> PCI: Scanning bus 0001:83
> PCI: Fixups for bus 0001:83
> PCI: Bus scan for 0001:83 returning with max=83
> pci 0001:82:02.0: scanning behind bridge, config 000000, pass 1
> pci 0001:82:02.0: bus configuration doesn't match, reconfiguring
> PCI: Scanning bus 0001:84
> PCI: Fixups for bus 0001:84
> PCI: Bus scan for 0001:84 returning with max=84
> pci 0001:82:03.0: scanning behind bridge, config 000000, pass 1
> pci 0001:82:03.0: bus configuration doesn't match, reconfiguring
> PCI: Scanning bus 0001:85
> pci 0001:85:00.0: found [1095/3531] class 000180 header type 00
> PCI: 0001:85:00.0 reg 10 64bit mmio: [b8100000, b810007f]
> PCI: 0001:85:00.0 reg 18 64bit mmio: [b8102000, b8103fff]
> PCI: 0001:85:00.0 reg 20 io port: [ffffff80, ffffffff]
> pci 0001:85:00.0: supports D1
> pci 0001:85:00.0: supports D2
> PCI: Fixups for bus 0001:85
> PCI: bridge 0001:82:03.0 32bit mmio: [b8100000, b81fffff]
> PCI: Bus scan for 0001:85 returning with max=85
> pci 0001:82:04.0: scanning behind bridge, config 000000, pass 1
> pci 0001:82:04.0: bus configuration doesn't match, reconfiguring
> PCI: Scanning bus 0001:86
> PCI: Fixups for bus 0001:86
> PCI: Bus scan for 0001:86 returning with max=86
> PCI: Bus scan for 0001:82 returning with max=86
> PCI: Bus scan for 0001:81 returning with max=86
> PCI: Bus scan for 0001:80 returning with max=86
> PCI: Scanning bus 0002:00
> PCI: Fixups for bus 0002:00
> PCI: Bus scan for 0002:00 returning with max=00
> pci 0001:82:01.0: PCI bridge, secondary bus 0001:83
> pci 0001:82:01.0:   IO window: disabled
> pci 0001:82:01.0:   MEM window: disabled
> pci 0001:82:01.0:   PREFETCH window: disabled
> pci 0001:82:02.0: PCI bridge, secondary bus 0001:84
> pci 0001:82:02.0:   IO window: disabled
> pci 0001:82:02.0:   MEM window: disabled
> pci 0001:82:02.0:   PREFETCH window: disabled
> pci 0001:82:03.0: PCI bridge, secondary bus 0001:85
> pci 0001:82:03.0:   IO window: 0x00-0xfff
> pci 0001:82:03.0:   MEM window: 0x80000000-0x800fffff
> pci 0001:82:03.0:   PREFETCH window: disabled
> pci 0001:82:04.0: PCI bridge, secondary bus 0001:86
> pci 0001:82:04.0:   IO window: disabled
> pci 0001:82:04.0:   MEM window: disabled
> pci 0001:82:04.0:   PREFETCH window: disabled
> pci 0001:81:00.0: PCI bridge, secondary bus 0001:82
> pci 0001:81:00.0:   IO window: 0x00-0xfff
> pci 0001:81:00.0:   MEM window: 0x80000000-0x800fffff
> pci 0001:81:00.0:   PREFETCH window: disabled
> pci 0001:80:00.0: PCI bridge, secondary bus 0001:81
> pci 0001:80:00.0:   IO window: 0x00-0xfff
> pci 0001:80:00.0:   MEM window: 0x80000000-0x801fffff
> pci 0001:80:00.0:   PREFETCH window: disabled
> pci 0001:81:00.0: enabling device (0006 -> 0007)
> pci 0001:82:03.0: enabling device (0006 -> 0007)
> bus: 40 index 0 io port: [fffc0000, fffcffff]
> bus: 40 index 1 mmio: [e00000000, e7fffffff]
> bus: 80 index 0 io port: [fffe0000, fffeffff]
> bus: 80 index 1 mmio: [e80000000, effffffff]
> bus: 81 index 0 io port: [fffe0000, fffe0fff]
> bus: 81 index 1 mmio: [e80000000, e801fffff]
> bus: 81 index 2 mmio: [0, 0]
> bus: 81 index 3 mmio: [0, 0]
> bus: 82 index 0 io port: [fffe0000, fffe0fff]
> bus: 82 index 1 mmio: [e80000000, e800fffff]
> bus: 82 index 2 mmio: [0, 0]
> bus: 82 index 3 mmio: [0, 0]
> bus: 83 index 0 mmio: [0, 0]
> bus: 83 index 1 mmio: [0, 0]
> bus: 83 index 2 mmio: [0, 0]
> bus: 83 index 3 mmio: [0, 0]
> bus: 84 index 0 mmio: [0, 0]
> bus: 84 index 1 mmio: [0, 0]
> bus: 84 index 2 mmio: [0, 0]
> bus: 84 index 3 mmio: [0, 0]
> bus: 85 index 0 io port: [fffe0000, fffe0fff]
> bus: 85 index 1 mmio: [e80000000, e800fffff]
> bus: 85 index 2 mmio: [0, 0]
> bus: 85 index 3 mmio: [0, 0]
> bus: 86 index 0 mmio: [0, 0]
> bus: 86 index 1 mmio: [0, 0]
> bus: 86 index 2 mmio: [0, 0]
> bus: 86 index 3 mmio: [0, 0]
> bus: 00 index 0 io port: [0, ffff]
> bus: 00 index 1 mmio: [d80000000, dffffffff]
> SCSI subsystem initialized
> libata version 3.00 loaded.
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> NET: Registered protocol family 2
> Switched to high resolution mode on CPU 0
> IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
> TCP established hash table entries: 65536 (order: 7, 524288 bytes)
> TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
> TCP: Hash tables configured (established 65536 bind 65536)
> TCP reno registered
> NET: Registered protocol family 1
> checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
> Freeing initrd memory: 3242k freed
> SATA port disabled via device-tree
> JFFS2 version 2.2. (NAND) Â© 2001-2006 Red Hat, Inc.
> msgmni has been set to 1008
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> pcieport-driver 0001:80:00.0: found MSI capability
> pci_express 0001:80:00.0:pcie00: allocate port service
> pci_express 0001:80:00.0:pcie01: allocate port service
> pcieport-driver 0001:81:00.0: found MSI capability
> pcieport-driver 0001:82:01.0: found MSI capability
> pci_express 0001:82:01.0:pcie22: allocate port service
> pcieport-driver 0001:82:02.0: found MSI capability
> pci_express 0001:82:02.0:pcie22: allocate port service
> pcieport-driver 0001:82:03.0: found MSI capability
> pci_express 0001:82:03.0:pcie22: allocate port service
> pcieport-driver 0001:82:04.0: found MSI capability
> aer 0001:80:00.0:pcie01: request IRQ failed
> aer: probe of 0001:80:00.0:pcie01 failed with error -38
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> pciehp: HPC vendor_id 10b5 device_id 8509 ss_vid 0 ss_did 0
> hpdriver 0001:82:01.0:pcie22: service driver hpdriver loaded
> pciehp: HPC vendor_id 10b5 device_id 8509 ss_vid 0 ss_did 0
> hpdriver 0001:82:02.0:pcie22: service driver hpdriver loaded
> pciehp: HPC vendor_id 10b5 device_id 8509 ss_vid 0 ss_did 0
> hpdriver 0001:82:03.0:pcie22: service driver hpdriver loaded
> pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> fakephp: Fake PCI Hot Plug Controller Driver
> fakephp: pci_hp_register failed with error -16
> Serial: 8250/16550 driver4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 22) is a 16550A
> console [ttyS0] enabled
> serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 24) is a 16550A
> serial8250.0: ttyS2 at MMIO 0x4ef600500 (irq = 29) is a 16550A
> serial8250.0: ttyS3 at MMIO 0x4ef600600 (irq = 25) is a 16550A
> 4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 22) is a 16550A
> 4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 24) is a 16550A
> 4ef600500.serial: ttyS2 at MMIO 0x4ef600500 (irq = 29) is a 16550A
> 4ef600600.serial: ttyS3 at MMIO 0x4ef600600 (irq = 25) is a 16550A
> brd: module loaded
> PPC 4xx OCP EMAC driver, version 3.54
> MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
> ZMII /plb/opb/emac-zmii@ef600d00 initialized
> RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
> TAH /plb/opb/emac-tah@ef601350 initialized
> TAH /plb/opb/emac-tah@ef601450 initialized
> /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
> eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:01:02:b9
> eth0: found Generic MII PHY (0x00)
> /plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
> eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:81:02:b9
> eth1: found Generic MII PHY (0x01)
> Driver 'sd' needs updating - please use bus_type methods
> sata_sil24 0001:85:00.0: version 1.1
> sata_sil24 0001:85:00.0: enabling device (0006 -> 0007)
> scsi0 : sata_sil24
> ata1: SATA max UDMA/100 host m128@0xe80002000 port 0xe80000000 irq 21
> ata1: SATA link down (SStatus 0 SControl 0)
> 4cc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
>  Amd/Fujitsu Extended Query Table at 0x0040
> 4cc000000.nor_flash: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> RedBoot partition parsing not available
> Creating 7 MTD partitions on "4cc000000.nor_flash":
> 0x00000000-0x001e0000 : "kernel"
> 0x001e0000-0x00200000 : "dtb"
> 0x00200000-0x01600000 : "ramdisk"
> 0x01600000-0x01a00000 : "jffs2"
> 0x01a00000-0x03f60000 : "user"
> 0x03f60000-0x03fa0000 : "env"
> 0x03fa0000-0x04000000 : "u-boot"
> NDFC NAND Driver initialized. Chip-Rev: 0x00000111
> NAND device: Manufacturer ID: 0x20, Chip ID: 0xf1 (ST Micro NAND 128MiB 3,3V 8-)
> Scanning device for bad blocks
> Bad eraseblock 764 at 0x05f80000
> Number of partitions 3
> Creating 3 MTD partitions on "NAND 128MiB 3,3V 8-bit":
> 0x00000000-0x00100000 : "u-boot"
> 0x00100000-0x00140000 : "env"
> 0x00140000-0x08000000 : "content"
> ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
> ppc-of-ohci 4bffd0000.usb: OF OHCI
> ppc-of-ohci 4bffd0000.usb: new USB bus registered, assigned bus number 1
> ppc-of-ohci 4bffd0000.usb: irq 40, io mem 0x4bffd0000
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: OF OHCI
> usb usb1: Manufacturer: Linux 2.6.27-01160-gc08fd34-dirty ohci_hcd
> usb usb1: SerialNumber: PPC-OF USB
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> dwc_otg: version 2.60a 22-NOV-2006
> dwc_otg: Shared Tx FIFO mode
> dwc_otg: Using Slave mode
> dwc_otg dwc_otg.0: DWC OTG Controller
> dwc_otg dwc_otg.0: new USB bus registered, assigned bus number 2
> dwc_otg dwc_otg.0: irq 28, io mem 0x00000000
> dwc_otg: dwc_otg_core_host_init: Unable to clear halt on channel 1
> dwc_otg: Init: Port Power? op_state=4
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 1 port detected
> usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: DWC OTG Controller
> usb usb2: Manufacturer: Linux 2.6.27-01160-gc08fd34-dirty dwc_otg_hcd
> usb usb2: SerialNumber: dwc_otg.0
> i2c /dev entries driver
> ibm-iic 4ef600700.i2c: clckdiv = 9
> rtc-m41t80 0-0068: chip found, driver version 0.05
> rtc-m41t80 0-0068: rtc core: registered m41t80 as rtc0
> ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
> ibm-iic 4ef600800.i2c: clckdiv = 9
> ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
> 24c01a EEPROM driver initialized
> TCP cubic registered
> NET: Registered protocol family 17
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> rtc-m41t80 0-0068: setting system clock to 2008-10-20 17:08:34 UTC (1224522514)
> eth0: link is up, 100 FDX, pause enabled
> IP-Config: Complete:
>      device=eth0, addr=169.254.0.199, mask=255.255.255.0, gw=169.254.0.100,
>      host=tanosx, domain=, nis-domain=(none),
>      bootserver=169.254.0.100, rootserver=169.254.0.100, rootpath=
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 160k init
> #
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
