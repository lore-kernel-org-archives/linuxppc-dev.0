Date: Fri, 10 Aug 2001 10:38:04 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Porter <mporter@mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Hollis <hollis-lists@austin.rr.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP and generic PCI resource assignment
In-Reply-To: <20010809091402.A11768@beef.az.mvista.com>
Message-ID: <Pine.LNX.4.05.10108101034110.2083-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 9 Aug 2001, Matt Porter wrote:
> On Thu, Aug 09, 2001 at 12:18:33PM +0200, Benjamin Herrenschmidt wrote:
> > >At any rate, relocating PCI resource 1 on this controller from 0x0 to
> > >0x01000000 causes my VGA console to go backwards endian. I don't know why
> > >this would be the case... Re-moving it back to 0x0 fixes the symptom. Any
> > >ideas on why this could happen? I think VGA is all IO, no memory at all?
> >
> > VGA is both IO and memory. It's possible that your VGA card is so broken
> > that it only use the low-order bits of addresses and use the high addresses
> > as flags, for example to access a "bug endian" aperture :) That would suck
> > as it would mean you actually have address aliasing going on on the bus,
> > possiby causing weird conflicts.
> >
> > >I'm curious about PCIBIOS_MIN_MEM... Why does that exist, and why was it
> > >given that value?
> >
> > Note sure, I don't really like the way it's used and hard coded....
>
> That "generic" code has caused me a number of problem on many PCI
> equipped embedded platforms (not just PPC ones).  The algorithm
> used to pick PCI Mem space addresses ignores the fact that there are
> specific areas in CPU address space captured to generate mem cycles.
> >From my read of the code, it simply picks any old address that's
> not claimed by another resource starting at PCIBIOS_MIN_MEM.  That's
> braindead and probably just another x86ism that'll work on those
> platforms.

You should initialize the parent pointers in the PCI bus structure with
pointers to resources containing the correct region.

I once hardcoded the parents for the LongTrail, but that code is gone. Now it
tries to set up the parents from information in the OF device, which works
more or less. There are (or were, read as in `were the last time I tried it, a
few months ago) still some problems, though. One of them is that the hardcoded
ISA motherboard resources (i8259 and legacy stuff) are requested before PCI
resources are done, and that the PCI bus parent resources were not requested
and thus don't appear in the full resource tree.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
