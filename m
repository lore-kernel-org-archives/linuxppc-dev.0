Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3032CB70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Sep 2010 19:23:39 +1000 (EST)
Message-ID: <4C8604E1.4080908@windriver.com>
Date: Tue, 07 Sep 2010 17:24:49 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: pci_request_regions() failure
References: <AANLkTim5kasMWC6u-mhQyCRiPv1w7BCg7o-mBfy28DfS@mail.gmail.com>	<4C85CCD6.3020504@windriver.com>
	<AANLkTi=bDOtCxW9VuXrSyAiCLoFCvWoskORpc_1ebDe7@mail.gmail.com>
In-Reply-To: <AANLkTi=bDOtCxW9VuXrSyAiCLoFCvWoskORpc_1ebDe7@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ravi Gupta wrote:
> Hi Tiejun,
> 
> Thanks for the reply. I am sending you the updated dmesg O/P(after enabling
> CONFIG_PCI_DEBUG) as attachment as well as at the end of the mail.
> 
> As far as driver is concern, I am trying the pci_skel driver available as
> example with LDD book with slight modifications.

Current LDD 3rd may be old for 2.6.35 on some sections :)

> 
> Driver Code:
> ================================================================
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/pci.h>
> 
> /* PCI IDs */
> static struct pci_device_id ids[] = {
>   { PCI_DEVICE(0x1204, 0xe250) },
>   { 0, }
> };
> MODULE_DEVICE_TABLE(pci, ids);
> 
> static unsigned char skel_get_revision(struct pci_dev *dev)
> {
>   u8 revision;
> 
>   pci_read_config_byte(dev, PCI_REVISION_ID, &revision);
>   return revision;
> }
> 
> static u16 skel_get_vendor_id(struct pci_dev *dev)
> {
>   u16 vendor_id;
> 
>   pci_read_config_word(dev, PCI_VENDOR_ID, &vendor_id);
>   return vendor_id;
> }
> 
> static u16 skel_get_device_id(struct pci_dev *dev)
> {
>   u16 device_id;
> 
>   pci_read_config_word(dev, PCI_DEVICE_ID, &device_id);
>   return device_id;
> }
> 
> static int probe(struct pci_dev *dev, const struct pci_device_id *id)
> {
>   /* Do probing type stuff here.
>    * Like calling request_region();
>    */
>   int err, i;
>   printk(KERN_ALERT "PCI driver: Probe function\n");
> 
>   /*
>    * Enable the bus-master bit values.
>    * Some PCI BIOSes fail to set the master-enable bit.
>    * Some demos support being an initiator, so need bus master ability.
>    */
>   err = pci_request_regions(dev, "pci_skell");
>   if (err) {
>     printk(KERN_ERR "request region failed :%d\n", err);
>     return err;
>   }
> 
>   pci_set_master(dev);
> 
>   if ((err = pci_enable_device(dev)) != 0) {
>     printk(KERN_ERR "Unable to Enable PCI device:%d\n", err);
>     return err;
>   }
> 
>   printk(KERN_ALERT "PCI driver Vendor ID = %x\n", skel_get_vendor_id(dev));
>   printk(KERN_ALERT "PCI driver Device ID = %x\n", skel_get_device_id(dev));
>   printk(KERN_ALERT "PCI driver Revision = %d\n", skel_get_revision(dev));
>   return 0;
> }
> 
> static void remove(struct pci_dev *dev)
> {
>   /* clean up any allocated resources and stuff here.
>    * like call release_region();
>    */
> }
> 
> static struct pci_driver pci_driver = {
>   .name = "pci_skel",
>   .id_table = ids,
>   .probe = probe,
>   .remove = remove,
> };
> 
> static int __init pci_skel_init(void)
> {
>   printk(KERN_ALERT "PCI driver: Init function\n");
>   return pci_register_driver(&pci_driver);
> }
> 
> static void __exit pci_skel_exit(void)
> {
>   printk(KERN_ALERT "PCI driver: Exit function\n");
>   pci_unregister_driver(&pci_driver);
> }
> 
> MODULE_LICENSE("GPL");
> 
> module_init(pci_skel_init);
> module_exit(pci_skel_exit);
> ================================================================
> 
> The above code fails at the pci_request_regions(dev, "pci_skell"); call,
> with -EBUSY(-16) i.e resource busy error. If I don't request for resources
> and directly enable the pci device by calling pci_device_enable(), it gives
> the error message
> 
> PCI driver: Init function
> PCI driver: Probe function
> pci_skel 0001:02:00.0: device not available (can't reserve [mem
> 0x00000000-0x0003ffff])
> Unable to Enable PCI device:-22
> pci_skel: probe of 0001:02:00.0 failed with error -22

