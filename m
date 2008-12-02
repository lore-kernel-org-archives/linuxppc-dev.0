Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF1E4DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 18:36:49 +1100 (EST)
Message-Id: <BD75FAE9-7D10-488B-9906-23B2D93F1FB6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081201060152.00DCCDDDE3@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Fix bogus cache flushing on all 40x and BookE
	processors
Date: Tue, 2 Dec 2008 01:36:40 -0600
References: <20081201060152.00DCCDDDE3@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 1, 2008, at 12:01 AM, Benjamin Herrenschmidt wrote:

> We were missing the CPU_FTR_NOEXECUTE bit in our cputable for all
> these processors. The result is that update_mmu_cache() would flush
> the cache for all pages mapped to userspace which is totally
> unnecessary on those processors since we already handle flushing
> on execute in the page fault path.
>
> This should provide a nice speed up ;-)
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> arch/powerpc/include/asm/cputable.h |   13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>
> --- linux-work.orig/arch/powerpc/include/asm/cputable.h	2008-12-01  
> 16:55:53.000000000 +1100
> +++ linux-work/arch/powerpc/include/asm/cputable.h	2008-12-01  
> 16:56:32.000000000 +1100
> @@ -366,19 +366,20 @@ extern const char *powerpc_base_platform
> #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | \
> 	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE)
> #define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
> -#define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
> -#define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
> +#define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN |  
> CPU_FTR_NOEXECUTE)
> +#define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN |  
> CPU_FTR_NOEXECUTE)
> #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
> 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
> -	    CPU_FTR_UNIFIED_ID_CACHE)
> +	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE)
> #define CPU_FTRS_E500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
> -	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN)
> +	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP |  
> CPU_FTR_NODSISRALIGN \

Added a '|' at the end of the line before the escape

>
> +	    CPU_FTR_NOEXECUTE)
> #define CPU_FTRS_E500_2	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
> 	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | \
> -	    CPU_FTR_NODSISRALIGN)
> +	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
> #define CPU_FTRS_E500MC	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
> 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN  
> | \
> -	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC)
> +	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE)
> #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)

- k
