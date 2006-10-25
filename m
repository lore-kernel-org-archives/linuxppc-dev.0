Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id ED43567C27
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 23:59:03 +1000 (EST)
Date: Wed, 25 Oct 2006 08:58:53 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] Maple: Use RTAS power off methods if available
Message-ID: <20061025135853.GB5408@localdomain>
References: <20061025102823.CF83667BBC@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061025102823.CF83667BBC@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> 
> Index: powerpc/arch/powerpc/Kconfig
> ===================================================================
> --- powerpc.orig/arch/powerpc/Kconfig
> +++ powerpc/arch/powerpc/Kconfig
> @@ -422,6 +422,7 @@ config PPC_MAPLE
>  	select GENERIC_TBSYNC
>  	select PPC_UDBG_16550
>  	select PPC_970_NAP
> +	select PPC_RTAS
>  	default n
>  	help
>            This option enables support for the Maple 970FX Evaluation Board.
> Index: powerpc/arch/powerpc/platforms/maple/setup.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/platforms/maple/setup.c
> +++ powerpc/arch/powerpc/platforms/maple/setup.c
> @@ -61,6 +61,7 @@
>  #include <asm/lmb.h>
>  #include <asm/mpic.h>
>  #include <asm/udbg.h>
> +#include <asm/rtas.h>
>  
>  #include "maple.h"
>  
> @@ -185,6 +186,26 @@ void __init maple_setup_arch(void)
>  	printk(KERN_DEBUG "Using native/NAP idle loop\n");
>  }
>  
> +static void __init maple_check_for_rtas_poweroff(void)
> +{
> +#ifdef CONFIG_PPC_RTAS
> +	struct device_node *rtas;
> +
> +	rtas = of_find_node_by_path("/rtas");
> +	if (rtas) {
> +		if (get_property(rtas, "system-reboot", NULL))
> +			ppc_md.restart = rtas_restart;
> +
> +		if (get_property(rtas, "power-off", NULL)) {
> +			ppc_md.power_off = rtas_power_off;
> +			ppc_md.halt = rtas_halt;
> +		}
> +
> +		of_node_put(rtas);
> +	}
> +#endif

PPC_RTAS is selected in Kconfig, the ifdef isn't necessary.
