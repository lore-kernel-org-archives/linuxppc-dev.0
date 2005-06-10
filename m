Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7B966679F1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Jun 2005 01:24:44 +1000 (EST)
In-Reply-To: <20050607012009.GB16387@gate.ebshome.net>
References: <20050607012009.GB16387@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <27777aec8e616a79f994dca2935e26a7@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 10 Jun 2005 10:24:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: add 405EP cpu_spec entry
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Linus,

You have applied this patch twice now.

- kumar

On Jun 6, 2005, at 8:20 PM, Eugene Surovegin wrote:

> Andrew,
>
> the following patch adds definition for PPC 405EP which was lost
> somehow during 2.4 -> 2.6 transition.
>
> Recent change to arch/ppc/kernel/misc.S ("Fix incorrect CPU_FTR fixup
> usage for unified caches") triggered this bug and 405EP boards don't
> boot anymore.
>
> Please, consider applying this patch before 2.6.12 release.
>
> Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
>
> diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
> --- a/arch/ppc/kernel/cputable.c
> +++ b/arch/ppc/kernel/cputable.c
> @@ -838,6 +838,17 @@ struct cpu_spec	cpu_specs[] = {
>  		.icache_bsize		= 32,
>  		.dcache_bsize		= 32,
>  	},
> +	{	/* 405EP */
> +		.pvr_mask		= 0xffff0000,
> +		.pvr_value		= 0x51210000,
> +		.cpu_name		= "405EP",
> +		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
> +			CPU_FTR_USE_TB,
> +		.cpu_user_features	= PPC_FEATURE_32 |
> +			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 32,
> +	},
>
>  #endif /* CONFIG_40x */
>  #ifdef CONFIG_44x
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
