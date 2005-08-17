Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 8408367F92
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 22:42:19 +1000 (EST)
Date: Wed, 17 Aug 2005 14:42:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Andrey Volkov <avolkov@varma-el.com>
In-Reply-To: <43032A76.6080104@varma-el.com>
Message-ID: <Pine.LNX.4.62.0508171439060.6073@numbat.sonytel.be>
References: <20050816194825.A62AC353AB5@atlas.denx.de>
	<43030D41.3000508@varma-el.com>
	<Pine.LNX.4.62.0508171317540.6073@numbat.sonytel.be>
	<43032A76.6080104@varma-el.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>, surendra.yadav@softdel.com
Subject: Re: [F]Framebuffer driver using SM501 hardware.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 17 Aug 2005, Andrey Volkov wrote:
> Geert Uytterhoeven wrote:
> > On Wed, 17 Aug 2005, Andrey Volkov wrote:
> > 
> >>Todo:
> >>- 16 bpp colormap (needed reverse endian support in fbcon/fbmem)
> > 
> > 
> > Can you please elaborate? For 2.6, there should be no such problems (for 2.4,
> > there are).
> 
> Sorry for inexactitude, problem (as usually :)) in next (for case of
> MPC5200 connected through PCI to SM501): PCI on PPC (and hence SM501) is
> a little endian, PPC - big endian.
> Currently (up to 2.6.13-rc6) frame buffer routines use
> __raw_writeXX for write to fb memory. Result - garbage with colors in
> RGB565/RGB888 modes (but pixels, meanwhile, are in place). If using
> write[lw] - colors are diplayed correctly, but all image pixels are
> shifted for (RGB565). This is not bug of frame buffer, this is lack of
> some define in .config which tell fb/device driver how palette must be
> generated (more precisely it is unknown when must be RGB565, but when
> must be BGR565).

Sorry, I cannot follow.

 1. If it's a palette issue, your setcolreg() routine doesn't fill in correctly
    the pseudo palette,
 2. If it's a RGB565 vs. BGR565 issue, you don't fill in correctly the offsets
    in the color bitfields in fb_var_screeninfo,
 3. If it's an endian issue, it's RRRRRGGGGGGBBBBB vs.GGBBBBBRRRRGGGG, right?
    And then there's no much we can do...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
