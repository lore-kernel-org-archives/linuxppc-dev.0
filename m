Return-Path: <dceravigupta@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id 6638CB6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 19:05:00 +1000 (EST)
Received: by pzk5 with SMTP id 5so2604494pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 02:04:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C89C0C9.6090007@windriver.com>
References: <AANLkTim5kasMWC6u-mhQyCRiPv1w7BCg7o-mBfy28DfS@mail.gmail.com>
	<4C85CCD6.3020504@windriver.com>
	<AANLkTi=bDOtCxW9VuXrSyAiCLoFCvWoskORpc_1ebDe7@mail.gmail.com>
	<4C8604E1.4080908@windriver.com>
	<AANLkTimLO+xf2Z1zoQfZ8bfB-b--Uu701afr7zg+1r6k@mail.gmail.com>
	<4C88AF1E.8010608@windriver.com>
	<AANLkTik1gWKO6vif+HgtM-j_5EUMJGwKRf+saRgK4TZg@mail.gmail.com>
	<4C89C0C9.6090007@windriver.com>
Date: Mon, 13 Sep 2010 14:34:58 +0530
Message-ID: <AANLkTinPb2KYDtb2fRZ0n9d2=sB1GU1o-LygPFe_BGwp@mail.gmail.com>
Subject: Re: pci_request_regions() failure
From: Ravi Gupta <dceravigupta@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Content-Type: multipart/alternative; boundary=001636457d940336e004902064fb
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636457d940336e004902064fb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tiejun,

Firstly I think we'd better print the BAR0 and BAR1 on the probe function o=
f
> your device driver because you have to make sure if a8000000-a803ffff is
> assigned to BAR0 and 0xa8040000-0xa807ffff for BAR1 as we expect.
>
> u32 value;
> pci_read_config_word(pdev, PCI_BASE_ADDRESS_0, &value); printk...
> pci_read_config_word(pdev, PCI_BASE_ADDRESS_1, &value); printk....
>
>
Both the BAR's values are coming out to be zero.


> And you can print this pci_resource_start(pdev, bar),
> pci_resource_len(pdev,
> bar) from the function, __pci_request_region, on the file
> drivers/pci/pci.c.
> Please check this as well.
>

I have done the changes in the __pci_request_region. But as you suggested
earlier that one should call pci_request_regions() after pci_enable_device(=
)
in the driver code. My driver is failing at the pci_enable_device() only.
Hence __pci_request_region() is not getting called. If, just for RND, I cal=
l
pci_request_regions() before pci_enable_device(), it give me the following
O/P.

__pci_request_region : Base Address =3D 0
__pci_request_region : Length Address =3D 1125903130362788
__pci_request_region : Base Address =3D 0
__pci_request_region : Length Address =3D 1125903130362788


