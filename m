Message-ID: <39C98739.B3656E8F@mvista.com>
Date: Wed, 20 Sep 2000 23:57:45 -0400
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
		<39C96EBC.6BE23535@mvista.com> <14793.29680.948198.119368@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> At the physical address level?  Can't we hide that at the virtual
> address level?

Yes....IMHO I think the PC is one of the worst architecture designs
ever, and making my PowerMac or anything else live within those
contraints isn't progress....

> If you have a super-I/O chip with a serial port at I/O address 0x3f8
> (for example), you just have to know that number, there's nothing that
> is going to tell you.

Yes, _someone_ has to know, but when that is hardcoded into a driver,
it isn't portable.  It's not at that address if it isn't on the first
ISA bridge of the first PCI bus, either.  That's the basis of my
suggestion that drivers don't assume where things are mapped.  The
one interface/function definition lacking in my proposal is a way for a
serial driver to ask a resource manager for the proper mapped address
to use to get to these things.  On a PC, it will get 0x3f8, but it
shouldn't assume that.

> Which ones in particular?

That I have modified or that need changing?  The ones I have modified
in the past are PCI Ethernet drivers that assumed they could hit I/O
in the lower 64K of memory.  They wouldn't work on an embedded system
that had a PCI/PCI bridge, and they also had some byte swapping problems.
You mentioned PMacs that require add-in serial cards on the second
PCI bus.  I am having lots of trouble with the SCSI adapters and I
would like to get to my FireWire ports on the G4.  These are a
combination of read/write trying to perform address arithmetic,
bridges not behaving, and believing too much OF is telling us.  I
also have some A/V cards that will probably never run in an x86 that
I have to write drivers for.

> Thereby assuming that all I/O is memory-mapped, making the driver
> non-portable to intel machines.

Well, not really.  The only thing not memory mapped on a PC are the
small ISA and PCI I/O spaces.  All of the PCI cards I have been
using recently (which admittedly are mostly audio/video or high
performance controllers) use PCI memory mapped access.

What I am really suggesting is even if you know it is I/O space
that requires in/out instructions, you should request an access
address.  On a PC with a serial port in the Super I/O on the PCI
bus you will still get 0x3f8 (or whatever it is, I never memorized
these).  I don't know what you get on a PC with more than one
PCI bus....

>
> > A driver should never simply 'inb(SERIAL_PORT_STATUS)' using some #define,
>
> Why not?

Well, this is exactly why we are all discussing this right now.  It
doesn't work on anything except a PC.  It won't even work with the
changes you are suggesting (except for the local serial on a PMac).
It is marginally more useful if you adopt the inb(BAR) and do the
mapping as you suggest.  That will be a PMac solution today for
someone that plugs something into a PCI slot, but it will have to
be hacked again when the next machine hits the street.

> Huh?  All I am proposing is that we set up the virtual -> physical
> mapping in a certain way.

Right, which works on the PMac, and requires drivers somehow find
an address that will work with that mapping.

> ....  The I/O space of a host bridge has to be
> accessible somewhere in the physical address space, that's the only
> way it can be accessible.

Yes, but somewhere isn't always mappable as conveniently as you
can do it on the PMac today.

> ..... then inb/outb will have to cope with
> that.  I hope it doesn't become necessary.

I don't think inb/outb should ever have to "cope" with address
calculations.....


> No, that's broken.  That's what I don't want.

Well, which is it?  Broken, or not what you want?

All I'm suggesting is that the address value you give to inb/outb
is exactly what it needs to use, and it has to be stored in 32 (or
64) bits.  Any solution that maps multiple ISA busses has to do this,
and PCI I/O has to do it anyway because of the address range.

> .....  That's an extra
> unnecessary incompatibility with intel.

I don't see the incompatibility.  If you want to support drivers
across a wide variety of platforms with multiple busses of any kind,
you have to provide an address that exists outside of the 64K ISA
window.  If you assume drivers can exist that hard code well known
ISA/PCI offsets into inb/outb, they will _only_ work on PC platforms.

> .....  Like it or not, not all
> devices are PCI, and most drivers are developed and tested on intel
> machines.

Well, there are lots of drivers on embedded processors that aren't
PCI and aren't Intel, but that isn't part of this discussion.

I fail to see why suggesting a driver requests (somehow) the address
(port, whatever) and uses that in the approprite in/out read/write
macro is incompatible with anything.  Even better, you can map it
however you wish on a PMac, Matt can do this thing on PReP, I can
use it on my cPCI 8260, someone else can use it on a PC, and we can
all use the same driver.

> The access functions for PCI memory space will always be distinct from
> the access functions for I/O space, because intel uses different
> instructions.  Sorry.

Yes, but you (and probably everyone else because of my poor writing)
missed the point.  The Linux I/O macros map to appropriate machine
specific functions.  If I _choose_ (for some reason because of some
platform specific feature) to hand a driver an I/O address more suitable
for what I know it can do, this abstraction allows that to happen.

> That's fine for devices with registers in PCI memory space.  For
> registers in PCI I/O space there are more constraints which mean that
> you can't do these optimizations.

Yes, you are correct.  Just like the people that asked for those
features.  Darwin is correct here as well.....

All I am suggesting are a few small things, that can grow into something
much better.  If we can find a way for drivers to stop making mapping
assumptions about the address space by asking for a "thing" to use
in the in/out or whatever macros, and this "thing" (which would be
an address on PowerPC or port on PC I/O) is not further adjusted by
arithmetic in these macros, we end up with something more portable
to more people.  You can still do your addressing mapping on the PMac,
but you haven't forced me to find a way to perform address computations
in these macros on other platforms by providing only a portion of the
necessary information.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
