From: "Andy Lowe" <andy_lowe@mvista.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH and RFC] Remove request_8xxirq
Date: Thu, 20 Jun 2002 21:32:22 -0500
Message-ID: <DIEAKNAFAEAMABGFAOOKCEIKDIAA.andy_lowe@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I guess since my name keeps coming up in this thread I should weigh in.

Dan Malek wrote:
> There is more to these patches than just the interrupt change. Why is
> the CPM microcode, and so much of commproc.c changed?

As Tom already replied, the CPM microcode stuff was included by mistake.  I
wouldn't necessarily recommend submitting that stuff as a separate patch
either.  There are also a few other perfectly good bits and pieces of code
that found their way into the patch that aren't relevant:  the SPI stuff in
commproc.h, the PCI and PCMCIA stuff in mbx.h, and the Ethernet stuff in
rpxclassic.h.

Dan Malek wrote:
> The PCI on MBX does not work well, and this does nothing to improve it.
Does
> anyone have a working MBX anymore?

This patch does not fix PCI on the MBX because additional changes are
necessary to the qspan host bridge code.  However, it does facilitate making
PCI work on the MBX and other 8xx designs because it allows request_irq() to
work, which all PCI device drivers use to install their interrupt handlers.
I have a working MBX, and with these changes to the interrupt handling and a
few additional changes to the qspan host bridge support, PCI cards seem to
work in it just fine.  I have successfully tested a Matrox video card,
several different Ethernet cards, and an MPEG decoder.  I also used these
same interrupt handling changes on a custom 860 board with a qspan bridge
that had PCI interrupts pinned out to both SIU IRQs and CPM Port C
interrupts instead of an 8259, and that worked as well.

Dan Malek wrote:
> I know Andy is sitting on a ton of 82xx PCI changes that would be nice
> to see checked in some day. :-)

I did do some work once on a custom 8260 board with an external PCI host
bridge.  I didn't have to do anything to the 8260 interrupt handling other
than rename request_8xxirq to request_irq so that PCI device drivers would
work without modification.  Other than that, it was just a matter of
implementing the host bridge support and PCI interrupt routing table
similarly to the way it is done on, say, the 7xx board ports.

Wolfgang Denk wrote:
> Isn't this more or less the same idea as presented by Wolfgang Grandegger
more
> than half a year ago?

Yes, it is more or less the same idea.  There is an important difference
between our approaches, however.  Wolfgang's approach was to extend
request_8xxirq() so that it would handle CPM interrupts as well as SIU
interrupts.  My approach was to make request_irq() work for SIU interrupts,
CPM interrupts, and any other interrupt controller (like an 8259) you might
have on a particular board.  I also implemented it in a way that allows you
to simultaneously continue using request_8xxirq() and cpm_install_handler()
in the same manner as always without the need for any kernel configuration
options.  (Tom changed every instance of cpm_install_handler and
request_8xxirq to request_irq in his version of the patch, but that isn't
strictly necessary.)  My motivation for doing this in the first place was to
make request_irq() work for all interrupts on 8xx targets so that standard
PCI and PCMCIA device drivers will work without having to put #ifdef's in
each driver to change request_irq to request_8xxirq or cpm_install_handler.

Now as for the argument that this patch is fatally flawed because IRQ
vectors 0 to 15 aren't reserved for 8259 interrupts, I don't find that to be
compelling.  PCI cards work just fine on the MBX with no modifications to
the drivers when using IRQ vectors 48 to 63 for the 8259.  You just stick
the right IRQ vectors in the PCI interrupt routing table and all PCI device
drivers will happily use them without prejudice.  PCMCIA and IDE drivers
also work fine.  The only possible issue I see is with legacy ISA drivers
with hardcoded IRQ vectors in the range 0 to 15.  I've never had an occasion
to use such a driver on an 8xx target, but if it came down to it I would
prefer to stick a #ifdef in an ISA device driver to hardcode a different IRQ
vector than to stick a #ifdef in every PCI and PCMCIA device driver to make
them call request_8xxirq or cpm_install_handler instead of request_irq.

Andy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
