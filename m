Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6D60DE02B
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 00:00:54 +1100 (EST)
Message-Id: <20070207124610.972565000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Date: Wed, 07 Feb 2007 13:45:39 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/12] powerpc: dart iommu suspend
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, Paul Mackeras <paulus@samba.org>,
	linux-pm@lists.osdl.org
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
The quick patch I posted w/o testing of course didn't work. This one does.

--- linux-2.6-git.orig/arch/powerpc/sysdev/dart_iommu.c	2007-02-07 02:55:03.607884289 +0100
+++ linux-2.6-git/arch/powerpc/sysdev/dart_iommu.c	2007-02-07 02:55:29.073884289 +0100
@@ -54,6 +54,9 @@ static unsigned long dart_tablesize;
 
 /* Virtual base address of the DART table */
 static u32 *dart_vbase;
+#ifdef CONFIG_PM
+static u32 *dart_copy;
+#endif
 
 /* Mapped base address for the dart */
 static unsigned int __iomem *dart;
@@ -346,6 +349,49 @@ void iommu_init_early_dart(void)
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
+static int iommu_init_late_dart(void)
+{
+	unsigned long i, tbase = (unsigned long) dart_tablebase;
+	struct page *p;
+
+	/* this 16MB area is left unmapped because of caching
+	 * considerations. that happens early so we can't mark
+	 * it there, do it now instead */
+	for (i = 0; i < (1<<24); i+= PAGE_SIZE)
+		SetPageNosave(virt_to_page((void*)(tbase + i)));
+
+	/* if no dart table exists then we don't need to save it */
+	if (!dart_tablebase)
+		return 0;
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
--- linux-2.6-git.orig/include/asm-powerpc/iommu.h	2007-02-07 02:55:03.635884289 +0100
+++ linux-2.6-git/include/asm-powerpc/iommu.h	2007-02-07 02:55:29.099884289 +0100
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <asm/machdep.h>
 #include <asm/types.h>
 #include <asm/bitops.h>
 
@@ -108,6 +109,19 @@ static inline void pci_iommu_init(void) 
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
--- linux-2.6-git.orig/include/asm-powerpc/machdep.h	2007-02-07 02:55:03.698884289 +0100
+++ linux-2.6-git/include/asm-powerpc/machdep.h	2007-02-07 02:55:29.108884289 +0100
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
