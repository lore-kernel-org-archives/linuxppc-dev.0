Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14552B7129
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2011 05:47:22 +1100 (EST)
Message-ID: <4D6BEDCE.3020102@embedded-sol.com>
Date: Mon, 28 Feb 2011 20:47:42 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
Content-Type: multipart/mixed; boundary="------------080503000205000504030409"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080503000205000504030409
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <br>
    Hi Ira,<br>
    <br>
    Attached dmesg output.<br>
    <br>
    Felix.<br>
    <br>
    -------- Original Message --------
    <table class="moz-email-headers-table" border="0" cellpadding="0"
      cellspacing="0">
      <tbody>
        <tr>
          <th nowrap="nowrap" valign="BASELINE" align="RIGHT">Subject: </th>
          <td>Re: [PATCH 0/8] fsldma: lockup fixes</td>
        </tr>
        <tr>
          <th nowrap="nowrap" valign="BASELINE" align="RIGHT">Date: </th>
          <td>Mon, 28 Feb 2011 09:16:24 -0800</td>
        </tr>
        <tr>
          <th nowrap="nowrap" valign="BASELINE" align="RIGHT">From: </th>
          <td>Ira W. Snyder <a class="moz-txt-link-rfc2396E" href="mailto:iws@ovro.caltech.edu">&lt;iws@ovro.caltech.edu&gt;</a></td>
        </tr>
        <tr>
          <th nowrap="nowrap" valign="BASELINE" align="RIGHT">To: </th>
          <td>Felix Radensky <a class="moz-txt-link-rfc2396E" href="mailto:felix@embedded-sol.com">&lt;felix@embedded-sol.com&gt;</a></td>
        </tr>
        <tr>
          <th nowrap="nowrap" valign="BASELINE" align="RIGHT">CC: </th>
          <td><a class="moz-txt-link-abbreviated" href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:linuxppc-dev@ozlabs.org">&lt;linuxppc-dev@ozlabs.org&gt;</a></td>
        </tr>
      </tbody>
    </table>
    <br>
    <br>
    <pre>On Mon, Feb 28, 2011 at 01:36:38PM +0200, Felix Radensky wrote:
&gt; Hi Ira,
&gt; 
&gt; I've tried your patches with linux-2.6.38-rc6 on P2020RDB.
&gt; DMA test fails with the following errors if threads_per_chan != 1
&gt; 
&gt; dma0chan0-copy1: terminating after 1 tests, 1 failures (status 0)
&gt; dma0chan0-copy2: #0: test timed out
&gt; 
&gt; I've run the test like this:
&gt; 
&gt; modprobe dmatest threads_per_chan=2 iterations=1
&gt; 

Thanks Felix. This works fine on the 83xx DMA controller. When you have
a chance, can you add "#define DEBUG 1" as the first line of
drivers/dma/fsldma.c and then rerun your test with:

modprobe dmatest threads_per_chan=2 iterations=1 max_channels=1

And send me the dmesg output.

I don't quite understand the difference between links and lists in the
85xx controller yet. I'll work my way through the datasheet this morning
and send out a fixed patch.

Thanks very much for running the tests!

Ira
</pre>
  </body>
</html>

--------------080503000205000504030409
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

Using P2020 RDB machine description
Memory CAM mapping: 256/256/256 Mb, residual: 256Mb
Linux version 2.6.38-rc6 (felix@felix.lan) (gcc version 4.2.2) #6 Mon Feb 28 20:40:18 IST 2011
Found legacy serial port 0 for /soc@ffe00000/serial@4500
  mem=ffe04500, taddr=ffe04500, irq=0, clk=600000000, speed=0
Found legacy serial port 1 for /soc@ffe00000/serial@4600
  mem=ffe04600, taddr=ffe04600, irq=0, clk=600000000, speed=0
bootconsole [udbg0] enabled
Found FSL PCI host bridge at 0x00000000ffe09000. Firmware bus number: 0->255
PCI host bridge /pcie@ffe09000  ranges:
 MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000a0000000 
  IO 0x00000000ffc30000..0x00000000ffc3ffff -> 0x0000000000000000
/pcie@ffe09000: PCICSRBAR @ 0xfff00000
Found FSL PCI host bridge at 0x00000000ffe0a000. Firmware bus number: 0->0
PCI host bridge /pcie@ffe0a000  ranges:
 MEM 0x00000000c0000000..0x00000000dfffffff -> 0x00000000c0000000 
  IO 0x00000000ffc20000..0x00000000ffc2ffff -> 0x0000000000000000
