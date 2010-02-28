Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 06D75B7DC4
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 17:30:54 +1100 (EST)
Received: by gwj20 with SMTP id 20so743938gwj.15
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 22:30:53 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1267307902-31939-2-git-send-email-agust@denx.de>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-2-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 27 Feb 2010 23:30:33 -0700
Message-ID: <fa686aa41002272230s7f900c0fv1aabf0e26ccbf84c@mail.gmail.com>
Subject: Re: [PATCH 1/3] video: add support for getting video mode from device
	tree
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev@ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anatolij,

[added cc: to devicetree-discuss@lists.ozlabs.org]

On Sat, Feb 27, 2010 at 2:58 PM, Anatolij Gustschin <agust@denx.de> wrote:
> Framebuffer drivers may want to get panel timing info
> from the device tree. This patch adds appropriate support.
> Subsequent patch for FSL DIU frame buffer driver makes use
> of this functionality.

I think this is moving in the right direction, but there needs to
debate & review over the binding before committing to anything.
Please write a patch that documents the new binding in
Documentation/powerpc/dts-bindings.  All new bindings should be
documented and reviewed on devicetree-discuss before merging any
drivers that use them into mainline.

>From what I can tell by reading your code, I suspect that the binding
you've designed will solve your immediate problem, but won't be able
to handle anything slightly more complex, but it also looks like the
binding has been designed to be generic, usable by any display device.

First off, I did a tiny amount of research, and I didn't find any
existing OpenFirmware bindings for describing video displays.
Otherwise, I'd suggest considering that.

>From the little bit that I know, it seems that for most video devices
(ie. PCs) the video card discovers the capabilities of the screen by
reading the monitor's EDID data.  However, in your particular case
embedded case, a fixed flat panel is attached, and there isn't any
EDID data provided.  Therefore, you need an alternate method of
describing the display capabilities.  Rather than designing something
entirely new, you may want to consider using the EDID data format
directly; or at least cover the same things that EDID describes.  The
downside to using EDID directly is that it is a packed binary format
that isn't parseable by mere mortals; but the data contained in it
seems about right.  The upside is the kernel already knows what to do
with EDID data.

Otherwise you risk designing something that won't be useful for
anything much outside of your own use case.  For example, the binding
I see from the code cannot handle a display with multiple output
modes.

Also, since you're now in the realm of describing a video display,
which is separate from the display controller, you should consider
describing the display in a separate device tree node.  Maybe
something like this...

video {
        compatible =3D "fsl,mpc5121-diu";
        display {
                compatible =3D "<vendor>,<model>";
                edid =3D [edid-data];
        };
};

Cheers,
g.

>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> =A0drivers/video/Kconfig =A0| =A0 =A05 +++
> =A0drivers/video/Makefile | =A0 =A01 +
> =A0drivers/video/ofmode.c | =A0 95 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> =A0drivers/video/ofmode.h | =A0 =A06 +++
> =A04 files changed, 107 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/video/ofmode.c
> =A0create mode 100644 drivers/video/ofmode.h
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 5a5c303..dc1beb0 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -203,6 +203,11 @@ config FB_MACMODES
> =A0 =A0 =A0 =A0depends on FB
> =A0 =A0 =A0 =A0default n
>
> +config FB_OF_MODE
> + =A0 =A0 =A0 tristate
> + =A0 =A0 =A0 depends on FB && OF
> + =A0 =A0 =A0 default n
> +
> =A0config FB_BACKLIGHT
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0depends on FB
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 4ecb30c..c4a912b 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_FB_SVGALIB) =A0 =A0 =A0 +=3D svgalib.o
> =A0obj-$(CONFIG_FB_MACMODES) =A0 =A0 =A0+=3D macmodes.o
> =A0obj-$(CONFIG_FB_DDC) =A0 =A0 =A0 =A0 =A0 +=3D fb_ddc.o
> =A0obj-$(CONFIG_FB_DEFERRED_IO) =A0 +=3D fb_defio.o
> +obj-$(CONFIG_FB_OF_MODE) =A0 =A0 =A0 +=3D ofmode.o
>
> =A0# Hardware specific drivers go first
> =A0obj-$(CONFIG_FB_AMIGA) =A0 =A0 =A0 =A0 =A0 =A0+=3D amifb.o c2p_planar.=
o
> diff --git a/drivers/video/ofmode.c b/drivers/video/ofmode.c
> new file mode 100644
> index 0000000..78caad1
> --- /dev/null
> +++ b/drivers/video/ofmode.c
> @@ -0,0 +1,95 @@
> +/*
> + * Get video mode settings from Flattened Device Tree.
> + *
> + * Copyright (C) 2010 DENX Software Engineering.
> + * Anatolij Gustschin <agust@denx.de>
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License version 2. See the file COPYING in the main directory
> + * of this archive for more details.
> + */
> +
> +#include <linux/fb.h>
> +#include <linux/of.h>
> +
> +int __devinit of_get_video_mode(struct device_node *np,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct fb_i=
nfo *info)
> +{
> + =A0 =A0 =A0 struct fb_videomode dt_mode;
> + =A0 =A0 =A0 const u32 *prop;
> + =A0 =A0 =A0 unsigned int len;
> +
> + =A0 =A0 =A0 if (!np || !info)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "width", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 dt_mode.xres =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "height", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 dt_mode.yres =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "depth", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 info->var.bits_per_pixel =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "linebytes", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 info->fix.line_length =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "refresh", &len);
> + =A0 =A0 =A0 if (prop && len =3D=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dt_mode.refresh =3D *prop; /* optional */
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "pixclock", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 dt_mode.pixclock =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "left_margin", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 dt_mode.left_margin =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "right_margin", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 dt_mode.right_margin =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "upper_margin", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 dt_mode.upper_margin =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "lower_margin", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 dt_mode.lower_margin =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "hsync_len", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 dt_mode.hsync_len =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "vsync_len", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 dt_mode.vsync_len =3D *prop;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "sync", &len);
> + =A0 =A0 =A0 if (!prop || len !=3D sizeof(u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 dt_mode.sync =3D *prop;
> +
> + =A0 =A0 =A0 fb_videomode_to_var(&info->var, &dt_mode);
> +
> + =A0 =A0 =A0 return 0;
> +err:
> + =A0 =A0 =A0 pr_err("%s: Can't find expected mode entry\n", np->full_nam=
e);
> + =A0 =A0 =A0 return -EINVAL;
> +}
> diff --git a/drivers/video/ofmode.h b/drivers/video/ofmode.h
> new file mode 100644
> index 0000000..9a13bec
> --- /dev/null
> +++ b/drivers/video/ofmode.h
> @@ -0,0 +1,6 @@
> +#ifndef _OFMODE_H
> +#define _OFMODE_H
> +
> +extern int __devinit of_get_video_mode(struct device_node *np,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct fb_info *info);
> +#endif
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
