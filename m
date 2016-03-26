Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qX83427kYzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 16:33:20 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 26 Mar 2016 15:33:18 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C1DE02BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 16:32:59 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2Q5Wpt11376654
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 16:32:59 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2Q5WQ1F031684
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 16:32:27 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/14] powerpc/mm: Replace _PAGE_USER with _PAGE_PRIVILEGED
In-Reply-To: <1458626727.23205.9.camel@neuling.org>
References: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1457357974-20839-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1458626727.23205.9.camel@neuling.org>
Date: Sat, 26 Mar 2016 11:02:07 +0530
Message-ID: <87fuvd7qjs.fsf@linux.vnet.ibm.com>
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
>> _PAGE_PRIVILEGED means the page can be accessed only by kernel. This is done
>> to keep pte bits similar to PowerISA 3.0 radix PTE format. User
>> pages are now makred by clearing _PAGE_PRIVILEGED bit.
>> 
>> Previously we allowed kernel to have a privileged page
>> in the lower address range(USER_REGION). With this patch such access
>> is denied.
>> 
>> We also prevent a kernel access to a non-privileged page in
>> higher address range (ie, REGION_ID != 0). Both the above access
>> scenario should never happen.
>
> A few comments below.  I didn't find any issues, just some potential
> cleanups.
>
> Mikey
>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/hash.h    | 34 ++++++++++++++--------------
>>  arch/powerpc/include/asm/book3s/64/pgtable.h | 18 ++++++++++++++-
>>  arch/powerpc/mm/hash64_4k.c                  |  2 +-
>>  arch/powerpc/mm/hash64_64k.c                 |  4 ++--
>>  arch/powerpc/mm/hash_utils_64.c              | 17 ++++++++------
>>  arch/powerpc/mm/hugepage-hash64.c            |  2 +-
>>  arch/powerpc/mm/hugetlbpage-hash64.c         |  3 ++-
>>  arch/powerpc/mm/hugetlbpage.c                |  2 +-
>>  arch/powerpc/mm/pgtable.c                    | 15 ++++++++++--
>>  arch/powerpc/mm/pgtable_64.c                 | 15 +++++++++---
>>  arch/powerpc/platforms/cell/spufs/fault.c    |  2 +-
>>  drivers/misc/cxl/fault.c                     |  5 ++--
>>  12 files changed, 80 insertions(+), 39 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
>> index f092d83fa623..fbefbaa92736 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
>> @@ -20,7 +20,7 @@
>>  #define _PAGE_READ		0x00004	/* read access allowed */
>>  #define _PAGE_RW		(_PAGE_READ | _PAGE_WRITE)
>>  #define _PAGE_RWX		(_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
>> -#define _PAGE_USER		0x00008 /* page may be accessed by userspace */
>> +#define _PAGE_PRIVILEGED	0x00008 /* page can only be access by kernel */
>
> /* page can only be accessed by kernel */
>
> Or just
>
> /* kernel access only */
>

fixed

