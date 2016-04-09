Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmMV0PnjzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:17:25 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 02:17:23 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C37CD38C8041
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:17:21 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396HLIq44433486
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:17:21 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396HLBZ026267
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:17:21 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 66/68] powerpc/mm/radix: Add THP support for 4k linux page
 size
Date: Sat,  9 Apr 2016 11:44:02 +0530
Message-Id: <1460182444-2468-67-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/hash-4k.h     | 59 ++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 25 ----------
 arch/powerpc/include/asm/book3s/64/pgtable.h     | 22 +++++++++
 arch/powerpc/platforms/Kconfig.cputype           |  2 +-
 4 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index bb3d8539bb1b..d915788d5074 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -50,6 +50,65 @@ static inline int hl_hugepd_ok(hugepd_t hpd)
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
index c56fd1872646..888c25a491b0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -53,31 +53,6 @@ static inline int hugepd_ok(hugepd_t hpd)
 
 #endif /* CONFIG_HUGETLB_PAGE */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
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
index b28139fe0efb..819320848b11 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -876,6 +876,28 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
 }
 
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
