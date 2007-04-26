Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 29F7EDDFC1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:42:51 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/13] powerpc: Add arch/powerpc support for
	Marvell/mv64x60 hostbridge
Date: Thu, 26 Apr 2007 02:42:39 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235858.GH4046@mag.az.mvista.com>
In-Reply-To: <20070425235858.GH4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704260242.39993.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c	2007-04-17 12:48:22.000000000 -0700
> @@ -0,0 +1,343 @@
> +/*
> + * Common routines for the Marvell mv64360/mv64460 host bridges (Discovery)
> + *
> +/* Interrupt Controller Interface Registers */

I'd make this a file that _only_ deals with the interrupt controller
code, and has a respective name, e.g. mv64x60_irq.c

> +/*
> + * The bootwrapper sets the coherency of the DMA windows according to
> + * the setting in the device tree.  For the kernel, coherency is a
> + * compile-time configuration option.  Fail if there is a mismatch.
> + */
> +
> +#ifdef CONFIG_NOT_COHERENT_CACHE
> +#define KERNEL_COHERENCY	0
> +#else
> +#define KERNEL_COHERENCY	1
> +#endif
> +
> +int __init mv64x60_verify_cache_coherency(void)
> +{
> +	struct device_node *np;
> +	const void *prop;
> +	int devtree_coherency;
> +
> +	np = of_find_node_by_path("/");
> +	prop = of_get_property(np, "coherency-off", NULL);
> +	of_node_put(np);
> +
> +	devtree_coherency = prop ? 0 : 1;
> +
> +	if (devtree_coherency != KERNEL_COHERENCY) {
> +		printk(KERN_ERR
> +			"kernel coherency:%s != device tree_coherency:%s\n",
> +			KERNEL_COHERENCY ? "on" : "off",
> +			devtree_coherency ? "on" : "off");
> +		BUG();
> +	}
> +
> +	return 0;
> +
> +late_initcall(mv64x60_verify_cache_coherency);

Not sure where to best put this function, but probably not in the same file as
your interrupt handling code.

Note that the way your function is written, there is nothing specific to
mv64x60 in it, and it will actually get called on other machines when the
file is built-in.

Maybe just rename it to verify_cache_coherency() and put it into
arch/powerpc/kernel/setup-common.c.

	Arnd <><
