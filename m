Return-Path: <tqnguyen@apm.com>
Received: from exprod5og106.obsmtp.com (exprod5og106.obsmtp.com [64.18.0.182])
 by ozlabs.org (Postfix) with SMTP id 00D7DB705E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 18:45:57 +1000 (EST)
Received: by dadp12 with SMTP id p12so7280428dad.35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 01:45:55 -0700 (PDT)
From: "Thang Q. Nguyen" <tqnguyen@apm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
 Grant Likely <grant.likely@secretlab.ca>,
 Rob Herring <rob.herring@calxeda.com>
Subject: [PATCH 1/7] Add support hardreset
Date: Tue, 17 Apr 2012 15:43:13 +0700
Message-Id: <1334652193-10487-1-git-send-email-tqnguyen@apm.com>
Cc: Phong Vo <pvo@apm.com>, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 "Thang Q. Nguyen" <tqnguyen@apm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 The hardreset operation is currently not supported. This causes sometime the SATA driver does cause kernel crash because of none-determined state.a This patch will fix the issue.

Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
---
 drivers/ata/sata_dwc_460ex.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 69f7cde..ae13ef1 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1581,10 +1581,31 @@ static void sata_dwc_qc_prep(struct ata_queued_cmd *qc)
 
 static void sata_dwc_error_handler(struct ata_port *ap)
 {
-	ap->link.flags |= ATA_LFLAG_NO_HRST;
 	ata_sff_error_handler(ap);
 }
 
+int sata_dwc_hardreset(struct ata_link *link, unsigned int *class,
+			unsigned long deadline)
+{
+	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(link->ap);
+	int ret;
+
+	ret = sata_sff_hardreset(link, class, deadline);
+
+	sata_dwc_enable_interrupts(hsdev);
+
+	/* Reconfigure the DMA control register */
+	out_le32(&hsdev->sata_dwc_regs->dmacr,
+		 SATA_DWC_DMACR_TXRXCH_CLEAR);
+
+	/* Reconfigure the DMA Burst Transaction Size register */
+	out_le32(&hsdev->sata_dwc_regs->dbtsr,
+		 SATA_DWC_DBTSR_MWR(AHB_DMA_BRST_DFLT) |
+		 SATA_DWC_DBTSR_MRD(AHB_DMA_BRST_DFLT));
+
+	return ret;
+}
+
 /*
  * scsi mid-layer and libata interface structures
  */
@@ -1604,6 +1625,7 @@ static struct ata_port_operations sata_dwc_ops = {
 	.inherits		= &ata_sff_port_ops,
 
 	.error_handler		= sata_dwc_error_handler,
+	.hardreset		= sata_dwc_hardreset,
 
 	.qc_prep		= sata_dwc_qc_prep,
 	.qc_issue		= sata_dwc_qc_issue,
-- 
1.7.3.4
