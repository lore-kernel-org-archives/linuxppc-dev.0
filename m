Message-ID: <3C0814AC.455D6FEA@mvista.com>
Date: Fri, 30 Nov 2001 15:22:20 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: paulus@samba.org
Cc: Ralph Blach <rcblach@us.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
References: <OF04BCE99E.8AF57CF2-ON85256B14.00425D94@raleigh.ibm.com > <15368.891.368917.13579@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> Ralph Blach writes:
>
> > This does not take into account the embedded world at all.
> > The correct form of the file should be asm-ppc/core/chip/revsion/board
> >
> > This is because the IBM Core Connect and the Motorola OCEAN internal
> > interconnect systems.
> >
> > These allow for a 405/book E/Mot processor cores to be customized around a
> > large set of
> > customized on chip perphials.  It will make the availabily of a large
> > number different
> > customized chips with different on chip perphials available.
> >
> > Thats my justification for core/chip
>
> How is the kernel supposed to know what on-chip peripherals exist?
> By the CPU version/revision numbers?  Are you *always* going to change
> the cpu revision number when you change the set of on-chip
> peripherals?  Or will the kernel have to "just know" what on-chip
> peripherals there are?

I'm not sure why Ralph added revision into the mix.  The chip should be
sufficient to define the set of on-chip peripherals.  Some concrete
examples of core / chip / board are:

  403
    403GCX
  405
    405cr
    405gp
      walnut
      cpci405
      ep405
    stb03xxx
      redwood-4
    NPe405H
    NPe405L

> The scenario you outline leads me to think that we should flatten the
> structure, rather than making a very deep hierarchical structure as
> you suggest.  What I mean is that we should structure things so that
> we have a collection of device drivers for various on-chip devices, a
> collection of PCI host bridge drivers, a collection of interrupt
> controller drivers, etc.  And these drivers should not make any
> assumptions about addresses etc.

(I use the word "processor" as a synonym for "chip" in the following.)

Yes, that was the direction I was headed in with my original 4xx work.
Implementation didn't always match the goals, but that's where I was
headed.  Many of the drivers still need some work to be properly
generalized (eg ethernet driver able to handle multiple EMACS on a
single processor, i2c driver able to handle multiple i2c busses [which
was done for the redwood-4 but doesn't seem to have shown up in the
tree yet]).

The IBM "Blue Logic" device cells tend to be compatible or consistent
versions so far (empirical observation) and IBM has told me that I
should expect the DCR register block for a device to be consistent
accross processors.  So a foobar controller may have a control register
at offset 0 within the block, an interrupt status register at offset 4
within the block, and an error status register at offset 8 within the
block.  The driver simply has to know what the base address of the
block is for a given processor.

There are a few devices that have not been consistent from processor
to processor.  GPIO seems especially processor specific.  The interrupt
controller is mostly the same, but may or may not have a cascade level.


> Then for each platform we have a device tree, or some similar kind of
> database, that tells us what devices are where and how they are
> connected.  We could consider using such a database at config time as
> well as at run-time.  The database could be supplied statically by the
> board support package or it could be supplied at runtime by the boot
> loader.


The original 4xx design was to have the block of DCR registers for a device
defined in a single place (could be the device's header file or a more
central header file, whatever is preferred).  Then the address of the
base of each block was defined for each target, where target could be
either processor or processor/board, depending on which defined the
address.  That is the intent of the DCRN_*_BASE #defines in headers like
include/asm-ppc/platforms/ibm405gp.h.  Unfortunately in the merge from
my tree to the ppc tree the definition of the block of DCR registers
also got replicated into the same header that contains the address
of the block.  That should be cleaned up - each block should be defined
just once (except maybe those like GPIO that vary significantly with
each processor).

One nice thing about the way the block of DCR registers are defined is
that if the constant providing the base address of the block is not
defined, then the DCRs in the block are defined to be zero and the
mfdcr() and mtdcr() macros will detect the zero value and not attempt
to access a non-existent DCR.  mfdcr() returns zero in this case and
mtdcr() does nothing.  This means that, if used carefully, there are
many cases where there is no need to use #ifdefs to decide whether
to access a DCR or not.


> Basically I want the knowledge that "because this is a 405gp chip we
> must have an XYZ ethernet controller at address FOO using interrupt
> N" to be concentrated in one place, not spread out through the
> code.  Then when IBM brings out a 405gp-A that has two XYZ's (neither
> of which are at the same address as in the 405gp) there is just one
> place that we have to change.
>
> > This is my justification for Revision, because different Chip Revision will
> > Have differnet Expansion
> > instruction sets.  The following statements have HUGE implecation on
> > Libraries, because the loader will have to load correct library
> > according to Chip Revision.

Oh, this is where you explain revision.  Will instruction set really
change with revision, or with processor name?


> It's more a problem for the distributions - they will need to make
> sure the correct libraries get installed.  My guess is that most
> libraries will end up not using the extra instructions.


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
