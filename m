Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 9D1EDB7B72
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 04:52:46 +1100 (EST)
Received: from crust.elkhashab.com ([24.28.25.36])
	by hrndva-omta01.mail.rr.com with ESMTP
	id <20091007173047170.ZGQD22999@hrndva-omta01.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2009 17:30:47 +0000
Received: from crust.elkhashab.com (localhost [127.0.0.1])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	n97HUkj1011530
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Oct 2009 12:30:46 -0500
Received: (from ayman@localhost)
	by crust.elkhashab.com (8.14.3/8.14.3/Submit) id n97HUkRJ011529
	for linuxppc-dev@lists.ozlabs.org; Wed, 7 Oct 2009 12:30:46 -0500
Date: Wed, 7 Oct 2009 12:30:46 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Trouble with canyonlands and PCI-E LSI SAS Controller
Message-ID: <20091007173046.GA11156@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, I've got some trouble getting an LSI SAS controller (LSISAS200)
to function.  It is at least enumerated correctly in a PC running
ubuntu, so it seems that it must be something particular to the PCI
implementation on the powerpc or the usage of u-boot.  

If the board is initialized by u-boot, and the BAR0 is written, then 
the board does not seem to respond to cfgrds when linux probes.  And
the kernel crashes when the scsi low level are loaded.  

If u-boot is inhibited and therefore linux sees the card in its reset
state then it will boot ok, but an lspci will show the card as disabled.

The last issue, is that I am not quite sure exactly which kernel drivers
are needed for this device.  

Here is the output from DEBUG=1 in the pci_probe.  The first is without
the fusion driver, and the latter is with the fusion driver.

Thanks
Ayman


# dmesg Bus: primary=80, secondary=81, subordinate=bf, sec-latency=0
Using PowerPC 44x Platform machine description
Linux version 2.6.31 (bobe@lablinux) (gcc version 4.2.2) #61 Tue Oct 6 08:25:39 CDT 2009
Found initrd at 0xdfb09000:0xdfe4cc6eidge: 0000000080100000-00000000801fffff
Found legacy serial port 0 for /plb/opb/serial@ef600300
  mem=4ef600300, taddr=4ef600300, irq=0, clk=6451612, speed=0
Found legacy serial port 1 for /plb/opb/serial@ef600400: Mask- 64bit+ Queue=0/2 Enable-
  mem=4ef600400, taddr=4ef600400, irq=0, clk=6451612, speed=0
Found legacy serial port 2 for /plb/opb/serial@ef600500
  mem=4ef600500, taddr=4ef600500, irq=0, clk=6451612, speed=0
Found legacy serial port 3 for /plb/opb/serial@ef600600
  mem=4ef600600, taddr=4ef600600, irq=0, clk=6451612, speed=0
Top of RAM: 0x20000000, Total RAM: 0x20000000
Memory hole size: 0MBevsel, IRQ 18
Zone PFN ranges:s at 1000 [disabled] [size=256]
  DMA      0x00000000 -> 0x00020000, non-prefetchable) [disabled] [size=16K]
  Normal   0x00020000 -> 0x00020000, non-prefetchable) [disabled] [size=256K]
  HighMem  0x00020000 -> 0x00020000e80100000 [disabled] [size=512K]
Movable zone start PFN for each nodeagement version 3
early_node_map[1] active PFN rangesEndpoint IRQ 0
    0: 0x00000000 -> 0x00020000l Product Data
