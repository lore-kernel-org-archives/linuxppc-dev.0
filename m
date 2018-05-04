Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40crzg6XQ6zDqw8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:34:07 +1000 (AEST)
Message-Id: <dbbb7947bd65de0636f55711c1f3c024a1a43429.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  06/17] powerpc: common ioremap functions.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:34:02 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__ioremap(), ioremap(), ioremap_wc() et ioremap_prot() are
very similar between PPC32 and PPC64, they can easily be
made common.

_PAGE_WRITE equals to _PAGE_RW on PPC32
_PAGE_RO and _PAGE_HWWRITE are 0 on PPC64

iounmap() can also be made common by renamig the PPC32
iounmap() as __iounmap()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
 arch/powerpc/include/asm/machdep.h           |  2 +-
 arch/powerpc/mm/ioremap.c                    | 95 +++++++++-------------------
 3 files changed, 31 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 47b5ffc8715d..c5c6ead06bfb 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -17,6 +17,7 @@
 #define _PAGE_NA		0
 #define _PAGE_RO		0
 #define _PAGE_USER		0
+#define _PAGE_HWWRITE		0
 
 #define _PAGE_EXEC		0x00001 /* execute permission */
 #define _PAGE_WRITE		0x00002 /* write access allowed */
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index ffe7c71e1132..84d99ed82d5d 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -33,11 +33,11 @@ struct pci_host_bridge;
 
 struct machdep_calls {
 	char		*name;
-#ifdef CONFIG_PPC64
 	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
 				   unsigned long flags, void *caller);
 	void		(*iounmap)(volatile void __iomem *token);
 
+#ifdef CONFIG_PPC64
 #ifdef CONFIG_PM
 	void		(*iommu_save)(void);
 	void		(*iommu_restore)(void);
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 5d2645193568..f8dc9638c598 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -23,6 +23,7 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
+#include <asm/machdep.h>
 
 #include "mmu_decl.h"
 
@@ -32,44 +33,6 @@ unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 void __iomem *
-ioremap(phys_addr_t addr, unsigned long size)
-{
-	return __ioremap_caller(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED,
-				__builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap);
-
-void __iomem *
-ioremap_wc(phys_addr_t addr, unsigned long size)
-{
-	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
-				__builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_wc);
-
-void __iomem *
-ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
-{
-	/* writeable implies dirty for kernel addresses */
-	if ((flags & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO)
-		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
-
-	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
-	flags &= ~(_PAGE_USER | _PAGE_EXEC);
-	flags |= _PAGE_PRIVILEGED;
-
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_prot);
-
-void __iomem *
-__ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
-{
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
-}
-EXPORT_SYMBOL(__ioremap);
-
-void __iomem *
 __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 		 void *caller)
 {
@@ -153,7 +116,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
 }
 
-void iounmap(volatile void __iomem *addr)
+void __iounmap(volatile void __iomem *addr)
 {
 	/*
 	 * If mapped by BATs then there is nothing to do.
@@ -165,7 +128,7 @@ void iounmap(volatile void __iomem *addr)
 	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
 		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
 }
-EXPORT_SYMBOL(iounmap);
+EXPORT_SYMBOL(__iounmap);
 
 #else
 
@@ -264,6 +227,30 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	return ret;
 }
 
+/*
+ * Unmap an IO region and remove it from imalloc'd list.
+ * Access to IO memory should be serialized by driver.
+ */
+void __iounmap(volatile void __iomem *token)
+{
+	void *addr;
+
+	if (!slab_is_available())
+		return;
+
+	addr = (void *) ((unsigned long __force)
+			 PCI_FIX_ADDR(token) & PAGE_MASK);
+	if ((unsigned long)addr < ioremap_bot) {
+		printk(KERN_WARNING "Attempt to iounmap early bolted mapping"
+		       " at 0x%p\n", addr);
+		return;
+	}
+	vunmap(addr);
+}
+EXPORT_SYMBOL(__iounmap);
+
+#endif
+
 void __iomem * __ioremap(phys_addr_t addr, unsigned long size,
 			 unsigned long flags)
 {
@@ -299,8 +286,8 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 	void *caller = __builtin_return_address(0);
 
 	/* writeable implies dirty for kernel addresses */
-	if (flags & _PAGE_WRITE)
-		flags |= _PAGE_DIRTY;
+	if ((flags & (_PAGE_WRITE | _PAGE_RO)) != _PAGE_RO)
+		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
 
 	/* we don't want to let _PAGE_EXEC leak out */
 	flags &= ~_PAGE_EXEC;
@@ -316,28 +303,6 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 }
 EXPORT_SYMBOL(ioremap_prot);
 
-/*
- * Unmap an IO region and remove it from imalloc'd list.
- * Access to IO memory should be serialized by driver.
- */
-void __iounmap(volatile void __iomem *token)
-{
-	void *addr;
-
-	if (!slab_is_available())
-		return;
-
-	addr = (void *) ((unsigned long __force)
-			 PCI_FIX_ADDR(token) & PAGE_MASK);
-	if ((unsigned long)addr < ioremap_bot) {
-		printk(KERN_WARNING "Attempt to iounmap early bolted mapping"
-		       " at 0x%p\n", addr);
-		return;
-	}
-	vunmap(addr);
-}
-EXPORT_SYMBOL(__iounmap);
-
 void iounmap(volatile void __iomem *token)
 {
 	if (ppc_md.iounmap)
@@ -346,5 +311,3 @@ void iounmap(volatile void __iomem *token)
 		__iounmap(token);
 }
 EXPORT_SYMBOL(iounmap);
-
-#endif
-- 
2.13.3
