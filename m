Date: Sun, 6 Aug 2000 13:35:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: PCI resource collisions (2.4.0-test1-ac5+)
Message-ID: <20000806133523.D2891@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've recently been playing with 2.4.0 on my machine (Yikes! G4, all PCI slots
full) and I've run into a problem with the new PCI resource checks.  First,
lspci -v gives:
00:00.0 Host bridge: Motorola MPC106 [Grackle] (rev 40)
	Flags: bus master, fast devsel, latency 0

00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 80800000-809fffff
	Capabilities: <available only to root>

00:10.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE (prog-if 00 [VGA])
	Subsystem: Unknown device b530:0408
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 16, IRQ 22
	Memory at 84000000 (32-bit, prefetchable) [size=64M]
	I/O ports at 2000 [size=256]
	Memory at 80a00000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 80a20000 [disabled] [size=128K]
	Capabilities: <available only to root>

01:00.0 FireWire (IEEE 1394): Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link Layer Controller (rev 04) (prog-if 00 [Generic])
	Subsystem: Apple Computer Inc.: Unknown device 001c
	Flags: bus master, medium devsel, latency 16, IRQ 21
	Memory at 80884000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Memory at 808c0000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Memory at 808b0000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Expansion ROM at 808a0000 [disabled] [size=64K]

01:01.0 IDE interface: CMD Technology Inc PCI0646 (rev 07) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: CMD Technology Inc: Unknown device 0646
	Flags: bus master, medium devsel, latency 64, IRQ 26
	I/O ports at 14c0 [size=8]
	I/O ports at 14b0 [size=4]
	I/O ports at 14a0 [size=8]
	I/O ports at 1490 [size=4]
	I/O ports at 1480 [size=16]
	Capabilities: <available only to root>

01:02.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
	Subsystem: 3Com Corporation: Unknown device 9055
	Flags: bus master, medium devsel, latency 16, IRQ 23
	I/O ports at 1400 [size=128]
	Memory at 80881000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 808e0000 [disabled] [size=128K]
	Capabilities: <available only to root>

01:03.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	Flags: bus master, medium devsel, latency 16, IRQ 24
	I/O ports at 1080 [size=128]
	Memory at 80880000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 80900000 [disabled] [size=256K]

01:04.0 SCSI storage controller: Adaptec AIC-7881U
	Flags: bus master, medium devsel, latency 16, IRQ 25
	I/O ports at <unassigned> [size=256]
	Memory at 80883000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 80890000 [disabled] [size=64K]

01:05.0 Class ff00: Apple Computer Inc. Paddington Mac I/O
	Flags: bus master, medium devsel, latency 16
	Memory at 80800000 (32-bit, non-prefetchable) [size=512K]

01:06.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
	Subsystem: OPTi Inc.: Unknown device c861
	Flags: bus master, medium devsel, latency 16, IRQ 28
	Memory at 80882000 (32-bit, non-prefetchable) [size=4K]

And at boot I get:
PCI: Probing PCI hardware
(Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link Layer Controller)
PCI: Address space collision on region 0 of device PCI device 104c:8000
PCI: Address space collision on region 1 of device PCI device 104c:8000
PCI: Address space collision on region 2 of device PCI device 104c:8000
PCI: Address space collision on region 6 of device PCI device 104c:8000
(CMD Technology Inc PCI0646)
PCI: Address space collision on region 0 of device PCI device 1095:0646
PCI: Address space collision on region 1 of device PCI device 1095:0646
PCI: Address space collision on region 2 of device PCI device 1095:0646
PCI: Address space collision on region 3 of device PCI device 1095:0646
PCI: Address space collision on region 4 of device PCI device 1095:0646
(3Com Corporation 3c905B 100BaseTX [Cyclone])
PCI: Address space collision on region 0 of device PCI device 10b7:9055
PCI: Address space collision on region 1 of device PCI device 10b7:9055
PCI: Address space collision on region 6 of device PCI device 10b7:9055
(Digital Equipment Corporation DECchip 21140 [FasterNet])
PCI: Address space collision on region 0 of device PCI device 1011:0009
PCI: Address space collision on region 1 of device PCI device 1011:0009
PCI: Address space collision on region 6 of device PCI device 1011:0009
(Adaptec AIC-7881U)
PCI: Address space collision on region 1 of device PCI device 9004:8178
PCI: Address space collision on region 6 of device PCI device 9004:8178
(Apple Computer Inc. Paddington Mac I/O)
PCI: Address space collision on region 0 of device PCI device 106b:0017
(OPTi Inc. 82C861)
PCI: Address space collision on region 0 of device PCI device 1045:c861

Which causes the aic7xxx.c driver to say there's a PCI resource collision, and
not use the card (which works fine in 2.2.x and 2.4.0-testX with the check
removed).  Has anyone else seen errors like this on 2.4.0-testX (the test1-acX
series added in a good deal of these checks..)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
