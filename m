Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id AC2E6DDE11
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 05:52:25 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/5] PowerPC 74xx: Katana Qp base support
Date: Sat, 24 Nov 2007 19:51:59 +0100
References: <20071116163116.GE25062@ru.mvista.com>
In-Reply-To: <20071116163116.GE25062@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711241952.00186.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 16 November 2007, Andrei Dolnikov wrote:

> +static int __init katanaqp_is_monarch(void)
> +{
> +	return !(in_8((volatile char *)(cpld_base + KATANAQP_CPLD_PSR)) &
> +		 KATANAQP_CPLD_PSR_PMCM);
> +}

The pointer here needs to be __iomem, not volatile. Same in other places.
Please use 'sparse' to check your code for bugs like this.

> +
> +static void __init katanaqp_setup_arch(void)
> +{
> +	struct device_node *cpld;
> +	const unsigned int *reg;
> +
> +	/*
> +	 * ioremap cpld registers in case they are later
> +	 * needed by katanaqp_reset_board().
> +	 */
> +	cpld = of_find_node_by_path("/mv64x60@f8100000/cpld@f8200000");

It doesn't sounds good to hardcode the path for this device.
Instead, it would be much better to look for the 'compatible' property
here.

> +static int __init katanaqp_of_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "cfi-flash");
> +	if (np)
> +		of_platform_device_create(np, "of-flash", NULL);
> +
> +	return 0;
> +}
> +
> +device_initcall(katanaqp_of_init);

This should be done automatically using of_platform_bus_probe().

	Arnd <><