Your PCI device should be one virtual device so I think the above should be as
we understood. You know 0x00000000 ~ 0x00003ffff should not be allowed to
reserved.

> 
> 
> 
>> Especially I want to know how/where you get
>> these two range, a8000000-a803ffff and a8040000-a807ffff. You wired them
> firstly
>> on the driver or allocated by the kernel?
> 
> Actually as I said before, I tried my device on i386 machine and there I got
> two ranges fe900000-fe93ffff and fe940000-fe97ffff, so from there I am
> guessing that on PowerPC also, it should allocate two ranges
> a8000000-a803ffff and a8040000-a807ffff resp.

I think you should do the following sequence in the probe function of your PCI
driver.

1. pci_enable_device(pdev);
2. pci_request_regions(pdev, DRV_NAME);
3. pci_set_master(pdev);
......

> 
> 
> 
> lspci output
> ================================================================
> 0000:00:00.0 Power PC: Freescale Semiconductor Inc Unknown device 00c6 (rev
> 21)
> 0001:01:00.0 PCI bridge: Freescale Semiconductor Inc Unknown device 00c6
> (rev 21)
> 0001:02:00.0 Non-VGA unclassified device: Lattice Semiconductor Corporation
> Unknown device e250   ----------> My device
> ================================================================
> 
> Dmesg with CONFIG_PCI_DEBUG enable.
> ================================================================
> Using MPC837x RDB/WLAN machine description
> Initializing cgroup subsys cpuset
> Initializing cgroup subsys cpu
> Linux version 2.6.35 (okapi@okapi) (gcc version 4.2.3 (Sourcery G++ Lite
> 4.2-171)) #13 Tue Sep 7 11:37:47 IST 2010
> Found initrd at 0xcf46d000:0xcf7b15b7
> Found legacy serial port 0 for /immr@e0000000/serial@4500
>   mem=e0004500, taddr=e0004500, irq=0, clk=399999996, speed=0
> Found legacy serial port 1 for /immr@e0000000/serial@4600
>   mem=e0004600, taddr=e0004600, irq=0, clk=399999996, speed=0
> bootconsole [udbg0] enabled
> Found FSL PCI host bridge at 0x00000000e0008500. Firmware bus number: 0->0
> PCI host bridge /pci@e0008500 (primary) ranges:
>  MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000
>  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 Prefetch
>   IO 0x00000000e0300000..0x00000000e03fffff -> 0x0000000000000000
> No pci config register base in dev tree, using default
> Found FSL PCI host bridge at 0x00000000e0009000. Firmware bus number: 0->255
> PCI host bridge /pcie@e0009000  ranges:
>  MEM 0x00000000a8000000..0x00000000b7ffffff -> 0x00000000a8000000
>   IO 0x00000000b8000000..0x00000000b87fffff -> 0x0000000000000000
> No pci config register base in dev tree, using default
> Found FSL PCI host bridge at 0x00000000e000a000. Firmware bus number: 0->255
> PCI host bridge /pcie@e000a000  ranges:
>  MEM 0x00000000c8000000..0x00000000d7ffffff -> 0x00000000c8000000
>   IO 0x00000000d8000000..0x00000000d87fffff -> 0x0000000000000000
> Top of RAM: 0x10000000, Total RAM: 0x10000000
> Memory hole size: 0MB
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00010000
>   Normal   empty
>   HighMem  empty
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00000000 -> 0x00010000
> On node 0 totalpages: 65536
> free_area_init_node: node 0, pgdat c04285e8, node_mem_map c0482000
>   DMA zone: 512 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 65024 pages, LIFO batch:15
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line: root=/dev/ram ramdisk_size=120000 rw ip=10.20.50.230:10
> .20.50.70:10.20.50.50:255.255.0.0:PowerQUICC:eth0:off console=ttyS0,115200
> mtdparts=nand:4m(kernel),-(jffs2)
> PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> High memory: 0k
> Memory: 251884k/262144k available (4072k kernel code, 10260k reserved, 244k
> data, 267k bss, 192k init)
> Kernel virtual memory layout:
>   * 0xfffcf000..0xfffff000  : fixmap
>   * 0xff800000..0xffc00000  : highmem PTEs
>   * 0xfe6f7000..0xff800000  : early ioremap
>   * 0xd1000000..0xfe6f7000  : vmalloc & ioremap
> Hierarchical RCU implementation.
>     RCU-based detection of stalled CPUs is disabled.
>     Verbose stalled-CPUs detection is disabled.
> NR_IRQS:512
> IPIC (128 IRQ sources) at d1000700
> time_init: decrementer frequency = 99.999999 MHz
> time_init: processor frequency   = 799.999992 MHz
> clocksource: timebase mult[2800000] shift[22] registered
> clockevent: decrementer mult[19999995] shift[32] cpu[0]
> Console: colour dummy device 80x25
> pid_max: default: 32768 minimum: 301
> Security Framework initialized
> SELinux:  Disabled at boot.
> Mount-cache hash table entries: 512
> Initializing cgroup subsys ns
> Initializing cgroup subsys cpuacct
> Initializing cgroup subsys devices
> NET: Registered protocol family 16
> irq: irq 38 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 38
> __irq_set_trigger: setting type, irq = 38, flags = 8
> ipic_set_irq_type function, with virq = 38, flow = 8
> irq: irq 74 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 74
> __irq_set_trigger: setting type, irq = 74, flags = 8
> ipic_set_irq_type function, with virq = 74, flow = 8
> irq: irq 75 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 75
> __irq_set_trigger: setting type, irq = 75, flags = 8
> ipic_set_irq_type function, with virq = 75, flow = 8
> PCI: Probing PCI hardware
> pci_bus 0000:00: scanning bus
> pci 0000:00:00.0: found [1957:00c6] class 000b20 header type 00
> pci 0000:00:00.0: reg 10: [mem 0x00000000-0x000fffff]
> pci 0000:00:00.0: reg 18: [mem 0x00000000-0x0fffffff 64bit pref]
> pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58
> pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x238
> pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x48
> pci 0000:00:00.0: calling quirk_resource_alignment+0x0/0x1c0
> pci 0000:00:00.0: supports D1 D2
> pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:00:00.0: PME# disabled
> pci_bus 0000:00: fixups for bus
> pci_bus 0000:00: bus scan returning with max=00
> pci_bus 0001:01: scanning bus
> pci 0001:01:00.0: found [1957:00c6] class 000b20 header type 01
> pci 0001:01:00.0: ignoring class b20 (doesn't match header type 01)
> pci 0001:01:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58
> pci 0001:01:00.0: calling pcibios_fixup_resources+0x0/0x238
> pci 0001:01:00.0: calling quirk_fsl_pcie_header+0x0/0x48
> pci 0001:01:00.0: calling quirk_resource_alignment+0x0/0x1c0
> pci 0001:01:00.0: supports D1 D2
> pci 0001:01:00.0: PME# supported from D0 D1 D2 D3hot
> pci 0001:01:00.0: PME# disabled
> pci_bus 0001:01: fixups for bus
> pci 0001:01:00.0: scanning [bus 01-ff] behind bridge, pass 0
> pci 0001:01:00.0: bus configuration invalid, reconfiguring
> pci 0001:01:00.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0001:02: scanning bus
> pci 0001:02:00.0: found [1204:e250] class 000000 header type 00
> pci 0001:02:00.0: reg 10: [mem 0xfffc0000-0xffffffff]
> pci 0001:02:00.0: reg 14: [mem 0xfffc0000-0xffffffff]

These infos make me confused. 0xfxxxxxxx should not be original BARs value and
also cannot be allocated for resources successfully by the kernel.

Often the kernel get them to allocate as PCI bus range. For example,

Firstly checking.....
-------
pci 0001:02:00.0: reg 10: [mem 0x00000000-0x00003fff 64bit]
pci 0001:02:00.0: reg 18: [io  0x0000-0x00ff]
pci 0001:02:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]

