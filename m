Message-ID: <39C9AFE2.25CB0ADA@mvista.com>
Date: Thu, 21 Sep 2000 02:51:14 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
		<14790.58502.25252.825448@argo.linuxcare.com.au>
		<20000919150621.A9826@cx258813-a.chnd1.az.home.com>
		<14791.61311.118516.747495@argo.linuxcare.com.au>
		<39C8DE1A.BC8EF0B6@mvista.com>
		<14793.18115.38314.912204@argo.linuxcare.com.au>
		<39C96EBC.6BE23535@mvista.com>
		<14793.29680.948198.119368@argo.linuxcare.com.au>
		<39C98739.B3656E8F@mvista.com> <14793.38735.809789.111193@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I actually think we are in nearly violent agreement, and I am getting
way too tired tonight to continue much further.....

Paul Mackerras wrote:

> Well, your powermac has a PCI bus, and PCI has an I/O space as well as
> a memory space (for better or for worse).

Agree fully.

> I think my basic point is that a setup where you can't do inb(n) to
> read the byte at address n in PCI I/O space is broken.

I agree.  I am not suggesting you shouldn't.  I'm just discussing
what 'n' should be :-).

> ....  On systems
> with 1 PCI host bridge, this is unambiguous, on systems with >1 host
> bridge inb(n) should access address n in PCI I/O space on the first
> host bridge.

Only if 'n' is a hard coded (or nearly) number that the programmer
assumed would exist on all systems.


> In the case of I/O space, there isn't any mapping.  Address n in I/O
> space is accessed with inb(n).

Of course it is mapped.  On an x86 it is a hardware wire that selects
one of two address spaces.  On other systems it selects an address
range that causes the PCI bridge to generate the I/O cycle instead of
a memory cycle on the PCI bus.  You can effectively think of in/out and
read/write as selecting the most significant address bit of the I/O bus.

Some of the confusion may be an overloaded use of the word 'map', but
we will solve that with examples :-).

> If you get a memory-mapped address then you should access it with
> readb/writeb.

If you are accessing an I/O bus memory space, you use readb/writeb.
If you are accessing an I/O bus I/O space, you use inb/outb.

The "handle" (address) you use in the in/out or read/write will be
mapped through the MMU of any processor other than the x86.  On the
x86, the in/out will use a value that makes sense with the in/out
instructions.

> We could do that too, we would just have to make sure that we assigned
> PCI I/O addresses so that no two bridges had devices in the same 4k
> range, then we could set up the virtual->physical mapping to give the
> illusion of a single I/O space.

I think we agree that we just use the PCI bridges to the best of
their ability, and let the MMU do the reset.  There are combinations
of this that are more efficient on some systems that others.  I have
no illusion of requiring a single I/O space (that's what MMUs are for :-).

> It doesn't work on anything except a PC....
> .....  In fact it works almost everywhere
> except on powermacs and embedded systems. :-)

OK, ok :-)....You copy a PC, you get a PC, I get the point :-).

> Huh???  the drivers won't have to be changed, they just go on doing
> inb(pci_dev->resource[0].start) or whatever

Ahhhh...OK....here we go...examples :-).  I contend that access is
wrong...

Somewhere (and I thought it was in that resource structure), you need
the BAR of that device on it's PCI bus.  You also need something that
indicates how that device is mapped through PCI bridges.  If
	pci_dev->resource[0].start is the BAR of the device
this isn't likely to work on many platforms.  I believe what a
device needs to do is something like:

	base = how_do_I_get_to(pci_dev, resource0);
	inb(base);

Or, even better (if you don't know the spaces):

	requires_io = is_pcidev_io(pci_dev, resource0);
	base = how_do_I_get_to(pci_dev, resource0);
	if (requires_io)
		inb(base)
	else
		readb(base)

Yes, you can map the PCI speces through the MMU and hack up the
pci_dev resources to make the address work.  I believe you need to
have this abstraction, not assume in/out or read/write will perform
address computation, and have hooks into the platform specific
support to efficiently "map" this as resources allow.

You can extrapolate this into other busses, and I am sure somehow
get something like the ISA serial port to return 0x3f8 (I memorized
this now :-) for the PC, or whatever is appropriate for other systems.

You can even dynamically manage the I/O (memory or I/O to the I/O bus)
resources because you have some idea about what is actually used.
Although this example is pretty simple (address mapping usually is),
when you start adding things like interrupt routing, inter-device
DMA, hot swapping, and backplane networking there are more things a
driver just can't assume to be simply pulled from a data structure.


> ..... Drivers don't have to look anywhere
> except in pci_dev->resource[] and they use read*/write* for memory
> space, in*/out* for I/O space.

I just don't think pci_dev->resource is the place to look, nor is
using "assumed" values in any access.  Just break the habit of doing
this.  I should be able to use usb_dev, or vme_dev, or firewire_dev
(well, perhaps just vme_dev :-) as easily as pci_dev.  There should
probably be a higher level naming abstraction above this (like OF :-)
so you can just ask for the serial port and not care where that device
exists.

> Can you give me an example of that?  If it's in physical address
> space, how the heck could it not be mappable to virtual space?

My point was only that I may not be able to map it into nice 64K or
1M offsets like you do on the PMac.  It depends upon how the bus is
allocated among on-board devices and trying to use single MMU entries
to map larger spaces.  You can map anything to nearly anywhere, but
for I/O you like to find a more efficient solution, and some mapping
has alignment restrictions based upon attributes (cache, byte swapping,
etc.).  The address computations may become more than just simple
add/shift, and require more complex operations when it is just easier
to provide another address.

> inb(n) should do whatever is necessary to access address n in PCI I/O
> space.

Ummm...no :-).  inb is an x86 instruction and you have to use it on
that platform.  It's a wart they have to live with.  I think Linux
should have a isa_io() macro or something (that works like I want :-),
but we have sort of implied inb/outb will do that for us....

> I don't believe there are any systems with multiple ISA buses.  That
> would be an abomination. :-)

How about microchannel :-).


> I would be quite happy with an ioportremap that said "give me an
> address that will let me access this region of PCI I/O space using
> readb/writeb".

That's not really what I meant, although it would work great on
everything but x86....I just think if you use in/out, you should
still have to ask "give me something to access this region".

> As far as your driver is concerned, it wants to access a register at
> address n in PCI I/O space, so it does inb(n).  It wants to access a
> register at address n in PCI memory space, it does readb(ioremap(n))
> (in simple terms).  What address computations do you need to do?

None, if 'n' or the result of ioreamp() (I don't like that function
much either :-), is ready to be used.  I just don't like doing all of
the arithmetic in the in/out read/write macros.  That should all be
done more intelligently by some platform functions only once.

> This discussion doesn't seem to be getting anywhere,

Is it any better now?  I am really tired.....more later...

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
