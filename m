Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A1A8B7D1C
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 18:50:29 +1100 (EST)
Message-ID: <4B98A0CB.8090103@embedded-sol.com>
Date: Thu, 11 Mar 2010 09:50:35 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Alex Chiang <achiang@hp.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>
	<20100310225100.GB27324@ldl.fc.hp.com>
In-Reply-To: <20100310225100.GB27324@ldl.fc.hp.com>
Content-Type: multipart/mixed; boundary="------------030408030205060002000801"
Cc: linux-pci@vger.kernel.org,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030408030205060002000801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

Resending, previous attempt was erroneously send as HTML.

Thanks a lot for replying.

Alex Chiang wrote:
> * Felix Radensky <felix@embedded-sol.com>:
>   
>> The problem arises when device is plugged in after boot. After doing
>> echo 1 > /sys/bus/pci/rescan
>> the device is identified, but bridge memory window is not allocated,
>> and reads from device memory regions return 0xffffffff. Below is
>> relevant output:
>>     
>
> Do you need firmware support on your platform for hotplug?
>   
I don't think so, but I've added powerpc guys to CC to make sure.
> Can you please send full dmesg during successful boot, full dmesg
> log during unsuccessful rescan, and contents of /proc/iomem and
> /proc/ioports during success and failure cases?
>
> Be sure you have PCI_CONFIG_DEBUG turned on.
>   
Attached. I really appreciate your help. Thanks a lot.

Felix.

--------------030408030205060002000801
Content-Type: text/plain;
 name="failure.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="failure.txt"

Linux version 2.6.33 (felix@felix-laptop.lan) (gcc version 4.2.2) #5 Thu Mar 11 09:35:52 IST 2010
Found legacy serial port 0 for /plb/opb/serial@ef600300
  mem=4ef600300, taddr=4ef600300, irq=0, clk=7407407, speed=0
Found legacy serial port 1 for /plb/opb/serial@ef600400
  mem=4ef600400, taddr=4ef600400, irq=0, clk=7407407, speed=0
Found legacy serial port 2 for /plb/opb/serial@ef600500
  mem=4ef600500, taddr=4ef600500, irq=0, clk=7407407, speed=0
Found legacy serial port 3 for /plb/opb/serial@ef600600
  mem=4ef600600, taddr=4ef600600, irq=0, clk=7407407, speed=0
Top of RAM: 0x30000000, Total RAM: 0x30000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00030000
  Normal   0x00030000 -> 0x00030000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00030000