Then allocating as the following:
-------
pci 0001:02:00.0: BAR 6: assigned [mem 0xa0000000-0xa001ffff pref]
pci 0001:02:00.0: BAR 0: assigned [mem 0xa0020000-0xa0023fff 64bit]
pci 0001:02:00.0: BAR 0: set to [mem 0xa0020000-0xa0023fff 64bit] (PCI address
[0xa0020000-0xa0023fff]

So I think your device BARs should be pre-allocated incorrectly by the
bootloader since your device is so special. Maybe this is just why that's
different from you saw on x86. As a result we cannot re-allocated into PCI bus
range as the kernel expect.

Looks we need some pci_fixup to modify them. Firstly I think you'd better 'zero'
all BARs of your PCI device on the function, pci_scan_device, on the file,
drivers/pci/probe.c. On there you can dedicate that once your device is probed.
Please check the each BAR's value again after the above fix.

Best Regards
Tiejun

> pci 0001:02:00.0: calling pcibios_fixup_resources+0x0/0x238
> pci 0001:02:00.0: calling quirk_resource_alignment+0x0/0x1c0
> pci_bus 0001:02: fixups for bus
> pci 0001:01:00.0: PCI bridge to [bus 02-ff]
> pci 0001:01:00.0:   bridge window [io  0x0000-0x0000] (disabled)
> pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
> pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
> (disabled)
> irq: irq 1 on host /immr@e0000000/interrupt-controller@700 mapped to virtual
> irq 16
> __irq_set_trigger: setting type, irq = 16, flags = 8
> ipic_set_irq_type function, with virq = 16, flow = 8
> pci_bus 0001:02: bus scan returning with max=02
> pci_bus 0001:01: bus scan returning with max=02
> pci_bus 0002:03: scanning bus
> pci_bus 0002:03: fixups for bus
> pci_bus 0002:03: bus scan returning with max=03
> PCI->OF bus map:
> 0 -> 0
> 1 -> 0
> 3 -> 0
> PCI: Cannot allocate resource region 0 of device 0001:02:00.0, will remap
> PCI: Cannot allocate resource region 1 of device 0001:02:00.0, will remap


> pci 0001:01:00.0: BAR 8: assigned [mem 0xa8000000-0xa80fffff]
> pci 0001:01:00.0: PCI bridge to [bus 02-02]
> pci 0001:01:00.0:   bridge window [io  disabled]
> pci 0001:01:00.0:   bridge window [mem 0xa8000000-0xa80fffff]
> pci 0001:01:00.0:   bridge window [mem pref disabled]
> pci_bus 0000:00: resource 0 [io  0x0000-0xfffff]
> pci_bus 0000:00: resource 1 [mem 0x90000000-0x9fffffff]
> pci_bus 0000:00: resource 2 [mem 0x80000000-0x8fffffff pref]
> pci_bus 0001:01: resource 0 [io  0xff7fe000-0xffffdfff]
> pci_bus 0001:01: resource 1 [mem 0xa8000000-0xb7ffffff]
> pci_bus 0001:02: resource 1 [mem 0xa8000000-0xa80fffff]
> pci_bus 0002:03: resource 0 [io  0xfeffc000-0xff7fbfff]
> pci_bus 0002:03: resource 1 [mem 0xc8000000-0xd7ffffff]
> Registering qe_ic with sysfs...
> Registering ipic with sysfs...
> bio: create slab <bio-0> at 0
> vgaarb: loaded
> SCSI subsystem initialized
> Switching to clocksource timebase
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> pci 0000:00:00.0: calling quirk_cardbus_legacy+0x0/0x44
> pci 0000:00:00.0: calling quirk_usb_early_handoff+0x0/0x740
> pci 0001:01:00.0: calling quirk_cardbus_legacy+0x0/0x44
> pci 0001:01:00.0: calling quirk_usb_early_handoff+0x0/0x740
> pci 0001:02:00.0: calling quirk_cardbus_legacy+0x0/0x44
> pci 0001:02:00.0: calling quirk_usb_early_handoff+0x0/0x740
> PCI: CLS 32 bytes, default 32
> Trying to unpack rootfs image as initramfs...
> rootfs image is not initramfs (no cpio magic); looks like an initrd
> Freeing initrd memory: 3345k freed
> irq: irq 9 on host /immr@e0000000/interrupt-controller@700 mapped to virtual
> irq 17
> __irq_set_trigger: setting type, irq = 17, flags = 8
> ipic_set_irq_type function, with virq = 17, flow = 8
> irq: irq 10 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 18
> __irq_set_trigger: setting type, irq = 18, flags = 8
> ipic_set_irq_type function, with virq = 18, flow = 8
> irq: irq 80 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 80
> __irq_set_trigger: setting type, irq = 80, flags = 8
> ipic_set_irq_type function, with virq = 80, flow = 8
> audit: initializing netlink socket (disabled)
> type=2000 audit(0.212:1): initialized
> JFFS2 version 2.2. (NAND) � 2001-2006 Red Hat, Inc.
> SGI XFS with security attributes, large block/inode numbers, no debug
> enabled
> msgmni has been set to 498
> alg: No test for cipher_null (cipher_null-generic)
> alg: No test for ecb(cipher_null) (ecb-cipher_null)
> alg: No test for digest_null (digest_null-generic)
> alg: No test for compress_null (compress_null-generic)
> alg: No test for stdrng (krng)
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 17) is a 16550A
> console [ttyS0] enabled, bootconsole disabled
> serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 18) is a 16550A
> brd: module loaded
> of_mpc8xxx_spi_probe function called.
> irq: irq 16 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 19
> __irq_set_trigger: setting type, irq = 19, flags = 8
> ipic_set_irq_type function, with virq = 19, flow = 8
> mpc8xxx_spi_probe function called.
> mpc8xxx_spi e0007000.spi: at 0xd1078000 (irq = 19), CPU mode
> irq: irq 32 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 32
> __irq_set_trigger: setting type, irq = 32, flags = 8
> ipic_set_irq_type function, with virq = 32, flow = 8
> irq: irq 33 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 33
> __irq_set_trigger: setting type, irq = 33, flags = 8
> ipic_set_irq_type function, with virq = 33, flow = 8
> irq: irq 34 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 34
> __irq_set_trigger: setting type, irq = 34, flags = 8
> ipic_set_irq_type function, with virq = 34, flow = 8
> eth0: Gianfar Ethernet Controller Version 1.2, 04:00:00:00:00:0a
> eth0: Running with NAPI enabled
> eth0: RX BD ring size for Q[0]: 256
> eth0: TX BD ring size for Q[0]: 256
> irq: irq 35 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 35
> __irq_set_trigger: setting type, irq = 35, flags = 8
> ipic_set_irq_type function, with virq = 35, flow = 8
> irq: irq 36 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 36
> __irq_set_trigger: setting type, irq = 36, flags = 8
> ipic_set_irq_type function, with virq = 36, flow = 8
> irq: irq 37 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 37
> __irq_set_trigger: setting type, irq = 37, flags = 8
> ipic_set_irq_type function, with virq = 37, flow = 8
> eth1: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00
> eth1: Running with NAPI enabled
> eth1: RX BD ring size for Q[0]: 256
> eth1: TX BD ring size for Q[0]: 256
> ucc_geth: QE UCC Gigabit Ethernet Controller
> Freescale PowerQUICC MII Bus: probed
> irq: irq 17 on host /immr@e0000000/interrupt-controller@700 mapped to
> virtual irq 20
> __irq_set_trigger: setting type, irq = 20, flags = 8
> ipic_set_irq_type function, with virq = 20, flow = 8
> Freescale PowerQUICC MII Bus: probed
> mice: PS/2 mouse device common for all mice
> Skipping unavailable LED gpio -19 (pwr)
> Skipping unavailable LED gpio -19 (hdd)
> TCP cubic registered
> NET: Registered protocol family 17
> registered taskstats version 1
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> RAMDISK: gzip image found at block 0
> VFS: Mounted root (ext2 filesystem) on device 1:0.
> Freeing unused kernel memory: 192k init
> PHY: mdio@e0024520:02 - Link is Up - 10/Half
> ================================================================
> 
> Regards
> Ravi Gupta
> 
