Message-ID: <392C039D.D0645FBD@embeddededge.com>
Date: Wed, 24 May 2000 12:30:21 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: mporter@mvista.com
CC: tjroberts@lucent.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: QUERY: Embedded PowerPC Linux?
References: <39243D0C.68406C9D@lucent.com> <slrn8iernk.lpg.mmporter@liberty.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:


> .....  The assumption is that 6xx/7xx/7xxx are only
> chrp/pmac/prep desktop systems and 8xx/82xx are embedded systems but that
> is changing quickly.

Some further information.  The 8240 it really a 603/PCI configuration.
I followed Cort's Gemini port for most of this.  The 8260 is a 603 along
the path of the 8xx/CPM configuration.

> I stub out all the chrp/pmac/prep garbage like "prom_init()" to make the
> linker happy and have a reasonablly slim kernel for 29F040 boot flashes.

We should try to find some common compressed boot image as well, or
better define why they are different.  I started the 'mbxboot' long
ago with the 8xx processors, and it has proved useful for the 8260
as well.  It seems to be the place where all of the highly integrated
processors boot because of their unique I/O devices.  The 'coffboot'
directory is where all of the standard I/O (like PCI with 165xx serial
ports) boards exist.


> I'm adding a (rather simplistic) PCI autoconfig routine to the pci_init()
> call since a firmware/monitor is not always available or desired.

Is this the right place for it, or should it be done prior to calling
the Linux kernel?  I don't really know.  I have done this in both
places, each has advantages and disadvantages.  For further discussion
I am even considering a "PCI emulation" set of functions.  There are
more and more boards with PCI type I/O devices, but attached to the
processor busses instead of through a PCI bridge.  It would be nice to
use the standard PCI drivers, but right now I have to hack up something
custom because the PCI configuration functions don't make sense.  I
think it would be useful to have these functions return something useful
and use the standard driver.  Anyone else see this type of board design?

> .......  The only intrusive thing I add is is a
> CONFIG_EMBEDDED which arch/ppc/kernel/Makefile keys off of to not link

Thank you.  That seems like a good thing.

> One sore point is that MACH_<board> is defined as a single bit flag so we
> will run out of those with the many MACH types that want to be in the
> kernel in the near future.  That should probably get fixed up to something
> with more longevity.

I could never understand why this was a bit flag.  I think it would
work equally well as a unique number, preferably monotonically increasing.
These are used in switch statements and tested for their value.  I
don't remember anything like 'if (_machine & MACH_<board>)'.

> The other thing that needs to happen is that the directory structure
> will need a reorg to avoid clutter

Think very carefully about this.  A while back we broke head.S into
head.S and head_8xx.S to avoid "clutter".  I wish we had not done that
now.  There have been changes in the memory management and context
switching that are done in head.S, and not to head_8xx.S (or attempted
and not completed).  When generic changes are made, you have to visit
all of the files affected and it is easy to miss them or ignore your
duty to do so when they are separated.  I am all for avoiding the
clutter in the files, but if you are in there making changes it should
serve as a reminder that you are affecting many things you may have
not considered.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
