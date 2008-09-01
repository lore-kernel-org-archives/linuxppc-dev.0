Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10FBADDEE9
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 15:28:32 +1000 (EST)
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support
	36-bit physical
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain
Date: Mon, 01 Sep 2008 15:19:59 +1000
Message-Id: <1220246399.13010.25.camel@pasglop>
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


> +#ifdef CONFIG_PTE_64BIT
> +#define PTE_FLAGS_OFFSET	4	/* offset of PTE flags, in bytes */
> +#define LNX_PTE_SIZE		8	/* size of a linux PTE, in bytes */
> +#else
> +#define PTE_FLAGS_OFFSET	0
> +#define LNX_PTE_SIZE		4
> +#endif

s/LNX_PTE_SIZE/PTE_BYTES or PTE_SIZE, no need for that horrible LNX
prefix. In fact, if it's only used by the asm, then ditch it and
have asm-offsets.c create something based on sizeof(pte_t).

>  #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
>  #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
> -#define pte_clear(mm,addr,ptep)	do { pte_update(ptep, ~0, 0); } while (0)
> +#define pte_clear(mm, addr, ptep) \
> +	do { pte_update(ptep, ~_PAGE_HASHPTE, 0); } while (0)

Where does this previous definition of pte_clear comes from ? It's bogus
(and it's not like that upstream). Your "updated" ones looks ok though.

But whatever tree has the "previous" one would break hash based ppc32
if merged or is there some other related changes in Kumar tree that
make the above safe ?
 
>  #define pmd_none(pmd)		(!pmd_val(pmd))
>  #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
> @@ -664,8 +670,30 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep, pte_t pte)
>  {
>  #if _PAGE_HASHPTE != 0
> +#ifndef CONFIG_PTE_64BIT
>  	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
>  #else
> +	/*
> +	 * We have to do the write of the 64b pte as 2 stores.  This
> +	 * code assumes that the entry we're storing to is currently
> +	 * not valid and that all callers have the page table lock.
> +	 * Having the entry be not valid protects readers who might read
> +	 * between the first and second stores.
> +	 */
> +	unsigned int tmp;

Do you know for sure the entry isn't valid ? On ppc64, we explicitely
test for that and if it was valid, we clear and flush it. The generic
code has been going on and off about calling set_pte_at() on an already
valid PTE, I wouldn't rely too much on it guaranteeing it will not
happen. The 32b PTE code is safe because it preserves _PAGE_HASHPTE .

Note also that once you have (which you don't now) the guarantee
that your previous PTE is invalid, then you can safely do two normal
stores instead of a lwarx/stwcx. loop. In any case, having the stw in
the middle of the loop doesn't sound very useful.

> +	__asm__ __volatile__("\
> +1:	lwarx	%0,0,%4\n\
> +	rlwimi	%L2,%0,0,30,30\n\
> +	stw	%2,0(%3)\n\
> +	eieio\n\
> +	stwcx.  %L2,0,%4\n\
> +	bne-	1b"
> +	: "=&r" (tmp), "=m" (*ptep)
> +	: "r" (pte), "r" (ptep), "r" ((unsigned long)(ptep) + 4), "m" (*ptep)
> +	: "cc");
> +#endif	/* CONFIG_PTE_64BIT */
> +#else /* _PAGE_HASHPTE == 0 */
>  #if defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
>  	__asm__ __volatile__("\
>  		stw%U0%X0 %2,%0\n\
> diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
> index b9ba7d9..d63e20a 100644
> --- a/arch/powerpc/mm/hash_low_32.S
> +++ b/arch/powerpc/mm/hash_low_32.S
> @@ -75,7 +75,7 @@ _GLOBAL(hash_page_sync)
>   * Returns to the caller if the access is illegal or there is no
>   * mapping for the address.  Otherwise it places an appropriate PTE
>   * in the hash table and returns from the exception.
> - * Uses r0, r3 - r8, ctr, lr.
> + * Uses r0, r3 - r8, r10, ctr, lr.
>   */
>  	.text
>  _GLOBAL(hash_page)
> @@ -106,9 +106,15 @@ _GLOBAL(hash_page)
>  	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
>  	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
>  112:	add	r5,r5,r7		/* convert to phys addr */
> +#ifndef CONFIG_PTE_64BIT
>  	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
>  	lwz	r8,0(r5)		/* get pmd entry */
>  	rlwinm.	r8,r8,0,0,19		/* extract address of pte page */
> +#else
> +	rlwinm	r8,r4,13,19,29		/* Compute pgdir/pmd offset */
> +	lwzx	r8,r8,r5		/* Get L1 entry */
> +	rlwinm. r8,r8,0,0,20		/* extract pt base address */
> +#endif

Any reason you wrote the above using a different technique ? If you
believe that rlwinm/lwzx is going to be more efficient than rlwimi/lwz,
maybe we should fix the old one ... or am I missing something totally
obvious ? :-)

Cheers,
Ben.
