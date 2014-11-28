Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2B8E1A0BC5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Nov 2014 09:38:38 +1100 (AEDT)
In-Reply-To: <20140923035330.6097.43515.stgit@mars>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/book3s: Fix flush_tlb cpu_spec hook to take a generic
 argument.
Message-Id: <20141128223838.B21E51401B1@ozlabs.org>
Date: Sat, 29 Nov 2014 09:38:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-23-09 at 03:53:54 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The flush_tlb hook in cpu_spec was introduced as a generic function hook
> to invalidate TLBs. But the current implementation of flush_tlb hook
> takes IS (invalidation selector) as an argument which is architecture
> dependent. Hence, It is not right to have a generic routine where caller
> has to pass non-generic argument.
> 
> This patch fixes this and makes flush_tlb hook as high level API.
> 
> The old code used to call flush_tlb hook with IS=0 (single page) resulting
> partial invalidation of TLBs which is not right. This fix now makes
> sure that whole TLB is invalidated to be able to successfully recover from
> TLB and ERAT errors.

Which old code? You mean the MCE code I think. That's a bug fix, so it should
be a separate patch.

> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index daa5af9..ae3e74f 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -100,7 +100,7 @@ struct cpu_spec {
>  	/*
>  	 * Processor specific routine to flush tlbs.
>  	 */
> -	void		(*flush_tlb)(unsigned long inval_selector);
> +	void		(*flush_tlb)(unsigned int action);
>  
>  };
>  
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
> index d765144..068ac8b 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -112,6 +112,11 @@
>  #define TLBIEL_INVAL_SET_SHIFT	12
>  
>  #define POWER7_TLB_SETS		128	/* # sets in POWER7 TLB */
> +#define POWER8_TLB_SETS		512	/* # sets in POWER8 TLB */
> +
> +/* TLB flush actions. Used as argument to cpu_spec.flush_tlb() hook */
> +#define FLUSH_TLB_ALL		0	/* invalidate all TLBs */
> +#define FLUSH_TLB_LPID		1	/* invalidate TLBs for current LPID */

Now that these are generic actions then they should go in cputable.h with the
flush hook.

> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
> index 4673353..9c9b741 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -137,15 +137,11 @@ __init_HFSCR:
>  /*
>   * Clear the TLB using the specified IS form of tlbiel instruction
>   * (invalidate by congruence class). P7 has 128 CCs., P8 has 512.
> - *
> - * r3 = IS field
>   */
>  __init_tlb_power7:
> -	li	r3,0xc00	/* IS field = 0b11 */
> -_GLOBAL(__flush_tlb_power7)
>  	li	r6,128
>  	mtctr	r6
> -	mr	r7,r3		/* IS field */
> +	li	r7,0xc00	/* IS field = 0b11 */
>  	ptesync
>  2:	tlbiel	r7
>  	addi	r7,r7,0x1000

So the current version is:

_GLOBAL(__flush_tlb_power7)
	li	r6,128
	mtctr	r6
	mr	r7,r3		/* IS field */
	ptesync
2:	tlbiel	r7
	addi	r7,r7,0x1000
	bdnz	2b
	ptesync
1:	blr

ie. a loop preceeded and followed by ptesync.

Your new version is:

> +static void _flush_tlb(uint32_t tlb_set, unsigned long inval_selector)
> +{
> +	unsigned long i, rb;
> +
> +	rb = inval_selector;
> +	for (i = 0; i < tlb_set; i++) {
> +		asm volatile("tlbiel %0" : : "r" (rb));
> +		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
> +	}
> +}

ie. no ptesyncs at all.

But there's no mention of that in the changelog. You need to explain why it is
OK to drop the ptesyncs.

> +/*
> + * Generic routine to flush TLB on power7. This routine is used as
> + * flush_tlb hook in cpu_spec for Power7 processor.
> + *
> + * action => FLUSH_TLB_ALL:  Invalidate all TLBs.
> + *	     FLUSH_TLB_LPID: Invalidate TLB for current LPID.
> + */
> +void __flush_tlb_power7(unsigned int action)
> +{
> +	switch (action) {
> +	case FLUSH_TLB_ALL:
> +		_flush_tlb(POWER7_TLB_SETS, TLBIEL_INVAL_SET);
> +		break;
> +	case FLUSH_TLB_LPID:
> +		_flush_tlb(POWER7_TLB_SETS, TLBIEL_INVAL_SET_LPID);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +/*
> + * Generic routine to flush TLB on power8. This routine is used as
> + * flush_tlb hook in cpu_spec for power8 processor.
> + *
> + * action => FLUSH_TLB_ALL:  Invalidate all TLBs.
> + *	     FLUSH_TLB_LPID: Invalidate TLB for current LPID.
> + */
> +void __flush_tlb_power8(unsigned int action)
> +{
> +	switch (action) {
> +	case FLUSH_TLB_ALL:
> +		_flush_tlb(POWER8_TLB_SETS, TLBIEL_INVAL_SET);
> +		break;
> +	case FLUSH_TLB_LPID:
> +		_flush_tlb(POWER8_TLB_SETS, TLBIEL_INVAL_SET_LPID);
> +		break;
> +	default:
> +		break;
> +	}
> +}

How about this:

void flush_tlb_206(unsigned num_sets, unsigned int action)
{
	unsigned long rb;
	int i;

	switch (action) {
	case FLUSH_TLB_ALL:
		rb = TLBIEL_INVAL_SET;
		break;
	case FLUSH_TLB_LPID:
		rb = TLBIEL_INVAL_SET_LPID;
		break;
	default:
		BUG();
	}

	for (i = 0; i < num_sets; i++) {
		asm volatile("tlbiel %0" : : "r" (rb));
		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
	}
}

void flush_tlb_power8(unsigned int action)
{
	flush_tlb_206(POWER8_TLB_SETS, action);
}

void flush_tlb_power7(unsigned int action)
{
	flush_tlb_206(POWER7_TLB_SETS, action);
}

cheers
