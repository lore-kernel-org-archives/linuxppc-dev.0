Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 1FE05DE058
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 02:59:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Problems with PCI-E devices not being detected with switch
Date: Wed, 15 Oct 2008 10:47:23 -0500
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
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

I am using the stock canyonlands 460EX development board.  I have=20
the 4L (port 1) configured as a root-complex.  I also have a SIL
pci-e sata card.  When I plug the sata card directly into the=20
canyonlands, everything works as expected.  The sil is detected
in Linux and I can read/write the disk.  The sil is a 3531.

The next step is to place this on the other side of a PCI-E switch.
The particular switch is a PLX 8509.  I connect this to the 4L port
and then connect the sil to a 1L port on the 8509.  When u-boot
comes up, it detects all of the switch ports and the 3531 correctly.=20

The problem occurs when Linux boots. It sees the switch (and looking
in /sys/bus/... confirms it), but nothing on the downstream sides of
the switch (secondary busses) is visible.  There were no boot messages
to indicate it had seen the Sil 3531 and it doesn't function.  We've=20
also tried other PCI-E devices (NI GPIB) on the downstream side and
they are also not detected, so it seems to be something in Linux, my
configuration, etc.  I've included the boot messages below from u-boot
and the kernel.  It is more than just the pci boot messages, but I was
not sure if something else in the log with provide some insight.

Thanks
Ayman


--

AND:  128 MiB
PCI:   Bus Dev VenId DevId Class Int
PCIE0: link is not up.
PCIE0: initialization as root-complex failed
PCIE1: successfully set as root-complex
        03  01  10b5  8509  0604  00
        03  02  10b5  8509  0604  00
        06  00  1095  3531  0180  00
        03  03  10b5  8509  0604  00
        03  04  10b5  8509  0604  00
        02  00  10b5  8509  0604  00
Net:   ppc_4xx_eth0, ppc_4xx_eth1

Type run flash_nfs to mount root filesystem over NFS

Hit any key to stop autoboot:  0
Waiting for PHY auto negotiation to complete.. done
ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
*** Unhandled DHCP Option in OFFER/ACK: 7
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 7
*** Unhandled DHCP Option in OFFER/ACK: 44
DHCP client bound to address 169.254.0.102
## Booting kernel from Legacy Image at fc000000 ...
   Image Name:   Linux-2.6.27-rc6-01149-g59c72dc-
   Created:      2008-09-18  22:17:29 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1616554 Bytes =3D  1.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at fc1e0000
   Booting using the fdt blob at 0xfc1e0000
## Loading init Ramdisk from Legacy Image at fc200000 ...
   Image Name:   Tanisys Ramdisk Image
   Created:      2008-09-18  20:29:45 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3320775 Bytes =3D  3.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Device Tree to 007fc000, end 007ff0c0 ... OK
   Loading Ramdisk to 06cd5000, end 06fffbc7 ... OK
Using Canyonlands machine description
Linux version 2.6.27-rc6-01149-g59c72dc-dirty (aymane@vbox) (gcc version =
4.2.2)
#9 Thu Sep 18 17:17:19 CDT 2008
Found initrd at 0xc6cd5000:0xc6fffbc7
Zone PFN ranges:
  DMA      0x00000000 -> 0x00007000
  Normal   0x00007000 -> 0x00007000
  HighMem  0x00007000 -> 0x00007000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00007000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
