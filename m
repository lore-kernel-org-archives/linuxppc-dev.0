Date: Mon, 3 Nov 2003 15:34:51 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bob Brose <bob@kunk.qbjnet.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IRQS on 6 Slot Macs
In-Reply-To: <20031103141125.10229.qmail@kunk.qbjnet.com>
Message-ID: <Pine.GSO.4.21.0311031532590.20074-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 3 Nov 2003, Bob Brose wrote:
> User Benjamin Herrenschmidt says:
> > On Mon, 2003-11-03 at 14:35, Robert E Brose II wrote:
> > > A couple of things right off, the rage128 appears to be the only thing on
> > > irq 23 however 23 doesn't show up in /proc/interrupts meaning, I suppose,
> > > that it's not using the interrupt. So why does the drm complain?
> > >
> > > How come everything from slots 3-6 says it's on the same interrupt (25)?
> >
> > I don't know what's up with the DRM not liking your interrupt. I can
> > answer for the sharing of USB, symbios and firewire interrupts: all 3
> > slots share one interrupt because of bad motherboard design :)
> > Basicallly, what they did when designing that machine was to use a
> > standard powersurge design with 3 slots and replace one of them
> > with a PCI<->PCI bridge. Since they didn't "know" how to get more
> > interrupt lines out of Grand Central, they just also stuffed all
> > interrupt lines together for those 4 slots (I'm pretty sure GC do

Tsss... They could at least have `swizzled' the lines...

> > have spare lines they could have used, but that would have meant
> > updating Open Firmware to understand the layout, I doubt the people
> > who designed that machine wanted to dive into that).
> >
> > Ben.
>
> I suppose then that I should reorder the cards so that the ones generating
> the most interrupts would be in the first 2 slots? It's pretty funny
> having the possibility of the use of lots of irqs then ending up with
> x86 style sharing. :(

Yes, try to spread out interrupts evenly across interrupt lines.
Furthermore the presence of the bridge will probably incur a slight slowdown
for the last 3 slots, too. Don't know whether it's significant (should reread
PCI specs first).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
