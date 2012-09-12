Return-Path: <acrux_it@libero.it>
Received: from outrelay07.libero.it (outrelay07.libero.it [212.52.84.111])
 by ozlabs.org (Postfix) with ESMTP id 35B442C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 08:54:11 +1000 (EST)
Date: Thu, 13 Sep 2012 00:47:31 +0200
From: Nik Mak <acrux_it@libero.it>
To: Dan =?ISO-8859-1?Q?Hor=E1k?= <dan@danny.cz>
Subject: Re: [PATCH] add GXT4000P and GXT6500P support to the gxt4500 driver
Message-Id: <20120913004731.a0e48fccc424ba6a15469577@libero.it>
In-Reply-To: <1347466004-14592-1-git-send-email-dan@danny.cz>
References: <1347466004-14592-1-git-send-email-dan@danny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nico Macrionitis <acrux@cruxppc.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Right, as far as i'm concerced that patch always worked without issues.

--nico




On Wed, 12 Sep 2012 18:06:44 +0200
Dan Hor=E1k <dan@danny.cz> wrote:

> I'm reviving an old patch from 2009 that adds support for GXT4000P and GX=
T6500P
> adapter to the gxt4500 driver.
>=20
> See threads at http://marc.info/?l=3Dlinux-fbdev-devel&m=3D12434508021695=
2&w=3D2
> and https://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072672.html
> for more details.
>=20
> This patch adds support for GXT4000P and GXT6500P cards found on some
> IBM pSeries machines.
> GXT4000P/6000P and GXT4500P/6500P  couples are  identical from
> software's point of view and are based on the same  Raster Engine
> (RC1000), except for a different reference clock for the PLL.
> GXT6x00P models are equipped with an additional Geometry Engine
> (GT1000) but this driver doesn't use it.
>=20
> Signed-off-by: Nico Macrionitis <acrux@cruxppc.org>
> Signed-off-by: Giuseppe Coviello <cjg@cruxppc.org>
> Tested-by: Dan Hor=E1k <dan@danny.cz>
> ---
>  drivers/video/Kconfig   |    8 +++++---
>  drivers/video/gxt4500.c |   15 +++++++++++++--
>  2 files changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 0217f74..c89eb1e 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2167,14 +2167,16 @@ config FB_PNX4008_DUM_RGB
>  	  Say Y here to enable support for PNX4008 RGB Framebuffer
> =20
>  config FB_IBM_GXT4500
> -	tristate "Framebuffer support for IBM GXT4500P adaptor"
> +	tristate "Framebuffer support for IBM GXT4000P/4500P/6000P/6500P adapto=
rs"
>  	depends on FB && PPC
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>  	---help---
> -	  Say Y here to enable support for the IBM GXT4500P display
> -	  adaptor, found on some IBM System P (pSeries) machines.
> +	  Say Y here to enable support for the IBM GXT4000P/6000P and
> +	  GXT4500P/6500P display adaptor based on Raster Engine RC1000,
> +	  found on some IBM System P (pSeries) machines. This driver
> +	  doesn't use Geometry Engine GT1000.
> =20
>  config FB_PS3
>  	tristate "PS3 GPU framebuffer driver"
> diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
> index 0fad23f..755c3e7 100644
> --- a/drivers/video/gxt4500.c
> +++ b/drivers/video/gxt4500.c
> @@ -1,5 +1,6 @@
>  /*
> - * Frame buffer device for IBM GXT4500P and GXT6000P display adaptors
> + * Frame buffer device for IBM GXT4500P/6500P and GXT4000P/6000P
> + * display adaptors
>   *
>   * Copyright (C) 2006 Paul Mackerras, IBM Corp. <paulus@samba.org>
>   */
> @@ -14,6 +15,8 @@
>  #include <linux/string.h>
> =20
>  #define PCI_DEVICE_ID_IBM_GXT4500P	0x21c
> +#define PCI_DEVICE_ID_IBM_GXT6500P	0x21b
> +#define PCI_DEVICE_ID_IBM_GXT4000P	0x16e
>  #define PCI_DEVICE_ID_IBM_GXT6000P	0x170
> =20
>  /* GXT4500P registers */
> @@ -173,6 +176,8 @@ static const struct fb_videomode defaultmode __devini=
tdata =3D {
>  /* List of supported cards */
>  enum gxt_cards {
>  	GXT4500P,
> +	GXT6500P,
> +	GXT4000P,
>  	GXT6000P
>  };
> =20
> @@ -182,6 +187,8 @@ static const struct cardinfo {
>  	const char *cardname;
>  } cardinfo[] =3D {
>  	[GXT4500P] =3D { .refclk_ps =3D 9259, .cardname =3D "IBM GXT4500P" },
> +	[GXT6500P] =3D { .refclk_ps =3D 9259, .cardname =3D "IBM GXT6500P" },
> +	[GXT4000P] =3D { .refclk_ps =3D 40000, .cardname =3D "IBM GXT4000P" },
>  	[GXT6000P] =3D { .refclk_ps =3D 40000, .cardname =3D "IBM GXT6000P" },
>  };
> =20
> @@ -736,6 +743,10 @@ static void __devexit gxt4500_remove(struct pci_dev =
*pdev)
>  static const struct pci_device_id gxt4500_pci_tbl[] =3D {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4500P),
>  	  .driver_data =3D GXT4500P },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT6500P),
> +	  .driver_data =3D GXT6500P },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4000P),
> +	  .driver_data =3D GXT4000P },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT6000P),
>  	  .driver_data =3D GXT6000P },
>  	{ 0 }
> @@ -768,7 +779,7 @@ static void __exit gxt4500_exit(void)
>  module_exit(gxt4500_exit);
> =20
>  MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
> -MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P/6000P");
> +MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P/6500P and GXT4000P/600=
0P");
>  MODULE_LICENSE("GPL");
>  module_param(mode_option, charp, 0);
>  MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<b=
pp>][@<refresh>]\"");
> --=20
> 1.7.7.6
>=20


--=20
Sent from Genesi EfikaMX Smartbook - Freescale i.MX51 based
