Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41X4p40yzxzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 19:09:31 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6K982uM061803
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 05:09:29 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kbcu3r21n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 05:09:29 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 20 Jul 2018 05:09:27 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 1/4] powerpc/mm/book3s: Update pmd_present to look at
 _PAGE_PRESENT bit
Date: Fri, 20 Jul 2018 14:39:11 +0530
Message-Id: <20180720090914.17471-1-aneesh.kumar@linux.ibm.com>
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
only used with _PAGE_PRESENT cleared. Hence we are not really loosing a pte bit
for this special case. pmd_present is also updated to look at _PAGE_INVALID.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    |  5 +++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 23 +++++++++++++++++---
 arch/powerpc/mm/hash_utils_64.c              |  6 ++---
 arch/powerpc/mm/pgtable-book3s64.c           |  2 +-
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 0387b155f13d..a371ac7c3183 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -16,6 +16,11 @@
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
index 676118743a06..fce9ce8781a0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -44,6 +44,15 @@
 
 #define _PAGE_PTE		0x4000000000000000UL	/* distinguishes PTEs from pointers */
 #define _PAGE_PRESENT		0x8000000000000000UL	/* pte contains a translation */
+/*
+ * We need to mark a pmd pte invalid while splitting. We can do that by clearing the
+ * _PAGE_PRESENT bit. But then that will be taken as a swap pte. Inorder to differentiate
+ * between two use a SW field when invalidating. We don't add a special bit to indicate
+ * swap pte because that is also used for migration ptes, and we do back and forth between
+ * a valid pte entry and migration ptes. So any information in the software bits will be
+ * lost if we overload those bits.
+ */
+#define _PAGE_INVALID		_RPAGE_SW0
 
 /*
  * Top and bottom bits of RPN which can be used by hash
@@ -859,8 +868,16 @@ static inline int pmd_none(pmd_t pmd)
 
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
@@ -887,7 +904,7 @@ static inline int pud_none(pud_t pud)
 
 static inline int pud_present(pud_t pud)
 {
-	return !pud_none(pud);
+	return (pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
 }
 
 extern struct page *pud_page(pud_t pud);
@@ -934,7 +951,7 @@ static inline int pgd_none(pgd_t pgd)
 
 static inline int pgd_present(pgd_t pgd)
 {
-	return !pgd_none(pgd);
+	return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
 }
 
 static inline pte_t pgd_pte(pgd_t pgd)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5a72e980e25a..7ce7fa5397d5 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1002,9 +1002,9 @@ void __init hash__early_init_mmu(void)
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
index 5d2328ef7958..c1f825ff251b 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -106,7 +106,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 {
 	unsigned long old_pmd;
 
-	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
+	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	/*
 	 * This ensures that generic code that rely on IRQ disabling
-- 
2.17.1