> And currently we have to debug this so on the function,
> __pci_assign_resource,
> from the file drivers/pci/setup-res.c, we can force skipping temporarily
> pci_bus_alloc_resource for bus 0001:01 since that will call
> pci_update_resource
> for bus 0001:01.
>
> static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev=
,
>                                 int resno)
> {
>        struct resource *res =3D dev->resource + resno;
>        resource_size_t size, min, align;
>        int ret;
>
>        size =3D resource_size(res);
>        min =3D (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO :
> PCIBIOS_MIN_MEM;
>        align =3D pci_resource_alignment(dev, res);
> -------
>        if (bus->number =3D=3D 0x01) {
>                ret =3D -ENOMEM
>                return ret;
>        }
> -------
>
> I means we don't want to assign resource as the below line on the log.
> ------
> pci 0001:01:00.0: BAR 8: assigned [mem 0xa8000000-0xa80fffff]
>
> I expect the following output:
> ------
> pci 0001:01:00.0: BAR 8: can't assign mem pref (size 0x100000)
>
>
This I have done successfully.

Dmesg
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using MPC837x RDB/WLAN machine description
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.35 (okapi@okapi) (gcc version 4.2.3 (Sourcery G++ Lite
4.2-171)) #35 Mon Sep 13 13:43:01 IST 2010
Found initrd at 0xcf46d000:0xcf7b15b7
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
free_area_init_node: node 0, pgdat c042d978, node_mem_map c0800000
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
Memory: 249920k/262144k available (4092k kernel code, 12224k reserved, 248k
data, 2207k bss, 192k init)
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
parent c0405660 (PCI IO)
PCI: PHB (bus 0) bridge rsrc 1: 0000000090000000-000000009fffffff [0x200],
parent c0405644 (PCI mem)
PCI: PHB (bus 0) bridge rsrc 2: 0000000080000000-000000008fffffff [0x2200],
parent c0405644 (PCI mem)
PCI: Allocating bus resources for 0001:01...
PCI: PHB (bus 1) bridge rsrc 0: 00000000ff7fe000-00000000ffffdfff [0x100],
parent c0405660 (PCI IO)
PCI: PHB (bus 1) bridge rsrc 1: 00000000a8000000-00000000b7ffffff [0x200],
parent c0405644 (PCI mem)
PCI: Allocating bus resources for 0001:02...
PCI: Allocating bus resources for 0002:03...
PCI: PHB (bus 3) bridge rsrc 0: 00000000feffc000-00000000ff7fbfff [0x100],
parent c0405660 (PCI IO)
PCI: PHB (bus 3) bridge rsrc 1: 00000000c8000000-00000000d7ffffff [0x200],
parent c0405644 (PCI mem)
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
pci 0001:01:00.0: BAR 8: can't assign mem (size 0x100000)
pci 0001:01:00.0: PCI bridge to [bus 02-02]
pci 0001:01:00.0: __pci_setup_bridge: Disabling prefetch window.
pci 0001:01:00.0: __pci_setup_bridge: Prefetch window disabled successfully=
.
pci 0001:01:00.0:   bridge window [io  disabled]
pci 0001:01:00.0:   bridge window [mem disabled]
pci 0001:01:00.0:   bridge window [mem pref disabled]
pci_bus 0000:00: resource 0 [io  0x0000-0xfffff]
pci_bus 0000:00: resource 1 [mem 0x90000000-0x9fffffff]
pci_bus 0000:00: resource 2 [mem 0x80000000-0x8fffffff pref]
pci_bus 0001:01: resource 0 [io  0xff7fe000-0xffffdfff]
pci_bus 0001:01: resource 1 [mem 0xa8000000-0xb7ffffff]
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
type=3D2000 audit(0.220:1): initialized
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
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
Freeing unused kernel memory: 192k init
PHY: mdio@e0024520:02 - Link is Up - 10/Half
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Regards,
Ravi

--001636457d940336e004902064fb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tiejun,<br><br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204=
, 204); padding-left: 1ex;">Firstly I think we&#39;d better print the BAR0 =
and BAR1 on the probe function of<br>

your device driver because you have to make sure if a8000000-a803ffff is<br=
>
assigned to BAR0 and 0xa8040000-0xa807ffff for BAR1 as we expect.<br>
<br>
u32 value;<br>
pci_read_config_word(pdev, PCI_BASE_ADDRESS_0, &amp;value); printk...<br>
pci_read_config_word(pdev, PCI_BASE_ADDRESS_1, &amp;value); printk....<br>
<br></blockquote><div><br>Both the BAR&#39;s values are coming out to be ze=
ro. <br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt=
 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
And you can print this pci_resource_start(pdev, bar), pci_resource_len(pdev=
,<br>
<div class=3D"im">bar) from the function, __pci_request_region, on the file=
 drivers/pci/pci.c.<br>
Please check this as well.<br></div></blockquote><div><br>I have done the c=
hanges in the __pci_request_region. But as you suggested earlier that one s=
hould call pci_request_regions() after pci_enable_device() in the driver co=
de. My driver is failing at the pci_enable_device() only. Hence __pci_reque=
st_region() is not getting called. If, just for RND, I call pci_request_reg=
ions() before pci_enable_device(), it give me the following O/P.<br>
<br>__pci_request_region : Base Address =3D 0<br>__pci_request_region : Len=
gth Address =3D 1125903130362788<br>__pci_request_region : Base Address =3D=
 0<br>__pci_request_region : Length Address =3D 1125903130362788<br>=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bor=
der-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
And currently we have to debug this so on the function, __pci_assign_resour=
ce,<br>
from the file drivers/pci/setup-res.c, we can force skipping temporarily<br=
>
pci_bus_alloc_resource for bus 0001:01 since that will call pci_update_reso=
urce<br>
for bus 0001:01.<br>
<br>
static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,<=
br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int resno)=
<br>
{<br>
 =A0 =A0 =A0 =A0struct resource *res =3D dev-&gt;resource + resno;<br>
 =A0 =A0 =A0 =A0resource_size_t size, min, align;<br>
 =A0 =A0 =A0 =A0int ret;<br>
<br>
 =A0 =A0 =A0 =A0size =3D resource_size(res);<br>
 =A0 =A0 =A0 =A0min =3D (res-&gt;flags &amp; IORESOURCE_IO) ? PCIBIOS_MIN_I=
O : PCIBIOS_MIN_MEM;<br>
 =A0 =A0 =A0 =A0align =3D pci_resource_alignment(dev, res);<br>
-------<br>
 =A0 =A0 =A0 =A0if (bus-&gt;number =3D=3D 0x01) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;<br>
 =A0 =A0 =A0 =A0}<br>
