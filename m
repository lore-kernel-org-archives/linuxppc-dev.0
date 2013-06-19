Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/kvm: Handle transparent hugepage in KVM
In-reply-to: <87k3lqxoy4.fsf@linux.vnet.ibm.com>
References: <1371624245-17247-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <9103.1371625902@ale.ozlabs.ibm.com> <87k3lqxoy4.fsf@linux.vnet.ibm.com>
Date: Thu, 20 Jun 2013 09:59:22 +1000
Message-ID: <2293.1371686362@ale.ozlabs.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> >> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> >> @@ -162,33 +162,40 @@ static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
> >>   * Lock and read a linux PTE.  If it's present and writable, atomically
> >>   * set dirty and referenced bits and return the PTE, otherwise return 0.
> >
> > This is comment still valid now the ldarx/stdcx is gone?  
> 
> In a way yes. Instead of lock and read as it was before, it is now done
> via cmpxchg which still use ldarx/stdcx

OK, maybe you can update to reflect that.

> >> +	pte_t old_pte, new_pte = __pte(0);
> >> +repeat:
> >> +	do {
> >> +		old_pte = pte_val(*ptep);
> >> +		/*
> >> +		 * wait until _PAGE_BUSY is clear then set it atomically
> >> +		 */
> >> +		if (unlikely(old_pte & _PAGE_BUSY))
> >> +			goto repeat;
> >
> > continue here?  Please don't create looping primitives.
> 
> No that would be wrong. (I did that in an earlier version :).We really
> don't want the below cmpxchg to run if we find _PAGE_BUSY.

How about something like this then?

while (1) {
      if (unlikely(old_pte & _PAGE_BUSY))
	    continue;
.....
      if cmpxchg(foo)
      	 break;
}


> 
> >   
> >> +
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +		/* If hugepage and is trans splitting return None */
> >> +		if (unlikely(hugepage &&
> >> +			     pmd_trans_splitting(pte_pmd(old_pte))))
> >
> > Comment looks much like the code... seems redundant.
> >
> >> +			return __pte(0);
> >> +#endif
> >>  
> >> -	*p = pte;	/* clears _PAGE_BUSY */
> >> +		/* If pte is not present return None */
> >> +		if (unlikely(!(old_pte & _PAGE_PRESENT)))
> >> +			return __pte(0);
> >>  
> >> -	return pte;
> >> +		new_pte = pte_mkyoung(old_pte);
> >> +		if (writing && pte_write(old_pte))
> >> +			new_pte = pte_mkdirty(new_pte);
> >> +
> >> +	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
> >> +					  old_pte, new_pte));
> >> +	return new_pte;
> >>  }
> >>  
> >> +
> >
> > Whitespace



> >> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> >> index dcf892d..39ae723 100644
> >> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> >> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> >> @@ -150,9 +150,7 @@ static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
> >>  		*pte_sizep = PAGE_SIZE;
> >>  	if (ps > *pte_sizep)
> >>  		return __pte(0);
> >> -	if (!pte_present(*ptep))
> >> -		return __pte(0);
> >> -	return kvmppc_read_update_linux_pte(ptep, writing);
> >> +	return kvmppc_read_update_linux_pte(ptep, writing, shift);
> >
> > 'shift' goes into the new 'hugepage' parameter?  Doesn't seem logical?
> > Can we harmonise the name to make it less confusing?
> >
> 
> it is actually the shift bits represending hugepage size. We set it to 0
> if we don't find hugepage in find_linux_pte_or_hugepte. May be something
> like hugepage_shift is better ?

Sure.

Mikey
