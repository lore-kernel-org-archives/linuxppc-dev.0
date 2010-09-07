Return-Path: <dceravigupta@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id 3589BB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Sep 2010 17:20:39 +1000 (EST)
Received: by pzk5 with SMTP id 5so2057166pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 07 Sep 2010 00:20:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C85CCD6.3020504@windriver.com>
References: <AANLkTim5kasMWC6u-mhQyCRiPv1w7BCg7o-mBfy28DfS@mail.gmail.com>
	<4C85CCD6.3020504@windriver.com>
Date: Tue, 7 Sep 2010 12:50:37 +0530
Message-ID: <AANLkTi=bDOtCxW9VuXrSyAiCLoFCvWoskORpc_1ebDe7@mail.gmail.com>
Subject: Re: pci_request_regions() failure
From: Ravi Gupta <dceravigupta@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Content-Type: multipart/mixed; boundary=001636458f76cc1d47048fa63bd3
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636458f76cc1d47048fa63bd3
Content-Type: multipart/alternative; boundary=001636458f76cc1d37048fa63bd1

--001636458f76cc1d37048fa63bd1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tiejun,

Thanks for the reply. I am sending you the updated dmesg O/P(after enabling
CONFIG_PCI_DEBUG) as attachment as well as at the end of the mail.

As far as driver is concern, I am trying the pci_skel driver available as
example with LDD book with slight modifications.

Driver Code:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>

/* PCI IDs */
static struct pci_device_id ids[] =3D {
  { PCI_DEVICE(0x1204, 0xe250) },
  { 0, }
};
MODULE_DEVICE_TABLE(pci, ids);

static unsigned char skel_get_revision(struct pci_dev *dev)
{
  u8 revision;

  pci_read_config_byte(dev, PCI_REVISION_ID, &revision);
  return revision;
}

static u16 skel_get_vendor_id(struct pci_dev *dev)
{
  u16 vendor_id;

  pci_read_config_word(dev, PCI_VENDOR_ID, &vendor_id);
  return vendor_id;
}

static u16 skel_get_device_id(struct pci_dev *dev)
{
  u16 device_id;

  pci_read_config_word(dev, PCI_DEVICE_ID, &device_id);
  return device_id;
}

static int probe(struct pci_dev *dev, const struct pci_device_id *id)
{
  /* Do probing type stuff here.
   * Like calling request_region();
   */
  int err, i;
  printk(KERN_ALERT "PCI driver: Probe function\n");

  /*
   * Enable the bus-master bit values.
   * Some PCI BIOSes fail to set the master-enable bit.
   * Some demos support being an initiator, so need bus master ability.
   */
  err =3D pci_request_regions(dev, "pci_skell");
  if (err) {
    printk(KERN_ERR "request region failed :%d\n", err);
    return err;
  }

  pci_set_master(dev);

  if ((err =3D pci_enable_device(dev)) !=3D 0) {
    printk(KERN_ERR "Unable to Enable PCI device:%d\n", err);
    return err;
  }

  printk(KERN_ALERT "PCI driver Vendor ID =3D %x\n", skel_get_vendor_id(dev=
));
  printk(KERN_ALERT "PCI driver Device ID =3D %x\n", skel_get_device_id(dev=
));
  printk(KERN_ALERT "PCI driver Revision =3D %d\n", skel_get_revision(dev))=
;
  return 0;
}

static void remove(struct pci_dev *dev)
{
  /* clean up any allocated resources and stuff here.
   * like call release_region();
   */
}

static struct pci_driver pci_driver =3D {
  .name =3D "pci_skel",
  .id_table =3D ids,
  .probe =3D probe,
  .remove =3D remove,
};

static int __init pci_skel_init(void)
{
  printk(KERN_ALERT "PCI driver: Init function\n");
  return pci_register_driver(&pci_driver);
}

static void __exit pci_skel_exit(void)
{
  printk(KERN_ALERT "PCI driver: Exit function\n");
  pci_unregister_driver(&pci_driver);
}

MODULE_LICENSE("GPL");

module_init(pci_skel_init);
module_exit(pci_skel_exit);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The above code fails at the pci_request_regions(dev, "pci_skell"); call,
with -EBUSY(-16) i.e resource busy error. If I don't request for resources
and directly enable the pci device by calling pci_device_enable(), it gives
the error message

PCI driver: Init function
PCI driver: Probe function
pci_skel 0001:02:00.0: device not available (can't reserve [mem
0x00000000-0x0003ffff])
Unable to Enable PCI device:-22
pci_skel: probe of 0001:02:00.0 failed with error -22



> Especially I want to know how/where you get
> these two range, a8000000-a803ffff and a8040000-a807ffff. You wired them
firstly
> on the driver or allocated by the kernel?

Actually as I said before, I tried my device on i386 machine and there I go=
t
two ranges fe900000-fe93ffff and fe940000-fe97ffff, so from there I am
guessing that on PowerPC also, it should allocate two ranges
a8000000-a803ffff and a8040000-a807ffff resp.



lspci output
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0000:00:00.0 Power PC: Freescale Semiconductor Inc Unknown device 00c6 (rev
21)
0001:01:00.0 PCI bridge: Freescale Semiconductor Inc Unknown device 00c6
(rev 21)
0001:02:00.0 Non-VGA unclassified device: Lattice Semiconductor Corporation
Unknown device e250   ----------> My device
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Dmesg with CONFIG_PCI_DEBUG enable.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using MPC837x RDB/WLAN machine description
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.35 (okapi@okapi) (gcc version 4.2.3 (Sourcery G++ Lite
4.2-171)) #13 Tue Sep 7 11:37:47 IST 2010
Found initrd at 0xcf46d000:0xcf7b15b7
Found legacy serial port 0 for /immr@e0000000/serial@4500
  mem=3De0004500, taddr=3De0004500, irq=3D0, clk=3D399999996, speed=3D0
