Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 135BFDE1D9
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 17:14:43 +1100 (EST)
Message-Id: <CCC6C674-09CB-4FC7-9F3E-87E8D5D0E114@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090130022651.08955DE108@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [RFC/PATCH] powerpc: Rework I$/D$ coherency
Date: Fri, 30 Jan 2009 00:14:32 -0600
References: <20090130022651.08955DE108@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 29, 2009, at 8:26 PM, Benjamin Herrenschmidt wrote:

> Index: linux-work/arch/powerpc/include/asm/pgtable-ppc64.h
> ===================================================================
> --- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	 
> 2009-01-28 16:00:26.000000000 +1100
> +++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-01-29  
> 10:50:58.000000000 +1100
> @@ -125,6 +125,8 @@
> #define _PTEIDX_SECONDARY	0x8
> #define _PTEIDX_GROUP_IX	0x7
>
> +/* To make some generic powerpc code happy */
> +#define _PAGE_HWEXEC		0
>
> /*
>  * POWER4 and newer have per page execute protection, older chips  
> can only
> @@ -285,6 +287,10 @@ static inline unsigned long pte_update(s
> 	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY)
> 	: "cc" );
>
> +	/* huge pages use the old page table lock */
> +	if (!huge)
> +		assert_pte_locked(mm, addr);
> +
> 	if (old & _PAGE_HASHPTE)
> 		hpte_need_flush(mm, addr, ptep, old, huge);
> 	return old;
> @@ -359,23 +365,12 @@ static inline void pte_clear(struct mm_s
> 	pte_update(mm, addr, ptep, ~0UL, 0);
> }
>
> -/*
> - * set_pte stores a linux PTE into the linux page table.
> - */
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long  
> addr,
> -			      pte_t *ptep, pte_t pte)
> -{
> -	if (pte_present(*ptep))
> -		pte_clear(mm, addr, ptep);
> -	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
> -	*ptep = pte;
> -}
>
> /* Set the dirty and/or accessed bits atomically in a linux PTE, this
>  * function doesn't need to flush the hash entry
>  */
> #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS

should the #define go since its in pgtable.h now?

>
> -static inline void __ptep_set_access_flags(pte_t *ptep, pte_t  
> entry, int dirty)
> +static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
> {
> 	unsigned long bits = pte_val(entry) &
> 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
> @@ -392,15 +387,6 @@ static inline void __ptep_set_access_fla
> 	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
> 	:"cc");
> }
> -#define  ptep_set_access_flags(__vma, __address, __ptep, __entry,  
> __dirty) \
> -({									   \
> -	int __changed = !pte_same(*(__ptep), __entry);			   \
> -	if (__changed) {						   \
> -		__ptep_set_access_flags(__ptep, __entry, __dirty);    	   \
> -		flush_tlb_page_nohash(__vma, __address);		   \
> -	}								   \
> -	__changed;							   \
> -})
