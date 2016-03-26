Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qX8vx613LzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 17:12:13 +1100 (AEDT)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 26 Mar 2016 11:42:10 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2Q6C7Si66781212
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 11:42:07 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2QBehkW025603
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 17:10:44 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 09/14] powerpc/mm: Drop WIMG in favour of new constants
In-Reply-To: <1458622797.23205.3.camel@neuling.org>
References: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1457357974-20839-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1458622797.23205.3.camel@neuling.org>
Date: Sat, 26 Mar 2016 11:42:05 +0530
Message-ID: <87d1qh7op6.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> [ text/plain ]
> On Mon, 2016-03-07 at 19:09 +0530, Aneesh Kumar K.V wrote:
>
>> PowerISA 3.0 introduce three pte bits with the below meaning
>> 000 ->  Normal Memory
>> 001 ->  Strong Access Order
>> 010 -> Non idempotent I/O ( Also cache inhibited and guarded)
>> 100 -> Tolerant I/O (Cache inhibited)
>
> Which PTE are you talking about here?  Radix, new Hash (ISA 3.0) or
> old Hash (ISA 2.07)?

Radix. Paul also pointed out that with latest ISA spec, this is now a
two bit value. I have also updated the patchset accordingly.

>
> A couple more comments below
>
>> We drop the existing WIMG bits in linux page table in favour of above
>> contants. We loose _PAGE_WRITETHRU with this conversion. We only use
>> writethru via pgprot_cached_wthru() which is used by fbdev/controlfb.c
>> which is Apple control display and also PPC32.
>> 
>> With respect to _PAGE_COHERENCE, we have been marking hpte
>> always coherent for some time now. htab_convert_pte_flags always added
>> HPTE_R_M.
>> 
>> NOTE: KVM changes need closer review.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/hash.h | 47 +++++++++----------------------
>>  arch/powerpc/include/asm/kvm_book3s_64.h  | 29 ++++++++++---------
>>  arch/powerpc/kvm/book3s_64_mmu_hv.c       | 11 ++++----
>>  arch/powerpc/kvm/book3s_hv_rm_mmu.c       | 12 ++++----
>>  arch/powerpc/mm/hash64_64k.c              |  2 +-
>>  arch/powerpc/mm/hash_utils_64.c           | 14 ++++-----
>>  arch/powerpc/mm/pgtable.c                 |  2 +-
>>  arch/powerpc/mm/pgtable_64.c              |  4 ---
>>  arch/powerpc/platforms/pseries/lpar.c     |  4 ---
>>  9 files changed, 48 insertions(+), 77 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
>> index c2b567456796..edd3d47ef9a4 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
>> @@ -21,11 +21,9 @@
>>  #define _PAGE_RW		(_PAGE_READ | _PAGE_WRITE)
>>  #define _PAGE_RWX		(_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
>>  #define _PAGE_PRIVILEGED	0x00008 /* page can only be access by kernel */
>> -#define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
>> -/* M (memory coherence) is always set in the HPTE, so we don't need it here */
>> -#define _PAGE_COHERENT		0x0
>> -#define _PAGE_NO_CACHE		0x00020 /* I: cache inhibit */
>> -#define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
>> +#define _PAGE_SAO		0x00010 /* Strong access order */
>> +#define _PAGE_NON_IDEMPOTENT	0x00020 /* non idempotent memory */
>> +#define _PAGE_TOLERANT		0x00040 /* tolerant memory, cache inhibited */
>>  #define _PAGE_DIRTY		0x00080 /* C: page changed */
>>  #define _PAGE_ACCESSED		0x00100 /* R: page referenced */
>>  #define _PAGE_SPECIAL		0x00400 /* software: special page */
>> @@ -122,9 +120,6 @@
>>  #define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | \
>>  				 _PAGE_RW | _PAGE_EXEC)
>>  
>> -/* Strong Access Ordering */
>> -#define _PAGE_SAO		(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
>> -
>>  /* No page size encoding in the linux PTE */
>>  #define _PAGE_PSIZE		0
>>  
>> @@ -150,10 +145,9 @@
>>  /*
>>   * Mask of bits returned by pte_pgprot()
>>   */
>> -#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
>> -			 _PAGE_WRITETHRU | _PAGE_4K_PFN | \
>> -			 _PAGE_PRIVILEGED | _PAGE_ACCESSED |  _PAGE_READ |\
>> -			 _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
>> +#define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
>> +			 _PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
>> +			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
>>  			 _PAGE_SOFT_DIRTY)
>>  /*is this
>>   * We define 2 sets of base prot bits, one for basic pages (ie,
>> @@ -162,7 +156,7 @@
>>   * the processor might need it for DMA coherency.
>>   */
>>  #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
>> -#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
>> +#define _PAGE_BASE	(_PAGE_BASE_NC)
>>  
>>  /* Permission masks used to generate the __P and __S table,
>>   *
>> @@ -203,9 +197,9 @@
>>  /* Permission masks used for kernel mappings */
>>  #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
>>  #define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
>> -				 _PAGE_NO_CACHE)
>> +				 _PAGE_TOLERANT)
>>  #define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
>> -				 _PAGE_NO_CACHE | _PAGE_GUARDED)
>> +				 _PAGE_NON_IDEMPOTENT)
>>  #define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX)
>>  #define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
>>  #define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
>> @@ -516,41 +510,26 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>>   * Macro to mark a page protection value as "uncacheable".
>>   */
>>  
>> -#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_GUARDED | _PAGE_NO_CACHE | \
>> -			 _PAGE_WRITETHRU)
>> +#define _PAGE_CACHE_CTL	(_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
>
> The comment here says 'Macro to mark a page protection value as
> "uncacheable"' but why do we put _PAGE_SAO in that?

