Return-Path: <anton@samba.org>
Date: Mon, 9 May 2011 17:18:38 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Simplify 4k/64k copy_page logic
Message-ID: <20110509171838.20aca792@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


To make it easier to add optimised versions of copy_page, remove
the 4kB loop for 64kB pages and just do all the work in copy_page.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/include/asm/page_64.h
===================================================================
--- linux-powerpc.orig/arch/powerpc/include/asm/page_64.h	2011-04-24 12:38:26.469653194 +1000
+++ linux-powerpc/arch/powerpc/include/asm/page_64.h	2011-04-24 12:39:27.220773995 +1000
@@ -59,24 +59,7 @@ static __inline__ void clear_page(void *
 	: "ctr", "memory");
 }
 
-extern void copy_4K_page(void *to, void *from);
-
-#ifdef CONFIG_PPC_64K_PAGES
-static inline void copy_page(void *to, void *from)
-{
-	unsigned int i;
-	for (i=0; i < (1 << (PAGE_SHIFT - 12)); i++) {
-		copy_4K_page(to, from);
-		to += 4096;
-		from += 4096;
-	}
-}
-#else /* CONFIG_PPC_64K_PAGES */
-static inline void copy_page(void *to, void *from)
-{
-	copy_4K_page(to, from);
-}
-#endif /* CONFIG_PPC_64K_PAGES */
+extern void copy_page(void *to, void *from);
 
 /* Log 2 of page table size */
 extern u64 ppc64_pft_size;
Index: linux-powerpc/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/ppc_ksyms.c	2011-04-24 12:38:26.489653562 +1000
+++ linux-powerpc/arch/powerpc/kernel/ppc_ksyms.c	2011-04-24 12:39:27.220773995 +1000
@@ -54,7 +54,6 @@ extern void single_step_exception(struct
 extern int sys_sigreturn(struct pt_regs *regs);
 
 EXPORT_SYMBOL(clear_pages);
-EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
@@ -88,9 +87,7 @@ EXPORT_SYMBOL(__copy_tofrom_user);
 EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
-#ifdef CONFIG_PPC64
-EXPORT_SYMBOL(copy_4K_page);
-#endif
+EXPORT_SYMBOL(copy_page);
 
 #if defined(CONFIG_PCI) && defined(CONFIG_PPC32)
 EXPORT_SYMBOL(isa_io_base);
Index: linux-powerpc/arch/powerpc/lib/copypage_64.S
===================================================================
--- linux-powerpc.orig/arch/powerpc/lib/copypage_64.S	2011-04-24 12:38:26.449652824 +1000
+++ linux-powerpc/arch/powerpc/lib/copypage_64.S	2011-04-24 14:28:05.471401998 +1000
@@ -6,6 +6,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+#include <asm/page.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
@@ -15,9 +16,9 @@ PPC64_CACHES:
         .tc             ppc64_caches[TC],ppc64_caches
         .section        ".text"
 
-
-_GLOBAL(copy_4K_page)
-	li	r5,4096		/* 4K page size */
+_GLOBAL(copy_page)
+	lis	r5,PAGE_SIZE@h
+	ori	r5,r5,PAGE_SIZE@l
 BEGIN_FTR_SECTION
 	ld      r10,PPC64_CACHES@toc(r2)
 	lwz	r11,DCACHEL1LOGLINESIZE(r10)	/* log2 of cache line size */
