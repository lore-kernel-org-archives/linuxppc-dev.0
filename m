Date: Sat, 25 Mar 2000 14:31:07 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003241842211.22814-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.05.10003251429000.11322-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Michael Schmitz wrote:
> > I spent some time discussion with Egbert. The result is basically that in
> > order to support all archs, bogus BIOS, legacy cards, softbooting, etc...
> > XF must take over the PCI the way it does it. There are lots of reasons
> > for that, I could try to summarize them if you really want the gory
> > details, I beleive Egbert is bored of repeating himself all the time ;)
>
> Nah, I take this to mean we better fix our PCI resource conflicts in the
> kernel if at all possible. But as I see everybody juggle with PCI resource

Yes, they should be fixed in the kernel's pcibios_* routines.

> > I suggested making that optional (and relying, for example, only on fbdev
> > or disabling the re-assignement when the appropriate option is set in
> > XF86Config), but Egbert thinks that would be a support nightmare with
> > users playing with the config options.
>
> I sometimes wonder - the FBDev X server used to be a painless thing: the
> kernel frame buffer driver would handle the gory details and X would use a
> simplified, maybe slow but stable interface. X used to deal with that
> fine. Suddenly the kernel isn't to be trusted to correctly set up things
> anymore, and we're back to square one in terms of X stability. How did
> that happen?

Because they insist on playing with PCI theirselves. And partly because of
multi-head (what if you have 2 cards, and you have a fbdev for only one of
them?). But the solution is quite simple: XFree86 should not touch PCI devices
that have a fbdev attached, and it can easily find out using fix.smem_start.

> Can't the PIO registers be accessed via the MMIO aperture? Either way,
> with non accelerated framebuffer drivers there's no need to ever use VGA
> registers. And there's no fbdev driver for stupid VGA cards (yuck). It's a
> non issue from my point of view.

Yes we have: vga16fb.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
