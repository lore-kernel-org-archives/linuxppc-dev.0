Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B9942B7D61
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 16:14:06 +1000 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
References: <4BC682DC.1050200@billgatliff.com>
	<v2ma0706c7b1004150906p34b853a0r80e2bb751e034b97@mail.gmail.com>
	<v2pa0706c7b1004150907teae3383dwa4ee101d07daacfe@mail.gmail.com>
In-Reply-To: <v2pa0706c7b1004150907teae3383dwa4ee101d07daacfe@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <201004160814.01037.roman.fietze@telemotive.de>
Date: Fri, 16 Apr 2010 08:14:00 +0200
Content-Type: Text/Plain;
  charset="iso-8859-15"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Bill,

On Thursday 15 April 2010 18:07:03 Bill Gatliff wrote:

> I would love it if you posted your code! Thanks!!

In this source file I just added my own routines:

Index: programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c   (revision 6)
+++ programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c   (revision 7)
@@ -139,8 +139,8 @@
        "shadowInit",
        "shadowSetup",
        "shadowUpdatePacked",
=2D       "shadowUpdatePackedSwapped16Weak",
=2D       "shadowUpdatePackedSwapped32Weak",
+       "shadowUpdatePackedSwapped16",
+       "shadowUpdatePackedSwapped32",
        "shadowUpdateRotatePacked",
        NULL
 };
@@ -619,6 +619,7 @@
        ScrnInfoPtr pScrn =3D xf86Screens[pScreen->myNum];
        FBDevPtr fPtr =3D FBDEVPTR(pScrn);
        VisualPtr visual;
+       ShadowUpdateProc pupdate;
        int init_picture =3D 0;
        int ret,flags,width,height;
=20
@@ -794,7 +795,7 @@
                xf86DrvMsg(pScrn->scrnIndex, X_WARNING,
                           "RENDER extension initialisation failed.\n");
=20
=2D       pupdate =3D pScrn->bitsPerPixel > 16 ? shadowUpdatePackedSwapped3=
2Weak() :
 shadowUpdatePackedSwapped16Weak();
+       pupdate =3D pScrn->bitsPerPixel > 16 ? shadowUpdatePackedSwapped32 =
: shado
wUpdatePackedSwapped16;
=20
        if (fPtr->shadowFB &&=20
            (!shadowSetup(pScreen) || !shadowAdd(pScreen, NULL,


=2D-------------------------------

And here's my complete programs/Xserver/miext/shadow/shpacked.c


/*
 * $XFree86: xc/programs/Xserver/miext/shadow/shpacked.c,v 1.5 2001/10/28 0=
3:34:16 tsi Exp $
 *
 * Copyright =A9 2000 Keith Packard
 *
 * Permission to use, copy, modify, distribute, and sell this software and =
its
 * documentation for any purpose is hereby granted without fee, provided th=
at
 * the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation, and that the name of Keith Packard not be used in
 * advertising or publicity pertaining to distribution of the software with=
out
 * specific, written prior permission.  Keith Packard makes no
 * representations about the suitability of this software for any purpose. =
 It
 * is provided "as is" without express or implied warranty.
 *
 * KEITH PACKARD DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
 * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
 * EVENT SHALL KEITH PACKARD BE LIABLE FOR ANY SPECIAL, INDIRECT OR
 * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF U=
SE,
 * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */

#include    <byteswap.h>
#include    <unistd.h>

#include    "X.h"
#include    "scrnintstr.h"
#include    "windowstr.h"
#include    "font.h"
#include    "dixfontstr.h"
#include    "fontstruct.h"
#include    "mi.h"
#include    "regionstr.h"
#include    "globals.h"
#include    "gcstruct.h"
#include    "shadow.h"
#include    "fb.h"

void
shadowUpdatePacked (ScreenPtr	    pScreen,
		    shadowBufPtr    pBuf)
{
    RegionPtr	damage =3D &pBuf->damage;
    PixmapPtr	pShadow =3D pBuf->pPixmap;
    int		nbox =3D REGION_NUM_RECTS (damage);
    BoxPtr	pbox =3D REGION_RECTS (damage);
    FbBits	*shaBase, *shaLine, *sha;
    FbStride	shaStride;
    int		scrBase, scrLine, scr;
    int		shaBpp;
    int		shaXoff, shaYoff; /* XXX assumed to be zero */
    int		x, y, w, h, width;
    int         i;
    FbBits	*winBase =3D NULL, *win;
    CARD32      winSize;

    fbGetDrawable (&pShadow->drawable, shaBase, shaStride, shaBpp, shaXoff,=
 shaYoff);
    while (nbox--)
    {
	x =3D pbox->x1 * shaBpp;
	y =3D pbox->y1;
	w =3D (pbox->x2 - pbox->x1) * shaBpp;
	h =3D pbox->y2 - pbox->y1;

	scrLine =3D (x >> FB_SHIFT);
	shaLine =3D shaBase + y * shaStride + (x >> FB_SHIFT);
				  =20
	x &=3D FB_MASK;
	w =3D (w + x + FB_MASK) >> FB_SHIFT;
=09
	while (h--)
	{
	    winSize =3D 0;
	    scrBase =3D 0;
	    width =3D w;
	    scr =3D scrLine;
	    sha =3D shaLine;
	    while (width) {
		/* how much remains in this window */
		i =3D scrBase + winSize - scr;
		if (i <=3D 0 || scr < scrBase)
		{
		    winBase =3D (FbBits *) (*pBuf->window) (pScreen,
							  y,
							  scr * sizeof (FbBits),
							  SHADOW_WINDOW_WRITE,
							  &winSize,
							  pBuf->closure);
		    if(!winBase)
			return;
		    scrBase =3D scr;
		    winSize /=3D sizeof (FbBits);
		    i =3D winSize;
		}
		win =3D winBase + (scr - scrBase);
		if (i > width)
		    i =3D width;
		width -=3D i;
		scr +=3D i;

		while (i--)
		    *win++ =3D *sha++;
	    }
	    shaLine +=3D shaStride;
	    y++;
	}
	pbox++;
    }
}


/* Swap frame buffer bytes in 32 bit value.  */
static __inline unsigned int
fbbits_swap32(unsigned int __bsx)
{
    return ((((__bsx) & 0xff000000) >> 8) | (((__bsx) & 0x00ff0000) << 8) |
	    (((__bsx) & 0x0000ff00) >> 8) | (((__bsx) & 0x000000ff) << 8));
}

void
shadowUpdatePackedSwapped16 (ScreenPtr	    pScreen,
			     shadowBufPtr    pBuf)
{
    RegionPtr	damage =3D &pBuf->damage;
    PixmapPtr	pShadow =3D pBuf->pPixmap;
    int		nbox =3D REGION_NUM_RECTS (damage);
    BoxPtr	pbox =3D REGION_RECTS (damage);
    FbBits	*shaBase, *shaLine, *sha;
    FbStride	shaStride;
    int		scrBase, scrLine, scr;
    int		shaBpp;
    int		shaXoff, shaYoff; /* XXX assumed to be zero */
    int		x, y, w, h, width;
    int         i;
    FbBits	*winBase =3D NULL, *win;
    CARD32      winSize;

    /* fprintf(stderr, "#### %s() nbox=3D%d sizof(*win)=3D%u\n", __FUNCTION=
__, nbox, sizeof(*win)); */

    fbGetDrawable (&pShadow->drawable, shaBase, shaStride, shaBpp, shaXoff,=
 shaYoff);
    while (nbox--)
    {
	x =3D pbox->x1 * shaBpp;
	y =3D pbox->y1;
	w =3D (pbox->x2 - pbox->x1) * shaBpp;
	h =3D pbox->y2 - pbox->y1;

	/* fprintf(stderr, "####\t%s: x=3D%d y=3D%d w=3D%d h=3D%d\n", __FUNCTION__=
, x, y, w, h); */

	scrLine =3D (x >> FB_SHIFT);
	shaLine =3D shaBase + y * shaStride + (x >> FB_SHIFT);
				  =20
	x &=3D FB_MASK;
	w =3D (w + x + FB_MASK) >> FB_SHIFT;
=09
	while (h--)
	{
	    winSize =3D 0;
	    scrBase =3D 0;
	    width =3D w;
	    scr =3D scrLine;
	    sha =3D shaLine;
	    while (width) {
		/* how much remains in this window */
		i =3D scrBase + winSize - scr;
		if (i <=3D 0 || scr < scrBase)
		{
		    winBase =3D (FbBits *) (*pBuf->window) (pScreen,
							  y,
							  scr * sizeof (FbBits),
							  SHADOW_WINDOW_WRITE,
							  &winSize,
							  pBuf->closure);
		    if(!winBase)
			return;
		    scrBase =3D scr;
		    winSize /=3D sizeof (FbBits);
		    i =3D winSize;
		}
		win =3D winBase + (scr - scrBase);
		if (i > width)
		    i =3D width;
		width -=3D i;
		scr +=3D i;

#if 1
		/* TODO: check which one of these solutions is
		 * faster. Allthough swab probably uses optimized PPC
		 * operations, the fbbits_swap32 solution uses 32 bit
		 * PCI accesses, so the result isn't that clear.
		 */
		while (i--)
		    *win++ =3D fbbits_swap32(*sha++);
#else
		swab(sha, win, i * sizeof(*win));
#endif
	    }
	    shaLine +=3D shaStride;
	    y++;
	}
	pbox++;
    }
}


void
shadowUpdatePackedSwapped32 (ScreenPtr	    pScreen,
			     shadowBufPtr    pBuf)
{
    RegionPtr	damage =3D &pBuf->damage;
    PixmapPtr	pShadow =3D pBuf->pPixmap;
    int		nbox =3D REGION_NUM_RECTS (damage);
    BoxPtr	pbox =3D REGION_RECTS (damage);
    FbBits	*shaBase, *shaLine, *sha;
    FbStride	shaStride;
    int		scrBase, scrLine, scr;
    int		shaBpp;
    int		shaXoff, shaYoff; /* XXX assumed to be zero */
    int		x, y, w, h, width;
    int         i;
    FbBits	*winBase =3D NULL, *win;
    CARD32      winSize;

    /* fprintf(stderr, "#### %s() nbox=3D%d sizof(*win)=3D%u\n", __FUNCTION=
__, nbox, sizeof(*win)); */

    fbGetDrawable (&pShadow->drawable, shaBase, shaStride, shaBpp, shaXoff,=
 shaYoff);
    while (nbox--)
    {
	x =3D pbox->x1 * shaBpp;
	y =3D pbox->y1;
	w =3D (pbox->x2 - pbox->x1) * shaBpp;
	h =3D pbox->y2 - pbox->y1;

	/* fprintf(stderr, "####\t%s: x=3D%d y=3D%d w=3D%d h=3D%d\n", __FUNCTION__=
, x, y, w, h); */

	scrLine =3D (x >> FB_SHIFT);
	shaLine =3D shaBase + y * shaStride + (x >> FB_SHIFT);
				  =20
	x &=3D FB_MASK;
	w =3D (w + x + FB_MASK) >> FB_SHIFT;
=09
	while (h--)
	{
	    winSize =3D 0;
	    scrBase =3D 0;
	    width =3D w;
	    scr =3D scrLine;
	    sha =3D shaLine;
	    while (width) {
		/* how much remains in this window */
		i =3D scrBase + winSize - scr;
		if (i <=3D 0 || scr < scrBase)
		{
		    winBase =3D (FbBits *) (*pBuf->window) (pScreen,
							  y,
							  scr * sizeof (FbBits),
							  SHADOW_WINDOW_WRITE,
							  &winSize,
							  pBuf->closure);
		    if(!winBase)
			return;
		    scrBase =3D scr;
		    winSize /=3D sizeof (FbBits);
		    i =3D winSize;
		}
		win =3D winBase + (scr - scrBase);
		if (i > width)
		    i =3D width;
		width -=3D i;
		scr +=3D i;

		while (i--)
		    *win++ =3D bswap_32(*sha++);
	    }
	    shaLine +=3D shaStride;
	    y++;
	}
	pbox++;
    }
}


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