/pcie@ffe0a000: PCICSRBAR @ 0xfff00000
MPC85xx RDB board from Freescale Semiconductor
Top of RAM: 0x40000000, Total RAM: 0x40000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00030000
  Normal   empty
  HighMem  0x00030000 -> 0x00040000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00040000
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c02ecfcc, node_mem_map c030e000
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 195072 pages, LIFO batch:31
  HighMem zone: 512 pages used for memmap
  HighMem zone: 65024 pages, LIFO batch:15
MMU: Allocated 1088 bytes of context maps for 255 contexts
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: root=/dev/nfs rw nfsroot=10.0.0.10:/opt/eldk/4.2/ppc_85xxDP ip=10.0.0.30:10.0.0.10::255.0.0.0:P2020RDB:eth0:off console=ttyS0,115200 ramdisk_size=700000 cache-sram-size=0x10000
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
High memory: 262140k
Memory: 1036340k/1048576k available (2928k kernel code, 12236k reserved, 104k data, 83k bss, 136k init)
Kernel virtual memory layout:
  * 0xfffcf000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xffbda000..0xffc00000  : early ioremap
  * 0xf1000000..0xffbda000  : vmalloc & ioremap
SLUB: Genslabs=15, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:512 nr_irqs:512 16
mpic: Setting up MPIC " OpenPIC  " version 1.2 at ffe40000, max 2 CPUs
mpic: ISU size: 256, shift: 8, mask: ff
mpic: Initializing for 256 sources
time_init: decrementer frequency = 75.000000 MHz
time_init: processor frequency   = 1200.000000 MHz
clocksource: timebase mult[3555555] shift[22] registered
clockevent: decrementer mult[13333333] shift[32] cpu[0]
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
pci 0000:00:00.0: [1957:0070] type 1 class 0x000b20
pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x0000-0x0000] (disabled)
pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref] (disabled)
pci 0001:02:00.0: [1957:0070] type 1 class 0x000b20
pci 0001:02:00.0: ignoring class b20 (doesn't match header type 01)
pci 0001:02:00.0: supports D1 D2
pci 0001:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:02:00.0: PME# disabled
pci 0001:02:00.0: PCI bridge to [bus 03-ff]
pci 0001:02:00.0:   bridge window [io  0x0000-0x0000] (disabled)
pci 0001:02:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
pci 0001:02:00.0:   bridge window [mem 0x00000000-0x000fffff pref] (disabled)
pcibios_allocate_bus_resources: i=0 flags 0x100 start 0xef050d7c end 0x0
pcibios_allocate_bus_resources: i=1 flags 0x200 start 0x4000 end 0x0
pcibios_allocate_bus_resources: i=0 flags 0x100 start 0x4000 end 0x0
pcibios_allocate_bus_resources: i=1 flags 0x200 start 0x4000 end 0x0
pcibios_allocate_bus_resources: i=2 flags 0x0 start 0x4000 end 0x0
pcibios_allocate_bus_resources: i=3 flags 0x0 start 0x4000 end 0x0
pcibios_allocate_bus_resources: i=0 flags 0x100 start 0x4000 end 0x0
pcibios_allocate_bus_resources: i=1 flags 0x200 start 0x4000 end 0x0
pcibios_allocate_bus_resources: i=0 flags 0x100 start 0x4000 end 0x0
pcibios_allocate_bus_resources: i=1 flags 0x200 start 0x4000 end 0x0
pcibios_allocate_bus_resources: i=2 flags 0x0 start 0x4000 end 0x0
pcibios_allocate_bus_resources: i=3 flags 0x0 start 0x4000 end 0x0
PCI 0000:00 Cannot reserve Legacy IO [io  0xffbed000-0xffbedfff]
PCI 0001:02 Cannot reserve Legacy IO [io  0xffbdb000-0xffbdbfff]
pci 0000:00:00.0: PCI bridge to [bus 01-01]
pci 0000:00:00.0:   bridge window [io  0xffbed000-0xffbfcfff]
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xbfffffff]
pci 0000:00:00.0:   bridge window [mem pref disabled]
pci 0000:00:00.0: enabling device (0106 -> 0107)
pci 0001:02:00.0: PCI bridge to [bus 03-03]
pci 0001:02:00.0:   bridge window [io  0xffbdb000-0xffbeafff]
pci 0001:02:00.0:   bridge window [mem 0xc0000000-0xdfffffff]
pci 0001:02:00.0:   bridge window [mem pref disabled]
pci 0001:02:00.0: enabling device (0106 -> 0107)
pci_bus 0000:00: resource 0 [io  0xffbed000-0xffbfcfff]
pci_bus 0000:00: resource 1 [mem 0xa0000000-0xbfffffff]
pci_bus 0000:01: resource 0 [io  0xffbed000-0xffbfcfff]
pci_bus 0000:01: resource 1 [mem 0xa0000000-0xbfffffff]
pci_bus 0001:02: resource 0 [io  0xffbdb000-0xffbeafff]
pci_bus 0001:02: resource 1 [mem 0xc0000000-0xdfffffff]
pci_bus 0001:03: resource 0 [io  0xffbdb000-0xffbeafff]
pci_bus 0001:03: resource 1 [mem 0xc0000000-0xdfffffff]
vgaarb: loaded
Freescale Elo / Elo Plus DMA driver
Switching to clocksource timebase
Switched to NOHz mode on CPU #0
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
PCI: CLS 0 bytes, default 32
irq: irq 42 on host /soc@ffe00000/pic@40000 mapped to virtual irq 42
irq: irq 19 on host /soc@ffe00000/pic@40000 mapped to virtual irq 19
irq: irq 17 on host /soc@ffe00000/pic@40000 mapped to virtual irq 17
irq: irq 18 on host /soc@ffe00000/pic@40000 mapped to virtual irq 18
irq: irq 43 on host /soc@ffe00000/pic@40000 mapped to virtual irq 43
irq: irq 59 on host /soc@ffe00000/pic@40000 mapped to virtual irq 59
irq: irq 76 on host /soc@ffe00000/pic@40000 mapped to virtual irq 76
of:fsl-elo-dma ffe0c300.dma: #0 (fsl,eloplus-dma-channel), irq 76
irq: irq 77 on host /soc@ffe00000/pic@40000 mapped to virtual irq 77
of:fsl-elo-dma ffe0c300.dma: #1 (fsl,eloplus-dma-channel), irq 77
irq: irq 78 on host /soc@ffe00000/pic@40000 mapped to virtual irq 78
of:fsl-elo-dma ffe0c300.dma: #2 (fsl,eloplus-dma-channel), irq 78
irq: irq 79 on host /soc@ffe00000/pic@40000 mapped to virtual irq 79
of:fsl-elo-dma ffe0c300.dma: #3 (fsl,eloplus-dma-channel), irq 79
of:fsl-elo-dma ffe0c300.dma: request channel 0 IRQ
of:fsl-elo-dma ffe0c300.dma: request channel 1 IRQ
of:fsl-elo-dma ffe0c300.dma: request channel 2 IRQ
of:fsl-elo-dma ffe0c300.dma: request channel 3 IRQ
irq: irq 47 on host /soc@ffe00000/pic@40000 mapped to virtual irq 47
irq: irq 16 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16
irq: irq 20 on host /soc@ffe00000/pic@40000 mapped to virtual irq 20
of:fsl-elo-dma ffe21300.dma: #0 (fsl,eloplus-dma-channel), irq 20
irq: irq 21 on host /soc@ffe00000/pic@40000 mapped to virtual irq 21
of:fsl-elo-dma ffe21300.dma: #1 (fsl,eloplus-dma-channel), irq 21
irq: irq 22 on host /soc@ffe00000/pic@40000 mapped to virtual irq 22
of:fsl-elo-dma ffe21300.dma: #2 (fsl,eloplus-dma-channel), irq 22
irq: irq 23 on host /soc@ffe00000/pic@40000 mapped to virtual irq 23
of:fsl-elo-dma ffe21300.dma: #3 (fsl,eloplus-dma-channel), irq 23
of:fsl-elo-dma ffe21300.dma: request channel 0 IRQ
of:fsl-elo-dma ffe21300.dma: request channel 1 IRQ
of:fsl-elo-dma ffe21300.dma: request channel 2 IRQ
of:fsl-elo-dma ffe21300.dma: request channel 3 IRQ
irq: irq 28 on host /soc@ffe00000/pic@40000 mapped to virtual irq 28
irq: irq 29 on host /soc@ffe00000/pic@40000 mapped to virtual irq 29
irq: irq 30 on host /soc@ffe00000/pic@40000 mapped to virtual irq 30
irq: irq 34 on host /soc@ffe00000/pic@40000 mapped to virtual irq 34
irq: irq 35 on host /soc@ffe00000/pic@40000 mapped to virtual irq 35
irq: irq 36 on host /soc@ffe00000/pic@40000 mapped to virtual irq 36
irq: irq 40 on host /soc@ffe00000/pic@40000 mapped to virtual irq 40
irq: irq 31 on host /soc@ffe00000/pic@40000 mapped to virtual irq 31
irq: irq 32 on host /soc@ffe00000/pic@40000 mapped to virtual irq 32
irq: irq 33 on host /soc@ffe00000/pic@40000 mapped to virtual irq 33
irq: irq 72 on host /soc@ffe00000/pic@40000 mapped to virtual irq 72
irq: irq 45 on host /soc@ffe00000/pic@40000 mapped to virtual irq 45
irq: irq 58 on host /soc@ffe00000/pic@40000 mapped to virtual irq 58
irq: irq 224 on host /soc@ffe00000/pic@40000 mapped to virtual irq 224
irq: irq 225 on host /soc@ffe00000/pic@40000 mapped to virtual irq 225
irq: irq 226 on host /soc@ffe00000/pic@40000 mapped to virtual irq 226
irq: irq 227 on host /soc@ffe00000/pic@40000 mapped to virtual irq 227
irq: irq 228 on host /soc@ffe00000/pic@40000 mapped to virtual irq 228
irq: irq 229 on host /soc@ffe00000/pic@40000 mapped to virtual irq 229
irq: irq 230 on host /soc@ffe00000/pic@40000 mapped to virtual irq 230
irq: irq 231 on host /soc@ffe00000/pic@40000 mapped to virtual irq 231
Setting up Freescale MSI support
msgmni has been set to 1512
Freescale DIU driver
Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xffe04500 (irq = 42) is a 16550A
console [ttyS0] enabled, bootconsole disabled
serial8250.0: ttyS1 at MMIO 0xffe04600 (irq = 42) is a 16550A
Fixed MDIO Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ec:a1:02
eth0: Running with NAPI enabled
eth0: RX BD ring size for Q[0]: 256
eth0: TX BD ring size for Q[0]: 256
eth1: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ec:a1:11
eth1: Running with NAPI enabled
eth1: RX BD ring size for Q[0]: 256
eth1: TX BD ring size for Q[0]: 256
eth2: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ec:a1:01
eth2: Running with NAPI enabled
eth2: RX BD ring size for Q[0]: 256
eth2: TX BD ring size for Q[0]: 256
Freescale PowerQUICC MII Bus: probed
irq: irq 3 on host /soc@ffe00000/pic@40000 mapped to virtual irq 24
Freescale PowerQUICC MII Bus: probed
of:mpc-i2c ffe03000.i2c: timeout 1000000 us
of:mpc-i2c ffe03100.i2c: timeout 1000000 us
TCP cubic registered
NET: Registered protocol family 17
IP-Config: Complete:
     device=eth0, addr=10.0.0.30, mask=255.0.0.0, gw=255.255.255.255,
     host=P2020RDB, domain=, nis-domain=(none),
     bootserver=10.0.0.10, rootserver=10.0.0.10, rootpath=
PHY: 0:01 - Link is Up - 1000/Full
VFS: Mounted root (nfs filesystem) on device 0:11.
Freeing unused kernel memory: 136k init
__dma_request_channel: success (dma0chan0)
of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
dmatest: Started 2 threads using dma0chan0
of:fsl-elo-dma ffe0c300.dma: chan0: irq: stat = 0x8
of:fsl-elo-dma ffe0c300.dma: chan0: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: chan0: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet entry
of:fsl-elo-dma ffe0c300.dma: chan0: completed_cookie=1
of:fsl-elo-dma ffe0c300.dma: chan0: no pending LDs
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet exit
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #0: No errors with src_off=0x3a2 dst_off=0xc1e len=0x2ce5
dma0chan0-copy0: terminating after 1 tests, 0 failures (status 0)
of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
dma0chan0-copy1: #0: test timed out
dma0chan0-copy1: terminating after 1 tests, 1 failures (status 0)

--------------080503000205000504030409--