-------<br>
<br>
I means we don&#39;t want to assign resource as the below line on the log.<=
br>
------<br>
<div class=3D"im">pci 0001:01:00.0: BAR 8: assigned [mem 0xa8000000-0xa80ff=
fff]<br>
<br>
</div>I expect the following output:<br>
------<br>
pci 0001:01:00.0: BAR 8: can&#39;t assign mem pref (size 0x100000)<br>
<br></blockquote><div>=A0</div><div>This I have done successfully.<br><br>D=
mesg<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Using MPC837x RDB/WL=
AN machine description<br>Initializing cgroup subsys cpuset<br>
Initializing cgroup subsys cpu<br>Linux version 2.6.35 (okapi@okapi) (gcc v=
ersion 4.2.3 (Sourcery G++ Lite 4.2-171)) #35 Mon Sep 13 13:43:01 IST 2010<=
br>Found initrd at 0xcf46d000:0xcf7b15b7<br>Found legacy serial port 0 for =
/immr@e0000000/serial@4500<br>
=A0 mem=3De0004500, taddr=3De0004500, irq=3D0, clk=3D400000002, speed=3D0<b=
r>Found legacy serial port 1 for /immr@e0000000/serial@4600<br>=A0 mem=3De0=
004600, taddr=3De0004600, irq=3D0, clk=3D400000002, speed=3D0<br>bootconsol=
e [udbg0] enabled<br>
Found FSL PCI host bridge at 0x00000000e0008500. Firmware bus number: 0-&gt=
;0<br>PCI host bridge /pci@e0008500 (primary) ranges:<br>=A0MEM 0x000000009=
0000000..0x000000009fffffff -&gt; 0x0000000090000000 <br>=A0MEM 0x000000008=
0000000..0x000000008fffffff -&gt; 0x0000000080000000 Prefetch<br>
=A0 IO 0x00000000e0300000..0x00000000e03fffff -&gt; 0x0000000000000000<br>N=
o pci config register base in dev tree, using default<br>Found FSL PCI host=
 bridge at 0x00000000e0009000. Firmware bus number: 0-&gt;255<br>PCI host b=
ridge /pcie@e0009000=A0 ranges:<br>
=A0MEM 0x00000000a8000000..0x00000000b7ffffff -&gt; 0x00000000a8000000 <br>=
=A0 IO 0x00000000b8000000..0x00000000b87fffff -&gt; 0x0000000000000000<br>N=
o pci config register base in dev tree, using default<br>Found FSL PCI host=
 bridge at 0x00000000e000a000. Firmware bus number: 0-&gt;255<br>
