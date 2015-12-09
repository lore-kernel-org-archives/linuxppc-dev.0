Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD7791A05EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 23:17:38 +1100 (AEDT)
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4396814030D
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2015 23:17:38 +1100 (AEDT)
Date: Wed, 9 Dec 2015 23:17:18 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH 2/2] powerpc: Copy only required pieces of the
 mm_context_t to the paca
Message-ID: <20151209231718.272afe94@kryten>
In-Reply-To: <1446008047-2393-2-git-send-email-mikey@neuling.org>
References: <1446008047-2393-1-git-send-email-mikey@neuling.org>
 <1446008047-2393-2-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Currently we copy the whole mm_context_t to the paca but only access a
> few bits of it.  This is wasteful of space paca and also takes quite
> some time in the hot path of context switching.
> 
> This patch pulls in only the required bits from the mm_context_t to
> the paca and on context switch, copies only those.
> 
> Benchmarking this (On top of Anton's recent MSR context switching
> changes [1]) using processes and yield shows an improvement of almost
> 3% on POWER8:
> 
>   http://ozlabs.org/~anton/junkcode/context_switch2.c
>   ./context_switch2 --test=yield --process 0 0

Now the context switch series is in, I tested this against powerpc-next
and still see a ~3% improvement.

Anton

> 1.
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135700.html
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/include/asm/paca.h   | 17 +++++++++++++++--
>  arch/powerpc/kernel/asm-offsets.c |  8 ++++----
>  arch/powerpc/mm/hash_utils_64.c   |  4 ++--
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/paca.h
> b/arch/powerpc/include/asm/paca.h index 1cc6e08..1c0d9f4 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -132,7 +132,13 @@ struct paca_struct {
>  #endif /* CONFIG_PPC_BOOK3E */
>  
>  #ifdef CONFIG_PPC_BOOK3S
> -	mm_context_t context;
> +	mm_context_id_t context_id;
> +#ifdef CONFIG_PPC_MM_SLICES
> +	u64 context_low_slices_psize;
> +	unsigned char context_high_slices_psize[SLICE_ARRAY_SIZE];
> +#else
> +	u16 context_sllp;
> +#endif
>  #endif
>  
>  	/*
> @@ -199,7 +205,14 @@ struct paca_struct {
>  #ifdef CONFIG_PPC_BOOK3S
>  static inline void copy_mm_to_paca(mm_context_t *context)
>  {
> -	get_paca()->context = *context;
> +	get_paca()->context_id = context->id;
> +#ifdef CONFIG_PPC_MM_SLICES
> +	get_paca()->context_low_slices_psize =
> context->low_slices_psize;
> +	memcpy(&get_paca()->context_high_slices_psize,
> +	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
> +#else
> +	get_paca()->context_sllp = context->sllp;
> +#endif
>  }
>  #else
>  static inline void copy_mm_to_paca(mm_context_t *context){}
> diff --git a/arch/powerpc/kernel/asm-offsets.c
> b/arch/powerpc/kernel/asm-offsets.c index 9db7be2..d5903a9 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -186,12 +186,12 @@ int main(void)
>  	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct,
> soft_enabled)); DEFINE(PACAIRQHAPPENED, offsetof(struct paca_struct,
> irq_happened)); #ifdef CONFIG_PPC_BOOK3S
> -	DEFINE(PACACONTEXTID, offsetof(struct paca_struct,
> context.id));
> +	DEFINE(PACACONTEXTID, offsetof(struct paca_struct,
> context_id)); #ifdef CONFIG_PPC_MM_SLICES
>  	DEFINE(PACALOWSLICESPSIZE, offsetof(struct paca_struct,
> -
> context.low_slices_psize));
> +
> context_low_slices_psize)); DEFINE(PACAHIGHSLICEPSIZE,
> offsetof(struct paca_struct,
> -
> context.high_slices_psize));
> +
> context_high_slices_psize)); DEFINE(MMUPSIZEDEFSIZE, sizeof(struct
> mmu_psize_def)); #endif /* CONFIG_PPC_MM_SLICES */
>  #endif
> @@ -224,7 +224,7 @@ int main(void)
>  #ifdef CONFIG_PPC_MM_SLICES
>  	DEFINE(MMUPSIZESLLP, offsetof(struct mmu_psize_def, sllp));
>  #else
> -	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct,
> context.sllp));
> +	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct,
> context_sllp)); #endif /* CONFIG_PPC_MM_SLICES */
>  	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
>  	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
> diff --git a/arch/powerpc/mm/hash_utils_64.c
> b/arch/powerpc/mm/hash_utils_64.c index fa62eb0..0e087e4 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -877,11 +877,11 @@ static unsigned int get_paca_psize(unsigned
> long addr) unsigned long index, mask_index;
>  
>  	if (addr < SLICE_LOW_TOP) {
> -		lpsizes = get_paca()->context.low_slices_psize;
> +		lpsizes = get_paca()->context_low_slices_psize;
>  		index = GET_LOW_SLICE_INDEX(addr);
>  		return (lpsizes >> (index * 4)) & 0xF;
>  	}
> -	hpsizes = get_paca()->context.high_slices_psize;
> +	hpsizes = get_paca()->context_high_slices_psize;
>  	index = GET_HIGH_SLICE_INDEX(addr);
>  	mask_index = index & 0x1;
>  	return (hpsizes[index >> 1] >> (mask_index * 4)) & 0xF;
