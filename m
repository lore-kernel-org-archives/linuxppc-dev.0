Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B246B1A065D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:23:16 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Subject: [PATCH 09/19] cxl: Add cookie parameter to afu_release_irqs()
Date: Tue, 19 May 2015 21:22:26 +1000
Message-Id: <1432034556-32400-10-git-send-email-mikey@neuling.org>
In-Reply-To: <1432034556-32400-1-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
Cc: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com,
 Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add cookie parameter to afu_release_irqs() so that we can pass in a different
cookie than the context structure.  This will be useful for other kernel
drivers that want to call this but get their own cookie back in the interrupt
handler.

Update all existing call sites.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/misc/cxl/context.c | 2 +-
 drivers/misc/cxl/cxl.h     | 2 +-
 drivers/misc/cxl/file.c    | 2 +-
 drivers/misc/cxl/irq.c     | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 78ce990..36bb8e4 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -186,7 +186,7 @@ static void __detach_context(struct cxl_context *ctx)
 		return;
 
 	WARN_ON(cxl_detach_process(ctx));
-	afu_release_irqs(ctx);
+	afu_release_irqs(ctx, ctx);
 	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
 	wake_up_all(&ctx->wq);
 }
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index f0b6727..7c014b8 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -609,7 +609,7 @@ void cxl_release_psl_err_irq(struct cxl *adapter);
 int cxl_register_serr_irq(struct cxl_afu *afu);
 void cxl_release_serr_irq(struct cxl_afu *afu);
 int afu_register_irqs(struct cxl_context *ctx, u32 count);
-void afu_release_irqs(struct cxl_context *ctx);
+void afu_release_irqs(struct cxl_context *ctx, void *cookie);
 irqreturn_t cxl_slice_irq_err(int irq, void *data);
 
 int cxl_debugfs_init(void);
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 2364bca..5377c8b 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -191,7 +191,7 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 
 	if ((rc = cxl_attach_process(ctx, false, work.work_element_descriptor,
 				     amr))) {
-		afu_release_irqs(ctx);
+		afu_release_irqs(ctx, ctx);
 		goto out;
 	}
 
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index c8929c5..c740c7b 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -477,7 +477,7 @@ out:
 	return -ENOMEM;
 }
 
-void afu_release_irqs(struct cxl_context *ctx)
+void afu_release_irqs(struct cxl_context *ctx, void *cookie)
 {
 	irq_hw_number_t hwirq;
 	unsigned int virq;
@@ -488,7 +488,7 @@ void afu_release_irqs(struct cxl_context *ctx)
 		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
 			virq = irq_find_mapping(NULL, hwirq);
 			if (virq)
-				cxl_unmap_irq(virq, ctx);
+				cxl_unmap_irq(virq, cookie);
 		}
 	}
 
-- 
2.1.0
