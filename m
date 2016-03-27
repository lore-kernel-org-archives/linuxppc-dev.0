Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqrq1NSfzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:50 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:26:49 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5E70619D8041
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:14:40 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8Qlrm46399594
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:26:47 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8Qk1w003433
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:26:46 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 64/65] powerpc/mm/radix: Add THP support for 4k linux page size
Date: Sun, 27 Mar 2016 13:54:12 +0530
Message-Id: <1459067053-10835-64-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/hash-4k.h     | 60 ++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 60 ------------------------
 arch/powerpc/include/asm/book3s/64/pgtable.h     | 57 ++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype           |  2 +-
 4 files changed, 118 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 4d2ae7fdc4f9..add4d554312c 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -29,6 +29,7 @@
 #define H_PAGE_THP_HUGE 0x0
 #define H_PTE_FRAG_NR	0
 #define H_PTE_FRAG_SIZE_SHIFT  0
+#define H_PAGE_COMBO	0x0
 /*
  * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range()
  */
@@ -49,6 +50,65 @@ static inline int hl_hugepd_ok(hugepd_t hpd)
 }
 #endif
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+
+static inline char *get_hpte_slot_array(pmd_t *pmdp)
+{
+	BUG();
+	return NULL;
+}
+
+static inline unsigned int hpte_valid(unsigned char *hpte_slot_array, int index)
+{
+	BUG();
+	return 0;
+}
+
+static inline unsigned int hpte_hash_index(unsigned char *hpte_slot_array,
+					   int index)
+{
+	BUG();
+	return 0;
+}
+
+static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
+					unsigned int index, unsigned int hidx)
+{
+	BUG();
+}
+
+static inline int hlpmd_trans_huge(pmd_t pmd)
+{
+	return 0;
+}
+
+static inline int hlpmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	BUG();
+	return 0;
+}
+
+static inline pmd_t hlpmd_mkhuge(pmd_t pmd)
+{
+	BUG();
+	return pmd;
+}
+
+extern unsigned long hlpmd_hugepage_update(struct mm_struct *mm,
+					   unsigned long addr, pmd_t *pmdp,
+					   unsigned long clr, unsigned long set);
+extern pmd_t hlpmdp_collapse_flush(struct vm_area_struct *vma,
+				   unsigned long address, pmd_t *pmdp);
+extern void hlpgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
+					 pgtable_t pgtable);
+extern pgtable_t hlpgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+extern void hlpmdp_huge_split_prepare(struct vm_area_struct *vma,
+				      unsigned long address, pmd_t *pmdp);
+extern pmd_t hlpmdp_huge_get_and_clear(struct mm_struct *mm,
+				       unsigned long addr, pmd_t *pmdp);
+extern int hl_has_transparent_hugepage(void);
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index 1803458a3297..888c25a491b0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -53,66 +53,6 @@ static inline int hugepd_ok(hugepd_t hpd)
 
 #endif /* CONFIG_HUGETLB_PAGE */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pmd_large(pmd_t pmd)
-{
-	return !!(pmd_val(pmd) & _PAGE_PTE);
-}
-
-static inline pmd_t pmd_mknotpresent(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
-}
-/*
- * For radix we should always find H_PAGE_HASHPTE zero. Hence
- * the below will work for radix too
- */
-static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pmd_t *pmdp)
-{
-	unsigned long old;
-
-	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
-		return 0;
-	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
-	return ((old & _PAGE_ACCESSED) != 0);
-}
-
-#define __HAVE_ARCH_PMDP_SET_WRPROTECT
-static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
-				      pmd_t *pmdp)
-{
-
-	if ((pmd_val(*pmdp) & _PAGE_WRITE) == 0)
-		return;
-
-	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
-}
-
-static inline int pmd_trans_huge(pmd_t pmd)
-{
-	if (radix_enabled())
-		return rpmd_trans_huge(pmd);
-	return hlpmd_trans_huge(pmd);
-}
-
-#define __HAVE_ARCH_PMD_SAME
-static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
-{
-	if (radix_enabled())
-		return rpmd_same(pmd_a, pmd_b);
-	return hlpmd_same(pmd_a, pmd_b);
-}
-
-static inline pmd_t pmd_mkhuge(pmd_t pmd)
-{
-	if (radix_enabled())
-		return rpmd_mkhuge(pmd);
-	return hlpmd_mkhuge(pmd);
-}
-
-#endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
-
 static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
 			       unsigned long pfn, pgprot_t prot)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 7eda6d2e5124..24d89e9001e0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -841,6 +841,63 @@ pmd_hugepage_update(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp,
 	return hlpmd_hugepage_update(mm, addr, pmdp, clr, set);
 }
 
+static inline int pmd_large(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_PTE);
+}
+
+static inline pmd_t pmd_mknotpresent(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
+}
+/*
+ * For radix we should always find H_PAGE_HASHPTE zero. Hence
+ * the below will work for radix too
+ */
+static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pmd_t *pmdp)
+{
+	unsigned long old;
+
+	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
+		return 0;
+	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
+	return ((old & _PAGE_ACCESSED) != 0);
+}
+
+#define __HAVE_ARCH_PMDP_SET_WRPROTECT
+static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pmd_t *pmdp)
+{
+
+	if ((pmd_val(*pmdp) & _PAGE_WRITE) == 0)
+		return;
+
+	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
+}
+
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	if (radix_enabled())
+		return rpmd_trans_huge(pmd);
+	return hlpmd_trans_huge(pmd);
+}
+
+#define __HAVE_ARCH_PMD_SAME
+static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	if (radix_enabled())
+		return rpmd_same(pmd_a, pmd_b);
+	return hlpmd_same(pmd_a, pmd_b);
+}
+
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	if (radix_enabled())
+		return rpmd_mkhuge(pmd);
+	return hlpmd_mkhuge(pmd);
+}
+
 #define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 extern int pmdp_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp,
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 53299182dba9..ad9c77399aab 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -72,7 +72,7 @@ config PPC_BOOK3S_64
 	select PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
 	select SYS_SUPPORTS_HUGETLBFS
-	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if PPC_64K_PAGES
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select IRQ_WORK
 
-- 
2.5.0
