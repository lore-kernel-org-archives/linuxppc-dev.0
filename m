Return-Path: <dceravigupta@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by ozlabs.org (Postfix) with ESMTP id 8B707B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Sep 2010 19:29:33 +1000 (EST)
Received: by pvg13 with SMTP id 13so2648430pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 08 Sep 2010 02:29:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C8604E1.4080908@windriver.com>
References: <AANLkTim5kasMWC6u-mhQyCRiPv1w7BCg7o-mBfy28DfS@mail.gmail.com>
	<4C85CCD6.3020504@windriver.com>
	<AANLkTi=bDOtCxW9VuXrSyAiCLoFCvWoskORpc_1ebDe7@mail.gmail.com>
	<4C8604E1.4080908@windriver.com>
Date: Wed, 8 Sep 2010 14:59:30 +0530
Message-ID: <AANLkTimLO+xf2Z1zoQfZ8bfB-b--Uu701afr7zg+1r6k@mail.gmail.com>
Subject: Re: pci_request_regions() failure
From: Ravi Gupta <dceravigupta@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Content-Type: multipart/alternative; boundary=0016364179a58d0e0b048fbc2689
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364179a58d0e0b048fbc2689
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tiejun,

Thanks for the reply.


Your PCI device should be one virtual device so I think the above should be
> as
> we understood. You know 0x00000000 ~ 0x00003ffff should not be allowed to
> reserved.
>

Can you explain a little more that what do you mean by "Your PCI device
should be one virtual device"?


> I think you should do the following sequence in the probe function of you=
r
> PCI
> driver.
>
> 1. pci_enable_device(pdev);
> 2. pci_request_regions(pdev, DRV_NAME);
> 3. pci_set_master(pdev);
> ......
>
> Okay, I have  changed my drive code to follow this sequence, but still no
success. It fails with the same errors as before.

# insmod ./pci_skel.ko
PCI driver: Init function
PCI driver: Probe function
pci_skel 0001:02:00.0: device not available (can't reserve [mem
0x00000000-0x0003ffff])
Unable to Enable PCI device:-22
pci_skel: probe of 0001:02:00.0 failed with error -22

Looks we need some pci_fixup to modify them. Firstly I think you'd better
> 'zero'
> all BARs of your PCI device on the function, pci_scan_device, on the file=
,
> drivers/pci/probe.c. On there you can dedicate that once your device is
> probed.
> Please check the each BAR's value again after the above fix.
>
>
Okay, I have set the BARs with all zeros in the pci_scan_device() function.
Below is the diff of the changes done by me.

--- /data/sources/linux-2.6.35/drivers/pci/probe.c  2010-08-02
03:41:14.000000000 +0530
+++ probe.c 2010-09-08 14:45:40.000000000 +0530
@@ -1172,6 +1172,45 @@ static struct pci_dev *pci_scan_device(s
    }
  }

+ printk(KERN_WARNING "pci : vendor id =3D 0x%x\n", l & 0xffff);
+ if ((l & 0xffff) =3D=3D 0x1204) {
+   /* zero's all BAR registers */
+   printk(KERN_WARNING "pci %04x:%02x:%02x.%d: trying to set all zeros in =
"
+       "BARs\n", pci_domain_nr(bus),
+       bus->number, PCI_SLOT(devfn),
+       PCI_FUNC(devfn));
+
+   if(pci_bus_write_config_dword(bus, devfn, PCI_BASE_ADDRESS_0, 0x0) ||
+       pci_bus_write_config_dword(bus, devfn, PCI_BASE_ADDRESS_1, 0x0) ||
+       pci_bus_write_config_dword(bus, devfn, PCI_BASE_ADDRESS_2, 0x0) ||
+       pci_bus_write_config_dword(bus, devfn, PCI_BASE_ADDRESS_3, 0x0) ||
+       pci_bus_write_config_dword(bus, devfn, PCI_BASE_ADDRESS_4, 0x0) ||
+       pci_bus_write_config_dword(bus, devfn, PCI_BASE_ADDRESS_5, 0x0)) {
+
+     printk(KERN_WARNING "pci %04x:%02x:%02x.%d: failed to reset bits"
+         "of BARs\n", pci_domain_nr(bus),
+         bus->number, PCI_SLOT(devfn),
+         PCI_FUNC(devfn));
+     return NULL;
+   }
+ }
+
  dev =3D alloc_pci_dev();
  if (!dev)
    return NULL;

The difference  I have seen in the dmesg is that the following two messages
are not coming now.

PCI: Cannot allocate resource region 0 of device 0001:02:00.0, will remap
PCI: Cannot allocate resource region 1 of device 0001:02:00.0, will remap

But my driver is still fails with the same error as before. I am attaching
the new dmesg log.

Dmesg with all BARs set to zero
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using MPC837x RDB/WLAN machine description
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.35 (okapi@okapi) (gcc version 4.2.3 (Sourcery G++ Lite
4.2-171)) #28 Wed Sep 8 13:20:27 IST 2010
Found initrd at 0xcf46c000:0xcf7b05b7
Found legacy serial port 0 for /immr@e0000000/serial@4500
  mem=3De0004500, taddr=3De0004500, irq=3D0, clk=3D400000002, speed=3D0
Found legacy serial port 1 for /immr@e0000000/serial@4600
  mem=3De0004600, taddr=3De0004600, irq=3D0, clk=3D400000002, speed=3D0
bootconsole [udbg0] enabled
Found FSL PCI host bridge at 0x00000000e0008500. Firmware bus number: 0->0
PCI host bridge /pci@e0008500 (primary) ranges:
 MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000
 MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 Prefetch
  IO 0x00000000e0300000..0x00000000e03fffff -> 0x0000000000000000
No pci config register base in dev tree, using default
Found FSL PCI host bridge at 0x00000000e0009000. Firmware bus number: 0->25=
5
PCI host bridge /pcie@e0009000  ranges:
 MEM 0x00000000a8000000..0x00000000b7ffffff -> 0x00000000a8000000
  IO 0x00000000b8000000..0x00000000b87fffff -> 0x0000000000000000
