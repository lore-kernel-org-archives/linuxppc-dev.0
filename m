Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19F441A06DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 15:48:53 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 23:48:52 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 0B6576E803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 23:35:42 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N4mo8H28967148
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 04:48:50 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N4mogq028442
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 23:48:50 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 09/18] powerpc/mm: Copy pgalloc (part 2)
Date: Tue, 23 Feb 2016 10:18:11 +0530
Message-Id: <1456202900-5454-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |  6 +++---
 arch/powerpc/include/asm/book3s/64/pgalloc.h       | 17 ++++++++++------
 arch/powerpc/include/asm/book3s/pgalloc.h          | 19 ++++++++++++++++++
 .../asm/{pgalloc-32.h => nohash/32/pgalloc.h}      |  0
 .../asm/{pgalloc-64.h => nohash/64/pgalloc.h}      |  0
 arch/powerpc/include/asm/nohash/pgalloc.h          | 23 ++++++++++++++++++++++
 arch/powerpc/include/asm/pgalloc.h                 | 19 +++---------------
 7 files changed, 59 insertions(+), 25 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/pgalloc.h
 rename arch/powerpc/include/asm/{pgalloc-32.h => nohash/32/pgalloc.h} (100%)
 rename arch/powerpc/include/asm/{pgalloc-64.h => nohash/64/pgalloc.h} (100%)
 create mode 100644 arch/powerpc/include/asm/nohash/pgalloc.h

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 76d6b9e0c8a9..a2350194fc76 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PGALLOC_32_H
-#define _ASM_POWERPC_PGALLOC_32_H
+#ifndef _ASM_POWERPC_BOOK3S_32_PGALLOC_H
+#define _ASM_POWERPC_BOOK3S_32_PGALLOC_H
 
 #include <linux/threads.h>
 
@@ -106,4 +106,4 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	pgtable_page_dtor(table);
 	pgtable_free_tlb(tlb, page_address(table), 0);
 }
-#endif /* _ASM_POWERPC_PGALLOC_32_H */
+#endif /* _ASM_POWERPC_BOOK3S_32_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 8d5fc3ac43da..54017260c8bf 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PGALLOC_64_H
-#define _ASM_POWERPC_PGALLOC_64_H
+#ifndef _ASM_POWERPC_BOOK3S_64_PGALLOC_H
+#define _ASM_POWERPC_BOOK3S_64_PGALLOC_H
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -52,8 +52,10 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 }
 
 #ifndef CONFIG_PPC_64K_PAGES
-
-#define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, __pgtable_ptr_val(PUD))
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
+{
+	pgd_set(pgd, __pgtable_ptr_val(pud));
+}
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
@@ -83,7 +85,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	pmd_set(pmd, __pgtable_ptr_val(page_address(pte_page)));
 }
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
+static inline pgtable_t pmd_pgtable(pmd_t pmd)
+{
+	return pmd_page(pmd);
+}
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
@@ -263,4 +268,4 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 
 #define check_pgt_cache()	do { } while (0)
 
-#endif /* _ASM_POWERPC_PGALLOC_64_H */
+#endif /* _ASM_POWERPC_BOOK3S_64_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/book3s/pgalloc.h b/arch/powerpc/include/asm/book3s/pgalloc.h
new file mode 100644
index 000000000000..54f591e9572e
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/pgalloc.h
@@ -0,0 +1,19 @@
+#ifndef _ASM_POWERPC_BOOK3S_PGALLOC_H
+#define _ASM_POWERPC_BOOK3S_PGALLOC_H
+
+#include <linux/mm.h>
+
+extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
+static inline void tlb_flush_pgtable(struct mmu_gather *tlb,
+				     unsigned long address)
+{
+
+}
+
+#ifdef CONFIG_PPC64
+#include <asm/book3s/64/pgalloc.h>
+#else
+#include <asm/book3s/32/pgalloc.h>
+#endif
+
+#endif /* _ASM_POWERPC_BOOK3S_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/pgalloc-32.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
similarity index 100%
rename from arch/powerpc/include/asm/pgalloc-32.h
rename to arch/powerpc/include/asm/nohash/32/pgalloc.h
diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
similarity index 100%
rename from arch/powerpc/include/asm/pgalloc-64.h
rename to arch/powerpc/include/asm/nohash/64/pgalloc.h
diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
new file mode 100644
index 000000000000..b39ec956d71e
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -0,0 +1,23 @@
+#ifndef _ASM_POWERPC_NOHASH_PGALLOC_H
+#define _ASM_POWERPC_NOHASH_PGALLOC_H
+
+#include <linux/mm.h>
+
+extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
+#ifdef CONFIG_PPC64
+extern void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address);
+#else
+/* 44x etc which is BOOKE not BOOK3E */
+static inline void tlb_flush_pgtable(struct mmu_gather *tlb,
+				     unsigned long address)
+{
+
+}
+#endif /* !CONFIG_PPC_BOOK3E */
+
+#ifdef CONFIG_PPC64
+#include <asm/nohash/64/pgalloc.h>
+#else
+#include <asm/nohash/32/pgalloc.h>
+#endif
+#endif /* _ASM_POWERPC_NOHASH_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index fc3ee06eab87..0413457ba11d 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -1,25 +1,12 @@
 #ifndef _ASM_POWERPC_PGALLOC_H
 #define _ASM_POWERPC_PGALLOC_H
-#ifdef __KERNEL__
 
 #include <linux/mm.h>
 
-#ifdef CONFIG_PPC_BOOK3E
-extern void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address);
-#else /* CONFIG_PPC_BOOK3E */
-static inline void tlb_flush_pgtable(struct mmu_gather *tlb,
-				     unsigned long address)
-{
-}
-#endif /* !CONFIG_PPC_BOOK3E */
-
-extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
-
-#ifdef CONFIG_PPC64
-#include <asm/pgalloc-64.h>
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/book3s/pgalloc.h>
 #else
-#include <asm/pgalloc-32.h>
+#include <asm/nohash/pgalloc.h>
 #endif
 
-#endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PGALLOC_H */
-- 
2.5.0
