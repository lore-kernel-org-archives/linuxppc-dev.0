Mime-Version: 1.0
Message-Id: <v04220801b4daa2e26f84@[10.0.0.42]>
Date: Thu, 24 Feb 2000 01:43:40 -0800
To: linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: PCI I/O address problems on B&W G3
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having a problem with the assignment of I/O addresses to devices.
Multiple PCI devices end with the same I/O port address base,
presumably because OF didn't fully initialize them.  I am using
Michael Lanner's PCI patch (applied to kernel 2.2.15-pre5 from cvs a
while back).  After reading the patch, it looks like it only tries to
correct base addresses for being behind a bridge, so I don't think it
is either helping or hurting.

The devices getting the same I/O port are two Adaptec SCSI cards, a
new 39160 dual-channel and an older 2940UW which I've had for a
while.  I also have a third SCSI card, an Atto UW  (Apple OEM surplus
from the beige G3 era) installed, but it isn't affected by this
problem.

The 39160 isn't recognized.  I initially thought this might be a
aic7xxx bug, but after I described all this in an email to Doug
Ledford (the aic7xxx author) he pointed out that the 2940 and the two
39160 channels all have the same I/O port base address, and that the
aic7xxx driver would refuse to init a card if its I/O resources were
already used.  The 2940UW gets initialized first, so it wins.
Presumably if I removed it I'd get on one channel of the 39160.

So it would seem to me that we need some kind of a scheme for
allocating I/O port base addresses if OF didn't do it.  I'm vaguely
familiar with the concepts behind PCI address space allocation,
having looked at it from the hardware design POV a while back, but
I'm not familiar enough with the kernel code yet to tackle this
problem (or to even be sure that I'm on the right track here).
Comments?


Potentially useful information from my machine:


PCI fixup boot messages:

PCI: Probing PCI hardware
PCI: setting IRQ 22 on device 00:80.
PCI: Correcting IOaddress 2 on device 00:80, now fe002001.
PCI: setting IRQ 21 on device 01:00.
PCI: Enabling memory for device 01:00
PCI: setting IRQ 26 on device 01:08.
PCI: Correcting IOaddress 0 on device 01:08, now fe001841.
PCI: Correcting IOaddress 1 on device 01:08, now fe001831.
PCI: Correcting IOaddress 2 on device 01:08, now fe001821.
PCI: Correcting IOaddress 3 on device 01:08, now fe001811.
PCI: Correcting IOaddress 4 on device 01:08, now fe001801.
PCI: setting IRQ 23 on device 01:10.
PCI: Correcting IOaddress 0 on device 01:10, now fe001401.
PCI: Enabling I/O for device 01:10
PCI: setting IRQ 24 on device 01:18.
PCI: Correcting IOaddress 0 on device 01:18, now fe000001.
PCI: Enabling I/O for device 01:18
PCI: setting IRQ 25 on device 01:20.
PCI: Correcting IOaddress 0 on device 01:20, now fe000001.
PCI: Correcting IOaddress 0 on device 01:21, now fe000001.
PCI: setting IRQ 28 on device 01:30.

(01:18 is the 2940UW, 01:20 and 01:21 are the two channels of the 39160.)


Results of lspci -v:

00:00.0 Host bridge: Motorola MPC106 [Grackle] (rev 40)
	Flags: bus master, fast devsel, latency 0

00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev
02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 80800000-809fffff
	Capabilities: [dc] Power Management version 1

00:10.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3
(rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc.: Unknown device 0005
	Flags: fast devsel, IRQ 22
	Memory at 82000000 (32-bit, non-prefetchable)
	Memory at 90000000 (32-bit, prefetchable)
	I/O ports at fe002000
	Expansion ROM at 80a00000 [disabled]
	Capabilities: [60] Power Management version 1

01:00.0 FireWire (IEEE 1394): Texas Instruments PCILynx/PCILynx2 IEEE
1394 Link Layer Controller (rev 02) (prog-if 00 [Generic])
	Subsystem: Apple Computer Inc.: Unknown device 001c
	Flags: bus master, medium devsel, latency 16, IRQ 21
	Memory at 80886000 (32-bit, non-prefetchable)
	Memory at 808c0000 (32-bit, non-prefetchable)
	Memory at 808b0000 (32-bit, non-prefetchable)
	Expansion ROM at 808a0000 [disabled]

01:01.0 IDE interface: CMD Technology Inc PCI0646 (rev 05) (prog-if
8f [Master SecP SecO PriP PriO])
	Subsystem: CMD Technology Inc: Unknown device 0646
	Flags: bus master, medium devsel, latency 64, IRQ 26
	I/O ports at fe001840
	I/O ports at fe001830
	I/O ports at fe001820
	I/O ports at fe001810
	I/O ports at fe001800
	Capabilities: [60] Power Management version 1

01:02.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c875 (rev 04)
	Flags: bus master, medium devsel, latency 255, IRQ 23
	I/O ports at fe001400
	Memory at 80880000 (32-bit, non-prefetchable)
	Memory at 80885000 (32-bit, non-prefetchable)
	Expansion ROM at 80940000

01:03.0 SCSI storage controller: Adaptec AIC-7881U
	Flags: bus master, medium devsel, latency 16, IRQ 24
	I/O ports at fe000000
	Memory at 80884000 (32-bit, non-prefetchable)
	Expansion ROM at 80890000 [disabled]

01:04.0 SCSI storage controller: Adaptec 7899A (rev 01)
	Subsystem: Adaptec: Unknown device f620
	Flags: bus master, 66Mhz, medium devsel, latency 16, IRQ 25
	BIST result: 00
	I/O ports at fe000000
	Memory at 80883000 (64-bit, non-prefetchable)
	Expansion ROM at 80900000 [disabled]
	Capabilities: [dc] Power Management version 2

01:04.1 SCSI storage controller: Adaptec 7899A (rev 01)
	Subsystem: Adaptec: Unknown device f620
	Flags: bus master, 66Mhz, medium devsel, latency 16
	BIST result: 00
	I/O ports at fe000000
	Memory at 80882000 (64-bit, non-prefetchable)
	Expansion ROM at 808e0000 [disabled]
	Capabilities: [dc] Power Management version 2

01:05.0 Class ff00: Apple Computer Inc. Paddington Mac I/O
	Flags: bus master, medium devsel, latency 16
	Memory at 80800000 (32-bit, non-prefetchable)

01:06.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
	Subsystem: OPTi Inc.: Unknown device c861
	Flags: bus master, medium devsel, latency 16, IRQ 28
	Memory at 80881000 (32-bit, non-prefetchable)


   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
