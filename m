Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 0B488474EF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 05:33:41 +1100 (EST)
Message-ID: <4963A402.10002@harris.com>
Date: Tue, 06 Jan 2009 13:33:38 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [QUESTION] 440EPx with PCI to PCIe bridge error
References: <496268E7.5090907@harris.com>	 <1231190318.14860.17.camel@pasglop>
	<49627D33.8030605@harris.com> <1231223634.14860.18.camel@pasglop>
In-Reply-To: <1231223634.14860.18.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> 
>> Here is a complete startup log, with debug turned on as you requested.
>> This is still against 2.6.27.9, as it will take me a little time to
>> build 2.6.28.  Hopefully, this log will be useful in the meantime.
> 
> Can you add "debug" to your kernel command line option or send the
> output of the "dmesg" command please ?
> 
> Cheers,
> Ben.

I've repeated the experiment with 2.6.28.  There is no improvement; I'm
still getting the "can't allocate mem resource" messages.

I've included the log below, with debug turned on in the specific pci
files you mentioned, and with the debug flag passed to the kernel.  At
the end of the log, I did an lspci, and also looked at /sys/bus/pci.
As you will see, the resources are all zero.

I can also try again with one of the "master" or "next" trees.  If you
think that would be helpful, just let me know what tree you would like
me to try.

Thanks again for helping with this.

	Steve


=> run flash_self;setenv bootargs ${bootargs} debug;bootm fd400000 fd900000
## Booting kernel from Legacy Image at fd400000 ...
   Image Name:   Linux-2.6.28-00013-ge007bf7-dirt
   Created:      2009-01-06  18:22:31 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1749398 Bytes =  1.7 MB
   Load Address: 00400000
   Entry Point:  0040045c
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at fd900000 ...
   Image Name:   initramfs
   Created:      2008-11-26  15:13:12 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    2443397 Bytes =  2.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 0fcb7000, end 0ff0b885 ... OK
CPU clock-frequency <- 0x27bc86a4 (667MHz)
CPU timebase-frequency <- 0x27bc86a4 (667MHz)
/plb: clock-frequency <- 9ef21a9 (167MHz)
/plb/opb: clock-frequency <- 4f790d4 (83MHz)
/plb/opb/ebc: clock-frequency <- 34fb5e3 (56MHz)
/plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600400: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600500: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600600: clock-frequency <- a8c000 (11MHz)
Memory <- <0x0 0x0 0xffff000> (255MB)
ENET0: local-mac-address <- 00:10:ec:01:04:d0
ENET1: local-mac-address <- 00:10:ec:01:04:d1

zImage starting: loaded at 0x00400000 (sp: 0x0ff0c828)
Allocating 0x3903b0 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040f000:0x007ca920)...done 0x3781fc bytes
Using loader supplied ramdisk at 0xfcb7000-0xff0b885
initrd head: 0x1f8b0808

Linux/PowerPC load: root=/dev/sda3 rw loglevel=7 ip=137.237.178.105:137.237.179.31:137.237.178.1:255.255.255.0:hydra_temp:eth0:off panic=1 console=ttyS0,115200 debug
Finalizing device tree... flat tree at 0x7d7300
Using Hydra_temp machine description
Linux version 2.6.28-00013-ge007bf7-dirty (sfalco@saf.cs.myharris.net) (gcc version 4.2.2) #138 Tue Jan 6 13:22:15 EST 2009
Found initrd at 0xcfcb7000:0xcff0b885
Found legacy serial port 0 for /plb/opb/serial@ef600300
  mem=1ef600300, taddr=1ef600300, irq=0, clk=11059200, speed=115200
Found legacy serial port 1 for /plb/opb/serial@ef600400
  mem=1ef600400, taddr=1ef600400, irq=0, clk=11059200, speed=0
Found legacy serial port 2 for /plb/opb/serial@ef600500
  mem=1ef600500, taddr=1ef600500, irq=0, clk=11059200, speed=0
