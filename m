Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqrc4t3qzDqFb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:40 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:26:38 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DA4243E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:26:36 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u2R8QaFQ43319462
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:26:36 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8QZEG030354
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:26:36 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 59/65] powerpc/mm/radix: Add hugetlb support 4K page size
Date: Sun, 27 Mar 2016 13:54:07 +0530
Message-Id: <1459067053-10835-59-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We have hugepage at the pmd level with 4K radix config. Hence we don't
need to use hugepd format with radix.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h    | 22 +-----------
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h | 46 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 10266ec97a83..4d2ae7fdc4f9 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -36,26 +36,7 @@
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
@@ -66,7 +47,6 @@ static inline int hugepd_ok(hugepd_t hpd)
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
