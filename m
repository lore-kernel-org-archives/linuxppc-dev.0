Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Nov 2006 18:45:12 +1100
Subject: [PATCH 32/32] powerpc: Fix a typo in new style SPE mapping code
In-Reply-To: <1163144683.554182.685908332811.qpush@grosgo>
Message-Id: <20061110074516.A35F867D3A@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a typo in the "new style" code for mapping SPE
resources, which causes it to try to map 4 times the same resource.

It also adds some pr_debug's that are useful to track down issues with
the firmware when bringinh up new machines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

The bug is in 2.6.19 so we should merge that asap.

 arch/powerpc/platforms/cell/spu_base.c |   41 ++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

Index: linux-cell/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spu_base.c	2006-10-23 14:41:37.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spu_base.c	2006-11-10 16:54:20.000000000 +1100
@@ -655,14 +655,19 @@ static int __init spu_map_interrupts(str
 
 	for (i=0; i < 3; i++) {
 		ret = of_irq_map_one(np, i, &oirq);
-		if (ret)
+		if (ret) {
+			pr_debug("spu_new: failed to get irq %d\n", i);
 			goto err;
-
+		}
 		ret = -EINVAL;
+		pr_debug("  irq %d no 0x%x on %s\n", i, oirq.specifier[0],
+			 oirq.controller->full_name);
 		spu->irqs[i] = irq_create_of_mapping(oirq.controller,
 					oirq.specifier, oirq.size);
-		if (spu->irqs[i] == NO_IRQ)
+		if (spu->irqs[i] == NO_IRQ) {
+			pr_debug("spu_new: failed to map it !\n");
 			goto err;
+		}
 	}
 	return 0;
 
@@ -681,7 +686,7 @@ static int spu_map_resource(struct devic
 	struct resource resource = { };
 	int ret;
 
-	ret = of_address_to_resource(node, 0, &resource);
+	ret = of_address_to_resource(node, nr, &resource);
 	if (ret)
 		goto out;
 
@@ -704,22 +709,42 @@ static int __init spu_map_device(struct 
 
 	ret = spu_map_resource(node, 0, (void __iomem**)&spu->local_store,
 					&spu->local_store_phys);
-	if (ret)
+	if (ret) {
+		pr_debug("spu_new: failed to map %s resource 0\n",
+			 node->full_name);
 		goto out;
+	}
 	ret = spu_map_resource(node, 1, (void __iomem**)&spu->problem,
 					&spu->problem_phys);
-	if (ret)
+	if (ret) {
+		pr_debug("spu_new: failed to map %s resource 1\n",
+			 node->full_name);
 		goto out_unmap;
+	}
 	ret = spu_map_resource(node, 2, (void __iomem**)&spu->priv2,
 					NULL);
-	if (ret)
+	if (ret) {
+		pr_debug("spu_new: failed to map %s resource 2\n",
+			 node->full_name);
 		goto out_unmap;
+	}
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		ret = spu_map_resource(node, 3, (void __iomem**)&spu->priv1,
 					NULL);
-	if (ret)
+	if (ret) {
+		pr_debug("spu_new: failed to map %s resource 3\n",
+			 node->full_name);
 		goto out_unmap;
+	}
+	pr_debug("spu_new: %s maps:\n", node->full_name);
+	pr_debug("  local store   : 0x%016lx -> 0x%p\n",
+		 spu->local_store_phys, spu->local_store);
+	pr_debug("  problem state : 0x%016lx -> 0x%p\n",
+		 spu->problem_phys, spu->problem);
+	pr_debug("  priv2         :                       0x%p\n", spu->priv2);
+	pr_debug("  priv1         :                       0x%p\n", spu->priv1);
+
 	return 0;
 
 out_unmap:
