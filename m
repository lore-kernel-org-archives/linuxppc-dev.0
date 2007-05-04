Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 May 2007 16:47:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Kill off the PTE_FMT macro
Message-ID: <20070504064751.GB19714@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

32-bit powerpc uses a PTE_FMT macro to handle printk() formatting of
PTE entries (which can vary in type and size).  Apparently there was a
good reason for it once, but with current compilers it's simpler just
to workaround the variation with a cast in the printk() itself
(there's only one use).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 include/asm-powerpc/page_32.h       |    2 --
 include/asm-powerpc/pgtable-ppc32.h |    3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: working-2.6/include/asm-powerpc/page_32.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/page_32.h	2007-01-24 12:01:20.000000000 +1100
+++ working-2.6/include/asm-powerpc/page_32.h	2007-05-04 16:42:24.000000000 +1000
@@ -14,11 +14,9 @@
 #ifdef CONFIG_PTE_64BIT
 typedef unsigned long long pte_basic_t;
 #define PTE_SHIFT	(PAGE_SHIFT - 3)	/* 512 ptes per page */
-#define PTE_FMT		"%16Lx"
 #else
 typedef unsigned long pte_basic_t;
 #define PTE_SHIFT	(PAGE_SHIFT - 2)	/* 1024 ptes per page */
-#define PTE_FMT		"%.8lx"
 #endif
 
 struct page;
Index: working-2.6/include/asm-powerpc/pgtable-ppc32.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable-ppc32.h	2007-05-03 10:19:32.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable-ppc32.h	2007-05-04 16:42:24.000000000 +1000
@@ -101,7 +101,8 @@ extern unsigned long ioremap_bot, iorema
 #define KERNEL_PGD_PTRS (PTRS_PER_PGD-USER_PGD_PTRS)
 
 #define pte_ERROR(e) \
-	printk("%s:%d: bad pte "PTE_FMT".\n", __FILE__, __LINE__, pte_val(e))
+	printk("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
+		(unsigned long long)pte_val(e))
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
 #define pgd_ERROR(e) \

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
