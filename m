Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJNXh1rb7zDvvk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 10:15:32 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAFNEB5M000783
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 18:15:29 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26rbr1892u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 18:15:29 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Tue, 15 Nov 2016 16:15:29 -0700
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
Subject: [PATCH 09/14] cxlflash: Wait for active AFU commands to timeout upon
 tear down
Date: Tue, 15 Nov 2016 17:15:19 -0600
In-Reply-To: <1479251530-22573-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1479251530-22573-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1479251719-23002-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>

With the removal of the static private command pool, the ability to
'complete' outstanding commands was lost. While not an issue for the
commands originating outside the driver, internal AFU commands are
synchronous and therefore have a timeout associated with them. To
avoid a stale memory access, the tear down sequence needs to ensure
that there are not any active commands before proceeding. As these
internal AFU commands are rare events, the simplest way to accomplish
this is detecting the activity and waiting for it to timeout.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/common.h | 1 +
 drivers/scsi/cxlflash/main.c   | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
index 465330f..5e5651ba 100644
--- a/drivers/scsi/cxlflash/common.h
+++ b/drivers/scsi/cxlflash/common.h
@@ -181,6 +181,7 @@ struct afu {
 	u64 *hrrq_curr;
 	bool toggle;
 	bool read_room;
+	atomic_t cmds_active;	/* Number of currently active AFU commands */
 	atomic64_t room;
 	u64 hb;
 	u32 internal_lun;	/* User-desired LUN mode for this AFU */
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index a17bff2..f192b1c 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -556,7 +556,7 @@ static void free_mem(struct cxlflash_cfg *cfg)
  *
  * Safe to call with AFU in a partially allocated/initialized state.
  *
- * Cleans up all state associated with the command queue, and unmaps
+ * Waits for any active internal AFU commands to timeout and then unmaps
  * the MMIO space.
  */
 static void stop_afu(struct cxlflash_cfg *cfg)
@@ -564,6 +564,8 @@ static void stop_afu(struct cxlflash_cfg *cfg)
 	struct afu *afu = cfg->afu;
 
 	if (likely(afu)) {
+		while (atomic_read(&afu->cmds_active))
+			ssleep(1);
 		if (likely(afu->afu_map)) {
 			cxl_psa_unmap((void __iomem *)afu->afu_map);
 			afu->afu_map = NULL;
@@ -1745,6 +1747,7 @@ int cxlflash_afu_sync(struct afu *afu, ctx_hndl_t ctx_hndl_u,
 	}
 
 	mutex_lock(&sync_active);
+	atomic_inc(&afu->cmds_active);
 	buf = kzalloc(sizeof(*cmd) + __alignof__(*cmd) - 1, GFP_KERNEL);
 	if (unlikely(!buf)) {
 		dev_err(dev, "%s: no memory for command\n", __func__);
@@ -1786,6 +1789,7 @@ int cxlflash_afu_sync(struct afu *afu, ctx_hndl_t ctx_hndl_u,
 		     (cmd->sa.host_use_b[0] & B_ERROR)))
 		rc = -1;
 out:
+	atomic_dec(&afu->cmds_active);
 	mutex_unlock(&sync_active);
 	kfree(buf);
 	pr_debug("%s: returning rc=%d\n", __func__, rc);
-- 
2.1.0
