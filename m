Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61822B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 22:30:01 +1000 (EST)
Subject: Re: powerpc/4xx: Regression failed on sil24 (and other) drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20110627113137.GA10387@crust.elkhashab.com>
References: <20110625235259.GA18837@crust.elkhashab.com>
	<1309169996.32158.390.camel@pasglop>
	<20110627113137.GA10387@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Jun 2011 22:29:40 +1000
Message-ID: <1309177780.32158.392.camel@pasglop>
Mime-Version: 1.0
Cc: cam@cs.ualberta.ca, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-06-27 at 06:31 -0500, Ayman El-Khashab wrote:

> That was my initial thought as well, but I wasn't versed
> enough in the pci magic in order to completely figure it
> out.
> 
> Here is the output, it is dmesg, iomem, then ioports for the
> passing and then the failing cases.

Ok, I can see some resource allocation errors in the log, I don't have
enough active brain cells left today to figure out what's going on but
I'll have a look tomorrow.

Cheers,
Ben.

> thanks
> ayman
> 
> ============== Passing ======================
> 
> Using PowerPC 44x Platform machine description
> Linux version 2.6.36-rc3-00186-g0e52247-dirty (aymane@lablinux) (gcc version 4.2.2) #18 Sat Jun 25 13:51:44 CDT 2011
> Found initrd at 0xdfa5c000:0xdfe4cbfa
> Found legacy serial port 0 for /plb/opb/serial@ef600300
>   mem=4ef600300, taddr=4ef600300, irq=0, clk=6451612, speed=0
> Found legacy serial port 1 for /plb/opb/serial@ef600400
>   mem=4ef600400, taddr=4ef600400, irq=0, clk=6451612, speed=0
> Top of RAM: 0x20000000, Total RAM: 0x20000000
> Memory hole size: 0MB
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00020000
>   Normal   empty
>   HighMem  empty
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00000000 -> 0x00020000
> On node 0 totalpages: 131072
> free_area_init_node: node 0, pgdat c03b9f48, node_mem_map c03ed000
>   DMA zone: 1024 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 130048 pages, LIFO batch:31
> MMU: Allocated 1088 bytes of context maps for 255 contexts
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
> Kernel command line: root=/dev/ram rw mem=512M ip=169.254.0.180:169.254.0.100:169.254.0.100:255.255.255.0:tanosx:eth0:off panic=1 console=ttyS0,57600
> PID hash table entries: 2048 (order: 1, 8192 bytes)
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> High memory: 0k
> Memory: 511668k/524288k available (3692k kernel code, 12620k reserved, 176k data, 141k bss, 184k init)
> Kernel virtual memory layout:
>   * 0xfffcf000..0xfffff000  : fixmap
>   * 0xffc00000..0xffe00000  : highmem PTEs
>   * 0xffa00000..0xffc00000  : consistent mem
>   * 0xffa00000..0xffa00000  : early ioremap
>   * 0xe1000000..0xffa00000  : vmalloc & ioremap
> SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> NR_IRQS:512
> UIC0 (32 IRQ sources) at DCR 0xc0
> UIC1 (32 IRQ sources) at DCR 0xd0
> irq: irq 30 on host /interrupt-controller0 mapped to virtual irq 30
> UIC2 (32 IRQ sources) at DCR 0xe0
> irq: irq 10 on host /interrupt-controller0 mapped to virtual irq 16
> UIC3 (32 IRQ sources) at DCR 0xf0
> irq: irq 16 on host /interrupt-controller0 mapped to virtual irq 17
> time_init: decrementer frequency = 800.000010 MHz
> time_init: processor frequency   = 800.000010 MHz
> clocksource: timebase mult[500000] shift[22] registered
> clockevent: decrementer mult[ccccccf7] shift[32] cpu[0]
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> i2c-core: driver [dummy] registered
> irq: irq 11 on host /interrupt-controller1 mapped to virtual irq 18
> 256k L2-cache enabled
> PCIE0: Checking link...
> PCIE0: No device detected.
> PCI host bridge /plb/pciex@d00000000 (primary) ranges:
>  MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000 
>  MEM 0x0000000f00000000..0x0000000f000fffff -> 0x0000000000000000 
>   IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
>  Removing ISA hole at 0x0000000f00000000
> 4xx PCI DMA offset set to 0x00000000
> /plb/pciex@d00000000: Legacy ISA memory support enabled
> PCIE0: successfully set as root-complex
> PCIE1: Checking link...
> PCIE1: Device detected, waiting for link...
> PCIE1: link is up !
> PCI host bridge /plb/pciex@d20000000 (primary) ranges:
>  MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000 
>  MEM 0x0000000f00100000..0x0000000f001fffff -> 0x0000000000000000 
>   IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
>  Removing ISA hole at 0x0000000f00100000
> 4xx PCI DMA offset set to 0x00000000
> /plb/pciex@d20000000: Legacy ISA memory support enabled
> PCIE1: successfully set as root-complex
> PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
>  MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000 
>  MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000 
>   IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
>  Removing ISA hole at 0x0000000c0ee00000
> 4xx PCI DMA offset set to 0x00000000
> /plb/pci@c0ec00000: Legacy ISA memory support enabled
> PCI: Probing PCI hardware
> pci_bus 0000:40: scanning bus
> pci 0000:40:00.0: found [aaa0:bed0] class 000604 header type 01
> pci 0000:40:00.0: reg 10: [mem 0x00000000-0x7fffffff pref]
> pci_bus 0000:40: fixups for bus
> pci 0000:40:00.0: scanning [bus 41-7f] behind bridge, pass 0
> pci_bus 0000:41: scanning bus
> pci_bus 0000:41: fixups for bus
> pci 0000:40:00.0: PCI bridge to [bus 41-7f]
> pci 0000:40:00.0:   bridge window [io  0x0000-0x0000] (disabled)
> pci 0000:40:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
> pci 0000:40:00.0:   bridge window [mem 0x00000000-0x000fffff pref] (disabled)
> pci_bus 0000:41: bus scan returning with max=41
> pci 0000:40:00.0: scanning [bus 41-7f] behind bridge, pass 1
> pci_bus 0000:40: bus scan returning with max=7f
> pci_bus 0001:80: scanning bus
> pci 0001:80:00.0: found [aaa1:bed1] class 000604 header type 01
> pci 0001:80:00.0: reg 10: [mem 0x00000000-0x7fffffff pref]
> pci_bus 0001:80: fixups for bus
> pci 0001:80:00.0: scanning [bus 81-bf] behind bridge, pass 0
> pci_bus 0001:81: scanning bus
> pci 0001:81:00.0: found [1095:3531] class 000180 header type 00
> pci 0001:81:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
> pci 0001:81:00.0: reg 18: [mem 0x00000000-0x00001fff 64bit]
> pci 0001:81:00.0: reg 20: [io  0x0000-0x007f]
> pci 0001:81:00.0: supports D1 D2
> pci_bus 0001:81: fixups for bus
> pci 0001:80:00.0: PCI bridge to [bus 81-bf]
> pci 0001:80:00.0:   bridge window [io  0x0000-0x0000] (disabled)
> pci 0001:80:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
> pci 0001:80:00.0:   bridge window [mem 0x00000000-0x000fffff pref] (disabled)
> irq: irq 16 on host /interrupt-controller3 mapped to virtual irq 19
> pci_bus 0001:81: bus scan returning with max=81
> pci 0001:80:00.0: scanning [bus 81-bf] behind bridge, pass 1
> pci_bus 0001:80: bus scan returning with max=bf
> pci_bus 0002:00: scanning bus
> pci_bus 0002:00: fixups for bus
> pci_bus 0002:00: bus scan returning with max=00
> pci 0000:40:00.0: BAR 0: can't assign mem pref (size 0x80000000)
> pci 0000:40:00.0: PCI bridge to [bus 41-7f]
> pci 0000:40:00.0:   bridge window [io  disabled]
> pci 0000:40:00.0:   bridge window [mem disabled]
> pci 0000:40:00.0:   bridge window [mem pref disabled]
> pci 0001:80:00.0: BAR 0: can't assign mem pref (size 0x80000000)
> pci 0001:80:00.0: BAR 8: assigned [mem 0xe80000000-0xe800fffff]
> pci 0001:80:00.0: BAR 7: assigned [io  0xfffe1000-0xfffe1fff]
> pci 0001:81:00.0: BAR 2: assigned [mem 0xe80000000-0xe80001fff 64bit]
> pci 0001:81:00.0: BAR 2: set to [mem 0xe80000000-0xe80001fff 64bit] (PCI address [0x80000000-0x80001fff]
> pci 0001:81:00.0: BAR 0: assigned [mem 0xe80002000-0xe8000207f 64bit]
> pci 0001:81:00.0: BAR 0: set to [mem 0xe80002000-0xe8000207f 64bit] (PCI address [0x80002000-0x8000207f]
> pci 0001:81:00.0: BAR 4: assigned [io  0xfffe1000-0xfffe107f]
> pci 0001:81:00.0: BAR 4: set to [io  0xfffe1000-0xfffe107f] (PCI address [0x1000-0x107f]
> pci 0001:80:00.0: PCI bridge to [bus 81-bf]
> pci 0001:80:00.0:   bridge window [io  0xfffe1000-0xfffe1fff]
> pci 0001:80:00.0:   bridge window [mem 0xe80000000-0xe800fffff]
> pci 0001:80:00.0:   bridge window [mem pref disabled]
> pci_bus 0000:40: resource 0 [io  0xfffc0000-0xfffcffff]
> pci_bus 0000:40: resource 1 [mem 0xe00000000-0xe7fffffff]
> pci_bus 0001:80: resource 0 [io  0xfffe0000-0xfffeffff]
> pci_bus 0001:80: resource 1 [mem 0xe80000000-0xeffffffff]
> pci_bus 0001:81: resource 0 [io  0xfffe1000-0xfffe1fff]
> pci_bus 0001:81: resource 1 [mem 0xe80000000-0xe800fffff]
> pci_bus 0002:00: resource 0 [io  0x0000-0xffff]
> pci_bus 0002:00: resource 1 [mem 0xd80000000-0xdffffffff]
> bio: create slab <bio-0> at 0
> i2c-core: driver [pcf857x] registered
> vgaarb: loaded
> SCSI subsystem initialized
> libata version 3.00 loaded.
> Switching to clocksource timebase
> NET: Registered protocol family 2
> IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> TCP reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> Trying to unpack rootfs image as initramfs...
> rootfs image is not initramfs (no cpio magic); looks like an initrd
> Freeing initrd memory: 4034k freed
> irq: irq 1 on host /interrupt-controller1 mapped to virtual irq 20
> irq: irq 1 on host /interrupt-controller0 mapped to virtual irq 21
> irq: irq 29 on host /interrupt-controller0 mapped to virtual irq 29
> irq: irq 6 on host /interrupt-controller2 mapped to virtual irq 22
> irq: irq 7 on host /interrupt-controller2 mapped to virtual irq 23
> irq: irq 3 on host /interrupt-controller2 mapped to virtual irq 24
> irq: irq 4 on host /interrupt-controller2 mapped to virtual irq 25
> irq: irq 5 on host /interrupt-controller2 mapped to virtual irq 26
> irq: irq 29 on host /interrupt-controller2 mapped to virtual irq 27
> irq: irq 30 on host /interrupt-controller2 mapped to virtual irq 28
> irq: irq 28 on host /interrupt-controller2 mapped to virtual irq 31
> irq: irq 26 on host /interrupt-controller1 mapped to virtual irq 32
> irq: irq 12 on host /interrupt-controller0 mapped to virtual irq 33
> irq: irq 0 on host /interrupt-controller3 mapped to virtual irq 34
> irq: irq 5 on host /interrupt-controller3 mapped to virtual irq 35
> irq: irq 6 on host /interrupt-controller1 mapped to virtual irq 36
> irq: irq 2 on host /interrupt-controller0 mapped to virtual irq 37
> irq: irq 3 on host /interrupt-controller0 mapped to virtual irq 38
> irq: irq 16 on host /interrupt-controller2 mapped to virtual irq 39
> irq: irq 20 on host /interrupt-controller2 mapped to virtual irq 40
> irq: irq 17 on host /interrupt-controller2 mapped to virtual irq 41
> irq: irq 21 on host /interrupt-controller2 mapped to virtual irq 42
> msgmni has been set to 1007
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 20) is a U6_16550A
> console [ttyS0] enabled
> serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 21) is a U6_16550A
> 4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 20) is a 16550
> 4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 21) is a 16550
> brd: module loaded
> i2c-core: driver [at24] registered
> sata_sil24 0001:81:00.0: version 1.1
> sata_sil24 0001:81:00.0: enabling device (0000 -> 0003)
> sata_sil24 0001:81:00.0: enabling bus mastering
> scsi0 : sata_sil24
> ata1: SATA max UDMA/100 host m128@0xe80002000 port 0xe80000000 irq 19
> PPC 4xx OCP EMAC driver, version 3.54
> MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
> ZMII /plb/opb/emac-zmii@ef600d00 initialized
> RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
> TAH /plb/opb/emac-tah@ef601350 initialized
> TAH /plb/opb/emac-tah@ef601450 initialized
> /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
> eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:01:02:b9
> eth0: found Generic MII PHY (0x00)
> /plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
> eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:81:02:b9
> eth1: found Generic MII PHY (0x01)
> i2c /dev entries driver
> i2c-core: driver [dev_driver] registered
> of:ibm-iic 4ef600700.i2c: clckdiv = 9
> i2c i2c-0: adapter [IBM IIC] registered
> irq: irq 25 on host /interrupt-controller2 mapped to virtual irq 43
> i2c 0-0068: uevent
> i2c i2c-0: client [m41t80] registered with bus id 0-0068
> irq: irq 20 on host /interrupt-controller1 mapped to virtual irq 44
> i2c 0-0048: uevent
> i2c i2c-0: client [ad7414] registered with bus id 0-0048
> i2c-dev: adapter [IBM IIC] registered as minor 0
> of:ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
> of:ibm-iic 4ef600800.i2c: clckdiv = 9
> i2c i2c-1: adapter [IBM IIC] registered
> i2c-dev: adapter [IBM IIC] registered as minor 1
> of:ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
> Netfilter messages via NETLINK v0.30.
> nf_conntrack version 0.5.0 (8057 buckets, 32228 max)
> ctnetlink v0.93: registering with nfnetlink.
> xt_time: kernel timezone is -0000
> IPVS: Registered protocols ()
> IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
> IPVS: ipvs loaded.
> ip_tables: (C) 2000-2006 Netfilter Core Team
> ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
> arp_tables: (C) 2002 David S. Miller
> TCP cubic registered
> NET: Registered protocol family 17
> Bridge firewalling registered
> Ebtables v2.0 registered
> eth0: link is down
> IP-Config: Complete:
>      device=eth0, addr=169.254.0.180, mask=255.255.255.0, gw=169.254.0.100,
>      host=tanosx, domain=, nis-domain=(none),
>      bootserver=169.254.0.100, rootserver=169.254.0.100, rootpath=
> ata1: SATA link down (SStatus 0 SControl 0)
> RAMDISK: gzip image found at block 0
> eth0: link is up, 100 FDX, pause enabled
> VFS: Mounted root (ext2 filesystem) on device 1:0.
> Freeing unused kernel memory: 184k init
> 
> 
> /proc/iomem
> 
> 4ef600300-4ef600307 : serial
> 4ef600400-4ef600407 : serial
> d80000000-dffffffff : /plb/pci@c0ec00000
> e00000000-e7fffffff : /plb/pciex@d00000000
> e80000000-effffffff : /plb/pciex@d20000000
>   e80000000-e800fffff : PCI Bus 0001:81
>     e80000000-e80001fff : 0001:81:00.0
>       e80000000-e80001fff : sata_sil24
>     e80002000-e8000207f : 0001:81:00.0
>       e80002000-e8000207f : sata_sil24
> 
> 
> /proc/ioports
> 
> 00000000-0000ffff : /plb/pci@c0ec00000
>   00000000-00000fff : Legacy IO
> fffc0000-fffcffff : /plb/pciex@d00000000
>   fffc0000-fffc0fff : Legacy IO
> fffe0000-fffeffff : /plb/pciex@d20000000
>   fffe0000-fffe0fff : Legacy IO
>   fffe1000-fffe1fff : PCI Bus 0001:81
>     fffe1000-fffe107f : 0001:81:00.0
> 
> 
> 
> ============== Failing ======================
> 
> 
> Using PowerPC 44x Platform machine description
> Linux version 2.6.36-rc3-00186-g0e52247 (aymane@lablinux) (gcc version 4.2.2) #19 Mon Jun 27 06:09:26 CDT 2011
> Found initrd at 0xdfa5c000:0xdfe4cbfa
> Found legacy serial port 0 for /plb/opb/serial@ef600300
>   mem=4ef600300, taddr=4ef600300, irq=0, clk=6451612, speed=0
> Found legacy serial port 1 for /plb/opb/serial@ef600400
>   mem=4ef600400, taddr=4ef600400, irq=0, clk=6451612, speed=0
> Top of RAM: 0x20000000, Total RAM: 0x20000000
> Memory hole size: 0MB
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00020000
>   Normal   empty
>   HighMem  empty
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00000000 -> 0x00020000
> On node 0 totalpages: 131072
> free_area_init_node: node 0, pgdat c03b9f48, node_mem_map c03ed000
>   DMA zone: 1024 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 130048 pages, LIFO batch:31
> MMU: Allocated 1088 bytes of context maps for 255 contexts
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
> Kernel command line: root=/dev/ram rw mem=512M ip=169.254.0.180:169.254.0.100:169.254.0.100:255.255.255.0:tanosx:eth0:off panic=1 console=ttyS0,57600
> PID hash table entries: 2048 (order: 1, 8192 bytes)
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> High memory: 0k
> Memory: 511668k/524288k available (3692k kernel code, 12620k reserved, 176k data, 141k bss, 184k init)
> Kernel virtual memory layout:
>   * 0xfffcf000..0xfffff000  : fixmap
>   * 0xffc00000..0xffe00000  : highmem PTEs
>   * 0xffa00000..0xffc00000  : consistent mem
>   * 0xffa00000..0xffa00000  : early ioremap
>   * 0xe1000000..0xffa00000  : vmalloc & ioremap
> SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> NR_IRQS:512
> UIC0 (32 IRQ sources) at DCR 0xc0
> UIC1 (32 IRQ sources) at DCR 0xd0
> irq: irq 30 on host /interrupt-controller0 mapped to virtual irq 30
> UIC2 (32 IRQ sources) at DCR 0xe0
> irq: irq 10 on host /interrupt-controller0 mapped to virtual irq 16
> UIC3 (32 IRQ sources) at DCR 0xf0
> irq: irq 16 on host /interrupt-controller0 mapped to virtual irq 17
> time_init: decrementer frequency = 800.000010 MHz
> time_init: processor frequency   = 800.000010 MHz
> clocksource: timebase mult[500000] shift[22] registered
> clockevent: decrementer mult[ccccccf7] shift[32] cpu[0]
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> i2c-core: driver [dummy] registered
> irq: irq 11 on host /interrupt-controller1 mapped to virtual irq 18
> 256k L2-cache enabled
> PCIE0: Checking link...
> PCIE0: No device detected.
> PCI host bridge /plb/pciex@d00000000 (primary) ranges:
>  MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000 
>  MEM 0x0000000f00000000..0x0000000f000fffff -> 0x0000000000000000 
>   IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
>  Removing ISA hole at 0x0000000f00000000
> 4xx PCI DMA offset set to 0x00000000
> /plb/pciex@d00000000: Legacy ISA memory support enabled
> PCIE0: successfully set as root-complex
> PCIE1: Checking link...
> PCIE1: Device detected, waiting for link...
> PCIE1: link is up !
> PCI host bridge /plb/pciex@d20000000 (primary) ranges:
>  MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000 
>  MEM 0x0000000f00100000..0x0000000f001fffff -> 0x0000000000000000 
>   IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
>  Removing ISA hole at 0x0000000f00100000
> 4xx PCI DMA offset set to 0x00000000
> /plb/pciex@d20000000: Legacy ISA memory support enabled
> PCIE1: successfully set as root-complex
> PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
>  MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000 
>  MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000 
>   IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
>  Removing ISA hole at 0x0000000c0ee00000
> 4xx PCI DMA offset set to 0x00000000
> /plb/pci@c0ec00000: Legacy ISA memory support enabled
> PCI: Probing PCI hardware
> pci_bus 0000:40: scanning bus
> pci 0000:40:00.0: found [aaa0:bed0] class 000604 header type 01
> pci 0000:40:00.0: reg 10: [mem 0x00000000-0x7fffffff pref]
> pci_bus 0000:40: fixups for bus
> pci 0000:40:00.0: scanning [bus 41-7f] behind bridge, pass 0
> pci_bus 0000:41: scanning bus
> pci_bus 0000:41: fixups for bus
> pci 0000:40:00.0: PCI bridge to [bus 41-7f]
> pci 0000:40:00.0:   bridge window [io  0x0000-0x0000] (disabled)
> pci 0000:40:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
> pci 0000:40:00.0:   bridge window [mem 0x00000000-0x000fffff pref] (disabled)
> pci_bus 0000:41: bus scan returning with max=41
> pci 0000:40:00.0: scanning [bus 41-7f] behind bridge, pass 1
> pci_bus 0000:40: bus scan returning with max=7f
> pci_bus 0001:80: scanning bus
> pci 0001:80:00.0: found [aaa1:bed1] class 000604 header type 01
> pci 0001:80:00.0: reg 10: [mem 0x00000000-0x7fffffff pref]
> pci_bus 0001:80: fixups for bus
> pci 0001:80:00.0: scanning [bus 81-bf] behind bridge, pass 0
> pci_bus 0001:81: scanning bus
> pci 0001:81:00.0: found [1095:3531] class 000180 header type 00
> pci 0001:81:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
> pci 0001:81:00.0: reg 18: [mem 0x00000000-0x00001fff 64bit]
> pci 0001:81:00.0: reg 20: [io  0x0000-0x007f]
> pci 0001:81:00.0: supports D1 D2
> pci_bus 0001:81: fixups for bus
> pci 0001:80:00.0: PCI bridge to [bus 81-bf]
> pci 0001:80:00.0:   bridge window [io  0x0000-0x0000] (disabled)
> pci 0001:80:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
> pci 0001:80:00.0:   bridge window [mem 0x00000000-0x000fffff pref] (disabled)
> irq: irq 16 on host /interrupt-controller3 mapped to virtual irq 19
> pci_bus 0001:81: bus scan returning with max=81
> pci 0001:80:00.0: scanning [bus 81-bf] behind bridge, pass 1
> pci_bus 0001:80: bus scan returning with max=bf
> pci_bus 0002:00: scanning bus
> pci_bus 0002:00: fixups for bus
> pci_bus 0002:00: bus scan returning with max=00
> pci 0000:40:00.0: BAR 0: assigned [mem 0xe00000000-0xe7fffffff pref]
> pci 0000:40:00.0: BAR 0: set to [mem 0xe00000000-0xe7fffffff pref] (PCI address [0x80000000-0xffffffff]
> pci 0000:40:00.0: PCI bridge to [bus 41-7f]
> pci 0000:40:00.0:   bridge window [io  disabled]
> pci 0000:40:00.0:   bridge window [mem disabled]
> pci 0000:40:00.0:   bridge window [mem pref disabled]
> pci 0001:80:00.0: BAR 0: assigned [mem 0xe80000000-0xeffffffff pref]
> pci 0001:80:00.0: BAR 0: set to [mem 0xe80000000-0xeffffffff pref] (PCI address [0x80000000-0xffffffff]
> pci 0001:80:00.0: BAR 8: can't assign mem (size 0x100000)
> pci 0001:80:00.0: BAR 7: assigned [io  0xfffe1000-0xfffe1fff]
> pci 0001:81:00.0: BAR 2: can't assign mem (size 0x2000)
> pci 0001:81:00.0: BAR 0: can't assign mem (size 0x80)
> pci 0001:81:00.0: BAR 4: assigned [io  0xfffe1000-0xfffe107f]
> pci 0001:81:00.0: BAR 4: set to [io  0xfffe1000-0xfffe107f] (PCI address [0x1000-0x107f]
> pci 0001:80:00.0: PCI bridge to [bus 81-bf]
> pci 0001:80:00.0:   bridge window [io  0xfffe1000-0xfffe1fff]
> pci 0001:80:00.0:   bridge window [mem disabled]
> pci 0001:80:00.0:   bridge window [mem pref disabled]
> pci_bus 0000:40: resource 0 [io  0xfffc0000-0xfffcffff]
> pci_bus 0000:40: resource 1 [mem 0xe00000000-0xe7fffffff]
> pci_bus 0001:80: resource 0 [io  0xfffe0000-0xfffeffff]
> pci_bus 0001:80: resource 1 [mem 0xe80000000-0xeffffffff]
> pci_bus 0001:81: resource 0 [io  0xfffe1000-0xfffe1fff]
> pci_bus 0002:00: resource 0 [io  0x0000-0xffff]
> pci_bus 0002:00: resource 1 [mem 0xd80000000-0xdffffffff]
> bio: create slab <bio-0> at 0
> i2c-core: driver [pcf857x] registered
> vgaarb: loaded
> SCSI subsystem initialized
> libata version 3.00 loaded.
> Switching to clocksource timebase
> NET: Registered protocol family 2
> IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> TCP established hash table entries: 16384 (order: 5, 131072 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> TCP reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> Trying to unpack rootfs image as initramfs...
> rootfs image is not initramfs (no cpio magic); looks like an initrd
> Freeing initrd memory: 4034k freed
> irq: irq 1 on host /interrupt-controller1 mapped to virtual irq 20
> irq: irq 1 on host /interrupt-controller0 mapped to virtual irq 21
> irq: irq 29 on host /interrupt-controller0 mapped to virtual irq 29
> irq: irq 6 on host /interrupt-controller2 mapped to virtual irq 22
> irq: irq 7 on host /interrupt-controller2 mapped to virtual irq 23
> irq: irq 3 on host /interrupt-controller2 mapped to virtual irq 24
> irq: irq 4 on host /interrupt-controller2 mapped to virtual irq 25
> irq: irq 5 on host /interrupt-controller2 mapped to virtual irq 26
> irq: irq 29 on host /interrupt-controller2 mapped to virtual irq 27
> irq: irq 30 on host /interrupt-controller2 mapped to virtual irq 28
> irq: irq 28 on host /interrupt-controller2 mapped to virtual irq 31
> irq: irq 26 on host /interrupt-controller1 mapped to virtual irq 32
> irq: irq 12 on host /interrupt-controller0 mapped to virtual irq 33
> irq: irq 0 on host /interrupt-controller3 mapped to virtual irq 34
> irq: irq 5 on host /interrupt-controller3 mapped to virtual irq 35
> irq: irq 6 on host /interrupt-controller1 mapped to virtual irq 36
> irq: irq 2 on host /interrupt-controller0 mapped to virtual irq 37
> irq: irq 3 on host /interrupt-controller0 mapped to virtual irq 38
> irq: irq 16 on host /interrupt-controller2 mapped to virtual irq 39
> irq: irq 20 on host /interrupt-controller2 mapped to virtual irq 40
> irq: irq 17 on host /interrupt-controller2 mapped to virtual irq 41
> irq: irq 21 on host /interrupt-controller2 mapped to virtual irq 42
> msgmni has been set to 1007
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 20) is a U6_16550A
> console [ttyS0] enabled
> serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 21) is a U6_16550A
> 4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 20) is a 16550
> 4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 21) is a 16550
> brd: module loaded
> i2c-core: driver [at24] registered
> sata_sil24 0001:81:00.0: version 1.1
> sata_sil24 0001:81:00.0: enabling device (0000 -> 0001)
> sata_sil24: probe of 0001:81:00.0 failed with error -22
> PPC 4xx OCP EMAC driver, version 3.54
> MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
> ZMII /plb/opb/emac-zmii@ef600d00 initialized
> RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
> TAH /plb/opb/emac-tah@ef601350 initialized
> TAH /plb/opb/emac-tah@ef601450 initialized
> /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
> eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:01:02:b9
> eth0: found Generic MII PHY (0x00)
> /plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
> eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:81:02:b9
> eth1: found Generic MII PHY (0x01)
> i2c /dev entries driver
> i2c-core: driver [dev_driver] registered
> of:ibm-iic 4ef600700.i2c: clckdiv = 9
> i2c i2c-0: adapter [IBM IIC] registered
> irq: irq 25 on host /interrupt-controller2 mapped to virtual irq 43
> i2c 0-0068: uevent
> i2c i2c-0: client [m41t80] registered with bus id 0-0068
> irq: irq 20 on host /interrupt-controller1 mapped to virtual irq 44
> i2c 0-0048: uevent
> i2c i2c-0: client [ad7414] registered with bus id 0-0048
> i2c-dev: adapter [IBM IIC] registered as minor 0
> of:ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
> of:ibm-iic 4ef600800.i2c: clckdiv = 9
> i2c i2c-1: adapter [IBM IIC] registered
> i2c-dev: adapter [IBM IIC] registered as minor 1
> of:ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
> Netfilter messages via NETLINK v0.30.
> nf_conntrack version 0.5.0 (8057 buckets, 32228 max)
> ctnetlink v0.93: registering with nfnetlink.
> xt_time: kernel timezone is -0000
> IPVS: Registered protocols ()
> IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
> IPVS: ipvs loaded.
> ip_tables: (C) 2000-2006 Netfilter Core Team
> ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
> arp_tables: (C) 2002 David S. Miller
> TCP cubic registered
> NET: Registered protocol family 17
> Bridge firewalling registered
> Ebtables v2.0 registered
> eth0: link is down
> IP-Config: Complete:
>      device=eth0, addr=169.254.0.180, mask=255.255.255.0, gw=169.254.0.100,
>      host=tanosx, domain=, nis-domain=(none),
>      bootserver=169.254.0.100, rootserver=169.254.0.100, rootpath=
> RAMDISK: gzip image found at block 0
> eth0: link is up, 100 FDX, pause enabled
> VFS: Mounted root (ext2 filesystem) on device 1:0.
> Freeing unused kernel memory: 184k init
> 
> /proc/iomem
> 
> 4ef600300-4ef600307 : serial
> 4ef600400-4ef600407 : serial
> d80000000-dffffffff : /plb/pci@c0ec00000
> e00000000-e7fffffff : /plb/pciex@d00000000
>   e00000000-e7fffffff : 0000:40:00.0
> e80000000-effffffff : /plb/pciex@d20000000
>   e80000000-effffffff : 0001:80:00.0
> 
> /proc/ioports
> 
> 00000000-0000ffff : /plb/pci@c0ec00000
>   00000000-00000fff : Legacy IO
> fffc0000-fffcffff : /plb/pciex@d00000000
>   fffc0000-fffc0fff : Legacy IO
> fffe0000-fffeffff : /plb/pciex@d20000000
>   fffe0000-fffe0fff : Legacy IO
>   fffe1000-fffe1fff : PCI Bus 0001:81
>     fffe1000-fffe107f : 0001:81:00.0
