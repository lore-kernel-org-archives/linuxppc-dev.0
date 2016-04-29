Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyg38z3zDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 64/70] powerpc/mm/radix: Add hugetlb support 4K page size
Date: Fri, 29 Apr 2016 23:26:27 +1000
Message-Id: <1461936393-10131-64-git-send-email-mpe@ellerman.id.au>
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

We have hugepage at the pmd level with 4K radix config. Hence we don't
need to use hugepd format with radix.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h    | 22 +-----------
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h | 46 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 99f360e0ecb0..6a10b0d89354 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -37,26 +37,7 @@
 	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE, (prot))
 
 #ifdef CONFIG_HUGETLB_PAGE
-/*
- * For 4k page size, we support explicit hugepage via hugepd
- */
-static inline int pmd_huge(pmd_t pmd)
-{
-	return 0;
-}
-
-static inline int pud_huge(pud_t pud)
-{
-	return 0;
-}
-
-static inline int pgd_huge(pgd_t pgd)
-{
-	return 0;
-}
-#define pgd_huge pgd_huge
-
-static inline int hugepd_ok(hugepd_t hpd)
+static inline int hash__hugepd_ok(hugepd_t hpd)
 {
 	/*
 	 * if it is not a pte and have hugepd shift mask
@@ -67,7 +48,6 @@ static inline int hugepd_ok(hugepd_t hpd)
 		return true;
 	return false;
 }
-#define is_hugepd(hpd)		(hugepd_ok(hpd))
 #endif
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index 423735f897f5..71e9abced493 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -3,5 +3,51 @@
 /*
  * hash 4k can't share hugetlb and also doesn't support THP
  */
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_HUGETLB_PAGE
+static inline int pmd_huge(pmd_t pmd)
+{
+	/*
+	 * leaf pte for huge page
+	 */
+	if (radix_enabled())
+		return !!(pmd_val(pmd) & _PAGE_PTE);
+	return 0;
+}
+
+static inline int pud_huge(pud_t pud)
+{
+	/*
+	 * leaf pte for huge page
+	 */
+	if (radix_enabled())
+		return !!(pud_val(pud) & _PAGE_PTE);
+	return 0;
+}
+
+static inline int pgd_huge(pgd_t pgd)
+{
+	/*
+	 * leaf pte for huge page
+	 */
+	if (radix_enabled())
+		return !!(pgd_val(pgd) & _PAGE_PTE);
+	return 0;
+}
+#define pgd_huge pgd_huge
+/*
+ * With radix , we have hugepage ptes in the pud and pmd entries. We don't
+ * need to setup hugepage directory for them. Our pte and page directory format
+ * enable us to have this enabled.
+ */
+static inline int hugepd_ok(hugepd_t hpd)
+{
+	if (radix_enabled())
+		return 0;
+	return hash__hugepd_ok(hpd);
+}
+#define is_hugepd(hpd)		(hugepd_ok(hpd))
+#endif /* CONFIG_HUGETLB_PAGE */
+#endif /* __ASSEMBLY__ */
 
 #endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_4K_H */
-- 
2.5.0
