From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14793.38735.809789.111193@argo.linuxcare.com.au>
Date: Thu, 21 Sep 2000 16:06:23 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39C98739.B3656E8F@mvista.com>
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
	<14790.58502.25252.825448@argo.linuxcare.com.au>
	<20000919150621.A9826@cx258813-a.chnd1.az.home.com>
	<14791.61311.118516.747495@argo.linuxcare.com.au>
	<39C8DE1A.BC8EF0B6@mvista.com>
	<14793.18115.38314.912204@argo.linuxcare.com.au>
	<39C96EBC.6BE23535@mvista.com>
	<14793.29680.948198.119368@argo.linuxcare.com.au>
	<39C98739.B3656E8F@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> Yes....IMHO I think the PC is one of the worst architecture designs
> ever, and making my PowerMac or anything else live within those
> contraints isn't progress....

Well, your powermac has a PCI bus, and PCI has an I/O space as well as
a memory space (for better or for worse).

I think my basic point is that a setup where you can't do inb(n) to
read the byte at address n in PCI I/O space is broken.  On systems
with 1 PCI host bridge, this is unambiguous, on systems with >1 host
bridge inb(n) should access address n in PCI I/O space on the first
host bridge.

> Yes, _someone_ has to know, but when that is hardcoded into a driver,
> it isn't portable.  It's not at that address if it isn't on the first
> ISA bridge of the first PCI bus, either.  That's the basis of my
> suggestion that drivers don't assume where things are mapped.  The

In the case of I/O space, there isn't any mapping.  Address n in I/O
space is accessed with inb(n).

> What I am really suggesting is even if you know it is I/O space
> that requires in/out instructions, you should request an access
> address.

If you get a memory-mapped address then you should access it with
readb/writeb.

>  On a PC with a serial port in the Super I/O on the PCI
> bus you will still get 0x3f8 (or whatever it is, I never memorized
> these).  I don't know what you get on a PC with more than one
> PCI bus....

Since an intel CPU has only a single I/O space (just as it has a
single physical memory space) I assume that each PCI host bridge
has a window that passes accesses to I/O ports in certain ranges
through to the PCI bus behind it.  Hopefully the ranges are all
distinct. :-)

We could do that too, we would just have to make sure that we assigned
PCI I/O addresses so that no two bridges had devices in the same 4k
range, then we could set up the virtual->physical mapping to give the
illusion of a single I/O space.

> > > A driver should never simply 'inb(SERIAL_PORT_STATUS)' using some #define,
> >
> > Why not?
>
> Well, this is exactly why we are all discussing this right now.  It
> doesn't work on anything except a PC.

It doesn't work on anything except a PC, or a prep system, or a chrp,
or an alpha system, or a sun ultra 5, or anything else where the
designer has used a super-i/o chip because it is cheap and gives them
all the usual things they want.  In fact it works almost everywhere
except on powermacs and embedded systems. :-)

>  It won't even work with the
> changes you are suggesting (except for the local serial on a PMac).

Yes it will, why won't it?  In fact it won't work for on-board serial
on a pmac.

> It is marginally more useful if you adopt the inb(BAR) and do the
> mapping as you suggest.  That will be a PMac solution today for
> someone that plugs something into a PCI slot, but it will have to
> be hacked again when the next machine hits the street.

Huh???  the drivers won't have to be changed, they just go on doing
inb(pci_dev->resource[0].start) or whatever and that will go on
working.  If the next machine has a different PCI host bridge, then we
will need code to support it (whether or not we adopt my proposal).

> > Huh?  All I am proposing is that we set up the virtual -> physical
> > mapping in a certain way.
>
> Right, which works on the PMac, and requires drivers somehow find
> an address that will work with that mapping.

No, you must have misunderstood me somewhere I think.  For PCI memory
space accesses, nothing is changed.  For PCI I/O space accesses,
drivers get the base I/O address from the pci_dev->resource fields and
use the in/out family of macros.  Drivers don't have to look anywhere
except in pci_dev->resource[] and they use read*/write* for memory
space, in*/out* for I/O space.

> > ....  The I/O space of a host bridge has to be
> > accessible somewhere in the physical address space, that's the only
> > way it can be accessible.
>
> Yes, but somewhere isn't always mappable as conveniently as you
> can do it on the PMac today.

Can you give me an example of that?  If it's in physical address
space, how the heck could it not be mappable to virtual space?

> I don't think inb/outb should ever have to "cope" with address
> calculations.....

inb(n) should do whatever is necessary to access address n in PCI I/O
space.

> All I'm suggesting is that the address value you give to inb/outb
> is exactly what it needs to use, and it has to be stored in 32 (or
> 64) bits.  Any solution that maps multiple ISA busses has to do this,

I don't believe there are any systems with multiple ISA buses.  That
would be an abomination. :-)

> Yes, but you (and probably everyone else because of my poor writing)
> missed the point.  The Linux I/O macros map to appropriate machine
> specific functions.  If I _choose_ (for some reason because of some
> platform specific feature) to hand a driver an I/O address more suitable
> for what I know it can do, this abstraction allows that to happen.

Which the driver accesses how?  with read*/write* or with in*/out*?

I would be quite happy with an ioportremap that said "give me an
address that will let me access this region of PCI I/O space using
readb/writeb".  I suspect that the number of cases where that would be
useful would be quite small though, since most devices where it would
matter would have registers in PCI memory space.

> All I am suggesting are a few small things, that can grow into something
> much better.  If we can find a way for drivers to stop making mapping
> assumptions about the address space by asking for a "thing" to use
> in the in/out or whatever macros, and this "thing" (which would be
> an address on PowerPC or port on PC I/O) is not further adjusted by
> arithmetic in these macros, we end up with something more portable
> to more people.  You can still do your addressing mapping on the PMac,
> but you haven't forced me to find a way to perform address computations
> in these macros on other platforms by providing only a portion of the
> necessary information.

As far as your driver is concerned, it wants to access a register at
address n in PCI I/O space, so it does inb(n).  It wants to access a
register at address n in PCI memory space, it does readb(ioremap(n))
(in simple terms).  What address computations do you need to do?  What
other information do you need?

This discussion doesn't seem to be getting anywhere, either I am
misunderstanding you or you are misunderstanding me.  If you had a
concrete example of a situation where you see a problem that might
help clarify the issues.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
