Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 248C71A036D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 08:58:22 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 14:58:21 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 468C619D8048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 14:46:14 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24LwI6Y34406600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 21:58:18 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24Lrxh6030768
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 16:54:00 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 5/7] cxlflash: Reorder user context initialization
Date: Fri,  4 Mar 2016 15:55:18 -0600
Message-Id: <1457128520-53056-5-git-send-email-ukrishn@linux.vnet.ibm.com>
In-Reply-To: <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support cxlflash in the PowerVM environment, underlying
hypervisor APIs have imposed a kernel API ordering change.

For the superpipe access to LUN, user applications need a context.
The cxlflash module creates this context by making a sequence of
cxl calls. In the current code, a context is initialized via
cxl_dev_context_init() followed by cxl_process_element(), a function
that obtains the process element id. Finally, cxl_start_work()
is called to attach the process element.

In the PowerVM environment, a process element id cannot be obtained
from the hypervisor until the process element is attached. The
cxlflash module is unable to create contexts without a valid
process element id.

To fix this problem, cxl_start_work() is called before obtaining
the process element id.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/superpipe.c | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index 7ec0b7a..d8a5cb3 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -1386,6 +1386,13 @@ static int cxlflash_disk_attach(struct scsi_device *sdev,
 		goto out_attach;
 	}
 
+	ctxi = create_context(cfg);
+	if (unlikely(!ctxi)) {
+		dev_err(dev, "%s: Failed to create context! (%d)\n",
+			__func__, ctxid);
+		goto err;
+	}
+
 	ctx = cxl_dev_context_init(cfg->dev);
 	if (IS_ERR_OR_NULL(ctx)) {
 		dev_err(dev, "%s: Could not initialize context %p\n",
@@ -1394,6 +1401,17 @@ static int cxlflash_disk_attach(struct scsi_device *sdev,
 		goto err;
 	}
 
+	work = &ctxi->work;
+	work->num_interrupts = attach->num_interrupts;
+	work->flags = CXL_START_WORK_NUM_IRQS;
+
+	rc = cxl_start_work(ctx, work);
+	if (unlikely(rc)) {
+		dev_dbg(dev, "%s: Could not start context rc=%d\n",
+			__func__, rc);
+		goto err;
+	}
+
 	ctxid = cxl_process_element(ctx);
 	if (unlikely((ctxid >= MAX_CONTEXT) || (ctxid < 0))) {
 		dev_err(dev, "%s: ctxid (%d) invalid!\n", __func__, ctxid);
@@ -1411,27 +1429,9 @@ static int cxlflash_disk_attach(struct scsi_device *sdev,
 	/* Translate read/write O_* flags from fcntl.h to AFU permission bits */
 	perms = SISL_RHT_PERM(attach->hdr.flags + 1);
 
-	ctxi = create_context(cfg);
-	if (unlikely(!ctxi)) {
-		dev_err(dev, "%s: Failed to create context! (%d)\n",
-			__func__, ctxid);
-		goto err;
-	}
-
 	/* Context mutex is locked upon return */
 	init_context(ctxi, cfg, ctx, ctxid, fd, file, perms);
 
-	work = &ctxi->work;
-	work->num_interrupts = attach->num_interrupts;
-	work->flags = CXL_START_WORK_NUM_IRQS;
-
-	rc = cxl_start_work(ctx, work);
-	if (unlikely(rc)) {
-		dev_dbg(dev, "%s: Could not start context rc=%d\n",
-			__func__, rc);
-		goto err;
-	}
-
 	rc = afu_attach(cfg, ctxi);
 	if (unlikely(rc)) {
 		dev_err(dev, "%s: Could not attach AFU rc %d\n", __func__, rc);
@@ -1532,24 +1532,24 @@ static int recover_context(struct cxlflash_cfg *cfg, struct ctx_info *ctxi)
 		goto out;
 	}
 
+	rc = cxl_start_work(ctx, &ctxi->work);
+	if (unlikely(rc)) {
+		dev_dbg(dev, "%s: Could not start context rc=%d\n",
+			__func__, rc);
+		goto err1;
+	}
+
 	ctxid = cxl_process_element(ctx);
 	if (unlikely((ctxid >= MAX_CONTEXT) || (ctxid < 0))) {
 		dev_err(dev, "%s: ctxid (%d) invalid!\n", __func__, ctxid);
 		rc = -EPERM;
-		goto err1;
+		goto err2;
 	}
 
 	file = cxl_get_fd(ctx, &cfg->cxl_fops, &fd);
 	if (unlikely(fd < 0)) {
 		rc = -ENODEV;
 		dev_err(dev, "%s: Could not get file descriptor\n", __func__);
-		goto err1;
-	}
-
-	rc = cxl_start_work(ctx, &ctxi->work);
-	if (unlikely(rc)) {
-		dev_dbg(dev, "%s: Could not start context rc=%d\n",
-			__func__, rc);
 		goto err2;
 	}
 
@@ -1594,10 +1594,10 @@ out:
 	return rc;
 
 err3:
-	cxl_stop_context(ctx);
-err2:
 	fput(file);
 	put_unused_fd(fd);
+err2:
+	cxl_stop_context(ctx);
 err1:
 	cxl_release_context(ctx);
 	goto out;
-- 
2.1.0