PCI host bridge /pcie@e000a000=A0 ranges:<br>=A0MEM 0x00000000c8000000..0x0=
0000000d7ffffff -&gt; 0x00000000c8000000 <br>=A0 IO 0x00000000d8000000..0x0=
0000000d87fffff -&gt; 0x0000000000000000<br>Top of RAM: 0x10000000, Total R=
AM: 0x10000000<br>
Memory hole size: 0MB<br>Zone PFN ranges:<br>=A0 DMA=A0=A0=A0=A0=A0 0x00000=
000 -&gt; 0x00010000<br>=A0 Normal=A0=A0 empty<br>=A0 HighMem=A0 empty<br>M=
ovable zone start PFN for each node<br>early_node_map[1] active PFN ranges<=
br>=A0=A0=A0 0: 0x00000000 -&gt; 0x00010000<br>
On node 0 totalpages: 65536<br>free_area_init_node: node 0, pgdat c042d978,=
 node_mem_map c0800000<br>=A0 DMA zone: 512 pages used for memmap<br>=A0 DM=
A zone: 0 pages reserved<br>=A0 DMA zone: 65024 pages, LIFO batch:15<br>Bui=
lt 1 zonelists in Zone order, mobility grouping on.=A0 Total pages: 65024<b=
r>
Kernel command line: root=3D/dev/ram ramdisk_size=3D120000 rw ip=3D10.20.50=
.230:10.20.50.70:10.20.50.50:255.255.0.0:PowerQUICC:eth0:off console=3DttyS=
0,115200 mtdparts=3Dnand:4m(kernel),-(jffs2)<br>PID hash table entries: 102=
4 (order: 0, 4096 bytes)<br>
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>Inode-ca=
che hash table entries: 16384 (order: 4, 65536 bytes)<br>High memory: 0k<br=
>Memory: 249920k/262144k available (4092k kernel code, 12224k reserved, 248=
k data, 2207k bss, 192k init)<br>
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
00000000-00000000000fffff [0x100], parent c0405660 (PCI IO)<br>PCI: PHB (bu=
s 0) bridge rsrc 1: 0000000090000000-000000009fffffff [0x200], parent c0405=
644 (PCI mem)<br>
PCI: PHB (bus 0) bridge rsrc 2: 0000000080000000-000000008fffffff [0x2200],=
 parent c0405644 (PCI mem)<br>PCI: Allocating bus resources for 0001:01...<=
br>PCI: PHB (bus 1) bridge rsrc 0: 00000000ff7fe000-00000000ffffdfff [0x100=
], parent c0405660 (PCI IO)<br>
PCI: PHB (bus 1) bridge rsrc 1: 00000000a8000000-00000000b7ffffff [0x200], =
parent c0405644 (PCI mem)<br>PCI: Allocating bus resources for 0001:02...<b=
r>PCI: Allocating bus resources for 0002:03...<br>PCI: PHB (bus 3) bridge r=
src 0: 00000000feffc000-00000000ff7fbfff [0x100], parent c0405660 (PCI IO)<=
br>
PCI: PHB (bus 3) bridge rsrc 1: 00000000c8000000-00000000d7ffffff [0x200], =
parent c0405644 (PCI mem)<br>Reserving legacy ranges for domain 0000<br>Can=
didate legacy IO: [io=A0 0x0000-0x0fff]<br>hose mem offset: 000000000000000=
0<br>
hose mem res: [mem 0x90000000-0x9fffffff]<br>hose mem res: [mem 0x80000000-=
0x8fffffff pref]<br>Reserving legacy ranges for domain 0001<br>Candidate le=
gacy IO: [io=A0 0xff7fe000-0xff7fefff]<br>hose mem offset: 0000000000000000=
<br>
hose mem res: [mem 0xa8000000-0xb7ffffff]<br>Reserving legacy ranges for do=
main 0002<br>Candidate legacy IO: [io=A0 0xfeffc000-0xfeffcfff]<br>hose mem=
 offset: 0000000000000000<br>hose mem res: [mem 0xc8000000-0xd7ffffff]<br>
