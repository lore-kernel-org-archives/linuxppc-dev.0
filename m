Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17EAEDDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 01:18:16 +1100 (EST)
Message-Id: <5535CAC8-11C4-4262-9B18-5F6416A51DE3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Ocker <weo@reccoware.de>
In-Reply-To: <1224764850.4082.54.camel@galileo.recco.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Specify GPIO number base for controller in DT
Date: Thu, 23 Oct 2008 09:18:12 -0500
References: <1224764850.4082.54.camel@galileo.recco.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 23, 2008, at 7:27 AM, Wolfgang Ocker wrote:

> The GPIOLIB allows the specification of a base gpio number for a
> controller. That is not possible using OF. Instead, free gpio numbers
> are assigned.
>
> In order to allow static, predefined gpio numbers, a base property in
> the gpio controller node specifies the first gpio number.
>
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
> ---
>
> --- linux-2.6.27-rc7/drivers/of/gpio.c.of_gpiospecbase	2008-09-22  
> 00:29:55.000000000 +0200
> +++ linux-2.6.27-rc7/drivers/of/gpio.c	2008-09-29 13:50:28.000000000  
> +0200
> @@ -164,6 +164,8 @@
> 	int ret = -ENOMEM;
> 	struct of_gpio_chip *of_gc = &mm_gc->of_gc;
> 	struct gpio_chip *gc = &of_gc->gc;
> +	const int *basep;
> +	int baselen;
>
> 	gc->label = kstrdup(np->full_name, GFP_KERNEL);
> 	if (!gc->label)
> @@ -173,7 +175,11 @@
> 	if (!mm_gc->regs)
> 		goto err1;
>
> -	gc->base = -1;
> +	basep = of_get_property(np, "base", &baselen);
> +	if (!basep || baselen != sizeof(*basep))
> +		gc->base = -1;
> +	else
> +		gc->base = *basep;
>
> 	if (!of_gc->xlate)
> 		of_gc->xlate = of_gpio_simple_xlate;
> --- linux-2.6.27-rc7/Documentation/powerpc/booting-without- 
> of.txt.spi_gpio_doc	2008-09-29 14:14:08.000000000 +0200
> +++ linux-2.6.27-rc7/Documentation/powerpc/booting-without-of.txt	 
> 2008-09-29 14:24:26.000000000 +0200
> @@ -2586,6 +2588,7 @@
> 		#gpio-cells = <2>;
> 		compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
> 		reg = <0x1400 0x18>;
> +		base = < 0x20 >;
> 		gpio-controller;
> 	};

We need the define what base is somewhere

- k