On node 0 totalpages: 196608
free_area_init_node: node 0, pgdat c035e76c, node_mem_map c0388000
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 195072 pages, LIFO batch:31
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 195072
Kernel command line: root=/dev/nfs rw nfsroot=10.0.0.10:/opt/eldk/ppc_4xxFP ip=10.0.0.30:10.0.0.10:10.0.0.138:255.0.0.0:smbe460:eth0:off panic=1 console=ttyS0,115200
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 775552k/786432k available (3364k kernel code, 10604k reserved, 116k data, 128k bss, 144k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfde00000..0xfe000000  : consistent mem
  * 0xfde00000..0xfde00000  : early ioremap
  * 0xf1000000..0xfde00000  : vmalloc & ioremap
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:512 nr_irqs:512
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
  alloc irq_desc for 30 on node 0
  alloc kstat_irqs on node 0
irq: irq 30 on host /interrupt-controller0 mapped to virtual irq 30
UIC2 (32 IRQ sources) at DCR 0xe0
  alloc irq_desc for 16 on node 0
  alloc kstat_irqs on node 0
irq: irq 10 on host /interrupt-controller0 mapped to virtual irq 16
UIC3 (32 IRQ sources) at DCR 0xf0
  alloc irq_desc for 17 on node 0
  alloc kstat_irqs on node 0
irq: irq 16 on host /interrupt-controller0 mapped to virtual irq 17
time_init: decrementer frequency = 1000.000012 MHz
time_init: processor frequency   = 1000.000012 MHz
clocksource: timebase mult[400000] shift[22] registered
clockevent: decrementer mult[80000019] shift[31] cpu[0]
Mount-cache hash table entries: 512
NET: Registered protocol family 16
  alloc irq_desc for 18 on node 0
  alloc kstat_irqs on node 0
irq: irq 11 on host /interrupt-controller1 mapped to virtual irq 18
256k L2-cache enabled
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000 
 MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000 
  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
 Removing ISA hole at 0x0000000c0ee00000
4xx PCI DMA offset set to 0x00000000
/plb/pci@c0ec00000: Legacy ISA memory support enabled
PCI: Probing PCI hardware
pci_bus 0000:00: scanning bus
pci 0000:00:02.0: found [3388:0020] class 000604 header type 01
pci 0000:00:02.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:00:02.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:00:02.0: calling quirk_resource_alignment+0x0/0x200
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci 0000:00:02.0: scanning behind bridge, config 000000, pass 0
pci 0000:00:02.0: bus configuration invalid, reconfiguring
pci 0000:00:02.0: scanning behind bridge, config 000000, pass 1
pci_bus 0000:01: scanning bus
pci_bus 0000:01: fixups for bus
pci 0000:00:02.0: PCI bridge to [bus 01-ff]
pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci_bus 0000:01: bus scan returning with max=01
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:02.0: disabling bridge window [io  0x0000-0x0fff] to [bus 01-01] (unused)
pci 0000:00:02.0: disabling bridge window [mem 0xd00000000-0xd000fffff pref] to [bus 01-01] (unused)
pci 0000:00:02.0: disabling bridge window [mem 0xd00000000-0xd000fffff] to [bus 01-01] (unused)
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci 0000:00:02.0:   bridge window [io  disabled]
pci 0000:00:02.0:   bridge window [mem disabled]
pci 0000:00:02.0:   bridge window [mem pref disabled]
pci 0000:00:02.0: enabling bus mastering
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0xd80000000-0xdffffffff]
pci_bus 0000:01: resource 0 [??? 0-4095 flags 0x0]
pci_bus 0000:01: resource 1 [??? 55834574848-55835623423 flags 0x0]
pci_bus 0000:01: resource 2 [??? 55834574848-55835623423 flags 0x0]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource timebase
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 512 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0000:00:02.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0000:00:02.0: calling quirk_usb_early_handoff+0x0/0x6cc
PCI: CLS 0 bytes, default 32
  alloc irq_desc for 19 on node 0
  alloc kstat_irqs on node 0
irq: irq 1 on host /interrupt-controller1 mapped to virtual irq 19
  alloc irq_desc for 20 on node 0
  alloc kstat_irqs on node 0
irq: irq 1 on host /interrupt-controller0 mapped to virtual irq 20
  alloc irq_desc for 29 on node 0
  alloc kstat_irqs on node 0
irq: irq 29 on host /interrupt-controller1 mapped to virtual irq 29
  alloc irq_desc for 21 on node 0
  alloc kstat_irqs on node 0
irq: irq 30 on host /interrupt-controller1 mapped to virtual irq 21
JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
msgmni has been set to 1515
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
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
4e4000000.nor_flash2: Found 1 x16 devices at 0x0 in 16-bit bank
4e4000000.nor_flash2: Found 1 x16 devices at 0x2000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=0x0,size=0x8000,blocks=4
erase region 1: offset=0x20000,size=0x20000,blocks=255
erase region 2: offset=0x2000000,size=0x8000,blocks=4
erase region 3: offset=0x2020000,size=0x20000,blocks=255
RedBoot partition parsing not available
Creating 1 MTD partitions on "4e4000000.nor_flash2":
0x000000000000-0x000004000000 : "data"
4cc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
4cc000000.nor_flash: Found 1 x16 devices at 0x2000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=0x0,size=0x8000,blocks=4
erase region 1: offset=0x20000,size=0x20000,blocks=255
erase region 2: offset=0x2000000,size=0x8000,blocks=4
erase region 3: offset=0x2020000,size=0x20000,blocks=255
RedBoot partition parsing not available
Creating 7 MTD partitions on "4cc000000.nor_flash":
0x000000000000-0x0000001e0000 : "kernel"
0x0000001e0000-0x000000200000 : "dtb"
0x000000200000-0x000001600000 : "ramdisk"
0x000001600000-0x000001a00000 : "jffs2"
0x000001a00000-0x000003f60000 : "user"
0x000003f60000-0x000003fa0000 : "u-boot env"
0x000003fa0000-0x000004000000 : "u-boot"
NAND device: Manufacturer ID: 0xec, Chip ID: 0xd3 (Samsung NAND 1GiB 3,3V 8-bit)
Scanning device for bad blocks
Bad eraseblock 806 at 0x0000064c0000
Bad eraseblock 807 at 0x0000064e0000
Bad eraseblock 2209 at 0x000011420000
Bad eraseblock 3294 at 0x000019bc0000
Bad eraseblock 4010 at 0x00001f540000
Bad eraseblock 4748 at 0x000025180000
Bad eraseblock 5082 at 0x000027b40000
Bad eraseblock 5083 at 0x000027b60000
Bad eraseblock 5716 at 0x00002ca80000
Bad eraseblock 5772 at 0x00002d180000
Bad eraseblock 6362 at 0x000031b40000
Bad eraseblock 6680 at 0x000034300000
Bad eraseblock 6740 at 0x000034a80000
Bad eraseblock 6796 at 0x000035180000
Creating 2 MTD partitions on "4e0000000.ndfc.nand":
0x000000000000-0x000000100000 : "u-boot"
0x000000000000-0x000003f00000 : "user"
PPC 4xx OCP EMAC driver, version 3.54
  alloc irq_desc for 22 on node 0
  alloc kstat_irqs on node 0
