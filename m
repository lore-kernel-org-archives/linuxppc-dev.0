Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D80E3DE0C3
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 19:30:58 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m248UqsR019127
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 01:30:53 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m248UYXE000251
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 02:30:52 -0600 (CST)
From: Zhang Wei <wei.zhang@freescale.com>
To: mporter@kernel.crashing.org, galak@kernel.crashing.org
Subject: [PATCH 14/17] Add the RapidIO master port maintance and doorbell
	window to space resources.
Date: Wed,  5 Mar 2008 00:29:59 +0800
Message-Id: <1204648202-5495-14-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <1204648202-5495-13-git-send-email-wei.zhang@freescale.com>
References: <1204648202-5495-1-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-2-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-3-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-4-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-5-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-6-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-7-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-8-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-9-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-10-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-11-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-12-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-13-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the RapidIO master port maintance and doorbell IO windows to
RIO space resources.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |   26 +++++++++++++++++++++-----
 include/linux/rio.h           |    1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index c260ae5..350db4e 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -192,6 +192,8 @@ struct rio_priv {
 	int bellirq;
 	int txirq;
 	int rxirq;
+	struct resource maint_res;
+	struct resource dbell_res;
 };
 
 /**
@@ -1363,15 +1365,29 @@ int fsl_rio_setup(struct of_device *dev)
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
 
 	priv->maint_win = (u32) ioremap(law_start, RIO_MAINT_WIN_SIZE);
 
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
diff --git a/include/linux/rio.h b/include/linux/rio.h
index d8ff4b8..c4acb52 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -257,6 +257,7 @@ struct rio_ops {
 #define RIO_RESOURCE_MEM	0x00000100
 #define RIO_RESOURCE_DOORBELL	0x00000200
 #define RIO_RESOURCE_MAILBOX	0x00000400
+#define RIO_RESOURCE_MAINT	0x00000800
 
 #define RIO_RESOURCE_CACHEABLE	0x00010000
 #define RIO_RESOURCE_PCI	0x00020000
-- 
1.5.4
