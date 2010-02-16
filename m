Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195]) by ozlabs.org (Postfix) with ESMTP id 88B21B7D65
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 05:06:44 +1100 (EST)
Received: by ywh33 with SMTP id 33so5600235ywh.15
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 10:06:43 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265377377-29327-10-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-10-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 11:06:22 -0700
Message-ID: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] powerpc/mpc5121: shared DIU framebuffer support
To: Anatolij Gustschin <agust@denx.de>, York Sun <yorksun@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Rigby <jrigby@gmail.com>, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 6:42 AM, Anatolij Gustschin <agust@denx.de> wrote:
> MPC5121 DIU configuration/setup as initialized by the boot
> loader currently will get lost while booting Linux. As a
> result displaying the boot splash is not possible through
> the boot process.
>
> To prevent this we reserve configured DIU frame buffer
> address range while booting and preserve AOI descriptor
> and gamma table so that DIU continues displaying through
> the whole boot process. On first open from user space
> DIU frame buffer driver releases the reserved frame
> buffer area and continues to operate as usual.
>
> The patch also moves drivers/video/fsl-diu-fb.h file to
> include/linux as we use some DIU structures in platform
> code.
>
> 'diu_ops' callbacks in platform code borrowed from John's
> DIU code.
>
> Signed-off-by: John Rigby <jrigby@gmail.com>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
[...]
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 72d68b3..29c7f31 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -34,7 +34,7 @@
> =A0#include <linux/of_platform.h>
>
> =A0#include <sysdev/fsl_soc.h>
> -#include "fsl-diu-fb.h"
> +#include <linux/fsl-diu-fb.h>
>
> =A0/*
> =A0* These parameters give default parameters
> @@ -178,6 +178,21 @@ static struct fb_videomode __devinitdata fsl_diu_mod=
e_db[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.sync =A0 =A0 =A0 =A0 =A0 =3D FB_SYNC_COMP=
_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vmode =A0 =A0 =A0 =A0 =A0=3D FB_VMODE_NON=
INTERLACED
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "800x480-60",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .refresh =A0 =A0 =A0 =A0=3D 60,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 800,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 480,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixclock =A0 =A0 =A0 =3D 31250,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .left_margin =A0 =A0=3D 86,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .right_margin =A0 =3D 42,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .upper_margin =A0 =3D 33,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .lower_margin =A0 =3D 10,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsync_len =A0 =A0 =A0=3D 128,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsync_len =A0 =A0 =A0=3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sync =A0 =A0 =A0 =A0 =A0 =3D FB_SYNC_COMP_=
HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vmode =A0 =A0 =A0 =A0 =A0=3D FB_VMODE_NONI=
NTERLACED
> + =A0 =A0 =A0 },
> =A0};

This hunk bothers me.  It looks like the type of data that belongs
either in some common shared .c file, or encoded into the device tree.
 It seems to be data about the display panel, instead of data about
the framebuffer driver.  I know that the driver already uses this
pattern, but before I merge this patch and further rely on that
pattern, I think it is worth discussing.

Kumar, York, thoughts?

g.