On node 0 totalpages: 131072essage Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
free_area_init_node: node 0, pgdat c0335654, node_mem_map c0363000
  DMA zone: 1024 pages used for memmaprror Reporting
  DMA zone: 0 pages reservedPower Budgeting
  DMA zone: 130048 pages, LIFO batch:31
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/ram rw mem=128M mem=512M ip=169.254.0.181:169.254.0.100:169.254.0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
High memory: 0k
Memory: 512512k/524288k available (3168k kernel code, 11356k reserved, 128k data, 132k bss, 160)
Kernel virtual memory layout:
  * 0xfffef000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xffa00000..0xffc00000  : consistent mem
  * 0xffa00000..0xffa00000  : early ioremap
  * 0xe1000000..0xffa00000  : vmalloc & ioremap
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:512
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
irq: irq 30 on host /interrupt-controller0 mapped to virtual irq 30
UIC2 (32 IRQ sources) at DCR 0xe0
irq: irq 10 on host /interrupt-controller0 mapped to virtual irq 16
UIC3 (32 IRQ sources) at DCR 0xf0
irq: irq 16 on host /interrupt-controller0 mapped to virtual irq 17
time_init: decrementer frequency = 800.000010 MHz
time_init: processor frequency   = 800.000010 MHz
clocksource: timebase mult[500000] shift[22] registered
clockevent: decrementer mult[ccccccf7] shift[32] cpu[0]
Mount-cache hash table entries: 512
NET: Registered protocol family 16
irq: irq 23 on host /interrupt-controller2 mapped to virtual irq 23
256k L2-cache enabled
PCIE0: Checking link...
PCIE0: No device detected.
PCI host bridge /plb/pciex@d00000000 (primary) ranges:
 MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000 
  IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE0: successfully set as root-complex
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
pci 0000:40:00.0: found [aaa0:bed0] class 000604 header type 01
pci 0000:40:00.0: reg 10 32bit mmio: [0x000000-0x7fffffff]
pci 0000:40:00.0: calling pcibios_fixup_resources+0x0/0x220
pci 0000:40:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
PCI: Hiding 4xx host bridge resources 0000:40:00.0
pci 0000:40:00.0: calling quirk_resource_alignment+0x0/0x200
PCI: Fixups for bus 0000:40
pci 0000:40:00.0: scanning behind bridge, config 7f4140, pass 0
PCI: Scanning bus 0000:41
PCI: Fixups for bus 0000:41
pci 0000:40:00.0: bridge io port: [0x00-0xfff]
pci 0000:40:00.0: bridge 32bit mmio: [0x000000-0x0fffff]
pci 0000:40:00.0: bridge 64bit mmio pref: [0x000000-0x0fffff]
PCI: Bus scan for 0000:41 returning with max=41
pci 0000:40:00.0: scanning behind bridge, config 7f4140, pass 1
PCI: Bus scan for 0000:40 returning with max=7f
PCI: Scanning bus 0001:80
pci 0001:80:00.0: found [aaa1:bed1] class 000604 header type 01
pci 0001:80:00.0: reg 10 32bit mmio: [0x000000-0x7fffffff]
pci 0001:80:00.0: calling pcibios_fixup_resources+0x0/0x220
pci 0001:80:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
PCI: Hiding 4xx host bridge resources 0001:80:00.0
pci 0001:80:00.0: calling quirk_resource_alignment+0x0/0x200
PCI: Fixups for bus 0001:80
pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 0
PCI: Scanning bus 0001:81
pci 0001:81:00.0: found [1000:0070] class 000107 header type 00
pci 0001:81:00.0: reg 10 io port: [0x00-0xff]
pci 0001:81:00.0: reg 14 64bit mmio: [0x000000-0x003fff]
pci 0001:81:00.0: reg 1c 64bit mmio: [0x000000-0x03ffff]
pci 0001:81:00.0: reg 30 32bit mmio: [0x000000-0x07ffff]
pci 0001:81:00.0: calling pcibios_fixup_resources+0x0/0x220
pci 0001:81:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0001:81:00.0: calling quirk_resource_alignment+0x0/0x200
pci 0001:81:00.0: supports D1 D2
PCI: Fixups for bus 0001:81
pci 0001:80:00.0: bridge io port: [0x00-0xfff]
irq: irq 16 on host /interrupt-controller3 mapped to virtual irq 18
PCI: Bus scan for 0001:81 returning with max=81
pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 1
PCI: Bus scan for 0001:80 returning with max=bf
PCI: Scanning bus 0002:00
PCI: Fixups for bus 0002:00
PCI: Bus scan for 0002:00 returning with max=00
pci 0000:40:00.0: PCI bridge, secondary bus 0000:41
pci 0000:40:00.0:   IO window: disabled
pci 0000:40:00.0:   MEM window: disabled
pci 0000:40:00.0:   PREFETCH window: disabled
pci 0001:81:00.0: BAR 6: got res [0xe80100000-0xe8017ffff] bus [0x80100000-0x8017ffff] flags 0x0
pci 0001:81:00.0: BAR 3: got res [0xe80000000-0xe8003ffff] bus [0x80000000-0x8003ffff] flags 0x4
pci 0001:81:00.0: BAR 3: moved to bus [0x80000000-0x8003ffff] flags 0x120204
pci 0001:81:00.0: BAR 1: got res [0xe80040000-0xe80043fff] bus [0x80040000-0x80043fff] flags 0x4
pci 0001:81:00.0: BAR 1: moved to bus [0x80040000-0x80043fff] flags 0x120204
pci 0001:81:00.0: BAR 0: got res [0xfffe1000-0xfffe10ff] bus [0x1000-0x10ff] flags 0x20020101
pci 0001:81:00.0: BAR 0: moved to bus [0x1000-0x10ff] flags 0x20101
pci 0001:80:00.0: PCI bridge, secondary bus 0001:81
pci 0001:80:00.0:   IO window: 0x1000-0x1fff
pci 0001:80:00.0:   MEM window: 0x80000000-0x800fffff
pci 0001:80:00.0:   PREFETCH window: 0x80100000-0x801fffff
pci_bus 0000:40: resource 0 io:  [0xfffc0000-0xfffcffff]
pci_bus 0000:40: resource 1 mem: [0xe00000000-0xe7fffffff]
pci_bus 0000:41: resource 0 mem: [0xfffc0000-0xfffc0fff]
pci_bus 0000:41: resource 1 mem: [0xd80000000-0xd800fffff]
pci_bus 0000:41: resource 2 mem: [0xd80000000-0xd800fffff]
pci_bus 0001:80: resource 0 io:  [0xfffe0000-0xfffeffff]
pci_bus 0001:80: resource 1 mem: [0xe80000000-0xeffffffff]
pci_bus 0001:81: resource 0 io:  [0xfffe1000-0xfffe1fff]
pci_bus 0001:81: resource 1 mem: [0xe80000000-0xe800fffff]
pci_bus 0001:81: resource 2 pref mem [0xe80100000-0xe801fffff]
pci_bus 0002:00: resource 0 io:  [0x00-0xffff]
pci_bus 0002:00: resource 1 mem: [0xd80000000-0xdffffffff]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
libata version 3.00 loaded.
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
Switched to high resolution mode on CPU 0
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 3343k freed
irq: irq 1 on host /interrupt-controller1 mapped to virtual irq 19
irq: irq 1 on host /interrupt-controller0 mapped to virtual irq 20
irq: irq 29 on host /interrupt-controller1 mapped to virtual irq 29
irq: irq 30 on host /interrupt-controller1 mapped to virtual irq 21
JFFS2 version 2.2. (NAND) �© 2001-2006 Red Hat, Inc.
msgmni has been set to 1008
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci 0000:40:00.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0000:40:00.0: calling quirk_usb_early_handoff+0x0/0x738
pci 0001:80:00.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0001:80:00.0: calling quirk_usb_early_handoff+0x0/0x738
pci 0001:81:00.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0001:81:00.0: calling quirk_usb_early_handoff+0x0/0x738
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 19) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 20) is a 16550A
serial8250.0: ttyS2 at MMIO 0x4ef600500 (irq = 29) is a 16550A
serial8250.0: ttyS3 at MMIO 0x4ef600600 (irq = 21) is a 16550A
4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 19) is a 16550
4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 20) is a 16550
4ef600500.serial: ttyS2 at MMIO 0x4ef600500 (irq = 29) is a 16550
4ef600600.serial: ttyS3 at MMIO 0x4ef600600 (irq = 21) is a 16550
brd: module loaded
Uniform Multi-Platform E-IDE driver
ide-gd driver 1.18
Loading iSCSI transport class v2.0-870.
PPC 4xx OCP EMAC driver, version 3.54
irq: irq 6 on host /interrupt-controller2 mapped to virtual irq 22
irq: irq 7 on host /interrupt-controller2 mapped to virtual irq 24
irq: irq 3 on host /interrupt-controller2 mapped to virtual irq 25
irq: irq 4 on host /interrupt-controller2 mapped to virtual irq 26
irq: irq 5 on host /interrupt-controller2 mapped to virtual irq 27
MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
TAH /plb/opb/emac-tah@ef601350 initialized
TAH /plb/opb/emac-tah@ef601450 initialized
irq: irq 16 on host /interrupt-controller2 mapped to virtual irq 28
irq: irq 20 on host /interrupt-controller2 mapped to virtual irq 31
/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:01:02:b9
eth0: found Generic MII PHY (0x00)
irq: irq 17 on host /interrupt-controller2 mapped to virtual irq 32
irq: irq 21 on host /interrupt-controller2 mapped to virtual irq 33
/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:81:02:b9
eth1: found Generic MII PHY (0x01)
4cc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
4cc000000.nor_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
Creating 7 MTD partitions on "4cc000000.nor_flash":
0x000000000000-0x0000001e0000 : "kernel"
0x0000001e0000-0x000000200000 : "dtb"
0x000000200000-0x000001600000 : "ramdisk"
0x000001600000-0x000001a00000 : "jffs2"
0x000001a00000-0x000003f60000 : "user"
0x000003f60000-0x000003fa0000 : "env"
0x000003fa0000-0x000004000000 : "u-boot"
i2c /dev entries driver
irq: irq 2 on host /interrupt-controller0 mapped to virtual irq 34
ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
irq: irq 3 on host /interrupt-controller0 mapped to virtual irq 35
ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
eth0: link is down
IP-Config: Complete:
     device=eth0, addr=169.254.0.181, mask=255.255.255.0, gw=169.254.0.100,
     host=tanosx, domain=, nis-domain=(none),
     bootserver=169.254.0.100, rootserver=169.254.0.100, rootpath=
