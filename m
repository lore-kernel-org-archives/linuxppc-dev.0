Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69F231A0611
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 15:04:58 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 16 Nov 2015 14:04:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C45E02BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 15:04:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAG44d6637421260
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 15:04:47 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAG44K2T003250
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 15:04:21 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, mikey@neuling.org,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Fix possible idr warning when contexts are released
Date: Mon, 16 Nov 2015 09:33:45 +0530
Message-Id: <1447646625-28854-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An idr warning is reported when a context is release after the capi card
is unbound from the cxl driver via sysfs. Below are the steps to
reproduce:

1. Create multiple afu contexts in an user-space application using libcxl.
2. Unbind capi card from cxl using command of form
   echo <capi-card-pci-addr> > /sys/bus/pci/drivers/cxl-pci/unbind
3. Exit/kill the application owning afu contexts.

After above steps a warning message is usually seen in the kernel logs
of the form "idr_remove called for id=<context-id> which is not
allocated."

This is caused by the function cxl_release_afu which destroys the
contexts_idr table. So when a context is release no entry for context pe
is found in the contexts_idr table and idr code prints this warning.

This patch fixes this issue by increasing & decreasing the ref-count on
the afu device when a context is initialized or when its freed
respectively. This prevents the afu from being released until all the
afu contexts have been released. The patch introduces two new functions
namely cxl_afu_get/put that manage the ref-count on the afu device.

Also the patch removes code inside cxl_dev_context_init that increases ref
on the afu device as its guaranteed to be alive during this function.

Reported-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c     |  4 ----
 drivers/misc/cxl/context.c |  9 +++++++++
 drivers/misc/cxl/cxl.h     | 12 ++++++++++++
 drivers/misc/cxl/file.c    | 19 +++++++++++--------
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 103baf0..a6543ae 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -25,7 +25,6 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 
 	afu = cxl_pci_to_afu(dev);
 
-	get_device(&afu->dev);
 	ctx = cxl_context_alloc();
 	if (IS_ERR(ctx)) {
 		rc = PTR_ERR(ctx);
@@ -61,7 +60,6 @@ err_mapping:
 err_ctx:
 	kfree(ctx);
 err_dev:
-	put_device(&afu->dev);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_GPL(cxl_dev_context_init);
@@ -87,8 +85,6 @@ int cxl_release_context(struct cxl_context *ctx)
 	if (ctx->status >= STARTED)
 		return -EBUSY;
 
-	put_device(&ctx->afu->dev);
-
 	cxl_context_free(ctx);
 
 	return 0;
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 2faa127..6dde7a9 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -97,6 +97,12 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 	ctx->pe = i;
 	ctx->elem = &ctx->afu->spa[i];
 	ctx->pe_inserted = false;
+
+	/*
+	 * take a ref on the afu so that it stays alive at-least till
+	 * this context is reclaimed inside reclaim_ctx.
+	 */
+	cxl_afu_get(afu);
 	return 0;
 }
 
@@ -278,6 +284,9 @@ static void reclaim_ctx(struct rcu_head *rcu)
 	if (ctx->irq_bitmap)
 		kfree(ctx->irq_bitmap);
 
+	/* Drop ref to the afu device taken during cxl_context_init */
+	cxl_afu_put(ctx->afu);
+
 	kfree(ctx);
 }
 
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 0cfb9c1..25ae57f 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -403,6 +403,18 @@ struct cxl_afu {
 	bool enabled;
 };
 
+/* AFU refcount management */
+static inline struct cxl_afu *cxl_afu_get(struct cxl_afu *afu)
+{
+
+	return (get_device(&afu->dev) == NULL) ? NULL : afu;
+}
+
+static inline void  cxl_afu_put(struct cxl_afu *afu)
+{
+	put_device(&afu->dev);
+}
+
 
 struct cxl_irq_name {
 	struct list_head list;
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 7ccd299..5cc1459 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -67,7 +67,13 @@ static int __afu_open(struct inode *inode, struct file *file, bool master)
 		spin_unlock(&adapter->afu_list_lock);
 		goto err_put_adapter;
 	}
-	get_device(&afu->dev);
+
+	/*
+	 * taking a ref to the afu so that it doesn't go away
+	 * for rest of the function. This ref is released before
+	 * we return.
+	 */
+	cxl_afu_get(afu);
 	spin_unlock(&adapter->afu_list_lock);
 
 	if (!afu->current_mode)
@@ -90,13 +96,12 @@ static int __afu_open(struct inode *inode, struct file *file, bool master)
 	file->private_data = ctx;
 	cxl_ctx_get();
 
-	/* Our ref on the AFU will now hold the adapter */
-	put_device(&adapter->dev);
-
-	return 0;
+	/* indicate success */
+	rc = 0;
 
 err_put_afu:
-	put_device(&afu->dev);
+	/* release the ref taken earlier */
+	cxl_afu_put(afu);
 err_put_adapter:
 	put_device(&adapter->dev);
 	return rc;
@@ -131,8 +136,6 @@ int afu_release(struct inode *inode, struct file *file)
 		mutex_unlock(&ctx->mapping_lock);
 	}
 
-	put_device(&ctx->afu->dev);
-
 	/*
 	 * At this this point all bottom halfs have finished and we should be
 	 * getting no more IRQs from the hardware for this context.  Once it's
-- 
2.2.1