Found legacy serial port 1 for /immr@e0000000/serial@4600
  mem=3De0004600, taddr=3De0004600, irq=3D0, clk=3D399999996, speed=3D0
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
free_area_init_node: node 0, pgdat c04285e8, node_mem_map c0482000
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
Memory: 251884k/262144k available (4072k kernel code, 10260k reserved, 244k
data, 267k bss, 192k init)
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
time_init: decrementer frequency =3D 99.999999 MHz
time_init: processor frequency   =3D 799.999992 MHz
clocksource: timebase mult[2800000] shift[22] registered
clockevent: decrementer mult[19999995] shift[32] cpu[0]
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
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: found [1957:00c6] class 000b20 header type 00
pci 0000:00:00.0: reg 10: [mem 0x00000000-0x000fffff]
pci 0000:00:00.0: reg 18: [mem 0x00000000-0x0fffffff 64bit pref]
pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58
pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x238
pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x48
pci 0000:00:00.0: calling quirk_resource_alignment+0x0/0x1c0
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci_bus 0000:00: bus scan returning with max=3D00
pci_bus 0001:01: scanning bus
pci 0001:01:00.0: found [1957:00c6] class 000b20 header type 01
pci 0001:01:00.0: ignoring class b20 (doesn't match header type 01)
pci 0001:01:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58
pci 0001:01:00.0: calling pcibios_fixup_resources+0x0/0x238
pci 0001:01:00.0: calling quirk_fsl_pcie_header+0x0/0x48
pci 0001:01:00.0: calling quirk_resource_alignment+0x0/0x1c0
pci 0001:01:00.0: supports D1 D2
pci 0001:01:00.0: PME# supported from D0 D1 D2 D3hot
pci 0001:01:00.0: PME# disabled
pci_bus 0001:01: fixups for bus
pci 0001:01:00.0: scanning [bus 01-ff] behind bridge, pass 0
pci 0001:01:00.0: bus configuration invalid, reconfiguring
pci 0001:01:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0001:02: scanning bus
pci 0001:02:00.0: found [1204:e250] class 000000 header type 00
pci 0001:02:00.0: reg 10: [mem 0xfffc0000-0xffffffff]
pci 0001:02:00.0: reg 14: [mem 0xfffc0000-0xffffffff]
pci 0001:02:00.0: calling pcibios_fixup_resources+0x0/0x238
pci 0001:02:00.0: calling quirk_resource_alignment+0x0/0x1c0
pci_bus 0001:02: fixups for bus
pci 0001:01:00.0: PCI bridge to [bus 02-ff]
pci 0001:01:00.0:   bridge window [io  0x0000-0x0000] (disabled)
pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
(disabled)
irq: irq 1 on host /immr@e0000000/interrupt-controller@700 mapped to virtua=
l
irq 16
__irq_set_trigger: setting type, irq =3D 16, flags =3D 8
ipic_set_irq_type function, with virq =3D 16, flow =3D 8
pci_bus 0001:02: bus scan returning with max=3D02
pci_bus 0001:01: bus scan returning with max=3D02
pci_bus 0002:03: scanning bus
pci_bus 0002:03: fixups for bus
pci_bus 0002:03: bus scan returning with max=3D03
PCI->OF bus map:
0 -> 0
1 -> 0
3 -> 0
PCI: Cannot allocate resource region 0 of device 0001:02:00.0, will remap
PCI: Cannot allocate resource region 1 of device 0001:02:00.0, will remap
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
msgmni has been set to 498
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

Regards
Ravi Gupta

--001636458f76cc1d37048fa63bd1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tiejun,<br><br>Thanks for the reply. I am sending you the updated dmesg =
O/P(after enabling CONFIG_PCI_DEBUG) as attachment as well as at the end of=
 the mail. <br><br>As far as driver is concern, I am trying the pci_skel dr=
iver available as example with LDD book with slight modifications. <br>
=A0<br>Driver Code:<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>#incl=
ude &lt;linux/kernel.h&gt;<br>#include &lt;linux/module.h&gt;<br>#include &=
lt;linux/pci.h&gt;<br><br>/* PCI IDs */<br>static struct pci_device_id ids[=
] =3D { <br>
=A0 { PCI_DEVICE(0x1204, 0xe250) },<br>=A0 { 0, }<br>};<br>MODULE_DEVICE_TA=
BLE(pci, ids);<br><br>static unsigned char skel_get_revision(struct pci_dev=
 *dev)<br>{<br>=A0 u8 revision;<br><br>=A0 pci_read_config_byte(dev, PCI_RE=
VISION_ID, &amp;revision);<br>
=A0 return revision;<br>}<br><br>static u16 skel_get_vendor_id(struct pci_d=
ev *dev)<br>{<br>=A0 u16 vendor_id;<br><br>=A0 pci_read_config_word(dev, PC=
I_VENDOR_ID, &amp;vendor_id);<br>=A0 return vendor_id;<br>}<br><br>static u=
16 skel_get_device_id(struct pci_dev *dev)<br>
{<br>=A0 u16 device_id;<br><br>=A0 pci_read_config_word(dev, PCI_DEVICE_ID,=
 &amp;device_id);<br>=A0 return device_id;<br>}<br><br>static int probe(str=
uct pci_dev *dev, const struct pci_device_id *id)<br>{<br>=A0 /* Do probing=
 type stuff here.=A0 <br>
=A0=A0 * Like calling request_region();<br>=A0=A0 */<br>=A0 int err, i;<br>=
=A0 printk(KERN_ALERT &quot;PCI driver: Probe function\n&quot;);<br><br>=A0=
 /*<br>=A0=A0 * Enable the bus-master bit values.<br>=A0=A0 * Some PCI BIOS=
es fail to set the master-enable bit.<br>
=A0=A0 * Some demos support being an initiator, so need bus master ability.=
<br>=A0=A0 */<br>=A0 err =3D pci_request_regions(dev, &quot;pci_skell&quot;=
);<br>=A0 if (err) {<br>=A0=A0=A0 printk(KERN_ERR &quot;request region fail=
ed :%d\n&quot;, err);<br>
=A0=A0=A0 return err;<br>=A0 }<br><br>=A0 pci_set_master(dev);<br><br>=A0 i=
f ((err =3D pci_enable_device(dev)) !=3D 0) {<br>=A0=A0=A0 printk(KERN_ERR =
&quot;Unable to Enable PCI device:%d\n&quot;, err);<br>=A0=A0=A0 return err=
;<br>=A0 }<br><br>=A0 printk(KERN_ALERT &quot;PCI driver Vendor ID =3D %x\n=
&quot;, skel_get_vendor_id(dev));<br>
=A0 printk(KERN_ALERT &quot;PCI driver Device ID =3D %x\n&quot;, skel_get_d=
evice_id(dev));<br>=A0 printk(KERN_ALERT &quot;PCI driver Revision =3D %d\n=
&quot;, skel_get_revision(dev));<br>=A0 return 0;<br>}<br><br>static void r=
emove(struct pci_dev *dev)<br>
{<br>=A0 /* clean up any allocated resources and stuff here.<br>=A0=A0 * li=
ke call release_region();<br>=A0=A0 */<br>}<br><br>static struct pci_driver=
 pci_driver =3D {<br>=A0 .name =3D &quot;pci_skel&quot;,<br>=A0 .id_table =
=3D ids,<br>=A0 .probe =3D probe,<br>
=A0 .remove =3D remove,<br>};<br><br>static int __init pci_skel_init(void)<=
br>{<br>=A0 printk(KERN_ALERT &quot;PCI driver: Init function\n&quot;);<br>=
=A0 return pci_register_driver(&amp;pci_driver);<br>}<br><br>static void __=
exit pci_skel_exit(void)<br>
{<br>=A0 printk(KERN_ALERT &quot;PCI driver: Exit function\n&quot;);<br>=A0=
 pci_unregister_driver(&amp;pci_driver);<br>}<br><br>MODULE_LICENSE(&quot;G=
PL&quot;);<br><br>module_init(pci_skel_init);<br>module_exit(pci_skel_exit)=
;<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>The above code fails at t=
he pci_request_regions(dev, &quot;pci_skell&quot;); call, with -EBUSY(-16) =
i.e resource busy error. If I don&#39;t request for resources and directly =
enable the pci device by calling pci_device_enable(), it gives the error me=
ssage<br>
<br>PCI driver: Init function<br>
PCI driver: Probe function<br>
pci_skel 0001:02:00.0: device not available (can&#39;t reserve [mem 0x00000=
000-0x0003ffff])<br>
Unable to Enable PCI device:-22<br>
pci_skel: probe of 0001:02:00.0 failed with error -22
		=09
		<br><br><br><br>&gt; Especially I want to know how/where you get<br>
&gt; these two range, a8000000-a803ffff and a8040000-a807ffff. You wired th=
em firstly<br>
&gt; on the driver or allocated by the kernel?<br><br>Actually as I said be=
fore, I tried my device on i386 machine and there I got two ranges fe900000=
-fe93ffff and fe940000-fe97ffff, so from there I am guessing that on PowerP=
C also, it should allocate two ranges a8000000-a803ffff and a8040000-a807ff=
ff resp.<br>
<br><br><br>lspci output<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>0000:00:00.0 Power PC: Freesc=
ale Semiconductor Inc Unknown device 00c6 (rev 21)<br>
0001:01:00.0 PCI bridge: Freescale Semiconductor Inc Unknown device 00c6 (r=
ev 21)<br>
0001:02:00.0 Non-VGA unclassified device: Lattice Semiconductor Corporation=
 Unknown device e250=A0=A0
		=09
		----------&gt; My device<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>