No pci config register base in dev tree, using default
Found FSL PCI host bridge at 0x00000000e000a000. Firmware bus number: 0->25=
5
PCI host bridge /pcie@e000a000  ranges:
 MEM 0x00000000c8000000..0x00000000d7ffffff -> 0x00000000c8000000
  IO 0x00000000d8000000..0x00000000d87fffff -> 0x0000000000000000
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00010000
  Normal   empty
  HighMem  empty
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat c04265e8, node_mem_map c0800000
  DMA zone: 512 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 65024 pages, LIFO batch:15
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=3D/dev/ram ramdisk_size=3D120000 rw ip=3D10.20.50=
.230:10
.20.50.70:10.20.50.50:255.255.0.0:PowerQUICC:eth0:off console=3DttyS0,11520=
0
mtdparts=3Dnand:4m(kernel),-(jffs2)
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
High memory: 0k
Memory: 249972k/262144k available (4064k kernel code, 12172k reserved, 244k
data, 2187k bss, 188k init)
Kernel virtual memory layout:
  * 0xfffcf000..0xfffff000  : fixmap
  * 0xff800000..0xffc00000  : highmem PTEs
  * 0xfe6f7000..0xff800000  : early ioremap
  * 0xd1000000..0xfe6f7000  : vmalloc & ioremap
Hierarchical RCU implementation.
    RCU-based detection of stalled CPUs is disabled.
    Verbose stalled-CPUs detection is disabled.
NR_IRQS:512
IPIC (128 IRQ sources) at d1000700
time_init: decrementer frequency =3D 100.000000 MHz
time_init: processor frequency   =3D 800.000004 MHz
clocksource: timebase mult[2800000] shift[22] registered
clockevent: decrementer mult[19999999] shift[32] cpu[0]
Console: colour dummy device 80x25
pid_max: default: 32768 minimum: 301
Security Framework initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys devices
NET: Registered protocol family 16
irq: irq 38 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 38
__irq_set_trigger: setting type, irq =3D 38, flags =3D 8
ipic_set_irq_type function, with virq =3D 38, flow =3D 8
irq: irq 74 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 74
__irq_set_trigger: setting type, irq =3D 74, flags =3D 8
ipic_set_irq_type function, with virq =3D 74, flow =3D 8
irq: irq 75 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 75
__irq_set_trigger: setting type, irq =3D 75, flags =3D 8
ipic_set_irq_type function, with virq =3D 75, flow =3D 8
PCI: Probing PCI hardware
PCI: Scanning PHB /pci@e0008500
PCI: PHB IO resource    =3D 0000000000000000-00000000000fffff [100]
PCI: PHB MEM resource 0 =3D 0000000090000000-000000009fffffff [200]
PCI: PHB MEM resource 1 =3D 0000000080000000-000000008fffffff [2200]
PCI: PHB MEM offset     =3D 0000000000000000
PCI: PHB IO  offset     =3D 00000000
    probe mode: 0
pci_bus 0000:00: scanning bus
pci : vendor id =3D 0x1957
pci 0000:00:00.0: found [1957:00c6] class 000b20 header type 00
pci 0000:00:00.0: reg 10: [mem 0x00000000-0x000fffff]
pci 0000:00:00.0: reg 18: [mem 0x00000000-0x0fffffff 64bit pref]
pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58
pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x180
pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x48
pci 0000:00:00.0: calling quirk_resource_alignment+0x0/0x1c0
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
PCI: Fixup bus devices 0 (PHB)
PCI: Try to map irq for 0000:00:00.0...
pci_bus 0000:00: bus scan returning with max=3D00
PCI: Scanning PHB /pcie@e0009000
PCI: PHB IO resource    =3D 00000000ff7fe000-00000000ffffdfff [100]
PCI: PHB MEM resource 0 =3D 00000000a8000000-00000000b7ffffff [200]
PCI: PHB MEM offset     =3D 0000000000000000
PCI: PHB IO  offset     =3D ff7fe000
    probe mode: 0
