Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <b3997f77b701a0886df6eb3a5e4446d4dc538483.1217977742.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/4] powerpc: fsl_msi doesn't need it's own of_node
Date: Wed,  6 Aug 2008 09:10:00 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The FSL MSI code keeps a pointer to the of_node from the device
it represents. However it also has an irq_host, which contains
a pointer to the of_node, so use that one instead.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/fsl_msi.c |   12 +++++-------
 arch/powerpc/sysdev/fsl_msi.h |    3 ---
 2 files changed, 5 insertions(+), 10 deletions(-)


Hi Paul, I sent these a while ago, and they were acked by FSL folks and 
Ojn - so I think Benh just forgot to merge them for 27.

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 2c5187c..d49fa99 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -108,7 +108,8 @@ static int fsl_msi_free_dt_hwirqs(struct fsl_msi *msi)
 	bitmap_allocate_region(msi->fsl_msi_bitmap, 0,
 		       get_count_order(NR_MSI_IRQS));
 
-	p = of_get_property(msi->of_node, "msi-available-ranges", &len);
+	p = of_get_property(msi->irqhost->of_node, "msi-available-ranges",
+			    &len);
 
 	if (!p) {
 		/* No msi-available-ranges property,
@@ -120,7 +121,7 @@ static int fsl_msi_free_dt_hwirqs(struct fsl_msi *msi)
 
 	if ((len % (2 * sizeof(u32))) != 0) {
 		printk(KERN_WARNING "fsl_msi: Malformed msi-available-ranges "
-		       "property on %s\n", msi->of_node->full_name);
+		       "property on %s\n", msi->irqhost->of_node->full_name);
 		return -EINVAL;
 	}
 
@@ -317,14 +318,11 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 		goto error_out;
 	}
 
-	msi->of_node = of_node_get(dev->node);
+	msi->irqhost = irq_alloc_host(dev->node, IRQ_HOST_MAP_LINEAR,
+				      NR_MSI_IRQS, &fsl_msi_host_ops, 0);
 
-	msi->irqhost = irq_alloc_host(of_node_get(dev->node),
-				IRQ_HOST_MAP_LINEAR,
-				NR_MSI_IRQS, &fsl_msi_host_ops, 0);
 	if (msi->irqhost == NULL) {
 		dev_err(&dev->dev, "No memory for MSI irqhost\n");
-		of_node_put(dev->node);
 		err = -ENOMEM;
 		goto error_out;
 	}
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index a653468..6574550 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -22,9 +22,6 @@
 #define FSL_PIC_IP_IPIC	0x00000002
 
 struct fsl_msi {
-	/* Device node of the MSI interrupt*/
-	struct device_node *of_node;
-
 	struct irq_host *irqhost;
 
 	unsigned long cascade_irq;
-- 
1.5.5
