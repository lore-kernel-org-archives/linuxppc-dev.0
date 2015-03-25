Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B449C1A0171
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:12:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [RFC PATCH 6/6] powerpc: Always enable STRICT_MM_TYPECHECKS
Date: Wed, 25 Mar 2015 20:11:59 +1100
Message-Id: <1427274719-25890-6-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
References: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
Cc: aneesh.kumar@in.ibm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The argument for making this an option was that gcc produced inferior
code with it enabled. That doesn't seem to be the case anymore (gcc
4.9), so turn it on always.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug               |  8 -------
 arch/powerpc/include/asm/page.h          | 40 --------------------------------
 arch/powerpc/include/asm/pgtable-ppc64.h |  5 ----
 3 files changed, 53 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 777108f4acab..ec2e40f2cc11 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -19,14 +19,6 @@ config PPC_WERROR
 	depends on !PPC_DISABLE_WERROR
 	default y
 
-config STRICT_MM_TYPECHECKS
-	bool "Do extra type checking on mm types"
-	default n
-	help
-	  This option turns on extra type checking for some mm related types.
-
-	  If you don't know what this means, say N.
-
 config PRINT_STACK_DEPTH
 	int "Stack depth to print" if DEBUG_KERNEL
 	default 64
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 71294a6e976e..6af9514106ab 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -278,7 +278,6 @@ extern long long virt_phys_offset;
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_STRICT_MM_TYPECHECKS
 /* These are used to make use of C type-checking. */
 
 /* PTE level */
@@ -319,45 +318,6 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) })
 
-#else
-
-/*
- * .. while these make it easier on the compiler
- */
-
-typedef pte_basic_t pte_t;
-#define pte_val(x)	(x)
-#define __pte(x)	(x)
-
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
-typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
-#else
-typedef pte_t real_pte_t;
-#endif
-
-
-#ifdef CONFIG_PPC64
-typedef unsigned long pmd_t;
-#define pmd_val(x)	(x)
-#define __pmd(x)	(x)
-
-#ifndef CONFIG_PPC_64K_PAGES
-typedef unsigned long pud_t;
-#define pud_val(x)	(x)
-#define __pud(x)	(x)
-#endif /* !CONFIG_PPC_64K_PAGES */
-#endif /* CONFIG_PPC64 */
-
-typedef unsigned long pgd_t;
-#define pgd_val(x)	(x)
-#define pgprot_val(x)	(x)
-
-typedef unsigned long pgprot_t;
-#define __pgd(x)	(x)
-#define __pgprot(x)	(x)
-
-#endif
-
 typedef struct { signed long pd; } hugepd_t;
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index f951d9cf358a..4fa3035d8449 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -118,13 +118,8 @@
  */
 #ifndef __real_pte
 
-#ifdef CONFIG_STRICT_MM_TYPECHECKS
 #define __real_pte(e,p)		((real_pte_t){(e)})
 #define __rpte_to_pte(r)	((r).pte)
-#else
-#define __real_pte(e,p)		(e)
-#define __rpte_to_pte(r)	(__pte(r))
-#endif
 #define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> 12)
 
 #define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
-- 
2.1.0
