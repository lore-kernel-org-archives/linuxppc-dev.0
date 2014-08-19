Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA8F21A10B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 21:25:48 +1000 (EST)
Message-ID: <53F3340D.4070106@freescale.com>
Date: Tue, 19 Aug 2014 14:25:01 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/4] powerpc/fsl_msi: reorganize structs to improve clarity
 and flexibility
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

Store cascade_data in an array inside the driver
data for later use.
Get rid of the msi_virq array since now we can
encapsulate the virqs in the cascade_data
directly and access them through the array
mentioned earlier.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 17 +++++++++++------
 arch/powerpc/sysdev/fsl_msi.h |  4 +++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 9fadc6e..05a0dd9 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -50,6 +50,7 @@ struct fsl_msi_feature {
 struct fsl_msi_cascade_data {
 	struct fsl_msi *msi_data;
 	int index;
+	int virq;
 };
 
 static inline u32 fsl_msi_read(u32 __iomem *base, unsigned int reg)
@@ -327,15 +328,18 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 {
 	struct fsl_msi *msi = platform_get_drvdata(ofdev);
 	int virq, i;
-	struct fsl_msi_cascade_data *cascade_data;
 
 	if (msi->list.prev != NULL)
 		list_del(&msi->list);
 	for (i = 0; i < NR_MSI_REG_MAX; i++) {
-		virq = msi->msi_virqs[i];
-		if (virq != NO_IRQ) {
-			cascade_data = irq_get_handler_data(virq);
-			kfree(cascade_data);
+		if (msi->cascade_array[i]) {
+			virq = msi->cascade_array[i]->virq;
+
+			BUG_ON(virq == NO_IRQ);
+			BUG_ON(msi->cascade_array[i] !=
+				irq_get_handler_data(virq));
+
+			kfree(msi->cascade_array[i]);
 			irq_dispose_mapping(virq);
 		}
 	}
@@ -369,9 +373,10 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 		return -ENOMEM;
 	}
 	irq_set_lockdep_class(virt_msir, &fsl_msi_irq_class);
-	msi->msi_virqs[irq_index] = virt_msir;
 	cascade_data->index = offset;
 	cascade_data->msi_data = msi;
+	cascade_data->virq = virt_msir;
+	msi->cascade_array[irq_index] = cascade_data;
 	irq_set_handler_data(virt_msir, cascade_data);
 	irq_set_chained_handler(virt_msir, fsl_msi_cascade);
 
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index df9aa9f..420cfcb 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -27,6 +27,8 @@
 #define FSL_PIC_IP_IPIC   0x00000002
 #define FSL_PIC_IP_VMPIC  0x00000003
 
+struct fsl_msi_cascade_data;
+
 struct fsl_msi {
 	struct irq_domain *irqhost;
 
@@ -37,7 +39,7 @@ struct fsl_msi {
 	u32 srs_shift; /* Shift of the shared interrupt register select */
 	void __iomem *msi_regs;
 	u32 feature;
-	int msi_virqs[NR_MSI_REG_MAX];
+	struct fsl_msi_cascade_data *cascade_array[NR_MSI_REG_MAX];
 
 	struct msi_bitmap bitmap;
 
-- 
1.9.2
