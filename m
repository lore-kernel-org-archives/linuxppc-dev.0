Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA95967C04
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 14:47:40 +1000 (EST)
In-Reply-To: <20060930215500.5ae1cec8.kim.phillips@freescale.com>
References: <20060930215500.5ae1cec8.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <00FB0505-D071-4FBA-9BCA-2E6E0B734A5A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add support for the e300c2 core
Date: Sat, 30 Sep 2006 23:48:17 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 30, 2006, at 9:55 PM, Kim Phillips wrote:

> Add support for the Freescale e300c2 core found in the MPC832x  
> processor line.
>
> As far as the kernel is concerned, the e300c2 core is identical to  
> the e300c1 found in the mpc834x, except that it's had its floating  
> point unit chopped off.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/kernel/cputable.c |   18 +++++++++++++++---
>  1 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/ 
> cputable.c
> index 190a57e..ce13830 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -63,6 +63,7 @@ #define COMMON_USER_PA6T	(COMMON_USER_PP
>  				 PPC_FEATURE_HAS_ALTIVEC_COMP)
>  #define COMMON_USER_BOOKE	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | \
>  				 PPC_FEATURE_BOOKE)
> +#define COMMON_USER_E300	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU)

Lets just drop COMMON_USER_E300 and explicitly set this like we do on  
8xx.

>  /* We only set the spe features if the kernel was compiled with
>   * spe support
> @@ -763,12 +764,23 @@ #if CLASSIC_PPC
>  		.cpu_setup		= __setup_cpu_603,
>  		.platform		= "ppc603",
>  	},
> -	{	/* e300 (a 603e core, plus some) on 83xx */
> +	{	/* e300c1 (a 603e core, plus some) on 83xx */
>  		.pvr_mask		= 0x7fff0000,
>  		.pvr_value		= 0x00830000,
> -		.cpu_name		= "e300",
> +		.cpu_name		= "e300c1",
>  		.cpu_features		= CPU_FTRS_E300,
> -		.cpu_user_features	= COMMON_USER,
> +		.cpu_user_features	= COMMON_USER_E300 | PPC_FEATURE_HAS_FPU,

This seems point less, why not just leave this as COMMON_USER for e300c1

> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 32,
> +		.cpu_setup		= __setup_cpu_603,
> +		.platform		= "ppc603",
> +	},
> +	{	/* e300c2 (an e300c1 core, plus some, minus FPU) on 83xx */
> +		.pvr_mask		= 0x7fff0000,
> +		.pvr_value		= 0x00840000,
> +		.cpu_name		= "e300c2",
> +		.cpu_features		= CPU_FTRS_E300,
> +		.cpu_user_features	= COMMON_USER_E300,

Why don't we just set .cpu_user_features = PPC_FEATURE_32 |  
PPC_FEATURE_HAS_MMU like we do on 8xx.

>  		.icache_bsize		= 32,
>  		.dcache_bsize		= 32,
>  		.cpu_setup		= __setup_cpu_603,

- kumar
