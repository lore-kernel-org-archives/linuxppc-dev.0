Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qrRkx4vTKzDqgY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 04:15:53 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: [PATCH v1 14/23] ata: sata_dwc_460ex: get rid of some pointless casts
Date: Thu, 21 Apr 2016 21:15:35 +0300
Message-Id: <1461262544-115408-15-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mans Rullgard <mans@mansr.com>

Casting a pointer to unsigned long only to immediately cast it back
to a pointer makes no sense.  Fix this.


Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 571ecd1..9e8271d 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -844,26 +844,26 @@ static void sata_dwc_enable_interrupts(struct sata_dwc_device *hsdev)
 		in_le32(&hsdev->sata_dwc_regs->errmr));
 }
 
-static void sata_dwc_setup_port(struct ata_ioports *port, unsigned long base)
+static void sata_dwc_setup_port(struct ata_ioports *port, void __iomem *base)
 {
-	port->cmd_addr = (void __iomem *)base + 0x00;
-	port->data_addr = (void __iomem *)base + 0x00;
+	port->cmd_addr		= base + 0x00;
+	port->data_addr		= base + 0x00;
 
-	port->error_addr = (void __iomem *)base + 0x04;
-	port->feature_addr = (void __iomem *)base + 0x04;
+	port->error_addr	= base + 0x04;
+	port->feature_addr	= base + 0x04;
 
-	port->nsect_addr = (void __iomem *)base + 0x08;
+	port->nsect_addr	= base + 0x08;
 
-	port->lbal_addr = (void __iomem *)base + 0x0c;
-	port->lbam_addr = (void __iomem *)base + 0x10;
-	port->lbah_addr = (void __iomem *)base + 0x14;
+	port->lbal_addr		= base + 0x0c;
+	port->lbam_addr		= base + 0x10;
+	port->lbah_addr		= base + 0x14;
 
-	port->device_addr = (void __iomem *)base + 0x18;
-	port->command_addr = (void __iomem *)base + 0x1c;
-	port->status_addr = (void __iomem *)base + 0x1c;
+	port->device_addr	= base + 0x18;
+	port->command_addr	= base + 0x1c;
+	port->status_addr	= base + 0x1c;
 
-	port->altstatus_addr = (void __iomem *)base + 0x20;
-	port->ctl_addr = (void __iomem *)base + 0x20;
+	port->altstatus_addr	= base + 0x20;
+	port->ctl_addr		= base + 0x20;
 }
 
 static int sata_dwc_dma_get_channel(struct sata_dwc_device_port *hsdevp)
@@ -1253,7 +1253,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Setup port */
 	host->ports[0]->ioaddr.cmd_addr = base;
 	host->ports[0]->ioaddr.scr_addr = base + SATA_DWC_SCR_OFFSET;
-	sata_dwc_setup_port(&host->ports[0]->ioaddr, (unsigned long)base);
+	sata_dwc_setup_port(&host->ports[0]->ioaddr, base);
 
 	/* Read the ID and Version Registers */
 	idr = in_le32(&hsdev->sata_dwc_regs->idr);
-- 
2.8.0.rc3
