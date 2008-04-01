Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e16ca5457060787c0d339e1b707e75c6f875f7b6.1207032121.git.michael@ellerman.id.au>
In-Reply-To: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
References: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [RFC/PATCH 4/4] Simplify xics direct/lpar irq_host setup
Date: Tue,  1 Apr 2008 17:42:27 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The xics code currently has a direct and lpar variant of xics_host_map, the
only difference being which irq_chip they use. If we remember which irq_chip
we're using we can combine these two routines. That also allows us to have a
single irq_host_ops instead of two.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/xics.c |   39 ++++++++++----------------------
 1 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 5a72f27..2fd8088 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -516,6 +516,8 @@ static struct irq_chip xics_pic_lpar = {
 	.set_affinity = xics_set_affinity
 };
 
+/* Points to the irq_chip we're actually using */
+static struct irq_chip *xics_irq_chip;
 
 static int xics_host_match(struct irq_host *h, struct device_node *node)
 {
@@ -526,23 +528,13 @@ static int xics_host_match(struct irq_host *h, struct device_node *node)
 	return !of_device_is_compatible(node, "chrp,iic");
 }
 
-static int xics_host_map_direct(struct irq_host *h, unsigned int virq,
-				irq_hw_number_t hw)
+static int xics_host_map(struct irq_host *h, unsigned int virq,
+			 irq_hw_number_t hw)
 {
-	pr_debug("xics: map_direct virq %d, hwirq 0x%lx\n", virq, hw);
+	pr_debug("xics: map virq %d, hwirq 0x%lx\n", virq, hw);
 
 	get_irq_desc(virq)->status |= IRQ_LEVEL;
-	set_irq_chip_and_handler(virq, &xics_pic_direct, handle_fasteoi_irq);
-	return 0;
-}
-
-static int xics_host_map_lpar(struct irq_host *h, unsigned int virq,
-			      irq_hw_number_t hw)
-{
-	pr_debug("xics: map_direct virq %d, hwirq 0x%lx\n", virq, hw);
-
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
-	set_irq_chip_and_handler(virq, &xics_pic_lpar, handle_fasteoi_irq);
+	set_irq_chip_and_handler(virq, xics_irq_chip, handle_fasteoi_irq);
 	return 0;
 }
 
@@ -561,27 +553,20 @@ static int xics_host_xlate(struct irq_host *h, struct device_node *ct,
 	return 0;
 }
 
-static struct irq_host_ops xics_host_direct_ops = {
+static struct irq_host_ops xics_host_ops = {
 	.match = xics_host_match,
-	.map = xics_host_map_direct,
-	.xlate = xics_host_xlate,
-};
-
-static struct irq_host_ops xics_host_lpar_ops = {
-	.match = xics_host_match,
-	.map = xics_host_map_lpar,
+	.map = xics_host_map,
 	.xlate = xics_host_xlate,
 };
 
 static void __init xics_init_host(void)
 {
-	struct irq_host_ops *ops;
-
 	if (firmware_has_feature(FW_FEATURE_LPAR))
-		ops = &xics_host_lpar_ops;
+		xics_irq_chip = &xics_pic_lpar;
 	else
-		ops = &xics_host_direct_ops;
-	xics_host = irq_alloc_host(NULL, IRQ_HOST_MAP_TREE, 0, ops,
+		xics_irq_chip = &xics_pic_direct;
+
+	xics_host = irq_alloc_host(NULL, IRQ_HOST_MAP_TREE, 0, &xics_host_ops,
 				   XICS_IRQ_SPURIOUS);
 	BUG_ON(xics_host == NULL);
 	irq_set_default_host(xics_host);
-- 
1.5.2.rc1.1884.g59b20
