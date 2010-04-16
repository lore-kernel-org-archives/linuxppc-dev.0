Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id A350AB7D6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 18:30:30 +1000 (EST)
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Roman Fietze <roman.fietze@telemotive.de>
In-Reply-To: <201004160814.01037.roman.fietze@telemotive.de>
References: <4BC682DC.1050200@billgatliff.com>
	<v2ma0706c7b1004150906p34b853a0r80e2bb751e034b97@mail.gmail.com>
	<v2pa0706c7b1004150907teae3383dwa4ee101d07daacfe@mail.gmail.com>
	<201004160814.01037.roman.fietze@telemotive.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Apr 2010 10:30:23 +0200
Message-ID: <1271406623.4030.43.camel@thor.local>
Mime-Version: 1.0
Cc: Bill Gatliff <bgat@billgatliff.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fre, 2010-04-16 at 08:14 +0200, Roman Fietze wrote:=20
>=20
> On Thursday 15 April 2010 18:07:03 Bill Gatliff wrote:
>=20
> > I would love it if you posted your code! Thanks!!
>=20
> In this source file I just added my own routines:
>=20
> Index: programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c   (revision 6)
> +++ programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c   (revision 7)
> @@ -139,8 +139,8 @@
>         "shadowInit",
>         "shadowSetup",
>         "shadowUpdatePacked",
> -       "shadowUpdatePackedSwapped16Weak",
> -       "shadowUpdatePackedSwapped32Weak",
> +       "shadowUpdatePackedSwapped16",
> +       "shadowUpdatePackedSwapped32",
>         "shadowUpdateRotatePacked",
>         NULL
>  };
> @@ -619,6 +619,7 @@
>         ScrnInfoPtr pScrn =3D xf86Screens[pScreen->myNum];
>         FBDevPtr fPtr =3D FBDEVPTR(pScrn);
>         VisualPtr visual;
> +       ShadowUpdateProc pupdate;
>         int init_picture =3D 0;
>         int ret,flags,width,height;
> =20
> @@ -794,7 +795,7 @@
>                 xf86DrvMsg(pScrn->scrnIndex, X_WARNING,
>                            "RENDER extension initialisation failed.\n");
> =20
> -       pupdate =3D pScrn->bitsPerPixel > 16 ? shadowUpdatePackedSwapped3=
2Weak() :
>  shadowUpdatePackedSwapped16Weak();
> +       pupdate =3D pScrn->bitsPerPixel > 16 ? shadowUpdatePackedSwapped3=
2 : shado
> wUpdatePackedSwapped16;
> =20
>         if (fPtr->shadowFB &&=20
>             (!shadowSetup(pScreen) || !shadowAdd(pScreen, NULL,

I hope you're aware that this really just hacks around the kernel
framebuffer device not exposing the framebuffer to userspace according
to the fbdev interface (see struct fb_bitfield
in /usr/include/linux/fb.h), and this will affect everything else using
the framebuffer device as well.

It would be better to handle this in the kernel framebuffer device,
either via hardware byte swapping facilities if available, or otherwise
e.g. via FB_DEFERRED_IO.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
