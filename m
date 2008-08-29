Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CECAADDFD5
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 01:50:31 +1000 (EST)
Message-Id: <AC9E6E10-58AB-4E06-87D8-E5477ADBF154@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1220018213-12959-2-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2 2/4] powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
Date: Fri, 29 Aug 2008 10:50:21 -0500
References: <1220018213-12959-1-git-send-email-galak@kernel.crashing.org>
	<1220018213-12959-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 29, 2008, at 8:56 AM, Kumar Gala wrote:

> There are some minor issues with support 64-bit PTEs on a 32-bit  
> processor
> when dealing with SMP.
>
> * We need to order the stores in set_pte_at to make sure the flag word
>  is set second.
> * Change pte_clear to use pte_update so only the flag word is cleared
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

>
> ---
> arch/powerpc/include/asm/pgtable-ppc32.h |   14 ++++++++++----
> 1 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/ 
> include/asm/pgtable-ppc32.h
> index 6fe39e3..db2e7bd 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc32.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc32.h
> @@ -517,7 +517,7 @@ extern unsigned long  
> bad_call_to_PMD_PAGE_SIZE(void);
>
> #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
> #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
> -#define pte_clear(mm,addr,ptep)	do { set_pte_at((mm), (addr),  
> (ptep), __pte(0)); } while (0)
> +#define pte_clear(mm,addr,ptep)	do { pte_update(ptep, ~0, 0); }  
> while (0)
>
> #define pmd_none(pmd)		(!pmd_val(pmd))
> #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
> @@ -612,9 +612,6 @@ static inline unsigned long pte_update(pte_t *p,
> 	return old;
> }
> #else /* CONFIG_PTE_64BIT */
> -/* TODO: Change that to only modify the low word and move  
> set_pte_at()
> - * out of line
> - */
> static inline unsigned long long pte_update(pte_t *p,
> 					    unsigned long clr,
> 					    unsigned long set)
> @@ -658,8 +655,17 @@ static inline void set_pte_at(struct mm_struct  
> *mm, unsigned long addr,
> #if _PAGE_HASHPTE != 0
> 	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
> #else
> +#if defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
> +	__asm__ __volatile__("\
> +		stw%U0%X0 %2,%0\n\
> +		eieio\n\
> +		stw%U0%X0 %L2,%1"
> +	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
> +	: "r" (pte) : "memory");

I know it's a nit, but can you put the clobber on a new line?  I  
totally missed it the first time I read this, and got all worked up  
about it :)

Cheers,
B