pci_bus 0001:01: scanning bus
pci : vendor id =3D 0x1957
pci 0001:01:00.0: found [1957:00c6] class 000b20 header type 01
pci 0001:01:00.0: ignoring class b20 (doesn't match header type 01)
pci 0001:01:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58
pci 0001:01:00.0: calling pcibios_fixup_resources+0x0/0x180
pci 0001:01:00.0: calling quirk_fsl_pcie_header+0x0/0x48
pci 0001:01:00.0: calling quirk_resource_alignment+0x0/0x1c0
pci 0001:01:00.0: supports D1 D2
pci 0001:01:00.0: PME# supported from D0 D1 D2 D3hot
pci 0001:01:00.0: PME# disabled
pci_bus 0001:01: fixups for bus
PCI: Fixup bus devices 1 (PHB)
PCI: Try to map irq for 0001:01:00.0...
pci 0001:01:00.0: scanning [bus 01-ff] behind bridge, pass 0
pci 0001:01:00.0: bus configuration invalid, reconfiguring
pci 0001:01:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0001:02: scanning bus
pci : vendor id =3D 0x1204
pci 0001:02:00.0: trying to set all zeros in BARs
pci 0001:02:00.0: found [1204:e250] class 000000 header type 00
pci 0001:02:00.0: reg 10: [mem 0x00000000-0x0003ffff]
pci 0001:02:00.0: reg 14: [mem 0x00000000-0x0003ffff]
pci 0001:02:00.0: calling pcibios_fixup_resources+0x0/0x180
PCI:0001:02:00.0 Resource 0 0000000000000000-000000000003ffff [40200] is
unassigned
PCI:0001:02:00.0 Resource 1 0000000000000000-000000000003ffff [40200] is
unassigned
pci 0001:02:00.0: calling quirk_resource_alignment+0x0/0x1c0
pci_bus 0001:02: fixups for bus
pci 0001:01:00.0: PCI bridge to [bus 02-ff]
pci 0001:01:00.0:   bridge window [io  0x0000-0x0000] (disabled)
pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
(disabled)
PCI: Fixup bus devices 2 (0001:01:00.0)
PCI: Try to map irq for 0001:02:00.0...
 Got one, spec 2 cells (0x00000001 0x00000008...) on /immr@e0000000
/interrupt-controller@700
irq: irq 1 on host /immr@e0000000/interrupt-controller@700 mapped to virtua=
l
irq 16
__irq_set_trigger: setting type, irq =3D 16, flags =3D 8
ipic_set_irq_type function, with virq =3D 16, flow =3D 8
 Mapped to linux irq 16
pci_bus 0001:02: bus scan returning with max=3D02
pci_bus 0001:01: bus scan returning with max=3D02
PCI: Scanning PHB /pcie@e000a000
PCI: PHB IO resource    =3D 00000000feffc000-00000000ff7fbfff [100]
PCI: PHB MEM resource 0 =3D 00000000c8000000-00000000d7ffffff [200]
PCI: PHB MEM offset     =3D 0000000000000000
PCI: PHB IO  offset     =3D feffc000
    probe mode: 0
pci_bus 0002:03: scanning bus
pci_bus 0002:03: fixups for bus
PCI: Fixup bus devices 3 (PHB)
pci_bus 0002:03: bus scan returning with max=3D03
PCI->OF bus map:
0 -> 0
1 -> 0
3 -> 0
PCI: Allocating bus resources for 0000:00...
PCI: PHB (bus 0) bridge rsrc 0: 0000000000000000-00000000000fffff [0x100],
parent c03fe5a0 (PCI IO)
PCI: PHB (bus 0) bridge rsrc 1: 0000000090000000-000000009fffffff [0x200],
parent c03fe584 (PCI mem)
PCI: PHB (bus 0) bridge rsrc 2: 0000000080000000-000000008fffffff [0x2200],
parent c03fe584 (PCI mem)
PCI: Allocating bus resources for 0001:01...
PCI: PHB (bus 1) bridge rsrc 0: 00000000ff7fe000-00000000ffffdfff [0x100],
parent c03fe5a0 (PCI IO)
PCI: PHB (bus 1) bridge rsrc 1: 00000000a8000000-00000000b7ffffff [0x200],
parent c03fe584 (PCI mem)
PCI: Allocating bus resources for 0001:02...
PCI: Allocating bus resources for 0002:03...
PCI: PHB (bus 3) bridge rsrc 0: 00000000feffc000-00000000ff7fbfff [0x100],
parent c03fe5a0 (PCI IO)
PCI: PHB (bus 3) bridge rsrc 1: 00000000c8000000-00000000d7ffffff [0x200],
parent c03fe584 (PCI mem)
Reserving legacy ranges for domain 0000
Candidate legacy IO: [io  0x0000-0x0fff]
hose mem offset: 0000000000000000
hose mem res: [mem 0x90000000-0x9fffffff]
hose mem res: [mem 0x80000000-0x8fffffff pref]
Reserving legacy ranges for domain 0001
Candidate legacy IO: [io  0xff7fe000-0xff7fefff]
hose mem offset: 0000000000000000
hose mem res: [mem 0xa8000000-0xb7ffffff]
Reserving legacy ranges for domain 0002
Candidate legacy IO: [io  0xfeffc000-0xfeffcfff]
hose mem offset: 0000000000000000
hose mem res: [mem 0xc8000000-0xd7ffffff]
PCI: Assigning unassigned resources...
pci 0001:01:00.0: BAR 8: assigned [mem 0xa8000000-0xa80fffff]
pci 0001:01:00.0: PCI bridge to [bus 02-02]
pci 0001:01:00.0:   bridge window [io  disabled]
pci 0001:01:00.0:   bridge window [mem 0xa8000000-0xa80fffff]
pci 0001:01:00.0:   bridge window [mem pref disabled]
pci_bus 0000:00: resource 0 [io  0x0000-0xfffff]
pci_bus 0000:00: resource 1 [mem 0x90000000-0x9fffffff]
pci_bus 0000:00: resource 2 [mem 0x80000000-0x8fffffff pref]
pci_bus 0001:01: resource 0 [io  0xff7fe000-0xffffdfff]
pci_bus 0001:01: resource 1 [mem 0xa8000000-0xb7ffffff]
pci_bus 0001:02: resource 1 [mem 0xa8000000-0xa80fffff]
pci_bus 0002:03: resource 0 [io  0xfeffc000-0xff7fbfff]
pci_bus 0002:03: resource 1 [mem 0xc8000000-0xd7ffffff]
Registering qe_ic with sysfs...
Registering ipic with sysfs...
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
Switching to clocksource timebase
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
pci 0000:00:00.0: calling quirk_cardbus_legacy+0x0/0x44
pci 0000:00:00.0: calling quirk_usb_early_handoff+0x0/0x740
pci 0001:01:00.0: calling quirk_cardbus_legacy+0x0/0x44
pci 0001:01:00.0: calling quirk_usb_early_handoff+0x0/0x740
pci 0001:02:00.0: calling quirk_cardbus_legacy+0x0/0x44
pci 0001:02:00.0: calling quirk_usb_early_handoff+0x0/0x740
PCI: CLS 32 bytes, default 32
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 3345k freed
irq: irq 9 on host /immr@e0000000/interrupt-controller@700 mapped to virtua=
l
irq 17
__irq_set_trigger: setting type, irq =3D 17, flags =3D 8
ipic_set_irq_type function, with virq =3D 17, flow =3D 8
irq: irq 10 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 18
__irq_set_trigger: setting type, irq =3D 18, flags =3D 8
ipic_set_irq_type function, with virq =3D 18, flow =3D 8
irq: irq 80 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 80
__irq_set_trigger: setting type, irq =3D 80, flags =3D 8
ipic_set_irq_type function, with virq =3D 80, flow =3D 8
audit: initializing netlink socket (disabled)
type=3D2000 audit(0.212:1): initialized
JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
SGI XFS with security attributes, large block/inode numbers, no debug
enabled
msgmni has been set to 494
alg: No test for cipher_null (cipher_null-generic)
alg: No test for ecb(cipher_null) (ecb-cipher_null)
alg: No test for digest_null (digest_null-generic)
alg: No test for compress_null (compress_null-generic)
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 17) is a 16550A
console [ttyS0] enabled, bootconsole disabled
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 18) is a 16550A
brd: module loaded
of_mpc8xxx_spi_probe function called.
irq: irq 16 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 19
__irq_set_trigger: setting type, irq =3D 19, flags =3D 8
ipic_set_irq_type function, with virq =3D 19, flow =3D 8
mpc8xxx_spi_probe function called.
mpc8xxx_spi e0007000.spi: at 0xd1078000 (irq =3D 19), CPU mode
irq: irq 32 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 32
__irq_set_trigger: setting type, irq =3D 32, flags =3D 8
ipic_set_irq_type function, with virq =3D 32, flow =3D 8
irq: irq 33 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 33
__irq_set_trigger: setting type, irq =3D 33, flags =3D 8
ipic_set_irq_type function, with virq =3D 33, flow =3D 8
irq: irq 34 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 34
__irq_set_trigger: setting type, irq =3D 34, flags =3D 8
ipic_set_irq_type function, with virq =3D 34, flow =3D 8
eth0: Gianfar Ethernet Controller Version 1.2, 04:00:00:00:00:0a
eth0: Running with NAPI enabled
eth0: RX BD ring size for Q[0]: 256
eth0: TX BD ring size for Q[0]: 256
irq: irq 35 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 35
__irq_set_trigger: setting type, irq =3D 35, flags =3D 8
ipic_set_irq_type function, with virq =3D 35, flow =3D 8
irq: irq 36 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 36
__irq_set_trigger: setting type, irq =3D 36, flags =3D 8
ipic_set_irq_type function, with virq =3D 36, flow =3D 8
irq: irq 37 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 37
__irq_set_trigger: setting type, irq =3D 37, flags =3D 8
ipic_set_irq_type function, with virq =3D 37, flow =3D 8
eth1: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00
eth1: Running with NAPI enabled
eth1: RX BD ring size for Q[0]: 256
eth1: TX BD ring size for Q[0]: 256
ucc_geth: QE UCC Gigabit Ethernet Controller
Freescale PowerQUICC MII Bus: probed
irq: irq 17 on host /immr@e0000000/interrupt-controller@700 mapped to
virtual irq 20
__irq_set_trigger: setting type, irq =3D 20, flags =3D 8
ipic_set_irq_type function, with virq =3D 20, flow =3D 8
Freescale PowerQUICC MII Bus: probed
mice: PS/2 mouse device common for all mice
Skipping unavailable LED gpio -19 (pwr)
Skipping unavailable LED gpio -19 (hdd)
TCP cubic registered
NET: Registered protocol family 17
registered taskstats version 1
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
RAMDISK: gzip image found at block 0
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing unused kernel memory: 188k init
PHY: mdio@e0024520:02 - Link is Up - 10/Half
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Regards,
Ravi

