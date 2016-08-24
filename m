Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sK2FP6GlmzDrcL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 19:34:17 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7O9SrNg024669
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 05:34:16 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 250kvv1ev4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 05:34:15 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 24 Aug 2016 05:34:14 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/4] powerpc/mm/radix: Use different pte update sequence for
 different POWER9 revs
Date: Wed, 24 Aug 2016 15:03:38 +0530
In-Reply-To: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1472031219-18759-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 DD1 requires pte to be marked invalid (V=0) before updating
it with the new value. This makes this distinction for the different
revisions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  3 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  5 +-
 arch/powerpc/include/asm/book3s/64/radix.h   | 75 ++++++++++++++++++++++------
 arch/powerpc/include/asm/nohash/32/pgtable.h |  3 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h |  3 +-
 arch/powerpc/mm/pgtable-book3s64.c           |  2 +-
 arch/powerpc/mm/pgtable.c                    |  2 +-
 7 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 38b33dcfcc9d..6b8b2d57fdc8 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -223,7 +223,8 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 }
 
 
-static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
+static inline void __ptep_set_access_flags(struct mm_struct *mm,
+					   pte_t *ptep, pte_t entry)
 {
 	unsigned long set = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 263bf39ced40..8ec8be9495ba 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -565,10 +565,11 @@ static inline bool check_pte_access(unsigned long access, unsigned long ptev)
  * Generic functions with hash/radix callbacks
  */
 
-static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
+static inline void __ptep_set_access_flags(struct mm_struct *mm,
+					   pte_t *ptep, pte_t entry)
 {
 	if (radix_enabled())
-		return radix__ptep_set_access_flags(ptep, entry);
+		return radix__ptep_set_access_flags(mm, ptep, entry);
 	return hash__ptep_set_access_flags(ptep, entry);
 }
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index a2fe8fbfbd3d..2a46dea8e1b1 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -11,6 +11,11 @@
 #include <asm/book3s/64/radix-4k.h>
 #endif
 
+#ifndef __ASSEMBLY__
+#include <asm/book3s/64/tlbflush-radix.h>
+#include <asm/cpu_has_feature.h>
+#endif
+
 /* An empty PTE can still have a R or C writeback */
 #define RADIX_PTE_NONE_MASK		(_PAGE_DIRTY | _PAGE_ACCESSED)
 
@@ -105,11 +110,8 @@
 #define RADIX_PUD_TABLE_SIZE	(sizeof(pud_t) << RADIX_PUD_INDEX_SIZE)
 #define RADIX_PGD_TABLE_SIZE	(sizeof(pgd_t) << RADIX_PGD_INDEX_SIZE)
 
-static inline unsigned long radix__pte_update(struct mm_struct *mm,
-					unsigned long addr,
-					pte_t *ptep, unsigned long clr,
-					unsigned long set,
-					int huge)
+static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
+					       unsigned long set)
 {
 	pte_t pte;
 	unsigned long old_pte, new_pte;
@@ -121,9 +123,39 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 
 	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
-	/* We already do a sync in cmpxchg, is ptesync needed ?*/
+	return old_pte;
+}
+
+
+static inline unsigned long radix__pte_update(struct mm_struct *mm,
+					unsigned long addr,
+					pte_t *ptep, unsigned long clr,
+					unsigned long set,
+					int huge)
+{
+	unsigned long old_pte;
+
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+
+		unsigned long new_pte;
+
+		old_pte = __radix_pte_update(ptep, ~0, 0);
+		asm volatile("ptesync" : : : "memory");
+		/*
+		 * new value of pte
+		 */
+		new_pte = (old_pte | set) & ~clr;
+
+		/*
+		 * For now let's do heavy pid flush
+		 * radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
+		 */
+		radix__flush_tlb_mm(mm);
+
+		__radix_pte_update(ptep, 0, new_pte);
+	} else
+		old_pte = __radix_pte_update(ptep, clr, set);
 	asm volatile("ptesync" : : : "memory");
-	/* huge pages use the old page table lock */
 	if (!huge)
 		assert_pte_locked(mm, addr);
 
@@ -134,20 +166,33 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
  * Set the dirty and/or accessed bits atomically in a linux PTE, this
  * function doesn't need to invalidate tlb.
  */
-static inline void radix__ptep_set_access_flags(pte_t *ptep, pte_t entry)
+static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
+						pte_t *ptep, pte_t entry)
 {
-	pte_t pte;
-	unsigned long old_pte, new_pte;
+
 	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
 					      _PAGE_RW | _PAGE_EXEC);
-	do {
-		pte = READ_ONCE(*ptep);
-		old_pte = pte_val(pte);
+
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+
+		unsigned long old_pte, new_pte;
+
+		old_pte = __radix_pte_update(ptep, ~0, 0);
+		asm volatile("ptesync" : : : "memory");
+		/*
+		 * new value of pte
+		 */
 		new_pte = old_pte | set;
 
-	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
+		/*
+		 * For now let's do heavy pid flush
+		 * radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
+		 */
+		radix__flush_tlb_mm(mm);
 
-	/* We already do a sync in cmpxchg, is ptesync needed ?*/
+		__radix_pte_update(ptep, 0, new_pte);
+	} else
+		__radix_pte_update(ptep, 0, set);
 	asm volatile("ptesync" : : : "memory");
 }
 
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 780847597514..c219ef7be53b 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -267,7 +267,8 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 }
 
 
-static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
+static inline void __ptep_set_access_flags(struct mm_struct *mm,
+					   pte_t *ptep, pte_t entry)
 {
 	unsigned long set = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index d4d808cf905e..653a1838469d 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -300,7 +300,8 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 /* Set the dirty and/or accessed bits atomically in a linux PTE, this
  * function doesn't need to flush the hash entry
  */
-static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
+static inline void __ptep_set_access_flags(struct mm_struct *mm,
+					   pte_t *ptep, pte_t entry)
 {
 	unsigned long bits = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 34079302cc17..7328886bca4c 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -35,7 +35,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 #endif
 	changed = !pmd_same(*(pmdp), entry);
 	if (changed) {
-		__ptep_set_access_flags(pmdp_ptep(pmdp), pmd_pte(entry));
+		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp), pmd_pte(entry));
 		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	}
 	return changed;
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 0b6fb244d0a1..911fdfb63ec1 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -224,7 +224,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	if (changed) {
 		if (!is_vm_hugetlb_page(vma))
 			assert_pte_locked(vma->vm_mm, address);
-		__ptep_set_access_flags(ptep, entry);
+		__ptep_set_access_flags(vma->vm_mm, ptep, entry);
 		flush_tlb_page(vma, address);
 	}
 	return changed;
-- 
2.7.4
