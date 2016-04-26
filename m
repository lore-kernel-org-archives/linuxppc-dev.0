Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvHFR2Z88zDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 19:03:39 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: [PATCH v2 07/23] ata: sata_dwc_460ex: skip dma setup for non-dma
 commands
Date: Tue, 26 Apr 2016 12:03:08 +0300
Message-Id: <1461661404-1952-8-git-send-email-andriy.shevchenko@linux.intel.com>
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

Calling dmaengine_prep_slave_sg() for non-dma ATA commands is
unnecessary at best and could be harmful if the dma driver reacts
badly to this.  It also causes this driver to print a bogus error
message in these cases.

This patch changes sata_dwc_qc_issue() to only do the dma setup
for dma commands and also reports an error to libata if if fails.

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 1250e18..038e5fb 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1023,36 +1023,12 @@ static void sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
 	sata_dwc_bmdma_start_by_tag(qc, tag);
 }
 
-/*
- * Function : sata_dwc_qc_prep_by_tag
- * arguments : ata_queued_cmd *qc, u8 tag
- * Return value : None
- * qc_prep for a particular queued command based on tag
- */
-static void sata_dwc_qc_prep_by_tag(struct ata_queued_cmd *qc, u8 tag)
-{
-	struct dma_async_tx_descriptor *desc;
-	struct ata_port *ap = qc->ap;
-	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
-
-	dev_dbg(ap->dev, "%s: port=%d dma dir=%s n_elem=%d\n",
-		__func__, ap->port_no, get_dma_dir_descript(qc->dma_dir),
-		 qc->n_elem);
-
-	desc = dma_dwc_xfer_setup(qc);
-	if (!desc) {
-		dev_err(ap->dev, "%s: dma_dwc_xfer_setup returns NULL\n",
-			__func__);
-		return;
-	}
-	hsdevp->desc[tag] = desc;
-}
-
 static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 {
 	u32 sactive;
 	u8 tag = qc->tag;
 	struct ata_port *ap = qc->ap;
+	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 
 #ifdef DEBUG_NCQ
 	if (qc->tag > 0 || ap->link.sactive > 1)
@@ -1066,7 +1042,14 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 
 	if (!ata_is_ncq(qc->tf.protocol))
 		tag = 0;
-	sata_dwc_qc_prep_by_tag(qc, tag);
+
+	if (ata_is_dma(qc->tf.protocol)) {
+		hsdevp->desc[tag] = dma_dwc_xfer_setup(qc);
+		if (!hsdevp->desc[tag])
+			return AC_ERR_SYSTEM;
+	} else {
+		hsdevp->desc[tag] = NULL;
+	}
 
 	if (ata_is_ncq(qc->tf.protocol)) {
 		sactive = core_scr_read(SCR_ACTIVE);
-- 
2.8.0.rc3
