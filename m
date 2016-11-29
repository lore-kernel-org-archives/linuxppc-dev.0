Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSPsf37wdzDvvX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 11:43:02 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT0cX8v103392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 19:42:59 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 270t5crysc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 19:42:59 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 28 Nov 2016 17:42:59 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v2 11/14] cxlflash: Cleanup send_tmf()
Date: Mon, 28 Nov 2016 18:42:50 -0600
In-Reply-To: <1480379984-60114-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1480379984-60114-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1480380170-60570-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>

The send_tmf() routine includes some copy/paste cruft that can be
removed as well as the setting of an AFU command-specific while
holding the tmf_slock. While not a bug, it is out of place and
should be shifted down alongside the other command initialization
statements for clarity.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index db77030..b763699 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -299,12 +299,10 @@ static int wait_resp(struct afu *afu, struct afu_cmd *cmd)
  */
 static int send_tmf(struct afu *afu, struct scsi_cmnd *scp, u64 tmfcmd)
 {
-	struct afu_cmd *cmd = sc_to_afucz(scp);
-
 	u32 port_sel = scp->device->channel + 1;
-	short lflag = 0;
 	struct Scsi_Host *host = scp->device->host;
 	struct cxlflash_cfg *cfg = (struct cxlflash_cfg *)host->hostdata;
+	struct afu_cmd *cmd = sc_to_afucz(scp);
 	struct device *dev = &cfg->dev->dev;
 	ulong lock_flags;
 	int rc = 0;
@@ -317,27 +315,21 @@ static int send_tmf(struct afu *afu, struct scsi_cmnd *scp, u64 tmfcmd)
 						  !cfg->tmf_active,
 						  cfg->tmf_slock);
 	cfg->tmf_active = true;
-	cmd->cmd_tmf = true;
 	spin_unlock_irqrestore(&cfg->tmf_slock, lock_flags);
 
+	cmd->rcb.scp = scp;
+	cmd->parent = afu;
+	cmd->cmd_tmf = true;
+
 	cmd->rcb.ctx_id = afu->ctx_hndl;
 	cmd->rcb.msi = SISL_MSI_RRQ_UPDATED;
 	cmd->rcb.port_sel = port_sel;
 	cmd->rcb.lun_id = lun_to_lunid(scp->device->lun);
-
-	lflag = SISL_REQ_FLAGS_TMF_CMD;
-
 	cmd->rcb.req_flags = (SISL_REQ_FLAGS_PORT_LUN_ID |
-			      SISL_REQ_FLAGS_SUP_UNDERRUN | lflag);
-
-	/* Stash the scp in the command, for reuse during interrupt */
-	cmd->rcb.scp = scp;
-	cmd->parent = afu;
-
-	/* Copy the CDB from the cmd passed in */
+			      SISL_REQ_FLAGS_SUP_UNDERRUN |
+			      SISL_REQ_FLAGS_TMF_CMD);
 	memcpy(cmd->rcb.cdb, &tmfcmd, sizeof(tmfcmd));
 
-	/* Send the command */
 	rc = send_cmd(afu, cmd);
 	if (unlikely(rc)) {
 		spin_lock_irqsave(&cfg->tmf_slock, lock_flags);
-- 
2.1.0
