Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB00EB7CFC
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Mar 2010 20:13:33 +1100 (EST)
Message-ID: <4BAF1DC2.2080600@embedded-sol.com>
Date: Sun, 28 Mar 2010 12:13:38 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>	<4B9A07D2.4060801@jp.fujitsu.com>	<4B9AC885.3010107@embedded-sol.com>
	<4B9DC820.2060100@jp.fujitsu.com>
	<4B9DCF01.4050709@embedded-sol.com>
	<4B9DF72F.3040105@jp.fujitsu.com>
	<4B9E18A7.2080605@embedded-sol.com>
	<4B9F19E2.2090709@jp.fujitsu.com>
	<4B9FFAD1.8030309@embedded-sol.com>
	<4BA02A49.9050101@jp.fujitsu.com>
In-Reply-To: <4BA02A49.9050101@jp.fujitsu.com>
Content-Type: multipart/mixed; boundary="------------040602080003050702020203"
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, Alex Chiang <achiang@hp.com>,
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
--------------040602080003050702020203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Kenji-san

Kenji Kaneshige wrote:
> Felix Radensky wrote:
>> Hello, Kenji-san
>>
>> Kenji Kaneshige wrote:
>>>
>>> I misunderstood the problem.
>>> My understanding was memory resource was not enabled even though 
>>> Linux set
>>> the Memory Space bit in the command register. But it was not 
>>> correct. The
>>> bridge memory window was marked unused and Linux didn't try to set 
>>> Memory
>>> Space bit in the command register. Current my understanding is as 
>>> follows.
>>> Please correct me if I'm still misunderstanding something.
>>>
>>> 1) Your BIOS doesn't assign any resource to the bridge if its child PCI
>>>   hot-plug slot is not occupied.
>>>
>>> 2) At the boot time, pci_assign_unassigned_resources() try to assign
>>>   memory resouces to the bridge using pci_bus_assign_resource(), but
>>>   it was disabled because there are no devices require memory resource.
>>>
>>> 3) And then pci_assign_unassigned_resouces() calls pci_enable_bridge(),
>>>   but Memory Space bit in the command register was not set because no
>>>   memory resource are assigned to the bridge. At the same time,
>>>   pci_dev->enable_cnt was incremented.
>>>
>>> 4) At the rescan time, pci_setup_bridge() and pci_enable_bridge() 
>>> doesn't
>>>   work because the bridge is already marked "enabled" (i.e.
>>>   pci_dev->enable_cnt is not zero).
>>>
>>> I don't have any concrete idea how to fix that so far, but I can say 
>>> my idea
>>> (pcibios_enable_device() should return an error) was wrong.
>>>
>>>
>> I was wandering if setting is_hotplug_bridge property for this bridge 
>> (e.g. via
>> header quirk) can be an acceptable solution. This will allow passing 
>> hpmemsize
>> kernel parameter, to specify the amount of memory to assign to the 
>> bridge.
>> I've tested this approach and it seems to work.
>
> Looks good to me.
>
> By the way, I think Yinghai's bridge resource reallocation patch series
> might help you. It is in Jesse's PCI tree. Please take a look.
>
> Thanks,
> Kenji Kaneshige
>
I've tried Jesse's tree with Yinghai's patches, but they don't seem to help.
Memory for bridge is not allocated after insertion of hotplug device and
bus rescan. Attached dmesg output in case of success and failure.

Thanks.

Felix.

--------------040602080003050702020203
Content-Type: text/plain;
 name="success.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="success.txt"

Linux version 2.6.33 (felix@felix-laptop.lan) (gcc version 4.2.2) #8 Sun Mar 28 12:04:25 IDT 2010
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
free_area_init_node: node 0, pgdat c02a84d0, node_mem_map c02e1000
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 195072 pages, LIFO batch:31
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 195072
Kernel command line: root=/dev/nfs rw nfsroot=10.0.0.10:/opt/eldk/ppc_4xxFP ip=10.0.0.30:10.0.0.10:10.0.0.138:255.0.0.0:smbe460:eth0:off panic=1 console=ttyS0,115200
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 776500k/786432k available (2656k kernel code, 9932k reserved, 100k data, 184k bss, 132k init)
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
pci 0000:01:00.0: reg 10: [mem 0x80000000-0x800fffff]
pci 0000:01:00.0: reg 14: [mem 0x84000000-0x87ffffff]
pci 0000:01:00.0: reg 18: [mem 0x88000000-0x8bffffff]
pci 0000:01:00.0: reg 1c: [mem 0x8c000000-0x8c003fff]
pci 0000:01:00.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:01:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:01:00.0: calling quirk_resource_alignment+0x0/0x200
pci_bus 0000:01: fixups for bus
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci 0000:00:02.0:   bridge window [io  1000 - 0000] reg reading
pci 0000:00:02.0:   bridge window [mem 0x80000000-0x8c0fffff]
pci 0000:00:02.0:   bridge window [mem 0x10000000 - 000fffff pref] reg reading
pci_bus 0000:01: bus scan returning with max=01
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 1
pci_bus 0000:00: bus scan returning with max=01
PCI: max bus depth: 1 pci_try_num: 2
pci 0000:00:02.0: BAR 8: assigned [mem 0xd80000000-0xd8dffffff]
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
pci 0000:00:02.0:   bridge window [mem 0xd80000000-0xd8dffffff]
pci 0000:00:02.0:   bridge window [mem pref disabled]
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0xd80000000-0xdffffffff]
pci_bus 0000:01: resource 1 [mem 0xd80000000-0xd8dffffff]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
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
pci 0000:00:02.0: calling quirk_usb_early_handoff+0x0/0x6d0
pci 0000:01:00.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x6d0
PCI: CLS 32 bytes, default 32
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
msgmni has been set to 1516
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
TCP cubic registered
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
eth0: link is down
IP-Config: Complete:
     device=eth0, addr=10.0.0.30, mask=255.0.0.0, gw=10.0.0.138,
     host=smbe460, domain=, nis-domain=(none),
     bootserver=10.0.0.10, rootserver=10.0.0.10, rootpath=
