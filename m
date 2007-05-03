Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 962ECDDF3D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 22:27:34 +1000 (EST)
Subject: [PATCH] powerpc: dart iommu suspend
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1178195106.13233.108.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178195106.13233.108.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 03 May 2007 14:28:32 +0200
Message-Id: <1178195312.13233.111.camel@johannes.berg>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
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
Cc: Paul Mackeras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>

---
 arch/powerpc/sysdev/dart_iommu.c |   46 +++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/iommu.h      |   14 +++++++++++
 include/asm-powerpc/machdep.h    |    5 ++++
 3 files changed, 65 insertions(+)

--- wireless-dev.orig/arch/powerpc/sysdev/dart_iommu.c	2007-05-03 14:20:26.089165535 +0200
+++ wireless-dev/arch/powerpc/sysdev/dart_iommu.c	2007-05-03 14:21:08.889165535 +0200
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
 	set_pci_dma_ops(&dma_direct_ops);
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
--- wireless-dev.orig/include/asm-powerpc/iommu.h	2007-05-03 14:20:26.109165535 +0200
+++ wireless-dev/include/asm-powerpc/iommu.h	2007-05-03 14:21:08.889165535 +0200
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
--- wireless-dev.orig/include/asm-powerpc/machdep.h	2007-05-03 14:21:07.569165535 +0200
+++ wireless-dev/include/asm-powerpc/machdep.h	2007-05-03 14:21:08.899165535 +0200
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
