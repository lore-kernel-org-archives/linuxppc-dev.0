Date: Fri, 29 Sep 2000 13:37:45 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>, Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <19340823125112.7591@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10009291319510.383-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Sep 2000, Benjamin Herrenschmidt wrote:
> >> I'm not sure it would help. It would probably allow a kind of "mapping on
> >> demand" of the IO region on memory mapped IOs platforms, but unless we
> >> add another parameter to ioportremap telling it the pci_dev (or at least
> >> the bus number), we can't "guess" on which IO bus the device is and which
> >> physical base we must use.
> >
> >But we can find out the IO bus by looking in which region the physical
> address
> >is located, right? Or do we have the same region on different IO busses?
> >That would be really weird! Different IO busses should decode different
> >regions.
>
> That mean that you intend to feed a physical address to ioportremap and
> not an IO address ? Hrm... that mean we need to have the physical address
> in the device IO resources instead of the content of the IO BAR. Well,
> how should this work for legacy devices, then ? By assuming addresses
> below 64k are legacy IO (hard coded) addresses ? I don't like it too much.

No, I meant I/O addresses. Each PCI bus should decode different I/O addresses,
just like it decodes different memory addresses.

Say the first bus decodes I/O 0x0000-0x0fff, the second one decodes
0x1000-0x1fff, and so on. If the different busses have different physical
addresses, you have to use the region decoding from my previous mail. Hence
ioportremap() would move the burden (and overhead) of the region decoding from
inb() and friends to one single place: ioportremap().

> The more I think about it, the more I want to separate legacy IO macros
> and PCI IO macros :)

That's impossible since legacy I/O macros _are_ PCI I/O macros.


On Fri, 29 Sep 2000, Benjamin Herrenschmidt wrote:
> >Essentially we have two cases with inb/outb - ISA devices and PCI
> >devices.  The ISA devices we handle by making sure that inb(0x3f8)
> >hits I/O address 0x3f8 on the first PCI host bridge.  The PCI devices
> >we handle by setting the pci_dev->resource[].start values to account
> >for any mapping we need to do.
> >
> >My proposal would simplify inb/outb by making _IO_BASE a constant
> >rather than a variable.
>
> Well, the ISA space would be on a fixed bus, but not necessarily bus 0
> (please  ;)

IIRC, it has to be on bus 0, according to the PCI spec.

> On uninorth, with the new bus remap code, the PCI slots will be bus 2 or
> something like that. Ideally, the arch would tell you which bus to map
> first, possibly overriden by a kernel arg.

On a PC, the PCI bus (with ISA) is bus 0, while AGP is on bus 1.

Hmm, I'm starting to wonder how legacy VGA works then, since the primary video
card these days is usually on the AGP bus, i.e. bus 1. But it's quite possible
this is some weird legacy quirk again...


On Thu, 28 Sep 2000, Michel Lanners wrote:
> On  28 Sep, this message from Geert Uytterhoeven echoed through cyberspace:
> >> I'm not sure it would help. It would probably allow a kind of "mapping on
> >> demand" of the IO region on memory mapped IOs platforms, but unless we
> >> add another parameter to ioportremap telling it the pci_dev (or at least
> >> the bus number), we can't "guess" on which IO bus the device is and which
> >> physical base we must use.
> >
> > But we can find out the IO bus by looking in which region the physical address
> > is located, right? Or do we have the same region on different IO busses?
> > That would be really weird! Different IO busses should decode different
> > regions.
>
> No, they map the same bus-view IO space (bus addr. 0x0 - 0xsomething) to
> different windows in the processor's memory space.
>
> In other words, you can have IO port 0x3f8 on each of the PCI buses, but
> it will be accessed at different addresses from the processor's point of
> view.

Hence you have to fixup any pci_dev on the non-primary bus so its resources
reflect the `real' I/O addresses, as seen from the CPU.

So I/O address 0x3f8 (CPU view) is decoded by the first bus and accesses 0x3f8
on the first bus.
Say the second bus decodes, 0x1000-0x1fff. Then I/O address 0x13f8 (CPU view)
is decoded by the second bus and accesses 0x3f8 on the second bus.

Unless I'm totally mistaken (cfr. the `problem' with AGP video cards on PC
above)...


[ I think I really need the output of lspci -vv on a PC with PCI, AGP and a
  PCI-PCI bridge (and lots of cards) to bring some clarity... ]

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
