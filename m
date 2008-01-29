Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b328031747602deeac6827c054b7986734a9c322.1201616038.git.michael@ellerman.id.au>
In-Reply-To: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/8] Split out the IOMMU logic from cell_dma_dev_setup()
Date: Wed, 30 Jan 2008 01:14:01 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Split the IOMMU logic out from cell_dma_dev_setup() into a separate
function. If we're not using dma_direct_ops or dma_iommu_ops we don't
know what the hell's going on, so BUG.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index a86e5bb..e9769fc 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -507,17 +507,12 @@ static struct cbe_iommu *cell_iommu_for_node(int nid)
 
 static unsigned long cell_dma_direct_offset;
 
-static void cell_dma_dev_setup(struct device *dev)
+static void cell_dma_dev_setup_iommu(struct device *dev)
 {
 	struct iommu_window *window;
 	struct cbe_iommu *iommu;
 	struct dev_archdata *archdata = &dev->archdata;
 
-	if (get_pci_dma_ops() == &dma_direct_ops) {
-		archdata->dma_data = (void *)cell_dma_direct_offset;
-		return;
-	}
-
 	/* Current implementation uses the first window available in that
 	 * node's iommu. We -might- do something smarter later though it may
 	 * never be necessary
@@ -534,6 +529,18 @@ static void cell_dma_dev_setup(struct device *dev)
 	archdata->dma_data = &window->table;
 }
 
+static void cell_dma_dev_setup(struct device *dev)
+{
+	struct dev_archdata *archdata = &dev->archdata;
+
+	if (get_pci_dma_ops() == &dma_iommu_ops)
+		cell_dma_dev_setup_iommu(dev);
+	else if (get_pci_dma_ops() == &dma_direct_ops)
+		archdata->dma_data = (void *)cell_dma_direct_offset;
+	else
+		BUG();
+}
+
 static void cell_pci_dma_dev_setup(struct pci_dev *dev)
 {
 	cell_dma_dev_setup(&dev->dev);
-- 
1.5.3.7.1.g4e596e
