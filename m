Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmMC3n9bzDqKF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:17:11 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 02:17:09 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 290F538C803B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:17:07 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396H7bx36241416
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:17:07 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396H6ml014086
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:17:06 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 61/68] powerpc/mm/radix: Add hugetlb support 4K page size
Date: Sat,  9 Apr 2016 11:43:57 +0530
Message-Id: <1460182444-2468-62-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We have hugepage at the pmd level with 4K radix config. Hence we don't
need to use hugepd format with radix.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h    | 22 +-----------
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h | 46 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 99f360e0ecb0..bb3d8539bb1b 100644
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
+static inline int hl_hugepd_ok(hugepd_t hpd)
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
index 423735f897f5..9860e769099f 100644
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
+	return hl_hugepd_ok(hpd);
+}
+#define is_hugepd(hpd)		(hugepd_ok(hpd))
+#endif /* CONFIG_HUGETLB_PAGE */
+#endif /* __ASSEMBLY__ */
 
 #endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_4K_H */
-- 
2.5.0
