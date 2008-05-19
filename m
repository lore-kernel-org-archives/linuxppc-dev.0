Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 48582DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 03:29:01 +1000 (EST)
Date: Mon, 19 May 2008 21:28:58 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] of/gpio: use dynamic base allocation
Message-ID: <20080519172858.GA21832@polina.dev.rtsoft.ru>
References: <20080429140524.GA14573@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080429140524.GA14573@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 06:05:24PM +0400, Anton Vorontsov wrote:
> Since gpiolib-dynamic-gpio-number-allocation.patch -mm patch was recently
> merged into Linus' tree (commit 8d0aab2f16c4fa170f32e7a74a52cd0122bbafef),
> we can use dynamic GPIO base allocation now.
> 
> This, in turn, removes number of gpios per chip constraint.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Paul, could you please apply this for the powerpc-next?

Thanks.

>  drivers/of/gpio.c |   38 +-------------------------------------
>  1 files changed, 1 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
> index 000681e..1c9cab8 100644
> --- a/drivers/of/gpio.c
> +++ b/drivers/of/gpio.c
> @@ -137,38 +137,6 @@ int of_gpio_simple_xlate(struct of_gpio_chip *of_gc, struct device_node *np,
>  }
>  EXPORT_SYMBOL(of_gpio_simple_xlate);
>  
> -/* Should be sufficient for now, later we'll use dynamic bases. */
> -#if defined(CONFIG_PPC32) || defined(CONFIG_SPARC32)
> -#define GPIOS_PER_CHIP 32
> -#else
> -#define GPIOS_PER_CHIP 64
> -#endif
> -
> -static int of_get_gpiochip_base(struct device_node *np)
> -{
> -	struct device_node *gc = NULL;
> -	int gpiochip_base = 0;
> -
> -	while ((gc = of_find_all_nodes(gc))) {
> -		if (!of_get_property(gc, "gpio-controller", NULL))
> -			continue;
> -
> -		if (gc != np) {
> -			gpiochip_base += GPIOS_PER_CHIP;
> -			continue;
> -		}
> -
> -		of_node_put(gc);
> -
> -		if (gpiochip_base >= ARCH_NR_GPIOS)
> -			return -ENOSPC;
> -
> -		return gpiochip_base;
> -	}
> -
> -	return -ENOENT;
> -}
> -
>  /**
>   * of_mm_gpiochip_add - Add memory mapped GPIO chip (bank)
>   * @np:		device node of the GPIO chip
> @@ -205,11 +173,7 @@ int of_mm_gpiochip_add(struct device_node *np,
>  	if (!mm_gc->regs)
>  		goto err1;
>  
> -	gc->base = of_get_gpiochip_base(np);
> -	if (gc->base < 0) {
> -		ret = gc->base;
> -		goto err1;
> -	}
> +	gc->base = -1;
>  
>  	if (!of_gc->xlate)
>  		of_gc->xlate = of_gpio_simple_xlate;
> -- 
> 1.5.5.1

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
