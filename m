Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB802DDE23
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 08:38:53 +1000 (EST)
Subject: Re: [PATCH] POWERPC: Rename PTE_SIZE to HPTE_SIZE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1220456273-6453-1-git-send-email-becky.bruce@freescale.com>
References: <1220456273-6453-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 08:38:37 +1000
Message-Id: <1220567917.4879.87.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-09-03 at 10:37 -0500, Becky Bruce wrote:
> It's the size of the hardware PTE; make that clear in the name.
> 
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
> ---
>  arch/powerpc/mm/hash_low_32.S |   36 ++++++++++++++++++------------------
>  1 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
> index b9ba7d9..c41d658 100644
> --- a/arch/powerpc/mm/hash_low_32.S
> +++ b/arch/powerpc/mm/hash_low_32.S
> @@ -285,7 +285,7 @@ Hash_bits = 12				/* e.g. 256kB hash table */
>  Hash_msk = (((1 << Hash_bits) - 1) * 64)
>  
>  /* defines for the PTE format for 32-bit PPCs */
> -#define PTE_SIZE	8
> +#define HPTE_SIZE	8
>  #define PTEG_SIZE	64
>  #define LG_PTEG_SIZE	6
>  #define LDPTEu		lwzu
> @@ -342,8 +342,8 @@ _GLOBAL(hash_page_patch_A)
>  
>  	/* Search the primary PTEG for a PTE whose 1st (d)word matches r5 */
>  	mtctr	r0
> -	addi	r4,r3,-PTE_SIZE
> -1:	LDPTEu	r6,PTE_SIZE(r4)		/* get next PTE */
> +	addi	r4,r3,-HPTE_SIZE
> +1:	LDPTEu	r6,HPTE_SIZE(r4)	/* get next PTE */
>  	CMPPTE	0,r6,r5
>  	bdnzf	2,1b			/* loop while ctr != 0 && !cr0.eq */
>  	beq+	found_slot
> @@ -353,9 +353,9 @@ _GLOBAL(hash_page_patch_A)
>  _GLOBAL(hash_page_patch_B)
>  	xoris	r4,r3,Hash_msk>>16	/* compute secondary hash */
>  	xori	r4,r4,(-PTEG_SIZE & 0xffff)
> -	addi	r4,r4,-PTE_SIZE
> +	addi	r4,r4,-HPTE_SIZE
>  	mtctr	r0
> -2:	LDPTEu	r6,PTE_SIZE(r4)
> +2:	LDPTEu	r6,HPTE_SIZE(r4)
>  	CMPPTE	0,r6,r5
>  	bdnzf	2,2b
>  	beq+	found_slot
> @@ -363,8 +363,8 @@ _GLOBAL(hash_page_patch_B)
>  
>  	/* Search the primary PTEG for an empty slot */
>  10:	mtctr	r0
> -	addi	r4,r3,-PTE_SIZE		/* search primary PTEG */
> -1:	LDPTEu	r6,PTE_SIZE(r4)		/* get next PTE */
> +	addi	r4,r3,-HPTE_SIZE	/* search primary PTEG */
> +1:	LDPTEu	r6,HPTE_SIZE(r4)	/* get next PTE */
>  	TST_V(r6)			/* test valid bit */
>  	bdnzf	2,1b			/* loop while ctr != 0 && !cr0.eq */
>  	beq+	found_empty
> @@ -380,9 +380,9 @@ _GLOBAL(hash_page_patch_B)
>  _GLOBAL(hash_page_patch_C)
>  	xoris	r4,r3,Hash_msk>>16	/* compute secondary hash */
>  	xori	r4,r4,(-PTEG_SIZE & 0xffff)
> -	addi	r4,r4,-PTE_SIZE
> +	addi	r4,r4,-HPTE_SIZE
>  	mtctr	r0
> -2:	LDPTEu	r6,PTE_SIZE(r4)
> +2:	LDPTEu	r6,HPTE_SIZE(r4)
>  	TST_V(r6)
>  	bdnzf	2,2b
>  	beq+	found_empty
> @@ -409,11 +409,11 @@ _GLOBAL(hash_page_patch_C)
>  
>  1:	addis	r4,r7,next_slot@ha		/* get next evict slot */
>  	lwz	r6,next_slot@l(r4)
> -	addi	r6,r6,PTE_SIZE			/* search for candidate */
> -	andi.	r6,r6,7*PTE_SIZE
> +	addi	r6,r6,HPTE_SIZE			/* search for candidate */
> +	andi.	r6,r6,7*HPTE_SIZE
>  	stw	r6,next_slot@l(r4)
>  	add	r4,r3,r6
> -	LDPTE	r0,PTE_SIZE/2(r4)		/* get PTE second word */
> +	LDPTE	r0,HPTE_SIZE/2(r4)		/* get PTE second word */
>  	clrrwi	r0,r0,12
>  	lis	r6,etext@h
>  	ori	r6,r6,etext@l			/* get etext */
> @@ -426,7 +426,7 @@ _GLOBAL(hash_page_patch_C)
>  found_empty:
>  	STPTE	r5,0(r4)
>  found_slot:
> -	STPTE	r8,PTE_SIZE/2(r4)
> +	STPTE	r8,HPTE_SIZE/2(r4)
>  
>  #else /* CONFIG_SMP */
>  /*
> @@ -452,7 +452,7 @@ found_slot:
>  	STPTE	r5,0(r4)
>  	sync
>  	TLBSYNC
> -	STPTE	r8,PTE_SIZE/2(r4) /* put in correct RPN, WIMG, PP bits */
> +	STPTE	r8,HPTE_SIZE/2(r4) /* put in correct RPN, WIMG, PP bits */
>  	sync
>  	SET_V(r5)
>  	STPTE	r5,0(r4)	/* finally set V bit in PTE */
> @@ -562,8 +562,8 @@ _GLOBAL(flush_hash_patch_A)
>  	/* Search the primary PTEG for a PTE whose 1st (d)word matches r5 */
>  	li	r0,8			/* PTEs/group */
>  	mtctr	r0
> -	addi	r12,r8,-PTE_SIZE
> -1:	LDPTEu	r0,PTE_SIZE(r12)	/* get next PTE */
> +	addi	r12,r8,-HPTE_SIZE
> +1:	LDPTEu	r0,HPTE_SIZE(r12)	/* get next PTE */
>  	CMPPTE	0,r0,r11
>  	bdnzf	2,1b			/* loop while ctr != 0 && !cr0.eq */
>  	beq+	3f
> @@ -574,9 +574,9 @@ _GLOBAL(flush_hash_patch_A)
>  _GLOBAL(flush_hash_patch_B)
>  	xoris	r12,r8,Hash_msk>>16	/* compute secondary hash */
>  	xori	r12,r12,(-PTEG_SIZE & 0xffff)
> -	addi	r12,r12,-PTE_SIZE
> +	addi	r12,r12,-HPTE_SIZE
>  	mtctr	r0
> -2:	LDPTEu	r0,PTE_SIZE(r12)
> +2:	LDPTEu	r0,HPTE_SIZE(r12)
>  	CMPPTE	0,r0,r11
>  	bdnzf	2,2b
>  	xori	r11,r11,PTE_H		/* clear H again */