--0016364179a58d0e0b048fbc2689
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tiejun,<br><br>Thanks for the reply.<br><br><br><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bo=
rder-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div><div clas=
s=3D"h5">


</div></div>Your PCI device should be one virtual device so I think the abo=
ve should be as<br>
we understood. You know 0x00000000 ~ 0x00003ffff should not be allowed to<b=
r>
reserved.<br></blockquote><div><br>Can you explain a little more that what =
do you mean by &quot;Your PCI device should be one virtual device&quot;?<br=
>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.=
8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
I think you should do the following sequence in the probe function of your =
PCI<br>
driver.<br>
<br>
1. pci_enable_device(pdev);<br>
2. pci_request_regions(pdev, DRV_NAME);<br>
3. pci_set_master(pdev);<br>
......<br>
<div><div class=3D"h5"><br></div></div></blockquote><div>Okay, I have=A0 ch=
anged my drive code to follow this sequence, but still no success. It fails=
 with the same errors as before.<br><br># insmod ./pci_skel.ko<br>PCI drive=
r: Init function<br>
PCI driver: Probe function<br>pci_skel 0001:02:00.0: device not available (=
can&#39;t reserve [mem 0x00000000-0x0003ffff])<br>Unable to Enable PCI devi=
ce:-22<br>pci_skel: probe of 0001:02:00.0 failed with error -22<br><br>
</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Looks we need some pci_fixup to modify them. Firstly I think you&#39;d bett=
er &#39;zero&#39;<br>
all BARs of your PCI device on the function, pci_scan_device, on the file,<=
br>
drivers/pci/probe.c. On there you can dedicate that once your device is pro=
bed.<br>
Please check the each BAR&#39;s value again after the above fix.<br>
<br></blockquote><div><br>Okay, I have set the BARs with all zeros in the p=
ci_scan_device() function. Below is the diff of the changes done by me.<br>=
<br>--- /data/sources/linux-2.6.35/drivers/pci/probe.c=A0 2010-08-02 03:41:=
14.000000000 +0530<br>
+++ probe.c 2010-09-08 14:45:40.000000000 +0530<br>@@ -1172,6 +1172,45 @@ s=
tatic struct pci_dev *pci_scan_device(s<br>=A0=A0=A0 }=A0=A0 <br>=A0 }<br>=
=A0<br>+ printk(KERN_WARNING &quot;pci : vendor id =3D 0x%x\n&quot;, l &amp=
; 0xffff);<br>
+ if ((l &amp; 0xffff) =3D=3D 0x1204) {<br>+=A0=A0 /* zero&#39;s all BAR re=
gisters */<br>+=A0=A0 printk(KERN_WARNING &quot;pci %04x:%02x:%02x.%d: tryi=
ng to set all zeros in &quot;<br>+=A0=A0=A0=A0=A0=A0 &quot;BARs\n&quot;, pc=
i_domain_nr(bus),<br>
+=A0=A0=A0=A0=A0=A0 bus-&gt;number, PCI_SLOT(devfn),<br>+=A0=A0=A0=A0=A0=A0=
 PCI_FUNC(devfn));<br>+<br>+=A0=A0 if(pci_bus_write_config_dword(bus, devfn=
, PCI_BASE_ADDRESS_0, 0x0) ||<br>+=A0=A0=A0=A0=A0=A0 pci_bus_write_config_d=
word(bus, devfn, PCI_BASE_ADDRESS_1, 0x0) ||<br>
+=A0=A0=A0=A0=A0=A0 pci_bus_write_config_dword(bus, devfn, PCI_BASE_ADDRESS=
_2, 0x0) ||<br>+=A0=A0=A0=A0=A0=A0 pci_bus_write_config_dword(bus, devfn, P=
CI_BASE_ADDRESS_3, 0x0) ||<br>+=A0=A0=A0=A0=A0=A0 pci_bus_write_config_dwor=
d(bus, devfn, PCI_BASE_ADDRESS_4, 0x0) ||<br>
+=A0=A0=A0=A0=A0=A0 pci_bus_write_config_dword(bus, devfn, PCI_BASE_ADDRESS=
_5, 0x0)) {<br>+<br>+=A0=A0=A0=A0 printk(KERN_WARNING &quot;pci %04x:%02x:%=
02x.%d: failed to reset bits&quot;<br>+=A0=A0=A0=A0=A0=A0=A0=A0 &quot;of BA=
Rs\n&quot;, pci_domain_nr(bus),<br>
+=A0=A0=A0=A0=A0=A0=A0=A0 bus-&gt;number, PCI_SLOT(devfn),<br>+=A0=A0=A0=A0=
=A0=A0=A0=A0 PCI_FUNC(devfn));<br>+=A0=A0=A0=A0 return NULL;<br>+=A0=A0 }<b=
r>+ }<br>+<br>=A0 dev =3D alloc_pci_dev();<br>=A0 if (!dev)<br>=A0=A0=A0 re=
turn NULL;<br><br>The difference=A0 I have seen in the dmesg is that the fo=
llowing two messages are not coming now.<br>
<br>PCI: Cannot allocate resource region 0 of device 0001:02:00.0, will rem=
ap<br>PCI: Cannot allocate resource region 1 of device 0001:02:00.0, will r=
emap<br><br>But my driver is still fails with the same error as before. I a=
m attaching the new dmesg log.<br>
<br>Dmesg with all BARs set to zero<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br></div></div>Using MPC837x RDB=
/WLAN machine description<br>Initializing cgroup subsys cpuset<br>Initializ=
ing cgroup subsys cpu<br>Linux version 2.6.35 (okapi@okapi) (gcc version 4.=
2.3 (Sourcery G++ Lite 4.2-171)) #28 Wed Sep 8 13:20:27 IST 2010<br>
Found initrd at 0xcf46c000:0xcf7b05b7<br>Found legacy serial port 0 for /im=
mr@e0000000/serial@4500<br>=A0 mem=3De0004500, taddr=3De0004500, irq=3D0, c=
lk=3D400000002, speed=3D0<br>Found legacy serial port 1 for /immr@e0000000/=
serial@4600<br>
=A0 mem=3De0004600, taddr=3De0004600, irq=3D0, clk=3D400000002, speed=3D0<b=
r>bootconsole [udbg0] enabled<br>Found FSL PCI host bridge at 0x00000000e00=
08500. Firmware bus number: 0-&gt;0<br>PCI host bridge /pci@e0008500 (prima=
ry) ranges:<br>
=A0MEM 0x0000000090000000..0x000000009fffffff -&gt; 0x0000000090000000 <br>=
=A0MEM 0x0000000080000000..0x000000008fffffff -&gt; 0x0000000080000000 Pref=
etch<br>=A0 IO 0x00000000e0300000..0x00000000e03fffff -&gt; 0x0000000000000=
000<br>
No pci config register base in dev tree, using default<br>Found FSL PCI hos=
t bridge at 0x00000000e0009000. Firmware bus number: 0-&gt;255<br>PCI host =
bridge /pcie@e0009000=A0 ranges:<br>=A0MEM 0x00000000a8000000..0x00000000b7=
ffffff -&gt; 0x00000000a8000000 <br>
=A0 IO 0x00000000b8000000..0x00000000b87fffff -&gt; 0x0000000000000000<br>N=
o pci config register base in dev tree, using default<br>Found FSL PCI host=
 bridge at 0x00000000e000a000. Firmware bus number: 0-&gt;255<br>PCI host b=
