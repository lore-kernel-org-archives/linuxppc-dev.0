Message-ID: <3F00E86B.1000309@stinkfoot.org>
Date: Mon, 30 Jun 2003 21:48:27 -0400
From: Ethan Weinstein <e-d0uble@stinkfoot.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aic7xxx panics (long)
References: <3EFFD86B.7060007@stinkfoot.org> <1056957083.32576.112.camel@gaston>
In-Reply-To: <1056957083.32576.112.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> As I already told you privately, there's nothing I can do without more
> informations on the panic. The panic/Oops log, or whatever is printed
> by xmon if you have it enabled would be a good first step. Also, what
> kind of machine is it ? Is there any special message displayed by
> the driver before it dies ? etc...
>
> Right now, you just say "it doesn't work", not much we can do about it...

Ben,

Unfortunately, xmon gives no output except that is't attempting to use a
serial port.  This machine (G4 MDD) has no serial, so I'm at a loss
getting any type of serial console working unless you have a suggestion.
I see the xmon source mentions using firewire, but I have no idea how
I'd get that working, as this is the only machine here with fw.

The aic7xxx driver's output is as usual, it begins to initialize... and
then we get the crash.

Is there anything else I can do here?  I've heard I can replace the
internal modem with a third party serial interface.  I'd be willing to
try this to get a serial console for debugging.

The last messages before the panic are as follows:

PCI: enabling device 10:12.0 ( 0004 -> 0007 )
Machine Check in Kernel Mode.
Caused by (from SRR1=149030)
Transfer error ack signal.

And that's it. I wish there were more.

The specs on this machine are as follows:

It's new dual G4 @1.2Ghz, 1280M of RAM.

processor       : 0
cpu             : 7455, altivec supported
clock           : 1249MHz
revision        : 3.2 (pvr 8001 0302)
bogomips        : 1248.46

processor       : 1
cpu             : 7455, altivec supported
clock           : 1249MHz
revision        : 3.2 (pvr 8001 0302)
bogomips        : 1248.46

total bogomips  : 2496.92
machine         : PowerMac3,6
motherboard     : PowerMac3,6 MacRISC3 Power Macintosh
detected as     : 129 (PowerMac G4 Windtunnel)
pmac flags      : 00000000
L2 cache        : 256K unified
memory          : 1280MB
pmac-generation : NewWorld

00:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 AGP
         Flags: bus master, 66Mhz, medium devsel, latency 16
         Capabilities: [80] AGP version 1.0

00:10.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If
[Radeon 9000] (rev 01) (prog-if 00 [VGA])
         Subsystem: ATI Technologies Inc Radeon R250 If [Radeon 9000]
         Flags: bus master, stepping, 66Mhz, medium devsel, latency 255,
IRQ 48
         Memory at 98000000 (32-bit, prefetchable) [size=128M]
         I/O ports at 802400 [size=256]
         Memory at 90000000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at 90020000 [disabled] [size=128K]
         Capabilities: [58] AGP version 2.0
         Capabilities: [50] Power Management version 2

10:0b.0 Host bridge: Apple Computer Inc.: Unknown device 0035
         Flags: bus master, 66Mhz, medium devsel, latency 16

10:12.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m
(rev 01)
         Subsystem: Adaptec AHA-3960D U160/m
         Flags: bus master, 66Mhz, medium devsel, latency 16, IRQ 52
         BIST result: 00
         I/O ports at 1000 [disabled] [size=256]
         Memory at 80089000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at 800e0000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2

10:12.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m
(rev 01)
         Subsystem: Adaptec AHA-3960D U160/m
         Flags: bus master, 66Mhz, medium devsel, latency 16, IRQ 52
         BIST result: 00
         I/O ports at 1400 [disabled] [size=256]
         Memory at 80088000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at 800c0000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2

10:13.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
         Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
         Flags: bus master, medium devsel, latency 16, IRQ 53
         Memory at 80087000 (32-bit, non-prefetchable) [size=4K]
         I/O ports at 0800 [size=64]
         Memory at 80200000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at 80100000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2

10:14.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 02)
         Subsystem: LSI Logic / Symbios Logic: Unknown device 1020
         Flags: bus master, medium devsel, latency 16, IRQ 54
         I/O ports at 0400 [size=256]
         Memory at 80081000 (32-bit, non-prefetchable) [size=256]
         Memory at 80086000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at 800a0000 [disabled] [size=128K]

10:17.0 Class ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 03)
         Flags: bus master, medium devsel, latency 16
         Memory at 80000000 (32-bit, non-prefetchable) [size=512K]