28448
Kernel command line: ramdisk_size=3D65536 root=3D/dev/ram rw mem=3D112M =
ip=3D169.254.0.1
02:169.254.0.100:169.254.0.100:255.255.255.0:tanosx:eth0:off panic=3D1 =
console=3Dtty
S0,115200
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0
UIC3 (32 IRQ sources) at DCR 0xf0
PID hash table entries: 512 (order: 9, 2048 bytes)
clocksource: timebase mult[500000] shift[22] registered
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 106764k/114688k available (3188k kernel code, 7784k reserved, =
124k data,
 138k bss, 160k init)
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
PCI: Hiding 4xx host bridge resources 0000:40:00.0
PCI: Hiding 4xx host bridge resources 0001:80:00.0
pci 0001:81:00.0: PME# supported from D0 D3hot D3cold
pci 0001:81:00.0: PME# disabled
PCI: bridge 0001:80:00.0 io port: [0, fff]
PCI: bridge 0001:80:00.0 32bit mmio: [b8000000, b81fffff]
pci 0001:02:00.0: unknown header type 03, ignoring device
pci 0001:02:01.0: unknown header type 41, ignoring device
pci 0001:02:02.0: unknown header type 03, ignoring device
pci 0001:02:03.0: unknown header type 41, ignoring device
pci 0001:02:04.0: ignoring class 1d09 (doesn't match header type 02)
pci 0001:02:05.0: unknown header type 41, ignoring device
pci 0001:02:06.0: ignoring class 1d09 (doesn't match header type 02)
pci 0001:02:07.0: unknown header type 41, ignoring device
pci 0001:02:08.0: unknown header type 03, ignoring device
pci 0001:02:09.0: unknown header type 41, ignoring device
pci 0001:02:0a.0: ignoring class 7d09 (doesn't match header type 02)
pci 0001:02:0b.0: unknown header type 41, ignoring device
pci 0001:02:0c.0: ignoring class 1d01 (doesn't match header type 02)
pci 0001:02:0d.0: unknown header type 41, ignoring device
pci 0001:02:0e.0: ignoring class 7d09 (doesn't match header type 02)
pci 0001:02:0f.0: unknown header type 41, ignoring device
pci 0001:02:10.0: unknown header type 03, ignoring device
pci 0001:02:11.0: unknown header type 41, ignoring device
pci 0001:02:12.0: unknown header type 03, ignoring device
pci 0001:02:13.0: unknown header type 41, ignoring device
pci 0001:02:14.0: unknown header type 03, ignoring device
pci 0001:02:15.0: unknown header type 41, ignoring device
pci 0001:02:16.0: ignoring class 3d09 (doesn't match header type 02)
pci 0001:02:17.0: unknown header type 41, ignoring device
pci 0001:02:18.0: unknown header type 03, ignoring device
pci 0001:02:19.0: unknown header type 41, ignoring device
pci 0001:02:1a.0: unknown header type 03, ignoring device
pci 0001:02:1b.0: unknown header type 41, ignoring device
pci 0001:02:1c.0: ignoring class 5d01 (doesn't match header type 02)
pci 0001:02:1d.0: unknown header type 41, ignoring device
pci 0001:02:1e.0: unknown header type 03, ignoring device
pci 0001:02:1f.0: unknown header type 41, ignoring device
PCI: bridge 0001:81:00.0 32bit mmio: [b8100000, b81fffff]
pci 0001:02:04.0: not setting up bridge for bus 0001:03
pci 0001:02:06.0: not setting up bridge for bus 0001:07
pci 0001:02:0a.0: not setting up bridge for bus 0001:0b
pci 0001:02:0c.0: not setting up bridge for bus 0001:0f
pci 0001:02:0e.0: not setting up bridge for bus 0001:13
pci 0001:02:16.0: not setting up bridge for bus 0001:17
pci 0001:02:1c.0: not setting up bridge for bus 0001:1b
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
bus: 03 index 0 mmio: [0, 0]
bus: 03 index 1 mmio: [0, 0]
bus: 03 index 2 mmio: [0, 0]
bus: 03 index 3 mmio: [0, 0]
bus: 07 index 0 mmio: [0, 0]
bus: 07 index 1 mmio: [0, 0]
bus: 07 index 2 mmio: [0, 0]
bus: 07 index 3 mmio: [0, 0]
bus: 0b index 0 mmio: [0, 0]
bus: 0b index 1 mmio: [0, 0]
bus: 0b index 2 mmio: [0, 0]
bus: 0b index 3 mmio: [0, 0]
bus: 0f index 0 mmio: [0, 0]
bus: 0f index 1 mmio: [0, 0]
bus: 0f index 2 mmio: [0, 0]
bus: 0f index 3 mmio: [0, 0]
bus: 13 index 0 mmio: [0, 0]
bus: 13 index 1 mmio: [0, 0]
bus: 13 index 2 mmio: [0, 0]
bus: 13 index 3 mmio: [0, 0]
bus: 17 index 0 mmio: [0, 0]
bus: 17 index 1 mmio: [0, 0]
bus: 17 index 2 mmio: [0, 0]
bus: 17 index 3 mmio: [0, 0]
bus: 1b index 0 mmio: [0, 0]
bus: 1b index 1 mmio: [0, 0]
bus: 1b index 2 mmio: [0, 0]
bus: 1b index 3 mmio: [0, 0]
bus: 00 index 0 io port: [0, ffff]
bus: 00 index 1 mmio: [d80000000, dffffffff]
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs...it isn't (no cpio magic); looks like an =
initrd
Freeing initrd memory: 3242k freed
SATA port disabled via device-tree
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
msgmni has been set to 215
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pcieport-driver 0001:80:00.0: found MSI capability
pcieport-driver 0001:81:00.0: found MSI capability
aer: probe of 0001:80:00.0:pcie01 failed with error -38
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
fakephp: Fake PCI Hot Plug Controller Driver
Serial: 8250/16550 driver4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq =3D 20) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq =3D 21) is a 16550A
serial8250.0: ttyS2 at MMIO 0x4ef600500 (irq =3D 29) is a 16550A
serial8250.0: ttyS3 at MMIO 0x4ef600600 (irq =3D 22) is a 16550A
4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq =3D 20) is a 16550A
4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq =3D 21) is a 16550A
4ef600500.serial: ttyS2 at MMIO 0x4ef600500 (irq =3D 29) is a 16550A
4ef600600.serial: ttyS3 at MMIO 0x4ef600600 (irq =3D 22) is a 16550A
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
ppc-of-ohci 4bffd0000.usb: OF OHCI
ppc-of-ohci 4bffd0000.usb: new USB bus registered, assigned bus number 1
ppc-of-ohci 4bffd0000.usb: irq 38, io mem 0x4bffd0000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: OF OHCI
usb usb1: Manufacturer: Linux 2.6.27-rc6-01149-g59c72dc-dirty ohci_hcd
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
usb usb2: Manufacturer: Linux 2.6.27-rc6-01149-g59c72dc-dirty =
dwc_otg_hcd
usb usb2: SerialNumber: dwc_otg.0
i2c /dev entries driver
rtc-m41t80 0-0068: chip found, driver version 0.05
rtc-m41t80 0-0068: rtc core: registered m41t80 as rtc0
ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
24c01a EEPROM driver initialized
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
rtc-m41t80 0-0068: setting system clock to 2008-10-15 11:59:27 UTC =
(1224071967)
eth0: link is up, 100 FDX, pause enabled
IP-Config: Complete:
     device=3Deth0, addr=3D169.254.0.102, mask=3D255.255.255.0, =
gw=3D169.254.0.100,
     host=3Dtanosx, domain=3D, nis-domain=3D(none),
     bootserver=3D169.254.0.100, rootserver=3D169.254.0.100, rootpath=3D
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 160k init
