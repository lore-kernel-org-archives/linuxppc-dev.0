Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyk5pwHzDqBD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 68/70] powerpc/mm/radix: Add THP support for 4K linux page
 size
Date: Fri, 29 Apr 2016 23:26:31 +1000
Message-Id: <1461936393-10131-68-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This adds THP support for 4K Linux page size config with radix. We still
don't do THP with 4K Linux page size and hash page table. Hash page
table needs a 16MB hugepage and we can't do THP with 16MM hugepage and
4K Linux page size.

We add missing functions to 4K hash config to get it to build and
hash__has_transparent_hugepage() makes sure we don't enable THP for 4K
hash config. To catch wrong usage of THP related with 4K config, we add
BUG() in those dummy functions we added to get it compile.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h     | 59 ++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 25 ----------
 arch/powerpc/include/asm/book3s/64/pgtable.h     | 22 +++++++++
 arch/powerpc/platforms/Kconfig.cputype           |  2 +-
 4 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 6a10b0d89354..1af837c561ba 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -50,6 +50,65 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
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
+static inline int hash__pmd_trans_huge(pmd_t pmd)
+{
+	return 0;
+}
+
+static inline int hash__pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	BUG();
+	return 0;
+}
+
+static inline pmd_t hash__pmd_mkhuge(pmd_t pmd)
+{
+	BUG();
+	return pmd;
+}
+
+extern unsigned long hash__pmd_hugepage_update(struct mm_struct *mm,
+					   unsigned long addr, pmd_t *pmdp,
+					   unsigned long clr, unsigned long set);
+extern pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma,
+				   unsigned long address, pmd_t *pmdp);
+extern void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
+					 pgtable_t pgtable);
+extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+extern void hash__pmdp_huge_split_prepare(struct vm_area_struct *vma,
+				      unsigned long address, pmd_t *pmdp);
+extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
+				       unsigned long addr, pmd_t *pmdp);
+extern int hash__has_transparent_hugepage(void);
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index 793ecd5ea301..cb2d0a5fa3f8 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -53,31 +53,6 @@ static inline int hugepd_ok(hugepd_t hpd)
 
 #endif /* CONFIG_HUGETLB_PAGE */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pmd_trans_huge(pmd_t pmd)
-{
-	if (radix_enabled())
-		return radix__pmd_trans_huge(pmd);
-	return hash__pmd_trans_huge(pmd);
-}
-
-#define __HAVE_ARCH_PMD_SAME
-static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
-{
-	if (radix_enabled())
-		return radix__pmd_same(pmd_a, pmd_b);
-	return hash__pmd_same(pmd_a, pmd_b);
-}
-
-static inline pmd_t pmd_mkhuge(pmd_t pmd)
-{
-	if (radix_enabled())
-		return radix__pmd_mkhuge(pmd);
-	return hash__pmd_mkhuge(pmd);
-}
-
-#endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
-
 static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
 			       unsigned long pfn, pgprot_t prot)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 1b09ba0c2d1d..898222ae7b82 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -876,6 +876,28 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
 }
 
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	if (radix_enabled())
+		return radix__pmd_trans_huge(pmd);
+	return hash__pmd_trans_huge(pmd);
+}
+
+#define __HAVE_ARCH_PMD_SAME
+static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	if (radix_enabled())
+		return radix__pmd_same(pmd_a, pmd_b);
+	return hash__pmd_same(pmd_a, pmd_b);
+}
+
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	if (radix_enabled())
+		return radix__pmd_mkhuge(pmd);
+	return hash__pmd_mkhuge(pmd);
+}
+
 #define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 extern int pmdp_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp,
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 8d2cfb8cd64e..77e9b8d591fb 100644
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
