Date: Wed, 7 Jun 2000 22:56:17 -0700
From: Matt Porter <mmporter@home.com>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: QUERY: Embedded PowerPC Linux?
Message-ID: <20000607225617.A11485@cx258813-a.chnd1.az.home.com>
References: <39243D0C.68406C9D@lucent.com> <slrn8iernk.lpg.mmporter@liberty.chnd1.az.home.com> <392C039D.D0645FBD@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <392C039D.D0645FBD@embeddededge.com>; from dan@netx4.com on Wed, May 24, 2000 at 12:30:21PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 24, 2000 at 12:30:21PM -0400, Dan Malek wrote:
> Matt Porter wrote:
> > I stub out all the chrp/pmac/prep garbage like "prom_init()" to make the
> > linker happy and have a reasonablly slim kernel for 29F040 boot flashes.
>
> We should try to find some common compressed boot image as well, or
> better define why they are different.  I started the 'mbxboot' long
> ago with the 8xx processors, and it has proved useful for the 8260
> as well.  It seems to be the place where all of the highly integrated
> processors boot because of their unique I/O devices.  The 'coffboot'
> directory is where all of the standard I/O (like PCI with 165xx serial
> ports) boards exist.

I think an embedded 6xx/7xx bootloader will remain separate since
most of these systems fall into mapping something close to PReP or CHRP
(even if they have a flexible bridge, unlike the Mot. Semi ones).  Off
topic: any chance we can change the "mbxboot" name?  It's kinda funny
since MBX is EOLed or on it's way to being EOLed.

Hmmm...prepboot has 165xx support as well...which is what I've adapted for
my ports.

> > I'm adding a (rather simplistic) PCI autoconfig routine to the pci_init()
> > call since a firmware/monitor is not always available or desired.
>
> Is this the right place for it, or should it be done prior to calling
> the Linux kernel?  I don't really know.  I have done this in both
> places, each has advantages and disadvantages.  For further discussion

I'm curious, what do you see as the disadvantages to enumerating the bus
late in the game?  I like just hooking up my indirect config space method
and using those calls rather than building something new the independent
bootloader.

> I am even considering a "PCI emulation" set of functions.  There are
> more and more boards with PCI type I/O devices, but attached to the
> processor busses instead of through a PCI bridge.  It would be nice to
> use the standard PCI drivers, but right now I have to hack up something
> custom because the PCI configuration functions don't make sense.  I
> think it would be useful to have these functions return something useful
> and use the standard driver.  Anyone else see this type of board design?

Sounds neat.

> > .......  The only intrusive thing I add is is a
> > CONFIG_EMBEDDED which arch/ppc/kernel/Makefile keys off of to not link
>
> Thank you.  That seems like a good thing.
>
> > One sore point is that MACH_<board> is defined as a single bit flag so we
> > will run out of those with the many MACH types that want to be in the
> > kernel in the near future.  That should probably get fixed up to something
> > with more longevity.
>
> I could never understand why this was a bit flag.  I think it would
> work equally well as a unique number, preferably monotonically increasing.
> These are used in switch statements and tested for their value.  I
> don't remember anything like 'if (_machine & MACH_<board>)'.

Exactly.  I can easily see over 32 MACH_<board>'s in the next year.

> > The other thing that needs to happen is that the directory structure
> > will need a reorg to avoid clutter
>
> Think very carefully about this.  A while back we broke head.S into
> head.S and head_8xx.S to avoid "clutter".  I wish we had not done that
> now.  There have been changes in the memory management and context
> switching that are done in head.S, and not to head_8xx.S (or attempted
> and not completed).  When generic changes are made, you have to visit
> all of the files affected and it is easy to miss them or ignore your
> duty to do so when they are separated.  I am all for avoiding the
> clutter in the files, but if you are in there making changes it should
> serve as a reminder that you are affecting many things you may have
> not considered.

Whoops.  I should have elaborated a bit more.  I've discussed this in
detail with Cort a while back and he seemed receptive to my idea of a
mostly cosmetic restructuring (it's at least a first phase).

Since I've only done 6xx/7xx work I'm not real sure where the 8xx stuff
fits into my view but the 6xx/7xx can probably be changed independently
for the first cut at this.

I'm basically looking at reorganizing directories plus the necessary
Makefile changes to reduce the klutter in arch/ppc/kernel/

It would now have something like:

arch/ppc/kernel/
		chrp
		gemini
		pmac
		prep
		<port a>
		<port b>

The generic stuff would either stay in kernel/ or move to kernel/common/
Since all of this is board/arch specific code, there is no maintainence
concern like when you split head.S for a different processor architecture.

I'm thinking that bootloaders should possibly move a little bit but
they're the least of my concern.

The next thing that goes with this is to free some of the independent
code from board specific files.  A good example is the m48t35 RTC driver
that is buried in the gemini_time.c.  Why not make it obvious to a
developer that the building block already exists?  I've already done
this for my current project but there are more things like that.

Next it would be great to abstract the find_end_of_memory calls from
setup.c so it's not necessary to add a new condition to call a board
specific routine if the kernel. Same thing in mm/init.c where the BATS
are set on non-8xx's.  The idea is to get to a point where it's only
necessary to add a few make rules and a directory of implement calls
for an existing processor family.

In between deadlines I'm experimenting with some different layouts so
eventually I'll pass something more solid in front of folks.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
