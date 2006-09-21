Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 21 Sep 2006 18:21:35 +1000
Subject: [PATCH] Remove DISCONTIGMEM cruft from page.h
Message-Id: <20060921082136.4D30667BDD@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This looks like cruft to me, these functions don't exist AFAICT,
and I can't see that it's possible to even enable DISCONTIGMEM on
powerpc anymore. CC'ing some folks who might know better, based on
the who-touched-it-last principle.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 include/asm-powerpc/page.h |    6 ------
 1 file changed, 6 deletions(-)

Index: to-merge/include/asm-powerpc/page.h
===================================================================
--- to-merge.orig/include/asm-powerpc/page.h
+++ to-merge/include/asm-powerpc/page.h
@@ -55,12 +55,6 @@
 #define PAGE_OFFSET     ASM_CONST(CONFIG_KERNEL_START)
 #define KERNELBASE      (PAGE_OFFSET + PHYSICAL_START)
 
-#ifdef CONFIG_DISCONTIGMEM
-#define page_to_pfn(page)	discontigmem_page_to_pfn(page)
-#define pfn_to_page(pfn)	discontigmem_pfn_to_page(pfn)
-#define pfn_valid(pfn)		discontigmem_pfn_valid(pfn)
-#endif
-
 #ifdef CONFIG_FLATMEM
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #endif
