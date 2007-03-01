Return-Path: <michael@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 01 Mar 2007 15:11:31 +0900
Subject: [PATCH] Allow spufs to build as a module with slices enabled
In-Reply-To: <20070220074433.96AAEDDDEC@ozlabs.org>
Message-Id: <20070301061134.0B4B2DDEC1@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The slice code is missing some exports to allow spufs to build as a
module. Add them.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 MODPOST 209 modules
WARNING: ".get_slice_psize" [arch/powerpc/platforms/cell/spufs/spufs.ko] undefined!
WARNING: ".slice_get_unmapped_area" [arch/powerpc/platforms/cell/spufs/spufs.ko] undefined!

---
 arch/powerpc/mm/slice.c |    3 +++
 1 file changed, 3 insertions(+)

Index: ecell/arch/powerpc/mm/slice.c
===================================================================
--- ecell.orig/arch/powerpc/mm/slice.c
+++ ecell/arch/powerpc/mm/slice.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/err.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
 #include <asm/mman.h>
 #include <asm/mmu.h>
 #include <asm/spu.h>
@@ -499,6 +500,7 @@ unsigned long slice_get_unmapped_area(un
 	return addr;
 
 }
+EXPORT_SYMBOL(slice_get_unmapped_area);
 
 unsigned long arch_get_unmapped_area(struct file *filp,
 				     unsigned long addr,
@@ -537,6 +539,7 @@ unsigned int get_slice_psize(struct mm_s
 
 	return (psizes >> (index * 4)) & 0xf;
 }
+EXPORT_SYMBOL(get_slice_psize);
 
 /*
  * This is called by hash_page when it needs to do a lazy conversion of
