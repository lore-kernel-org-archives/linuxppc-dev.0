Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fBJl64BdzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 17:38:47 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: linux-pci@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common code
Date: Mon, 30 Jul 2018 09:38:42 +0200
Message-Id: <20180730073842.16092-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is nothing arch specific about PCI or dma-debug, so move this
call to common code just after registering the bus type.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma.c | 3 ---
 arch/sh/drivers/pci/pci.c | 2 --
 arch/x86/kernel/pci-dma.c | 3 ---
 drivers/pci/pci-driver.c  | 2 +-
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 155170d70324..dbfc7056d7df 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -357,9 +357,6 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
 
 static int __init dma_init(void)
 {
-#ifdef CONFIG_PCI
-	dma_debug_add_bus(&pci_bus_type);
-#endif
 #ifdef CONFIG_IBMVIO
 	dma_debug_add_bus(&vio_bus_type);
 #endif
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index e5b7437ab4af..8256626bc53c 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -160,8 +160,6 @@ static int __init pcibios_init(void)
 	for (hose = hose_head; hose; hose = hose->next)
 		pcibios_scanbus(hose);
 
-	dma_debug_add_bus(&pci_bus_type);
-
 	pci_initialized = 1;
 
 	return 0;
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index ab5d9dd668d2..43f58632f123 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -155,9 +155,6 @@ static int __init pci_iommu_init(void)
 {
 	struct iommu_table_entry *p;
 
-#ifdef CONFIG_PCI
-	dma_debug_add_bus(&pci_bus_type);
-#endif
 	x86_init.iommu.iommu_init();
 
 	for (p = __iommu_table; p < __iommu_table_end; p++) {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6792292b5fc7..bef17c3fca67 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1668,7 +1668,7 @@ static int __init pci_driver_init(void)
 	if (ret)
 		return ret;
 #endif
-
+	dma_debug_add_bus(&pci_bus_type);
 	return 0;
 }
 postcore_initcall(pci_driver_init);
-- 
2.18.0
