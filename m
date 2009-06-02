Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7425DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 10:42:54 +1000 (EST)
Subject: Re: [Linux-fbdev-devel] [PATCH] GXT400P and GXT6500P support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: cjg@cruxppc.org
In-Reply-To: <1243841551.4215.5.camel@anestethize.cjg.home>
References: <a265241c0905271157s45e23528haefbd2fa31ba6763@mail.gmail.com>
	<20090530134236.b97158c9.krzysztof.h1@poczta.fm>
	<1243841551.4215.5.camel@anestethize.cjg.home>
Content-Type: text/plain
Date: Tue, 02 Jun 2009 10:42:38 +1000
Message-Id: <1243903358.591.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-06-01 at 09:32 +0200, Giuseppe Coviello wrote:

> 
> Signed-off-by: Nico Macrionitis <acrux@cruxppc.org>
> Signed-off-by: Giuseppe Coviello <cjg@cruxppc.org>

As long as you guys have verified that it actually works, I have
no objection.

Ack.

Cheers,
Ben.

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 0048f11..7ee1e65 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1964,14 +1964,16 @@ config FB_PNX4008_DUM_RGB
>  	  Say Y here to enable support for PNX4008 RGB Framebuffer
>  
>  config FB_IBM_GXT4500
> -	tristate "Framebuffer support for IBM GXT4500P adaptor"
> +	tristate "Framebuffer support for IBM GXT4000P/4500P/6000P/6500P adaptors"
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
>  
>  config FB_PS3
>  	tristate "PS3 GPU framebuffer driver"
> diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
> index 896e53d..a3c4d41 100644
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
>  
>  #define PCI_DEVICE_ID_IBM_GXT4500P	0x21c
> +#define PCI_DEVICE_ID_IBM_GXT6500P      0x21b
> +#define PCI_DEVICE_ID_IBM_GXT4000P      0x16e
>  #define PCI_DEVICE_ID_IBM_GXT6000P	0x170
>  
>  /* GXT4500P registers */
> @@ -173,6 +176,8 @@ static const struct fb_videomode defaultmode __devinitdata = {
>  /* List of supported cards */
>  enum gxt_cards {
>  	GXT4500P,
> +	GXT6500P,
> +	GXT4000P,
>  	GXT6000P
>  };
>  
> @@ -182,6 +187,8 @@ static const struct cardinfo {
>  	const char *cardname;
>  } cardinfo[] = {
>  	[GXT4500P] = { .refclk_ps = 9259, .cardname = "IBM GXT4500P" },
> +	[GXT6500P] = { .refclk_ps = 9259, .cardname = "IBM GXT6500P" },
> +	[GXT4000P] = { .refclk_ps = 40000, .cardname = "IBM GXT4000P" },
>  	[GXT6000P] = { .refclk_ps = 40000, .cardname = "IBM GXT6000P" },
>  };
>  
> @@ -736,6 +743,10 @@ static void __devexit gxt4500_remove(struct pci_dev *pdev)
>  static const struct pci_device_id gxt4500_pci_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4500P),
>  	  .driver_data = GXT4500P },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT6500P),
> +	  .driver_data = GXT6500P },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4000P),
> +	  .driver_data = GXT4000P },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT6000P),
>  	  .driver_data = GXT6000P },
>  	{ 0 }
> @@ -768,7 +779,7 @@ static void __exit gxt4500_exit(void)
>  module_exit(gxt4500_exit);
>  
>  MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
> -MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P/6000P");
> +MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P/6500P and GXT4000P/6000P");
>  MODULE_LICENSE("GPL");
>  module_param(mode_option, charp, 0);
>  MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\"");
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