Dmesg with CONFIG_PCI_DEBUG enable.<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
Using MPC837x RDB/WLAN machine description<br>Initializing cgroup subsys cp=
uset<br>Initializing cgroup subsys cpu<br>Linux version 2.6.35 (okapi@okapi=
) (gcc version 4.2.3 (Sourcery G++ Lite 4.2-171)) #13 Tue Sep 7 11:37:47 IS=
T 2010<br>
Found initrd at 0xcf46d000:0xcf7b15b7<br>Found legacy serial port 0 for /im=
mr@e0000000/serial@4500<br>=A0 mem=3De0004500, taddr=3De0004500, irq=3D0, c=
lk=3D399999996, speed=3D0<br>Found legacy serial port 1 for /immr@e0000000/=
serial@4600<br>
=A0 mem=3De0004600, taddr=3De0004600, irq=3D0, clk=3D399999996, speed=3D0<b=
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
free_area_init_node: node 0, pgdat c04285e8, node_mem_map c0482000<br>=A0 D=
MA zone: 512 pages used for memmap<br>=A0 DMA zone: 0 pages reserved<br>=A0=
 DMA zone: 65024 pages, LIFO batch:15<br>Built 1 zonelists in Zone order, m=
obility grouping on.=A0 Total pages: 65024<br>
Kernel command line: root=3D/dev/ram ramdisk_size=3D120000 rw ip=3D10.20.50=
.230:10.20.50.70:10.20.50.50:255.255.0.0:PowerQUICC:eth0:off console=3DttyS=
0,115200 mtdparts=3Dnand:4m(kernel),-(jffs2)<br>PID hash table entries: 102=
4 (order: 0, 4096 bytes)<br>
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>Inode-ca=
che hash table entries: 16384 (order: 4, 65536 bytes)<br>High memory: 0k<br=
>Memory: 251884k/262144k available (4072k kernel code, 10260k reserved, 244=
k data, 267k bss, 192k init)<br>
Kernel virtual memory layout:<br>=A0 * 0xfffcf000..0xfffff000=A0 : fixmap<b=
r>=A0 * 0xff800000..0xffc00000=A0 : highmem PTEs<br>=A0 * 0xfe6f7000..0xff8=
00000=A0 : early ioremap<br>=A0 * 0xd1000000..0xfe6f7000=A0 : vmalloc &amp;=
 ioremap<br>