Found legacy serial port 3 for /plb/opb/serial@ef600600
  mem=1ef600600, taddr=1ef600600, irq=0, clk=11059200, speed=0
console [udbg0] enabled
setup_arch: bootmem
arch: exit
Top of RAM: 0xffff000, Total RAM: 0xffff000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x0000ffff
  Normal   0x0000ffff -> 0x0000ffff
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x0000ffff
On node 0 totalpages: 65535
free_area_init_node: node 0, pgdat c037077c, node_mem_map c0391000
  DMA zone: 512 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 65023 pages, LIFO batch:15
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65023
Kernel command line: root=/dev/sda3 rw loglevel=7 ip=137.237.178.105:137.237.179.31:137.237.178.1:255.255.255.0:hydra_temp:eth0:off panic=1 console=ttyS0,115200 debug
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0
PID hash table entries: 1024 (order: 10, 4096 bytes)
time_init: decrementer frequency = 666.666660 MHz
time_init: processor frequency   = 666.666660 MHz
clocksource: timebase mult[600000] shift[22] registered
clockevent: decrementer mult[aaaa] shift[16] cpu[0]
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 253492k/262140k available (3380k kernel code, 8340k reserved, 148k data, 92k bss, 160k init)
SLUB: Genslabs=10, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 1331.20 BogoMIPS (lpj=2662400)
Mount-cache hash table entries: 512
net_namespace: 288 bytes
NET: Registered protocol family 16

PCI host bridge /plb/pci@1ec000000 (primary) ranges:
 MEM 0x0000000180000000..0x000000018fffffff -> 0x0000000080000000
  IO 0x00000001e8000000..0x00000001e80fffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCI: Probing PCI hardware
pci 0000:00:00.0: reg 14 32bit mmio: [0x000000-0x7fffffff]
PCI:0000:00:00.0 Resource 1 0000000000000000-000000007fffffff [21208] is unassigned
PCI: Hiding 4xx host bridge resources 0000:00:00.0
pci 0000:00:00.0: supports D1
pci 0000:00:0c.0: supports D1
pci 0000:00:0c.0: PME# supported from D0 D1 D3hot
pci 0000:00:0c.0: PME# disabled
PCI: Fixup bus 0 (PHB)
pci_busdev_to_OF_node(0,0x0)
 parent is /plb/pci@1ec000000
 result is <NULL>
PCI: device 0000:00:00.0 OF node: <none>
pci_busdev_to_OF_node(0,0x60)
 parent is /plb/pci@1ec000000
 result is <NULL>
PCI: device 0000:00:0c.0 OF node: <none>
Try to map irq for 0000:00:00.0...
pci_busdev_to_OF_node(0,0x0)
 parent is /plb/pci@1ec000000
 result is <NULL>
 -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
 -> mapped to linux irq 16
Try to map irq for 0000:00:0c.0...
pci_busdev_to_OF_node(0,0x60)
 parent is /plb/pci@1ec000000
 result is <NULL>
 -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
 -> mapped to linux irq 16
pci 0000:01:00.0: reg 10 32bit mmio: [0x80000000-0x8007ffff]
pci 0000:01:00.0: reg 14 32bit mmio: [0xf0000000-0xffffffff]
PCI:0000:01:00.0 Resource 0 0000000080000000-000000008007ffff [20200] fixup...
PCI:0000:01:00.0            0000000180000000-000000018007ffff
PCI:0000:01:00.0 Resource 1 00000000f0000000-00000000ffffffff [20200] fixup...
PCI:0000:01:00.0            00000001f0000000-00000001ffffffff
pci 0000:00:0c.0: bridge 32bit mmio: [0x80000000-0x800fffff]
PCI: Fixup bus 1 (0000:00:0c.0)
PCI:0000:00:0c.0 Bus rsrc 1 0000000080000000-00000000800fffff [200] fixup...
PCI:0000:00:0c.0            0000000180000000-00000001800fffff
pci_busdev_to_OF_node(1,0x0)
PCI: device 0000:01:00.0 OF node: <none>
Try to map irq for 0000:01:00.0...
pci_busdev_to_OF_node(1,0x0)
pci_busdev_to_OF_node(0,0x60)
 parent is /plb/pci@1ec000000
 result is <NULL>
 -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
 -> mapped to linux irq 16