ridge /pcie@e000a000=A0 ranges:<br>
=A0MEM 0x00000000c8000000..0x00000000d7ffffff -&gt; 0x00000000c8000000 <br>=
=A0 IO 0x00000000d8000000..0x00000000d87fffff -&gt; 0x0000000000000000<br>T=
op of RAM: 0x10000000, Total RAM: 0x10000000<br>Memory hole size: 0MB<br>Zo=
ne PFN ranges:<br>
=A0 DMA=A0=A0=A0=A0=A0 0x00000000 -&gt; 0x00010000<br>=A0 Normal=A0=A0 empt=
y<br>=A0 HighMem=A0 empty<br>Movable zone start PFN for each node<br>early_=
node_map[1] active PFN ranges<br>=A0=A0=A0 0: 0x00000000 -&gt; 0x00010000<b=
r>On node 0 totalpages: 65536<br>
free_area_init_node: node 0, pgdat c04265e8, node_mem_map c0800000<br>=A0 D=
MA zone: 512 pages used for memmap<br>=A0 DMA zone: 0 pages reserved<br>=A0=
 DMA zone: 65024 pages, LIFO batch:15<br>Built 1 zonelists in Zone order, m=
obility grouping on.=A0 Total pages: 65024<br>
Kernel command line: root=3D/dev/ram ramdisk_size=3D120000 rw ip=3D10.20.50=
.230:10.20.50.70:10.20.50.50:255.255.0.0:PowerQUICC:eth0:off console=3DttyS=
0,115200 mtdparts=3Dnand:4m(kernel),-(jffs2)<br>PID hash table entries: 102=
4 (order: 0, 4096 bytes)<br>
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>Inode-ca=
che hash table entries: 16384 (order: 4, 65536 bytes)<br>High memory: 0k<br=
>Memory: 249972k/262144k available (4064k kernel code, 12172k reserved, 244=
k data, 2187k bss, 188k init)<br>
Kernel virtual memory layout:<br>=A0 * 0xfffcf000..0xfffff000=A0 : fixmap<b=
r>=A0 * 0xff800000..0xffc00000=A0 : highmem PTEs<br>=A0 * 0xfe6f7000..0xff8=
00000=A0 : early ioremap<br>=A0 * 0xd1000000..0xfe6f7000=A0 : vmalloc &amp;=
 ioremap<br>