10:18.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10 [OHCI])
         Flags: medium devsel
         Memory at 80085000 (32-bit, non-prefetchable) [disabled] [size=4K]

10:19.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10 [OHCI])
         Flags: medium devsel
         Memory at 80084000 (32-bit, non-prefetchable) [disabled] [size=4K]

10:1b.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
         Subsystem: NEC Corporation USB
         Flags: bus master, medium devsel, latency 16, IRQ 63
         Memory at 80083000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 2

10:1b.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
         Subsystem: NEC Corporation USB
         Flags: bus master, medium devsel, latency 16, IRQ 63
         Memory at 80082000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 2

20:0b.0 Host bridge: Apple Computer Inc.: Unknown device 0036
         Flags: bus master, 66Mhz, medium devsel, latency 16

20:0d.0 Class ff00: Apple Computer Inc. UniNorth 2 ATA/100
         Flags: bus master, medium devsel, latency 32, IRQ 39
         Memory at f5004000 (32-bit, non-prefetchable) [disabled] [size=16K]

20:0e.0 FireWire (IEEE 1394): Apple Computer Inc. UniNorth 2 FireWire
(rev 01) (prog-if 10 [OHCI])
         Subsystem: Apple Computer Inc.: Unknown device 5811
         Flags: medium devsel, IRQ 40
         Memory at f5000000 (32-bit, non-prefetchable) [disabled] [size=4K]
         Capabilities: [44] Power Management version 2

20:0f.0 Ethernet controller: Apple Computer Inc. UniNorth 2 GMAC (Sun GEM)
         Flags: bus master, 66Mhz, slow devsel, latency 6, IRQ 41
         Memory at f5200000 (32-bit, non-prefetchable) [size=2M]
         Expansion ROM at f5100000 [disabled] [size=1M]


Here's a recent (good) dmesg:

