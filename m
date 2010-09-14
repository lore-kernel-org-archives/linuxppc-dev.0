Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 65C02B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Sep 2010 15:37:01 +1000 (EST)
Message-ID: <4C8F0A52.9070608@windriver.com>
Date: Tue, 14 Sep 2010 13:38:26 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: pci_request_regions() failure
References: <AANLkTim5kasMWC6u-mhQyCRiPv1w7BCg7o-mBfy28DfS@mail.gmail.com>	<4C85CCD6.3020504@windriver.com>	<AANLkTi=bDOtCxW9VuXrSyAiCLoFCvWoskORpc_1ebDe7@mail.gmail.com>	<4C8604E1.4080908@windriver.com>	<AANLkTimLO+xf2Z1zoQfZ8bfB-b--Uu701afr7zg+1r6k@mail.gmail.com>	<4C88AF1E.8010608@windriver.com>	<AANLkTik1gWKO6vif+HgtM-j_5EUMJGwKRf+saRgK4TZg@mail.gmail.com>	<4C89C0C9.6090007@windriver.com>
	<AANLkTinPb2KYDtb2fRZ0n9d2=sB1GU1o-LygPFe_BGwp@mail.gmail.com>
In-Reply-To: <AANLkTinPb2KYDtb2fRZ0n9d2=sB1GU1o-LygPFe_BGwp@mail.gmail.com>
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
> Firstly I think we'd better print the BAR0 and BAR1 on the probe function of
>> your device driver because you have to make sure if a8000000-a803ffff is
>> assigned to BAR0 and 0xa8040000-0xa807ffff for BAR1 as we expect.
>>
>> u32 value;
>> pci_read_config_word(pdev, PCI_BASE_ADDRESS_0, &value); printk...
>> pci_read_config_word(pdev, PCI_BASE_ADDRESS_1, &value); printk....
>>
>>
> Both the BAR's values are coming out to be zero.
> 
> 
>> And you can print this pci_resource_start(pdev, bar),
>> pci_resource_len(pdev,
>> bar) from the function, __pci_request_region, on the file
>> drivers/pci/pci.c.
>> Please check this as well.
>>
> 
> I have done the changes in the __pci_request_region. But as you suggested
> earlier that one should call pci_request_regions() after pci_enable_device()
> in the driver code. My driver is failing at the pci_enable_device() only.
> Hence __pci_request_region() is not getting called. If, just for RND, I call
> pci_request_regions() before pci_enable_device(), it give me the following
> O/P.
> 
> __pci_request_region : Base Address = 0
> __pci_request_region : Length Address = 1125903130362788
> __pci_request_region : Base Address = 0
> __pci_request_region : Length Address = 1125903130362788

According to these values I think the kernel don't assign the resources to your
PCI device.

