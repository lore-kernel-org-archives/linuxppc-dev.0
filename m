Message-ID: <3BD06614.800C99E8@raleigh.ibm.com>
Date: Fri, 19 Oct 2001 13:42:44 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/kernel clutter
References: <15312.6740.808012.183783@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul,

I don't feel the PPC tree, or most of the developers, realize what's
happening in the Power PC hardware Arena.
The powerpc hardware is becoming increasingly diverse because  of the
IBM core connect technology.
CoreConnect allows hardware designers to easily reusable hardware cores
much like a programmer uses a subroutine.
(See www.chips.ibm.com).  (I am not sure what Mot has)

This allows IBM to quickly integrate different sets of peripherals to a
processor core.
One only has to look to the 405 to see the effects of this.  Announced
for the 405 are the
405CR, 405GP, NPE405H, NPE405L, the Ranier network processor, the 405LP
and the stb04xxx. There are also many CSSPs which
have 405 processor cores that have been designed or are in process.
These CSSP's  have peripherals that are not in any of the
of the released chips but are in IBM core library.  Many of these
CSSP's  have customer designed peripherals.
(This is NOT a sales pitch.  This is just to let everybody know that way
IBM (and probably Mot ) stitches processors
and peripherals together has changed. IE, It a LOT easier now to stich
together Processor cores and components
to make a CSSP. )

All of these chips have a different mix of on chip peripherals.  Given
the ease that the hardware designers
now have in creating chips, we need a PPC linux structure that
recognizes this.

The linux kernel ppc tree is going to have to become much more flexible
to recognize the incredible flexibility that
IBM and Motorola are  designing into the PPC hardware.

Chip

Paul Mackerras wrote:
>
> I feel that arch/ppc/kernel in the linuxppc_2_4_devel tree is getting
> more than a bit cluttered.  I propose that we make a new
> arch/ppc/platforms directory and move the platform-specific files into
> there - i.e. all of *_setup.c, *_pic.c, *_pci.c, and maybe some
> others.  What would be left in arch/ppc/kernel is the more generic
> stuff, i.e. things relating to the different base processors, the
> different types of interrupt controllers or PCI host bridges, the
> generic stuff that interfaces to the rest of the kernel (e.g. setup.c)
> and so on.
>
> My idea is that adding support for a new board would not normally
> require changes in arch/ppc/kernel unless the new board has a new type
> of interrupt controller, PCI host bridge, etc.
>
> Thoughts?  Objections?
>
> Another thing I would like to do is to generalize the drivers for the
> various on-chip peripherals a bit more.  The platform code would then
> specify in some way "this platform has an XYZZY on-chip ethernet
> controller with registers at 0xabcdef00, using interrupt 123, with
> quirks A, D and F".  (This sort of thing is what the OF device tree
> was designed for and does very well, BTW.)
>
> The configuration scripts could force CONFIG_XYZZY on when this
> platform is selected and that would compile in the xyzzy driver.
> The xyzzy driver initialization would get called during boot and would
> look up whether the platform has any XYZZY's, and if so, what
> addresses and interrupts to use.  So the XYZZY code doesn't need to
> know anything about which platforms have an XYZZY at all.
>
> This would be a bit of work in the short term to implement but would
> mean that we could potentially reuse code more easily for new
> platforms.  The idea is that if a new platform has an XYZZY, the
> platform setup code just has to create a device tree (or whatever)
> node for it, make sure the XYZZY driver is configured in, and it
> should (hopefully :) Just Work.
>
> This could extend to things like interrupt controllers and PCI host
> bridges as well as regular I/O devices, too.
>
> Paul.
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