Jun 30 20:56:54 spicymeatball kernel: klogd 1.4.1, log source =
/proc/kmsg started.
Jun 30 20:56:54 spicymeatball kernel: Memory BAT mapping: BAT2=256Mb,
BAT3=256Mb, residual: 768Mb
Jun 30 20:56:54 spicymeatball kernel: Total memory = 1280MB; using
4096kB for hash table (at c0400000)
Jun 30 20:56:54 spicymeatball kernel: Linux version 2.4.20-ben10-new
(root@spicymeatball) (gcc version 2.95.3 20010315 (release)) #1 SMP Tue
Jun 24 23:38:22 EDT 2003
Jun 30 20:56:54 spicymeatball kernel: Found Uninorth memory controller &
host bridge, revision: 36
Jun 30 20:56:54 spicymeatball kernel: Mapped at 0xfdeec000
Jun 30 20:56:54 spicymeatball kernel: Found a Keylargo mac-io
controller, rev: 3, mapped at 0xfde6c000
Jun 30 20:56:54 spicymeatball kernel: PowerMac motherboard: PowerMac G4
Windtunnel
Jun 30 20:56:54 spicymeatball kernel: CPU MSCCR0 : 0x00008003
Jun 30 20:56:54 spicymeatball kernel: CPU HID1   : 0x80002c80
Jun 30 20:56:54 spicymeatball kernel: Found UniNorth PCI host bridge at
0xf0000000. Firmware bus number: 0->0
Jun 30 20:56:54 spicymeatball kernel: hose pci, pci_mem_offset:
00000000, start0: f1000000
Jun 30 20:56:54 spicymeatball kernel:   io_base_virt: fd669000,
io_base_phys: f0000000, isa_mem_base: 00000000
Jun 30 20:56:54 spicymeatball kernel: Found UniNorth PCI host bridge at
0xf2000000. Firmware bus number: 0->0
Jun 30 20:56:54 spicymeatball kernel: hose pci, pci_mem_offset:
00000000, start0: f3000000
Jun 30 20:56:54 spicymeatball kernel:   io_base_virt: fce67000,
io_base_phys: f2000000, isa_mem_base: 00000000
Jun 30 20:56:54 spicymeatball kernel: Found UniNorth PCI host bridge at
0xf4000000. Firmware bus number: 0->0
Jun 30 20:56:54 spicymeatball kernel: hose pci, pci_mem_offset:
00000000, start0: f5000000
Jun 30 20:56:54 spicymeatball kernel:   io_base_virt: fc665000,
io_base_phys: f4000000, isa_mem_base: 00000000
Jun 30 20:56:54 spicymeatball kernel: PMU driver 2 initialized for
Core99, firmware: 0c
Jun 30 20:56:54 spicymeatball kernel: On node 0 totalpages: 327680
Jun 30 20:56:54 spicymeatball kernel: zone(0): 131072 pages.
Jun 30 20:56:54 spicymeatball kernel: zone(1): 0 pages.
Jun 30 20:56:54 spicymeatball kernel: zone(2): 196608 pages.
Jun 30 20:56:54 spicymeatball kernel: Kernel command line:
root=/dev/sda4 ro aic7xxx=verbose panic=600
Jun 30 20:56:54 spicymeatball kernel: PowerMac using OpenPIC irq controller
Jun 30 20:56:54 spicymeatball kernel: OpenPIC Version 1.2 (4 CPUs and 64
IRQ sources) at fc61e000
Jun 30 20:56:54 spicymeatball kernel: OpenPIC timer frequency is
4.166666 MHz
Jun 30 20:56:54 spicymeatball kernel: GMT Delta read from XPRAM: 0
minutes, DST: off
Jun 30 20:56:54 spicymeatball kernel: via_calibrate_decr: ticks per
jiffy = 416586 (2499517 ticks)
Jun 30 20:56:54 spicymeatball kernel: Console: colour dummy device 80x25
Jun 30 20:56:54 spicymeatball kernel: Calibrating delay loop... 1248.46
BogoMIPS
Jun 30 20:56:54 spicymeatball kernel: Memory: 1288128k available (1364k
kernel code, 876k data, 260k init, 786432k highmem)
Jun 30 20:56:54 spicymeatball kernel: AGP special page: 0xdffff000
Jun 30 20:56:54 spicymeatball kernel: Dentry cache hash table entries:
262144 (order: 9, 2097152 bytes)
Jun 30 20:56:54 spicymeatball kernel: Inode cache hash table entries:
131072 (order: 8, 1048576 bytes)
Jun 30 20:56:54 spicymeatball kernel: Mount-cache hash table entries:
32768 (order: 6, 262144 bytes)
Jun 30 20:56:54 spicymeatball kernel: Buffer-cache hash table entries:
131072 (order: 7, 524288 bytes)
Jun 30 20:56:54 spicymeatball kernel: Page-cache hash table entries:
524288 (order: 9, 2097152 bytes)
Jun 30 20:56:54 spicymeatball kernel: POSIX conformance testing by UNIFIX
Jun 30 20:56:54 spicymeatball kernel: Entering SMP Mode...
Jun 30 20:56:54 spicymeatball kernel: smp_core99_probe: found 2 cpus
Jun 30 20:56:54 spicymeatball kernel: CPU0: L2CR is 80000000
Jun 30 20:56:54 spicymeatball kernel: CPU0: L3CR is 8f830000
Jun 30 20:56:54 spicymeatball kernel: CPU1: L2CR was 0
Jun 30 20:56:54 spicymeatball kernel: CPU1: L2CR set to 80000000
Jun 30 20:56:54 spicymeatball kernel: CPU1: L3CR was 0
Jun 30 20:56:54 spicymeatball kernel: CPU1: L3CR set to 8f830000
Jun 30 20:56:54 spicymeatball kernel: Processor 1 found.
Jun 30 20:56:54 spicymeatball kernel: smp_software_tb_sync: 4 passes,
final offset: 4
Jun 30 20:56:54 spicymeatball kernel: Waiting on wait_init_idle (map = 0x0)
Jun 30 20:56:54 spicymeatball kernel: All processors have done init_idle
Jun 30 20:56:54 spicymeatball kernel: PCI: Probing PCI hardware
Jun 30 20:56:54 spicymeatball kernel: Scanning bus 00
Jun 30 20:56:54 spicymeatball kernel: Found 00:58 [106b/0034] 000600 00
Jun 30 20:56:54 spicymeatball kernel: Found 00:80 [1002/4966] 000300 00
Jun 30 20:56:54 spicymeatball kernel: Fixup res 1 (101) of dev 00:10.0:
400 -> 802400
Jun 30 20:56:54 spicymeatball kernel: Fixups for bus 00
Jun 30 20:56:54 spicymeatball kernel: Bus scan for 00 returning with max=00
Jun 30 20:56:54 spicymeatball kernel: Scanning bus 10
Jun 30 20:56:54 spicymeatball kernel: Found 10:58 [106b/0035] 000600 00
Jun 30 20:56:54 spicymeatball kernel: Found 10:90 [9005/00c0] 000100 00
Jun 30 20:56:54 spicymeatball kernel: Found 10:91 [9005/00c0] 000100 00
Jun 30 20:56:54 spicymeatball kernel: Found 10:98 [8086/1229] 000200 00
Jun 30 20:56:54 spicymeatball kernel: Found 10:a0 [1000/000c] 000100 00
Jun 30 20:56:54 spicymeatball kernel: Found 10:b8 [106b/0022] 00ff00 00
Jun 30 20:56:54 spicymeatball kernel: Found 10:c0 [106b/0019] 000c03 00
Jun 30 20:56:54 spicymeatball kernel: Found 10:c8 [106b/0019] 000c03 00
Jun 30 20:56:54 spicymeatball kernel: Found 10:d8 [1033/0035] 000c03 00
Jun 30 20:56:54 spicymeatball kernel: Found 10:d9 [1033/0035] 000c03 00
Jun 30 20:56:54 spicymeatball kernel: Fixups for bus 10
Jun 30 20:56:54 spicymeatball kernel: Bus scan for 10 returning with max=10
Jun 30 20:56:54 spicymeatball kernel: Scanning bus 20
Jun 30 20:56:54 spicymeatball kernel: Found 20:58 [106b/0036] 000600 00
Jun 30 20:56:54 spicymeatball kernel: Found 20:68 [106b/0033] 00ff00 00
Jun 30 20:56:54 spicymeatball kernel: Found 20:70 [106b/0031] 000c00 00
Jun 30 20:56:54 spicymeatball kernel: Found 20:78 [106b/0032] 000200 00
Jun 30 20:56:54 spicymeatball kernel: Fixups for bus 20
Jun 30 20:56:54 spicymeatball kernel: Bus scan for 20 returning with max=20
Jun 30 20:56:54 spicymeatball kernel: PCI->OF bus map:
Jun 30 20:56:54 spicymeatball kernel: 0 -> 0
Jun 30 20:56:54 spicymeatball kernel: 16 -> 0
Jun 30 20:56:54 spicymeatball kernel: 32 -> 0
Jun 30 20:56:54 spicymeatball kernel: PCI:00:10.0: Resource 0:
98000000-9fffffff (f=1208), vd: 1002, dev: 4966
Jun 30 20:56:54 spicymeatball kernel: PCI:00:10.0: Resource 2:
90000000-9000ffff (f=200), vd: 1002, dev: 4966
Jun 30 20:56:54 spicymeatball kernel: PCI:10:17.0: Resource 0:
80000000-8007ffff (f=200), vd: 106b, dev: 0022
Jun 30 20:56:54 spicymeatball kernel: PCI:20:0f.0: Resource 0:
f5200000-f53fffff (f=200), vd: 106b, dev: 0032
Jun 30 20:56:54 spicymeatball kernel: PCI:00:10.0: Resource 1:
00802400-008024ff (f=101), vd: 1002, dev: 4966
Jun 30 20:56:54 spicymeatball kernel: PCI:10:12.0: Resource 1:
80089000-80089fff (f=204), vd: 9005, dev: 00c0
Jun 30 20:56:54 spicymeatball kernel: PCI:10:12.1: Resource 1:
80088000-80088fff (f=204), vd: 9005, dev: 00c0
Jun 30 20:56:54 spicymeatball kernel: PCI:10:13.0: Resource 0:
80087000-80087fff (f=200), vd: 8086, dev: 1229
Jun 30 20:56:54 spicymeatball kernel: PCI:10:13.0: Resource 1:
00000800-0000083f (f=101), vd: 8086, dev: 1229
Jun 30 20:56:54 spicymeatball kernel: PCI:10:13.0: Resource 2:
80200000-802fffff (f=200), vd: 8086, dev: 1229
Jun 30 20:56:54 spicymeatball kernel: PCI:10:14.0: Resource 0:
00000400-000004ff (f=101), vd: 1000, dev: 000c
Jun 30 20:56:54 spicymeatball kernel: PCI:10:14.0: Resource 1:
80081000-800810ff (f=200), vd: 1000, dev: 000c
Jun 30 20:56:54 spicymeatball kernel: PCI:10:14.0: Resource 2:
80086000-80086fff (f=200), vd: 1000, dev: 000c
Jun 30 20:56:54 spicymeatball kernel: PCI:10:18.0: Resource 0:
80085000-80085fff (f=200), vd: 106b, dev: 0019
Jun 30 20:56:54 spicymeatball kernel: PCI:10:19.0: Resource 0:
80084000-80084fff (f=200), vd: 106b, dev: 0019
Jun 30 20:56:54 spicymeatball kernel: PCI:10:1b.0: Resource 0:
80083000-80083fff (f=200), vd: 1033, dev: 0035
Jun 30 20:56:54 spicymeatball kernel: PCI:10:1b.1: Resource 0:
80082000-80082fff (f=200), vd: 1033, dev: 0035
Jun 30 20:56:54 spicymeatball kernel: PCI:20:0d.0: Resource 0:
f5004000-f5007fff (f=200), vd: 106b, dev: 0033
Jun 30 20:56:54 spicymeatball kernel: PCI:20:0e.0: Resource 0:
f5000000-f5000fff (f=200), vd: 106b, dev: 0031
Jun 30 20:56:54 spicymeatball kernel: Linux NET4.0 for Linux 2.4
Jun 30 20:56:54 spicymeatball kernel: Based upon Swansea University
Computer Society NET3.039
Jun 30 20:56:54 spicymeatball kernel: Initializing RT netlink socket
Jun 30 20:56:54 spicymeatball kernel: Starting kswapd
Jun 30 20:56:54 spicymeatball kernel: allocated 32 pages and 32 bhs
reserved for the highmem bounces
Jun 30 20:56:54 spicymeatball kernel: PCI: Enabling device 00:10.0 (0086
-> 0087)
Jun 30 20:56:54 spicymeatball kernel: radeonfb: ref_clk=2700,
ref_div=12, xclk=24975 from OF
Jun 30 20:56:54 spicymeatball kernel: Console: switching to colour frame
buffer device 80x30
Jun 30 20:56:54 spicymeatball kernel: radeonfb: ATI Radeon 9000 If DDR
SGRAM 64 MB
Jun 30 20:56:54 spicymeatball kernel: radeonfb: DVI port no monitor
connected
Jun 30 20:56:54 spicymeatball kernel: radeonfb: CRT port CRT monitor
connected
Jun 30 20:56:54 spicymeatball kernel: pty: 256 Unix98 ptys configured
Jun 30 20:56:54 spicymeatball kernel: SCSI subsystem driver Revision: 1.00
Jun 30 20:56:54 spicymeatball kernel: PCI: Enabling device 10:12.0 (0000
-> 0003)
Jun 30 20:56:54 spicymeatball kernel: PCI: Enabling bus mastering for
device 10:12.0
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:0: Reading
SEEPROM...done.
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:0: BIOS eeprom is
present
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:0: Secondary High
byte termination Enabled
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:0: Secondary Low
byte termination Enabled
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:0: Primary Low Byte
termination Enabled
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:0: Primary High Byte
termination Enabled
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:0: Downloading
Sequencer Program... 419 instructions downloaded
Jun 30 20:56:54 spicymeatball kernel: PCI: Enabling device 10:12.1 (0004
-> 0007)
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:1: Reading
SEEPROM...done.
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:1: BIOS eeprom is
present
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:1: Secondary High
byte termination Enabled
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:1: Secondary Low
byte termination Enabled
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:1: Primary Low Byte
termination Enabled
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:1: Primary High Byte
termination Enabled
Jun 30 20:56:54 spicymeatball kernel: ahc_pci:16:18:1: Downloading
Sequencer Program... 419 instructions downloaded
Jun 30 20:56:54 spicymeatball kernel: scsi0 : Adaptec AIC7XXX
EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Jun 30 20:56:54 spicymeatball kernel:         <Adaptec 3960D Ultra160
SCSI adapter>
Jun 30 20:56:54 spicymeatball kernel:         aic7899: Ultra160 Wide
Channel A, SCSI Id=7, 32/253 SCBs
Jun 30 20:56:54 spicymeatball kernel:
Jun 30 20:56:54 spicymeatball kernel: scsi1 : Adaptec AIC7XXX
EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Jun 30 20:56:54 spicymeatball kernel:         <Adaptec 3960D Ultra160
SCSI adapter>
Jun 30 20:56:54 spicymeatball kernel:         aic7899: Ultra160 Wide
Channel B, SCSI Id=7, 32/253 SCBs
Jun 30 20:56:54 spicymeatball kernel:
Jun 30 20:56:54 spicymeatball kernel: blk: queue c0322618, I/O limit
4095Mb (mask 0xffffffff)
Jun 30 20:56:54 spicymeatball kernel:   Vendor: SEAGATE   Model:
ST318452LW        Rev: 0002
Jun 30 20:56:54 spicymeatball kernel:   Type:   Direct-Access
            ANSI SCSI revision: 03
