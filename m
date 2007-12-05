Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f4d0ac13491bbe6834fe1f8d4bf86c04754f3774.1196839256.git.michael@ellerman.id.au>
In-Reply-To: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
References: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/7] Add celleb_dma_dev_setup()
Date: Wed,  5 Dec 2007 18:20:58 +1100 (EST)
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
---
 arch/powerpc/platforms/celleb/iommu.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/celleb/iommu.c b/arch/powerpc/platforms/celleb/iommu.c
index 755d869..04d5678 100644
--- a/arch/powerpc/platforms/celleb/iommu.c
+++ b/arch/powerpc/platforms/celleb/iommu.c
@@ -71,6 +71,17 @@ static void __init celleb_init_direct_mapping(void)
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
@@ -80,7 +91,7 @@ static int celleb_of_bus_notify(struct notifier_block *nb,
 	if (action != BUS_NOTIFY_ADD_DEVICE)
 		return 0;
 
-	dev->archdata.dma_ops = get_pci_dma_ops();
+	celleb_dma_dev_setup(dev);
 
 	return 0;
 }
@@ -96,6 +107,7 @@ static int __init celleb_init_iommu(void)
 
 	celleb_init_direct_mapping();
 	set_pci_dma_ops(&dma_direct_ops);
+	ppc_md.pci_dma_dev_setup = celleb_pci_dma_dev_setup;
 	bus_register_notifier(&of_platform_bus_type, &celleb_of_bus_notifier);
 
 	return 0;
-- 
1.5.3.7.1.g4e596e
