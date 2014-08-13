Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC7511A1603
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:26 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Aug 2014 17:02:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 95FF92BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:24 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7D6j3N834603122
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 16:45:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7D72NCe006130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:23 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V2 4/8] powerpc: thp: Handle combo pages in invalidate
Date: Wed, 13 Aug 2014 12:32:00 +0530
Message-Id: <1407913324-8062-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1407913324-8062-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1407913324-8062-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we changed base page size of the segment, either via sub_page_protect
or via remap_4k_pfn, we do a demote_segment which doesn't flush the hash
table entries. We do a lazy hash page table flush for all mapped pages
in the demoted segment. This happens when we handle hash page fault for
these pages.

We use _PAGE_COMBO bit along with _PAGE_HASHPTE to indicate whether a
pte is backed by 4K hash pte. If we find _PAGE_COMBO not set on the pte,
that implies that we could possibly have older 64K hash pte entries in
the hash page table and we need to invalidate those entries.

Use _PAGE_COMBO to determine the page size with which we should
invalidate the hash table entries on unmap.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |  2 +-
 arch/powerpc/mm/pgtable_64.c             | 14 +++++++++++---
 arch/powerpc/mm/tlb_hash64.c             |  2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index eb9261024f51..7b3d54fae46f 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -413,7 +413,7 @@ static inline char *get_hpte_slot_array(pmd_t *pmdp)
 }
 
 extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
-				   pmd_t *pmdp);
+				   pmd_t *pmdp, unsigned long old_pmd);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
 extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 5039f3b04d6e..948a81e02ddb 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -538,7 +538,7 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 	*pmdp = __pmd((old & ~clr) | set);
 #endif
 	if (old & _PAGE_HASHPTE)
-		hpte_do_hugepage_flush(mm, addr, pmdp);
+		hpte_do_hugepage_flush(mm, addr, pmdp, old);
 	return old;
 }
 
@@ -645,7 +645,7 @@ void pmdp_splitting_flush(struct vm_area_struct *vma,
 	if (!(old & _PAGE_SPLITTING)) {
 		/* We need to flush the hpte */
 		if (old & _PAGE_HASHPTE)
-			hpte_do_hugepage_flush(vma->vm_mm, address, pmdp);
+			hpte_do_hugepage_flush(vma->vm_mm, address, pmdp, old);
 	}
 	/*
 	 * This ensures that generic code that rely on IRQ disabling
@@ -723,7 +723,7 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
  * neesd to be flushed.
  */
 void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
-			    pmd_t *pmdp)
+			    pmd_t *pmdp, unsigned long old_pmd)
 {
 	int ssize, i;
 	unsigned long s_addr;
@@ -746,7 +746,15 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	/* get the base page size,vsid and segment size */
+#ifdef CONFIG_DEBUG_VM
 	psize = get_slice_psize(mm, s_addr);
+	BUG_ON(psize == MMU_PAGE_16M);
+#endif
+	if (old_pmd & _PAGE_COMBO)
+		psize = MMU_PAGE_4K;
+	else
+		psize = MMU_PAGE_64K;
+
 	if (!is_kernel_addr(s_addr)) {
 		ssize = user_segment_size(s_addr);
 		vsid = get_vsid(mm->context.id, s_addr, ssize);
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index c99f6510a0b2..9adda5790463 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -216,7 +216,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 		if (!(pte & _PAGE_HASHPTE))
 			continue;
 		if (unlikely(hugepage_shift && pmd_trans_huge(*(pmd_t *)pte)))
-			hpte_do_hugepage_flush(mm, start, (pmd_t *)pte);
+			hpte_do_hugepage_flush(mm, start, (pmd_t *)ptep, pte);
 		else
 			hpte_need_flush(mm, start, ptep, pte, 0);
 	}
-- 
1.9.1