Hierarchical RCU implementation.<br>=A0=A0=A0 RCU-based detection of stalle=
d CPUs is disabled.<br>=A0=A0=A0 Verbose stalled-CPUs detection is disabled=
.<br>NR_IRQS:512<br>IPIC (128 IRQ sources) at d1000700<br>time_init: decrem=
enter frequency =3D 100.000000 MHz<br>
time_init: processor frequency=A0=A0 =3D 800.000004 MHz<br>clocksource: tim=
ebase mult[2800000] shift[22] registered<br>clockevent: decrementer mult[19=
999999] shift[32] cpu[0]<br>Console: colour dummy device 80x25<br>pid_max: =
default: 32768 minimum: 301<br>
Security Framework initialized<br>SELinux:=A0 Disabled at boot.<br>Mount-ca=
che hash table entries: 512<br>Initializing cgroup subsys ns<br>Initializin=
g cgroup subsys cpuacct<br>Initializing cgroup subsys devices<br>NET: Regis=
tered protocol family 16<br>
irq: irq 38 on host /immr@e0000000/interrupt-controller@700 mapped to virtu=
al irq 38<br>__irq_set_trigger: setting type, irq =3D 38, flags =3D 8<br>ip=
ic_set_irq_type function, with virq =3D 38, flow =3D 8<br>irq: irq 74 on ho=
st /immr@e0000000/interrupt-controller@700 mapped to virtual irq 74<br>
__irq_set_trigger: setting type, irq =3D 74, flags =3D 8<br>ipic_set_irq_ty=
pe function, with virq =3D 74, flow =3D 8<br>irq: irq 75 on host /immr@e000=
0000/interrupt-controller@700 mapped to virtual irq 75<br>__irq_set_trigger=
: setting type, irq =3D 75, flags =3D 8<br>
ipic_set_irq_type function, with virq =3D 75, flow =3D 8<br>PCI: Probing PC=
I hardware<br>PCI: Scanning PHB /pci@e0008500<br>PCI: PHB IO resource=A0=A0=
=A0 =3D 0000000000000000-00000000000fffff [100]<br>PCI: PHB MEM resource 0 =
=3D 0000000090000000-000000009fffffff [200]<br>
PCI: PHB MEM resource 1 =3D 0000000080000000-000000008fffffff [2200]<br>PCI=
: PHB MEM offset=A0=A0=A0=A0 =3D 0000000000000000<br>PCI: PHB IO=A0 offset=
=A0=A0=A0=A0 =3D 00000000<br>=A0=A0=A0 probe mode: 0<br>pci_bus 0000:00: sc=
anning bus<br>pci : vendor id =3D 0x1957<br>
pci 0000:00:00.0: found [1957:00c6] class 000b20 header type 00<br>pci 0000=
:00:00.0: reg 10: [mem 0x00000000-0x000fffff]<br>pci 0000:00:00.0: reg 18: =
[mem 0x00000000-0x0fffffff 64bit pref]<br>pci 0000:00:00.0: calling fixup_h=
ide_host_resource_fsl+0x0/0x58<br>
pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x180<br>pci 0000:00:=
00.0: calling quirk_fsl_pcie_header+0x0/0x48<br>pci 0000:00:00.0: calling q=
uirk_resource_alignment+0x0/0x1c0<br>pci 0000:00:00.0: supports D1 D2<br>
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot<br>pci 0000:00:00.0: P=
ME# disabled<br>pci_bus 0000:00: fixups for bus<br>PCI: Fixup bus devices 0=
 (PHB)<br>PCI: Try to map irq for 0000:00:00.0...<br>pci_bus 0000:00: bus s=
can returning with max=3D00<br>
PCI: Scanning PHB /pcie@e0009000<br>PCI: PHB IO resource=A0=A0=A0 =3D 00000=
000ff7fe000-00000000ffffdfff [100]<br>PCI: PHB MEM resource 0 =3D 00000000a=
8000000-00000000b7ffffff [200]<br>PCI: PHB MEM offset=A0=A0=A0=A0 =3D 00000=
00000000000<br>PCI: PHB IO=A0 offset=A0=A0=A0=A0 =3D ff7fe000<br>
=A0=A0=A0 probe mode: 0<br>pci_bus 0001:01: scanning bus<br>pci : vendor id=
 =3D 0x1957<br>pci 0001:01:00.0: found [1957:00c6] class 000b20 header type=
 01<br>pci 0001:01:00.0: ignoring class b20 (doesn&#39;t match header type =
01)<br>
pci 0001:01:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58<br>pci 0001=
:01:00.0: calling pcibios_fixup_resources+0x0/0x180<br>pci 0001:01:00.0: ca=
lling quirk_fsl_pcie_header+0x0/0x48<br>pci 0001:01:00.0: calling quirk_res=
ource_alignment+0x0/0x1c0<br>
pci 0001:01:00.0: supports D1 D2<br>pci 0001:01:00.0: PME# supported from D=
0 D1 D2 D3hot<br>pci 0001:01:00.0: PME# disabled<br>pci_bus 0001:01: fixups=
 for bus<br>PCI: Fixup bus devices 1 (PHB)<br>PCI: Try to map irq for 0001:=
01:00.0...<br>
pci 0001:01:00.0: scanning [bus 01-ff] behind bridge, pass 0<br>pci 0001:01=
:00.0: bus configuration invalid, reconfiguring<br>pci 0001:01:00.0: scanni=
ng [bus 00-00] behind bridge, pass 1<br>pci_bus 0001:02: scanning bus<br>
pci : vendor id =3D 0x1204<br>pci 0001:02:00.0: trying to set all zeros in =
BARs<br>pci 0001:02:00.0: found [1204:e250] class 000000 header type 00<br>=
pci 0001:02:00.0: reg 10: [mem 0x00000000-0x0003ffff]<br>pci 0001:02:00.0: =
reg 14: [mem 0x00000000-0x0003ffff]<br>
pci 0001:02:00.0: calling pcibios_fixup_resources+0x0/0x180<br>PCI:0001:02:=
00.0 Resource 0 0000000000000000-000000000003ffff [40200] is unassigned<br>=
PCI:0001:02:00.0 Resource 1 0000000000000000-000000000003ffff [40200] is un=
assigned<br>
pci 0001:02:00.0: calling quirk_resource_alignment+0x0/0x1c0<br>pci_bus 000=
1:02: fixups for bus<br>pci 0001:01:00.0: PCI bridge to [bus 02-ff]<br>pci =
0001:01:00.0:=A0=A0 bridge window [io=A0 0x0000-0x0000] (disabled)<br>pci 0=
001:01:00.0:=A0=A0 bridge window [mem 0x00000000-0x000fffff] (disabled)<br>
pci 0001:01:00.0:=A0=A0 bridge window [mem 0x00000000-0x000fffff pref] (dis=
abled)<br>PCI: Fixup bus devices 2 (0001:01:00.0)<br>PCI: Try to map irq fo=
r 0001:02:00.0...<br>=A0Got one, spec 2 cells (0x00000001 0x00000008...) on=
 /immr@e0000000/interrupt-controller@700<br>
