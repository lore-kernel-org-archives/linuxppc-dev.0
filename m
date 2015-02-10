Return-Path: <rusty@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2286B1A016E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 17:54:49 +1100 (AEDT)
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Michael Neuling" <michael.neuling@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] cxl: export symbols required for modules to use the API.
Date: Tue, 10 Feb 2015 17:23:33 +1030
Message-Id: <1423551214-10209-1-git-send-email-rusty@rustcorp.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/misc/cxl/api.c  | 11 ++++++++++-
 drivers/misc/cxl/vphb.c |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index c7263ed..95d7b67 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -31,11 +31,13 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 
 	return ctx;
 }
+EXPORT_SYMBOL_GPL(cxl_dev_context_init);
 
 void cxl_release_context(struct cxl_context *ctx)
 {
 	cxl_context_free(ctx);
 }
+EXPORT_SYMBOL_GPL(cxl_release_context);
 
 int cxl_allocate_afu_irqs(struct cxl_context *ctx, int num)
 {
@@ -43,11 +45,13 @@ int cxl_allocate_afu_irqs(struct cxl_context *ctx, int num)
 		num = ctx->afu->pp_irqs;
 	return afu_allocate_irqs(ctx, num);
 }
+EXPORT_SYMBOL_GPL(cxl_allocate_afu_irqs);
 
 void cxl_free_afu_irqs(struct cxl_context *ctx)
 {
 	cxl_release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
 }
+EXPORT_SYMBOL_GPL(cxl_free_afu_irqs);
 
 static irq_hw_number_t cxl_find_afu_irq(struct cxl_context *ctx, int num)
 {
@@ -80,6 +84,7 @@ int cxl_map_afu_irq(struct cxl_context *ctx, int num,
 
 	return cxl_map_irq(ctx->afu->adapter, hwirq, handler, cookie, name);
 }
+EXPORT_SYMBOL_GPL(cxl_map_afu_irq);
 
 void cxl_unmap_afu_irq(struct cxl_context *ctx, int num, void *cookie)
 {
@@ -94,7 +99,7 @@ void cxl_unmap_afu_irq(struct cxl_context *ctx, int num, void *cookie)
 	if (virq)
 		cxl_unmap_irq(virq, cookie);
 }
-
+EXPORT_SYMBOL_GPL(cxl_unmap_afu_irq);
 
 /*
  * Start a context
@@ -127,12 +132,14 @@ out:
 	mutex_unlock(&ctx->status_mutex);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(cxl_start_context);
 
 /* Stop a context */
 void cxl_stop_context(struct cxl_context *ctx)
 {
 	___detach_context(ctx);
 }
+EXPORT_SYMBOL_GPL(cxl_stop_context);
 
 void __iomem *cxl_psa_map(struct cxl_context *ctx)
 {
@@ -147,8 +154,10 @@ void __iomem *cxl_psa_map(struct cxl_context *ctx)
 		 __func__, afu->psn_phys, afu->adapter->ps_size);
 	return ioremap(afu->psn_phys, afu->adapter->ps_size);
 }
+EXPORT_SYMBOL_GPL(cxl_psa_map);
 
 void cxl_psa_unmap(void __iomem *addr)
 {
 	iounmap(addr);
 }
+EXPORT_SYMBOL_GPL(cxl_psa_unmap);
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 102f2f0..40215f8 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -189,3 +189,4 @@ struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev, unsigned int *cfg_record)
 
 	return afu;
 }
+EXPORT_SYMBOL_GPL(cxl_pci_to_afu);
-- 
2.1.0