irq: irq 6 on host /interrupt-controller2 mapped to virtual irq 22
  alloc irq_desc for 23 on node 0
  alloc kstat_irqs on node 0
irq: irq 7 on host /interrupt-controller2 mapped to virtual irq 23
  alloc irq_desc for 24 on node 0
  alloc kstat_irqs on node 0
irq: irq 3 on host /interrupt-controller2 mapped to virtual irq 24
  alloc irq_desc for 25 on node 0
  alloc kstat_irqs on node 0
irq: irq 4 on host /interrupt-controller2 mapped to virtual irq 25
  alloc irq_desc for 26 on node 0
  alloc kstat_irqs on node 0
irq: irq 5 on host /interrupt-controller2 mapped to virtual irq 26
MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
TAH /plb/opb/emac-tah@ef601350 initialized
TAH /plb/opb/emac-tah@ef601450 initialized
  alloc irq_desc for 27 on node 0
  alloc kstat_irqs on node 0
irq: irq 16 on host /interrupt-controller2 mapped to virtual irq 27
  alloc irq_desc for 28 on node 0
  alloc kstat_irqs on node 0
irq: irq 20 on host /interrupt-controller2 mapped to virtual irq 28
/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:99:88:77:66:55
eth0: found Generic MII PHY (0x00)
  alloc irq_desc for 31 on node 0
  alloc kstat_irqs on node 0
irq: irq 17 on host /interrupt-controller2 mapped to virtual irq 31
  alloc irq_desc for 32 on node 0
  alloc kstat_irqs on node 0
irq: irq 21 on host /interrupt-controller2 mapped to virtual irq 32
/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:99:88:77:66:56
eth1: found Generic MII PHY (0x10)
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
  alloc irq_desc for 33 on node 0
  alloc kstat_irqs on node 0
irq: irq 29 on host /interrupt-controller2 mapped to virtual irq 33
ppc-of-ehci 4bffd0400.ehci: OF EHCI
ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number 1
ppc-of-ehci 4bffd0400.ehci: irq 33, io mem 0x4bffd0400
ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OF EHCI
usb usb1: Manufacturer: Linux 2.6.33 ehci_hcd
usb usb1: SerialNumber: PPC-OF USB
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
i2c /dev entries driver
  alloc irq_desc for 34 on node 0
  alloc kstat_irqs on node 0
irq: irq 2 on host /interrupt-controller0 mapped to virtual irq 34
at24 0-0051: 65536 byte 24c512 EEPROM (writable)
at24 0-0053: 256 byte spd EEPROM (read-only)
ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
  alloc irq_desc for 35 on node 0
  alloc kstat_irqs on node 0
