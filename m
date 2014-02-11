Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CA02C2C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 21:35:17 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 11 Feb 2014 16:05:12 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B522B3940063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 16:05:07 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1BAZ8lU59375786
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 16:05:08 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1BAZ63D031400
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 16:05:07 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, riel@redhat.com,
 mgorman@suse.de, mpe@ellerman.id.au
Subject: [PATCH 3/3] mm: Use ptep/pmdp_set_numa for updating _PAGE_NUMA bit
Date: Tue, 11 Feb 2014 16:04:55 +0530
Message-Id: <1392114895-14997-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1392114895-14997-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1392114895-14997-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Archs like ppc64 doesn't do tlb flush in set_pte/pmd functions. ppc64 also doesn't implement
flush_tlb_range. ppc64 require the tlb flushing to be batched within ptl locks. The reason
to do that is to ensure that the hash page table is in sync with linux page table.
We track the hpte index in linux pte and if we clear them without flushing hash and drop the
ptl lock, we can have another cpu update the pte and can end up with double hash. We also want
to keep set_pte_at simpler by not requiring them to do hash flush for performance reason.
Hence cannot use them while updating _PAGE_NUMA bit. Add new functions for marking pte/pmd numa

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable.h | 22 ++++++++++++++++++++++
 include/asm-generic/pgtable.h      | 24 ++++++++++++++++++++++++
 mm/huge_memory.c                   |  9 ++-------
 mm/mprotect.c                      |  4 +---
 4 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index f83b6f3e1b39..3ebb188c3ff5 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -75,12 +75,34 @@ static inline pte_t pte_mknuma(pte_t pte)
 	return pte;
 }
 
+#define ptep_set_numa ptep_set_numa
+static inline void ptep_set_numa(struct mm_struct *mm, unsigned long addr,
+				 pte_t *ptep)
+{
+	if ((pte_val(*ptep) & _PAGE_PRESENT) == 0)
+		VM_BUG_ON(1);
+
+	pte_update(mm, addr, ptep, _PAGE_PRESENT, _PAGE_NUMA, 0);
+	return;
+}
+
 #define pmd_numa pmd_numa
 static inline int pmd_numa(pmd_t pmd)
 {
 	return pte_numa(pmd_pte(pmd));
 }
 
+#define pmdp_set_numa pmdp_set_numa
+static inline void pmdp_set_numa(struct mm_struct *mm, unsigned long addr,
+				 pmd_t *pmdp)
+{
+	if ((pmd_val(*pmdp) & _PAGE_PRESENT) == 0)
+		VM_BUG_ON(1);
+
+	pmd_hugepage_update(mm, addr, pmdp, _PAGE_PRESENT, _PAGE_NUMA);
+	return;
+}
+
 #define pmd_mknonnuma pmd_mknonnuma
 static inline pmd_t pmd_mknonnuma(pmd_t pmd)
 {
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 8e4f41d9af4d..93fdb5315a0d 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -669,6 +669,18 @@ static inline int pmd_numa(pmd_t pmd)
 }
 #endif
 
+#ifndef pmdp_set_numa
+static inline void pmdp_set_numa(struct mm_struct *mm, unsigned long addr,
+				 pmd_t *pmdp)
+{
+	pmd_t pmd = *pmdp;
+
+	pmd = pmd_mknuma(entry);
+	set_pmd_at(mm, addr, pmdp, pmd);
+	return;
+}
+#endif
+
 /*
  * pte/pmd_mknuma sets the _PAGE_ACCESSED bitflag automatically
  * because they're called by the NUMA hinting minor page fault. If we
@@ -701,6 +713,18 @@ static inline pte_t pte_mknuma(pte_t pte)
 }
 #endif
 
+#ifndef ptep_set_numa
+static inline void ptep_set_numa(struct mm_struct *mm, unsigned long addr,
+				 pte_t *ptep)
+{
+	pte_t ptent = *ptep;
+
+	ptent = pte_mknuma(ptent);
+	set_pte_at(mm, addr, ptep, ptent);
+	return;
+}
+#endif
+
 #ifndef pmd_mknuma
 static inline pmd_t pmd_mknuma(pmd_t pmd)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 82166bf974e1..da23eb96779f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1545,6 +1545,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pmd_mknonnuma(entry);
 			entry = pmd_modify(entry, newprot);
 			ret = HPAGE_PMD_NR;
+			set_pmd_at(mm, addr, pmd, entry);
 			BUG_ON(pmd_write(entry));
 		} else {
 			struct page *page = pmd_page(*pmd);
@@ -1557,16 +1558,10 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			 */
 			if (!is_huge_zero_page(page) &&
 			    !pmd_numa(*pmd)) {
-				entry = *pmd;
-				entry = pmd_mknuma(entry);
+				pmdp_set_numa(mm, addr, pmd);
 				ret = HPAGE_PMD_NR;
 			}
 		}
-
-		/* Set PMD if cleared earlier */
-		if (ret == HPAGE_PMD_NR)
-			set_pmd_at(mm, addr, pmd, entry);
-
 		spin_unlock(ptl);
 	}
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 33eab902f10e..769a67a15803 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -69,12 +69,10 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			} else {
 				struct page *page;
 
-				ptent = *pte;
 				page = vm_normal_page(vma, addr, oldpte);
 				if (page && !PageKsm(page)) {
 					if (!pte_numa(oldpte)) {
-						ptent = pte_mknuma(ptent);
-						set_pte_at(mm, addr, pte, ptent);
+						ptep_set_numa(mm, addr, pte);
 						updated = true;
 					}
 				}
-- 
1.8.3.2
