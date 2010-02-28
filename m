Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 37FB5B7D8B
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 17:53:18 +1100 (EST)
Received: by gyg13 with SMTP id 13so122651gyg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 22:53:17 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1267307902-31939-3-git-send-email-agust@denx.de>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-3-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 27 Feb 2010 23:52:57 -0700
Message-ID: <fa686aa41002272252t7d62dcd2p26f5fe1480ab53e6@mail.gmail.com>
Subject: Re: [PATCH 2/3] fbdev: fsl-diu-fb.c: allow setting panel video mode
	from DT
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com,
	linuxppc-dev@ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 27, 2010 at 2:58 PM, Anatolij Gustschin <agust@denx.de> wrote:
> Add support for specifying display panel data in the device
> tree. If no panel data is provided in the device tree, default
> video mode will be used as usual.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

This one seems okay, but the binding in the first patch first needs to
get resolved.

g.

> ---
> =A0drivers/video/Kconfig =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/video/fsl-diu-fb.c | =A0 63 +++++++++++++++++++++++++---------=
----------
> =A02 files changed, 37 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index dc1beb0..c805ecd 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1850,6 +1850,7 @@ config FB_FSL_DIU
> =A0 =A0 =A0 =A0select FB_CFB_COPYAREA
> =A0 =A0 =A0 =A0select FB_CFB_IMAGEBLIT
> =A0 =A0 =A0 =A0select PPC_LIB_RHEAP
> + =A0 =A0 =A0 select FB_OF_MODE
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0Framebuffer driver for the Freescale SoC DIU
>
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 4637bcb..19ca1da 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -36,6 +36,8 @@
> =A0#include <sysdev/fsl_soc.h>
> =A0#include "fsl-diu-fb.h"
>
> +#include "ofmode.h"
> +
> =A0/*
> =A0* These parameters give default parameters
> =A0* for video output 1024x768,
> @@ -1168,7 +1170,7 @@ static int init_fbinfo(struct fb_info *info)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int __devinit install_fb(struct fb_info *info)
> +static int __devinit install_fb(struct device_node *np, struct fb_info *=
info)
> =A0{
> =A0 =A0 =A0 =A0int rc;
> =A0 =A0 =A0 =A0struct mfb_info *mfbi =3D info->par;
> @@ -1177,33 +1179,40 @@ static int __devinit install_fb(struct fb_info *i=
nfo)
> =A0 =A0 =A0 =A0if (init_fbinfo(info))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 if (mfbi->index =3D=3D 0) =A0 /* plane 0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 aoi_mode =3D fb_mode;
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 if (mfbi->index =3D=3D 0) { /* plane 0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* use default mode for plane0 if there is =
no mode in DTB */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_video_mode(np, info) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 aoi_mode =3D fb_mode;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 aoi_mode =3D NULL;
> + =A0 =A0 =A0 } else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0aoi_mode =3D init_aoi_mode;
> - =A0 =A0 =A0 pr_debug("mode used =3D %s\n", aoi_mode);
> - =A0 =A0 =A0 rc =3D fb_find_mode(&info->var, info, aoi_mode, fsl_diu_mod=
e_db,
> - =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(fsl_diu_mode_db), &fsl_diu_default_mo=
de, default_bpp);
>
> - =A0 =A0 =A0 switch (rc) {
> - =A0 =A0 =A0 case 1:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("using mode specified in @mode\n")=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case 2:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("using mode specified in @mode "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "with ignored refresh rate\=
n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case 3:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("using mode default mode\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case 4:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("using mode from list\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("rc =3D %d\n", rc);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("failed to find mode\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 if (aoi_mode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("mode used =3D %s\n", aoi_mode);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D fb_find_mode(&info->var, info, aoi_m=
ode, fsl_diu_mode_db,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_S=
IZE(fsl_diu_mode_db),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &fsl_di=
u_default_mode, default_bpp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("using mode specif=
ied in @mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("using mode specif=
ied in @mode "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "with ignor=
ed refresh rate\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("using mode defaul=
t mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("using mode from l=
ist\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("rc =3D %d\n", rc)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("failed to find mo=
de\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0pr_debug("xres_virtual %d\n", info->var.xres_virtual);
> @@ -1521,7 +1530,7 @@ static int __devinit fsl_diu_probe(struct of_device=
 *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mfbi->ad =3D (struct diu_ad *)((u32)pool.a=
d.vaddr
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0+ pool.ad.offset) + i;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mfbi->ad->paddr =3D pool.ad.paddr + i * si=
zeof(struct diu_ad);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D install_fb(machine_data->fsl_diu_in=
fo[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D install_fb(np, machine_data->fsl_di=
u_info[i]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&ofdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Failed to=
 register framebuffer %d\n",
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