irq: irq 3 on host /interrupt-controller0 mapped to virtual irq 35
ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
rtc-ds1307 5-0068: rtc core: registered ds1338 as rtc0
rtc-ds1307 5-0068: 56 bytes nvram
pca954x 1-0070: registered 8 virtual busses for I2C switch pca9548
pca954x 2-0071: registered 8 virtual busses for I2C switch pca9548
pca954x 3-0072: registered 8 virtual busses for I2C switch pca9548
TCP cubic registered
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
rtc-ds1307 5-0068: setting system clock to 2000-02-28 11:43:27 UTC (951738207)
eth0: link is down
IP-Config: Complete:
     device=eth0, addr=10.0.0.30, mask=255.0.0.0, gw=10.0.0.138,
     host=smbe460, domain=, nis-domain=(none),
     bootserver=10.0.0.10, rootserver=10.0.0.10, rootpath=
Looking up port of RPC 100003/2 on 10.0.0.10
eth0: link is up, 100 FDX, pause enabled
Looking up port of RPC 100005/1 on 10.0.0.10
VFS: Mounted root (nfs filesystem) on device 0:13.
Freeing unused kernel memory: 144k init
pci_bus 0000:00: scanning bus
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 0
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: found [1575:0002] class 00ff00 header type 00
pci 0000:01:00.0: reg 10: [mem 0x00000000-0x000fffff]
pci 0000:01:00.0: reg 14: [mem 0x00000000-0x03ffffff]
pci 0000:01:00.0: reg 18: [mem 0x00000000-0x03ffffff]
pci 0000:01:00.0: reg 1c: [mem 0x00000000-0x00003fff]
pci 0000:01:00.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:01:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:01:00.0: calling quirk_resource_alignment+0x0/0x200
pci_bus 0000:01: bus scan returning with max=01
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 1
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:02.0: disabling bridge window [io  0x0000-0x0fff] to [bus 01-01] (unused)
pci 0000:00:02.0: disabling bridge window [mem 0xd00000000-0xd000fffff pref] to [bus 01-01] (unused)
pci 0000:00:02.0: BAR 8: assigned [mem 0xd80000000-0xd89ffffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0xd80000000-0xd83ffffff]
pci 0000:01:00.0: BAR 1: set to [mem 0xd80000000-0xd83ffffff] (PCI address [0x80000000-0x83ffffff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xd84000000-0xd87ffffff]
pci 0000:01:00.0: BAR 2: set to [mem 0xd84000000-0xd87ffffff] (PCI address [0x84000000-0x87ffffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xd88000000-0xd880fffff]
pci 0000:01:00.0: BAR 0: set to [mem 0xd88000000-0xd880fffff] (PCI address [0x88000000-0x880fffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xd88100000-0xd88103fff]
pci 0000:01:00.0: BAR 3: set to [mem 0xd88100000-0xd88103fff] (PCI address [0x88100000-0x88103fff]

# cat /proc/iomem

4bffd0400-4bffd048f : ehci_hcd
4cc000000-4cfffffff : 4cc000000.nor_flash
4e4000000-4e7ffffff : 4e4000000.nor_flash2
4ef600300-4ef600307 : serial
4ef600400-4ef600407 : serial
4ef600500-4ef600507 : serial
4ef600600-4ef600607 : serial
d80000000-dffffffff : /plb/pci@c0ec00000
  d80000000-d89ffffff : PCI Bus 0000:01
    d80000000-d83ffffff : 0000:01:00.0
    d84000000-d87ffffff : 0000:01:00.0
    d88000000-d880fffff : 0000:01:00.0
    d88100000-d88103fff : 0000:01:00.0

# cat /proc/ioports
00000000-0000ffff : /plb/pci@c0ec00000
  00000000-00000fff : Legacy IO


--------------030408030205060002000801
Content-Type: text/plain;
 name="success.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="success.txt"

Linux version 2.6.33 (felix@felix-laptop.lan) (gcc version 4.2.2) #5 Thu Mar 11 09:35:52 IST 2010
Found legacy serial port 0 for /plb/opb/serial@ef600300
  mem=4ef600300, taddr=4ef600300, irq=0, clk=7407407, speed=0
Found legacy serial port 1 for /plb/opb/serial@ef600400
  mem=4ef600400, taddr=4ef600400, irq=0, clk=7407407, speed=0
Found legacy serial port 2 for /plb/opb/serial@ef600500
  mem=4ef600500, taddr=4ef600500, irq=0, clk=7407407, speed=0
Found legacy serial port 3 for /plb/opb/serial@ef600600
  mem=4ef600600, taddr=4ef600600, irq=0, clk=7407407, speed=0
Top of RAM: 0x30000000, Total RAM: 0x30000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00030000
  Normal   0x00030000 -> 0x00030000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00030000
On node 0 totalpages: 196608
free_area_init_node: node 0, pgdat c035e76c, node_mem_map c0388000
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 195072 pages, LIFO batch:31
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 195072
Kernel command line: root=/dev/nfs rw nfsroot=10.0.0.10:/opt/eldk/ppc_4xxFP ip=10.0.0.30:10.0.0.10:10.0.0.138:255.0.0.0:smbe460:eth0:off panic=1 console=ttyS0,115200
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 775552k/786432k available (3364k kernel code, 10604k reserved, 116k data, 128k bss, 144k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfde00000..0xfe000000  : consistent mem
  * 0xfde00000..0xfde00000  : early ioremap
  * 0xf1000000..0xfde00000  : vmalloc & ioremap
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:512 nr_irqs:512
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
  alloc irq_desc for 30 on node 0
  alloc kstat_irqs on node 0
irq: irq 30 on host /interrupt-controller0 mapped to virtual irq 30
UIC2 (32 IRQ sources) at DCR 0xe0
  alloc irq_desc for 16 on node 0
  alloc kstat_irqs on node 0
irq: irq 10 on host /interrupt-controller0 mapped to virtual irq 16
UIC3 (32 IRQ sources) at DCR 0xf0
  alloc irq_desc for 17 on node 0
  alloc kstat_irqs on node 0
irq: irq 16 on host /interrupt-controller0 mapped to virtual irq 17
time_init: decrementer frequency = 1000.000012 MHz
time_init: processor frequency   = 1000.000012 MHz
clocksource: timebase mult[400000] shift[22] registered
clockevent: decrementer mult[80000019] shift[31] cpu[0]
Mount-cache hash table entries: 512
NET: Registered protocol family 16
  alloc irq_desc for 18 on node 0
  alloc kstat_irqs on node 0
irq: irq 11 on host /interrupt-controller1 mapped to virtual irq 18
256k L2-cache enabled
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000 
 MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000 
  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
 Removing ISA hole at 0x0000000c0ee00000
4xx PCI DMA offset set to 0x00000000
/plb/pci@c0ec00000: Legacy ISA memory support enabled
PCI: Probing PCI hardware
pci_bus 0000:00: scanning bus
pci 0000:00:02.0: found [3388:0020] class 000604 header type 01
pci 0000:00:02.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:00:02.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:00:02.0: calling quirk_resource_alignment+0x0/0x200
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 0
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: found [1575:0002] class 00ff00 header type 00
pci 0000:01:00.0: reg 10: [mem 0x88000000-0x880fffff]
pci 0000:01:00.0: reg 14: [mem 0x80000000-0x83ffffff]
pci 0000:01:00.0: reg 18: [mem 0x84000000-0x87ffffff]
pci 0000:01:00.0: reg 1c: [mem 0x88100000-0x88103fff]
pci 0000:01:00.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:01:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:01:00.0: calling quirk_resource_alignment+0x0/0x200
pci_bus 0000:01: fixups for bus
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci_bus 0000:01: bus scan returning with max=01
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 1
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:02.0: BAR 8: assigned [mem 0xd80000000-0xd89ffffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0xd80000000-0xd83ffffff]
pci 0000:01:00.0: BAR 1: set to [mem 0xd80000000-0xd83ffffff] (PCI address [0x80000000-0x83ffffff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xd84000000-0xd87ffffff]
pci 0000:01:00.0: BAR 2: set to [mem 0xd84000000-0xd87ffffff] (PCI address [0x84000000-0x87ffffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xd88000000-0xd880fffff]
pci 0000:01:00.0: BAR 0: set to [mem 0xd88000000-0xd880fffff] (PCI address [0x88000000-0x880fffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xd88100000-0xd88103fff]
pci 0000:01:00.0: BAR 3: set to [mem 0xd88100000-0xd88103fff] (PCI address [0x88100000-0x88103fff]
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci 0000:00:02.0:   bridge window [io  disabled]
pci 0000:00:02.0:   bridge window [mem 0xd80000000-0xd89ffffff]
pci 0000:00:02.0:   bridge window [mem pref disabled]
pci 0000:00:02.0: enabling device (0084 -> 0086)
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0xd80000000-0xdffffffff]
pci_bus 0000:01: resource 1 [mem 0xd80000000-0xd89ffffff]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource timebase
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 512 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0000:00:02.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0000:00:02.0: calling quirk_usb_early_handoff+0x0/0x6cc
pci 0000:01:00.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x6cc
PCI: CLS 0 bytes, default 32
  alloc irq_desc for 19 on node 0
  alloc kstat_irqs on node 0
irq: irq 1 on host /interrupt-controller1 mapped to virtual irq 19
  alloc irq_desc for 20 on node 0
  alloc kstat_irqs on node 0
irq: irq 1 on host /interrupt-controller0 mapped to virtual irq 20
  alloc irq_desc for 29 on node 0
  alloc kstat_irqs on node 0
irq: irq 29 on host /interrupt-controller1 mapped to virtual irq 29
  alloc irq_desc for 21 on node 0
  alloc kstat_irqs on node 0
irq: irq 30 on host /interrupt-controller1 mapped to virtual irq 21
JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
msgmni has been set to 1515
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
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
4e4000000.nor_flash2: Found 1 x16 devices at 0x0 in 16-bit bank
4e4000000.nor_flash2: Found 1 x16 devices at 0x2000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=0x0,size=0x8000,blocks=4
erase region 1: offset=0x20000,size=0x20000,blocks=255
erase region 2: offset=0x2000000,size=0x8000,blocks=4
erase region 3: offset=0x2020000,size=0x20000,blocks=255
RedBoot partition parsing not available
Creating 1 MTD partitions on "4e4000000.nor_flash2":
0x000000000000-0x000004000000 : "data"
4cc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
4cc000000.nor_flash: Found 1 x16 devices at 0x2000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=0x0,size=0x8000,blocks=4
erase region 1: offset=0x20000,size=0x20000,blocks=255
erase region 2: offset=0x2000000,size=0x8000,blocks=4
erase region 3: offset=0x2020000,size=0x20000,blocks=255
RedBoot partition parsing not available
Creating 7 MTD partitions on "4cc000000.nor_flash":
0x000000000000-0x0000001e0000 : "kernel"
0x0000001e0000-0x000000200000 : "dtb"
0x000000200000-0x000001600000 : "ramdisk"
0x000001600000-0x000001a00000 : "jffs2"
0x000001a00000-0x000003f60000 : "user"
0x000003f60000-0x000003fa0000 : "u-boot env"
0x000003fa0000-0x000004000000 : "u-boot"
NAND device: Manufacturer ID: 0xec, Chip ID: 0xd3 (Samsung NAND 1GiB 3,3V 8-bit)
Scanning device for bad blocks
Bad eraseblock 806 at 0x0000064c0000
Bad eraseblock 807 at 0x0000064e0000
Bad eraseblock 2209 at 0x000011420000
Bad eraseblock 3294 at 0x000019bc0000
Bad eraseblock 4010 at 0x00001f540000
Bad eraseblock 4748 at 0x000025180000
Bad eraseblock 5082 at 0x000027b40000
Bad eraseblock 5083 at 0x000027b60000
Bad eraseblock 5716 at 0x00002ca80000
Bad eraseblock 5772 at 0x00002d180000
Bad eraseblock 6362 at 0x000031b40000
Bad eraseblock 6680 at 0x000034300000
Bad eraseblock 6740 at 0x000034a80000
Bad eraseblock 6796 at 0x000035180000
Creating 2 MTD partitions on "4e0000000.ndfc.nand":
0x000000000000-0x000000100000 : "u-boot"
0x000000000000-0x000003f00000 : "user"
PPC 4xx OCP EMAC driver, version 3.54
  alloc irq_desc for 22 on node 0
  alloc kstat_irqs on node 0
irq: irq 6 on host /interrupt-controller2 mapped to virtual irq 22
  alloc irq_desc for 23 on node 0
  alloc kstat_irqs on node 0
irq: irq 7 on host /interrupt-controller2 mapped to virtual irq 23
  alloc irq_desc for 24 on node 0
  alloc kstat_irqs on node 0
irq: irq 3 on host /interrupt-controller2 mapped to virtual irq 24
  alloc irq_desc for 25 on node 0
  alloc kstat_irqs on node 0
irq: irq 4 on host /interrupt-controller2 mapped to virtual irq 25
  alloc irq_desc for 26 on node 0
  alloc kstat_irqs on node 0
irq: irq 5 on host /interrupt-controller2 mapped to virtual irq 26
MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
TAH /plb/opb/emac-tah@ef601350 initialized
TAH /plb/opb/emac-tah@ef601450 initialized
  alloc irq_desc for 27 on node 0
  alloc kstat_irqs on node 0
irq: irq 16 on host /interrupt-controller2 mapped to virtual irq 27
  alloc irq_desc for 28 on node 0
  alloc kstat_irqs on node 0
irq: irq 20 on host /interrupt-controller2 mapped to virtual irq 28
/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:99:88:77:66:55
eth0: found Generic MII PHY (0x00)
  alloc irq_desc for 31 on node 0
  alloc kstat_irqs on node 0
irq: irq 17 on host /interrupt-controller2 mapped to virtual irq 31
  alloc irq_desc for 32 on node 0
  alloc kstat_irqs on node 0
irq: irq 21 on host /interrupt-controller2 mapped to virtual irq 32
/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:99:88:77:66:56
eth1: found Generic MII PHY (0x10)
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
  alloc irq_desc for 33 on node 0
  alloc kstat_irqs on node 0
irq: irq 29 on host /interrupt-controller2 mapped to virtual irq 33
ppc-of-ehci 4bffd0400.ehci: OF EHCI
ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number 1
ppc-of-ehci 4bffd0400.ehci: irq 33, io mem 0x4bffd0400
ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OF EHCI
usb usb1: Manufacturer: Linux 2.6.33 ehci_hcd
usb usb1: SerialNumber: PPC-OF USB
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
i2c /dev entries driver
  alloc irq_desc for 34 on node 0
  alloc kstat_irqs on node 0
irq: irq 2 on host /interrupt-controller0 mapped to virtual irq 34
at24 0-0051: 65536 byte 24c512 EEPROM (writable)
at24 0-0053: 256 byte spd EEPROM (read-only)
ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
  alloc irq_desc for 35 on node 0
  alloc kstat_irqs on node 0
irq: irq 3 on host /interrupt-controller0 mapped to virtual irq 35
ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
rtc-ds1307 5-0068: rtc core: registered ds1338 as rtc0
rtc-ds1307 5-0068: 56 bytes nvram
pca954x 1-0070: registered 8 virtual busses for I2C switch pca9548
pca954x 2-0071: registered 8 virtual busses for I2C switch pca9548
pca954x 3-0072: registered 8 virtual busses for I2C switch pca9548
TCP cubic registered
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
rtc-ds1307 5-0068: setting system clock to 2000-02-28 11:41:36 UTC (951738096)
eth0: link is down
IP-Config: Complete:
     device=eth0, addr=10.0.0.30, mask=255.0.0.0, gw=10.0.0.138,
     host=smbe460, domain=, nis-domain=(none),
     bootserver=10.0.0.10, rootserver=10.0.0.10, rootpath=
Looking up port of RPC 100003/2 on 10.0.0.10
eth0: link is up, 100 FDX, pause enabled
Looking up port of RPC 100005/1 on 10.0.0.10
VFS: Mounted root (nfs filesystem) on device 0:13.
Freeing unused kernel memory: 144k init

# cat /proc/iomem
 
4bffd0400-4bffd048f : ehci_hcd
4cc000000-4cfffffff : 4cc000000.nor_flash
4e4000000-4e7ffffff : 4e4000000.nor_flash2
4ef600300-4ef600307 : serial
4ef600400-4ef600407 : serial
4ef600500-4ef600507 : serial
4ef600600-4ef600607 : serial
d80000000-dffffffff : /plb/pci@c0ec00000
  d80000000-d89ffffff : PCI Bus 0000:01
    d80000000-d83ffffff : 0000:01:00.0
    d84000000-d87ffffff : 0000:01:00.0
    d88000000-d880fffff : 0000:01:00.0
    d88100000-d88103fff : 0000:01:00.0

# cat /proc/ioports

00000000-0000ffff : /plb/pci@c0ec00000
  00000000-00000fff : Legacy IO


--------------030408030205060002000801--
