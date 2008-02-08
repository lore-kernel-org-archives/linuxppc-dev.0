Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3a5f24f6525e3bfab1bdd8d76aa68c9835be958f.1202449018.git.michael@ellerman.id.au>
In-Reply-To: <3aa63ba024ba35ff3bf5b5f1d6aec2efa9782ba5.1202449018.git.michael@ellerman.id.au>
References: <3aa63ba024ba35ff3bf5b5f1d6aec2efa9782ba5.1202449018.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/4] Don't enable cell IOMMU fixed mapping if there are no
	dma-ranges
Date: Fri,  8 Feb 2008 16:37:03 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In order for the cell IOMMU fixed mapping to work we need "dma-ranges"
properties in the device tree. If there are none then there's no point
enabling the fixed mapping support.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index a276064..1f7b254 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -917,6 +917,18 @@ static int __init cell_iommu_fixed_mapping_init(void)
 		return -1;
 	}
 
+	/* We must have dma-ranges properties for fixed mapping to work */
+	for (np = NULL; (np = of_find_all_nodes(np));) {
+		if (of_find_property(np, "dma-ranges", NULL))
+			break;
+	}
+	of_node_put(np);
+
+	if (!np) {
+		pr_debug("iommu: no dma-ranges found, no fixed mapping\n");
+		return -1;
+	}
+
 	/* The default setup is to have the fixed mapping sit after the
 	 * dynamic region, so find the top of the largest IOMMU window
 	 * on any axon, then add the size of RAM and that's our max value.
-- 
1.5.2.rc1.1884.g59b20
