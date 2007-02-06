Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FCC5DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 12:56:22 +1100 (EST)
Subject: Re: [RFC 08/10] powerpc: dart iommu suspend
From: Johannes Berg <johannes@sipsolutions.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070206011949.GA15434@lixom.net>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.029827000@sipsolutions.net>
	<20070206011949.GA15434@lixom.net>
Content-Type: text/plain
Date: Tue, 06 Feb 2007 02:52:47 +0100
Message-Id: <1170726767.30959.30.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org,
	Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

How's this? Needs to go along with the correct changes in the code that
uses it, of course.

I can't use a local void * as you suggested because it needs to be added
to as an unsigned long, but I can use a local unsigned long.

Not even compiled yet.

Btw. What does TCE stand for?

--- mb-wireless.orig/arch/powerpc/sysdev/dart_iommu.c	2007-02-06 02:45:34.464524763 +0100
+++ mb-wireless/arch/powerpc/sysdev/dart_iommu.c	2007-02-06 02:48:40.784524763 +0100
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
+static void iommu_dart_suspend(void)
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
+	ppc_md.iommu_suspend = iommu_dart_suspend;
+	ppc_md.iommu_resume = iommu_dart_resume;
+
+	return 0;
+}
+
+late_initcall(iommu_init_late_dart);
+#endif
 
 void __init alloc_dart_table(void)
 {
--- mb-wireless.orig/include/asm-powerpc/iommu.h	2007-02-06 02:45:34.524524763 +0100
+++ mb-wireless/include/asm-powerpc/iommu.h	2007-02-06 02:46:28.964524763 +0100
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
+#ifdef CONFIG_PM
+static inline void iommu_suspend(void)
+{
+	if (ppc_md.iommu_suspend)
+		ppc_md.iommu_suspend();
+}
+
+static inline void iommu_restore(void)
+{
+	if (ppc_md.iommu_resume)
+		ppc_md.iommu_resume();
+}
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
--- mb-wireless.orig/include/asm-powerpc/machdep.h	2007-02-06 02:45:34.584524763 +0100
+++ mb-wireless/include/asm-powerpc/machdep.h	2007-02-06 02:46:10.834524763 +0100
@@ -91,6 +91,11 @@ struct machdep_calls {
 	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
 				   unsigned long flags);
 	void		(*iounmap)(volatile void __iomem *token);
+
+#ifdef CONFIG_PM
+	void		(*iommu_suspend)(void);
+	void		(*iommu_resume)(void);
+#endif
 #endif /* CONFIG_PPC64 */
 
 	int		(*probe)(void);
