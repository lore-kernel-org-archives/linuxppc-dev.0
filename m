Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 58F05DDF3F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 05:15:09 +1100 (EST)
Message-Id: <20071218175104.432538000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:48:57 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 05/18] Add celleb_dma_dev_setup()
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Celleb always uses dma_direct_ops, and sets dma_direct_offset, so it too
should set dma_data to dma_direct_offset.

Currently there's no pci_dma_dev_setup() routine for Celleb so add one.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/celleb/iommu.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/celleb/iommu.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/celleb/iommu.c
+++ linux-2.6-new/arch/powerpc/platforms/celleb/iommu.c
@@ -72,6 +72,17 @@ static void __init celleb_init_direct_ma
 	dma_direct_offset = dma_base;
 }
 
+static void celleb_dma_dev_setup(struct device *dev)
+{
+	dev->archdata.dma_ops = get_pci_dma_ops();
+	dev->archdata.dma_data = &dma_direct_offset;
+}
+
+static void celleb_pci_dma_dev_setup(struct pci_dev *pdev)
+{
+	celleb_dma_dev_setup(&pdev->dev);
+}
+
 static int celleb_of_bus_notify(struct notifier_block *nb,
 				unsigned long action, void *data)
 {
@@ -81,7 +92,7 @@ static int celleb_of_bus_notify(struct n
 	if (action != BUS_NOTIFY_ADD_DEVICE)
 		return 0;
 
-	dev->archdata.dma_ops = get_pci_dma_ops();
+	celleb_dma_dev_setup(dev);
 
 	return 0;
 }
@@ -97,6 +108,7 @@ static int __init celleb_init_iommu(void
 
 	celleb_init_direct_mapping();
 	set_pci_dma_ops(&dma_direct_ops);
+	ppc_md.pci_dma_dev_setup = celleb_pci_dma_dev_setup;
 	bus_register_notifier(&of_platform_bus_type, &celleb_of_bus_notifier);
 
 	return 0;

-- 
