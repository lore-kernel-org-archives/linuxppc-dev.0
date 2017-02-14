Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMmFQ4bx4zDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 13:14:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
	arbab@linux.vnet.ibm.com
Subject: [PATCH] powerpc/mm: Fix build break with RADIX=y & HUGETLBFS=n
Date: Tue, 14 Feb 2017 13:14:11 +1100
Message-Id: <1487038451-6119-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we enable RADIX but disable HUGETLBFS, the build breaks with:

  arch/powerpc/mm/pgtable-radix.c:557:7: error: implicit declaration of function 'pmd_huge'
  arch/powerpc/mm/pgtable-radix.c:588:7: error: implicit declaration of function 'pud_huge'

Fix it by stubbing those functions when HUGETLBFS=n.

Fixes: 4b5d62ca17a1 ("powerpc/mm: add radix__remove_section_mapping()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h  | 5 +++++
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index 9db83b4e017d..8708a0239a56 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -47,7 +47,12 @@ static inline int hugepd_ok(hugepd_t hpd)
 	return hash__hugepd_ok(hpd);
 }
 #define is_hugepd(hpd)		(hugepd_ok(hpd))
+
+#else /* !CONFIG_HUGETLB_PAGE */
+static inline int pmd_huge(pmd_t pmd) { return 0; }
+static inline int pud_huge(pud_t pud) { return 0; }
 #endif /* CONFIG_HUGETLB_PAGE */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index 198aff33c380..2ce4209399ed 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -46,6 +46,9 @@ static inline int hugepd_ok(hugepd_t hpd)
 }
 #define is_hugepd(pdep)			0
 
+#else /* !CONFIG_HUGETLB_PAGE */
+static inline int pmd_huge(pmd_t pmd) { return 0; }
+static inline int pud_huge(pud_t pud) { return 0; }
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
-- 
2.7.4