RAMDISK: gzip image found at block 0
eth0: link is up, 100 FDX, pause enabled
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing unused kernel memory: 160k init
# 

Using PowerPC 44x Platform machine description
Linux version 2.6.31 (bobe@lablinux) (gcc version 4.2.2) #65 Tue Oct 6 09:25:00 CDT 2009
Found initrd at 0xdfb09000:0xdfe4cc6e
Found legacy serial port 0 for /plb/opb/serial@ef600300
  mem=4ef600300, taddr=4ef600300, irq=0, clk=6451612, speed=0
Found legacy serial port 1 for /plb/opb/serial@ef600400
  mem=4ef600400, taddr=4ef600400, irq=0, clk=6451612, speed=0
Found legacy serial port 2 for /plb/opb/serial@ef600500
  mem=4ef600500, taddr=4ef600500, irq=0, clk=6451612, speed=0
Found legacy serial port 3 for /plb/opb/serial@ef600600
  mem=4ef600600, taddr=4ef600600, irq=0, clk=6451612, speed=0
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
free_area_init_node: node 0, pgdat c033d9fc, node_mem_map c036c000
  DMA zone: 1024 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 130048 pages, LIFO batch:31
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/ram rw mem=128M mem=512M ip=169.254.0.181:169.254.0.100:169.254.0.100:255.255.255.0:tanosx:eth0:off panic=1 console=ttyS0,57600
PID hash table entries: 2048 (order: 11, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
High memory: 0k
Memory: 512512k/524288k available (3200k kernel code, 11392k reserved, 132k data, 128k bss, 156k init)
Kernel virtual memory layout:
  * 0xfffef000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xffa00000..0xffc00000  : consistent mem
  * 0xffa00000..0xffa00000  : early ioremap
  * 0xe1000000..0xffa00000  : vmalloc & ioremap
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:512
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
irq: irq 30 on host /interrupt-controller0 mapped to virtual irq 30
UIC2 (32 IRQ sources) at DCR 0xe0
irq: irq 10 on host /interrupt-controller0 mapped to virtual irq 16
UIC3 (32 IRQ sources) at DCR 0xf0
irq: irq 16 on host /interrupt-controller0 mapped to virtual irq 17
time_init: decrementer frequency = 800.000010 MHz
time_init: processor frequency   = 800.000010 MHz
clocksource: timebase mult[500000] shift[22] registered
clockevent: decrementer mult[ccccccf7] shift[32] cpu[0]
Mount-cache hash table entries: 512
NET: Registered protocol family 16
irq: irq 23 on host /interrupt-controller2 mapped to virtual irq 23
256k L2-cache enabled
PCIE0: Checking link...
PCIE0: No device detected.
PCI host bridge /plb/pciex@d00000000 (primary) ranges:
 MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000 
  IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE0: successfully set as root-complex
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
pci 0000:40:00.0: found [aaa0:bed0] class 000604 header type 01
pci 0000:40:00.0: reg 10 32bit mmio: [0x000000-0x7fffffff]
pci 0000:40:00.0: calling pcibios_fixup_resources+0x0/0x220
pci 0000:40:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
PCI: Hiding 4xx host bridge resources 0000:40:00.0
pci 0000:40:00.0: calling quirk_resource_alignment+0x0/0x200
PCI: Fixups for bus 0000:40
pci 0000:40:00.0: scanning behind bridge, config 7f4140, pass 0
PCI: Scanning bus 0000:41
PCI: Fixups for bus 0000:41
pci 0000:40:00.0: bridge io port: [0x00-0xfff]
pci 0000:40:00.0: bridge 32bit mmio: [0x000000-0x0fffff]
pci 0000:40:00.0: bridge 64bit mmio pref: [0x000000-0x0fffff]
PCI: Bus scan for 0000:41 returning with max=41
pci 0000:40:00.0: scanning behind bridge, config 7f4140, pass 1
PCI: Bus scan for 0000:40 returning with max=7f
PCI: Scanning bus 0001:80
pci 0001:80:00.0: found [aaa1:bed1] class 000604 header type 01
pci 0001:80:00.0: reg 10 32bit mmio: [0x000000-0x7fffffff]
pci 0001:80:00.0: calling pcibios_fixup_resources+0x0/0x220
pci 0001:80:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
PCI: Hiding 4xx host bridge resources 0001:80:00.0
pci 0001:80:00.0: calling quirk_resource_alignment+0x0/0x200
PCI: Fixups for bus 0001:80
pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 0
PCI: Scanning bus 0001:81
pci 0001:81:00.0: found [1000:0070] class 000107 header type 00
pci 0001:81:00.0: reg 10 io port: [0x00-0xff]
pci 0001:81:00.0: reg 14 64bit mmio: [0x000000-0x003fff]
pci 0001:81:00.0: reg 1c 64bit mmio: [0x000000-0x03ffff]
pci 0001:81:00.0: reg 30 32bit mmio: [0x000000-0x07ffff]
pci 0001:81:00.0: calling pcibios_fixup_resources+0x0/0x220
pci 0001:81:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0001:81:00.0: calling quirk_resource_alignment+0x0/0x200
pci 0001:81:00.0: supports D1 D2
PCI: Fixups for bus 0001:81
pci 0001:80:00.0: bridge io port: [0x00-0xfff]
irq: irq 16 on host /interrupt-controller3 mapped to virtual irq 18
PCI: Bus scan for 0001:81 returning with max=81
pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 1
PCI: Bus scan for 0001:80 returning with max=bf
PCI: Scanning bus 0002:00
PCI: Fixups for bus 0002:00
PCI: Bus scan for 0002:00 returning with max=00
pci 0000:40:00.0: PCI bridge, secondary bus 0000:41
pci 0000:40:00.0:   IO window: disabled
pci 0000:40:00.0:   MEM window: disabled
pci 0000:40:00.0:   PREFETCH window: disabled
pci 0001:81:00.0: BAR 6: got res [0xe80100000-0xe8017ffff] bus [0x80100000-0x8017ffff] flags 0x20027200
pci 0001:81:00.0: BAR 3: got res [0xe80000000-0xe8003ffff] bus [0x80000000-0x8003ffff] flags 0x20120204
pci 0001:81:00.0: BAR 3: moved to bus [0x80000000-0x8003ffff] flags 0x120204
pci 0001:81:00.0: BAR 1: got res [0xe80040000-0xe80043fff] bus [0x80040000-0x80043fff] flags 0x20120204
pci 0001:81:00.0: BAR 1: moved to bus [0x80040000-0x80043fff] flags 0x120204
pci 0001:81:00.0: BAR 0: got res [0xfffe1000-0xfffe10ff] bus [0x1000-0x10ff] flags 0x20020101
pci 0001:81:00.0: BAR 0: moved to bus [0x1000-0x10ff] flags 0x20101
pci 0001:80:00.0: PCI bridge, secondary bus 0001:81
pci 0001:80:00.0:   IO window: 0x1000-0x1fff
pci 0001:80:00.0:   MEM window: 0x80000000-0x800fffff
pci 0001:80:00.0:   PREFETCH window: 0x80100000-0x801fffff
pci_bus 0000:40: resource 0 io:  [0xfffc0000-0xfffcffff]
pci_bus 0000:40: resource 1 mem: [0xe00000000-0xe7fffffff]
pci_bus 0000:41: resource 0 mem: [0xfffc0000-0xfffc0fff]
pci_bus 0000:41: resource 1 mem: [0xd80000000-0xd800fffff]
pci_bus 0000:41: resource 2 mem: [0xd80000000-0xd800fffff]
pci_bus 0001:80: resource 0 io:  [0xfffe0000-0xfffeffff]
pci_bus 0001:80: resource 1 mem: [0xe80000000-0xeffffffff]
pci_bus 0001:81: resource 0 io:  [0xfffe1000-0xfffe1fff]
pci_bus 0001:81: resource 1 mem: [0xe80000000-0xe800fffff]
pci_bus 0001:81: resource 2 pref mem [0xe80100000-0xe801fffff]
pci_bus 0002:00: resource 0 io:  [0x00-0xffff]
pci_bus 0002:00: resource 1 mem: [0xd80000000-0xdffffffff]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
Switched to high resolution mode on CPU 0
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 3343k freed
irq: irq 1 on host /interrupt-controller1 mapped to virtual irq 19
irq: irq 1 on host /interrupt-controller0 mapped to virtual irq 20
irq: irq 29 on host /interrupt-controller1 mapped to virtual irq 29
irq: irq 30 on host /interrupt-controller1 mapped to virtual irq 21
JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
msgmni has been set to 1008
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci 0000:40:00.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0000:40:00.0: calling quirk_usb_early_handoff+0x0/0x738
pci 0001:80:00.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0001:80:00.0: calling quirk_usb_early_handoff+0x0/0x738
pci 0001:81:00.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0001:81:00.0: calling quirk_usb_early_handoff+0x0/0x738
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 19) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 20) is a 16550A
serial8250.0: ttyS2 at MMIO 0x4ef600500 (irq = 29) is a 16550A
serial8250.0: ttyS3 at MMIO 0x4ef600600 (irq = 21) is a 16550A
4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 19) is a 16550
4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 20) is a 16550
4ef600500.serial: ttyS2 at MMIO 0x4ef600500 (irq = 29) is a 16550
4ef600600.serial: ttyS3 at MMIO 0x4ef600600 (irq = 21) is a 16550
brd: module loaded
Uniform Multi-Platform E-IDE driver
ide-gd driver 1.18
PPC 4xx OCP EMAC driver, version 3.54
irq: irq 6 on host /interrupt-controller2 mapped to virtual irq 22
irq: irq 7 on host /interrupt-controller2 mapped to virtual irq 24
irq: irq 3 on host /interrupt-controller2 mapped to virtual irq 25
irq: irq 4 on host /interrupt-controller2 mapped to virtual irq 26
irq: irq 5 on host /interrupt-controller2 mapped to virtual irq 27
MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
TAH /plb/opb/emac-tah@ef601350 initialized
TAH /plb/opb/emac-tah@ef601450 initialized
irq: irq 16 on host /interrupt-controller2 mapped to virtual irq 28
irq: irq 20 on host /interrupt-controller2 mapped to virtual irq 31
/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:01:02:b9
eth0: found Generic MII PHY (0x00)
irq: irq 17 on host /interrupt-controller2 mapped to virtual irq 32
irq: irq 21 on host /interrupt-controller2 mapped to virtual irq 33
/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:81:02:b9
eth1: found Generic MII PHY (0x01)
Fusion MPT base driver 3.04.10
Copyright (c) 1999-2008 LSI Corporation
Fusion MPT SPI Host driver 3.04.10
Fusion MPT FC Host driver 3.04.10
Fusion MPT SAS Host driver 3.04.10
Fusion MPT misc device (ioctl) driver 3.04.10
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
4cc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
4cc000000.nor_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
Creating 7 MTD partitions on "4cc000000.nor_flash":
0x000000000000-0x0000001e0000 : "kernel"
0x0000001e0000-0x000000200000 : "dtb"
0x000000200000-0x000001600000 : "ramdisk"
0x000001600000-0x000001a00000 : "jffs2"
0x000001a00000-0x000003f60000 : "user"
0x000003f60000-0x000003fa0000 : "env"
0x000003fa0000-0x000004000000 : "u-boot"
i2c /dev entries driver
irq: irq 2 on host /interrupt-controller0 mapped to virtual irq 34
ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
irq: irq 3 on host /interrupt-controller0 mapped to virtual irq 35
ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
eth0: link is down
eth0: link is up, 100 FDX, pause enabled
IP-Config: Complete:
     device=eth0, addr=169.254.0.181, mask=255.255.255.0, gw=169.254.0.100,
     host=tanosx, domain=, nis-domain=(none),
     bootserver=169.254.0.100, rootserver=169.254.0.100, rootpath=
RAMDISK: gzip image found at block 0
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing unused kernel memory: 156k init
