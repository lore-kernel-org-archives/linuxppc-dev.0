Date: Thu, 21 Sep 2000 15:44:51 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: Dan Malek <dan@mvista.com>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <14793.38735.809789.111193@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.10.10009211536590.375-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Sep 2000, Paul Mackerras wrote:
> Dan Malek writes:
>
> > Yes....IMHO I think the PC is one of the worst architecture designs
> > ever, and making my PowerMac or anything else live within those
> > contraints isn't progress....
>
> Well, your powermac has a PCI bus, and PCI has an I/O space as well as
> a memory space (for better or for worse).
>
> I think my basic point is that a setup where you can't do inb(n) to
> read the byte at address n in PCI I/O space is broken.  On systems
> with 1 PCI host bridge, this is unambiguous, on systems with >1 host
> bridge inb(n) should access address n in PCI I/O space on the first
> host bridge.

And how do you handle accesses to PCI I/O space on the other busses?

> > Yes, _someone_ has to know, but when that is hardcoded into a driver,
> > it isn't portable.  It's not at that address if it isn't on the first
> > ISA bridge of the first PCI bus, either.  That's the basis of my
> > suggestion that drivers don't assume where things are mapped.  The
>
> In the case of I/O space, there isn't any mapping.  Address n in I/O
> space is accessed with inb(n).

`The I/O space' is the union of all I/O spaces behind all bridges.

> >  On a PC with a serial port in the Super I/O on the PCI
> > bus you will still get 0x3f8 (or whatever it is, I never memorized
> > these).  I don't know what you get on a PC with more than one
> > PCI bus....
>
> Since an intel CPU has only a single I/O space (just as it has a
> single physical memory space) I assume that each PCI host bridge
> has a window that passes accesses to I/O ports in certain ranges
> through to the PCI bus behind it.  Hopefully the ranges are all
> distinct. :-)

That's indeed how it's supposed to work (AFAIK).

> We could do that too, we would just have to make sure that we assigned
> PCI I/O addresses so that no two bridges had devices in the same 4k
> range, then we could set up the virtual->physical mapping to give the
> illusion of a single I/O space.

I think the mapping from 8 (not 64, IIRC) consecutive I/O port addresses to 1
4K page was meant exactly to solve this problem.

> > > > A driver should never simply 'inb(SERIAL_PORT_STATUS)' using some #define,
> > >
> > > Why not?
> >
> > Well, this is exactly why we are all discussing this right now.  It
> > doesn't work on anything except a PC.
>
> It doesn't work on anything except a PC, or a prep system, or a chrp,
> or an alpha system, or a sun ultra 5, or anything else where the
> designer has used a super-i/o chip because it is cheap and gives them
> all the usual things they want.  In fact it works almost everywhere
> except on powermacs and embedded systems. :-)

Even some embedded systems have Super I/Os :-)

But: Super I/O is legacy I/O, and always present on the first bus (starting at
I/O space address 0). I never heard of a system with a Super I/O on a
different bus, but of course no one prevents me from building a system like
that...

Legacy I/O is also limited to 10 bit addresses. This knowledge could optimize
the size of my translation table (cfr. my previous mail).

> > I don't think inb/outb should ever have to "cope" with address
> > calculations.....
>
> inb(n) should do whatever is necessary to access address n in PCI I/O
> space.

Yes indeed.

> > All I'm suggesting is that the address value you give to inb/outb
> > is exactly what it needs to use, and it has to be stored in 32 (or
> > 64) bits.  Any solution that maps multiple ISA busses has to do this,
>
> I don't believe there are any systems with multiple ISA buses.  That
> would be an abomination. :-)

IIRC the spec allows only one PCI/ISA bridge, and it has to be on the first
PCI bus so legacy I/O accesses work.

And we still didn't mention the nightmare called ISA memory space... Where is
your legacy VGA memory?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