PCI: Assigning unassigned resources...<br>pci 0001:01:00.0: BAR 8: can&#39;=
t assign mem (size 0x100000)<br>pci 0001:01:00.0: PCI bridge to [bus 02-02]=
<br>pci 0001:01:00.0: __pci_setup_bridge: Disabling prefetch window.<br>
pci 0001:01:00.0: __pci_setup_bridge: Prefetch window disabled successfully=
.<br>pci 0001:01:00.0:=A0=A0 bridge window [io=A0 disabled]<br>pci 0001:01:=
00.0:=A0=A0 bridge window [mem disabled]<br>pci 0001:01:00.0:=A0=A0 bridge =
window [mem pref disabled]<br>
pci_bus 0000:00: resource 0 [io=A0 0x0000-0xfffff]<br>pci_bus 0000:00: reso=
urce 1 [mem 0x90000000-0x9fffffff]<br>pci_bus 0000:00: resource 2 [mem 0x80=
000000-0x8fffffff pref]<br>pci_bus 0001:01: resource 0 [io=A0 0xff7fe000-0x=
ffffdfff]<br>
pci_bus 0001:01: resource 1 [mem 0xa8000000-0xb7ffffff]<br>pci_bus 0002:03:=
 resource 0 [io=A0 0xfeffc000-0xff7fbfff]<br>pci_bus 0002:03: resource 1 [m=
em 0xc8000000-0xd7ffffff]<br>Registering qe_ic with sysfs...<br>Registering=
 ipic with sysfs...<br>
bio: create slab &lt;bio-0&gt; at 0<br>vgaarb: loaded<br>SCSI subsystem ini=
tialized<br>Switching to clocksource timebase<br>NET: Registered protocol f=
amily 2<br>IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<b=
r>
TCP established hash table entries: 8192 (order: 4, 65536 bytes)<br>TCP bin=
d hash table entries: 8192 (order: 3, 32768 bytes)<br>TCP: Hash tables conf=
igured (established 8192 bind 8192)<br>TCP reno registered<br>UDP hash tabl=
e entries: 256 (order: 0, 4096 bytes)<br>
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)<br>NET: Registered =
protocol family 1<br>pci 0000:00:00.0: calling quirk_cardbus_legacy+0x0/0x4=
4<br>pci 0000:00:00.0: calling quirk_usb_early_handoff+0x0/0x740<br>pci 000=
1:01:00.0: calling quirk_cardbus_legacy+0x0/0x44<br>
pci 0001:01:00.0: calling quirk_usb_early_handoff+0x0/0x740<br>pci 0001:02:=
00.0: calling quirk_cardbus_legacy+0x0/0x44<br>pci 0001:02:00.0: calling qu=
irk_usb_early_handoff+0x0/0x740<br>PCI: CLS 32 bytes, default 32<br>Trying =
to unpack rootfs image as initramfs...<br>
rootfs image is not initramfs (no cpio magic); looks like an initrd<br>Free=
ing initrd memory: 3345k freed<br>irq: irq 9 on host /immr@e0000000/interru=
pt-controller@700 mapped to virtual irq 17<br>__irq_set_trigger: setting ty=
pe, irq =3D 17, flags =3D 8<br>
ipic_set_irq_type function, with virq =3D 17, flow =3D 8<br>irq: irq 10 on =
host /immr@e0000000/interrupt-controller@700 mapped to virtual irq 18<br>__=
irq_set_trigger: setting type, irq =3D 18, flags =3D 8<br>ipic_set_irq_type=
 function, with virq =3D 18, flow =3D 8<br>
irq: irq 80 on host /immr@e0000000/interrupt-controller@700 mapped to virtu=
al irq 80<br>__irq_set_trigger: setting type, irq =3D 80, flags =3D 8<br>ip=
ic_set_irq_type function, with virq =3D 80, flow =3D 8<br>audit: initializi=
ng netlink socket (disabled)<br>
type=3D2000 audit(0.220:1): initialized<br>JFFS2 version 2.2. (NAND) =C2=A9=
 2001-2006 Red Hat, Inc.<br>SGI XFS with security attributes, large block/i=
node numbers, no debug enabled<br>msgmni has been set to 494<br>alg: No tes=
t for cipher_null (cipher_null-generic)<br>
alg: No test for ecb(cipher_null) (ecb-cipher_null)<br>alg: No test for dig=
est_null (digest_null-generic)<br>alg: No test for compress_null (compress_=
null-generic)<br>alg: No test for stdrng (krng)<br>Block layer SCSI generic=
 (bsg) driver version 0.4 loaded (major 253)<br>
