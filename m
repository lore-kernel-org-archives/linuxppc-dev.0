Date: Tue, 8 Aug 2000 14:35:19 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Josh Huber <huber@mclx.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC X
 Server))
In-Reply-To: <20000807093124.B248@mclx.com>
Message-ID: <Pine.LNX.4.10.10008081433260.442-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Aug 2000, Josh Huber wrote:
> On Mon, Aug 07, 2000 at 09:08:01AM +0200, Michel D?nzer wrote:
> > Benjamin Herrenschmidt wrote:
> > > The Pismo allows that by scaling the LCD, but I don't think code for that
> > > is implemented in the XFree r128 driver (I didn't check lately).
> >
> > No it doesn't work, neither with aty128fb. Would that be hard to implement?
>
> If it's anything like the mach 64, it shouldn't be hard to implement
> at all.  you just have to program 3 registers.
>
> Speaking of this, I'm having trouble with the stretching setup for my
> wallstreet.  It works fine in console mode, but something in the X
> server is messing with the chip setup in a way to screw up the
> rendering.  After playing with it I was able to get proper output:
>
> console settings:
>     mclk = 99.844107 MHz
>     vclk = 44.702930 MHz
>     dsp_loop_latency = 10
>     dsp_precision = 5
>     dsp_xclks_per_row = 1143 => 17.859375
>     dsp_on = 69 => 34.500000
>     dsp_off = 1113 => 556.500000
>
> X (xf4.0.1) settings:
>     mclk = 99.844107 MHz
>     vclk = 44.702930 MHz
>     dsp_loop_latency = 10
>     dsp_precision = 4
>     dsp_xclks_per_row = 1143 => 8.929688
>     dsp_on = 103 => 25.750000
>     dsp_off = 1119 => 279.750000

Is this XF4.0.1 in `fbdev' mode? If yes, it's a bug in the X server. Setting
the DSP registers is part of the video mode initialization and thus is the
sole responsability of the frame buffer device, when running in `fbdev' mode.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
