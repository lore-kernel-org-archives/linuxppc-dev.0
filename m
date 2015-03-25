Return-Path: <dja@axtens.net>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9BB31A0744
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:49 +1100 (AEDT)
Received: by pagj7 with SMTP id j7so17255631pag.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:48 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/27] powerpc: dart_iommu: optionally populate controller_ops
 on init
Date: Wed, 25 Mar 2015 16:35:47 +1100
Message-Id: <1427261761-22952-14-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a pci_controller_ops struct is provided to iommu_init_early_dart,
populate that with the DMA setup ops, rather than ppc_md. If NULL is
provided, populate ppc_md as before.

This also patches the call sites for Maple and Power Mac to pass
NULL, so existing behaviour is preserved.

The benefit of making this optional is that it means we don't have
to change dart, Maple and Power Mac over to the controller_ops
system in one fell swoop.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/iommu.h        |  3 ++-
 arch/powerpc/platforms/maple/setup.c    |  2 +-
 arch/powerpc/platforms/powermac/setup.c |  2 +-
 arch/powerpc/sysdev/dart_iommu.c        | 16 ++++++++++++----
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index f1ea597..0be7d9e 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -29,6 +29,7 @@
 #include <linux/bitops.h>
 #include <asm/machdep.h>
 #include <asm/types.h>
+#include <asm/pci-bridge.h>
 
 #define IOMMU_PAGE_SHIFT_4K      12
 #define IOMMU_PAGE_SIZE_4K       (ASM_CONST(1) << IOMMU_PAGE_SHIFT_4K)
@@ -169,7 +170,7 @@ extern void iommu_unmap_page(struct iommu_table *tbl, dma_addr_t dma_handle,
 			     struct dma_attrs *attrs);
 
 extern void iommu_init_early_pSeries(void);
-extern void iommu_init_early_dart(void);
+extern void iommu_init_early_dart(struct pci_controller_ops *controller_ops);
 extern void iommu_init_early_pasemi(void);
 
 extern void alloc_dart_table(void);
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 56b85cd..3bf2e03 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -203,7 +203,7 @@ static void __init maple_init_early(void)
 {
 	DBG(" -> maple_init_early\n");
 
-	iommu_init_early_dart();
+	iommu_init_early_dart(NULL);
 
 	DBG(" <- maple_init_early\n");
 }
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index efe172d..71a353c 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -473,7 +473,7 @@ static void __init pmac_init_early(void)
 	udbg_adb_init(!!strstr(boot_command_line, "btextdbg"));
 
 #ifdef CONFIG_PPC64
-	iommu_init_early_dart();
+	iommu_init_early_dart(NULL);
 #endif
 
 	/* SMP Init has to be done early as we need to patch up
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 9e5353f..120e96a 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -369,7 +369,7 @@ static int dart_dma_set_mask(struct device *dev, u64 dma_mask)
 	return 0;
 }
 
-void __init iommu_init_early_dart(void)
+void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 {
 	struct device_node *dn;
 
@@ -395,15 +395,23 @@ void __init iommu_init_early_dart(void)
 	if (dart_is_u4)
 		ppc_md.dma_set_mask = dart_dma_set_mask;
 
-	ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_dart;
-	ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_dart;
-
+	if (controller_ops) {
+		controller_ops->dma_dev_setup = pci_dma_dev_setup_dart;
+		controller_ops->dma_bus_setup = pci_dma_bus_setup_dart;
+	} else {
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_dart;
+		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_dart;
+	}
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_iommu_ops);
 	return;
 
  bail:
 	/* If init failed, use direct iommu and null setup functions */
+	if (controller_ops) {
+		controller_ops->dma_dev_setup = NULL;
+		controller_ops->dma_bus_setup = NULL;
+	}
 	ppc_md.pci_dma_dev_setup = NULL;
 	ppc_md.pci_dma_bus_setup = NULL;
 
-- 
2.1.4
