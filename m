To: buckheit@olg.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: X/CLUT/pixel data format question WRT IMSTT cards
In-Reply-To: Your message of "Thu, 29 Jul 1999 23:57:03 -0400"
	<B0011235688@mail.olg.com>
References: <B0011235688@mail.olg.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990731031316O.roikawa@rr.iij4u.or.jp>
Date: Sat, 31 Jul 1999 03:13:16 GMT
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: "charlie buckheit" <buckheit@olg.com>
Subject: X/CLUT/pixel data format question WRT IMSTT cards

> Hi,
> 
> I was wondering if someone who understands the Xserver code a little better
> can first point me in the direction of the code that sets the CLUT for X,
> second if any information on the pixel data formats for the various color
> modes is available, and third if the Xserver runs in true color mode or does
> it only use the color lookup tables. I'm trying to figure out why the IMSTT
> card is still having problems in 16 and 24/32 bpp modes. I pretty much
> proved to myself that its not an endian problem (I've got IXMicro provided
> code and API manuals for the chipsets) as when I write directly to the video
> memory the results on the screen are correct (i.e. in 24/32 bpp writting
> 0x000000ff to the screen results in blue, 0x0000ff00 green, 0x00ff0000 red,
> and 0xff000000 in black as the most significant 8 bits are the alpha data
> which is not used). On my computer the greys are correct (telling me that
> the RGB registers are probably correct as all three must be the same value
> to get greys in true color mode), and images displayed in GIMP are fine
> (this can't be pure luck can it???)...its just the gnome/enlightenment stuff
> thats messed up...specifically the icons and window borders. So my thought
> now is that either the X pixel formats are different then the IMSTT card
> expects or the CLUT is not getting set correctly or X doesn't like the true
> color mode.
> 
> BTW 16bpp is a completely different animal though I think the problems are
> related as the colors are correct there also when written manually to the
> screen.

AFAIK, IMSTT HW acceleration code has some problems with PolyFillRectSolid
operation. In my case(TwinTurbo Rev.1 OEM) I had to change the byte order
of the foreground color register and the BLT command code to work properly
with my card. You can try to change the byte order and BLT command code at
 /xc/programs/Xserver/hw/xfree68/imstt/imstt.c: ttPolyFillRect

	clr = pGC->fgPixel;
	if (Bpp == 2)
		clr = (clr << 8) | (clr << 24) | (clr >> 8);
	else
		clr = ((clr << 24) | ((clr << 8) & 0xff0000) | ((clr >> 8) & 0xff00) | (clr >> 24));

and 
	ttout(BLTCTL, 0x200000); /* 0x840 */
	
For my case correct order and command code were
	clr = pGC->fgPixel;
	switch(Bpp) { /* clrReg is where CLR register exits */
	  case 1:
	    *clrReg = clr | (clr << 8) | (clr << 16) | (clr << 24);
	    break;
	  case 2:
	    *clrReg = clr | (clr << 16);
	    break;
	  case 4:
	    *clrReg = clr;
	    break;
	  default: /* ??? */
	    *clrReg = clr;
	    break;
	}

and
	ttout(BLTCTL, 0x840); /* 0x200000 */

But this will not work for other card, and more confusing, the byte
order and BLT command code seemed different by chip/OF ROM version
and whether the kernel boots from BootX or OF because imsttfb doesn't
fully initialize drawing registers. Or, if you don't want to be bothered,
you can simply disable accelerated solid fill by,
void
imstt_init (ScreenPtr scr)
{
	int width, Bpp;

	width = scr->width;
	Bpp = scr->rootDepth >> 3;
	switch (Bpp) {
		case 1:
			cfbTEOps.CopyArea = tt8CopyArea;
			cfbNonTEOps.CopyArea = tt8CopyArea;
			cfbTEOps1Rect.CopyArea = tt8CopyArea;
			cfbNonTEOps1Rect.CopyArea = tt8CopyArea;
+#if 0
			cfbTEOps.PolyFillRect = ttPolyFillRect;
			cfbNonTEOps.PolyFillRect = ttPolyFillRect;
			cfbTEOps1Rect.PolyFillRect = ttPolyFillRect;
			cfbNonTEOps1Rect.PolyFillRect = ttPolyFillRect;
+#endif
			break;

		case 2:
			cfb16TEOps.CopyArea = tt16CopyArea;
			cfb16NonTEOps.CopyArea = tt16CopyArea;
			cfb16TEOps1Rect.CopyArea = tt16CopyArea;
			cfb16NonTEOps1Rect.CopyArea = tt16CopyArea;
+#if 0
			cfb16TEOps.PolyFillRect = ttPolyFillRect;
			cfb16NonTEOps.PolyFillRect = ttPolyFillRect;
			cfb16TEOps1Rect.PolyFillRect = ttPolyFillRect;
			cfb16NonTEOps1Rect.PolyFillRect = ttPolyFillRect;
+#endif
			break;
#ifdef CONFIG_CFB24
		case 3:
			cfb24TEOps.CopyArea = tt24CopyArea;
			cfb24NonTEOps.CopyArea = tt24CopyArea;
			cfb24TEOps1Rect.CopyArea = tt24CopyArea;
			cfb24NonTEOps1Rect.CopyArea = tt24CopyArea;
+#if 0
			cfb24TEOps.PolyFillRect = ttPolyFillRect;
			cfb24NonTEOps.PolyFillRect = ttPolyFillRect;
			cfb24TEOps1Rect.PolyFillRect = ttPolyFillRect;
			cfb24NonTEOps1Rect.PolyFillRect = ttPolyFillRect;
+#endif
			break;
#endif
		case 4:
			cfb32TEOps.CopyArea = tt32CopyArea;
			cfb32NonTEOps.CopyArea = tt32CopyArea;
			cfb32TEOps1Rect.CopyArea = tt32CopyArea;
			cfb32NonTEOps1Rect.CopyArea = tt32CopyArea;
+#if 0
			cfb32TEOps.PolyFillRect = ttPolyFillRect;
			cfb32NonTEOps.PolyFillRect = ttPolyFillRect;
			cfb32TEOps1Rect.PolyFillRect = ttPolyFillRect;
			cfb32NonTEOps1Rect.PolyFillRect = ttPolyFillRect;
+#endif
			break;
	}
,though it makes the drawing speed slower.

Of course these situation is mainly due to the lack of documents.
If you have one(s) from IxMicro, probably the answers are there.
You will be able to check BLT command codes and bit/byte order control
registers, etc.


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