>>  #define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
>>  /* M (memory coherence) is always set in the HPTE, so we don't need it here */
>>  #define _PAGE_COHERENT		0x0
>> @@ -114,10 +114,13 @@
>>  #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
>>  #endif /* CONFIG_PPC_MM_SLICES */
>>  
>> -/* No separate kernel read-only */
>> -#define _PAGE_KERNEL_RW		(_PAGE_RW | _PAGE_DIRTY) /* user access blocked by key */
>> +/*
>> + * No separate kernel read-only, user access blocked by key
>> + */
>> +#define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_RW | _PAGE_DIRTY)
>>  #define _PAGE_KERNEL_RO		 _PAGE_KERNEL_RW
>> -#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
>> +#define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | \
>> +				 _PAGE_RW | _PAGE_EXEC)
>>  
>>  /* Strong Access Ordering */
>>  #define _PAGE_SAO		(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
>> @@ -149,7 +152,7 @@
>>   */
>>  #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
>>  			 _PAGE_WRITETHRU | _PAGE_4K_PFN | \
>> -			 _PAGE_USER | _PAGE_ACCESSED |  _PAGE_READ |\
>> +			 _PAGE_PRIVILEGED | _PAGE_ACCESSED |  _PAGE_READ |\
>>  			 _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
>>  			 _PAGE_SOFT_DIRTY)
>>  /*
>> @@ -171,16 +174,13 @@
>>   *
>>   * Note due to the way vm flags are laid out, the bits are XWR
>>   */
>> -#define PAGE_NONE	__pgprot(_PAGE_BASE)
>> -#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
>> -#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | \
>> -				 _PAGE_EXEC)
>> -#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
>> -#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
>> -				 _PAGE_EXEC)
>> -#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ)
>> -#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_READ| \
>> -				 _PAGE_EXEC)
>> +#define PAGE_NONE	__pgprot(_PAGE_BASE | _PAGE_PRIVILEGED)
>> +#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_RW)
>> +#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_RW | _PAGE_EXEC)
>> +#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_READ)
>> +#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
>> +#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_READ)
>> +#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
>
> Eyeballing these, they seemed to have been converted ok
>
>>  
>>  #define __P000	PAGE_NONE
>>  #define __P001	PAGE_READONLY
>> @@ -421,8 +421,8 @@ static inline pte_t pte_clear_soft_dirty(pte_t pte)
>>   */
>>  static inline int pte_protnone(pte_t pte)
>>  {
>> -	return (pte_val(pte) &
>> -		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
>> +	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PRIVILEGED)) ==
>> +		(_PAGE_PRESENT | _PAGE_PRIVILEGED);
>>  }
>>  #endif /* CONFIG_NUMA_BALANCING */
>>  
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index 4ac6221802ad..97d06de8dbf6 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -187,7 +187,7 @@ extern struct page *pgd_page(pgd_t pgd);
>>  
>>  static inline bool pte_user(pte_t pte)
>>  {
>> -	return (pte_val(pte) & _PAGE_USER);
>> +	return !(pte_val(pte) & _PAGE_PRIVILEGED);
>
> This function might be usable in some places you have in the patch.
>
>>  }
>>  
>>  #ifdef CONFIG_MEM_SOFT_DIRTY
>> @@ -211,6 +211,22 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
>>  }
>>  #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
>>  
>> +static inline bool check_pte_access(unsigned long access, unsigned long ptev)
>> +{
>> +	/*
>> +	 * This check for _PAGE_RWX and _PAG_PRESENT bits
>> +	 */
>> +	if (access & ~ptev)
>
> Is this really doing what the comment says?

yes, we make sure we have the right prvilege bit in access when
we call this function. Since privilege access is now checked by the
presence of _PAGE_PRIVILGED the above won't check that.

>
> Also small typo _PAG_ => _PAGE_

fixed

>
>> +		return false;
>> +	/*
>> +	 * This check for access to privilege space
>> +	 */
>> +	if ((access & _PAGE_PRIVILEGED) != (ptev & _PAGE_PRIVILEGED))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
>>  void pgtable_cache_init(void);
>>  
>> diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
>> index 7ebac279d38e..42ba12c184e1 100644
>> --- a/arch/powerpc/mm/hash64_4k.c
>> +++ b/arch/powerpc/mm/hash64_4k.c
>> @@ -38,7 +38,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>>  		if (unlikely(old_pte & _PAGE_BUSY))
>>  			return 0;
>>  		/* If PTE permissions don't match, take page fault */
>
> Is this comment still relevant?  Same below.

I would guess yes, if the pte permission which include R,W,X and
privilege access don't match that in pte, take a fault.

>
>> -		if (unlikely(access & ~old_pte))
>> +		if (unlikely(!check_pte_access(access, old_pte)))
>>  			return 1;
>>  		/*
>>  		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
>> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
>> index 83ac9f658733..f33b410d6c8a 100644
>> --- a/arch/powerpc/mm/hash64_64k.c
>> +++ b/arch/powerpc/mm/hash64_64k.c
>> @@ -70,7 +70,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>>  		if (unlikely(old_pte & _PAGE_BUSY))
>>  			return 0;
>>  		/* If PTE permissions don't match, take page fault */
>> -		if (unlikely(access & ~old_pte))
>> +		if (unlikely(!check_pte_access(access, old_pte)))
>>  			return 1;
>>  		/*
>>  		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
>> @@ -241,7 +241,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>>  		if (unlikely(old_pte & _PAGE_BUSY))
>>  			return 0;
>>  		/* If PTE permissions don't match, take page fault */
>> -		if (unlikely(access & ~old_pte))
>> +		if (unlikely(!check_pte_access(access, old_pte)))
>>  			return 1;
>>  		/*
>>  		 * Check if PTE has the cache-inhibit bit set
>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>> index ec37f4b0a8ff..630603f74056 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -174,7 +174,7 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
>>  	 * User area is mapped with PP=0x2 for read/write
>>  	 * or PP=0x3 for read-only (including writeable but clean pages).
>>  	 */
>> -	if (pteflags & _PAGE_USER) {
>> +	if (!(pteflags & _PAGE_PRIVILEGED)) {
>
> Could use pte_user() here?  Maybe other places too.


pte_user use pte_t type as argument. hence opencoded here.

>
>>  		if (pteflags & _PAGE_RWX)
>>  			rflags |= 0x2;
>>  		if (!((pteflags & _PAGE_WRITE) && (pteflags & _PAGE_DIRTY)))
>> @@ -1086,7 +1086,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>>  	/* Pre-check access permissions (will be re-checked atomically
>>  	 * in __hash_page_XX but this pre-check is a fast path
>>  	 */
>> -	if (access & ~pte_val(*ptep)) {
>> +	if (!check_pte_access(access, pte_val(*ptep))) {
>>  		DBG_LOW(" no access !\n");
>>  		rc = 1;
>>  		goto bail;
>> @@ -1224,12 +1224,15 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
>>  	if (dsisr & DSISR_ISSTORE)
>>  		access |= _PAGE_WRITE;
>>  	/*
>> -	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
>> -	 * accessing a userspace segment (even from the kernel). We assume
>> -	 * kernel addresses always have the high bit set.
>> +	 * We set _PAGE_PRIVILEGED only when
>> +	 * kernel mode access kernel space.
>> +	 *
>> +	 * _PAGE_PRIVILEGED is NOT set
>> +	 * 1) when kernel mode access user space
>> +	 * 2) user space access kernel space.
>>  	 */
>> -	if ((msr & MSR_PR) || (REGION_ID(ea) == USER_REGION_ID))
>> -		access |= _PAGE_USER;
>> +	if (!(msr & MSR_PR) && !(REGION_ID(ea) == USER_REGION_ID))
>> +		access |= _PAGE_PRIVILEGED;
>
>
> This is a bit ugly:
>  (!(msr & MSR_PR) && !(REGION_ID(ea) == USER_REGION_ID))
>
> You could set  _PAGE_PRIVILEGED and then clear it using the same if
> statement as before. Might be easier to read. ie
>
>  	access |= _PAGE_PRIVILEGED;
> 	if ((msr & MSR_PR) || (REGION_ID(ea) == USER_REGION_ID))
> 		access &= ~(_PAGE_PRIVILEGED);
>

fixed

>
>
>>  
>>  	if (trap == 0x400)
>>  		access |= _PAGE_EXEC;
>> diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
>> index 39342638a498..182f1d3fe73c 100644
>> --- a/arch/powerpc/mm/hugepage-hash64.c
>> +++ b/arch/powerpc/mm/hugepage-hash64.c
>> @@ -41,7 +41,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>>  		if (unlikely(old_pmd & _PAGE_BUSY))
>>  			return 0;
>>  		/* If PMD permissions don't match, take page fault */
>
> As above, is this comment still correct?  The comment says
> "permissions don't match" but the function call is
> "check_pte_access()".  Seems like a different concept.
>
>> -		if (unlikely(access & ~old_pmd))
>> +		if (unlikely(!check_pte_access(access, old_pmd)))
>>  			return 1;
>>  		/*
>>  		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
>> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
>> index e6e54a04bd32..96765510a49c 100644
>> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
>> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
>> @@ -51,8 +51,9 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>>  		if (unlikely(old_pte & _PAGE_BUSY))
>>  			return 0;
>>  		/* If PTE permissions don't match, take page fault */
>> -		if (unlikely(access & ~old_pte))
>> +		if (unlikely(!check_pte_access(access, old_pte)))
>
> Same comment again.... 
>
>>  			return 1;
>> +
>>  		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
>>  		 * a write access */
>>  		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index 6e52e722d3f2..7201e9c624d5 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -1003,7 +1003,7 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>>  		end = pte_end;
>>  
>>  	pte = READ_ONCE(*ptep);
>> -	mask = _PAGE_PRESENT | _PAGE_USER | _PAGE_READ;
>> +	mask = _PAGE_PRESENT | _PAGE_READ;
>>  	if (write)
>>  		mask |= _PAGE_WRITE;
>>  
>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>> index 98b5c03e344d..7b492283d502 100644
>> --- a/arch/powerpc/mm/pgtable.c
>> +++ b/arch/powerpc/mm/pgtable.c
>> @@ -43,9 +43,20 @@ static inline int is_exec_fault(void)
>>   */
>>  static inline int pte_looks_normal(pte_t pte)
>>  {
>> +
>> +#if defined(CONFIG_PPC_BOOK3S_64)
>> +	if ((pte_val(pte) &
>> +	     (_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE)) ==
>> +	    _PAGE_PRESENT) {
>> +		if (!(pte_val(pte) & _PAGE_PRIVILEGED))
>> +			return 1;
>> +	}
>> +	return 0;
>> +#else
>>  	return (pte_val(pte) &
>> -	    (_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER)) ==
>> -	    (_PAGE_PRESENT | _PAGE_USER);
>> +		(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER)) ==
>> +		(_PAGE_PRESENT | _PAGE_USER);
>> +#endif
>>  }
>>  
>>  static struct page *maybe_pte_to_page(pte_t pte)
>> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
>> index 00d8d985bba3..441905f7bba4 100644
>> --- a/arch/powerpc/mm/pgtable_64.c
>> +++ b/arch/powerpc/mm/pgtable_64.c
>> @@ -280,8 +280,17 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
>>  	if (flags & _PAGE_WRITE)
>>  		flags |= _PAGE_DIRTY;
>>  
>> -	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
>> -	flags &= ~(_PAGE_USER | _PAGE_EXEC);
>> +	/* we don't want to let _PAGE_EXEC leak out */
>> +	flags &= ~_PAGE_EXEC;
>> +	/*
>> +	 * Force kernel mapping.
>> +	 */
>> +#if defined(CONFIG_PPC_BOOK3S_64)
>> +	flags |= _PAGE_PRIVILEGED;
>> +#else
>> +	flags &= ~_PAGE_USER;
>> +#endif
>> +
>>  
>>  #ifdef _PAGE_BAP_SR
>>  	/* _PAGE_USER contains _PAGE_BAP_SR on BookE using the new PTE format
>> @@ -669,7 +678,7 @@ void pmdp_huge_split_prepare(struct vm_area_struct *vma,
>>  	 * the translation is still valid, because we will withdraw
>>  	 * pgtable_t after this.
>>  	 */
>> -	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_USER, 0);
>> +	pmd_hugepage_update(vma->vm_mm, address, pmdp, 0, _PAGE_PRIVILEGED);
>>  }
>>  
>>  
>> diff --git a/arch/powerpc/platforms/cell/spufs/fault.c b/arch/powerpc/platforms/cell/spufs/fault.c
>> index c3a3bf1745b7..e29e4d5afa2d 100644
>> --- a/arch/powerpc/platforms/cell/spufs/fault.c
>> +++ b/arch/powerpc/platforms/cell/spufs/fault.c
>
> You need to CC the spufs maintainer for this one.
>
>
>> @@ -141,7 +141,7 @@ int spufs_handle_class1(struct spu_context *ctx)
>>  	/* we must not hold the lock when entering copro_handle_mm_fault */
>>  	spu_release(ctx);
>>  
>> -	access = (_PAGE_PRESENT | _PAGE_READ | _PAGE_USER);
>> +	access = (_PAGE_PRESENT | _PAGE_READ);
>>  	access |= (dsisr & MFC_DSISR_ACCESS_PUT) ? _PAGE_WRITE : 0UL;
>>  	local_irq_save(flags);
>>  	ret = hash_page(ea, access, 0x300, dsisr);
>> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
>> index a3d5e1e16c21..23e37cd41e64 100644
>> --- a/drivers/misc/cxl/fault.c
>> +++ b/drivers/misc/cxl/fault.c
>
> You need to CC both cxl driver maintainers for this one.
>
>> @@ -152,8 +152,9 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
>>  	access = _PAGE_PRESENT | _PAGE_READ;
>>  	if (dsisr & CXL_PSL_DSISR_An_S)
>>  		access |= _PAGE_WRITE;
>> -	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
>> -		access |= _PAGE_USER;
>> +
>> +	if (ctx->kernel && (dar & (1ULL << 63)))
>> +		access |= _PAGE_PRIVILEGED;
>>  
>>  	if (dsisr & DSISR_NOHPTE)
>>  		inv_flags |= HPTE_NOHPTE_UPDATE;
