Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D95B31A1628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 10:22:25 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v2 11/21] cxl: Rework detach context functions
Date: Tue, 26 May 2015 10:20:08 +1000
Message-Id: <1432599618-26844-12-git-send-email-mikey@neuling.org>
In-Reply-To: <1432599618-26844-1-git-send-email-mikey@neuling.org>
References: <1432599618-26844-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rework __detach_context() and cxl_context_detach() so we can reuse them in the
kernel API.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 20 +++++++++++++-------
 drivers/misc/cxl/cxl.h     |  1 +
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 36bb8e4..7d857b7 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -174,7 +174,7 @@ int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma)
  * return until all outstanding interrupts for this context have completed. The
  * hardware should no longer access *ctx after this has returned.
  */
-static void __detach_context(struct cxl_context *ctx)
+int __detach_context(struct cxl_context *ctx)
 {
 	enum cxl_context_status status;
 
@@ -183,12 +183,10 @@ static void __detach_context(struct cxl_context *ctx)
 	ctx->status = CLOSED;
 	mutex_unlock(&ctx->status_mutex);
 	if (status != STARTED)
-		return;
+		return -EBUSY;
 
 	WARN_ON(cxl_detach_process(ctx));
-	afu_release_irqs(ctx, ctx);
-	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
-	wake_up_all(&ctx->wq);
+	return 0;
 }
 
 /*
@@ -199,7 +197,15 @@ static void __detach_context(struct cxl_context *ctx)
  */
 void cxl_context_detach(struct cxl_context *ctx)
 {
-	__detach_context(ctx);
+	int rc;
+
+	rc = __detach_context(ctx);
+	if (rc)
+		return;
+
+	afu_release_irqs(ctx, ctx);
+	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
+	wake_up_all(&ctx->wq);
 }
 
 /*
@@ -216,7 +222,7 @@ void cxl_context_detach_all(struct cxl_afu *afu)
 		 * Anything done in here needs to be setup before the IDR is
 		 * created and torn down after the IDR removed
 		 */
-		__detach_context(ctx);
+		cxl_context_detach(ctx);
 
 		/*
 		 * We are force detaching - remove any active PSA mappings so
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 7c014b8..296a077 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -632,6 +632,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 		     struct address_space *mapping);
 void cxl_context_free(struct cxl_context *ctx);
 int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma);
+int __detach_context(struct cxl_context *ctx);
 
 /* This matches the layout of the H_COLLECT_CA_INT_INFO retbuf */
 struct cxl_irq_info {
-- 
2.1.0