Looking up port of RPC 100003/2 on 10.0.0.10
eth0: link is up, 100 FDX, pause enabled
Looking up port of RPC 100005/1 on 10.0.0.10
VFS: Mounted root (nfs filesystem) on device 0:11.
Freeing unused kernel memory: 132k init

--------------040602080003050702020203
Content-Type: text/plain;
 name="failure.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="failure.txt"

Linux version 2.6.33 (felix@felix-laptop.lan) (gcc version 4.2.2) #8 Sun Mar 28 12:04:25 IDT 2010
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
free_area_init_node: node 0, pgdat c02a84d0, node_mem_map c02e1000
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 195072 pages, LIFO batch:31
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 195072
Kernel command line: root=/dev/nfs rw nfsroot=10.0.0.10:/opt/eldk/ppc_4xxFP ip=10.0.0.30:10.0.0.10:10.0.0.138:255.0.0.0:smbe460:eth0:off panic=1 console=ttyS0,115200
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 776500k/786432k available (2656k kernel code, 9932k reserved, 100k data, 184k bss, 132k init)
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
pci_bus 0000:01: fixups for bus
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci 0000:00:02.0:   bridge window [io  1000 - 0000] reg reading
pci 0000:00:02.0:   bridge window [mem 0x80000000 - 0x7fffffff] reg reading
pci 0000:00:02.0:   bridge window [mem 0x10000000 - 000fffff pref] reg reading
pci_bus 0000:01: bus scan returning with max=01
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 1
pci_bus 0000:00: bus scan returning with max=01
PCI: max bus depth: 1 pci_try_num: 2
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci 0000:00:02.0:   bridge window [io  disabled]
pci 0000:00:02.0:   bridge window [mem disabled]
pci 0000:00:02.0:   bridge window [mem pref disabled]
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0xd80000000-0xdffffffff]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
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
pci 0000:00:02.0: calling quirk_usb_early_handoff+0x0/0x6d0
PCI: CLS 32 bytes, default 32
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
msgmni has been set to 1516
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
TCP cubic registered
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
eth0: link is down
IP-Config: Complete:
     device=eth0, addr=10.0.0.30, mask=255.0.0.0, gw=10.0.0.138,
     host=smbe460, domain=, nis-domain=(none),
     bootserver=10.0.0.10, rootserver=10.0.0.10, rootpath=
Looking up port of RPC 100003/2 on 10.0.0.10
eth0: link is up, 100 FDX, pause enabled
Looking up port of RPC 100005/1 on 10.0.0.10
VFS: Mounted root (nfs filesystem) on device 0:11.
Freeing unused kernel memory: 132k init
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
pci 0000:00:02.0: BAR 8: assigned [mem 0xd80000000-0xd89ffffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0xd80000000-0xd83ffffff]
pci 0000:01:00.0: BAR 1: set to [mem 0xd80000000-0xd83ffffff] (PCI address [0x80000000-0x83ffffff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xd84000000-0xd87ffffff]
pci 0000:01:00.0: BAR 2: set to [mem 0xd84000000-0xd87ffffff] (PCI address [0x84000000-0x87ffffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xd88000000-0xd880fffff]
pci 0000:01:00.0: BAR 0: set to [mem 0xd88000000-0xd880fffff] (PCI address [0x88000000-0x880fffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xd88100000-0xd88103fff]
pci 0000:01:00.0: BAR 3: set to [mem 0xd88100000-0xd88103fff] (PCI address [0x88100000-0x88103fff]

--------------040602080003050702020203--
