Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxc65FqzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 02/70] powerpc/mm: Always use STRICT_MM_TYPECHECKS
Date: Fri, 29 Apr 2016 23:25:25 +1000
Message-Id: <1461936393-10131-2-git-send-email-mpe@ellerman.id.au>
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

Testing done by Paul Mackerras has shown that with a modern compiler
there is no negative effect on code generation from enabling
STRICT_MM_TYPECHECKS.

So remove the option, and always use the strict type definitions.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug               |  8 ------
 arch/powerpc/include/asm/pgtable-types.h | 46 --------------------------------
 2 files changed, 54 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 638f9ce740f5..d3fcf7e64e3a 100644
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
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index 43140f8b0592..1464e74178d8 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -1,9 +1,6 @@
 #ifndef _ASM_POWERPC_PGTABLE_TYPES_H
 #define _ASM_POWERPC_PGTABLE_TYPES_H
 
-#ifdef CONFIG_STRICT_MM_TYPECHECKS
-/* These are used to make use of C type-checking. */
-
 /* PTE level */
 typedef struct { pte_basic_t pte; } pte_t;
 #define __pte(x)	((pte_t) { (x) })
@@ -48,49 +45,6 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) })
 
-#else
-
-/*
- * .. while these make it easier on the compiler
- */
-
-typedef pte_basic_t pte_t;
-#define __pte(x)	(x)
-static inline pte_basic_t pte_val(pte_t pte)
-{
-	return pte;
-}
-
-#ifdef CONFIG_PPC64
-typedef unsigned long pmd_t;
-#define __pmd(x)	(x)
-static inline unsigned long pmd_val(pmd_t pmd)
-{
-	return pmd;
-}
-
-#if defined(CONFIG_PPC_BOOK3S_64) || !defined(CONFIG_PPC_64K_PAGES)
-typedef unsigned long pud_t;
-#define __pud(x)	(x)
-static inline unsigned long pud_val(pud_t pud)
-{
-	return pud;
-}
-#endif /* CONFIG_PPC_BOOK3S_64 || !CONFIG_PPC_64K_PAGES */
-#endif /* CONFIG_PPC64 */
-
-typedef unsigned long pgd_t;
-#define __pgd(x)	(x)
-static inline unsigned long pgd_val(pgd_t pgd)
-{
-	return pgd;
-}
-
-typedef unsigned long pgprot_t;
-#define pgprot_val(x)	(x)
-#define __pgprot(x)	(x)
-
-#endif /* CONFIG_STRICT_MM_TYPECHECKS */
 /*
  * With hash config 64k pages additionally define a bigger "real PTE" type that
  * gathers the "second half" part of the PTE for pseudo 64k pages
-- 
2.5.0
