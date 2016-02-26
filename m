Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF6211A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 13:08:04 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 19:08:02 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id F1E0D1FF0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 18:56:05 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1Q27ulL28049412
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 19:07:56 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1Q27tLr024781
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 19:07:56 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 06/18] powerpc/mm: Switch book3s 64 with 64K page size
 to 4 level page table
In-Reply-To: <20160225033932.GE18753@oak.ozlabs.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160225033932.GE18753@oak.ozlabs.ibm.com>
Date: Fri, 26 Feb 2016 07:37:51 +0530
Message-ID: <87bn74jkaw.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Tue, Feb 23, 2016 at 10:18:08AM +0530, Aneesh Kumar K.V wrote:
>> This is needed so that we can support both hash and radix page table
>> using single kernel. Radix kernel uses a 4 level table.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/Kconfig                          |  1 +
>>  arch/powerpc/include/asm/book3s/64/hash-4k.h  | 33 +--------------------------
>>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 20 +++++++++-------
>>  arch/powerpc/include/asm/book3s/64/hash.h     | 11 +++++++++
>>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 25 +++++++++++++++++++-
>>  arch/powerpc/include/asm/pgalloc-64.h         | 28 ++++++++++++++++++++---
>>  arch/powerpc/include/asm/pgtable-types.h      | 13 +++++++----
>>  arch/powerpc/mm/init_64.c                     | 21 ++++++++++++-----
>>  8 files changed, 97 insertions(+), 55 deletions(-)
>> 
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 9faa18c4f3f7..599329332613 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -303,6 +303,7 @@ config ZONE_DMA32
>>  config PGTABLE_LEVELS
>>  	int
>>  	default 2 if !PPC64
>> +	default 4 if PPC_BOOK3S_64
>>  	default 3 if PPC_64K_PAGES
>>  	default 4
>
> Why not just "default 4"?  Why do we still need the if PPC_BOOK3S_64
> line at all?

You are suggesting remove that PPC_64K_PAGES line right ? I was not sure
about other platforms that use 64K pages.


>
> [...]
>
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
>> index ef9bd68f7e6d..d0ee6fcef823 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
>> @@ -235,6 +235,7 @@
>>  #define __pgtable_ptr_val(ptr)	__pa(ptr)
>>  
>>  #define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
>> +#define pud_index(address) (((address) >> (PUD_SHIFT)) & (PTRS_PER_PUD - 1))
>>  #define pmd_index(address) (((address) >> (PMD_SHIFT)) & (PTRS_PER_PMD - 1))
>>  #define pte_index(address) (((address) >> (PAGE_SHIFT)) & (PTRS_PER_PTE - 1))
>>  
>> @@ -363,8 +364,18 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
>>  	:"cc");
>>  }
>>  
>> +static inline int pgd_bad(pgd_t pgd)
>> +{
>> +	return (pgd_val(pgd) == 0);
>> +}
>> +
>>  #define __HAVE_ARCH_PTE_SAME
>>  #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
>> +static inline unsigned long pgd_page_vaddr(pgd_t pgd)
>> +{
>> +	return (unsigned long)__va(pgd_val(pgd) & ~PGD_MASKED_BITS);
>> +}
>> +
>>  
>>  /* Generic accessors to PTE bits */
>>  static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index 7482f69117b6..77d3ce05798e 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -106,6 +106,26 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
>>  	*pgdp = __pgd(val);
>>  }
>>  
>> +static inline void pgd_clear(pgd_t *pgdp)
>> +{
>> +	*pgdp = __pgd(0);
>> +}
>> +
>> +#define pgd_none(pgd)		(!pgd_val(pgd))
>> +#define pgd_present(pgd)	(!pgd_none(pgd))
>> +
>> +static inline pte_t pgd_pte(pgd_t pgd)
>> +{
>> +	return __pte(pgd_val(pgd));
>> +}
>> +
>> +static inline pgd_t pte_pgd(pte_t pte)
>> +{
>> +	return __pgd(pte_val(pte));
>> +}
>> +
>> +extern struct page *pgd_page(pgd_t pgd);
>
> Why did you put pgd_bad() and pgd_page_vaddr() in hash.h, but
> pgd_clear(), pgd_none, pgd_present etc. in pgtable.h?  Why split them
> between two headers rather than putting them all in the same header?
>

Any page table operation that involved PTE bit position I am moving to
hash.h with the expectation that we will have to put a conditional call
in there. Functions like pgd_none and pgd_clear don't use bit
positions.

-aneesh
