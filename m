Date: Wed, 26 Jul 2000 13:54:16 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] IRQ Latency tool 0.1.3 release.
In-Reply-To: <20000725213953.24969@192.168.1.10>
Message-ID: <Pine.LNX.4.10.10007261351040.443-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 25 Jul 2000, Benjamin Herrenschmidt wrote:
> >> I still haven't found the "hard-block" that is effecting the overall audio
> >> latency performance... ah well, back to the drawing board...
> >
> >Do you have IDE? The IDE driver turned out to be the major interrupt messing
> >problem on m68k, since it can disable interrupts for quite a while.
>
> We have some great IRQ blockers in Linux currently. IDE is one,
> especially in PIO mode where it disables IRQs by default during
> transferts (AFAIK), but I think also in the fbdevs where, I think, a
> bunch of lenghtly things like scrolling are done with IRQs disabled.

> I don't know how the fbdev case can be improved, I beleive James has some
> plans about that for 2.5...

There's indeed a global lock on the console, to prevent multiple accesses to
the console at once. This solves some problems, one being that some graphics
hardware crashes when both the CPU and the graphics accelerator touch the video
RAM at the same time.

Interrupts in fbdev would be nice for some high-end hardware, which can
trigger an interrupt when a bunch of graphics processing was done.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
