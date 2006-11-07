Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Nov 2006 18:23:01 +1100
Subject: [PATCH 29/31] powerpc: remove ioremap64 and fixup_bigphys_addr
In-Reply-To: <1162884150.435786.961370643810.qpush@grosgo>
Message-Id: <20061107072419.2165E6837E@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In order to suppose platforms with devices above 4Gb on 32 bits platforms
with a >32 bits physical address space, we used to have a special ioremap64
along with a fixup routine fixup_bigphys_addr.

This shouldn't be necessary anymore as struct resource now supports 64 bits
addresses even on 32 bits archs. This patch enables that option when
CONFIG_PHYS_64BIT is set and removes ioremap64 and fixup_bigphys_addr.

This is a preliminary work for the upcoming merge of 32 and 64 bits io.h

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/Kconfig               |    1 +
 arch/powerpc/mm/pgtable_32.c       |   17 -----------------
 arch/powerpc/platforms/85xx/misc.c |    8 --------
 3 files changed, 1 insertion(+), 25 deletions(-)

Index: linux-cell/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/pgtable_32.c	2006-11-06 15:18:35.000000000 +1100
+++ linux-cell/arch/powerpc/mm/pgtable_32.c	2006-11-06 15:55:37.000000000 +1100
@@ -141,28 +141,11 @@ void pte_free(struct page *ptepage)
 	__free_page(ptepage);
 }
 
-#ifndef CONFIG_PHYS_64BIT
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
 	return __ioremap(addr, size, _PAGE_NO_CACHE);
 }
-#else /* CONFIG_PHYS_64BIT */
-void __iomem *
-ioremap64(unsigned long long addr, unsigned long size)
-{
-	return __ioremap(addr, size, _PAGE_NO_CACHE);
-}
-EXPORT_SYMBOL(ioremap64);
-
-void __iomem *
-ioremap(phys_addr_t addr, unsigned long size)
-{
-	phys_addr_t addr64 = fixup_bigphys_addr(addr, size);
-
-	return ioremap64(addr64, size);
-}
-#endif /* CONFIG_PHYS_64BIT */
 EXPORT_SYMBOL(ioremap);
 
 void __iomem *
Index: linux-cell/arch/powerpc/platforms/85xx/misc.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/85xx/misc.c	2006-11-06 15:18:35.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/85xx/misc.c	2006-11-06 15:55:37.000000000 +1100
@@ -21,11 +21,3 @@ void mpc85xx_restart(char *cmd)
 	local_irq_disable();
 	abort();
 }
-
-/* For now this is a pass through */
-phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)
-{
-	return addr;
-};
-
-EXPORT_SYMBOL(fixup_bigphys_addr);
Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2006-11-06 15:55:34.000000000 +1100
+++ linux-cell/arch/powerpc/Kconfig	2006-11-06 15:55:37.000000000 +1100
@@ -247,6 +247,7 @@ config PTE_64BIT
 config PHYS_64BIT
 	bool 'Large physical address support' if E500
 	depends on 44x || E500
+	select RESOURCES_64BIT
 	default y if 44x
 	---help---
 	  This option enables kernel support for larger than 32-bit physical
