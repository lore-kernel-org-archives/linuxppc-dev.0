Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ee954714b1cd2d8bed2e52b79adf89805acd45bf.1226550015.git.michael@ellerman.id.au>
In-Reply-To: <2743c30c538d24a0befee055bd6e0fcd746d0e82.1226550015.git.michael@ellerman.id.au>
References: <2743c30c538d24a0befee055bd6e0fcd746d0e82.1226550015.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/4] Use of_find_node_with_property() in
	cell_iommu_fixed_mapping_init()
Date: Thu, 13 Nov 2008 15:20:40 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 3168272..86db4dd 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -1053,10 +1053,7 @@ static int __init cell_iommu_fixed_mapping_init(void)
 	}
 
 	/* We must have dma-ranges properties for fixed mapping to work */
-	for (np = NULL; (np = of_find_all_nodes(np));) {
-		if (of_find_property(np, "dma-ranges", NULL))
-			break;
-	}
+	np = of_find_node_with_property(NULL, "dma-ranges");
 	of_node_put(np);
 
 	if (!np) {
-- 
1.5.5
