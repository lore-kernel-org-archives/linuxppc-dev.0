Date: Fri, 24 Mar 2000 14:48:51 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003241427400.21215-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.10003241446420.7616-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Michael Schmitz wrote:
> > > On a somewhat related issue (the PCI mapping funnies for the Lombard and
> > > possibly other Rage Pro devices): what are the penalties if I 'correct'
> > > the PCI mapping for the Rage Pro within atyfb_of_init?
> >
> > atyfb_of_init() no longer exists. Atyfb uses PCI probing only now.
>
> Define 'now' please.

2.4.0 :-)

> > > I'd like to correct the first one to only include the big endian aperture,
> >
> > Why? Atyfb has no troubles finding the big endian aperture on its own.
>
> Stupid X doesn't query atyfb on this and stomps on the PCI resources.
> atyfb finds the BE aperture because someone hardcoded that it's at
> base + 0x800000 :-)

Bug in X: the big endian frame buffer is at base + 0x800000.

Besides, why does X need this? If it uses fbdev, all it should notice is that
the reported fix.smem_start lies within the 16 MB for this PCI device, so it
should not touch that PCI directly, only through the fbdev API (ioctl+mmap).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