Jun 30 20:56:54 spicymeatball kernel: blk: queue c1754418, I/O limit
4095Mb (mask 0xffffffff)
Jun 30 20:56:54 spicymeatball kernel:   Vendor: SEAGATE   Model:
ST318452LW        Rev: 0004
Jun 30 20:56:54 spicymeatball kernel:   Type:   Direct-Access
            ANSI SCSI revision: 03
Jun 30 20:56:54 spicymeatball kernel: blk: queue c1750c18, I/O limit
4095Mb (mask 0xffffffff)
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:6): 3.300MB/s transfers
Jun 30 20:56:54 spicymeatball kernel: scsi0:A:6:0: Tagged Queuing
enabled.  Depth 253
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:9): 3.300MB/s transfers
Jun 30 20:56:54 spicymeatball kernel: scsi0:A:9:0: Tagged Queuing
enabled.  Depth 253
Jun 30 20:56:54 spicymeatball kernel:   Vendor: FUJITSU   Model:
MAM3184MP         Rev: 0107
Jun 30 20:56:54 spicymeatball kernel:   Type:   Direct-Access
            ANSI SCSI revision: 03
Jun 30 20:56:54 spicymeatball kernel: blk: queue c1749618, I/O limit
4095Mb (mask 0xffffffff)
Jun 30 20:56:54 spicymeatball kernel: (scsi1:A:15): 3.300MB/s transfers
Jun 30 20:56:54 spicymeatball kernel: scsi1:A:15:0: Tagged Queuing
enabled.  Depth 253
Jun 30 20:56:54 spicymeatball kernel: Attached scsi disk sda at scsi0,
channel 0, id 6, lun 0
Jun 30 20:56:54 spicymeatball kernel: Attached scsi disk sdb at scsi0,
channel 0, id 9, lun 0
Jun 30 20:56:54 spicymeatball kernel: Attached scsi disk sdc at scsi1,
channel 0, id 15, lun 0
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:6:0): Sending PPR
bus_width 1, period 9, offset 7f, ppr_options 2
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:6:0): Received PPR width
1, period 9, offset 3f,options 2
Jun 30 20:56:54 spicymeatball kernel: ^IFiltered to width 1, period 9,
offset 3f, options 2
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:6): 6.600MB/s transfers
(16bit)
Jun 30 20:56:54 spicymeatball kernel: scsi0: target 6 using 16bit transfers
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:6): 160.000MB/s transfers
(80.000MHz DT, offset 63, 16bit)
Jun 30 20:56:54 spicymeatball kernel: scsi0: target 6 synchronous at
80.0MHz DT, offset = 0x3f
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:6:0): Sending PPR
bus_width 1, period 9, offset 3f, ppr_options 2
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:6:0): Received PPR width
1, period 9, offset 3f,options 2
Jun 30 20:56:54 spicymeatball kernel: ^IFiltered to width 1, period 9,
offset 3f, options 2
Jun 30 20:56:54 spicymeatball kernel: SCSI device sda: 35843670 512-byte
hdwr sectors (18352 MB)
Jun 30 20:56:54 spicymeatball kernel: Partition check:
Jun 30 20:56:54 spicymeatball kernel:  sda: [mac] sda1 sda2 sda3 sda4 sda5
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:9:0): Sending PPR
bus_width 1, period 9, offset 7f, ppr_options 2
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:9:0): Received PPR width
1, period 9, offset 3f,options 2
Jun 30 20:56:54 spicymeatball kernel: ^IFiltered to width 1, period 9,
offset 3f, options 2
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:9): 6.600MB/s transfers
(16bit)
Jun 30 20:56:54 spicymeatball kernel: scsi0: target 9 using 16bit transfers
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:9): 160.000MB/s transfers
(80.000MHz DT, offset 63, 16bit)
Jun 30 20:56:54 spicymeatball kernel: scsi0: target 9 synchronous at
80.0MHz DT, offset = 0x3f
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:9:0): Sending PPR
bus_width 1, period 9, offset 3f, ppr_options 2
Jun 30 20:56:54 spicymeatball kernel: (scsi0:A:9:0): Received PPR width
1, period 9, offset 3f,options 2
Jun 30 20:56:54 spicymeatball kernel: ^IFiltered to width 1, period 9,
offset 3f, options 2
Jun 30 20:56:54 spicymeatball kernel: SCSI device sdb: 35843670 512-byte
hdwr sectors (18352 MB)
Jun 30 20:56:54 spicymeatball kernel:  sdb: [mac] sdb1 sdb2 sdb3
Jun 30 20:56:54 spicymeatball kernel: (scsi1:A:15:0): Sending PPR
bus_width 1, period 9, offset 7f, ppr_options 2
Jun 30 20:56:54 spicymeatball kernel: (scsi1:A:15:0): Received PPR width
1, period 9, offset 7f,options 2
Jun 30 20:56:54 spicymeatball kernel: ^IFiltered to width 1, period 9,
offset 7f, options 2
Jun 30 20:56:54 spicymeatball kernel: (scsi1:A:15): 6.600MB/s transfers
(16bit)
Jun 30 20:56:54 spicymeatball kernel: scsi1: target 15 using 16bit transfers
Jun 30 20:56:54 spicymeatball kernel: (scsi1:A:15): 160.000MB/s
transfers (80.000MHz DT, offset 127, 16bit)
Jun 30 20:56:54 spicymeatball kernel: scsi1: target 15 synchronous at
80.0MHz DT, offset = 0x7f
Jun 30 20:56:54 spicymeatball kernel: (scsi1:A:15:0): Sending PPR
bus_width 1, period 9, offset 7f, ppr_options 2
Jun 30 20:56:54 spicymeatball kernel: (scsi1:A:15:0): Received PPR width
1, period 9, offset 7f,options 2
Jun 30 20:56:54 spicymeatball kernel: ^IFiltered to width 1, period 9,
offset 7f, options 2
Jun 30 20:56:54 spicymeatball kernel: (scsi1:A:15:0): data overrun
detected in Data-in phase.  Tag == 0x2.
Jun 30 20:56:54 spicymeatball kernel: (scsi1:A:15:0): Have seen Data
Phase.  Length = 0.  NumSGs = 1.
Jun 30 20:56:54 spicymeatball kernel: sg[0] - Addr 0x01768040 : Length 32
Jun 30 20:56:54 spicymeatball kernel: SCSI device sdc: 35885344 512-byte
hdwr sectors (18373 MB)
Jun 30 20:56:54 spicymeatball kernel:  sdc: [mac] sdc1 sdc2 sdc3
Jun 30 20:56:54 spicymeatball kernel: Macintosh non-volatile memory
driver v1.0
Jun 30 20:56:54 spicymeatball kernel: usb.c: registered new driver usbdevfs
Jun 30 20:56:54 spicymeatball kernel: usb.c: registered new driver hub
Jun 30 20:56:54 spicymeatball kernel: PCI: Enabling device 10:1b.0 (0000
-> 0002)
Jun 30 20:56:54 spicymeatball kernel: PCI: Enabling bus mastering for
device 10:1b.0
Jun 30 20:56:54 spicymeatball kernel: usb-ohci.c: USB OHCI at membase
0xe500a000, IRQ 63
Jun 30 20:56:54 spicymeatball kernel: usb-ohci.c: usb-10:1b.0, NEC
Corporation USB
Jun 30 20:56:54 spicymeatball kernel: usb.c: new USB bus registered,
assigned bus number 1
Jun 30 20:56:54 spicymeatball kernel: hub.c: USB hub found
Jun 30 20:56:54 spicymeatball kernel: hub.c: 3 ports detected
Jun 30 20:56:54 spicymeatball kernel: PCI: Enabling device 10:1b.1 (0000
-> 0002)
Jun 30 20:56:54 spicymeatball kernel: PCI: Enabling bus mastering for
device 10:1b.1
Jun 30 20:56:54 spicymeatball kernel: usb-ohci.c: USB OHCI at membase
0xe500c000, IRQ 63
Jun 30 20:56:54 spicymeatball kernel: usb-ohci.c: usb-10:1b.1, NEC
Corporation USB (#2)
Jun 30 20:56:54 spicymeatball kernel: usb.c: new USB bus registered,
assigned bus number 2
Jun 30 20:56:54 spicymeatball kernel: hub.c: USB hub found
Jun 30 20:56:54 spicymeatball kernel: hub.c: 2 ports detected
Jun 30 20:56:54 spicymeatball kernel: usb.c: registered new driver hid
Jun 30 20:56:54 spicymeatball kernel: hid-core.c: v1.8.1 Andreas Gal,
Vojtech Pavlik <vojtech@suse.cz>
Jun 30 20:56:54 spicymeatball kernel: hid-core.c: USB HID support drivers
Jun 30 20:56:54 spicymeatball kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jun 30 20:56:54 spicymeatball kernel: IP Protocols: ICMP, UDP, TCP
Jun 30 20:56:54 spicymeatball kernel: IP: routing cache hash table of
16384 buckets, 128Kbytes
Jun 30 20:56:54 spicymeatball kernel: TCP: Hash tables configured
(established 262144 bind 65536)
Jun 30 20:56:54 spicymeatball kernel: NET4: Unix domain sockets 1.0/SMP
for Linux NET4.0.
Jun 30 20:56:54 spicymeatball kernel: VFS: Mounted root (ext2
filesystem) readonly.
Jun 30 20:56:54 spicymeatball kernel: Freeing unused kernel memory: 260k
init 8k chrp 8k prep
Jun 30 20:56:54 spicymeatball kernel: Adding Swap: 358392k swap-space
(priority 1)
Jun 30 20:56:54 spicymeatball last message repeated 2 times
Jun 30 20:56:54 spicymeatball kernel: hub.c: new USB device 10:1b.1-1,
assigned address 2
Jun 30 20:56:54 spicymeatball kernel: hub.c: USB hub found
Jun 30 20:56:54 spicymeatball kernel: hub.c: 3 ports detected
Jun 30 20:56:54 spicymeatball kernel: hub.c: new USB device 10:1b.1-1.1,
assigned address 3
Jun 30 20:56:54 spicymeatball kernel: usb_control/bulk_msg: timeout
Jun 30 20:56:54 spicymeatball kernel: input0: USB HID v10.01 Keyboard
[Mitsumi Electric Apple Extended USB Keyboard] on usb2:3.0
Jun 30 20:56:54 spicymeatball kernel: input1: USB HID v10.01 Pointer
[Mitsumi Electric Apple Extended USB Keyboard] on usb2:3.1
Jun 30 20:56:54 spicymeatball kernel: sungem.c:v0.97 3/20/02 David S.
Miller (davem@redhat.com)
Jun 30 20:56:54 spicymeatball kernel: eth0: Sun GEM (PCI)
10/100/1000BaseT Ethernet 00:03:93:de:d7:ea
Jun 30 20:56:54 spicymeatball kernel: eth0: Found BCM5421 PHY
Jun 30 20:56:54 spicymeatball kernel: Intel(R) PRO/100 Network Driver -
version 2.1.24-k1
Jun 30 20:56:54 spicymeatball kernel: Copyright (c) 2002 Intel Corporation
Jun 30 20:56:54 spicymeatball kernel:
Jun 30 20:56:54 spicymeatball kernel: PCI: Enabling device 10:13.0 (0004
-> 0007)
Jun 30 20:56:54 spicymeatball kernel: e100: selftest OK.
Jun 30 20:56:54 spicymeatball kernel: e100: eth1: Intel(R) PRO/100+
Management Adapter
Jun 30 20:56:54 spicymeatball kernel:   Mem:0x80087000  IRQ:53  Speed:0
Mbps  Dx:N/A
Jun 30 20:56:54 spicymeatball kernel:   Hardware receive checksums enabled
Jun 30 20:56:54 spicymeatball kernel:   cpu cycle saver enabled
Jun 30 20:56:54 spicymeatball kernel:
Jun 30 20:56:54 spicymeatball kernel: ip_conntrack version 2.1 (8192
buckets, 65536 max) - 292 bytes per conntrack
Jun 30 20:56:54 spicymeatball kernel: ip_tables: (C) 2000-2002 Netfilter
core team
Jun 30 20:56:54 spicymeatball kernel: PCI: Enabling device 10:14.0 (0004
-> 0007)
Jun 30 20:56:54 spicymeatball kernel: sym.16.20.0: setting
PCI_COMMAND_PARITY...
Jun 30 20:56:54 spicymeatball kernel: sym.16.20.0: setting
PCI_COMMAND_INVALIDATE.
Jun 30 20:56:54 spicymeatball kernel: sym0: <895> rev 0x2 on pci bus 16
device 20 function 0 irq 54
Jun 30 20:56:54 spicymeatball kernel: sym0: No NVRAM, ID 7, Fast-40,
LVD, parity checking
Jun 30 20:56:54 spicymeatball kernel: sym0: SCSI BUS has been reset.
Jun 30 20:56:54 spicymeatball kernel: scsi2 : sym-2.1.17a
Jun 30 20:56:54 spicymeatball kernel: blk: queue c0322018, I/O limit
4095Mb (mask 0xffffffff)
Jun 30 20:56:54 spicymeatball kernel:   Vendor: SEAGATE   Model:
ULTRIUM06242-XXX  Rev: 1470
Jun 30 20:56:54 spicymeatball kernel:   Type:   Sequential-Access
            ANSI SCSI revision: 03
Jun 30 20:56:54 spicymeatball kernel: blk: queue c174c418, I/O limit
4095Mb (mask 0xffffffff)
Jun 30 20:56:54 spicymeatball kernel: eth0: Link is up at 10 Mbps,
half-duplex.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
