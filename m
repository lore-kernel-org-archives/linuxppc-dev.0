Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxg6N4vzDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 06/70] powerpc/mm: Use pte_raw() in pte_same()/pmd_same()
Date: Fri, 29 Apr 2016 23:25:29 +1000
Message-Id: <1461936393-10131-6-git-send-email-mpe@ellerman.id.au>
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

We can avoid doing endian conversions by using pte_raw() in pxx_same().
The swap of the constant (_PAGE_HPTEFLAGS) should be done at compile
time by the compiler.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 2 +-
 arch/powerpc/include/asm/book3s/64/hash.h     | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 0a7956a80a08..f4949f117057 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -272,7 +272,7 @@ static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 #define __HAVE_ARCH_PMD_SAME
 static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 {
-	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
+	return (((pmd_raw(pmd_a) ^ pmd_raw(pmd_b)) & ~cpu_to_be64(_PAGE_HPTEFLAGS)) == 0);
 }
 
 static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 7fc1a9a8169a..22064bd329f2 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -372,7 +372,11 @@ static inline int pgd_bad(pgd_t pgd)
 }
 
 #define __HAVE_ARCH_PTE_SAME
-#define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
+static inline int pte_same(pte_t pte_a, pte_t pte_b)
+{
+	return (((pte_raw(pte_a) ^ pte_raw(pte_b)) & ~cpu_to_be64(_PAGE_HPTEFLAGS)) == 0);
+}
+
 static inline unsigned long pgd_page_vaddr(pgd_t pgd)
 {
 	return (unsigned long)__va(pgd_val(pgd) & ~PGD_MASKED_BITS);
-- 
2.5.0