Hierarchical RCU implementation.<br>=A0=A0=A0 RCU-based detection of stalle=
d CPUs is disabled.<br>=A0=A0=A0 Verbose stalled-CPUs detection is disabled=
.<br>NR_IRQS:512<br>IPIC (128 IRQ sources) at d1000700<br>time_init: decrem=
enter frequency =3D 99.999999 MHz<br>
time_init: processor frequency=A0=A0 =3D 799.999992 MHz<br>clocksource: tim=
ebase mult[2800000] shift[22] registered<br>clockevent: decrementer mult[19=
999995] shift[32] cpu[0]<br>Console: colour dummy device 80x25<br>pid_max: =
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
I hardware<br>pci_bus 0000:00: scanning bus<br>pci 0000:00:00.0: found [195=
7:00c6] class 000b20 header type 00<br>pci 0000:00:00.0: reg 10: [mem 0x000=
00000-0x000fffff]<br>
pci 0000:00:00.0: reg 18: [mem 0x00000000-0x0fffffff 64bit pref]<br>pci 000=
0:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58<br>pci 0000:00:00.=
0: calling pcibios_fixup_resources+0x0/0x238<br>pci 0000:00:00.0: calling q=
uirk_fsl_pcie_header+0x0/0x48<br>
pci 0000:00:00.0: calling quirk_resource_alignment+0x0/0x1c0<br>pci 0000:00=
:00.0: supports D1 D2<br>pci 0000:00:00.0: PME# supported from D0 D1 D2 D3h=
ot<br>pci 0000:00:00.0: PME# disabled<br>pci_bus 0000:00: fixups for bus<br=
>
pci_bus 0000:00: bus scan returning with max=3D00<br>pci_bus 0001:01: scann=
ing bus<br>pci 0001:01:00.0: found [1957:00c6] class 000b20 header type 01<=
br>pci 0001:01:00.0: ignoring class b20 (doesn&#39;t match header type 01)<=
br>
pci 0001:01:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58<br>pci 0001=
:01:00.0: calling pcibios_fixup_resources+0x0/0x238<br>pci 0001:01:00.0: ca=
lling quirk_fsl_pcie_header+0x0/0x48<br>pci 0001:01:00.0: calling quirk_res=
ource_alignment+0x0/0x1c0<br>
pci 0001:01:00.0: supports D1 D2<br>pci 0001:01:00.0: PME# supported from D=
0 D1 D2 D3hot<br>pci 0001:01:00.0: PME# disabled<br>pci_bus 0001:01: fixups=
 for bus<br>pci 0001:01:00.0: scanning [bus 01-ff] behind bridge, pass 0<br=
>
pci 0001:01:00.0: bus configuration invalid, reconfiguring<br>pci 0001:01:0=
0.0: scanning [bus 00-00] behind bridge, pass 1<br>pci_bus 0001:02: scannin=
g bus<br>pci 0001:02:00.0: found [1204:e250] class 000000 header type 00<br=
>
pci 0001:02:00.0: reg 10: [mem 0xfffc0000-0xffffffff]<br>pci 0001:02:00.0: =
reg 14: [mem 0xfffc0000-0xffffffff]<br>pci 0001:02:00.0: calling pcibios_fi=
xup_resources+0x0/0x238<br>pci 0001:02:00.0: calling quirk_resource_alignme=
nt+0x0/0x1c0<br>
pci_bus 0001:02: fixups for bus<br>pci 0001:01:00.0: PCI bridge to [bus 02-=
ff]<br>pci 0001:01:00.0:=A0=A0 bridge window [io=A0 0x0000-0x0000] (disable=
d)<br>pci 0001:01:00.0:=A0=A0 bridge window [mem 0x00000000-0x000fffff] (di=
sabled)<br>
pci 0001:01:00.0:=A0=A0 bridge window [mem 0x00000000-0x000fffff pref] (dis=
abled)<br>irq: irq 1 on host /immr@e0000000/interrupt-controller@700 mapped=
 to virtual irq 16<br>__irq_set_trigger: setting type, irq =3D 16, flags =
=3D 8<br>
ipic_set_irq_type function, with virq =3D 16, flow =3D 8<br>pci_bus 0001:02=
: bus scan returning with max=3D02<br>pci_bus 0001:01: bus scan returning w=
ith max=3D02<br>pci_bus 0002:03: scanning bus<br>pci_bus 0002:03: fixups fo=
r bus<br>
pci_bus 0002:03: bus scan returning with max=3D03<br>PCI-&gt;OF bus map:<br=
>0 -&gt; 0<br>1 -&gt; 0<br>3 -&gt; 0<br>PCI: Cannot allocate resource regio=
n 0 of device 0001:02:00.0, will remap<br>PCI: Cannot allocate resource reg=
ion 1 of device 0001:02:00.0, will remap<br>
pci 0001:01:00.0: BAR 8: assigned [mem 0xa8000000-0xa80fffff]<br>pci 0001:0=
1:00.0: PCI bridge to [bus 02-02]<br>pci 0001:01:00.0:=A0=A0 bridge window =
[io=A0 disabled]<br>pci 0001:01:00.0:=A0=A0 bridge window [mem 0xa8000000-0=
xa80fffff]<br>
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
ed<br>msgmni has been set to 498<br>alg: No test for cipher_null (cipher_nu=
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
 memory: 192k init<br>PHY: mdio@e0024520:02 - Link is Up - 10/Half<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>Regards<br>Ravi Gupta<br>

--001636458f76cc1d37048fa63bd1--

--001636458f76cc1d47048fa63bd3
Content-Type: application/octet-stream; name=dmesg_log
Content-Disposition: attachment; filename=dmesg_log
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gdsen03l0

VXNpbmcgTVBDODM3eCBSREIvV0xBTiBtYWNoaW5lIGRlc2NyaXB0aW9uCkluaXRpYWxpemluZyBj
Z3JvdXAgc3Vic3lzIGNwdXNldApJbml0aWFsaXppbmcgY2dyb3VwIHN1YnN5cyBjcHUKTGludXgg
dmVyc2lvbiAyLjYuMzUgKG9rYXBpQG9rYXBpKSAoZ2NjIHZlcnNpb24gNC4yLjMgKFNvdXJjZXJ5
IEcrKyBMaXRlIDQuMi0xNzEpKSAjMTMgVHVlIFNlcCA3IDExOjM3OjQ3IElTVCAyMDEwCkZvdW5k
IGluaXRyZCBhdCAweGNmNDZkMDAwOjB4Y2Y3YjE1YjcKRm91bmQgbGVnYWN5IHNlcmlhbCBwb3J0
IDAgZm9yIC9pbW1yQGUwMDAwMDAwL3NlcmlhbEA0NTAwCiAgbWVtPWUwMDA0NTAwLCB0YWRkcj1l
MDAwNDUwMCwgaXJxPTAsIGNsaz0zOTk5OTk5OTYsIHNwZWVkPTAKRm91bmQgbGVnYWN5IHNlcmlh
bCBwb3J0IDEgZm9yIC9pbW1yQGUwMDAwMDAwL3NlcmlhbEA0NjAwCiAgbWVtPWUwMDA0NjAwLCB0
YWRkcj1lMDAwNDYwMCwgaXJxPTAsIGNsaz0zOTk5OTk5OTYsIHNwZWVkPTAKYm9vdGNvbnNvbGUg
W3VkYmcwXSBlbmFibGVkCkZvdW5kIEZTTCBQQ0kgaG9zdCBicmlkZ2UgYXQgMHgwMDAwMDAwMGUw
MDA4NTAwLiBGaXJtd2FyZSBidXMgbnVtYmVyOiAwLT4wClBDSSBob3N0IGJyaWRnZSAvcGNpQGUw
MDA4NTAwIChwcmltYXJ5KSByYW5nZXM6CiBNRU0gMHgwMDAwMDAwMDkwMDAwMDAwLi4weDAwMDAw
MDAwOWZmZmZmZmYgLT4gMHgwMDAwMDAwMDkwMDAwMDAwIAogTUVNIDB4MDAwMDAwMDA4MDAwMDAw
MC4uMHgwMDAwMDAwMDhmZmZmZmZmIC0+IDB4MDAwMDAwMDA4MDAwMDAwMCBQcmVmZXRjaAogIElP
IDB4MDAwMDAwMDBlMDMwMDAwMC4uMHgwMDAwMDAwMGUwM2ZmZmZmIC0+IDB4MDAwMDAwMDAwMDAw
MDAwMApObyBwY2kgY29uZmlnIHJlZ2lzdGVyIGJhc2UgaW4gZGV2IHRyZWUsIHVzaW5nIGRlZmF1
bHQKRm91bmQgRlNMIFBDSSBob3N0IGJyaWRnZSBhdCAweDAwMDAwMDAwZTAwMDkwMDAuIEZpcm13
YXJlIGJ1cyBudW1iZXI6IDAtPjI1NQpQQ0kgaG9zdCBicmlkZ2UgL3BjaWVAZTAwMDkwMDAgIHJh
bmdlczoKIE1FTSAweDAwMDAwMDAwYTgwMDAwMDAuLjB4MDAwMDAwMDBiN2ZmZmZmZiAtPiAweDAw
MDAwMDAwYTgwMDAwMDAgCiAgSU8gMHgwMDAwMDAwMGI4MDAwMDAwLi4weDAwMDAwMDAwYjg3ZmZm
ZmYgLT4gMHgwMDAwMDAwMDAwMDAwMDAwCk5vIHBjaSBjb25maWcgcmVnaXN0ZXIgYmFzZSBpbiBk
ZXYgdHJlZSwgdXNpbmcgZGVmYXVsdApGb3VuZCBGU0wgUENJIGhvc3QgYnJpZGdlIGF0IDB4MDAw
MDAwMDBlMDAwYTAwMC4gRmlybXdhcmUgYnVzIG51bWJlcjogMC0+MjU1ClBDSSBob3N0IGJyaWRn
ZSAvcGNpZUBlMDAwYTAwMCAgcmFuZ2VzOgogTUVNIDB4MDAwMDAwMDBjODAwMDAwMC4uMHgwMDAw
MDAwMGQ3ZmZmZmZmIC0+IDB4MDAwMDAwMDBjODAwMDAwMCAKICBJTyAweDAwMDAwMDAwZDgwMDAw
MDAuLjB4MDAwMDAwMDBkODdmZmZmZiAtPiAweDAwMDAwMDAwMDAwMDAwMDAKVG9wIG9mIFJBTTog
MHgxMDAwMDAwMCwgVG90YWwgUkFNOiAweDEwMDAwMDAwCk1lbW9yeSBob2xlIHNpemU6IDBNQgpa
b25lIFBGTiByYW5nZXM6CiAgRE1BICAgICAgMHgwMDAwMDAwMCAtPiAweDAwMDEwMDAwCiAgTm9y
bWFsICAgZW1wdHkKICBIaWdoTWVtICBlbXB0eQpNb3ZhYmxlIHpvbmUgc3RhcnQgUEZOIGZvciBl
YWNoIG5vZGUKZWFybHlfbm9kZV9tYXBbMV0gYWN0aXZlIFBGTiByYW5nZXMKICAgIDA6IDB4MDAw
MDAwMDAgLT4gMHgwMDAxMDAwMApPbiBub2RlIDAgdG90YWxwYWdlczogNjU1MzYKZnJlZV9hcmVh
X2luaXRfbm9kZTogbm9kZSAwLCBwZ2RhdCBjMDQyODVlOCwgbm9kZV9tZW1fbWFwIGMwNDgyMDAw
CiAgRE1BIHpvbmU6IDUxMiBwYWdlcyB1c2VkIGZvciBtZW1tYXAKICBETUEgem9uZTogMCBwYWdl
cyByZXNlcnZlZAogIERNQSB6b25lOiA2NTAyNCBwYWdlcywgTElGTyBiYXRjaDoxNQpCdWlsdCAx
IHpvbmVsaXN0cyBpbiBab25lIG9yZGVyLCBtb2JpbGl0eSBncm91cGluZyBvbi4gIFRvdGFsIHBh
Z2VzOiA2NTAyNApLZXJuZWwgY29tbWFuZCBsaW5lOiByb290PS9kZXYvcmFtIHJhbWRpc2tfc2l6
ZT0xMjAwMDAgcncgaXA9MTAuMjAuNTAuMjMwOjEwLjIwLjUwLjcwOjEwLjIwLjUwLjUwOjI1NS4y
NTUuMC4wOlBvd2VyUVVJQ0M6ZXRoMDpvZmYgY29uc29sZT10dHlTMCwxMTUyMDAgbXRkcGFydHM9
bmFuZDo0bShrZXJuZWwpLC0oamZmczIpClBJRCBoYXNoIHRhYmxlIGVudHJpZXM6IDEwMjQgKG9y
ZGVyOiAwLCA0MDk2IGJ5dGVzKQpEZW50cnkgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAzMjc2
OCAob3JkZXI6IDUsIDEzMTA3MiBieXRlcykKSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVz
OiAxNjM4NCAob3JkZXI6IDQsIDY1NTM2IGJ5dGVzKQpIaWdoIG1lbW9yeTogMGsKTWVtb3J5OiAy
NTE4ODRrLzI2MjE0NGsgYXZhaWxhYmxlICg0MDcyayBrZXJuZWwgY29kZSwgMTAyNjBrIHJlc2Vy
dmVkLCAyNDRrIGRhdGEsIDI2N2sgYnNzLCAxOTJrIGluaXQpCktlcm5lbCB2aXJ0dWFsIG1lbW9y
eSBsYXlvdXQ6CiAgKiAweGZmZmNmMDAwLi4weGZmZmZmMDAwICA6IGZpeG1hcAogICogMHhmZjgw
MDAwMC4uMHhmZmMwMDAwMCAgOiBoaWdobWVtIFBURXMKICAqIDB4ZmU2ZjcwMDAuLjB4ZmY4MDAw
MDAgIDogZWFybHkgaW9yZW1hcAogICogMHhkMTAwMDAwMC4uMHhmZTZmNzAwMCAgOiB2bWFsbG9j
ICYgaW9yZW1hcApIaWVyYXJjaGljYWwgUkNVIGltcGxlbWVudGF0aW9uLgoJUkNVLWJhc2VkIGRl
dGVjdGlvbiBvZiBzdGFsbGVkIENQVXMgaXMgZGlzYWJsZWQuCglWZXJib3NlIHN0YWxsZWQtQ1BV
cyBkZXRlY3Rpb24gaXMgZGlzYWJsZWQuCk5SX0lSUVM6NTEyCklQSUMgKDEyOCBJUlEgc291cmNl
cykgYXQgZDEwMDA3MDAKdGltZV9pbml0OiBkZWNyZW1lbnRlciBmcmVxdWVuY3kgPSA5OS45OTk5
OTkgTUh6CnRpbWVfaW5pdDogcHJvY2Vzc29yIGZyZXF1ZW5jeSAgID0gNzk5Ljk5OTk5MiBNSHoK
Y2xvY2tzb3VyY2U6IHRpbWViYXNlIG11bHRbMjgwMDAwMF0gc2hpZnRbMjJdIHJlZ2lzdGVyZWQK
Y2xvY2tldmVudDogZGVjcmVtZW50ZXIgbXVsdFsxOTk5OTk5NV0gc2hpZnRbMzJdIGNwdVswXQpD
b25zb2xlOiBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1CnBpZF9tYXg6IGRlZmF1bHQ6IDMyNzY4
IG1pbmltdW06IDMwMQpTZWN1cml0eSBGcmFtZXdvcmsgaW5pdGlhbGl6ZWQKU0VMaW51eDogIERp
c2FibGVkIGF0IGJvb3QuCk1vdW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNTEyCkluaXRp
YWxpemluZyBjZ3JvdXAgc3Vic3lzIG5zCkluaXRpYWxpemluZyBjZ3JvdXAgc3Vic3lzIGNwdWFj
Y3QKSW5pdGlhbGl6aW5nIGNncm91cCBzdWJzeXMgZGV2aWNlcwpORVQ6IFJlZ2lzdGVyZWQgcHJv
dG9jb2wgZmFtaWx5IDE2CmlycTogaXJxIDM4IG9uIGhvc3QgL2ltbXJAZTAwMDAwMDAvaW50ZXJy
dXB0LWNvbnRyb2xsZXJANzAwIG1hcHBlZCB0byB2aXJ0dWFsIGlycSAzOApfX2lycV9zZXRfdHJp
Z2dlcjogc2V0dGluZyB0eXBlLCBpcnEgPSAzOCwgZmxhZ3MgPSA4CmlwaWNfc2V0X2lycV90eXBl
IGZ1bmN0aW9uLCB3aXRoIHZpcnEgPSAzOCwgZmxvdyA9IDgKaXJxOiBpcnEgNzQgb24gaG9zdCAv
aW1tckBlMDAwMDAwMC9pbnRlcnJ1cHQtY29udHJvbGxlckA3MDAgbWFwcGVkIHRvIHZpcnR1YWwg
aXJxIDc0Cl9faXJxX3NldF90cmlnZ2VyOiBzZXR0aW5nIHR5cGUsIGlycSA9IDc0LCBmbGFncyA9
IDgKaXBpY19zZXRfaXJxX3R5cGUgZnVuY3Rpb24sIHdpdGggdmlycSA9IDc0LCBmbG93ID0gOApp
cnE6IGlycSA3NSBvbiBob3N0IC9pbW1yQGUwMDAwMDAwL2ludGVycnVwdC1jb250cm9sbGVyQDcw
MCBtYXBwZWQgdG8gdmlydHVhbCBpcnEgNzUKX19pcnFfc2V0X3RyaWdnZXI6IHNldHRpbmcgdHlw
ZSwgaXJxID0gNzUsIGZsYWdzID0gOAppcGljX3NldF9pcnFfdHlwZSBmdW5jdGlvbiwgd2l0aCB2
aXJxID0gNzUsIGZsb3cgPSA4ClBDSTogUHJvYmluZyBQQ0kgaGFyZHdhcmUKcGNpX2J1cyAwMDAw
OjAwOiBzY2FubmluZyBidXMKcGNpIDAwMDA6MDA6MDAuMDogZm91bmQgWzE5NTc6MDBjNl0gY2xh
c3MgMDAwYjIwIGhlYWRlciB0eXBlIDAwCnBjaSAwMDAwOjAwOjAwLjA6IHJlZyAxMDogW21lbSAw
eDAwMDAwMDAwLTB4MDAwZmZmZmZdCnBjaSAwMDAwOjAwOjAwLjA6IHJlZyAxODogW21lbSAweDAw
MDAwMDAwLTB4MGZmZmZmZmYgNjRiaXQgcHJlZl0KcGNpIDAwMDA6MDA6MDAuMDogY2FsbGluZyBm
aXh1cF9oaWRlX2hvc3RfcmVzb3VyY2VfZnNsKzB4MC8weDU4CnBjaSAwMDAwOjAwOjAwLjA6IGNh
bGxpbmcgcGNpYmlvc19maXh1cF9yZXNvdXJjZXMrMHgwLzB4MjM4CnBjaSAwMDAwOjAwOjAwLjA6
IGNhbGxpbmcgcXVpcmtfZnNsX3BjaWVfaGVhZGVyKzB4MC8weDQ4CnBjaSAwMDAwOjAwOjAwLjA6
IGNhbGxpbmcgcXVpcmtfcmVzb3VyY2VfYWxpZ25tZW50KzB4MC8weDFjMApwY2kgMDAwMDowMDow
MC4wOiBzdXBwb3J0cyBEMSBEMgpwY2kgMDAwMDowMDowMC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9t
IEQwIEQxIEQyIEQzaG90CnBjaSAwMDAwOjAwOjAwLjA6IFBNRSMgZGlzYWJsZWQKcGNpX2J1cyAw
MDAwOjAwOiBmaXh1cHMgZm9yIGJ1cwpwY2lfYnVzIDAwMDA6MDA6IGJ1cyBzY2FuIHJldHVybmlu
ZyB3aXRoIG1heD0wMApwY2lfYnVzIDAwMDE6MDE6IHNjYW5uaW5nIGJ1cwpwY2kgMDAwMTowMTow
MC4wOiBmb3VuZCBbMTk1NzowMGM2XSBjbGFzcyAwMDBiMjAgaGVhZGVyIHR5cGUgMDEKcGNpIDAw
MDE6MDE6MDAuMDogaWdub3JpbmcgY2xhc3MgYjIwIChkb2Vzbid0IG1hdGNoIGhlYWRlciB0eXBl
IDAxKQpwY2kgMDAwMTowMTowMC4wOiBjYWxsaW5nIGZpeHVwX2hpZGVfaG9zdF9yZXNvdXJjZV9m
c2wrMHgwLzB4NTgKcGNpIDAwMDE6MDE6MDAuMDogY2FsbGluZyBwY2liaW9zX2ZpeHVwX3Jlc291
cmNlcysweDAvMHgyMzgKcGNpIDAwMDE6MDE6MDAuMDogY2FsbGluZyBxdWlya19mc2xfcGNpZV9o
ZWFkZXIrMHgwLzB4NDgKcGNpIDAwMDE6MDE6MDAuMDogY2FsbGluZyBxdWlya19yZXNvdXJjZV9h
bGlnbm1lbnQrMHgwLzB4MWMwCnBjaSAwMDAxOjAxOjAwLjA6IHN1cHBvcnRzIEQxIEQyCnBjaSAw
MDAxOjAxOjAwLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDEgRDIgRDNob3QKcGNpIDAwMDE6
MDE6MDAuMDogUE1FIyBkaXNhYmxlZApwY2lfYnVzIDAwMDE6MDE6IGZpeHVwcyBmb3IgYnVzCnBj
aSAwMDAxOjAxOjAwLjA6IHNjYW5uaW5nIFtidXMgMDEtZmZdIGJlaGluZCBicmlkZ2UsIHBhc3Mg
MApwY2kgMDAwMTowMTowMC4wOiBidXMgY29uZmlndXJhdGlvbiBpbnZhbGlkLCByZWNvbmZpZ3Vy
aW5nCnBjaSAwMDAxOjAxOjAwLjA6IHNjYW5uaW5nIFtidXMgMDAtMDBdIGJlaGluZCBicmlkZ2Us
IHBhc3MgMQpwY2lfYnVzIDAwMDE6MDI6IHNjYW5uaW5nIGJ1cwpwY2kgMDAwMTowMjowMC4wOiBm
b3VuZCBbMTIwNDplMjUwXSBjbGFzcyAwMDAwMDAgaGVhZGVyIHR5cGUgMDAKcGNpIDAwMDE6MDI6
MDAuMDogcmVnIDEwOiBbbWVtIDB4ZmZmYzAwMDAtMHhmZmZmZmZmZl0KcGNpIDAwMDE6MDI6MDAu
MDogcmVnIDE0OiBbbWVtIDB4ZmZmYzAwMDAtMHhmZmZmZmZmZl0KcGNpIDAwMDE6MDI6MDAuMDog
Y2FsbGluZyBwY2liaW9zX2ZpeHVwX3Jlc291cmNlcysweDAvMHgyMzgKcGNpIDAwMDE6MDI6MDAu
MDogY2FsbGluZyBxdWlya19yZXNvdXJjZV9hbGlnbm1lbnQrMHgwLzB4MWMwCnBjaV9idXMgMDAw
MTowMjogZml4dXBzIGZvciBidXMKcGNpIDAwMDE6MDE6MDAuMDogUENJIGJyaWRnZSB0byBbYnVz
IDAyLWZmXQpwY2kgMDAwMTowMTowMC4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDAwMDAtMHgw
MDAwXSAoZGlzYWJsZWQpCnBjaSAwMDAxOjAxOjAwLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4
MDAwMDAwMDAtMHgwMDBmZmZmZl0gKGRpc2FibGVkKQpwY2kgMDAwMTowMTowMC4wOiAgIGJyaWRn
ZSB3aW5kb3cgW21lbSAweDAwMDAwMDAwLTB4MDAwZmZmZmYgcHJlZl0gKGRpc2FibGVkKQppcnE6
IGlycSAxIG9uIGhvc3QgL2ltbXJAZTAwMDAwMDAvaW50ZXJydXB0LWNvbnRyb2xsZXJANzAwIG1h
cHBlZCB0byB2aXJ0dWFsIGlycSAxNgpfX2lycV9zZXRfdHJpZ2dlcjogc2V0dGluZyB0eXBlLCBp
cnEgPSAxNiwgZmxhZ3MgPSA4CmlwaWNfc2V0X2lycV90eXBlIGZ1bmN0aW9uLCB3aXRoIHZpcnEg
PSAxNiwgZmxvdyA9IDgKcGNpX2J1cyAwMDAxOjAyOiBidXMgc2NhbiByZXR1cm5pbmcgd2l0aCBt
YXg9MDIKcGNpX2J1cyAwMDAxOjAxOiBidXMgc2NhbiByZXR1cm5pbmcgd2l0aCBtYXg9MDIKcGNp
X2J1cyAwMDAyOjAzOiBzY2FubmluZyBidXMKcGNpX2J1cyAwMDAyOjAzOiBmaXh1cHMgZm9yIGJ1
cwpwY2lfYnVzIDAwMDI6MDM6IGJ1cyBzY2FuIHJldHVybmluZyB3aXRoIG1heD0wMwpQQ0ktPk9G
IGJ1cyBtYXA6CjAgLT4gMAoxIC0+IDAKMyAtPiAwClBDSTogQ2Fubm90IGFsbG9jYXRlIHJlc291
cmNlIHJlZ2lvbiAwIG9mIGRldmljZSAwMDAxOjAyOjAwLjAsIHdpbGwgcmVtYXAKUENJOiBDYW5u
b3QgYWxsb2NhdGUgcmVzb3VyY2UgcmVnaW9uIDEgb2YgZGV2aWNlIDAwMDE6MDI6MDAuMCwgd2ls
bCByZW1hcApwY2kgMDAwMTowMTowMC4wOiBCQVIgODogYXNzaWduZWQgW21lbSAweGE4MDAwMDAw
LTB4YTgwZmZmZmZdCnBjaSAwMDAxOjAxOjAwLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMi0wMl0K
cGNpIDAwMDE6MDE6MDAuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgZGlzYWJsZWRdCnBjaSAwMDAx
OjAxOjAwLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4YTgwMDAwMDAtMHhhODBmZmZmZl0KcGNp
IDAwMDE6MDE6MDAuMDogICBicmlkZ2Ugd2luZG93IFttZW0gcHJlZiBkaXNhYmxlZF0KcGNpX2J1
cyAwMDAwOjAwOiByZXNvdXJjZSAwIFtpbyAgMHgwMDAwLTB4ZmZmZmZdCnBjaV9idXMgMDAwMDow
MDogcmVzb3VyY2UgMSBbbWVtIDB4OTAwMDAwMDAtMHg5ZmZmZmZmZl0KcGNpX2J1cyAwMDAwOjAw
OiByZXNvdXJjZSAyIFttZW0gMHg4MDAwMDAwMC0weDhmZmZmZmZmIHByZWZdCnBjaV9idXMgMDAw
MTowMTogcmVzb3VyY2UgMCBbaW8gIDB4ZmY3ZmUwMDAtMHhmZmZmZGZmZl0KcGNpX2J1cyAwMDAx
OjAxOiByZXNvdXJjZSAxIFttZW0gMHhhODAwMDAwMC0weGI3ZmZmZmZmXQpwY2lfYnVzIDAwMDE6
MDI6IHJlc291cmNlIDEgW21lbSAweGE4MDAwMDAwLTB4YTgwZmZmZmZdCnBjaV9idXMgMDAwMjow
MzogcmVzb3VyY2UgMCBbaW8gIDB4ZmVmZmMwMDAtMHhmZjdmYmZmZl0KcGNpX2J1cyAwMDAyOjAz
OiByZXNvdXJjZSAxIFttZW0gMHhjODAwMDAwMC0weGQ3ZmZmZmZmXQpSZWdpc3RlcmluZyBxZV9p
YyB3aXRoIHN5c2ZzLi4uClJlZ2lzdGVyaW5nIGlwaWMgd2l0aCBzeXNmcy4uLgpiaW86IGNyZWF0
ZSBzbGFiIDxiaW8tMD4gYXQgMAp2Z2FhcmI6IGxvYWRlZApTQ1NJIHN1YnN5c3RlbSBpbml0aWFs
aXplZApTd2l0Y2hpbmcgdG8gY2xvY2tzb3VyY2UgdGltZWJhc2UKTkVUOiBSZWdpc3RlcmVkIHBy
b3RvY29sIGZhbWlseSAyCklQIHJvdXRlIGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMjA0OCAo
b3JkZXI6IDEsIDgxOTIgYnl0ZXMpClRDUCBlc3RhYmxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6
IDgxOTIgKG9yZGVyOiA0LCA2NTUzNiBieXRlcykKVENQIGJpbmQgaGFzaCB0YWJsZSBlbnRyaWVz
OiA4MTkyIChvcmRlcjogMywgMzI3NjggYnl0ZXMpClRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJl
ZCAoZXN0YWJsaXNoZWQgODE5MiBiaW5kIDgxOTIpClRDUCByZW5vIHJlZ2lzdGVyZWQKVURQIGhh
c2ggdGFibGUgZW50cmllczogMjU2IChvcmRlcjogMCwgNDA5NiBieXRlcykKVURQLUxpdGUgaGFz
aCB0YWJsZSBlbnRyaWVzOiAyNTYgKG9yZGVyOiAwLCA0MDk2IGJ5dGVzKQpORVQ6IFJlZ2lzdGVy
ZWQgcHJvdG9jb2wgZmFtaWx5IDEKcGNpIDAwMDA6MDA6MDAuMDogY2FsbGluZyBxdWlya19jYXJk
YnVzX2xlZ2FjeSsweDAvMHg0NApwY2kgMDAwMDowMDowMC4wOiBjYWxsaW5nIHF1aXJrX3VzYl9l
YXJseV9oYW5kb2ZmKzB4MC8weDc0MApwY2kgMDAwMTowMTowMC4wOiBjYWxsaW5nIHF1aXJrX2Nh
cmRidXNfbGVnYWN5KzB4MC8weDQ0CnBjaSAwMDAxOjAxOjAwLjA6IGNhbGxpbmcgcXVpcmtfdXNi
X2Vhcmx5X2hhbmRvZmYrMHgwLzB4NzQwCnBjaSAwMDAxOjAyOjAwLjA6IGNhbGxpbmcgcXVpcmtf
Y2FyZGJ1c19sZWdhY3krMHgwLzB4NDQKcGNpIDAwMDE6MDI6MDAuMDogY2FsbGluZyBxdWlya191
c2JfZWFybHlfaGFuZG9mZisweDAvMHg3NDAKUENJOiBDTFMgMzIgYnl0ZXMsIGRlZmF1bHQgMzIK
VHJ5aW5nIHRvIHVucGFjayByb290ZnMgaW1hZ2UgYXMgaW5pdHJhbWZzLi4uCnJvb3RmcyBpbWFn
ZSBpcyBub3QgaW5pdHJhbWZzIChubyBjcGlvIG1hZ2ljKTsgbG9va3MgbGlrZSBhbiBpbml0cmQK
RnJlZWluZyBpbml0cmQgbWVtb3J5OiAzMzQ1ayBmcmVlZAppcnE6IGlycSA5IG9uIGhvc3QgL2lt
bXJAZTAwMDAwMDAvaW50ZXJydXB0LWNvbnRyb2xsZXJANzAwIG1hcHBlZCB0byB2aXJ0dWFsIGly
cSAxNwpfX2lycV9zZXRfdHJpZ2dlcjogc2V0dGluZyB0eXBlLCBpcnEgPSAxNywgZmxhZ3MgPSA4
CmlwaWNfc2V0X2lycV90eXBlIGZ1bmN0aW9uLCB3aXRoIHZpcnEgPSAxNywgZmxvdyA9IDgKaXJx
OiBpcnEgMTAgb24gaG9zdCAvaW1tckBlMDAwMDAwMC9pbnRlcnJ1cHQtY29udHJvbGxlckA3MDAg
bWFwcGVkIHRvIHZpcnR1YWwgaXJxIDE4Cl9faXJxX3NldF90cmlnZ2VyOiBzZXR0aW5nIHR5cGUs
IGlycSA9IDE4LCBmbGFncyA9IDgKaXBpY19zZXRfaXJxX3R5cGUgZnVuY3Rpb24sIHdpdGggdmly
cSA9IDE4LCBmbG93ID0gOAppcnE6IGlycSA4MCBvbiBob3N0IC9pbW1yQGUwMDAwMDAwL2ludGVy
cnVwdC1jb250cm9sbGVyQDcwMCBtYXBwZWQgdG8gdmlydHVhbCBpcnEgODAKX19pcnFfc2V0X3Ry
aWdnZXI6IHNldHRpbmcgdHlwZSwgaXJxID0gODAsIGZsYWdzID0gOAppcGljX3NldF9pcnFfdHlw
ZSBmdW5jdGlvbiwgd2l0aCB2aXJxID0gODAsIGZsb3cgPSA4CmF1ZGl0OiBpbml0aWFsaXppbmcg
bmV0bGluayBzb2NrZXQgKGRpc2FibGVkKQp0eXBlPTIwMDAgYXVkaXQoMC4yMTI6MSk6IGluaXRp
YWxpemVkCkpGRlMyIHZlcnNpb24gMi4yLiAoTkFORCkgwqkgMjAwMS0yMDA2IFJlZCBIYXQsIElu
Yy4KU0dJIFhGUyB3aXRoIHNlY3VyaXR5IGF0dHJpYnV0ZXMsIGxhcmdlIGJsb2NrL2lub2RlIG51
bWJlcnMsIG5vIGRlYnVnIGVuYWJsZWQKbXNnbW5pIGhhcyBiZWVuIHNldCB0byA0OTgKYWxnOiBO
byB0ZXN0IGZvciBjaXBoZXJfbnVsbCAoY2lwaGVyX251bGwtZ2VuZXJpYykKYWxnOiBObyB0ZXN0
IGZvciBlY2IoY2lwaGVyX251bGwpIChlY2ItY2lwaGVyX251bGwpCmFsZzogTm8gdGVzdCBmb3Ig
ZGlnZXN0X251bGwgKGRpZ2VzdF9udWxsLWdlbmVyaWMpCmFsZzogTm8gdGVzdCBmb3IgY29tcHJl
c3NfbnVsbCAoY29tcHJlc3NfbnVsbC1nZW5lcmljKQphbGc6IE5vIHRlc3QgZm9yIHN0ZHJuZyAo
a3JuZykKQmxvY2sgbGF5ZXIgU0NTSSBnZW5lcmljIChic2cpIGRyaXZlciB2ZXJzaW9uIDAuNCBs
b2FkZWQgKG1ham9yIDI1MykKaW8gc2NoZWR1bGVyIG5vb3AgcmVnaXN0ZXJlZAppbyBzY2hlZHVs
ZXIgZGVhZGxpbmUgcmVnaXN0ZXJlZAppbyBzY2hlZHVsZXIgY2ZxIHJlZ2lzdGVyZWQgKGRlZmF1
bHQpClNlcmlhbDogODI1MC8xNjU1MCBkcml2ZXIsIDQgcG9ydHMsIElSUSBzaGFyaW5nIGVuYWJs
ZWQKc2VyaWFsODI1MC4wOiB0dHlTMCBhdCBNTUlPIDB4ZTAwMDQ1MDAgKGlycSA9IDE3KSBpcyBh
IDE2NTUwQQpjb25zb2xlIFt0dHlTMF0gZW5hYmxlZCwgYm9vdGNvbnNvbGUgZGlzYWJsZWQKc2Vy
aWFsODI1MC4wOiB0dHlTMSBhdCBNTUlPIDB4ZTAwMDQ2MDAgKGlycSA9IDE4KSBpcyBhIDE2NTUw
QQpicmQ6IG1vZHVsZSBsb2FkZWQKb2ZfbXBjOHh4eF9zcGlfcHJvYmUgZnVuY3Rpb24gY2FsbGVk
LgppcnE6IGlycSAxNiBvbiBob3N0IC9pbW1yQGUwMDAwMDAwL2ludGVycnVwdC1jb250cm9sbGVy
QDcwMCBtYXBwZWQgdG8gdmlydHVhbCBpcnEgMTkKX19pcnFfc2V0X3RyaWdnZXI6IHNldHRpbmcg
dHlwZSwgaXJxID0gMTksIGZsYWdzID0gOAppcGljX3NldF9pcnFfdHlwZSBmdW5jdGlvbiwgd2l0
aCB2aXJxID0gMTksIGZsb3cgPSA4Cm1wYzh4eHhfc3BpX3Byb2JlIGZ1bmN0aW9uIGNhbGxlZC4K
bXBjOHh4eF9zcGkgZTAwMDcwMDAuc3BpOiBhdCAweGQxMDc4MDAwIChpcnEgPSAxOSksIENQVSBt
b2RlCmlycTogaXJxIDMyIG9uIGhvc3QgL2ltbXJAZTAwMDAwMDAvaW50ZXJydXB0LWNvbnRyb2xs
ZXJANzAwIG1hcHBlZCB0byB2aXJ0dWFsIGlycSAzMgpfX2lycV9zZXRfdHJpZ2dlcjogc2V0dGlu
ZyB0eXBlLCBpcnEgPSAzMiwgZmxhZ3MgPSA4CmlwaWNfc2V0X2lycV90eXBlIGZ1bmN0aW9uLCB3
aXRoIHZpcnEgPSAzMiwgZmxvdyA9IDgKaXJxOiBpcnEgMzMgb24gaG9zdCAvaW1tckBlMDAwMDAw
MC9pbnRlcnJ1cHQtY29udHJvbGxlckA3MDAgbWFwcGVkIHRvIHZpcnR1YWwgaXJxIDMzCl9faXJx
X3NldF90cmlnZ2VyOiBzZXR0aW5nIHR5cGUsIGlycSA9IDMzLCBmbGFncyA9IDgKaXBpY19zZXRf
aXJxX3R5cGUgZnVuY3Rpb24sIHdpdGggdmlycSA9IDMzLCBmbG93ID0gOAppcnE6IGlycSAzNCBv
biBob3N0IC9pbW1yQGUwMDAwMDAwL2ludGVycnVwdC1jb250cm9sbGVyQDcwMCBtYXBwZWQgdG8g
dmlydHVhbCBpcnEgMzQKX19pcnFfc2V0X3RyaWdnZXI6IHNldHRpbmcgdHlwZSwgaXJxID0gMzQs
IGZsYWdzID0gOAppcGljX3NldF9pcnFfdHlwZSBmdW5jdGlvbiwgd2l0aCB2aXJxID0gMzQsIGZs
b3cgPSA4CmV0aDA6IEdpYW5mYXIgRXRoZXJuZXQgQ29udHJvbGxlciBWZXJzaW9uIDEuMiwgMDQ6
MDA6MDA6MDA6MDA6MGEKZXRoMDogUnVubmluZyB3aXRoIE5BUEkgZW5hYmxlZApldGgwOiBSWCBC
RCByaW5nIHNpemUgZm9yIFFbMF06IDI1NgpldGgwOiBUWCBCRCByaW5nIHNpemUgZm9yIFFbMF06
IDI1NgppcnE6IGlycSAzNSBvbiBob3N0IC9pbW1yQGUwMDAwMDAwL2ludGVycnVwdC1jb250cm9s
bGVyQDcwMCBtYXBwZWQgdG8gdmlydHVhbCBpcnEgMzUKX19pcnFfc2V0X3RyaWdnZXI6IHNldHRp
bmcgdHlwZSwgaXJxID0gMzUsIGZsYWdzID0gOAppcGljX3NldF9pcnFfdHlwZSBmdW5jdGlvbiwg
d2l0aCB2aXJxID0gMzUsIGZsb3cgPSA4CmlycTogaXJxIDM2IG9uIGhvc3QgL2ltbXJAZTAwMDAw
MDAvaW50ZXJydXB0LWNvbnRyb2xsZXJANzAwIG1hcHBlZCB0byB2aXJ0dWFsIGlycSAzNgpfX2ly
cV9zZXRfdHJpZ2dlcjogc2V0dGluZyB0eXBlLCBpcnEgPSAzNiwgZmxhZ3MgPSA4CmlwaWNfc2V0
X2lycV90eXBlIGZ1bmN0aW9uLCB3aXRoIHZpcnEgPSAzNiwgZmxvdyA9IDgKaXJxOiBpcnEgMzcg
b24gaG9zdCAvaW1tckBlMDAwMDAwMC9pbnRlcnJ1cHQtY29udHJvbGxlckA3MDAgbWFwcGVkIHRv
IHZpcnR1YWwgaXJxIDM3Cl9faXJxX3NldF90cmlnZ2VyOiBzZXR0aW5nIHR5cGUsIGlycSA9IDM3
LCBmbGFncyA9IDgKaXBpY19zZXRfaXJxX3R5cGUgZnVuY3Rpb24sIHdpdGggdmlycSA9IDM3LCBm
bG93ID0gOApldGgxOiBHaWFuZmFyIEV0aGVybmV0IENvbnRyb2xsZXIgVmVyc2lvbiAxLjIsIDAw
OjAwOjAwOjAwOjAwOjAwCmV0aDE6IFJ1bm5pbmcgd2l0aCBOQVBJIGVuYWJsZWQKZXRoMTogUlgg
QkQgcmluZyBzaXplIGZvciBRWzBdOiAyNTYKZXRoMTogVFggQkQgcmluZyBzaXplIGZvciBRWzBd
OiAyNTYKdWNjX2dldGg6IFFFIFVDQyBHaWdhYml0IEV0aGVybmV0IENvbnRyb2xsZXIKRnJlZXNj
YWxlIFBvd2VyUVVJQ0MgTUlJIEJ1czogcHJvYmVkCmlycTogaXJxIDE3IG9uIGhvc3QgL2ltbXJA
ZTAwMDAwMDAvaW50ZXJydXB0LWNvbnRyb2xsZXJANzAwIG1hcHBlZCB0byB2aXJ0dWFsIGlycSAy
MApfX2lycV9zZXRfdHJpZ2dlcjogc2V0dGluZyB0eXBlLCBpcnEgPSAyMCwgZmxhZ3MgPSA4Cmlw
aWNfc2V0X2lycV90eXBlIGZ1bmN0aW9uLCB3aXRoIHZpcnEgPSAyMCwgZmxvdyA9IDgKRnJlZXNj
YWxlIFBvd2VyUVVJQ0MgTUlJIEJ1czogcHJvYmVkCm1pY2U6IFBTLzIgbW91c2UgZGV2aWNlIGNv
bW1vbiBmb3IgYWxsIG1pY2UKU2tpcHBpbmcgdW5hdmFpbGFibGUgTEVEIGdwaW8gLTE5IChwd3Ip
ClNraXBwaW5nIHVuYXZhaWxhYmxlIExFRCBncGlvIC0xOSAoaGRkKQpUQ1AgY3ViaWMgcmVnaXN0
ZXJlZApORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3CnJlZ2lzdGVyZWQgdGFza3N0
YXRzIHZlcnNpb24gMQpkcml2ZXJzL3J0Yy9oY3Rvc3lzLmM6IHVuYWJsZSB0byBvcGVuIHJ0YyBk
ZXZpY2UgKHJ0YzApClJBTURJU0s6IGd6aXAgaW1hZ2UgZm91bmQgYXQgYmxvY2sgMApWRlM6IE1v
dW50ZWQgcm9vdCAoZXh0MiBmaWxlc3lzdGVtKSBvbiBkZXZpY2UgMTowLgpGcmVlaW5nIHVudXNl
ZCBrZXJuZWwgbWVtb3J5OiAxOTJrIGluaXQKUEhZOiBtZGlvQGUwMDI0NTIwOjAyIC0gTGluayBp
cyBVcCAtIDEwL0hhbGYK
--001636458f76cc1d47048fa63bd3--
