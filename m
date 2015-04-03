Return-Path: <pebolle@tiscali.nl>
Received: from lb2-smtp-cloud2.xs4all.net (lb2-smtp-cloud2.xs4all.net
 [194.109.24.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C05901A09FD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 23:01:35 +1100 (AEDT)
Message-ID: <1428062487.7898.12.camel@x220>
Subject: Re: [PATCH v2] powerpc/83xx: add support for mpc8306
From: Paul Bolle <pebolle@tiscali.nl>
To: Filip Brozovic <fbrozovic@gmail.com>
Date: Fri, 03 Apr 2015 14:01:27 +0200
In-Reply-To: <1428057856-26421-1-git-send-email-fbrozovic@gmail.com>
References: <1428057856-26421-1-git-send-email-fbrozovic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-03 at 12:44 +0200, Filip Brozovic wrote:
> --- a/arch/powerpc/platforms/83xx/Kconfig
> +++ b/arch/powerpc/platforms/83xx/Kconfig
 
> +# used for gpio
> +config PPC_MPC830x
> +	bool
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +
> +config PPC_MPC8306
> +	bool

To me these two new Kconfig symbols look pointless:
- they have no prompt, so one cannot set them manually;
- no other Kconfig symbol selects them;
- they do not default to 'y'.

I'm not aware of a way to set these symbols to 'y' outside of those
three. Is there perhaps a way for kconfig to set these symbols to 'y'
that I have missed?

Or do you expect to do one of these three things in a separate patch?

> --- a/arch/powerpc/platforms/83xx/usb.c
> +++ b/arch/powerpc/platforms/83xx/usb.c
> @@ -99,7 +99,7 @@ int mpc834x_usb_cfg(void)
>  }
>  #endif /* CONFIG_PPC_MPC834x */
>  
> -#ifdef CONFIG_PPC_MPC831x
> +#if defined(CONFIG_PPC_MPC8306) || defined(CONFIG_PPC_MPC831x)
>  int mpc831x_usb_cfg(void)
>  {
>  	u32 temp;

So I think this hunk is pointless.

> @@ -210,7 +218,7 @@ out:
>  	of_node_put(np);
>  	return ret;
>  }
> -#endif /* CONFIG_PPC_MPC831x */
> +#endif /* CONFIG_PPC_MPC8306 || CONFIG_PPC_MPC831x */
>  
>  #ifdef CONFIG_PPC_MPC837x
>  int mpc837x_usb_cfg(void)

Ditto.

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index c1e2ca3..4c60e7f 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -217,11 +217,11 @@ config GPIO_MPC5200
>  
>  config GPIO_MPC8XXX
>  	bool "MPC512x/MPC8xxx GPIO support"
> -	depends on PPC_MPC512x || PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || \
> -		   FSL_SOC_BOOKE || PPC_86xx
> +	depends on PPC_MPC512x || PPC_MPC830x || PPC_MPC831x || PPC_MPC834x || \
> +		   PPC_MPC837x || FSL_SOC_BOOKE || PPC_86xx
>  	help
>  	  Say Y here if you're going to use hardware that connects to the
> -	  MPC512x/831x/834x/837x/8572/8610 GPIOs.
> +	  MPC512x/830x/831x/834x/837x/8572/8610 GPIOs.
>  
>  config GPIO_MSM_V1
>  	tristate "Qualcomm MSM GPIO v1"

Ditto (except for the help change, which still might make sense).

Thanks,


Paul Bolle
