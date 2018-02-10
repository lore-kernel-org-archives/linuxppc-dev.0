Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdnCT0BR8zF0cY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 20:47:13 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1A9iwsA079490
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 04:47:11 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1x5jrbk7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 04:47:10 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 10 Feb 2018 09:47:08 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxram@us.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/mm: Fix crashes with PUD level hugetlb config
In-Reply-To: <87r2pvfr5g.fsf@linux.vnet.ibm.com>
References: <20180208103442.22045-1-aneesh.kumar@linux.vnet.ibm.com>
 <87r2pvfr5g.fsf@linux.vnet.ibm.com>
Date: Sat, 10 Feb 2018 15:17:02 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9kxfa7d.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> To support memory keys, we moved the hash pte slot information to the second
>> half of the page table. This was ok with PTE entries at level 4 and level 3.
>> We already allocate larger page table pages at those level to accomodate extra
>> details. For level 4 we already have the extra space which was used to track
>> 4k hash page table entry details and at pmd level the extra space was allocated
>> to track the THP details.
>>
>> With hugetlbfs PTE, we used this extra space at the PMD level to store the
>> slot details. But we also support hugetlbfs PTE at PUD leve and PUD level page
>> didn't allocate extra space. This resulted in memory corruption.
>>
>> Fix this by allocating extra space at PUD level when HUGETLB is enabled. We
>> may need further changes to allocate larger space at PMD level when we enable
>> HUGETLB. That will be done in next patch.
>>
>> Fixes:bf9a95f9a6481bc6e(" powerpc: Free up four 64K PTE bits in 64K backed HPTE pages")
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Another fix, I still get random memory corruption with hugetlb test with
> 16G hugepage config.

Another one. I am not sure whether we really want this in this form. But
with this tests are running fine.

-aneesh

commit 658fe8c310a913e69e5bc9a40d4c28a3b88d5c08
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Sat Feb 10 13:17:34 2018 +0530

    powerpc/mm/hash64: memset the pagetable pages on allocation.
    
    Now that we are using second half of the table to store slot details and we
    don't clear them in the huge_pte_get_and_clear, we need to make sure we zero
    out the range on allocation. This done some extra work because the first half
    of the table is cleared by huge_pte_get_and_clear and memset in this patch
    zero-out the full table page.
    
    We need to do this for pgd and pud because both get allocated from the same slab
    cache.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
The other option is to get huget_pte_get_and_clear to clear the second half of the page table.
That requires generic changes, because we don't have hugetlb page size available there.

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 53df86d3cfce..adb7fba4b6c7 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -73,10 +73,13 @@ static inline void radix__pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
+	pgd_t *pgd;
 	if (radix_enabled())
 		return radix__pgd_alloc(mm);
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
-		pgtable_gfp_flags(mm, GFP_KERNEL));
+	pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	memset(pgd, 0, PGD_TABLE_SIZE);
+	return pgd;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
@@ -93,8 +96,11 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
-		pgtable_gfp_flags(mm, GFP_KERNEL));
+	pud_t *pud;
+	pud = kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
+			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	memset(pud, 0, PUD_TABLE_SIZE);
+	return pud;
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