yes, that comment is confusing and I removed that. Now we don't
support a noncached SAO pte. Hence the idea of clearing all
bits concerning pte attributes and enable only the requested caching
attribute. Also if we don't clear SAO and set non-idempotent, it bcomes
a tolerant mapping. Below is the bit mapping now

#define _PAGE_SAO		0x00010 /* Strong access order */
#define _PAGE_NON_IDEMPOTENT	0x00020 /* non idempotent memory */
#define _PAGE_TOLERANT		0x00030 /* tolerant memory, cache inhibited */

>
>>  
>>  #define pgprot_noncached pgprot_noncached
>>  static inline pgprot_t pgprot_noncached(pgprot_t prot)
>>  {
>>  	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
>> -			_PAGE_NO_CACHE | _PAGE_GUARDED);
>> +			_PAGE_NON_IDEMPOTENT);
>>  }
>>  
>>  #define pgprot_noncached_wc pgprot_noncached_wc
>>  static inline pgprot_t pgprot_noncached_wc(pgprot_t prot)
>>  {
>>  	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
>> -			_PAGE_NO_CACHE);
>> +			_PAGE_TOLERANT);
>>  }
>>  
>>  #define pgprot_cached pgprot_cached
>>  static inline pgprot_t pgprot_cached(pgprot_t prot)
>>  {
>> -	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
>> -			_PAGE_COHERENT);
>> -}
>> -
>> -#define pgprot_cached_wthru pgprot_cached_wthru
>> -static inline pgprot_t pgprot_cached_wthru(pgprot_t prot)
>> -{
>> -	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
>> -			_PAGE_COHERENT | _PAGE_WRITETHRU);
>> -}
>> -
>> -#define pgprot_cached_noncoherent pgprot_cached_noncoherent
>> -static inline pgprot_t pgprot_cached_noncoherent(pgprot_t prot)
>> -{
>> -	return __pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL);
>> +	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL));
>>  }
>>  
>>  #define pgprot_writecombine pgprot_writecombine
>> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
>> index f9a7a89a3e4f..f23b1698ad3c 100644
>> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
>> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
>> @@ -278,19 +278,24 @@ static inline unsigned long hpte_make_readonly(unsigned long ptel)
>>  	return ptel;
>>  }
>>  
>> -static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
>> +static inline bool hpte_cache_flags_ok(unsigned long hptel, bool is_ci)
>>  {
>> -	unsigned int wimg = ptel & HPTE_R_WIMG;
>> +	unsigned int wimg = hptel & HPTE_R_WIMG;
>>  
>>  	/* Handle SAO */
>>  	if (wimg == (HPTE_R_W | HPTE_R_I | HPTE_R_M) &&
>>  	    cpu_has_feature(CPU_FTR_ARCH_206))
>>  		wimg = HPTE_R_M;
>>  
>> -	if (!io_type)
>> +	if (!is_ci)
>>  		return wimg == HPTE_R_M;
>> -
>> -	return (wimg & (HPTE_R_W | HPTE_R_I)) == io_type;
>> +	/*
>> +	 * if host is mapped cache inhibited, make sure hptel also have
>> +	 * cache inhibited.
>> +	 */
>> +	if (wimg & HPTE_R_W) /* FIXME!! is this ok for all guest. ? */
>> +		return false;
>> +	return !!(wimg & HPTE_R_I);
>>  }
>>  
>>  /*
>> @@ -333,16 +338,12 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing)
>>  	return new_pte;
>>  }
>>  
>> -
>> -/* Return HPTE cache control bits corresponding to Linux pte bits */
>> -static inline unsigned long hpte_cache_bits(unsigned long pte_val)
>> +/*
>> + * check whether the mapping is cache inhibited
>> + */
>> +static inline bool hpte_is_cache_inhibited(unsigned long pte_val)
>>  {
>> -#if _PAGE_NO_CACHE == HPTE_R_I && _PAGE_WRITETHRU == HPTE_R_W
>> -	return pte_val & (HPTE_R_W | HPTE_R_I);
>> -#else
>> -	return ((pte_val & _PAGE_NO_CACHE) ? HPTE_R_I : 0) +
>> -		((pte_val & _PAGE_WRITETHRU) ? HPTE_R_W : 0);
>> -#endif
>> +	return !!(pte_val & (_PAGE_TOLERANT | _PAGE_NON_IDEMPOTENT));
>
> Can we use _PAGE_CACHE_CTL here?
>
>>  }

This is different now

/*
 * check a pte mapping have cache inhibited property
 */
static inline bool pte_ci(pte_t pte)
{
	unsigned long pte_v = pte_val(pte);

	if (((pte_v & _PAGE_CACHE_CTL) == _PAGE_TOLERANT) ||
	    ((pte_v & _PAGE_CACHE_CTL) == _PAGE_NON_IDEMPOTENT))
		return true;
	return false;
}


>>  
>>  static inline bool hpte_read_permission(unsigned long pp, unsigned long key)
>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> index c7b78d8336b2..40ad06c41ca1 100644
>> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> @@ -447,7 +447,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,

...

-aneesh
