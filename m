Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3530BDE0B5
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 03:48:53 +1100 (EST)
Date: Wed, 12 Dec 2007 10:48:47 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC 1/7] [POWERPC] Implement GPIO API embryo
Message-ID: <20071212164847.GC4329@loki.buserror.net>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210204825.GA32278@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071210204825.GA32278@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 11:48:25PM +0300, Anton Vorontsov wrote:
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 232c298..596982f 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -73,6 +73,10 @@ config GENERIC_FIND_NEXT_BIT
>  	bool
>  	default y
>  
> +config GENERIC_GPIO
> +	bool
> +	default n
> +

default n is the default.  No need to explicitly state it.

> +
> +int __of_parse_gpio_bank_pin(struct device_node *np, int index,
> +			     int bank_width, int max_bank)

Why the leading underscores?

> diff --git a/include/asm-powerpc/gpio.h b/include/asm-powerpc/gpio.h
> new file mode 100644
> index 0000000..f7513ff
> --- /dev/null
> +++ b/include/asm-powerpc/gpio.h
> @@ -0,0 +1,51 @@
> +/*
> + * Generic GPIO API implementation for PowerPC.

Is there anything really powerpc specific here, or should it go under
drivers/of?

-Scott
