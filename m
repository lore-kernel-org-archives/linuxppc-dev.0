Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 4F07EDDE01
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 01:54:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Problems with PCI-E devices not being detected with switch
Date: Fri, 17 Oct 2008 09:54:10 -0500
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F829@tanisys-ex2.Tanisys.Local>
In-Reply-To: <1224202209.7654.36.camel@pasglop>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
	<1224202209.7654.36.camel@pasglop>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2008-10-16 at 10:01 -0500, Ayman El-Khashab wrote:
>> Benjamin Herrenschmidt wrote:
>>> On Wed, 2008-10-15 at 10:47 -0500, Ayman El-Khashab wrote:
>>>=20
>>> Note for people on CC: This is a problem on 460EX on a canyonland
>>> using the 4x port.=20
>>>=20
>=20
> Ok, can you send me a full dmesg log with "debug" on the kernel
> command line after adding a #define DEBUG 1 to the top of
> drivers/pci/probe.c please ? (before the batch of #include). =20
>=20

Yes, it is below.  I saw the #define DEBUG 1 turned on these messages
below, but I am not sure how to verify that I correctly added the=20
"debug" to the kernel arguments.  (In u-boot I added them to the end
of the ramargs variable)

thanks,
- ame


# dmesg
Linux version 2.6.27-01160-gc08fd34-dirty (mfg@lablinux) (gcc version =
4.2.2) #11
 Fri Oct 17 09:32:16 CDT 2008
Found initrd at 0xc6cd5000:0xc6fffbc7
Found legacy serial port 0 for /plb/opb/serial@ef600300
  mem=3D4ef600300, taddr=3D4ef600300, irq=3D0, clk=3D7407407, speed=3D0
Found legacy serial port 1 for /plb/opb/serial@ef600400
  mem=3D4ef600400, taddr=3D4ef600400, irq=3D0, clk=3D7407407, speed=3D0
Found legacy serial port 2 for /plb/opb/serial@ef600500
  mem=3D4ef600500, taddr=3D4ef600500, irq=3D0, clk=3D7407407, speed=3D0
Found legacy serial port 3 for /plb/opb/serial@ef600600
  mem=3D4ef600600, taddr=3D4ef600600, irq=3D0, clk=3D7407407, speed=3D0
Top of RAM: 0x20000000, Total RAM: 0x20000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00020000
  Normal   0x00020000 -> 0x00020000
  HighMem  0x00020000 -> 0x00020000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00020000
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat c0344a78, node_mem_map c0372000
  DMA zone: 130048 pages, LIFO batch:31
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
130048
Kernel command line: ramdisk_size=3D65536 root=3D/dev/ram rw debug =
ip=3D169.254.0.102:
169.254.0.100:169.254.0.100:255.255.255.0:tanosx:eth0:off panic=3D1 =
console=3DttyS0,
115200
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0
UIC3 (32 IRQ sources) at DCR 0xf0
PID hash table entries: 2048 (order: 11, 8192 bytes)
time_init: decrementer frequency =3D 800.000010 MHz
time_init: processor frequency   =3D 800.000010 MHz
clocksource: timebase mult[500000] shift[22] registered
clockevent: decrementer mult[cccc] shift[16] cpu[0]
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
High memory: 0k
Memory: 512640k/524288k available (3228k kernel code, 11320k reserved, =
124k data
, 138k bss, 160k init)
SLUB: Genslabs=3D10, HWalign=3D32, Order=3D0-3, MinObjects=3D0, =
CPUs=3D1, Nodes=3D1
Calibrating delay loop... 1597.44 BogoMIPS (lpj=3D3194880)
Mount-cache hash table entries: 512
net_namespace: 288 bytes
NET: Registered protocol family 16
256k L2-cache enabled
PCIE0: Checking link...
PCIE0: No device detected.
PCI host bridge /plb/pciex@d00000000 (primary) ranges:
 MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000
  IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE0: successfully set as endpoint
PCIE1: Checking link...
PCIE1: Device detected, waiting for link...
PCIE1: link is up !
PCI host bridge /plb/pciex@d20000000 (primary) ranges:
 MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
  IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE1: successfully set as root-complex
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCI: Probing PCI hardware
PCI: Scanning bus 0000:40
pci 0000:40:00.0: found [eee0/fed0] class 000b20 header type 00
PCI: 0000:40:00.0 reg 10 64bit mmio: [0, 1ffffff]
PCI: Hiding 4xx host bridge resources 0000:40:00.0
PCI: Fixups for bus 0000:40
PCI: Bus scan for 0000:40 returning with max=3D40
PCI: Scanning bus 0001:80
pci 0001:80:00.0: found [aaa1/bed1] class 000604 header type 01
PCI: 0001:80:00.0 reg 10 32bit mmio: [0, 7fffffff]
PCI: Hiding 4xx host bridge resources 0001:80:00.0
PCI: Fixups for bus 0001:80
pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 0
PCI: Scanning bus 0001:81
pci 0001:81:00.0: found [10b5/8509] class 000604 header type 01
PCI: 0001:81:00.0 reg 10 32bit mmio: [b8000000, b801ffff]
pci 0001:81:00.0: PME# supported from D0 D3hot D3cold
pci 0001:81:00.0: PME# disabled
PCI: Fixups for bus 0001:81
PCI: bridge 0001:80:00.0 io port: [0, fff]
PCI: bridge 0001:80:00.0 32bit mmio: [b8000000, b81fffff]
pci 0001:81:00.0: scanning behind bridge, config 060201, pass 0
PCI: Scanning bus 0001:02
pci 0001:02:00.0: found [8201/3e00] class 0091ed header type 48
pci 0001:02:00.0: unknown header type 48, ignoring device
pci 0001:02:01.0: found [2822/c78a] class 008846 header type 11
pci 0001:02:01.0: unknown header type 11, ignoring device
pci 0001:02:02.0: found [8201/3e00] class 0091ed header type 48
pci 0001:02:02.0: unknown header type 48, ignoring device
pci 0001:02:03.0: found [2822/c78a] class 008846 header type 51
pci 0001:02:03.0: unknown header type 51, ignoring device
pci 0001:02:04.0: found [8201/3e08] class 0091ed header type 48
pci 0001:02:04.0: unknown header type 48, ignoring device
pci 0001:02:05.0: found [2822/c78a] class 008846 header type 51
pci 0001:02:05.0: unknown header type 51, ignoring device
pci 0001:02:06.0: found [8201/3e00] class 0091ed header type 48
pci 0001:02:06.0: unknown header type 48, ignoring device
pci 0001:02:07.0: found [2822/c78a] class 008846 header type 51
pci 0001:02:07.0: unknown header type 51, ignoring device
pci 0001:02:08.0: found [8201/3e08] class 0091ed header type 48
pci 0001:02:08.0: unknown header type 48, ignoring device
pci 0001:02:09.0: found [2822/c78a] class 008842 header type 51
pci 0001:02:09.0: unknown header type 51, ignoring device
pci 0001:02:0a.0: found [8201/3e08] class 0091ed header type 48
pci 0001:02:0a.0: unknown header type 48, ignoring device
pci 0001:02:0b.0: found [2822/c78a] class 008846 header type 51
pci 0001:02:0b.0: unknown header type 51, ignoring device
pci 0001:02:0c.0: found [8201/3e08] class 0091ed header type 48
pci 0001:02:0c.0: unknown header type 48, ignoring device
pci 0001:02:0d.0: found [2822/c78a] class 008846 header type 51
pci 0001:02:0d.0: unknown header type 51, ignoring device
pci 0001:02:0e.0: found [8201/3e00] class 0091ed header type 48
pci 0001:02:0e.0: unknown header type 48, ignoring device
pci 0001:02:0f.0: found [2822/c78a] class 008846 header type 51
pci 0001:02:0f.0: unknown header type 51, ignoring device
pci 0001:02:10.0: found [8201/3e08] class 0091ed header type 48
pci 0001:02:10.0: unknown header type 48, ignoring device
pci 0001:02:11.0: found [2822/c78a] class 008846 header type 51
pci 0001:02:11.0: unknown header type 51, ignoring device
pci 0001:02:12.0: found [8201/3e08] class 0091ed header type 48
pci 0001:02:12.0: unknown header type 48, ignoring device
pci 0001:02:13.0: found [2822/c78a] class 008846 header type 51
pci 0001:02:13.0: unknown header type 51, ignoring device
pci 0001:02:14.0: found [8201/3e08] class 0091ed header type 48
pci 0001:02:14.0: unknown header type 48, ignoring device
pci 0001:02:15.0: found [2822/c78a] class 008846 header type 51
pci 0001:02:15.0: unknown header type 51, ignoring device
pci 0001:02:16.0: found [8201/3e08] class 0091ed header type 48
pci 0001:02:16.0: unknown header type 48, ignoring device
pci 0001:02:17.0: found [2822/c78a] class 008846 header type 51
pci 0001:02:17.0: unknown header type 51, ignoring device
pci 0001:02:18.0: found [8201/3e00] class 0091ed header type 48
pci 0001:02:18.0: unknown header type 48, ignoring device
pci 0001:02:19.0: found [2822/c78a] class 008842 header type 51
pci 0001:02:19.0: unknown header type 51, ignoring device
pci 0001:02:1a.0: found [8201/3e00] class 0091ed header type 48
pci 0001:02:1a.0: unknown header type 48, ignoring device
pci 0001:02:1b.0: found [2822/c78a] class 008846 header type 11
pci 0001:02:1b.0: unknown header type 11, ignoring device
pci 0001:02:1c.0: found [8201/3e08] class 0099ed header type 48
pci 0001:02:1c.0: unknown header type 48, ignoring device
pci 0001:02:1d.0: found [2822/c78a] class 008846 header type 11
pci 0001:02:1d.0: unknown header type 11, ignoring device
pci 0001:02:1e.0: found [8201/3e08] class 0091ed header type 48
pci 0001:02:1e.0: unknown header type 48, ignoring device
pci 0001:02:1f.0: found [2822/c78a] class 008846 header type 11
pci 0001:02:1f.0: unknown header type 11, ignoring device
PCI: Fixups for bus 0001:02
PCI: bridge 0001:81:00.0 32bit mmio: [b8100000, b81fffff]
PCI: Bus scan for 0001:02 returning with max=3D02
PCI: Bus #02 (-#06) is partially hidden behind bridge #81 (-#bf)
pci 0001:81:00.0: scanning behind bridge, config 060201, pass 1
PCI: Bus scan for 0001:81 returning with max=3D81
pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 1
PCI: Bus scan for 0001:80 returning with max=3Dbf
PCI: Scanning bus 0002:00
PCI: Fixups for bus 0002:00
PCI: Bus scan for 0002:00 returning with max=3D00
pci 0001:81:00.0: PCI bridge, secondary bus 0001:02
pci 0001:81:00.0:   IO window: disabled
pci 0001:81:00.0:   MEM window: disabled
pci 0001:81:00.0:   PREFETCH window: disabled
pci 0001:80:00.0: PCI bridge, secondary bus 0001:81
pci 0001:80:00.0:   IO window: disabled
pci 0001:80:00.0:   MEM window: 0x80000000-0x800fffff
pci 0001:80:00.0:   PREFETCH window: disabled
bus: 40 index 0 io port: [fffc0000, fffcffff]
bus: 40 index 1 mmio: [e00000000, e7fffffff]
bus: 80 index 0 io port: [fffe0000, fffeffff]
bus: 80 index 1 mmio: [e80000000, effffffff]
bus: 81 index 0 mmio: [fffe0000, fffe0fff]
bus: 81 index 1 mmio: [e80000000, e800fffff]
bus: 81 index 2 mmio: [0, 0]
bus: 81 index 3 mmio: [0, 0]
bus: 02 index 0 mmio: [0, 0]
bus: 02 index 1 mmio: [eb8100000, eb81fffff]
bus: 02 index 2 mmio: [0, 0]
bus: 02 index 3 mmio: [0, 0]
bus: 00 index 0 io port: [0, ffff]
bus: 00 index 1 mmio: [d80000000, dffffffff]
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs...it isn't (no cpio magic); looks like an =
initrd
Freeing initrd memory: 3242k freed
SATA port disabled via device-tree
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
msgmni has been set to 1008
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pcieport-driver 0001:80:00.0: found MSI capability
pci_express 0001:80:00.0:pcie00: allocate port service
pci_express 0001:80:00.0:pcie01: allocate port service
pcieport-driver 0001:81:00.0: found MSI capability
aer 0001:80:00.0:pcie01: request IRQ failed
aer: probe of 0001:80:00.0:pcie01 failed with error -38
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
fakephp: Fake PCI Hot Plug Controller Driver
Serial: 8250/16550 driver4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq =3D 19) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq =3D 20) is a 16550A
serial8250.0: ttyS2 at MMIO 0x4ef600500 (irq =3D 29) is a 16550A
serial8250.0: ttyS3 at MMIO 0x4ef600600 (irq =3D 21) is a 16550A
4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq =3D 19) is a 16550A
4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq =3D 20) is a 16550A
4ef600500.serial: ttyS2 at MMIO 0x4ef600500 (irq =3D 29) is a 16550A
4ef600600.serial: ttyS3 at MMIO 0x4ef600600 (irq =3D 21) is a 16550A
brd: module loaded
PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
TAH /plb/opb/emac-tah@ef601350 initialized
TAH /plb/opb/emac-tah@ef601450 initialized
/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:01:02:b9
eth0: found Generic MII PHY (0x00)
/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:81:02:b9
eth1: found Generic MII PHY (0x01)
Driver 'sd' needs updating - please use bus_type methods
4cc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
4cc000000.nor_flash: CFI does not contain boot bank location. Assuming =
top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
Creating 7 MTD partitions on "4cc000000.nor_flash":
0x00000000-0x001e0000 : "kernel"
0x001e0000-0x00200000 : "dtb"
0x00200000-0x01600000 : "ramdisk"
0x01600000-0x01a00000 : "jffs2"
0x01a00000-0x03f60000 : "user"
0x03f60000-0x03fa0000 : "env"
0x03fa0000-0x04000000 : "u-boot"
NDFC NAND Driver initialized. Chip-Rev: 0x00000111
NAND device: Manufacturer ID: 0x20, Chip ID: 0xf1 (ST Micro NAND 128MiB =
3,3V 8-b
it)
Scanning device for bad blocks
Bad eraseblock 764 at 0x05f80000
Number of partitions 3
Creating 3 MTD partitions on "NAND 128MiB 3,3V 8-bit":
0x00000000-0x00100000 : "u-boot"
0x00100000-0x00140000 : "env"
0x00140000-0x08000000 : "content"
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ppc-of-ohci 4bffd0000.usb: OF OHCI
ppc-of-ohci 4bffd0000.usb: new USB bus registered, assigned bus number 1
ppc-of-ohci 4bffd0000.usb: irq 37, io mem 0x4bffd0000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: OF OHCI
usb usb1: Manufacturer: Linux 2.6.27-01160-gc08fd34-dirty ohci_hcd
usb usb1: SerialNumber: PPC-OF USB
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
dwc_otg: version 2.60a 22-NOV-2006
dwc_otg: Shared Tx FIFO mode
dwc_otg: Using Slave mode
dwc_otg dwc_otg.0: DWC OTG Controller
dwc_otg dwc_otg.0: new USB bus registered, assigned bus number 2
dwc_otg dwc_otg.0: irq 28, io mem 0x00000000
dwc_otg: dwc_otg_core_host_init: Unable to clear halt on channel 1
dwc_otg: Init: Port Power? op_state=3D4
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: Product: DWC OTG Controller
usb usb2: Manufacturer: Linux 2.6.27-01160-gc08fd34-dirty dwc_otg_hcd
usb usb2: SerialNumber: dwc_otg.0
i2c /dev entries driver
ibm-iic 4ef600700.i2c: clckdiv =3D 9
rtc-m41t80 0-0068: chip found, driver version 0.05
rtc-m41t80 0-0068: rtc core: registered m41t80 as rtc0
ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
ibm-iic 4ef600800.i2c: clckdiv =3D 9
ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
24c01a EEPROM driver initialized
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
rtc-m41t80 0-0068: setting system clock to 2008-10-17 11:03:37 UTC =
(1224241417)
eth0: link is up, 100 FDX, pause enabled
IP-Config: Complete:
     device=3Deth0, addr=3D169.254.0.102, mask=3D255.255.255.0, =
gw=3D169.254.0.100,
     host=3Dtanosx, domain=3D, nis-domain=3D(none),
     bootserver=3D169.254.0.100, rootserver=3D169.254.0.100, rootpath=3D
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 160k init
