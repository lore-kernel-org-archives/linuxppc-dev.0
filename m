Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C55A1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 03:52:05 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 18 Feb 2016 09:52:04 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 379821FF0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:40:03 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1IGprSu23003180
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:51:53 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1IGpqgY001590
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 09:51:53 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 17/30] powerpc/mm: Use flush_tlb_page in
 ptep_clear_flush_young
Date: Thu, 18 Feb 2016 22:20:41 +0530
Message-Id: <1455814254-10226-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This should not have any impact for hash linux implementation. But radix
would require us to flush tlb after clearing accessed bit. Also move
code that is not dependent on pte bits to generic header.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 45 +++++-----------------------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 39 ++++++++++++++++++++++++
 arch/powerpc/include/asm/mmu-hash64.h        |  2 +-
 3 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 0bcd9f0d16c8..890c81014dc7 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -319,6 +319,14 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 	return old;
 }
 
+/*
+ * We currently remove entries from the hashtable regardless of whether
+ * the entry was young or dirty. The generic routines only flush if the
+ * entry was young or dirty which is not good enough.
+ *
+ * We should be more intelligent about this but for the moment we override
+ * these functions and force a tlb flush unconditionally
+ */
 static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 					      unsigned long addr, pte_t *ptep)
 {
@@ -329,13 +337,6 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 	old = pte_update(mm, addr, ptep, H_PAGE_ACCESSED, 0, 0);
 	return (old & H_PAGE_ACCESSED) != 0;
 }
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-#define ptep_test_and_clear_young(__vma, __addr, __ptep)		   \
-({									   \
-	int __r;							   \
-	__r = __ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep); \
-	__r;								   \
-})
 
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
@@ -357,36 +358,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pte_update(mm, addr, ptep, H_PAGE_RW, 0, 1);
 }
 
-/*
- * We currently remove entries from the hashtable regardless of whether
- * the entry was young or dirty. The generic routines only flush if the
- * entry was young or dirty which is not good enough.
- *
- * We should be more intelligent about this but for the moment we override
- * these functions and force a tlb flush unconditionally
- */
-#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-#define ptep_clear_flush_young(__vma, __address, __ptep)		\
-({									\
-	int __young = __ptep_test_and_clear_young((__vma)->vm_mm, __address, \
-						  __ptep);		\
-	__young;							\
-})
-
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
-				       unsigned long addr, pte_t *ptep)
-{
-	unsigned long old = pte_update(mm, addr, ptep, ~0UL, 0, 0);
-	return __pte(old);
-}
-
-static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
-			     pte_t * ptep)
-{
-	pte_update(mm, addr, ptep, ~0UL, 0, 0);
-}
-
 
 /* Set the dirty and/or accessed bits atomically in a linux PTE, this
  * function doesn't need to flush the hash entry
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index a57f425043ee..2e6d2362748b 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -8,6 +8,10 @@
 #include <asm/book3s/64/hash.h>
 #include <asm/barrier.h>
 
+#ifndef __ASSEMBLY__
+#include <asm/tlbflush.h>
+#include <linux/mm_types.h>
+#endif
 /*
  * The second half of the kernel virtual space is used for IO mappings,
  * it's itself carved into the PIO region (ISA and PHB IO space) and
@@ -129,6 +133,41 @@ extern unsigned long ioremap_bot;
 
 #endif /* __real_pte */
 
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long address,
+					    pte_t *ptep)
+{
+	return  __ptep_test_and_clear_young(vma->vm_mm, address, ptep);
+}
+
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	int young;
+
+	young = __ptep_test_and_clear_young(vma->vm_mm, address, ptep);
+	if (young)
+		flush_tlb_page(vma, address);
+	return young;
+}
+
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long addr, pte_t *ptep)
+{
+	unsigned long old = pte_update(mm, addr, ptep, ~0UL, 0, 0);
+
+	return __pte(old);
+}
+
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
+			     pte_t *ptep)
+{
+	pte_update(mm, addr, ptep, ~0UL, 0, 0);
+}
+
 static inline void pmd_set(pmd_t *pmdp, unsigned long val)
 {
 	*pmdp = __pmd(val);
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 5b32723b24b1..a34f3687e093 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -21,7 +21,7 @@
  * need for various slices related matters. Note that this isn't the
  * complete pgtable.h but only a portion of it.
  */
-#include <asm/book3s/64/pgtable.h>
+#include <asm/book3s/64/hash.h>
 #include <asm/bug.h>
 #include <asm/processor.h>
 
-- 
2.5.0
