To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC823 Single-Buffer Burst Fly-By Mode
MIME-Version: 1.0
Message-ID: <OF6C4649C4.C40D1EAF-ONC1256A7F.002CD838@matrix-vision.de>
From: "Howard Gray" <hgray@matrix-vision.de>
Date: Wed, 4 Jul 2001 10:39:49 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone had any success getting the "Single-Buffer Burst Fly-By Mode"
(UM 16.6.3.11.4) on the MPC823 to work?

I am using our own hardware which with a recent revision CPU
(XPC823EZT66B2) so I shouldn't need to download the IDMA microcode patch.
I want to be able to DMA image data from a peripheral (CMOS sensor + FPGA)
directly into main memory.

The parameter RAM organisation for Single-Buffer Burst Fly-By Mod is
different than that used for other IDMA modes so the example in the
Motorola Engineer's Toolbox doesn't help much.

I've followed the instructions in the user manual i.e....

1. Issued a STOP command to the CPCR and waited for the FLG flag to clear.
2. Setup DCMR in the parameter RAM (non-interlaced mode, others except
BAPR and BCR not needed ?)
3. Set EIE to 1 and DR1M in the RCCR appropriately.
4. Issued an INIT command to the CPCR and waited for the FLG flag to
clear.
5. Setup IDMR1 mask register to use the DONE bit and cleared it in IDSR1.
6. Setup BAPR and BCR in the parameter RAM.
7. Set DREQ1 bit to 1 in PCSO to enable IDMA.

(It seems that I buffer descriptors are not used and don't need to be
setup).

Nothing seems to happen. Nothing is transferred when *DREQ1 is asserted so
that the DONE bit in the IDSR1 status register never appears.

An interrupt-driven version without IDMA works already but I would like to
try out IDMA (even though it has got some bad press in this list before).
Any help would be appreciated.

Thanks,

--
Howard D. Gray


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