PCI: PHB (bus 0) bridge rsrc 0: 0000000000000000-00000000000fffff [0x100], parent c0351c80 (PCI IO)
PCI: PHB (bus 0) bridge rsrc 1: 0000000180000000-000000018fffffff [0x200], parent c0351c58 (PCI mem)
PCI: Assigning unassigned resouces...
pci 0000:00:0c.0: BAR 8: can't allocate mem resource [0x180000000-0x18fffffff]
pci 0000:01:00.0: BAR 1: can't allocate mem resource [0x1f0000000-0x1ffffffff]
pci 0000:01:00.0: BAR 0: can't allocate mem resource [0x180000000-0x18007ffff]
pci 0000:00:0c.0: PCI bridge, secondary bus 0000:01
pci 0000:00:0c.0:   IO window: disabled
pci 0000:00:0c.0:   MEM window: disabled
pci 0000:00:0c.0:   PREFETCH window: disabled
bus: 00 index 0 io port: [0x00-0xfffff]
bus: 00 index 1 mmio: [0x180000000-0x18fffffff]
bus: 01 index 0 mmio: [0x0-0x0]
bus: 01 index 1 mmio: [0x0-0x0]
bus: 01 index 2 mmio: [0x0-0x0]
bus: 01 index 3 mmio: [0x0-0x0]
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs... it is
Freeing initrd memory: 2386k freed
msgmni has been set to 500
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x1ef600300 (irq = 17) is a 16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0x1ef600400 (irq = 18) is a 16550A
serial8250.0: ttyS2 at MMIO 0x1ef600500 (irq = 19) is a 16550A
serial8250.0: ttyS3 at MMIO 0x1ef600600 (irq = 20) is a 16550A
1ef600300.serial: ttyS0 at MMIO 0x1ef600300 (irq = 17) is a 16550A
1ef600400.serial: ttyS1 at MMIO 0x1ef600400 (irq = 18) is a 16550A
1ef600500.serial: ttyS2 at MMIO 0x1ef600500 (irq = 19) is a 16550A
1ef600600.serial: ttyS3 at MMIO 0x1ef600600 (irq = 20) is a 16550A
brd: module loaded
PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 2 TX channels, 2 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601000 initialized with MDIO support
/plb/opb/emac-rgmii@ef601000: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:01:04:d0
eth0: found Marvell 88E1111 Ethernet PHY (0x00)
/plb/opb/emac-rgmii@ef601000: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:01:04:d1
eth1: found Marvell 88E1111 Ethernet PHY (0x01)
Uniform Multi-Platform E-IDE driver
ide-gd driver 1.18
Driver 'sd' needs updating - please use bus_type methods
scsi0 : pata_platform
ata1: PATA max PIO6 mmio cmd 0x1c1000000 ctl 0x1c1000098 irq 32
ata1.00: ATA-0: SMC01GBFK6E, CF080204, max MWDMA2
ata1.00: 2001888 sectors, multi 0: LBA
ata1.00: configured for PIO
ata1.00: configured for PIO
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      SMC01GBFK6E      CF08 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 2001888 512-byte hardware sectors: (1.02 GB/977 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 2001888 512-byte hardware sectors: (1.02 GB/977 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
1fc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
1fc000000.nor_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
Creating 9 MTD partitions on "1fc000000.nor_flash":
0x00000000-0x00500000 : "kernel0"
0x00500000-0x00a00000 : "ramdisk0"
0x00a00000-0x00f00000 : "kernel1"
0x00f00000-0x01400000 : "ramdisk1"
0x01400000-0x01900000 : "kernel2"
0x01900000-0x01e00000 : "ramdisk2"
0x03f60000-0x03f80000 : "env0"
0x03f80000-0x03fa0000 : "env1"
0x03fa0000-0x04000000 : "u-boot"
spi_ppc4xx_of 1ef600900.spi: driver initialized
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ppc-of-ehci e0000300.ehci: OF EHCI
ppc-of-ehci e0000300.ehci: new USB bus registered, assigned bus number 1
ppc-of-ehci e0000300.ehci: irq 34, io mem 0xe0000300
ppc-of-ehci e0000300.ehci: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OF EHCI
usb usb1: Manufacturer: Linux 2.6.28-00013-ge007bf7-dirty ehci_hcd
usb usb1: SerialNumber: PPC-OF USB
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ppc-of-ohci e0000400.usb: OF OHCI
ppc-of-ohci e0000400.usb: new USB bus registered, assigned bus number 2
ppc-of-ohci e0000400.usb: irq 35, io mem 0xe0000400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OF OHCI
usb usb2: Manufacturer: Linux 2.6.28-00013-ge007bf7-dirty ohci_hcd
usb usb2: SerialNumber: PPC-OF USB
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
rtc-m41t80 0-0068: chip found, driver version 0.05
rtc-m41t80 0-0068: rtc core: registered m41t65 as rtc0
ibm-iic 1ef600700.i2c: using standard (100 kHz) mode
ibm-iic 1ef600800.i2c: using standard (100 kHz) mode
at24 0-0052: 512 byte 24c04 EEPROM (writable)
ad7414 0-0048: chip found
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
rtc-m41t80 0-0068: setting system clock to 2009-01-06 08:26:29 UTC (1231230389)
eth0: link is down
eth0: link is up, 100 FDX, pause enabled
IP-Config: Complete:
     device=eth0, addr=137.237.178.105, mask=255.255.255.0, gw=137.237.178.1,
     host=hydra_temp, domain=, nis-domain=(none),
     bootserver=137.237.179.31, rootserver=137.237.179.31, rootpath=
Freeing unused kernel memory: 160k init
Checking /dev/sda1
Checking /dev/sda2
Checking /dev/sda3
Checking /dev/sda4
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
init started: BusyBox v1.10.4 (2008-10-27 12:52:02 EDT)
starting pid 912, tty '/dev/ttyS0': '/etc/init.d/rcS'
launcher[970]: launching /bin/craft on /dev/ttyS0
Hydra> !
$ su
Password:
# lspci
00:00.0 Class 0680: Unknown device 1014:027f
00:0c.0 Class 0604: Unknown device 10b5:8112 (rev aa)
01:00.0 Class ff00: Unknown device 1172:0004 (rev 01)
# ls /sys/bus/pci/devices/*
/sys/bus/pci/devices/0000:00:00.0:
broken_parity_status  enable                resource
bus                   irq                   subsystem
class                 local_cpulist         subsystem_device
config                local_cpus            subsystem_vendor
device                modalias              uevent
devspec               msi_bus               vendor

/sys/bus/pci/devices/0000:00:0c.0:
0000:01:00.0          enable                resource
broken_parity_status  irq                   subsystem
bus                   local_cpulist         subsystem_device
class                 local_cpus            subsystem_vendor
config                modalias              uevent
device                msi_bus               vendor
devspec               pci_bus:0000:01

/sys/bus/pci/devices/0000:01:00.0:
broken_parity_status  enable                resource
bus                   irq                   subsystem
class                 local_cpulist         subsystem_device
config                local_cpus            subsystem_vendor
device                modalias              uevent
devspec               msi_bus               vendor
# cat /sys/bus/pci/devices/0000:00:0c.0/resource
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
# cat /sys/bus/pci/devices/0000:01:00.0/resource
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
#
