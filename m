Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 89108DE05A
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 11:15:15 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBC0EWeV014538
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 19:14:32 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBC0FA4I162514
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 19:15:10 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBC0F9Hb014319
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 19:15:10 -0500
Date: Thu, 11 Dec 2008 19:15:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/9] powerpc: Fix bogus cache flushing on all 40x and
	BookE processors v2
Message-ID: <20081211191503.1e8bbf18@zod.rchland.ibm.com>
In-Reply-To: <20081208054038.20368DDE1F@ozlabs.org>
References: <1228714789.103940.266501677728.qpush@grosgo>
	<20081208054038.20368DDE1F@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 08 Dec 2008 16:39:52 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> We were missing the CPU_FTR_NOEXECUTE bit in our cputable for all
> these processors. The result is that update_mmu_cache() would flush
> the cache for all pages mapped to userspace which is totally
> unnecessary on those processors since we already handle flushing
> on execute in the page fault path.
> 
> This should provide a nice speed up ;-)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Kumar, feel free to take this through your tree.

josh

> ---
> 
> This one fixes the E500 definition and uses a bit that works
> for 32-bit processors
> 
>  arch/powerpc/include/asm/cputable.h |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> --- linux-work.orig/arch/powerpc/include/asm/cputable.h	2008-12-03 13:32:53.000000000 +1100
> +++ linux-work/arch/powerpc/include/asm/cputable.h	2008-12-08 15:42:13.000000000 +1100
> @@ -163,6 +163,7 @@ extern const char *powerpc_base_platform
>  #define CPU_FTR_SPE			ASM_CONST(0x0000000002000000)
>  #define CPU_FTR_NEED_PAIRED_STWCX	ASM_CONST(0x0000000004000000)
>  #define CPU_FTR_LWSYNC			ASM_CONST(0x0000000008000000)
> +#define CPU_FTR_NOEXECUTE		ASM_CONST(0x0000000010000000)
> 
>  /*
>   * Add the 64-bit processor unique features in the top half of the word;
> @@ -177,7 +178,6 @@ extern const char *powerpc_base_platform
>  #define CPU_FTR_SLB			LONG_ASM_CONST(0x0000000100000000)
>  #define CPU_FTR_16M_PAGE		LONG_ASM_CONST(0x0000000200000000)
>  #define CPU_FTR_TLBIEL			LONG_ASM_CONST(0x0000000400000000)
> -#define CPU_FTR_NOEXECUTE		LONG_ASM_CONST(0x0000000800000000)
>  #define CPU_FTR_IABR			LONG_ASM_CONST(0x0000002000000000)
>  #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000004000000000)
>  #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000008000000000)
> @@ -367,19 +367,20 @@ extern const char *powerpc_base_platform
>  #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | \
>  	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE)
>  #define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
> -#define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
> -#define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
> +#define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
> +#define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
>  #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
>  	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
> -	    CPU_FTR_UNIFIED_ID_CACHE)
> +	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE)
>  #define CPU_FTRS_E500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
> -	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN)
> +	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
> +	    CPU_FTR_NOEXECUTE)
>  #define CPU_FTRS_E500_2	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
>  	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | \
> -	    CPU_FTR_NODSISRALIGN)
> +	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
>  #define CPU_FTRS_E500MC	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
>  	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN | \
> -	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC)
> +	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE)
>  #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
> 
>  /* 64-bit CPUs */
