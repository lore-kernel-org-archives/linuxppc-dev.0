Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0F5BB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 12:01:01 +1000 (EST)
Subject: Re: [PATCH] powerpc/book3e-64: use a separate TLB handler when
	linear map is bolted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110603221232.GA29809@schlenkerla.am.freescale.net>
References: <20110603221232.GA29809@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jun 2011 12:00:50 +1000
Message-ID: <1308276050.2516.129.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-06-03 at 17:12 -0500, Scott Wood wrote:
> On MMUs such as FSL where we can guarantee the entire linear mapping is
> bolted, we don't need to worry about linear TLB misses.  If on top of
> that we do a full table walk, we get rid of all recursive TLB faults, and
> can dispense with some state saving.  This gains a few percent on
> TLB-miss-heavy workloads, and around 50% on a benchmark that had a high
> rate of virtual page table faults under the normal handler.
> 
> While touching the EX_TLB layout, remove EX_TLB_MMUCR0, EX_TLB_SRR0, and
> EX_TLB_SRR1 as they're not used.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This turned out to be a little faster than the virtual pmd approach
> on the sort benchmark as well as lmbench's lat_mem_rd with page stride.
> 
> It's slightly slower than virtual pmd (around 1%), but still faster than
> current code, on linear tests such as lmbench's bw_mem cp.

Does this completely replace your previous series of 7 patches ? (IE.
Should I ditch them in patchwork ?) Or does it apply on top of them ?

Some comments inline...

>  #define SET_IVOR(vector_number, vector_offset)	\
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index a73668a..9d9e444 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -54,6 +54,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	/* 64-bit Book3E keeps track of current PGD in the PACA */
>  #ifdef CONFIG_PPC_BOOK3E_64
>  	get_paca()->pgd = next->pgd;
> +	get_paca()->extlb[0][EX_TLB_PGD / 8] = (unsigned long)next->pgd;
>  #endif
>  	/* Nothing else to do if we aren't actually switching */
>  	if (prev == next)
> @@ -110,6 +111,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
>  	/* 64-bit Book3E keeps track of current PGD in the PACA */
>  #ifdef CONFIG_PPC_BOOK3E_64
>  	get_paca()->pgd = NULL;
> +	get_paca()->extlb[0][EX_TLB_PGD / 8] = 0;
>  #endif
>  }

Why do you keep a copy of the pgd there since it's in the PACA already
and you have r13 setup in your handlers ?

> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
> index af08922..0f4ab86 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -30,6 +30,212 @@
>  #define VPTE_PGD_SHIFT	(VPTE_PUD_SHIFT + PUD_INDEX_SIZE)
>  #define VPTE_INDEX_SIZE (VPTE_PGD_SHIFT + PGD_INDEX_SIZE)
>  
> +/**********************************************************************
> + *                                                                    *
> + * TLB miss handling for Book3E with a bolted linear mapping          *
> + * No virtual page table, no nested TLB misses                        *
> + *                                                                    *
> + **********************************************************************/
> +
> +.macro tlb_prolog_bolted addr
> +	mtspr	SPRN_SPRG_TLB_SCRATCH,r13
> +	mfspr	r13,SPRN_SPRG_PACA
> +	std	r10,PACA_EXTLB+EX_TLB_R10(r13)
> +	mfcr	r10
> +	std	r11,PACA_EXTLB+EX_TLB_R11(r13)
> +	mfspr	r11,SPRN_SPRG_TLB_SCRATCH

Do you need that ? Can't you leave r13 in scratch the whole way and
just pop it out in the error case when branching to DSI/ISI ? The only
thing is that TLB_SCRATCH needs to be saved/restored by
crit/debug/mcheck but thats worth saving cycles in the TLB miss handler
no ?

> +	std	r16,PACA_EXTLB+EX_TLB_R16(r13)
> +	mfspr	r16,\addr		/* get faulting address */
> +	std	r14,PACA_EXTLB+EX_TLB_R14(r13)
> +	ld	r14,PACA_EXTLB+EX_TLB_PGD(r13)

Why not get PGD from paca ?

> +	std	r15,PACA_EXTLB+EX_TLB_R15(r13)
> +	std	r10,PACA_EXTLB+EX_TLB_CR(r13)
> +	std	r11,PACA_EXTLB+EX_TLB_R13(r13)
> +	TLB_MISS_PROLOG_STATS_BOLTED
> +.endm
> +
> +.macro tlb_epilog_bolted
> +	ld	r14,PACA_EXTLB+EX_TLB_CR(r13)
> +	ld	r10,PACA_EXTLB+EX_TLB_R10(r13)
> +	ld	r11,PACA_EXTLB+EX_TLB_R11(r13)
> +	mtcr	r14
> +	ld	r14,PACA_EXTLB+EX_TLB_R14(r13)
> +	ld	r15,PACA_EXTLB+EX_TLB_R15(r13)
> +	TLB_MISS_RESTORE_STATS_BOLTED
> +	ld	r16,PACA_EXTLB+EX_TLB_R16(r13)
> +	ld	r13,PACA_EXTLB+EX_TLB_R13(r13)
> +.endm
> +
> +/* Data TLB miss */
> +	START_EXCEPTION(data_tlb_miss_bolted)
> +	tlb_prolog_bolted SPRN_DEAR
> +
> +	/* We need _PAGE_PRESENT and  _PAGE_ACCESSED set */
> +
> +	/* We do the user/kernel test for the PID here along with the RW test
> +	 */
> +	/* We pre-test some combination of permissions to avoid double
> +	 * faults:
> +	 *
> +	 * We move the ESR:ST bit into the position of _PAGE_BAP_SW in the PTE
> +	 * ESR_ST   is 0x00800000
> +	 * _PAGE_BAP_SW is 0x00000010
> +	 * So the shift is >> 19. This tests for supervisor writeability.
> +	 * If the page happens to be supervisor writeable and not user
> +	 * writeable, we will take a new fault later, but that should be
> +	 * a rare enough case.
> +	 *
> +	 * We also move ESR_ST in _PAGE_DIRTY position
> +	 * _PAGE_DIRTY is 0x00001000 so the shift is >> 11
> +	 *
> +	 * MAS1 is preset for all we need except for TID that needs to
> +	 * be cleared for kernel translations
> +	 */
> +
> +	mfspr	r11,SPRN_ESR
> +
> +	srdi	r15,r16,60		/* get region */
> +	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
> +	bne-	dtlb_miss_fault_bolted

Ok so I'm not familiar with your pipeline here, but wouldn't it be
better to move the srdi to after the bne above and make it srdi., thus
avoiding the compare below ?

> +	rlwinm	r10,r11,32-19,27,27
> +	rlwimi	r10,r11,32-16,19,19
> +	cmpwi	r15,0
> +	ori	r10,r10,_PAGE_PRESENT
> +	oris	r11,r10,_PAGE_ACCESSED@h
> +
> +	TLB_MISS_STATS_SAVE_INFO_BOLTED
> +	bne	tlb_miss_kernel_bolted
> +

Cheers,
Ben.
