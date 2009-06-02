Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id E5C81DDDE1
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 20:49:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/5] powerpc: Introduce CONFIG_PPC_BOOK3S
Date: Tue, 2 Jun 2009 11:49:17 +0100
References: <20090602075022.57FE2DDF72@ozlabs.org>
In-Reply-To: <20090602075022.57FE2DDF72@ozlabs.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200906021149.17816.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 02 June 2009, Benjamin Herrenschmidt wrote:
> --- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype	2009-06-02 16:29:27.000000000 +1000
> +++ linux-work/arch/powerpc/platforms/Kconfig.cputype	2009-06-02 16:55:01.000000000 +1000
> @@ -9,7 +9,6 @@ menu "Processor support"
>  choice
>  	prompt "Processor Type"
>  	depends on PPC32
> -	default 6xx
>  	help
>  	  There are five families of 32 bit PowerPC chips supported.
>  	  The most common ones are the desktop and server CPUs (601, 603,

It looks like you couldn't decide which route to take here. You leave the
'depends on PPC32' above, but

> @@ -21,24 +20,27 @@ choice
>  
>  	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
>  
> -config 6xx
> +config PPC_BOOK3S
>  	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
>  	select PPC_FPU
>  
>  config PPC_85xx
>  	bool "Freescale 85xx"
> +	depends on PPC32
>  	select E500
>  	select FSL_SOC
>  	select MPC85xx
>  
>  config PPC_8xx
>  	bool "Freescale 8xx"
> +	depends on PPC32
>  	select FSL_SOC
>  	select 8xx
>  	select PPC_LIB_RHEAP

also add it (redundantly) in all other processor types except BOOK3S, and

> -# Until we have a choice of exclusive CPU types on 64-bit, we always
> -# use PPC_BOOK3S. On 32-bit, this is equivalent to 6xx which is
> -# "classic" MMU
> -
>  config PPC_BOOK3S
> -       def_bool y
> -       depends on PPC64 || 6xx
> +	default y
> +       	depends on PPC64
> +	select PPC_FPU
> +

then add the other BOOK3S option depending on PPC64. Even though
it might look silly to have a choice statement with just one possible
option in case of PPC64, why not integrate it right away, for consistency
reasons. It seems strange to have the same Kconfig symbol both
as a choice and a simple bool.

> @@ -125,6 +131,7 @@ config BOOKE
>  config FSL_BOOKE
>  	bool
>  	depends on E200 || E500
> +	select PPC_BOOK3E_MMU
>  	default y
>  
>  config FSL_EMB_PERFMON
> @@ -203,7 +210,7 @@ config SPE
>  
>  config PPC_STD_MMU
>  	bool
> -	depends on 6xx || PPC64
> +	depends on PPC_BOOK3S
>  	default y
>  
>  config PPC_STD_MMU_32

This also feels inconsistent, using a 'select' in one case and 'depends on' in the
other one. The two ways are obviously equivalent, but I find it a bit confusing
to mix them.

	Arnd <><
