Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3aa63ba024ba35ff3bf5b5f1d6aec2efa9782ba5.1202449018.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/4] Fix cell IOMMU null pointer explosion on old firmwares
Date: Fri,  8 Feb 2008 16:37:02 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The cell IOMMU fixed mapping support has a null pointer bug if you run
it on older firmwares that don't contain the "dma-ranges" properties.
Fix it and convert to using of_get_next_parent() while we're there.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index df33066..a276064 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 
 #include <asm/prom.h>
@@ -789,18 +790,16 @@ static int __init cell_iommu_init_disabled(void)
 static u64 cell_iommu_get_fixed_address(struct device *dev)
 {
 	u64 cpu_addr, size, best_size, pci_addr = OF_BAD_ADDR;
-	struct device_node *tmp, *np;
+	struct device_node *np;
 	const u32 *ranges = NULL;
 	int i, len, best;
 
-	np = dev->archdata.of_node;
-	of_node_get(np);
-	ranges = of_get_property(np, "dma-ranges", &len);
-	while (!ranges && np) {
-		tmp = of_get_parent(np);
-		of_node_put(np);
-		np = tmp;
+	np = of_node_get(dev->archdata.of_node);
+	while (np) {
 		ranges = of_get_property(np, "dma-ranges", &len);
+		if (ranges)
+			break;
+		np = of_get_next_parent(np);
 	}
 
 	if (!ranges) {
-- 
1.5.2.rc1.1884.g59b20
