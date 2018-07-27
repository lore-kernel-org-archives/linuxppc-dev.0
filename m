Return-Path: <srs0=i7yr=kl=linux.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cKYT2mCbzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 16:58:21 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41cKYT23kQz8sww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 16:58:21 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41cKYS5TpNz9ryl
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2018 16:58:20 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6R6snPH039258
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2018 02:58:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kfx0chd1r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2018 02:58:18 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 27 Jul 2018 07:58:16 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc/64s: fix page table fragment refcount race vs
 speculative references
In-Reply-To: <87tvonv621.fsf@linux.ibm.com>
References: <20180725095342.22445-1-npiggin@gmail.com>
 <87tvonv621.fsf@linux.ibm.com>
Date: Fri, 27 Jul 2018 12:28:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9etnp18.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Adding the list back.

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> writes:

> Nicholas Piggin <npiggin@gmail.com> writes:
>
>> The page table fragment allocator uses the main page refcount racily
>> with respect to speculative references. A customer observed a BUG due
>> to page table page refcount underflow in the fragment allocator. This
>> can be caused by the fragment allocator set_page_count stomping on a
>> speculative reference, and then the speculative failure handler
>> decrements the new reference, and the underflow eventually pops when
>> the page tables are freed.
>>
>> Fix this by using a dedicated field in the struct page for the page
>> table fragment allocator.
>>
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
>> Fixes: 5c1f6ee9a31c ("powerpc: Reduce PTE table memory wastage")
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/powerpc/mm/mmu_context_book3s64.c |  8 ++++----
>>  arch/powerpc/mm/pgtable-book3s64.c     | 17 +++++++++++------
>>  include/linux/mm_types.h               |  5 ++++-
>>  3 files changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
>> index f3d4b4a0e561..3bb5cec03d1f 100644
>> --- a/arch/powerpc/mm/mmu_context_book3s64.c
>> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
>> @@ -200,9 +200,9 @@ static void pte_frag_destroy(void *pte_frag)
>>  	/* drop all the pending references */
>>  	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
>>  	/* We allow PTE_FRAG_NR fragments from a PTE page */
>> -	if (page_ref_sub_and_test(page, PTE_FRAG_NR - count)) {
>> +	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
>>  		pgtable_page_dtor(page);
>> -		free_unref_page(page);
>> +		__free_page(page);
>>  	}
>>  }
>>
>> @@ -215,9 +215,9 @@ static void pmd_frag_destroy(void *pmd_frag)
>>  	/* drop all the pending references */
>>  	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
>>  	/* We allow PTE_FRAG_NR fragments from a PTE page */
>> -	if (page_ref_sub_and_test(page, PMD_FRAG_NR - count)) {
>> +	if (atomic_sub_and_test(PMD_FRAG_NR - count, &page->pt_frag_refcount)) {
>>  		pgtable_pmd_page_dtor(page);
>> -		free_unref_page(page);
>> +		__free_page(page);
>>  	}
>>  }
>>
>> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
>> index 4afbfbb64bfd..78d0b3d5ebad 100644
>> --- a/arch/powerpc/mm/pgtable-book3s64.c
>> +++ b/arch/powerpc/mm/pgtable-book3s64.c
>> @@ -270,6 +270,8 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
>>  		return NULL;
>>  	}
>>
>> +	atomic_set(&page->pt_frag_refcount, 1);
>> +
>>  	ret = page_address(page);
>>  	/*
>>  	 * if we support only one fragment just return the
>> @@ -285,7 +287,7 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
>>  	 * count.
>>  	 */
>>  	if (likely(!mm->context.pmd_frag)) {
>> -		set_page_count(page, PMD_FRAG_NR);
>> +		atomic_set(&page->pt_frag_refcount, PMD_FRAG_NR);
>>  		mm->context.pmd_frag = ret + PMD_FRAG_SIZE;
>>  	}
>>  	spin_unlock(&mm->page_table_lock);
>> @@ -308,9 +310,10 @@ void pmd_fragment_free(unsigned long *pmd)
>>  {
>>  	struct page *page = virt_to_page(pmd);
>>
>> -	if (put_page_testzero(page)) {
>> +	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
>> +	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
>>  		pgtable_pmd_page_dtor(page);
>> -		free_unref_page(page);
>> +		__free_page(page);
>>  	}
>>  }
>>
>> @@ -352,6 +355,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
>>  			return NULL;
>>  	}
>>
>> +	atomic_set(&page->pt_frag_refcount, 1);
>>
>>  	ret = page_address(page);
>>  	/*
>> @@ -367,7 +371,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
>>  	 * count.
>>  	 */
>>  	if (likely(!mm->context.pte_frag)) {
>> -		set_page_count(page, PTE_FRAG_NR);
>> +		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
>>  		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
>>  	}
>>  	spin_unlock(&mm->page_table_lock);
>> @@ -390,10 +394,11 @@ void pte_fragment_free(unsigned long *table, int kernel)
>>  {
>>  	struct page *page = virt_to_page(table);
>>
>> -	if (put_page_testzero(page)) {
>> +	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
>> +	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
>>  		if (!kernel)
>>  			pgtable_page_dtor(page);
>> -		free_unref_page(page);
>> +		__free_page(page);
>>  	}
>>  }
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 99ce070e7dcb..22651e124071 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -139,7 +139,10 @@ struct page {
>>  			unsigned long _pt_pad_1;	/* compound_head */
>>  			pgtable_t pmd_huge_pte; /* protected by page->ptl */
>>  			unsigned long _pt_pad_2;	/* mapping */
>> -			struct mm_struct *pt_mm;	/* x86 pgds only */
>> +			union {
>> +				struct mm_struct *pt_mm; /* x86 pgds only */
>> +				atomic_t pt_frag_refcount; /* powerpc */
>> +			};
>>  #if ALLOC_SPLIT_PTLOCKS
>>  			spinlock_t *ptl;
>>  #else
>> -- 
>> 2.17.0
