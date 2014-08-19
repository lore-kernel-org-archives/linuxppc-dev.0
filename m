Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B8441A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 21:25:25 +1000 (EST)
Message-ID: <53F3340F.2020208@freescale.com>
Date: Tue, 19 Aug 2014 14:25:03 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/4] powerpc/fsl_msi: change the irq handler from chained
 to normal
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we do for other fsl-mpic related cascaded irqchips
(e.g. error ints, mpic timers), use a normal irq handler
for msi irqs too.
This brings some advantages such as mask/unmask/ack/eoi
and irq state taken care behind the scenes, kstats
updates a.s.o plus access to features provided by mpic,
such as affinity.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 56 ++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 05a0dd9..0cfc32a 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/of_platform.h>
+#include <linux/interrupt.h>
 #include <sysdev/fsl_soc.h>
 #include <asm/prom.h>
 #include <asm/hw_irq.h>
@@ -241,40 +242,24 @@ out_free:
 	return rc;
 }
 
-static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
+static irqreturn_t fsl_msi_cascade(int irq, void *data)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irq_data *idata = irq_desc_get_irq_data(desc);
 	unsigned int cascade_irq;
 	struct fsl_msi *msi_data;
 	int msir_index = -1;
 	u32 msir_value = 0;
 	u32 intr_index;
 	u32 have_shift = 0;
-	struct fsl_msi_cascade_data *cascade_data;
+	struct fsl_msi_cascade_data *cascade_data = data;
+	irqreturn_t ret = IRQ_NONE;
 
-	cascade_data = irq_get_handler_data(irq);
 	msi_data = cascade_data->msi_data;
 
-	raw_spin_lock(&desc->lock);
-	if ((msi_data->feature &  FSL_PIC_IP_MASK) == FSL_PIC_IP_IPIC) {
-		if (chip->irq_mask_ack)
-			chip->irq_mask_ack(idata);
-		else {
-			chip->irq_mask(idata);
-			chip->irq_ack(idata);
-		}
-	}
-
-	if (unlikely(irqd_irq_inprogress(idata)))
-		goto unlock;
-
 	msir_index = cascade_data->index;
 
 	if (msir_index >= NR_MSI_REG_MAX)
 		cascade_irq = NO_IRQ;
 
-	irqd_set_chained_irq_inprogress(idata);
 	switch (msi_data->feature & FSL_PIC_IP_MASK) {
 	case FSL_PIC_IP_MPIC:
 		msir_value = fsl_msi_read(msi_data->msi_regs,
@@ -303,25 +288,15 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 		cascade_irq = irq_linear_revmap(msi_data->irqhost,
 				msi_hwirq(msi_data, msir_index,
 					  intr_index + have_shift));
-		if (cascade_irq != NO_IRQ)
+		if (cascade_irq != NO_IRQ) {
 			generic_handle_irq(cascade_irq);
+			ret = IRQ_HANDLED;
+		}
 		have_shift += intr_index + 1;
 		msir_value = msir_value >> (intr_index + 1);
 	}
-	irqd_clr_chained_irq_inprogress(idata);
 
-	switch (msi_data->feature & FSL_PIC_IP_MASK) {
-	case FSL_PIC_IP_MPIC:
-	case FSL_PIC_IP_VMPIC:
-		chip->irq_eoi(idata);
-		break;
-	case FSL_PIC_IP_IPIC:
-		if (!irqd_irq_disabled(idata) && chip->irq_unmask)
-			chip->irq_unmask(idata);
-		break;
-	}
-unlock:
-	raw_spin_unlock(&desc->lock);
+	return ret;
 }
 
 static int fsl_of_msi_remove(struct platform_device *ofdev)
@@ -336,9 +311,8 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 			virq = msi->cascade_array[i]->virq;
 
 			BUG_ON(virq == NO_IRQ);
-			BUG_ON(msi->cascade_array[i] !=
-				irq_get_handler_data(virq));
 
+			free_irq(virq, msi->cascade_array[i]);
 			kfree(msi->cascade_array[i]);
 			irq_dispose_mapping(virq);
 		}
@@ -358,7 +332,7 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 			       int offset, int irq_index)
 {
 	struct fsl_msi_cascade_data *cascade_data = NULL;
-	int virt_msir, i;
+	int virt_msir, i, ret;
 
 	virt_msir = irq_of_parse_and_map(dev->dev.of_node, irq_index);
 	if (virt_msir == NO_IRQ) {
@@ -377,8 +351,14 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 	cascade_data->msi_data = msi;
 	cascade_data->virq = virt_msir;
 	msi->cascade_array[irq_index] = cascade_data;
-	irq_set_handler_data(virt_msir, cascade_data);
-	irq_set_chained_handler(virt_msir, fsl_msi_cascade);
+
+	ret = request_irq(virt_msir, fsl_msi_cascade, 0,
+			  "fsl-msi-cascade", cascade_data);
+	if (ret) {
+		dev_err(&dev->dev, "failed to request_irq(%d), ret = %d\n",
+			virt_msir, ret);
+		return ret;
+	}
 
 	/* Release the hwirqs corresponding to this MSI register */
 	for (i = 0; i < IRQS_PER_MSI_REG; i++)
-- 
1.9.2
