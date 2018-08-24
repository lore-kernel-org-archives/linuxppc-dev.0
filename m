Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xW9G4l3TzDqwt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 16:10:26 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7O69DKS007782
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 02:10:24 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m2a10cpth-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 02:10:24 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 24 Aug 2018 00:00:17 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V3 1/6] powerpc/mm/book3s: Update pmd_present to look at
 _PAGE_PRESENT bit
Date: Fri, 24 Aug 2018 11:30:03 +0530
Message-Id: <20180824060008.18396-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this patch we use 0x8000000000000000UL (_PAGE_PRESENT) to indicate a valid
pgd/pud/pmd entry. We also switch the p**_present() to look at this bit.

With pmd_present, we have a special case. We need to make sure we consider a
pmd marked invalid during THP split as present. Right now we clear the
_PAGE_PRESENT bit during a pmdp_invalidate. Inorder to consider this special
case we add a new pte bit _PAGE_INVALID (mapped to _RPAGE_SW0). This bit is
only used with _PAGE_PRESENT cleared. Hence we are not really losing a pte bit
for this special case. pmd_present is also updated to look at _PAGE_INVALID.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    |  5 +++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 14 +++++++++++---
 arch/powerpc/mm/hash_utils_64.c              |  6 +++---
 arch/powerpc/mm/pgtable-book3s64.c           |  9 +++++++--
 arch/powerpc/mm/pgtable.c                    |  3 ++-
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d52a51b2ce7b..fcf8b10a209f 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -18,6 +18,11 @@
 #include <asm/book3s/64/hash-4k.h>
 #endif
 
+/* Bits to set in a PMD/PUD/PGD entry valid bit*/
+#define HASH_PMD_VAL_BITS		(0x8000000000000000UL)
+#define HASH_PUD_VAL_BITS		(0x8000000000000000UL)
+#define HASH_PGD_VAL_BITS		(0x8000000000000000UL)
+
 /*
  * Size of EA range mapped by our pagetables.
  */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 13a688fc8cd0..8feb4a3240d5 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -875,8 +875,16 @@ static inline int pmd_none(pmd_t pmd)
 
 static inline int pmd_present(pmd_t pmd)
 {
+	/*
+	 * A pmd is considerent present if _PAGE_PRESENT is set.
+	 * We also need to consider the pmd present which is marked
+	 * invalid during a split. Hence we look for _PAGE_INVALID
+	 * if we find _PAGE_PRESENT cleared.
+	 */
+	if (pmd_raw(pmd) & cpu_to_be64(_PAGE_PRESENT | _PAGE_INVALID))
+		return true;
 
-	return !pmd_none(pmd);
+	return false;
 }
 
 static inline int pmd_bad(pmd_t pmd)
@@ -903,7 +911,7 @@ static inline int pud_none(pud_t pud)
 
 static inline int pud_present(pud_t pud)
 {
-	return !pud_none(pud);
+	return (pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
 }
 
 extern struct page *pud_page(pud_t pud);
@@ -950,7 +958,7 @@ static inline int pgd_none(pgd_t pgd)
 
 static inline int pgd_present(pgd_t pgd)
 {
-	return !pgd_none(pgd);
+	return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
 }
 
 static inline pte_t pgd_pte(pgd_t pgd)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f23a89d8e4ce..8ff03c7205a0 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1001,9 +1001,9 @@ void __init hash__early_init_mmu(void)
 	 * 4k use hugepd format, so for hash set then to
 	 * zero
 	 */
-	__pmd_val_bits = 0;
-	__pud_val_bits = 0;
-	__pgd_val_bits = 0;
+	__pmd_val_bits = HASH_PMD_VAL_BITS;
+	__pud_val_bits = HASH_PUD_VAL_BITS;
+	__pgd_val_bits = HASH_PGD_VAL_BITS;
 
 	__kernel_virt_start = H_KERN_VIRT_START;
 	__kernel_virt_size = H_KERN_VIRT_SIZE;
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 01d7c0f7c4f0..cb73b3f9912c 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -69,7 +69,12 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
+	/*
+	 * pmd during temporary invalidate will be considered present.
+	 * So check for _PAGE_PRESENT explicitly.
+	 */
+	WARN_ON((pte_raw(pmd_pte(*pmdp)) & cpu_to_be64(_PAGE_PRESENT)) &&
+		!pte_protnone(pmd_pte(*pmdp)));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 	WARN_ON(!(pmd_trans_huge(pmd) || pmd_devmap(pmd)));
 #endif
@@ -106,7 +111,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 {
 	unsigned long old_pmd;
 
-	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
+	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	/*
 	 * This ensures that generic code that rely on IRQ disabling
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index d71c7777669c..4e065383fbe3 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -192,7 +192,8 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
 	 * Hence we can use set_pte_at for them.
 	 */
-	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
+	VM_WARN_ON((pte_raw(*ptep) & cpu_to_be64(_PAGE_PRESENT)) &&
+		!pte_protnone(*ptep));
 
 	/* Add the pte bit when trying to set a pte */
 	pte = __pte(pte_val(pte) | _PAGE_PTE);
-- 
2.17.1