io scheduler noop registered<br>io scheduler deadline registered<br>io sche=
duler cfq registered (default)<br>Serial: 8250/16550 driver, 4 ports, IRQ s=
haring enabled<br>serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 17) is a =
16550A<br>
console [ttyS0] enabled, bootconsole disabled<br>serial8250.0: ttyS1 at MMI=
O 0xe0004600 (irq =3D 18) is a 16550A<br>brd: module loaded<br>of_mpc8xxx_s=
pi_probe function called.<br>irq: irq 16 on host /immr@e0000000/interrupt-c=
ontroller@700 mapped to virtual irq 19<br>
__irq_set_trigger: setting type, irq =3D 19, flags =3D 8<br>ipic_set_irq_ty=
pe function, with virq =3D 19, flow =3D 8<br>mpc8xxx_spi_probe function cal=
led.<br>mpc8xxx_spi e0007000.spi: at 0xd1078000 (irq =3D 19), CPU mode<br>i=
rq: irq 32 on host /immr@e0000000/interrupt-controller@700 mapped to virtua=
l irq 32<br>
__irq_set_trigger: setting type, irq =3D 32, flags =3D 8<br>ipic_set_irq_ty=
pe function, with virq =3D 32, flow =3D 8<br>irq: irq 33 on host /immr@e000=
0000/interrupt-controller@700 mapped to virtual irq 33<br>__irq_set_trigger=
: setting type, irq =3D 33, flags =3D 8<br>
ipic_set_irq_type function, with virq =3D 33, flow =3D 8<br>irq: irq 34 on =
host /immr@e0000000/interrupt-controller@700 mapped to virtual irq 34<br>__=
irq_set_trigger: setting type, irq =3D 34, flags =3D 8<br>ipic_set_irq_type=
 function, with virq =3D 34, flow =3D 8<br>
eth0: Gianfar Ethernet Controller Version 1.2, 04:00:00:00:00:0a<br>eth0: R=
unning with NAPI enabled<br>eth0: RX BD ring size for Q[0]: 256<br>eth0: TX=
 BD ring size for Q[0]: 256<br>irq: irq 35 on host /immr@e0000000/interrupt=
-controller@700 mapped to virtual irq 35<br>
__irq_set_trigger: setting type, irq =3D 35, flags =3D 8<br>ipic_set_irq_ty=
pe function, with virq =3D 35, flow =3D 8<br>irq: irq 36 on host /immr@e000=
0000/interrupt-controller@700 mapped to virtual irq 36<br>__irq_set_trigger=
: setting type, irq =3D 36, flags =3D 8<br>
ipic_set_irq_type function, with virq =3D 36, flow =3D 8<br>irq: irq 37 on =
host /immr@e0000000/interrupt-controller@700 mapped to virtual irq 37<br>__=
irq_set_trigger: setting type, irq =3D 37, flags =3D 8<br>ipic_set_irq_type=
 function, with virq =3D 37, flow =3D 8<br>
eth1: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00<br>eth1: R=
unning with NAPI enabled<br>eth1: RX BD ring size for Q[0]: 256<br>eth1: TX=
 BD ring size for Q[0]: 256<br>ucc_geth: QE UCC Gigabit Ethernet Controller=
<br>
Freescale PowerQUICC MII Bus: probed<br>irq: irq 17 on host /immr@e0000000/=
interrupt-controller@700 mapped to virtual irq 20<br>__irq_set_trigger: set=
ting type, irq =3D 20, flags =3D 8<br>ipic_set_irq_type function, with virq=
 =3D 20, flow =3D 8<br>
Freescale PowerQUICC MII Bus: probed<br>mice: PS/2 mouse device common for =
all mice<br>Skipping unavailable LED gpio -19 (pwr)<br>Skipping unavailable=
 LED gpio -19 (hdd)<br>TCP cubic registered<br>NET: Registered protocol fam=
ily 17<br>
registered taskstats version 1<br>drivers/rtc/hctosys.c: unable to open rtc=
 device (rtc0)<br>RAMDISK: gzip image found at block 0<br>VFS: Mounted root=
 (ext2 filesystem) on device 1:0.<br>Freeing unused kernel memory: 192k ini=
t<br>
PHY: mdio@e0024520:02 - Link is Up - 10/Half<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br></div></div><br>Regards,<br>Ravi<br>

--001636457d940336e004902064fb--
