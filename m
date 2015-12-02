Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A333B1A0915
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 00:45:50 +1100 (AEDT)
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 2 Dec 2015 13:45:47 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 422B31B0806E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 13:46:11 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB2Djiaw37814486
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 13:45:45 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB2DjhM9012709
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 06:45:44 -0700
Subject: Re: [PATCH v4] powerpc/mm: Add page soft dirty tracking
To: Denis Kirjanov <kda@linux-powerpc.org>
References: <1449054265-5985-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <CAOJe8K1QzBrNr=3SBy2HqQOSGdwcFByLensYVr8-QcbA0+xA=w@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, xemul@parallels.com
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Message-ID: <565EF605.8080800@linux.vnet.ibm.com>
Date: Wed, 2 Dec 2015 14:45:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAOJe8K1QzBrNr=3SBy2HqQOSGdwcFByLensYVr8-QcbA0+xA=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/12/2015 12:54, Denis Kirjanov wrote:
> On 12/2/15, Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
>> User space checkpoint and restart tool (CRIU) needs the page's change
>> to be soft tracked. This allows to do a pre checkpoint and then dump
>> only touched pages.
>>
>> This is done by using a newly assigned PTE bit (_PAGE_SOFT_DIRTY) when
>> the page is backed in memory, and a new _PAGE_SWP_SOFT_DIRTY bit when
>> the page is swapped out.
>>
>> To introduce a new PTE _PAGE_SOFT_DIRTY bit value common to hash 4k
>> and hash 64k pte, the bits already defined in hash-*4k.h should be
>> shifted left by one.
>>
>> The _PAGE_SWP_SOFT_DIRTY bit is dynamically put after the swap type in
>> the swap pte. A check is added to ensure that the bit is not
>> overwritten by _PAGE_HPTEFLAGS.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>
>> This patch should to be applied on top of the Aneesh's series titled
>> "[PATCH V6 00/35]  powerpc/mm: Update page table format for book3s 64"
>>
>> v4:
>> - updated to match Aneesh's v6 series.
>> V3:
>> - updated to match Aneesh's changes in the pte handling
>> - updated to match commit a7b761749317 ("mm: add architecture
>>   primitives for software dirty bit clearing")
>> V2:
>> - Fix allnoconfig build
>>
>>  arch/powerpc/Kconfig                          |  2 ++
>>  arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 +-
>>  arch/powerpc/include/asm/book3s/64/hash-64k.h |  4 ++--
>>  arch/powerpc/include/asm/book3s/64/hash.h     | 30
>> ++++++++++++++++++++++-----
>>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 26 +++++++++++++++++++++++
>>  5 files changed, 56 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index db49e0d796b1..6e03f85b11cd 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -559,6 +559,7 @@ choice
>>
>>  config PPC_4K_PAGES
>>  	bool "4k page size"
>> +	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
>>
>>  config PPC_16K_PAGES
>>  	bool "16k page size"
>> @@ -567,6 +568,7 @@ config PPC_16K_PAGES
>>  config PPC_64K_PAGES
>>  	bool "64k page size"
>>  	depends on !PPC_FSL_BOOK3E && (44x || PPC_STD_MMU_64 || PPC_BOOK3E_64)
>> +	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
>>
>>  config PPC_256K_PAGES
>>  	bool "256k page size"
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> index e59832c94609..ea0414d6659e 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> @@ -52,7 +52,7 @@
>>  			 _PAGE_F_SECOND | _PAGE_F_GIX)
>>
>>  /* shift to put page number into pte */
>> -#define PTE_RPN_SHIFT	(17)
>> +#define PTE_RPN_SHIFT	(18)
>>
>>  #define _PAGE_4K_PFN		0
>>  #ifndef __ASSEMBLY__
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> index 9f9942998587..9e55e3b1fef0 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> @@ -25,8 +25,8 @@
>>  #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
>>  #define PGDIR_MASK	(~(PGDIR_SIZE-1))
>>
>> -#define _PAGE_COMBO	0x00020000 /* this is a combo 4k page */
>> -#define _PAGE_4K_PFN	0x00040000 /* PFN is for a single 4k page */
>> +#define _PAGE_COMBO	0x00040000 /* this is a combo 4k page */
>> +#define _PAGE_4K_PFN	0x00080000 /* PFN is for a single 4k page */
>>  /*
>>   * Used to track subpage group valid if _PAGE_COMBO is set
>>   * This overloads _PAGE_F_GIX and _PAGE_F_SECOND
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h
>> b/arch/powerpc/include/asm/book3s/64/hash.h
>> index 8b929e531758..92a615b15fbf 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
>> @@ -33,6 +33,7 @@
>>  #define _PAGE_F_GIX_SHIFT	12
>>  #define _PAGE_F_SECOND		0x08000 /* Whether to use secondary hash or not */
>>  #define _PAGE_SPECIAL		0x10000 /* software: special page */
>> +#define _PAGE_SOFT_DIRTY	0x20000 /* software: software dirty tracking */
>>
>>  /*
>>   * THP pages can't be special. So use the _PAGE_SPECIAL
>> @@ -50,7 +51,7 @@
>>   */
>>  #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
>>  			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
>> -			 _PAGE_THP_HUGE | _PAGE_PTE)
>> +			 _PAGE_THP_HUGE | _PAGE_PTE | _PAGE_SOFT_DIRTY)
>>
>>  #ifdef CONFIG_PPC_64K_PAGES
>>  #include <asm/book3s/64/hash-64k.h>
>> @@ -136,14 +137,16 @@
>>   * pgprot changes
>>   */
>>  #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
>> -			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE)
>> +			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE | \
>> +			 _PAGE_SOFT_DIRTY)
>>  /*
>>   * Mask of bits returned by pte_pgprot()
>>   */
>>  #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
>>  			 _PAGE_WRITETHRU | _PAGE_4K_PFN | \
>>  			 _PAGE_USER | _PAGE_ACCESSED |  \
>> -			 _PAGE_RW |  _PAGE_DIRTY | _PAGE_EXEC)
>> +			 _PAGE_RW |  _PAGE_DIRTY | _PAGE_EXEC | \
>> +			 _PAGE_SOFT_DIRTY)
>>  /*
>>   * We define 2 sets of base prot bits, one for basic pages (ie,
>>   * cacheable kernel and user pages) and one for non cacheable
>> @@ -339,7 +342,8 @@ static inline void pte_clear(struct mm_struct *mm,
>> unsigned long addr,
>>  static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
>>  {
>>  	unsigned long bits = pte_val(entry) &
>> -		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
>> +		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC |
>> +		 _PAGE_SOFT_DIRTY);
>>
>>  	unsigned long old, tmp;
>>
>> @@ -366,6 +370,22 @@ static inline int pte_special(pte_t pte)	{ return
>> !!(pte_val(pte) & _PAGE_SPECIA
>>  static inline int pte_none(pte_t pte)		{ return (pte_val(pte) &
>> ~_PTE_NONE_MASK) == 0; }
>>  static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte)
>> & PAGE_PROT_BITS); }
>>
>> +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>> +static inline int pte_soft_dirty(pte_t pte)
>> +{
>> +	return !!(pte_val(pte) & _PAGE_SOFT_DIRTY);
>> +}
> It has to be bool, right?

You're right.
I did that the same way it is done in the other architectures (x86 and
s390), but using a boolean is better.

>> +static inline pte_t pte_mksoft_dirty(pte_t pte)
>> +{
>> +	return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
>> +}
>> +
>> +static inline pte_t pte_clear_soft_dirty(pte_t pte)
>> +{
>> +	return __pte(pte_val(pte) & ~_PAGE_SOFT_DIRTY);
>> +}
>> +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
>> +
>>  #ifdef CONFIG_NUMA_BALANCING
>>  /*
>>   * These work without NUMA balancing but the kernel does not care. See the
>> @@ -424,7 +444,7 @@ static inline pte_t pte_mkwrite(pte_t pte)
>>
>>  static inline pte_t pte_mkdirty(pte_t pte)
>>  {
>> -	return __pte(pte_val(pte) | _PAGE_DIRTY);
>> +	return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>>  }
>>
>>  static inline pte_t pte_mkyoung(pte_t pte)
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index a2d4e0e37067..37fcc2072afb 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -146,6 +146,7 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long
>> val)
>>  	 * We filter HPTEFLAGS on set_pte.			\
>>  	 */							\
>>  	BUILD_BUG_ON(_PAGE_HPTEFLAGS & (0x1f << _PAGE_BIT_SWAP_TYPE)); \
>> +	BUILD_BUG_ON(_PAGE_HPTEFLAGS & _PAGE_SWP_SOFT_DIRTY);	\
>>  	} while (0)
>>  /*
>>   * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
>> @@ -161,6 +162,24 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long
>> val)
>>  #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
>>  #define __swp_entry_to_pte(x)		__pte((x).val)
>>
>> +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>> +#define _PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS +
>> _PAGE_BIT_SWAP_TYPE))
>> +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
>> +{
>> +	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
>> +}
>> +static inline int pte_swp_soft_dirty(pte_t pte)
>> +{
>> +	return pte_val(pte) & _PAGE_SWP_SOFT_DIRTY;
>> +}
> ditto
>> +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
>> +{
>> +	return __pte(pte_val(pte) & ~_PAGE_SWP_SOFT_DIRTY);
>> +}
>> +#else
>> +#define _PAGE_SWP_SOFT_DIRTY	0
>> +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
>> +
>>  void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
>>  void pgtable_cache_init(void);
>>
>> @@ -201,6 +220,13 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
>>  #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
>>  #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
>>  #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
>> +
>> +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>> +#define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
>> +#define pmd_mksoft_dirty(pmd)  pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
>> +#define pmd_clear_soft_dirty(pmd)
>> pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)))
>> +#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
>> +
>>  #ifdef CONFIG_NUMA_BALANCING
>>  static inline int pmd_protnone(pmd_t pmd)
>>  {
>> --
>> 1.9.1
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