irq: irq 1 on host /immr@e0000000/interrupt-controller@700 mapped to virtua=
l irq 16<br>__irq_set_trigger: setting type, irq =3D 16, flags =3D 8<br>ipi=
c_set_irq_type function, with virq =3D 16, flow =3D 8<br>=A0Mapped to linux=
 irq 16<br>
pci_bus 0001:02: bus scan returning with max=3D02<br>pci_bus 0001:01: bus s=
can returning with max=3D02<br>PCI: Scanning PHB /pcie@e000a000<br>PCI: PHB=
 IO resource=A0=A0=A0 =3D 00000000feffc000-00000000ff7fbfff [100]<br>PCI: P=
HB MEM resource 0 =3D 00000000c8000000-00000000d7ffffff [200]<br>
PCI: PHB MEM offset=A0=A0=A0=A0 =3D 0000000000000000<br>PCI: PHB IO=A0 offs=
et=A0=A0=A0=A0 =3D feffc000<br>=A0=A0=A0 probe mode: 0<br>pci_bus 0002:03: =
scanning bus<br>pci_bus 0002:03: fixups for bus<br>PCI: Fixup bus devices 3=
 (PHB)<br>pci_bus 0002:03: bus scan returning with max=3D03<br>
PCI-&gt;OF bus map:<br>0 -&gt; 0<br>1 -&gt; 0<br>3 -&gt; 0<br>PCI: Allocati=
ng bus resources for 0000:00...<br>PCI: PHB (bus 0) bridge rsrc 0: 00000000=
00000000-00000000000fffff [0x100], parent c03fe5a0 (PCI IO)<br>PCI: PHB (bu=
s 0) bridge rsrc 1: 0000000090000000-000000009fffffff [0x200], parent c03fe=
584 (PCI mem)<br>
PCI: PHB (bus 0) bridge rsrc 2: 0000000080000000-000000008fffffff [0x2200],=
 parent c03fe584 (PCI mem)<br>PCI: Allocating bus resources for 0001:01...<=
br>PCI: PHB (bus 1) bridge rsrc 0: 00000000ff7fe000-00000000ffffdfff [0x100=
], parent c03fe5a0 (PCI IO)<br>
PCI: PHB (bus 1) bridge rsrc 1: 00000000a8000000-00000000b7ffffff [0x200], =
parent c03fe584 (PCI mem)<br>PCI: Allocating bus resources for 0001:02...<b=
r>PCI: Allocating bus resources for 0002:03...<br>PCI: PHB (bus 3) bridge r=
src 0: 00000000feffc000-00000000ff7fbfff [0x100], parent c03fe5a0 (PCI IO)<=
br>
PCI: PHB (bus 3) bridge rsrc 1: 00000000c8000000-00000000d7ffffff [0x200], =
parent c03fe584 (PCI mem)<br>Reserving legacy ranges for domain 0000<br>Can=
didate legacy IO: [io=A0 0x0000-0x0fff]<br>hose mem offset: 000000000000000=
0<br>
hose mem res: [mem 0x90000000-0x9fffffff]<br>hose mem res: [mem 0x80000000-=
0x8fffffff pref]<br>Reserving legacy ranges for domain 0001<br>Candidate le=
gacy IO: [io=A0 0xff7fe000-0xff7fefff]<br>hose mem offset: 0000000000000000=
<br>
hose mem res: [mem 0xa8000000-0xb7ffffff]<br>Reserving legacy ranges for do=
main 0002<br>Candidate legacy IO: [io=A0 0xfeffc000-0xfeffcfff]<br>hose mem=
 offset: 0000000000000000<br>hose mem res: [mem 0xc8000000-0xd7ffffff]<br>
PCI: Assigning unassigned resources...<br>pci 0001:01:00.0: BAR 8: assigned=
 [mem 0xa8000000-0xa80fffff]<br>pci 0001:01:00.0: PCI bridge to [bus 02-02]=
<br>pci 0001:01:00.0:=A0=A0 bridge window [io=A0 disabled]<br>pci 0001:01:0=
0.0:=A0=A0 bridge window [mem 0xa8000000-0xa80fffff]<br>
pci 0001:01:00.0:=A0=A0 bridge window [mem pref disabled]<br>pci_bus 0000:0=
0: resource 0 [io=A0 0x0000-0xfffff]<br>pci_bus 0000:00: resource 1 [mem 0x=
90000000-0x9fffffff]<br>pci_bus 0000:00: resource 2 [mem 0x80000000-0x8ffff=
fff pref]<br>
pci_bus 0001:01: resource 0 [io=A0 0xff7fe000-0xffffdfff]<br>pci_bus 0001:0=
1: resource 1 [mem 0xa8000000-0xb7ffffff]<br>pci_bus 0001:02: resource 1 [m=
em 0xa8000000-0xa80fffff]<br>pci_bus 0002:03: resource 0 [io=A0 0xfeffc000-=
0xff7fbfff]<br>
pci_bus 0002:03: resource 1 [mem 0xc8000000-0xd7ffffff]<br>Registering qe_i=
c with sysfs...<br>Registering ipic with sysfs...<br>bio: create slab &lt;b=
io-0&gt; at 0<br>vgaarb: loaded<br>SCSI subsystem initialized<br>Switching =
to clocksource timebase<br>
NET: Registered protocol family 2<br>IP route cache hash table entries: 204=
8 (order: 1, 8192 bytes)<br>TCP established hash table entries: 8192 (order=
: 4, 65536 bytes)<br>TCP bind hash table entries: 8192 (order: 3, 32768 byt=
es)<br>
TCP: Hash tables configured (established 8192 bind 8192)<br>TCP reno regist=
ered<br>UDP hash table entries: 256 (order: 0, 4096 bytes)<br>UDP-Lite hash=
 table entries: 256 (order: 0, 4096 bytes)<br>NET: Registered protocol fami=
