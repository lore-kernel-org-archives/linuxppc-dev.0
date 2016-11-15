Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJNYL3YbMzDvt5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 10:16:06 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAFNEDZS000831
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 18:16:04 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26rbr189m0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 18:16:04 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Tue, 15 Nov 2016 18:16:03 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: [PATCH 12/14] cxlflash: Cleanup queuecommand()
Date: Tue, 15 Nov 2016 17:15:54 -0600
In-Reply-To: <1479251530-22573-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1479251530-22573-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1479251754-23114-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>

The queuecommand routine is disorganized where it populates the
private command and also contains some logic/statements that are
not needed given that cxlflash devices do not (and likely never
will) support scatter-gather.

Restructure the code to remove the unnecessary logic and create an
organized flow:

	handle state -> DMA map -> populate command -> send command

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 50 ++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 5acc3fe..d5b355c 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -413,11 +413,11 @@ static int cxlflash_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scp)
 	struct afu *afu = cfg->afu;
 	struct device *dev = &cfg->dev->dev;
 	struct afu_cmd *cmd = sc_to_afucz(scp);
+	struct scatterlist *sg = scsi_sglist(scp);
 	u32 port_sel = scp->device->channel + 1;
-	int nseg, i, ncount;
-	struct scatterlist *sg;
+	u16 req_flags = SISL_REQ_FLAGS_SUP_UNDERRUN;
 	ulong lock_flags;
-	short lflag = 0;
+	int nseg = 0;
 	int rc = 0;
 	int kref_got = 0;
 
@@ -460,45 +460,35 @@ static int cxlflash_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scp)
 	kref_get(&cfg->afu->mapcount);
 	kref_got = 1;
 
-	cmd->rcb.ctx_id = afu->ctx_hndl;
-	cmd->rcb.msi = SISL_MSI_RRQ_UPDATED;
-	cmd->rcb.port_sel = port_sel;
-	cmd->rcb.lun_id = lun_to_lunid(scp->device->lun);
-
-	if (scp->sc_data_direction == DMA_TO_DEVICE)
-		lflag = SISL_REQ_FLAGS_HOST_WRITE;
-	else
-		lflag = SISL_REQ_FLAGS_HOST_READ;
+	if (likely(sg)) {
+		nseg = scsi_dma_map(scp);
+		if (unlikely(nseg < 0)) {
+			dev_err(dev, "%s: Fail DMA map!\n", __func__);
+			rc = SCSI_MLQUEUE_HOST_BUSY;
+			goto out;
+		}
 
-	cmd->rcb.req_flags = (SISL_REQ_FLAGS_PORT_LUN_ID |
-			      SISL_REQ_FLAGS_SUP_UNDERRUN | lflag);
+		cmd->rcb.data_len = sg_dma_len(sg);
+		cmd->rcb.data_ea = sg_dma_address(sg);
+	}
 
-	/* Stash the scp in the reserved field, for reuse during interrupt */
 	cmd->rcb.scp = scp;
 	cmd->parent = afu;
 
-	nseg = scsi_dma_map(scp);
-	if (unlikely(nseg < 0)) {
-		dev_err(dev, "%s: Fail DMA map! nseg=%d\n",
-			__func__, nseg);
-		rc = SCSI_MLQUEUE_HOST_BUSY;
-		goto out;
-	}
+	cmd->rcb.ctx_id = afu->ctx_hndl;
+	cmd->rcb.msi = SISL_MSI_RRQ_UPDATED;
+	cmd->rcb.port_sel = port_sel;
+	cmd->rcb.lun_id = lun_to_lunid(scp->device->lun);
 
-	ncount = scsi_sg_count(scp);
-	scsi_for_each_sg(scp, sg, ncount, i) {
-		cmd->rcb.data_len = sg_dma_len(sg);
-		cmd->rcb.data_ea = sg_dma_address(sg);
-	}
+	if (scp->sc_data_direction == DMA_TO_DEVICE)
+		req_flags |= SISL_REQ_FLAGS_HOST_WRITE;
 
-	/* Copy the CDB from the scsi_cmnd passed in */
+	cmd->rcb.req_flags = req_flags;
 	memcpy(cmd->rcb.cdb, scp->cmnd, sizeof(cmd->rcb.cdb));
 
-	/* Send the command */
 	rc = send_cmd(afu, cmd);
 	if (unlikely(rc))
 		scsi_dma_unmap(scp);
-
 out:
 	if (kref_got)
 		kref_put(&afu->mapcount, afu_unmap);
-- 
2.1.0
