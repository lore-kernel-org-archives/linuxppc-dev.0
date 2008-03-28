Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6543ADECA6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 08:27:17 +1100 (EST)
Message-Id: <200803282121.m2SLLK7x010729@imap1.linux-foundation.org>
Subject: [patch 20/24] rapidio: add the RapidIO master port maintance and
	doorbell window to space resources
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Fri, 28 Mar 2008 14:21:19 -0700
Cc: akpm@linux-foundation.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

Add the RapidIO master port maintance and doorbell IO windows to RIO space
resources.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/sysdev/fsl_rio.c |   26 +++++++++++++++++++++-----
 include/linux/rio.h           |    1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff -puN arch/powerpc/sysdev/fsl_rio.c~rapidio-add-the-rapidio-master-port-maintance-and-doorbell-window-to-space-resources arch/powerpc/sysdev/fsl_rio.c
--- a/arch/powerpc/sysdev/fsl_rio.c~rapidio-add-the-rapidio-master-port-maintance-and-doorbell-window-to-space-resources
+++ a/arch/powerpc/sysdev/fsl_rio.c
@@ -192,6 +192,8 @@ struct rio_priv {
 	int bellirq;
 	int txirq;
 	int rxirq;
+	struct resource maint_res;
+	struct resource dbell_res;
 };
 
 /**
@@ -1362,15 +1364,29 @@ int fsl_rio_setup(struct of_device *dev)
 		out_be32((priv->regs_win + RIO_ISR_AACR), RIO_ISR_AACR_AA);
 
 	/* Configure maintenance transaction window */
-	out_be32(&priv->maint_atmu_regs->rowbar, 0x000c0000);
-	out_be32(&priv->maint_atmu_regs->rowar, 0x80077015);
+	rio_init_io_res(&priv->maint_res, law_start, RIO_MAINT_WIN_SIZE,
+			"maint_win", RIO_RESOURCE_MAINT);
+	rc = rio_request_io_region(port, &priv->maint_res);
+	if (rc) {
+		dev_err(&dev->dev, "request maint window error!\n");
+		goto err;
+	}
+	out_be32(&priv->maint_atmu_regs->rowbar, (law_start >> 12) & 0xffffff);
+	out_be32(&priv->maint_atmu_regs->rowar, 0x80077000
+					| (__ilog2(RIO_MAINT_WIN_SIZE) - 1));
 
 	priv->maint_win = ioremap(law_start, RIO_MAINT_WIN_SIZE);
 
 	/* Configure outbound doorbell window */
-	out_be32(&priv->dbell_atmu_regs->rowbar, 0x000c0400);
-	out_be32(&priv->dbell_atmu_regs->rowar, 0x8004200b);
-	fsl_rio_doorbell_init(port);
+	rio_init_io_res(&priv->dbell_res, law_start + RIO_MAINT_WIN_SIZE,
+			RIO_DBELL_WIN_SIZE, "dbell_win", RIO_RESOURCE_DOORBELL);
+	out_be32(&priv->dbell_atmu_regs->rowbar, (priv->dbell_res.start >> 12)
+							& 0xffffff);
+	out_be32(&priv->dbell_atmu_regs->rowar, 0x80042000
+					| (__ilog2(RIO_DBELL_WIN_SIZE) - 1));
+	rc = fsl_rio_doorbell_init(port);
+	if (rc)
+		goto err;
 
 	return 0;
 err:
diff -puN include/linux/rio.h~rapidio-add-the-rapidio-master-port-maintance-and-doorbell-window-to-space-resources include/linux/rio.h
--- a/include/linux/rio.h~rapidio-add-the-rapidio-master-port-maintance-and-doorbell-window-to-space-resources
+++ a/include/linux/rio.h
@@ -257,6 +257,7 @@ struct rio_ops {
 #define RIO_RESOURCE_MEM	0x00000100
 #define RIO_RESOURCE_DOORBELL	0x00000200
 #define RIO_RESOURCE_MAILBOX	0x00000400
+#define RIO_RESOURCE_MAINT	0x00000800
 
 #define RIO_RESOURCE_CACHEABLE	0x00010000
 #define RIO_RESOURCE_PCI	0x00020000
_
