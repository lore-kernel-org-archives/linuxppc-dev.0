Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87BF21A002B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 11:59:02 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CA855140778
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:59:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 30 Sep 2015 11:59:00 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 01F7E3578053
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:58:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U1wmCZ60358708
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:58:56 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U1wNCq030177
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:58:24 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: imunsie@au1.ibm.com, mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com
Subject: [PATCH 1/3] cxl: fix leak of IRQ names in cxl_free_afu_irqs()
Date: Wed, 30 Sep 2015 11:58:05 +1000
Message-Id: <1443578287-7847-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cxl_free_afu_irqs() doesn't free IRQ names when it releases an AFU's IRQ
ranges. The userspace API equivalent in afu_release_irqs() calls
afu_irq_name_free() to release the IRQ names.

Call afu_irq_name_free() in cxl_free_afu_irqs() to release the IRQ names.
Make afu_irq_name_free() non-static to allow this.

Reported-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/api.c | 1 +
 drivers/misc/cxl/cxl.h | 1 +
 drivers/misc/cxl/irq.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 8af12c8..103baf0 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -105,6 +105,7 @@ EXPORT_SYMBOL_GPL(cxl_allocate_afu_irqs);
 
 void cxl_free_afu_irqs(struct cxl_context *ctx)
 {
+	afu_irq_name_free(ctx);
 	cxl_release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
 }
 EXPORT_SYMBOL_GPL(cxl_free_afu_irqs);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 1c30ef7..0cfb9c1 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -677,6 +677,7 @@ int cxl_register_serr_irq(struct cxl_afu *afu);
 void cxl_release_serr_irq(struct cxl_afu *afu);
 int afu_register_irqs(struct cxl_context *ctx, u32 count);
 void afu_release_irqs(struct cxl_context *ctx, void *cookie);
+void afu_irq_name_free(struct cxl_context *ctx);
 irqreturn_t cxl_slice_irq_err(int irq, void *data);
 
 int cxl_debugfs_init(void);
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 583b42a..38b57d6 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -414,7 +414,7 @@ void cxl_release_psl_irq(struct cxl_afu *afu)
 	kfree(afu->psl_irq_name);
 }
 
-static void afu_irq_name_free(struct cxl_context *ctx)
+void afu_irq_name_free(struct cxl_context *ctx)
 {
 	struct cxl_irq_name *irq_name, *tmp;
 
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
