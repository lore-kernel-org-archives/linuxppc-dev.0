Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74CB81A17C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 18:17:13 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 12:47:11 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id BE7C43940065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:47:06 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0C7GTL119923172
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:30 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0C7GT0Y014035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 33/33] powerpc/mm: Hash linux abstraction for pte swap
 encoding
Date: Tue, 12 Jan 2016 12:46:08 +0530
Message-Id: <1452582968-22669-34-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 44 +++++++++----------------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 49 ++++++++++++++++++++++++++++
 arch/powerpc/mm/slb.c                        |  1 -
 3 files changed, 64 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index f43b26c4d319..13926dbfb687 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -41,6 +41,7 @@
  */
 #define H_PAGE_THP_HUGE  H_PAGE_4K_PFN
 
+#define H_PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + H_PAGE_BIT_SWAP_TYPE))
 /*
  * set of bits not changed in pmd_modify.
  */
@@ -230,46 +231,31 @@
 #define hlpmd_index(address) (((address) >> (H_PMD_SHIFT)) & (H_PTRS_PER_PMD - 1))
 #define hlpte_index(address) (((address) >> (PAGE_SHIFT)) & (H_PTRS_PER_PTE - 1))
 
-/* Encode and de-code a swap entry */
-#define MAX_SWAPFILES_CHECK() do { \
-	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS); \
-	/*							\
-	 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
-	 * We filter HPTEFLAGS on set_pte.			\
-	 */							\
-	BUILD_BUG_ON(H_PAGE_HPTEFLAGS & (0x1f << H_PAGE_BIT_SWAP_TYPE)); \
-	BUILD_BUG_ON(H_PAGE_HPTEFLAGS & H_PAGE_SWP_SOFT_DIRTY);	\
-	} while (0)
 /*
  * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
+ * We encode swap type in the lower part of pte, skipping the lowest two bits.
+ * Offset is encoded as pfn.
  */
-#define SWP_TYPE_BITS 5
-#define __swp_type(x)		(((x).val >> H_PAGE_BIT_SWAP_TYPE) \
-				& ((1UL << SWP_TYPE_BITS) - 1))
-#define __swp_offset(x)		((x).val >> H_PTE_RPN_SHIFT)
-#define __swp_entry(type, offset)	((swp_entry_t) { \
-					((type) << H_PAGE_BIT_SWAP_TYPE) \
-					| ((offset) << H_PTE_RPN_SHIFT) })
-
-#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
-#define __swp_entry_to_pte(x)		__pte((x).val)
+#define hl_swp_type(x)		(((x).val >> H_PAGE_BIT_SWAP_TYPE)	\
+				 & ((1UL << SWP_TYPE_BITS) - 1))
+#define hl_swp_offset(x)	((x).val >> H_PTE_RPN_SHIFT)
+#define hl_swp_entry(type, offset)	((swp_entry_t) {		\
+				((type) << H_PAGE_BIT_SWAP_TYPE)	\
+				| ((offset) << H_PTE_RPN_SHIFT) })
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
-#define _PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + _PAGE_BIT_SWAP_TYPE))
-static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+static inline pte_t hl_pte_swp_mksoft_dirty(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
+	return __pte(pte_val(pte) | H_PAGE_SWP_SOFT_DIRTY);
 }
-static inline bool pte_swp_soft_dirty(pte_t pte)
+static inline bool hl_pte_swp_soft_dirty(pte_t pte)
 {
-	return !!(pte_val(pte) & _PAGE_SWP_SOFT_DIRTY);
+	return !!(pte_val(pte) & H_PAGE_SWP_SOFT_DIRTY);
 }
-static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+static inline pte_t hl_pte_swp_clear_soft_dirty(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_SWP_SOFT_DIRTY);
+	return __pte(pte_val(pte) & ~H_PAGE_SWP_SOFT_DIRTY);
 }
-#else
-#define _PAGE_SWP_SOFT_DIRTY	0
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
 extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index ff7dda649ee3..bf5598628e34 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -5,6 +5,7 @@
  * the ppc64 hashed page table.
  */
 
+#define SWP_TYPE_BITS 5
 #include <asm/book3s/64/hash.h>
 #include <asm/barrier.h>
 
@@ -322,6 +323,54 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 {
 	return set_hlpte_at(mm, addr, ptep, pte);
 }
+/*
+ * Swap definitions
+ */
+
+/* Encode and de-code a swap entry */
+#define MAX_SWAPFILES_CHECK() do {					\
+		BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS);	\
+		/*							\
+		 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
+		 * We filter HPTEFLAGS on set_pte.			\
+		 */							\
+		BUILD_BUG_ON(H_PAGE_HPTEFLAGS & (0x1f << H_PAGE_BIT_SWAP_TYPE)); \
+		BUILD_BUG_ON(H_PAGE_HPTEFLAGS & H_PAGE_SWP_SOFT_DIRTY);	\
+	} while (0)
+/*
+ * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
+ */
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
+#define __swp_entry_to_pte(x)		__pte((x).val)
+static inline unsigned long __swp_type(swp_entry_t entry)
+{
+	return hl_swp_type(entry);
+}
+
+static inline pgoff_t __swp_offset(swp_entry_t entry)
+{
+	return hl_swp_offset(entry);
+}
+
+static inline swp_entry_t __swp_entry(unsigned long type, pgoff_t offset)
+{
+	return hl_swp_entry(type, offset);
+}
+
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+{
+	return hl_pte_swp_mksoft_dirty(pte);
+}
+static inline bool pte_swp_soft_dirty(pte_t pte)
+{
+	return hl_pte_swp_soft_dirty(pte);
+}
+static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+{
+	return hl_pte_swp_clear_soft_dirty(pte);
+}
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
 static inline void pmd_set(pmd_t *pmdp, unsigned long val)
 {
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 6ec8f49822d1..11c132f4cb35 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -14,7 +14,6 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#include <asm/pgtable.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/paca.h>
-- 
2.5.0
