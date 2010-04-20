Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 861A3B7E1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 21:44:29 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3KBiBkt015991 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 04:44:21 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3KBrs2v014673
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 06:54:02 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/5] fsl_msi: add remove path and probe failing path
Date: Tue, 20 Apr 2010 20:20:48 +0800
Message-Id: <1271766048-19272-5-git-send-email-leoli@freescale.com>
In-Reply-To: <1271766048-19272-4-git-send-email-leoli@freescale.com>
References: <1271766048-19272-1-git-send-email-leoli@freescale.com>
	<1271766048-19272-2-git-send-email-leoli@freescale.com>
	<1271766048-19272-3-git-send-email-leoli@freescale.com>
	<1271766048-19272-4-git-send-email-leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also cleanup the probe function.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c |   35 +++++++++++++++++++++++++++++------
 arch/powerpc/sysdev/fsl_msi.h |    1 +
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 61e97cb..2c25575 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -251,6 +251,29 @@ unlock:
 	spin_unlock(&desc->lock);
 }
 
+static int fsl_of_msi_remove(struct of_device *ofdev)
+{
+	struct fsl_msi *msi = ofdev->dev.platform_data;
+	int virq, i;
+	struct fsl_msi_cascade_data *cascade_data;
+
+	if (msi->list.prev != NULL)
+		list_del(&msi->list);
+	for (i = 0; i < NR_MSI_REG; i++) {
+		virq = msi->msi_virqs[i];
+		if (virq != NO_IRQ) {
+			cascade_data = get_irq_data(virq);
+			kfree(cascade_data);
+			irq_dispose_mapping(virq);
+		}
+	}
+	msi_bitmap_free(&msi->bitmap);
+	iounmap(msi->msi_regs);
+	kfree(msi);
+
+	return 0;
+}
+
 static int __devinit fsl_of_msi_probe(struct of_device *dev,
 				const struct of_device_id *match)
 {
@@ -270,9 +293,9 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 	msi = kzalloc(sizeof(struct fsl_msi), GFP_KERNEL);
 	if (!msi) {
 		dev_err(&dev->dev, "No memory for MSI structure\n");
-		err = -ENOMEM;
-		goto error_out;
+		return -ENOMEM;
 	}
+	dev->dev.platform_data = msi;
 
 	msi->irqhost = irq_alloc_host(dev->node, IRQ_HOST_MAP_LINEAR,
 				      NR_MSI_IRQS, &fsl_msi_host_ops, 0);
@@ -329,9 +352,7 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 		offset = *p / IRQS_PER_MSI_REG;
 
 	count /= sizeof(u32);
-	for (i = 0; i < count / 2; i++) {
-		if (i > NR_MSI_REG)
-			break;
+	for (i = 0; i < min(count / 2, NR_MSI_REG); i++) {
 		virt_msir = irq_of_parse_and_map(dev->node, i);
 		if (virt_msir != NO_IRQ) {
 			cascade_data = kzalloc(
@@ -343,6 +364,7 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 				err = -ENOMEM;
 				goto error_out;
 			}
+			msi->msi_virqs[i] = virt_msir;
 			cascade_data->index = i + offset;
 			cascade_data->msi_data = msi;
 			set_irq_data(virt_msir, (void *)cascade_data);
@@ -364,7 +386,7 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 	}
 	return 0;
 error_out:
-	kfree(msi);
+	fsl_of_msi_remove(dev);
 	return err;
 }
 
@@ -394,6 +416,7 @@ static struct of_platform_driver fsl_of_msi_driver = {
 	.name = "fsl-msi",
 	.match_table = fsl_of_msi_ids,
 	.probe = fsl_of_msi_probe,
+	.remove = fsl_of_msi_remove,
 };
 
 static __init int fsl_of_msi_init(void)
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 8fc5523..624580c 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -32,6 +32,7 @@ struct fsl_msi {
 	u32 msi_addr_hi;
 	void __iomem *msi_regs;
 	u32 feature;
+	int msi_virqs[NR_MSI_REG];
 
 	struct msi_bitmap bitmap;
 
-- 
1.6.6-rc1.GIT
