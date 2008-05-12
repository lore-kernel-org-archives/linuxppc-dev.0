Return-Path: <dgibson@ozlabs.org>
Date: Mon, 12 May 2008 11:33:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] More useful cputable defaults
Message-ID: <20080512013357.GA5227@yookeroo.seuss>
References: <20080505052405.23E38DDE0A@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080505052405.23E38DDE0A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 05, 2008 at 03:22:27PM +1000, Benjamin Herrenschmidt wrote:
> Changes the cputable so that various CPU families that have an exclusive
> CONFIG_ option have a more sensible default entry to patch if the specific
> processor hasn't been identified.
> 
> This makes the kernel more generally useful when booted on an unknown
> PVR for things like new 4xx variants.

This patch (as commit 76bc080ef5a34aedb63e1691f28c6b42f3468e4e) leaves
the last cputable entry for E200 and E500 without a closing brace.

[...]
> -#elif defined(CONFIG_E500)
> +	{	/* default match */
> +		.pvr_mask		= 0x00000000,
> +		.pvr_value		= 0x00000000,
> +		.cpu_name		= "(generic E200 PPC)",
> +		.cpu_features		= CPU_FTRS_E200,
> +		.cpu_user_features	= COMMON_USER_BOOKE |
> +			PPC_FEATURE_HAS_EFP_SINGLE |
> +			PPC_FEATURE_UNIFIED_CACHE,
> +		.dcache_bsize		= 32,
> +		.machine_check		= machine_check_e200,
> +		.platform		= "ppc5554",

-> here

> +#endif /* CONFIG_E200 */
> +#ifdef CONFIG_E500

[snip]
> -#if !CLASSIC_PPC
>  	{	/* default match */
>  		.pvr_mask		= 0x00000000,
>  		.pvr_value		= 0x00000000,
> -		.cpu_name		= "(generic PPC)",
> -		.cpu_features		= CPU_FTRS_GENERIC_32,
> -		.cpu_user_features	= PPC_FEATURE_32,
> +		.cpu_name		= "(generic E500 PPC)",
> +		.cpu_features		= CPU_FTRS_E500,
> +		.cpu_user_features	= COMMON_USER_BOOKE |
> +			PPC_FEATURE_HAS_SPE_COMP |
> +			PPC_FEATURE_HAS_EFP_SINGLE_COMP,
>  		.icache_bsize		= 32,
>  		.dcache_bsize		= 32,
> +		.machine_check		= machine_check_e500,
>  		.platform		= "powerpc",
> -	}

-> and here.

> -#endif /* !CLASSIC_PPC */
> +#endif /* CONFIG_E500 */
>  #endif /* CONFIG_PPC32 */
>  };

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
