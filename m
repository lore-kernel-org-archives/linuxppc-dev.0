Date: Thu, 29 Nov 01 14:15:10 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111292215.AA01078@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_init_hwif_ports
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


mod+linuxppc-dev@MissionCriticalLinux.com wrote:

> Not to quibble with your painfully accurate
> description of the VT82C686B, but might it be
> possible (using the IDE Interrupt Routing register
> at offset 0x4a in function 1) to arrange for both
> channels to use the same interrupt routing?
> Like force both to IRQ14?  Just a thought...

>From what I could tell the IDE interrupt routing is fixed by the board
circuitry *outside* the chip and cannot be changed by any register diddling. As
I said, I don't think the VT82C686B even knows when an IDE interrupt has
occurred. The interrupt lines from the IDE connectors are tied directly to the
IRQ14 and IRQ15 pins, the same ones that go to the ISA slot connectors. If one
of these pins goes high, the VT82C686B has no way of knowing that it's IDE or
something else on ISA using this IRQ is signaling an interrupt.

Then what does the supposed IDE Interrupt Routing register (at offset 0x4A in
function 0, I assume that's what you really meant) do? I have no idea. I
suspect that Via *tried* to make it standards-compliant and support both AT-
compatible and pure PCI IDE interrupt routing, but never fully got it. Consider
function 1's Interrupt Pin register (offset 0x3D). The Via manual says:

00h Legacy mode interrupt routing
01h Native mode interrupt routing

Yet it always reads as 00 and I couldn't get it to read as 01 or as anything
else.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
