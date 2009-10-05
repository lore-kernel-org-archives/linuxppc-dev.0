Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1913EB7B8A
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 07:17:19 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1254744999-3158-4-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-4-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Oct 2009 07:17:04 +1100
Message-Id: <1254773824.7122.33.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-10-05 at 14:16 +0200, Joakim Tjernlund wrote:
> Update the TLB asm to make proper use of _PAGE_DIRY and _PAGE_ACCESSED.
> Pros:
>  - I/D TLB Miss never needs to write to the linux pte.
>  - _PAGE_ACCESSED is only set on I/D TLB Error fixing accounting
>  - _PAGE_DIRTY is mapped to 0x100, the changed bit, and is set directly
>     when a page has been made dirty.

Not sure here. You seem to still set those from asm. Is that necessary ?

The approach I take on BookE is to simply not set these from asm, -and-
(this is important) not set write permission if dirty is not set in
the TLB miss and set no access permission at all when accessed is not
set. This is important or we'll miss dirty updates which can
be fatal.

The C code in handle_pte_fault() will fixup missing access and dirty
if necessary and flush.

Also look at the 440 code, I think you could simplify your
implementation using similar techniques, such as andc of PTE against
requested bits etc... and thus maybe save a couple of insns.

Cheers,
Ben.

>  - Proper RO/RW mapping of user space.
>  - Free up 2 SW TLB bits in the linux pte(add back _PAGE_WRITETHRU ?)
> Cons:
>  - 4 more instructions in I/D TLB Miss, but the since the linux pte is
>    not written anymore, it should still be a win.
> ---
>  arch/powerpc/include/asm/pte-8xx.h |    9 +-
>  arch/powerpc/kernel/head_8xx.S     |  163 ++++++++++++++++++++++++++----------
>  2 files changed, 122 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
> index 8c6e312..af541a2 100644
> --- a/arch/powerpc/include/asm/pte-8xx.h
> +++ b/arch/powerpc/include/asm/pte-8xx.h
> @@ -32,22 +32,21 @@
>  #define _PAGE_FILE	0x0002	/* when !present: nonlinear file mapping */
>  #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
>  #define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
> +#define _PAGE_DIRTY	0x0100	/* C: page changed */
>  
>  /* These five software bits must be masked out when the entry is loaded
>   * into the TLB.
>   */
>  #define _PAGE_EXEC	0x0008	/* software: i-cache coherency required */
>  #define _PAGE_GUARDED	0x0010	/* software: guarded access */
> -#define _PAGE_DIRTY	0x0020	/* software: page changed */
> -#define _PAGE_RW	0x0040	/* software: user write access allowed */
> -#define _PAGE_ACCESSED	0x0080	/* software: page referenced */
> +#define _PAGE_USER	0x0020	/* software: User space access */
>  
>  /* Setting any bits in the nibble with the follow two controls will
>   * require a TLB exception handler change.  It is assumed unused bits
>   * are always zero.
>   */
> -#define _PAGE_HWWRITE	0x0100	/* h/w write enable: never set in Linux PTE */
> -#define _PAGE_USER	0x0800	/* One of the PP bits, the other is USER&~RW */
> +#define _PAGE_RW	0x0400	/* lsb PP bits */
> +#define _PAGE_ACCESSED	0x0800	/* msb PP bits */
>  
>  #define _PMD_PRESENT	0x0001
>  #define _PMD_BAD	0x0ff0
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 118bb05..b1f72d9 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -333,21 +333,15 @@ InstructionTLBMiss:
>  	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
>  	lwz	r10, 0(r11)	/* Get the pte */
>  
> -#ifdef CONFIG_SWAP
> -	/* do not set the _PAGE_ACCESSED bit of a non-present page */
> -	andi.	r11, r10, _PAGE_PRESENT
> -	beq	4f
> -	ori	r10, r10, _PAGE_ACCESSED
> -	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
> -	stw	r10, 0(r11)
> -4:
> -#else
> -	ori	r10, r10, _PAGE_ACCESSED
> -	stw	r10, 0(r11)
> -#endif
> -
> +	andi.	r11, r10, _PAGE_USER | _PAGE_ACCESSED
> +	cmpwi	cr0, r11, _PAGE_USER | _PAGE_ACCESSED
> +	beq+	cr0, 5f	/* branch if access allowed */
> +	rlwinm	r10, r10, 0, 22, 19 /* r10 &= ~(_PAGE_ACCESSED | _PAGE_RW) */
> +	b	6f
> +5:	xori	r10, r10, _PAGE_RW /* invert RW bit */
> +6:
>  	/* The Linux PTE won't go exactly into the MMU TLB.
> -	 * Software indicator bits 21, 22 and 28 must be clear.
> +	 * Software indicator bit 28 must be clear.
>  	 * Software indicator bits 24, 25, 26, and 27 must be
>  	 * set.  All other Linux PTE bits control the behavior
>  	 * of the MMU.
> @@ -409,21 +403,15 @@ DataStoreTLBMiss:
>  	DO_8xx_CPU6(0x3b80, r3)
>  	mtspr	SPRN_MD_TWC, r11
>  
> -#ifdef CONFIG_SWAP
> -	/* do not set the _PAGE_ACCESSED bit of a non-present page */
> -	andi.	r11, r10, _PAGE_PRESENT
> -	beq	4f
> -	ori	r10, r10, _PAGE_ACCESSED
> -4:
> -	/* and update pte in table */
> -#else
> -	ori	r10, r10, _PAGE_ACCESSED
> -#endif
> -	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
> -	stw	r10, 0(r11)
> -
> +	andi.	r11, r10, _PAGE_USER | _PAGE_ACCESSED
> +	cmpwi	cr0, r11, _PAGE_USER | _PAGE_ACCESSED
> +	beq+	cr0, 5f	/* branch if access allowed */
> +	rlwinm	r10, r10, 0, 22, 19 /* r10 &= ~(_PAGE_ACCESSED | _PAGE_RW) */
> +	b	6f
> +5:	xori	r10, r10, _PAGE_RW /* invert RW bit */
> +6:
>  	/* The Linux PTE won't go exactly into the MMU TLB.
> -	 * Software indicator bits 21, 22 and 28 must be clear.
> +	 * Software indicator bit 28 must be clear.
>  	 * Software indicator bits 24, 25, 26, and 27 must be
>  	 * set.  All other Linux PTE bits control the behavior
>  	 * of the MMU.
> @@ -448,6 +436,91 @@ DataStoreTLBMiss:
>   */
>  	. = 0x1300
>  InstructionTLBError:
> +#ifdef CONFIG_8xx_CPU6
> +	stw	r3, 8(r0)
> +#endif
> +	DO_8xx_CPU6(0x3f80, r3)
> +	mtspr	SPRN_M_TW, r10	/* Save a couple of working registers */
> +	mfcr	r10
> +	stw	r10, 0(r0)
> +	stw	r11, 4(r0)
> +
> +	mfspr	r11, SPRN_SRR1
> +	andis.	r11, r11, 0x5000	/* no translation, guarded */
> +	bne	2f
> +
> +	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
> +#ifdef CONFIG_8xx_CPU15
> +	addi	r11, r10, 0x1000
> +	tlbie	r11
> +	addi	r11, r10, -0x1000
> +	tlbie	r11
> +#endif
> +	DO_8xx_CPU6(0x3780, r3)
> +	mtspr	SPRN_MD_EPN, r10	/* Have to use MD_EPN for walk, MI_EPN can't */
> +	mfspr	r10, SPRN_M_TWB	/* Get level 1 table entry address */
> +
> +	/* If we are faulting a kernel address, we have to use the
> +	 * kernel page tables.
> +	 */
> +	andi.	r11, r10, 0x0800	/* Address >= 0x80000000 */
> +	beq	3f
> +	lis	r11, swapper_pg_dir@h
> +	ori	r11, r11, swapper_pg_dir@l
> +	rlwimi	r10, r11, 0, 2, 19
> +3:
> +	lwz	r11, 0(r10)	/* Get the level 1 entry */
> +	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address */
> +	beq	2f		/* If zero, don't try to find a pte */
> +
> +	/* We have a pte table, so load the MI_TWC with the attributes
> +	 * for this "segment."
> +	 */
> +	ori	r11,r11,1		/* Set valid bit */
> +	DO_8xx_CPU6(0x2b80, r3)
> +	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
> +	DO_8xx_CPU6(0x3b80, r3)
> +	mtspr	SPRN_MD_TWC, r11	/* Load pte table base address */
> +
> +	mfspr	r11, SPRN_SRR1
> +	andi.	r11, r11, 0x4000 /* MSR[PR] */
> +	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
> +	lwz	r10, 0(r11)	/* Get the pte */
> +	beq	5f /* Kernel access always OK */
> +	andi.	r11,r10, _PAGE_USER
> +	beq	2f
> +5:	ori	r10, r10, _PAGE_ACCESSED
> +	mfspr	r21, SPRN_MD_TWC	/* ....and get the pte address */
> +	stw	r10, 0(r11)
> +	xori	r10, r10, _PAGE_RW /* invert RW bit */
> +
> +	/* The Linux PTE won't go exactly into the MMU TLB.
> +	 * Software indicator bit 28 must be clear.
> +	 * Software indicator bits 24, 25, 26, and 27 must be
> +	 * set.  All other Linux PTE bits control the behavior
> +	 * of the MMU.
> +	 */
> +	li	r11, 0x00f0
> +	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
> +	DO_8xx_CPU6(0x2d80, r3)
> +	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
> +
> +	mfspr	r10, SPRN_M_TW	/* Restore registers */
> +	lwz	r11, 0(r0)
> +	mtcr	r11
> +	lwz	r11, 4(r0)
> +#ifdef CONFIG_8xx_CPU6
> +	lwz	r3, 8(r0)
> +#endif
> +	rfi
> +
> +2:	mfspr	r10, SPRN_M_TW	/* Restore registers */
> +	lwz	r11, 0(r0)
> +	mtcr	r11
> +	lwz	r11, 4(r0)
> +#ifdef CONFIG_8xx_CPU6
> +	lwz	r3, 8(r0)
> +#endif
>  	b	InstructionAccess
>  
>  /* This is the data TLB error on the MPC8xx.  This could be due to
> @@ -472,8 +545,8 @@ DataTLBError:
>  	/* First, make sure this was a store operation.
>  	*/
>  	mfspr	r10, SPRN_DSISR
> -	andis.	r11, r10, 0x4800 /* no translation, no permission. */
> -	bne	2f	/* branch if either is set */
> +	andis.	r11, r10, 0x4000 /* no translation */
> +	bne	2f	/* branch if set */
>  
>  	/* The EA of a data TLB miss is automatically stored in the MD_EPN
>  	 * register.  The EA of a data TLB error is automatically stored in
> @@ -522,26 +595,26 @@ DataTLBError:
>  	mfspr	r11, SPRN_MD_TWC		/* ....and get the pte address */
>  	lwz	r10, 0(r11)		/* Get the pte */
>  
> -	andi.	r11, r10, _PAGE_RW	/* Is it writeable? */
> -	beq	2f			/* Bail out if not */
> +	mfspr	r11, SPRN_SRR1
> +	andi.	r11, r11, 0x4000 /* MSR[PR] */
> +	beq	5f /* Kernel access always OK */
> +	andi.	r11,r10, _PAGE_USER
> +	beq	2f
> +5:	mfspr	r11, SPRN_DSISR
> +	andis.	r11, r11, 0x0200	/* store */
> +	beq	6f
> +	andi.	r11, r10, _PAGE_RW	/* writeable? */
> +	beq	2f /* branch if not */
> +	ori	r10, r10, _PAGE_DIRTY | _PAGE_HWWRITE
> +6:	ori	r10, r10, _PAGE_ACCESSED
>  
> -	/* Update 'changed', among others.
> -	*/
> -#ifdef CONFIG_SWAP
> -	ori	r10, r10, _PAGE_DIRTY|_PAGE_HWWRITE
> -	/* do not set the _PAGE_ACCESSED bit of a non-present page */
> -	andi.	r11, r10, _PAGE_PRESENT
> -	beq	4f
> -	ori	r10, r10, _PAGE_ACCESSED
> -4:
> -#else
> -	ori	r10, r10, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
> -#endif
>  	mfspr	r11, SPRN_MD_TWC		/* Get pte address again */
>  	stw	r10, 0(r11)		/* and update pte in table */
>  
> +	xori	r10, r10, _PAGE_RW	/* Invert RW bit */
> +
>  	/* The Linux PTE won't go exactly into the MMU TLB.
> -	 * Software indicator bits 21, 22 and 28 must be clear.
> +	 * Software indicator bit 28 must be clear.
>  	 * Software indicator bits 24, 25, 26, and 27 must be
>  	 * set.  All other Linux PTE bits control the behavior
>  	 * of the MMU.
