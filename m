Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 328971A05C9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 15:48:47 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 21:48:45 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BF09E19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:36:39 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N4mgoR23789756
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:48:42 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N4mfGa019847
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:48:42 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 05/18] powerpc/mm: Don't have conditional defines for
 real_pte_t
Date: Tue, 23 Feb 2016 10:18:07 +0530
Message-Id: <1456202900-5454-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We remove real_pte_t out of STRICT_MM_TYPESCHECK.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  5 -----
 arch/powerpc/include/asm/pgtable-types.h     | 26 +++++++++-----------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c8240b737d11..7482f69117b6 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -43,13 +43,8 @@
  */
 #ifndef __real_pte
 
-#ifdef CONFIG_STRICT_MM_TYPECHECKS
 #define __real_pte(e,p)		((real_pte_t){(e)})
 #define __rpte_to_pte(r)	((r).pte)
-#else
-#define __real_pte(e,p)		(e)
-#define __rpte_to_pte(r)	(__pte(r))
-#endif
 #define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >>_PAGE_F_GIX_SHIFT)
 
 #define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index 2fac0c4acfa4..71487e1ca638 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -12,15 +12,6 @@ static inline pte_basic_t pte_val(pte_t x)
 	return x.pte;
 }
 
-/* 64k pages additionally define a bigger "real PTE" type that gathers
- * the "second half" part of the PTE for pseudo 64k pages
- */
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
-#else
-typedef struct { pte_t pte; } real_pte_t;
-#endif
-
 /* PMD level */
 #ifdef CONFIG_PPC64
 typedef struct { unsigned long pmd; } pmd_t;
@@ -67,13 +58,6 @@ static inline pte_basic_t pte_val(pte_t pte)
 	return pte;
 }
 
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
-#else
-typedef pte_t real_pte_t;
-#endif
-
-
 #ifdef CONFIG_PPC64
 typedef unsigned long pmd_t;
 #define __pmd(x)	(x)
@@ -103,6 +87,14 @@ typedef unsigned long pgprot_t;
 #define pgprot_val(x)	(x)
 #define __pgprot(x)	(x)
 
+#endif /* CONFIG_STRICT_MM_TYPECHECKS */
+/*
+ * With hash config 64k pages additionally define a bigger "real PTE" type that
+ * gathers the "second half" part of the PTE for pseudo 64k pages
+ */
+#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
+typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
+#else
+typedef struct { pte_t pte; } real_pte_t;
 #endif
-
 #endif /* _ASM_POWERPC_PGTABLE_TYPES_H */
-- 
2.5.0
