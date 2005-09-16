Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9CDA2682DF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Sep 2005 02:27:36 +1000 (EST)
Date: Fri, 16 Sep 2005 09:27:33 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Stefan Roese <sr@denx.de>
Message-ID: <20050916162733.GA8019@gate.ebshome.net>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509151803.15301.sr@denx.de> <20050915092555.A27452@cox.net>
	<200509161306.17103.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200509161306.17103.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: cleanup AMCC PPC4xx eval boards to better
	support U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 16, 2005 at 01:06:16PM +0200, Stefan Roese wrote:
> Add U-Boot support to AMCC PPC405 eval boards (bubinga, sycamore and walnut)
> and cleanup PPC440 eval boards (bamboo, ebony, luan and ocotea) to better
> support U-Boot as bootloader.

In general, 44x pieces look OK, but 40x aren't. Notice, that we don't 
have any #ifdef CONFIG_UBOOT in 44x sources. Let's not add them for 
40x, try to replicate the same boot-wrapper approach as Matt used for 
44x.

[snip]

> diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
> --- a/arch/ppc/platforms/4xx/Kconfig
> +++ b/arch/ppc/platforms/4xx/Kconfig
> @@ -212,10 +212,18 @@ config EMBEDDEDBOOT
>  	depends on EP405 || XILINX_ML300
>  	default y
>  
> -config IBM_OPENBIOS
> -	bool
> +choice
> +	prompt "Bootloader support"
>  	depends on ASH || BUBINGA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
> -	default y
> +	default IBM_OPENBIOS
> +
> +config IBM_OPENBIOS
> +	bool "IBM OpenBIOS"
> +
> +config UBOOT
> +	bool "U-Boot"
> +
> +endchoice

Do we really need this? U-Boot build is different from OpenBIOS 
already (we just use vmlinux without any boot-wrapper) and is selected 
by different make target.

[snip]

> --- a/arch/ppc/platforms/4xx/bubinga.c
> +++ b/arch/ppc/platforms/4xx/bubinga.c
> @@ -89,7 +89,11 @@ bubinga_early_serial_map(void)
>            * by 16.
>            */
>  	uart_div = (mfdcr(DCRN_CPC0_UCR_BASE) & DCRN_CPC0_UCR_U0DIV);
> +#ifdef CONFIG_UBOOT
> +	uart_clock = __res.bi_procfreq / uart_div;
> +#else
>  	uart_clock = __res.bi_pllouta_freq / uart_div;
> +#endif

Why not just rename this field and skip this ugly ifdefing?

-- 
Eugene