ly 1<br>
pci 0000:00:00.0: calling quirk_cardbus_legacy+0x0/0x44<br>pci 0000:00:00.0=
: calling quirk_usb_early_handoff+0x0/0x740<br>pci 0001:01:00.0: calling qu=
irk_cardbus_legacy+0x0/0x44<br>pci 0001:01:00.0: calling quirk_usb_early_ha=
ndoff+0x0/0x740<br>
pci 0001:02:00.0: calling quirk_cardbus_legacy+0x0/0x44<br>pci 0001:02:00.0=
: calling quirk_usb_early_handoff+0x0/0x740<br>PCI: CLS 32 bytes, default 3=
2<br>Trying to unpack rootfs image as initramfs...<br>rootfs image is not i=
nitramfs (no cpio magic); looks like an initrd<br>
Freeing initrd memory: 3345k freed<br>irq: irq 9 on host /immr@e0000000/int=
errupt-controller@700 mapped to virtual irq 17<br>__irq_set_trigger: settin=
g type, irq =3D 17, flags =3D 8<br>ipic_set_irq_type function, with virq =
=3D 17, flow =3D 8<br>
irq: irq 10 on host /immr@e0000000/interrupt-controller@700 mapped to virtu=
al irq 18<br>__irq_set_trigger: setting type, irq =3D 18, flags =3D 8<br>ip=
ic_set_irq_type function, with virq =3D 18, flow =3D 8<br>irq: irq 80 on ho=
st /immr@e0000000/interrupt-controller@700 mapped to virtual irq 80<br>
__irq_set_trigger: setting type, irq =3D 80, flags =3D 8<br>ipic_set_irq_ty=
pe function, with virq =3D 80, flow =3D 8<br>audit: initializing netlink so=
cket (disabled)<br>type=3D2000 audit(0.212:1): initialized<br>JFFS2 version=
 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.<br>
SGI XFS with security attributes, large block/inode numbers, no debug enabl=
ed<br>msgmni has been set to 494<br>alg: No test for cipher_null (cipher_nu=
ll-generic)<br>alg: No test for ecb(cipher_null) (ecb-cipher_null)<br>alg: =
No test for digest_null (digest_null-generic)<br>
alg: No test for compress_null (compress_null-generic)<br>alg: No test for =
stdrng (krng)<br>Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 253)<br>io scheduler noop registered<br>io scheduler deadline registe=
red<br>
io scheduler cfq registered (default)<br>Serial: 8250/16550 driver, 4 ports=
, IRQ sharing enabled<br>serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 17=
) is a 16550A<br>console [ttyS0] enabled, bootconsole disabled<br>serial825=
0.0: ttyS1 at MMIO 0xe0004600 (irq =3D 18) is a 16550A<br>
brd: module loaded<br>of_mpc8xxx_spi_probe function called.<br>irq: irq 16 =
on host /immr@e0000000/interrupt-controller@700 mapped to virtual irq 19<br=
>__irq_set_trigger: setting type, irq =3D 19, flags =3D 8<br>ipic_set_irq_t=
ype function, with virq =3D 19, flow =3D 8<br>
mpc8xxx_spi_probe function called.<br>mpc8xxx_spi e0007000.spi: at 0xd10780=
00 (irq =3D 19), CPU mode<br>irq: irq 32 on host /immr@e0000000/interrupt-c=
ontroller@700 mapped to virtual irq 32<br>__irq_set_trigger: setting type, =
irq =3D 32, flags =3D 8<br>
ipic_set_irq_type function, with virq =3D 32, flow =3D 8<br>irq: irq 33 on =
host /immr@e0000000/interrupt-controller@700 mapped to virtual irq 33<br>__=
irq_set_trigger: setting type, irq =3D 33, flags =3D 8<br>ipic_set_irq_type=
 function, with virq =3D 33, flow =3D 8<br>
irq: irq 34 on host /immr@e0000000/interrupt-controller@700 mapped to virtu=
al irq 34<br>__irq_set_trigger: setting type, irq =3D 34, flags =3D 8<br>ip=
ic_set_irq_type function, with virq =3D 34, flow =3D 8<br>eth0: Gianfar Eth=
ernet Controller Version 1.2, 04:00:00:00:00:0a<br>
eth0: Running with NAPI enabled<br>eth0: RX BD ring size for Q[0]: 256<br>e=
th0: TX BD ring size for Q[0]: 256<br>irq: irq 35 on host /immr@e0000000/in=
terrupt-controller@700 mapped to virtual irq 35<br>__irq_set_trigger: setti=
ng type, irq =3D 35, flags =3D 8<br>
ipic_set_irq_type function, with virq =3D 35, flow =3D 8<br>irq: irq 36 on =
host /immr@e0000000/interrupt-controller@700 mapped to virtual irq 36<br>__=
irq_set_trigger: setting type, irq =3D 36, flags =3D 8<br>ipic_set_irq_type=
 function, with virq =3D 36, flow =3D 8<br>
irq: irq 37 on host /immr@e0000000/interrupt-controller@700 mapped to virtu=
al irq 37<br>__irq_set_trigger: setting type, irq =3D 37, flags =3D 8<br>ip=
ic_set_irq_type function, with virq =3D 37, flow =3D 8<br>eth1: Gianfar Eth=
ernet Controller Version 1.2, 00:00:00:00:00:00<br>
eth1: Running with NAPI enabled<br>eth1: RX BD ring size for Q[0]: 256<br>e=
th1: TX BD ring size for Q[0]: 256<br>ucc_geth: QE UCC Gigabit Ethernet Con=
troller<br>Freescale PowerQUICC MII Bus: probed<br>irq: irq 17 on host /imm=
r@e0000000/interrupt-controller@700 mapped to virtual irq 20<br>
__irq_set_trigger: setting type, irq =3D 20, flags =3D 8<br>ipic_set_irq_ty=
pe function, with virq =3D 20, flow =3D 8<br>Freescale PowerQUICC MII Bus: =
probed<br>mice: PS/2 mouse device common for all mice<br>Skipping unavailab=
le LED gpio -19 (pwr)<br>
Skipping unavailable LED gpio -19 (hdd)<br>TCP cubic registered<br>NET: Reg=
istered protocol family 17<br>registered taskstats version 1<br>drivers/rtc=
/hctosys.c: unable to open rtc device (rtc0)<br>RAMDISK: gzip image found a=
t block 0<br>
VFS: Mounted root (ext2 filesystem) on device 1:0.<br>Freeing unused kernel=
 memory: 188k init<br>PHY: mdio@e0024520:02 - Link is Up - 10/Half<br>=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>Regards,<br>
Ravi<br>

--0016364179a58d0e0b048fbc2689--