> 
> 
>> And currently we have to debug this so on the function,
>> __pci_assign_resource,
>> from the file drivers/pci/setup-res.c, we can force skipping temporarily
>> pci_bus_alloc_resource for bus 0001:01 since that will call
>> pci_update_resource
>> for bus 0001:01.
>>
>> static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>>                                 int resno)
>> {
>>        struct resource *res = dev->resource + resno;
>>        resource_size_t size, min, align;
>>        int ret;
>>
>>        size = resource_size(res);
>>        min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO :
>> PCIBIOS_MIN_MEM;
>>        align = pci_resource_alignment(dev, res);
>> -------
>>        if (bus->number == 0x01) {
>>                ret = -ENOMEM
>>                return ret;
>>        }
>> -------
>>
>> I means we don't want to assign resource as the below line on the log.
>> ------
>> pci 0001:01:00.0: BAR 8: assigned [mem 0xa8000000-0xa80fffff]
>>
>> I expect the following output:
>> ------
>> pci 0001:01:00.0: BAR 8: can't assign mem pref (size 0x100000)
>>
>>
> This I have done successfully.

Sure.

> 
> Dmesg
> ================================================================
> Using MPC837x RDB/WLAN machine description
> Initializing cgroup subsys cpuset
> Initializing cgroup subsys cpu
> Linux version 2.6.35 (okapi@okapi) (gcc version 4.2.3 (Sourcery G++ Lite
> 4.2-171)) #35 Mon Sep 13 13:43:01 IST 2010
> Found initrd at 0xcf46d000:0xcf7b15b7
> Found legacy serial port 0 for /immr@e0000000/serial@4500
>   mem=e0004500, taddr=e0004500, irq=0, clk=400000002, speed=0
> Found legacy serial port 1 for /immr@e0000000/serial@4600
>   mem=e0004600, taddr=e0004600, irq=0, clk=400000002, speed=0
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
> free_area_init_node: node 0, pgdat c042d978, node_mem_map c0800000
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
> Memory: 249920k/262144k available (4092k kernel code, 12224k reserved, 248k
> data, 2207k bss, 192k init)
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
> time_init: decrementer frequency = 100.000000 MHz
> time_init: processor frequency   = 800.000004 MHz
> clocksource: timebase mult[2800000] shift[22] registered
> clockevent: decrementer mult[19999999] shift[32] cpu[0]
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
> PCI: Scanning PHB /pci@e0008500
> PCI: PHB IO resource    = 0000000000000000-00000000000fffff [100]
> PCI: PHB MEM resource 0 = 0000000090000000-000000009fffffff [200]
> PCI: PHB MEM resource 1 = 0000000080000000-000000008fffffff [2200]
> PCI: PHB MEM offset     = 0000000000000000
> PCI: PHB IO  offset     = 00000000
>     probe mode: 0
> pci_bus 0000:00: scanning bus
> pci : vendor id = 0x1957
> pci 0000:00:00.0: found [1957:00c6] class 000b20 header type 00
> pci 0000:00:00.0: reg 10: [mem 0x00000000-0x000fffff]
> pci 0000:00:00.0: reg 18: [mem 0x00000000-0x0fffffff 64bit pref]
> pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58
> pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x180
> pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x48
> pci 0000:00:00.0: calling quirk_resource_alignment+0x0/0x1c0
> pci 0000:00:00.0: supports D1 D2
> pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:00:00.0: PME# disabled
> pci_bus 0000:00: fixups for bus
> PCI: Fixup bus devices 0 (PHB)
> PCI: Try to map irq for 0000:00:00.0...
> pci_bus 0000:00: bus scan returning with max=00
> PCI: Scanning PHB /pcie@e0009000
> PCI: PHB IO resource    = 00000000ff7fe000-00000000ffffdfff [100]
> PCI: PHB MEM resource 0 = 00000000a8000000-00000000b7ffffff [200]
> PCI: PHB MEM offset     = 0000000000000000
> PCI: PHB IO  offset     = ff7fe000
>     probe mode: 0
> pci_bus 0001:01: scanning bus
> pci : vendor id = 0x1957
> pci 0001:01:00.0: found [1957:00c6] class 000b20 header type 01
> pci 0001:01:00.0: ignoring class b20 (doesn't match header type 01)
> pci 0001:01:00.0: calling fixup_hide_host_resource_fsl+0x0/0x58
> pci 0001:01:00.0: calling pcibios_fixup_resources+0x0/0x180
> pci 0001:01:00.0: calling quirk_fsl_pcie_header+0x0/0x48
> pci 0001:01:00.0: calling quirk_resource_alignment+0x0/0x1c0
> pci 0001:01:00.0: supports D1 D2
> pci 0001:01:00.0: PME# supported from D0 D1 D2 D3hot
> pci 0001:01:00.0: PME# disabled
> pci_bus 0001:01: fixups for bus
> PCI: Fixup bus devices 1 (PHB)
> PCI: Try to map irq for 0001:01:00.0...
> pci 0001:01:00.0: scanning [bus 01-ff] behind bridge, pass 0
> pci 0001:01:00.0: bus configuration invalid, reconfiguring
> pci 0001:01:00.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0001:02: scanning bus
> pci : vendor id = 0x1204
> pci 0001:02:00.0: trying to set all zeros in BARs
> pci 0001:02:00.0: found [1204:e250] class 000000 header type 00
> pci 0001:02:00.0: reg 10: [mem 0x00000000-0x0003ffff]
> pci 0001:02:00.0: reg 14: [mem 0x00000000-0x0003ffff]
> pci 0001:02:00.0: calling pcibios_fixup_resources+0x0/0x180
> PCI:0001:02:00.0 Resource 0 0000000000000000-000000000003ffff [40200] is
> unassigned
> PCI:0001:02:00.0 Resource 1 0000000000000000-000000000003ffff [40200] is
> unassigned
> pci 0001:02:00.0: calling quirk_resource_alignment+0x0/0x1c0
> pci_bus 0001:02: fixups for bus
> pci 0001:01:00.0: PCI bridge to [bus 02-ff]
> pci 0001:01:00.0:   bridge window [io  0x0000-0x0000] (disabled)
> pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
> pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
> (disabled)
> PCI: Fixup bus devices 2 (0001:01:00.0)
> PCI: Try to map irq for 0001:02:00.0...
>  Got one, spec 2 cells (0x00000001 0x00000008...) on /immr@e0000000
> /interrupt-controller@700
> irq: irq 1 on host /immr@e0000000/interrupt-controller@700 mapped to virtual
> irq 16
> __irq_set_trigger: setting type, irq = 16, flags = 8
> ipic_set_irq_type function, with virq = 16, flow = 8
>  Mapped to linux irq 16
> pci_bus 0001:02: bus scan returning with max=02
> pci_bus 0001:01: bus scan returning with max=02
> PCI: Scanning PHB /pcie@e000a000
> PCI: PHB IO resource    = 00000000feffc000-00000000ff7fbfff [100]
> PCI: PHB MEM resource 0 = 00000000c8000000-00000000d7ffffff [200]
> PCI: PHB MEM offset     = 0000000000000000
> PCI: PHB IO  offset     = feffc000
>     probe mode: 0
> pci_bus 0002:03: scanning bus
> pci_bus 0002:03: fixups for bus
> PCI: Fixup bus devices 3 (PHB)
> pci_bus 0002:03: bus scan returning with max=03
> PCI->OF bus map:
> 0 -> 0
> 1 -> 0
> 3 -> 0
> PCI: Allocating bus resources for 0000:00...
> PCI: PHB (bus 0) bridge rsrc 0: 0000000000000000-00000000000fffff [0x100],
> parent c0405660 (PCI IO)
> PCI: PHB (bus 0) bridge rsrc 1: 0000000090000000-000000009fffffff [0x200],
> parent c0405644 (PCI mem)
> PCI: PHB (bus 0) bridge rsrc 2: 0000000080000000-000000008fffffff [0x2200],
> parent c0405644 (PCI mem)
> PCI: Allocating bus resources for 0001:01...
> PCI: PHB (bus 1) bridge rsrc 0: 00000000ff7fe000-00000000ffffdfff [0x100],
> parent c0405660 (PCI IO)
> PCI: PHB (bus 1) bridge rsrc 1: 00000000a8000000-00000000b7ffffff [0x200],
> parent c0405644 (PCI mem)
> PCI: Allocating bus resources for 0001:02...
> PCI: Allocating bus resources for 0002:03...
> PCI: PHB (bus 3) bridge rsrc 0: 00000000feffc000-00000000ff7fbfff [0x100],
> parent c0405660 (PCI IO)
> PCI: PHB (bus 3) bridge rsrc 1: 00000000c8000000-00000000d7ffffff [0x200],
> parent c0405644 (PCI mem)
> Reserving legacy ranges for domain 0000
> Candidate legacy IO: [io  0x0000-0x0fff]
> hose mem offset: 0000000000000000
> hose mem res: [mem 0x90000000-0x9fffffff]
> hose mem res: [mem 0x80000000-0x8fffffff pref]
> Reserving legacy ranges for domain 0001
> Candidate legacy IO: [io  0xff7fe000-0xff7fefff]
> hose mem offset: 0000000000000000
> hose mem res: [mem 0xa8000000-0xb7ffffff]
> Reserving legacy ranges for domain 0002
> Candidate legacy IO: [io  0xfeffc000-0xfeffcfff]
> hose mem offset: 0000000000000000
> hose mem res: [mem 0xc8000000-0xd7ffffff]
> PCI: Assigning unassigned resources...
> pci 0001:01:00.0: BAR 8: can't assign mem (size 0x100000)
> pci 0001:01:00.0: PCI bridge to [bus 02-02]
> pci 0001:01:00.0: __pci_setup_bridge: Disabling prefetch window.
> pci 0001:01:00.0: __pci_setup_bridge: Prefetch window disabled successfully.
> pci 0001:01:00.0:   bridge window [io  disabled]
> pci 0001:01:00.0:   bridge window [mem disabled]
> pci 0001:01:00.0:   bridge window [mem pref disabled]

I cannot see 0001:02 is assigned again. I guess the code we modify issue 0001:02
is skipped so please check. I only hope do for 0001:01, not 0001:02.

And I think we have to clean all pre-allocated resource from the bootloader.

Firstly remove all previous change from your kernel to restore the original state.

Add the follows into kernel. (i.e. your target.c)
void debug_pci_fixup_resource(struct pci_dev* dev)
{
        pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0);
        pci_write_config_dword(dev, PCI_BASE_ADDRESS_1, 0);

        if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
                pci_write_config_dword(dev, PCI_BASE_ADDRESS_2, 0);
                pci_write_config_dword(dev, PCI_BASE_ADDRESS_3, 0);
                pci_write_config_dword(dev, PCI_BASE_ADDRESS_4, 0);
                pci_write_config_dword(dev, PCI_BASE_ADDRESS_5, 0);
        }
}
DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, debug_pci_fixup_resource);

Then you try to track why we miss allocating 0001:02.

Cheers
Tiejun

> pci_bus 0000:00: resource 0 [io  0x0000-0xfffff]
> pci_bus 0000:00: resource 1 [mem 0x90000000-0x9fffffff]
> pci_bus 0000:00: resource 2 [mem 0x80000000-0x8fffffff pref]
> pci_bus 0001:01: resource 0 [io  0xff7fe000-0xffffdfff]
> pci_bus 0001:01: resource 1 [mem 0xa8000000-0xb7ffffff]
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
> type=2000 audit(0.220:1): initialized
> JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
> SGI XFS with security attributes, large block/inode numbers, no debug
> enabled
> msgmni has been set to 494
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
> Regards,
> Ravi
> 
