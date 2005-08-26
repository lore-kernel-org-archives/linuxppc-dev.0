Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050823225303.GF31949@krispykreme>
References: <20050823225303.GF31949@krispykreme>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0192F2FD-0132-4B51-9524-590084E3FB0B@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 26 Aug 2005 14:00:43 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc64: Add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Any reason we shouldn't do the same thing on ppc32?

- kumar

On Aug 23, 2005, at 5:53 PM, Anton Blanchard wrote:

>
> Hi,
>
> While ppc64 has the CONFIG_HZ Kconfig option, it wasnt actually being
> used. Connect it up and set all platforms to 250Hz.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
>
> Index: build/include/asm-ppc64/param.h
> ===================================================================
> --- build.orig/include/asm-ppc64/param.h    2005-08-15
> 23:42:07.000000000 +1000
> +++ build/include/asm-ppc64/param.h    2005-08-24 08:02:29.000000000
> +1000
> @@ -1,6 +1,8 @@
>  #ifndef _ASM_PPC64_PARAM_H
>  #define _ASM_PPC64_PARAM_H
>
> +#include <linux/config.h>
> +
>  /*
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
> @@ -9,7 +11,7 @@
>   */
>
>  #ifdef __KERNEL__
> -# define HZ        1000        /* Internal kernel timer
> frequency */
> +# define HZ        CONFIG_HZ    /* Internal kernel timer
> frequency */
>  # define USER_HZ    100        /* .. some user interfaces are
> in "ticks" */
>  # define CLOCKS_PER_SEC    (USER_HZ)    /* like times() */
>  #endif
> Index: build/arch/ppc64/configs/g5_defconfig
> ===================================================================
> --- build.orig/arch/ppc64/configs/g5_defconfig    2005-08-15
> 23:42:04.000000000 +1000
> +++ build/arch/ppc64/configs/g5_defconfig    2005-08-24
> 07:55:50.000000000 +1000
> @@ -103,10 +103,10 @@
>  # CONFIG_PREEMPT_VOLUNTARY is not set
>  # CONFIG_PREEMPT is not set
>  # CONFIG_PREEMPT_BKL is not set
> -CONFIG_HZ_100=y
> -# CONFIG_HZ_250 is not set
> +# CONFIG_HZ_100 is not set
> +CONFIG_HZ_250=y
>  # CONFIG_HZ_1000 is not set
> -CONFIG_HZ=100
> +CONFIG_HZ=250
>  CONFIG_GENERIC_HARDIRQS=y
>  CONFIG_SECCOMP=y
>  CONFIG_ISA_DMA_API=y
> Index: build/arch/ppc64/configs/iSeries_defconfig
> ===================================================================
> --- build.orig/arch/ppc64/configs/iSeries_defconfig    2005-08-15
> 23:42:04.000000000 +1000
> +++ build/arch/ppc64/configs/iSeries_defconfig    2005-08-24
> 07:56:46.000000000 +1000
> @@ -94,10 +94,10 @@
>  # CONFIG_PREEMPT_VOLUNTARY is not set
>  # CONFIG_PREEMPT is not set
>  # CONFIG_PREEMPT_BKL is not set
> -CONFIG_HZ_100=y
> -# CONFIG_HZ_250 is not set
> +# CONFIG_HZ_100 is not set
> +CONFIG_HZ_250=y
>  # CONFIG_HZ_1000 is not set
> -CONFIG_HZ=100
> +CONFIG_HZ=250
>  CONFIG_GENERIC_HARDIRQS=y
>  CONFIG_MSCHUNKS=y
>  CONFIG_LPARCFG=y
> Index: build/arch/ppc64/configs/maple_defconfig
> ===================================================================
> --- build.orig/arch/ppc64/configs/maple_defconfig    2005-08-15
> 23:42:04.000000000 +1000
> +++ build/arch/ppc64/configs/maple_defconfig    2005-08-24
> 08:46:58.000000000 +1000
> @@ -103,10 +103,10 @@
>  # CONFIG_PREEMPT_VOLUNTARY is not set
>  # CONFIG_PREEMPT is not set
>  # CONFIG_PREEMPT_BKL is not set
> -CONFIG_HZ_100=y
> -# CONFIG_HZ_250 is not set
> +# CONFIG_HZ_100 is not set
> +CONFIG_HZ_250=y
>  # CONFIG_HZ_1000 is not set
> -CONFIG_HZ=100
> +CONFIG_HZ=250
>  CONFIG_GENERIC_HARDIRQS=y
>  CONFIG_SECCOMP=y
>  CONFIG_ISA_DMA_API=y
> Index: build/arch/ppc64/configs/pSeries_defconfig
> ===================================================================
> --- build.orig/arch/ppc64/configs/pSeries_defconfig    2005-08-15
> 23:42:04.000000000 +1000
> +++ build/arch/ppc64/configs/pSeries_defconfig    2005-08-24
> 07:58:38.000000000 +1000
> @@ -112,10 +112,10 @@
>  # CONFIG_PREEMPT_VOLUNTARY is not set
>  # CONFIG_PREEMPT is not set
>  # CONFIG_PREEMPT_BKL is not set
> -CONFIG_HZ_100=y
> -# CONFIG_HZ_250 is not set
> +# CONFIG_HZ_100 is not set
> +CONFIG_HZ_250=y
>  # CONFIG_HZ_1000 is not set
> -CONFIG_HZ=100
> +CONFIG_HZ=250
>  CONFIG_EEH=y
>  CONFIG_GENERIC_HARDIRQS=y
>  CONFIG_PPC_RTAS=y
> Index: build/arch/ppc64/defconfig
> ===================================================================
> --- build.orig/arch/ppc64/defconfig    2005-08-15 23:42:04.000000000
> +1000
> +++ build/arch/ppc64/defconfig    2005-08-24 07:55:27.000000000 +1000
> @@ -114,10 +114,10 @@
>  # CONFIG_PREEMPT_VOLUNTARY is not set
>  # CONFIG_PREEMPT is not set
>  # CONFIG_PREEMPT_BKL is not set
> -CONFIG_HZ_100=y
> -# CONFIG_HZ_250 is not set
> +# CONFIG_HZ_100 is not set
> +CONFIG_HZ_250=y
>  # CONFIG_HZ_1000 is not set
> -CONFIG_HZ=100
> +CONFIG_HZ=250
>  CONFIG_EEH=y
>  CONFIG_GENERIC_HARDIRQS=y
>  CONFIG_PPC_RTAS=y
> _______________________________________________
> Linuxppc64-dev mailing list
> Linuxppc64-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc64-dev
>
