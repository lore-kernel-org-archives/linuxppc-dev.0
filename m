Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJNX62mLCzDvxQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 10:15:01 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAFNEJTP129930
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 18:14:59 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26r1yxu1v1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 18:14:59 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Tue, 15 Nov 2016 16:14:58 -0700
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
Subject: [PATCH 06/14] cxlflash: Allocate memory instead of using command pool
 for AFU sync
Date: Tue, 15 Nov 2016 17:14:52 -0600
In-Reply-To: <1479251530-22573-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1479251530-22573-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1479251692-22892-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>

As staging for the removal of the AFU command pool, remove the reliance
upon the pool for the internal AFU sync command. Instead of obtaining an
AFU command from the pool, dynamically allocate memory with the appropriate
alignment requirements. Since the AFU sync service is only executed from
the process environment, blocking is acceptable.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 51ee9ef..816d85c 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1847,8 +1847,8 @@ int cxlflash_afu_sync(struct afu *afu, ctx_hndl_t ctx_hndl_u,
 	struct cxlflash_cfg *cfg = afu->parent;
 	struct device *dev = &cfg->dev->dev;
 	struct afu_cmd *cmd = NULL;
+	char *buf = NULL;
 	int rc = 0;
-	int retry_cnt = 0;
 	static DEFINE_MUTEX(sync_active);
 
 	if (cfg->state != STATE_NORMAL) {
@@ -1857,23 +1857,23 @@ int cxlflash_afu_sync(struct afu *afu, ctx_hndl_t ctx_hndl_u,
 	}
 
 	mutex_lock(&sync_active);
-retry:
-	cmd = cmd_checkout(afu);
-	if (unlikely(!cmd)) {
-		retry_cnt++;
-		udelay(1000 * retry_cnt);
-		if (retry_cnt < MC_RETRY_CNT)
-			goto retry;
-		dev_err(dev, "%s: could not get a free command\n", __func__);
+	buf = kzalloc(sizeof(*cmd) + __alignof__(*cmd) - 1, GFP_KERNEL);
+	if (unlikely(!buf)) {
+		dev_err(dev, "%s: no memory for command\n", __func__);
 		rc = -1;
 		goto out;
 	}
 
-	pr_debug("%s: afu=%p cmd=%p %d\n", __func__, afu, cmd, ctx_hndl_u);
+	cmd = (struct afu_cmd *)PTR_ALIGN(buf, __alignof__(*cmd));
+	init_completion(&cmd->cevent);
+	spin_lock_init(&cmd->slock);
+	cmd->parent = afu;
 
-	memset(cmd->rcb.cdb, 0, sizeof(cmd->rcb.cdb));
+	pr_debug("%s: afu=%p cmd=%p %d\n", __func__, afu, cmd, ctx_hndl_u);
 
 	cmd->rcb.req_flags = SISL_REQ_FLAGS_AFU_CMD;
+	cmd->rcb.ctx_id = afu->ctx_hndl;
+	cmd->rcb.msi = SISL_MSI_RRQ_UPDATED;
 	cmd->rcb.port_sel = 0x0;	/* NA */
 	cmd->rcb.lun_id = 0x0;	/* NA */
 	cmd->rcb.data_len = 0x0;
@@ -1899,8 +1899,7 @@ int cxlflash_afu_sync(struct afu *afu, ctx_hndl_t ctx_hndl_u,
 		rc = -1;
 out:
 	mutex_unlock(&sync_active);
-	if (cmd)
-		cmd_checkin(cmd);
+	kfree(buf);
 	pr_debug("%s: returning rc=%d\n", __func__, rc);
 	return rc;
 }
-- 
2.1.0
