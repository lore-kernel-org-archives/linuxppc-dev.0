Date: Tue, 19 Sep 2000 23:12:20 -0700
From: Matt Porter <mporter@mvista.com>
To: Paul Mackerras <paulus@linuxcare.com.au>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Message-ID: <20000919231220.A10511@cx258813-a.chnd1.az.home.com>
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home> <14790.58502.25252.825448@argo.linuxcare.com.au> <20000919150621.A9826@cx258813-a.chnd1.az.home.com> <14791.61311.118516.747495@argo.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14791.61311.118516.747495@argo.linuxcare.com.au>; from paulus@linuxcare.com.au on Wed, Sep 20, 2000 at 09:58:07AM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 20, 2000 at 09:58:07AM +1100, Paul Mackerras wrote:
>
> Matt Porter writes:
>
> > On Tue, Sep 19, 2000 at 02:59:02PM +1100, Paul Mackerras wrote:
> > > What I am intending to do is to map the I/O space of all the PCI host
> > > bridges in consecutive areas beginning at some address such as
> > > 0xff000000, with some amount of space such as 64kB or 1MB per bridge,
> > > whatever is appropriate.  Then we adjust the I/O port numbers in the
> > > pci_dev structures by adding on host_bridge_nr * space_per_bridge.  As
> > > a side effect, isa_io_base (which is really pci_io_base) becomes a
> > > constant.
> >
> > Specifically, what problem are you trying to solve with this
> > implementation?  I gather that we're talking about the legacy I/O
> > problem that the kernel has.  What are the cases where you need
> > to use in*/out* calls targetting devices on host bridges other
> > than the "primary" one?
>
> This is the situation: you have a machine with 2 or more PCI host
> bridges.  You plug a board into the PCI bus behind the 2nd host
> bridge.  The board has registers in PCI I/O space.  An address is
> assigned for those registers in the BAR in config space.  If you read
> the BAR and then do an inb from that port number, you don't get the
> I/O port on your board.

Ok then, that's what I described.

> One solution that has been proposed is to set the base I/O port number
> in the pci_dev structure to be actually the virtual address where you
> can access that I/O port.  I don't like that solution because it means
> that drivers for legacy PC-style devices can't do inb/outb to the
> usual well-known port numbers and find the device they expect.  For
> example, inb(0x3f8) won't access the first serial port (this is on
> machines such as prep and some chrp which have a lot of PC-style
> devices).

Ick...agree here.  Of course, the serial driver could be changed to
do other than inb/outb's for other archs and be passed the memory
mapped address of the ports.

> My solution is to allocate say 1MB of I/O space per host bridge and
> then adjust the pci_dev structures for the devices behind the 2nd and
> subsequent host bridges.  So for example a board that has I/O ports at
> 0x1000 behind the 2nd host bridge would end up with its
> pci_dev->resource[0].start == 0x101000.  The virtual <-> physical
> mappings are set up so that the 2nd host bridge's I/O space is mapped
> in starting at 0xff100000.  The result is that doing inb(0x101000)
> accesses the device as expected.

This looks to be a good solution if we can't resolve to make the kernel
less legacy-oriented.  I changed the default K2 board memory map to
do a similar thing by orienting the 2nd host bridge right after the
1st in the physical map.  The virt->phys mapping was then 1:1 and things
work as you describe above.  Obviously, this approach won't work when
you have separate bridge ASICs since you can't get the memory map
granularity that I had in the dual host bridge package.

> > I recently did a port to the SBS K2 cPCI board which involves the
> > IBM CPC710 dual host bridge.  Due to the multi host bridge legacy
> > I/O difficulty, a documented assumption is that legacy I/O calls
> > would only be used on the "primary" host bridge.  I realize there
> > are plenty of drivers (like de4x5) that insist on using inw/outw
> > (and thus break on host bridge 2) but these drivers should be
> > fixed.
>
> Fixed how?  I mean, how are you generically going to access PCI I/O
> space without using inw/outw etc.?  On intel that is the only possible
> way to do it so I just cannot see that you will persuade driver
> authors that they shouldn't use inw/outw.

Well, on drivers like the de4x5 you switch to use the mem bar instead
of the I/O bar and then it's generic.  There are lots of drivers that
given the choice, chose to use I/O calls.  These can easily be fixed.

> > In the long run, the legacy I/O compatibility calls need to be
> > completely wiped out for non-x86 architectures.  It is all
> > memory mapped after all and only a few drivers like serial and
> > IDE would need separate low level access paths for x86/non-x86
> > architectures.
>
> I disagree.  There will always be PCI devices with registers in PCI
> I/O space.  I really don't want to see a situation where drivers get
> littered with ifdefs because you have to use different access
> functions for accessing PCI I/O space on non-intel machines and intel
> machines.  That would be just totally counter-productive.

PCI I/O is memory mapped on everything but x86.  In most cases PCI
devices provide bars that map the same set of registers into both
I/O space and mem space.  That leaves only the true legacy devices
which have no memory bars to be concerned with.  It's a smaller
set of drivers that need different low level access methods than
you're making it out to be.

> > If we can't cover I/O with a BAT then it will definitely have some
> > ramifications with serial ports in the legacy I/O range among other
> > things.
>
> Why?  Are you concerned about very early debugging?  If not, what?

Sure, that is a convenience of the BAT mapping.  It can all be
fixed though if that's the answer you're looking for. :)

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
