Date: Thu, 21 Sep 2000 16:03:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dan Malek <dan@mvista.com>
cc: paulus@linuxcare.com.au,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39C9AFE2.25CB0ADA@mvista.com>
Message-ID: <Pine.LNX.4.10.10009211544591.375-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Sep 2000, Dan Malek wrote:
> > I think my basic point is that a setup where you can't do inb(n) to
> > read the byte at address n in PCI I/O space is broken.
>
> I agree.  I am not suggesting you shouldn't.  I'm just discussing
> what 'n' should be :-).

`n' is the offset as accepted by the bus bridge, being it a host bridge or a
PCI-PCI bridge, or a PCI-ISA bridge (with subtractive decoding (`claim all
accesses that are not claimed by any other device on the bus') for legacy I/O.

The first bridge (`host bridge 1') takes I/O addresses 0..n1-1, the next one
n1..n2, and so on.

> > We could do that too, we would just have to make sure that we assigned
> > PCI I/O addresses so that no two bridges had devices in the same 4k
> > range, then we could set up the virtual->physical mapping to give the
> > illusion of a single I/O space.
>
> I think we agree that we just use the PCI bridges to the best of
> their ability, and let the MMU do the reset.  There are combinations
> of this that are more efficient on some systems that others.  I have
> no illusion of requiring a single I/O space (that's what MMUs are for :-).

And how to access PCI I/O space from user space? There the MMU doesn't help,
since the user application (usually XFree86) just look at the BARs from
/proc/bus/pci/...

> > Huh???  the drivers won't have to be changed, they just go on doing
> > inb(pci_dev->resource[0].start) or whatever
>
> Ahhhh...OK....here we go...examples :-).  I contend that access is
> wrong...
>
> Somewhere (and I thought it was in that resource structure), you need
> the BAR of that device on it's PCI bus.  You also need something that
> indicates how that device is mapped through PCI bridges.  If
> 	pci_dev->resource[0].start is the BAR of the device
> this isn't likely to work on many platforms.  I believe what a
> device needs to do is something like:
>
> 	base = how_do_I_get_to(pci_dev, resource0);
> 	inb(base);
>
> Or, even better (if you don't know the spaces):
>
> 	requires_io = is_pcidev_io(pci_dev, resource0);
> 	base = how_do_I_get_to(pci_dev, resource0);
> 	if (requires_io)
> 		inb(base)
> 	else
> 		readb(base)

This is very similar to what many people already suggested on linux-kernel
years ago: inb() and friends should take an additional argument pci_dev *.

> Yes, you can map the PCI speces through the MMU and hack up the
> pci_dev resources to make the address work.  I believe you need to
> have this abstraction, not assume in/out or read/write will perform
> address computation, and have hooks into the platform specific
> support to efficiently "map" this as resources allow.

For kernel space. This doesn't work for user space, unless you mmap
/dev/pci_{io,mem}_space, which don't exist at the moment.

> You can extrapolate this into other busses, and I am sure somehow
> get something like the ISA serial port to return 0x3f8 (I memorized
> this now :-) for the PC, or whatever is appropriate for other systems.

Currently the serial driver relies on the arch-specific #define
SERIAL_PORT_DFNS to know which legacy ports to probe. This should at least
become machine-specific, to support PowerMacs.

BTW, I have Linus' tree only here, and I see it still has STD_COM_FLAGS for
ttyS[0-2] and STD_COM4_FLAGS for ttyS3. The difference between these is that
STD_COM_FLAGS contains ASYNC_SKIP_TEST to skip some presence detect. IIRC,
this was the reason serial.c found a bogus ttyS2 on my LongTrail. So touching
non-existent ports on non-PCs can give weird results...

> > inb(n) should do whatever is necessary to access address n in PCI I/O
> > space.
>
> Ummm...no :-).  inb is an x86 instruction and you have to use it on
> that platform.  It's a wart they have to live with.  I think Linux
> should have a isa_io() macro or something (that works like I want :-),
> but we have sort of implied inb/outb will do that for us....
>
> > I don't believe there are any systems with multiple ISA buses.  That
> > would be an abomination. :-)
>
> How about microchannel :-).

Microchannel is something different.

inb() resp. readb() and friends are explicitly meant for PCI I/O resp. memory
space only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
