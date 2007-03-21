Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB5ECDDEC9
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 23:12:43 +1100 (EST)
Message-Id: <20070321104211.195653000@sipsolutions.net>
References: <20070321104037.696668000@sipsolutions.net>
Date: Wed, 21 Mar 2007 11:40:40 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 3/6] powerpc: dart iommu suspend
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This implements save and restore hooks for IOMMUs and implements
it the dart iommu.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 arch/powerpc/sysdev/dart_iommu.c |   46 +++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/iommu.h      |   14 +++++++++++
 include/asm-powerpc/machdep.h    |    5 ++++
 3 files changed, 65 insertions(+)

--- linux-2.6-git.orig/arch/powerpc/sysdev/dart_iommu.c	2007-03-21 09:22:31.555847391 +0100
+++ linux-2.6-git/arch/powerpc/sysdev/dart_iommu.c	2007-03-21 09:23:03.801847391 +0100
@@ -36,6 +36,7 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
+#include <linux/suspend.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/iommu.h>
@@ -54,6 +55,9 @@ static unsigned long dart_tablesize;
 
 /* Virtual base address of the DART table */
 static u32 *dart_vbase;
+#ifdef CONFIG_PM
+static u32 *dart_copy;
+#endif
 
 /* Mapped base address for the dart */
 static unsigned int __iomem *dart;
@@ -346,6 +350,48 @@ void iommu_init_early_dart(void)
 	pci_dma_ops = &dma_direct_ops;
 }
 
+#ifdef CONFIG_PM
+static void iommu_dart_save(void)
+{
+	memcpy(dart_copy, dart_vbase, 2*1024*1024);
+}
+
+static void iommu_dart_restore(void)
+{
+	memcpy(dart_vbase, dart_copy, 2*1024*1024);
+	dart_tlb_invalidate_all();
+}
+
+static int __init iommu_init_late_dart(void)
+{
+	unsigned long tbasepfn;
+	struct page *p;
+
+	/* if no dart table exists then we won't need to save it
+	 * and the area has also not been reserved */
+	if (!dart_tablebase)
+		return 0;
+
+	tbasepfn = __pa(dart_tablebase) >> PAGE_SHIFT;
+	register_nosave_region_late(tbasepfn,
+				    tbasepfn + ((1<<24) >> PAGE_SHIFT));
+
+	/* For suspend we need to copy the dart contents because
+	 * it is not part of the regular mapping (see above) and
+	 * thus not saved automatically. The memory for this copy
+	 * must be allocated early because we need 2 MB. */
+	p = alloc_pages(GFP_KERNEL, 21 - PAGE_SHIFT);
+	BUG_ON(!p);
+	dart_copy = page_address(p);
+
+	ppc_md.iommu_save = iommu_dart_save;
+	ppc_md.iommu_restore = iommu_dart_restore;
+
+	return 0;
+}
+
+late_initcall(iommu_init_late_dart);
+#endif
 
 void __init alloc_dart_table(void)
 {
--- linux-2.6-git.orig/include/asm-powerpc/iommu.h	2007-03-21 09:22:31.584847391 +0100
+++ linux-2.6-git/include/asm-powerpc/iommu.h	2007-03-21 09:23:03.803847391 +0100
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <asm/machdep.h>
 #include <asm/types.h>
 #include <asm/bitops.h>
 
@@ -109,6 +110,19 @@ static inline void pci_iommu_init(void) 
 #endif
 
 extern void alloc_dart_table(void);
+#if defined(CONFIG_PPC64) && defined(CONFIG_PM)
+static inline void iommu_save(void)
+{
+	if (ppc_md.iommu_save)
+		ppc_md.iommu_save();
+}
+
+static inline void iommu_restore(void)
+{
+	if (ppc_md.iommu_restore)
+		ppc_md.iommu_restore();
+}
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
--- linux-2.6-git.orig/include/asm-powerpc/machdep.h	2007-03-21 09:23:02.283847391 +0100
+++ linux-2.6-git/include/asm-powerpc/machdep.h	2007-03-21 09:23:03.805847391 +0100
@@ -91,6 +91,11 @@ struct machdep_calls {
 	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
 				   unsigned long flags);
 	void		(*iounmap)(volatile void __iomem *token);
+
+#ifdef CONFIG_PM
+	void		(*iommu_save)(void);
+	void		(*iommu_restore)(void);
+#endif
 #endif /* CONFIG_PPC64 */
 
 	int		(*probe)(void);

--
