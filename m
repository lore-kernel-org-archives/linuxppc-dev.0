Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 90DE71A0E24
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 11:01:30 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH] cxl: Fix refcounting in kernel API
Date: Tue,  7 Jul 2015 11:01:17 +1000
Message-Id: <1436230877-14542-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the kernel API AFU dev refcounting is done on context start and stop.
This patch moves this refcounting to context init and release, bringing it
inline with how the userspace API does it.

Without this we've seen the refcounting on the AFU get out of whack between the
user and kernel API usage.  This causes the AFU structures to be freed when
they are actually still in use.

This fixes some kref warnings we've been seeing and spurious ErrIVTE IRQs.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
mpe: This is for 4.2 fixes

 drivers/misc/cxl/api.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 0c77240..729e085 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -23,6 +23,7 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 
 	afu = cxl_pci_to_afu(dev);
 
+	get_device(&afu->dev);
 	ctx = cxl_context_alloc();
 	if (IS_ERR(ctx))
 		return ctx;
@@ -31,6 +32,7 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 	rc = cxl_context_init(ctx, afu, false, NULL);
 	if (rc) {
 		kfree(ctx);
+		put_device(&afu->dev);
 		return ERR_PTR(-ENOMEM);
 	}
 	cxl_assign_psn_space(ctx);
@@ -60,6 +62,8 @@ int cxl_release_context(struct cxl_context *ctx)
 	if (ctx->status != CLOSED)
 		return -EBUSY;
 
+	put_device(&ctx->afu->dev);
+
 	cxl_context_free(ctx);
 
 	return 0;
@@ -159,7 +163,6 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 	}
 
 	ctx->status = STARTED;
-	get_device(&ctx->afu->dev);
 out:
 	mutex_unlock(&ctx->status_mutex);
 	return rc;
@@ -175,12 +178,7 @@ EXPORT_SYMBOL_GPL(cxl_process_element);
 /* Stop a context.  Returns 0 on success, otherwise -Errno */
 int cxl_stop_context(struct cxl_context *ctx)
 {
-	int rc;
-
-	rc = __detach_context(ctx);
-	if (!rc)
-		put_device(&ctx->afu->dev);
-	return rc;
+	return __detach_context(ctx);
 }
 EXPORT_SYMBOL_GPL(cxl_stop_context);
 
-- 
2.1.0
