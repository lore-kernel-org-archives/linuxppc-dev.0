Date: Thu, 28 Oct 1999 22:46:52 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Josh Huber <huberj@WPI.EDU>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LCD stretching partially working!
In-Reply-To: <14360.32207.88755.452600@cpu.wpi.edu>
Message-ID: <Pine.LNX.4.05.9910282243080.6037-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Oct 1999, Josh Huber wrote:
> I'm working on getting hardware stretching for the Rage LT chipset
> (wallst. & lombard at least), and have got this far:
> 
> 
> In console mode:
> 1. Stretching in the vertical direction works
> 2. stretching in the horiz direction works

Great!

> 3. doing both at the same time appears to work...except for a little
>    screen flicker. (what could cause this?)

Two possible solutions:

  - Does it help if you lower the mclk?
  - Perhaps the display FIFO parameters have to take into account the
    stretching? At least for the horizontal stretching this sounds logical to
    me, i.e. try to use

    xclks_per_row = (pll->mclk_fb_div*pll->vclk_post_div_real*64*hstretch<<11)/
		    (pll->vclk_fb_div*pll->mclk_post_div_real*bpp);

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
