Date: Mon, 27 Mar 2000 12:38:57 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>, Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003271147390.31775-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.10003271235360.11532-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 27 Mar 2000, Michael Schmitz wrote:
> > > Applying Geerts patch (minus the PCIBIOS_MIN_MEM patch) plus the following
> > > one solves my PCI address conflict for the Mach64 by reallocating the MMIO
> > > aperture, and allows XFree86 4.0 to run on my Lombard.
> >
> > Great news! So how does it compare to 3.3.x for you?
>
> It feels a lot slower (15/16 bpp as fast as 32 before), 16 bpp have messed
> up color (green too bright, maybe 565 is wrong after all), 32 bpp fails to
> start (no screen found, weight 000 inconsistent with depth 32).

16 bpp (depth 15) is 555 on the Mach64. Feel free to add support for 565 (depth
16).

> I need to figure out what the pixel format for 16 and 32 bpp really is.
> Currently the X server refuses to start up if the RGB weights don't add up
> to the screen depth, and depth 32 isn't supported at all. 24 bpp works but
> it's really slower than 32 bpp before. Plus the X server refuses to
> cooperate with xscreensaver and consistently kicks me out after 10
> minutes.

32 bpp (depth 24) is 888.

> Even with not loading the more arcane extensions the X server weighs in at
> 21 MB (I recall 17 or so before), that might explain the slowdown a bit.

Does it use shadowfb? And extra copy of the screen image would explain some of
the memory requirements.

BTW, you don't want to know about the resource consumption of Xsun on the
Ultra-10 at work.

> Need to work on the accelerated Mach64 driver perhaps.

YES! ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
