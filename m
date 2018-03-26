Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40904F4c85zF22l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:30:21 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGU6UQ015178
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:30:19 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gy326m55n-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:30:18 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 12:30:17 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 01/41] cxlflash: Preserve number of interrupts for master
 contexts
Date: Mon, 26 Mar 2018 11:29:56 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522081796-57486-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The number of interrupts requested for user contexts are stored in the
context specific structures and utilized to manage the interrupts. For the
master contexts, this number is only used once and therefore not saved.

To prepare for future commits where the number of interrupts will be
required in more than one place, preserve the value in the master context
structure.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/common.h |  1 +
 drivers/scsi/cxlflash/main.c   | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
index 102fd26..5d7ca01 100644
--- a/drivers/scsi/cxlflash/common.h
+++ b/drivers/scsi/cxlflash/common.h
@@ -211,6 +211,7 @@ struct hwq {
 	struct sisl_ctrl_map __iomem *ctrl_map;		/* MC control map */
 	ctx_hndl_t ctx_hndl;	/* master's context handle */
 	u32 index;		/* Index of this hwq */
+	int num_irqs;		/* Numer of interrupts requested for context */
 	struct list_head pending_cmds;	/* Commands pending completion */
 
 	atomic_t hsq_credits;
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index d8fe7ab8..3d3e003 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1911,7 +1911,7 @@ static enum undo_level init_intr(struct cxlflash_cfg *cfg,
 	int rc = 0;
 	enum undo_level level = UNDO_NOOP;
 	bool is_primary_hwq = (hwq->index == PRIMARY_HWQ);
-	int num_irqs = is_primary_hwq ? 3 : 2;
+	int num_irqs = hwq->num_irqs;
 
 	rc = cfg->ops->allocate_afu_irqs(ctx, num_irqs);
 	if (unlikely(rc)) {
@@ -1965,16 +1965,20 @@ static int init_mc(struct cxlflash_cfg *cfg, u32 index)
 	struct device *dev = &cfg->dev->dev;
 	struct hwq *hwq = get_hwq(cfg->afu, index);
 	int rc = 0;
+	int num_irqs;
 	enum undo_level level;
 
 	hwq->afu = cfg->afu;
 	hwq->index = index;
 	INIT_LIST_HEAD(&hwq->pending_cmds);
 
-	if (index == PRIMARY_HWQ)
+	if (index == PRIMARY_HWQ) {
 		ctx = cfg->ops->get_context(cfg->dev, cfg->afu_cookie);
-	else
+		num_irqs = 3;
+	} else {
 		ctx = cfg->ops->dev_context_init(cfg->dev, cfg->afu_cookie);
+		num_irqs = 2;
+	}
 	if (IS_ERR_OR_NULL(ctx)) {
 		rc = -ENOMEM;
 		goto err1;
@@ -1982,6 +1986,7 @@ static int init_mc(struct cxlflash_cfg *cfg, u32 index)
 
 	WARN_ON(hwq->ctx_cookie);
 	hwq->ctx_cookie = ctx;
+	hwq->num_irqs = num_irqs;
 
 	/* Set it up as a master with the CXL */
 	cfg->ops->set_master(ctx);
-- 
2.1.0
