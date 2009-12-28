Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55522B6F17
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Dec 2009 21:51:06 +1100 (EST)
Message-ID: <4B388D9D.7010404@embedded-sol.com>
Date: Mon, 28 Dec 2009 12:51:09 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Stefan Roese <sr@denx.de>
Subject: PCI-PCI bridge scanning broken on 460EX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm running linux-2.6.33-rc2 on Canyonlands board. When PLX 6254 
transparent PCI-PCI
bridge is plugged into PCI slot the kernel simply resets the board 
without printing anything
to console. Without PLX bridge kernel boots fine.

I've tracked down the problem to the following code in pci_scan_bridge() 
in drivers/pci/probe.c:

if (pcibios_assign_all_busses() || broken)
                /* Temporarily disable forwarding of the
                   configuration cycles on all bridges in
                   this bus segment to avoid possible
                   conflicts in the second pass between two
                   bridges programmed with overlapping
                   bus ranges. */
                pci_write_config_dword(dev, PCI_PRIMARY_BUS,
                               buses & ~0xffffff);

If test for broken is removed, kernel boots fine, detects the bridge, but
does not detect the device behind the bridge. The same device plugged
directly into PCI slot is detected correctly.

To remind you, tests for broken were added by commit 
a1c19894b786f10c76ac40e93c6b5d70c9b946d2,
and were intended to solve device detection problem behind PCI-E 
switches, as discussed in this thread:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2008-October/063939.html

I'd appreciate any help in resolving this issue. Below is dmesg output 
with DEBUG enabled
and problematic test for broken removed.

Using PowerPC 44x Platform machine description
Linux version 2.6.33-rc2 (felix@felix-laptop.lan) (gcc version 4.2.2) 
#10 Mon De
c 28 12:21:25 IST 2009
Found legacy serial port 0 for /plb/opb/serial@ef600300
  mem=4ef600300, taddr=4ef600300, irq=0, clk=7407407, speed=0
Found legacy serial port 1 for /plb/opb/serial@ef600400
  mem=4ef600400, taddr=4ef600400, irq=0, clk=7407407, speed=0
Found legacy serial port 2 for /plb/opb/serial@ef600500
  mem=4ef600500, taddr=4ef600500, irq=0, clk=7407407, speed=0
Found legacy serial port 3 for /plb/opb/serial@ef600600
  mem=4ef600600, taddr=4ef600600, irq=0, clk=7407407, speed=0
Top of RAM: 0x20000000, Total RAM: 0x20000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00020000
  Normal   0x00020000 -> 0x00020000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00020000
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat c026ba48, node_mem_map c0289000
  DMA zone: 1024 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 130048 pages, LIFO batch:31
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/nfs rw 
nfsroot=10.0.0.10:/opt/eldk/ppc_4xx ip=10.
0.0.30:10.0.0.10::255.0.0.0:canyonlands:eth0:off panic=1 
console=ttyS0,115200 de
bug
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 516864k/524288k available (2416k kernel code, 7140k reserved, 
100k data,
 72k bss, 128k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfde00000..0xfe000000  : consistent mem
  * 0xfde00000..0xfde00000  : early ioremap
  * 0xe1000000..0xfde00000  : vmalloc & ioremap
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
time_init: decrementer frequency = 600.000007 MHz
time_init: processor frequency   = 600.000007 MHz
clocksource: timebase mult[6aaaab] shift[22] registered
clockevent: decrementer mult[999999b7] shift[32] cpu[0]
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
pci 0000:00:06.0: found [3388:0020] class 000604 header type 01
pci 0000:00:06.0: supports D1 D2
pci 0000:00:06.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:06.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci 0000:00:06.0: scanning behind bridge, config 000000, pass 0
pci 0000:00:06.0: bus configuration invalid, reconfiguring
pci 0000:00:06.0: scanning behind bridge, config 000000, pass 1
pci_bus 0000:01: scanning bus
pci 0000:01:06.0: found [3388:0020] class 000604 header type 01
pci 0000:01:06.0: supports D1 D2
pci 0000:01:06.0: PME# supported from D0 D1 D2 D3hot
pci 0000:01:06.0: PME# disabled
pci_bus 0000:01: fixups for bus
pci 0000:00:06.0: PCI bridge to [bus 01-ff]
pci 0000:00:06.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:06.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:06.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:01:06.0: scanning behind bridge, config ff0100, pass 0
pci 0000:01:06.0: bus configuration invalid, reconfiguring
pci 0000:01:06.0: scanning behind bridge, config ff0100, pass 1
pci_bus 0000:01: bus scan returning with max=01
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:06.0: disabling bridge window [io  0x0000-0x0fff] to [bus 
01-01] (un
used)
pci 0000:00:06.0: disabling bridge window [mem 0xd00000000-0xd000fffff 
pref] to
[bus 01-01] (unused)
pci 0000:00:06.0: disabling bridge window [mem 0xd00000000-0xd000fffff] 
to [bus
01-01] (unused)
pci 0000:00:06.0: PCI bridge to [bus 01-01]
pci 0000:00:06.0:   bridge window [io  disabled]
pci 0000:00:06.0:   bridge window [mem disabled]
pci 0000:00:06.0:   bridge window [mem pref disabled]
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0xd80000000-0xdffffffff]
pci_bus 0000:01: resource 0 [??? 0-4095 flags 0x0]
pci_bus 0000:01: resource 1 [??? 55834574848-55835623423 flags 0x0]
pci_bus 0000:01: resource 2 [??? 55834574848-55835623423 flags 0x0]

Thanks a lot.

Felix.
