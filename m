Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5B30AB7DBC
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 09:09:04 +1100 (EST)
Date: Sat, 27 Feb 2010 23:09:03 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 09/11] powerpc/mpc5121: shared DIU framebuffer support
Message-ID: <20100227230903.237f2009@wker>
In-Reply-To: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-10-git-send-email-agust@denx.de>
	<fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: wd@denx.de, dzu@denx.de, John Rigby <jrigby@gmail.com>,
	linuxppc-dev@ozlabs.org, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 16 Feb 2010 11:06:22 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> [...]
> > diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> > index 72d68b3..29c7f31 100644
> > --- a/drivers/video/fsl-diu-fb.c
> > +++ b/drivers/video/fsl-diu-fb.c
> > @@ -34,7 +34,7 @@
> > =C2=A0#include <linux/of_platform.h>
> >
> > =C2=A0#include <sysdev/fsl_soc.h>
> > -#include "fsl-diu-fb.h"
> > +#include <linux/fsl-diu-fb.h>
> >
> > =C2=A0/*
> > =C2=A0* These parameters give default parameters
> > @@ -178,6 +178,21 @@ static struct fb_videomode __devinitdata fsl_diu_m=
ode_db[] =3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.sync =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.vmode =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D FB_VMODE_NONINTERLACED
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> > + =C2=A0 =C2=A0 =C2=A0 {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D "800x480-60",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .refresh =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D 60,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .xres =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D 800,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .yres =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D 480,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pixclock =C2=A0 =C2=
=A0 =C2=A0 =3D 31250,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .left_margin =C2=A0 =
=C2=A0=3D 86,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .right_margin =C2=A0=
 =3D 42,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .upper_margin =C2=A0=
 =3D 33,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .lower_margin =C2=A0=
 =3D 10,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .hsync_len =C2=A0 =
=C2=A0 =C2=A0=3D 128,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .vsync_len =C2=A0 =
=C2=A0 =C2=A0=3D 2,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .sync =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .vmode =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D FB_VMODE_NONINTERLACED
> > + =C2=A0 =C2=A0 =C2=A0 },
> > =C2=A0};
>=20
> This hunk bothers me.  It looks like the type of data that belongs
> either in some common shared .c file, or encoded into the device tree.
>  It seems to be data about the display panel, instead of data about
> the framebuffer driver.  I know that the driver already uses this
> pattern, but before I merge this patch and further rely on that
> pattern, I think it is worth discussing.

In the updated DIU patches I don't add panel timing data to the
framebuffer driver. It is encoded in the device tree now. If this
is acceptable, I'll send another patch adding the documentation
for added bindings.

Thanks,
Anatolij
