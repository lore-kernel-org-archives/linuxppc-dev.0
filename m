Date: Wed, 7 Jun 2000 21:11:07 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
cc: mlan@cpu.lu, schmitz@opal.biophys.uni-duesseldorf.de,
        daenzerm@student.ethz.ch, toe@unlserve.unl.edu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <20000608005823P.roikawa@rr.iij4u.or.jp>
Message-ID: <Pine.LNX.4.05.10006072108230.30676-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 8 Jun 2000, Ryuichi Oikawa wrote:
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > That's not sufficient (perhaps it is in this case, though): both fix.smem_start
> > and fix.smem_len may be not page aligned. To catch all cases, you have to use
> Can't /dev/fb mmap handle this case?  I just thought I saw some page
> handling code which adds extra page in fbmem.c. I'm using this for /dev/mem:
>
>   int pages, trailer_page = 0;
>
>   if(basePhys & (PAGE_SIZE - 1))
>     ++trailer_page;
>   pages = (memSize + PAGE_SIZE - 1)/PAGE_SIZE + trailer_page;
>   *baseVirt = (pointer)mmap(0, pages*PAGE_SIZE, PROT_READ|PROT_WRITE,
> 			    MAP_SHARED, fd, basePhys & PAGE_MASK);
>   *baseVirt += basePhys & (PAGE_SIZE - 1);
>
> > the formula from my previous posting.

>From a first look, that looks very similar to my formula.

> > > But looking through the XF4 fbdev support code I saw two more mistakes
> > > causing potential problem. One is a confusion of virtual screen width
> > > with screen pitch:
> > >
> > > fbdev.c
> > > 	pScrn->displayWidth = pScrn->virtualX; /* FIXME: might be wrong */
> > >
> > > Yes, this is wrong as the authur noted, but interestingly this code spreads
> > > over the all drivers supporting fbdev, though I can't distinguish which is
> > > the original :^)  Maybe polite solution is to fix each driver, but quick
> > > fix will be
> > >
> > > +	pScrn->displayWidth = fPtr->fix.line_width /
> > > +				(fPtr->var.bits_per_pixel >> 3)
> >
> > Typo: the field is called `line_length', not `line_width'.
>  Ah, I see, but I simply cut & pasted it.... where this comes?
>
> > And that formula is valid for chunky displays only, not for interleaved
> > bitplanes (I suppose pScrn->displayWidth is the width of one line in memory,
> > counted in pixel units?).
> Yes, it is used calculate video memory address from the x, y coordinate.
> How is displayWidth used for planar architecture? Is setting
> displayWidth == xres_virtual necessary to work properly?

For non-interleaved bitplanes, the same formula as for chunky pixels is valid.
For interleaved bitplanes, displayWidth == xres_virtual (assumed you can
display the full xres_virtual).

> > If line_length is 0, you must fallback to xres_virtual / bytes_per_pixel.
> Like this?
> +	if(fPtr->fix.line_width)
> +		pScrn->displayWidth = fPtr->fix.line_width /
> +				(fPtr->var.bits_per_pixel >> 3)

Yes. But ilbm (interleaved bitplanes) still has to use a different formula.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
