Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 949E21007E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:37:58 +1000 (EST)
Subject: Re: [PATCH 6/7] powerpc/mm: 64-bit: tlb handler micro-optimization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110518210536.GE29524@schlenkerla.am.freescale.net>
References: <20110518210536.GE29524@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 07:37:47 +1000
Message-ID: <1305754667.7481.5.camel@pasglop>
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

On Wed, 2011-05-18 at 16:05 -0500, Scott Wood wrote:
> A little more speed up measured on e5500.
> 
> Setting of U0-3 is dropped as it is not used by Linux as far as I can
> see.

Please keep them for now. If your core doesn't have them, make them an
MMU feature.

Cheers,
Ben.

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/mm/tlb_low_64e.S |   21 ++++++++-------------
>  1 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
> index e782023..a94c87b 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -47,10 +47,10 @@
>  	 * We could probably also optimize by not saving SRR0/1 in the
>  	 * linear mapping case but I'll leave that for later
>  	 */
> -	mfspr	r14,SPRN_ESR
>  	mfspr	r16,SPRN_DEAR		/* get faulting address */
>  	srdi	r15,r16,60		/* get region */
>  	cmpldi	cr0,r15,0xc		/* linear mapping ? */
> +	mfspr	r14,SPRN_ESR
>  	TLB_MISS_STATS_SAVE_INFO
>  	beq	tlb_load_linear		/* yes -> go to linear map load */
>  
> @@ -62,11 +62,11 @@
>  	andi.	r10,r15,0x1
>  	bne-	virt_page_table_tlb_miss
>  
> -	std	r14,EX_TLB_ESR(r12);	/* save ESR */
> -	std	r16,EX_TLB_DEAR(r12);	/* save DEAR */
> +	/* We need _PAGE_PRESENT and  _PAGE_ACCESSED set */
>  
> -	 /* We need _PAGE_PRESENT and  _PAGE_ACCESSED set */
> +	std	r14,EX_TLB_ESR(r12);	/* save ESR */
>  	li	r11,_PAGE_PRESENT
> +	std	r16,EX_TLB_DEAR(r12);	/* save DEAR */
>  	oris	r11,r11,_PAGE_ACCESSED@h
>  
>  	/* We do the user/kernel test for the PID here along with the RW test
> @@ -225,21 +225,16 @@ finish_normal_tlb_miss:
>  	 *                 yet implemented for now
>  	 * MAS 2   :	Defaults not useful, need to be redone
>  	 * MAS 3+7 :	Needs to be done
> -	 *
> -	 * TODO: mix up code below for better scheduling
>  	 */
>  	clrrdi	r11,r16,12		/* Clear low crap in EA */
> +	rldicr	r15,r14,64-(PTE_RPN_SHIFT-PAGE_SHIFT),63-PAGE_SHIFT
>  	rlwimi	r11,r14,32-19,27,31	/* Insert WIMGE */
> +	clrldi	r15,r15,12		/* Clear crap at the top */
>  	mtspr	SPRN_MAS2,r11
> -
> -	/* Move RPN in position */
> -	rldicr	r11,r14,64-(PTE_RPN_SHIFT-PAGE_SHIFT),63-PAGE_SHIFT
> -	clrldi	r15,r11,12		/* Clear crap at the top */
> -	rlwimi	r15,r14,32-8,22,25	/* Move in U bits */
> +	andi.	r11,r14,_PAGE_DIRTY
>  	rlwimi	r15,r14,32-2,26,31	/* Move in BAP bits */
>  
>  	/* Mask out SW and UW if !DIRTY (XXX optimize this !) */
> -	andi.	r11,r14,_PAGE_DIRTY
>  	bne	1f
>  	li	r11,MAS3_SW|MAS3_UW
>  	andc	r15,r15,r11
> @@ -483,10 +478,10 @@ virt_page_table_tlb_miss_whacko_fault:
>  	 * We could probably also optimize by not saving SRR0/1 in the
>  	 * linear mapping case but I'll leave that for later
>  	 */
> -	mfspr	r14,SPRN_ESR
>  	mfspr	r16,SPRN_DEAR		/* get faulting address */
>  	srdi	r11,r16,60		/* get region */
>  	cmpldi	cr0,r11,0xc		/* linear mapping ? */
> +	mfspr	r14,SPRN_ESR
>  	TLB_MISS_STATS_SAVE_INFO
>  	beq	tlb_load_linear		/* yes -> go to linear map load */
>  
