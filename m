Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80ED3DDE1A
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 04:52:34 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0BHqVBt016069
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 12:52:31 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0BHqVXJ061076
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 12:52:31 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0BHqUpL002563
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 12:52:31 -0500
Date: Fri, 11 Jan 2008 11:51:43 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 1/5] Warp Base Platform
Message-ID: <20080111115143.4ed89ab6@zod.rchland.ibm.com>
In-Reply-To: <47871675.6030602@pikatech.com>
References: <47852C41.8000506@pikatech.com>
	<20080111174259.b749f1f0.sfr@canb.auug.org.au>
	<47871675.6030602@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 11 Jan 2008 02:10:45 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> ---
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 66a3d8c..b3e4c35 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -469,7 +469,7 @@ config MCA
>  config PCI
>  	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
>  		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
> -		|| PPC_PS3
> +		|| PPC_PS3 || 44x
>  	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
>  		&& !PPC_85xx && !PPC_86xx
>  	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index d248013..a95409e 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -53,6 +53,19 @@ config RAINIER
>  	help
>  	  This option enables support for the AMCC PPC440GRX evaluation board.
> 
> +config WARP
> +	bool "PIKA Warp"
> +	depends on 44x
> +	default n
> +	select 440EP
> +	help
> +	  This option enables support for the PIKA Warp(tm) Appliance. The Warp
> +          is a small computer replacement with up to 9 ports of FXO/FXS plus VOIP
> +	  stations and trunks.
> +
> +	  See http://www.pikatechnologies.com/ and follow the "PIKA for Computer
> +	  Telephony Developers" link for more information.
> +
>  #config LUAN
>  #	bool "Luan"
>  #	depends on 44x
> @@ -75,6 +88,7 @@ config 440EP
>  	select PPC_FPU
>  	select IBM440EP_ERR42
>  	select IBM_NEW_EMAC_ZMII
> +	select USB_ARCH_HAS_OHCI
> 
>  config 440EPX
>  	bool
> diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
> index a2a0dc1..c1733c0 100644
> --- a/arch/powerpc/platforms/44x/Makefile
> +++ b/arch/powerpc/platforms/44x/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_BAMBOO)	+= bamboo.o
>  obj-$(CONFIG_SEQUOIA)	+= sequoia.o
>  obj-$(CONFIG_KATMAI)	+= katmai.o
>  obj-$(CONFIG_RAINIER)	+= rainier.o
> +obj-$(CONFIG_WARP)	+= warp.o
> --- /dev/null	2005-11-20 22:22:37.000000000 -0500
> +++ arch/powerpc/platforms/44x/warp.c	2008-01-11 02:08:20.000000000 -0500
> @@ -0,0 +1,244 @@
> +/*
> + * PIKA Warp(tm) board specific routines
> + *
> + * Copyright (c) 2008 PIKA Technologies
> + *   Sean MacLennan <smaclennan@pikatech.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +#include <linux/kthread.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/time.h>
> +#include <asm/uic.h>
> +
> +#include "44x.h"
> +
> +#define WARP_GPIO_BASE 0xEF600B00ULL

This should be in the device tree...

> +
> +/* This is for the power LEDs 1 = on, 0 = off, -1 = leave alone */
> +void warp_set_power_leds(int green, int red)
> +{
> +	static void *gpio_base = NULL;
> +	unsigned leds;
> +
> +	if (gpio_base == NULL) {
> +		gpio_base = ioremap(WARP_GPIO_BASE, 0x148);

... and you should get the resource for it from there instead of using
the #define.

> +		if (gpio_base == NULL) {
> +			printk("ERROR: Unable to remap GPIO base.\n");
> +			return;
> +		}
> +	}
> +
> +	leds = readl(gpio_base + 0x100);

Do you really want readl here?  That will byte-swap.

> +
> +	switch(green) {
> +	case 0: leds &= ~0x80; break;
> +	case 1: leds |=  0x80; break;
> +	}
> +	switch(red) {
> +	case 0: leds &= ~0x40; break;
> +	case 1: leds |=  0x40; break;
> +	}
> +
> +	writel(leds, gpio_base + 0x100);

Same here.

> +}
> +EXPORT_SYMBOL(warp_set_power_leds);

Hm... does this really need to be exported?

> +// SAM not yet #define NAND_FLASH
> +#ifdef NAND_FLASH
> +/* --- All of this code is for the NAND flash */

Perhaps you could split this out into warp-nand.c instead of ifdefing
it here.  That way it can be left uncompiled until we figure out the
NAND situation in general.

josh
