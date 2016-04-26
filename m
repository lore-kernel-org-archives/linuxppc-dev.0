Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvHFK0kjwzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 19:03:32 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: [PATCH v2 10/23] ata: sata_dwc_460ex: add phy support
Date: Tue, 26 Apr 2016 12:03:11 +0300
Message-Id: <1461661404-1952-11-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mans Rullgard <mans@mansr.com>

This adds support for powering on an optional PHY when activating the
device.

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/Kconfig          |  1 +
 drivers/ata/sata_dwc_460ex.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ede126d..41b0725 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -313,6 +313,7 @@ config ATA_PIIX
 
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
+	select GENERIC_PHY
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 200af36..4b8eded 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -35,6 +35,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/phy/phy.h>
 #include <linux/libata.h>
 #include <linux/slab.h>
 
@@ -145,6 +146,7 @@ struct sata_dwc_device {
 	struct ata_host		*host;
 	u8 __iomem		*reg_base;
 	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
+	struct phy		*phy;
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	struct dw_dma_chip	*dma;
 #endif
@@ -948,6 +950,10 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	if (err)
 		goto CLEANUP_ALLOC;
 
+	err = phy_power_on(hsdev->phy);
+	if (err)
+		goto CLEANUP_ALLOC;
+
 	for (i = 0; i < SATA_DWC_QCMD_MAX; i++)
 		hsdevp->cmd_issued[i] = SATA_DWC_CMD_ISSUED_NOT;
 
@@ -983,11 +989,13 @@ CLEANUP:
 static void sata_dwc_port_stop(struct ata_port *ap)
 {
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
+	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 
 	dev_dbg(ap->dev, "%s: ap->id = %d\n", __func__, ap->print_id);
 
 	dmaengine_terminate_all(hsdevp->chan);
 	dma_release_channel(hsdevp->chan);
+	phy_power_off(hsdev->phy);
 
 	kfree(hsdevp);
 	ap->private_data = NULL;
@@ -1321,6 +1329,17 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 #endif
 
+	hsdev->phy = devm_phy_optional_get(hsdev->dev, "sata-phy");
+	if (IS_ERR(hsdev->phy)) {
+		err = PTR_ERR(hsdev->phy);
+		hsdev->phy = NULL;
+		goto error_out;
+	}
+
+	err = phy_init(hsdev->phy);
+	if (err)
+		goto error_out;
+
 	/*
 	 * Now, register with libATA core, this will also initiate the
 	 * device discovery process, invoking our port_start() handler &
@@ -1334,6 +1353,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	return 0;
 
 error_out:
+	phy_exit(hsdev->phy);
 	iounmap(base);
 	return err;
 }
@@ -1346,6 +1366,8 @@ static int sata_dwc_remove(struct platform_device *ofdev)
 
 	ata_host_detach(host);
 
+	phy_exit(hsdev->phy);
+
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	/* Free SATA DMA resources */
 	sata_dwc_dma_exit_old(hsdev);
-- 
2.8.0.rc3
