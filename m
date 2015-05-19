Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3E4F1A0709
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:23:19 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Subject: [PATCH 12/19] cxl: Export some symbols
Date: Tue, 19 May 2015 21:22:29 +1000
Message-Id: <1432034556-32400-13-git-send-email-mikey@neuling.org>
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

These will soon be using elsewhere in the driver.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/misc/cxl/cxl.h    | 5 +++++
 drivers/misc/cxl/native.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 8180680..15e1077 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -632,6 +632,9 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 		     struct address_space *mapping);
 void cxl_context_free(struct cxl_context *ctx);
 int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma);
+unsigned int cxl_map_irq(struct cxl *adapter, irq_hw_number_t hwirq,
+			 irq_handler_t handler, void *cookie, const char *name);
+void cxl_unmap_irq(unsigned int virq, void *cookie);
 int __detach_context(struct cxl_context *ctx);
 
 /* This matches the layout of the H_COLLECT_CA_INT_INFO retbuf */
@@ -646,6 +649,7 @@ struct cxl_irq_info {
 	u64 padding[3]; /* to match the expected retbuf size for plpar_hcall9 */
 };
 
+void assign_psn_space(struct cxl_context *ctx);
 int cxl_attach_process(struct cxl_context *ctx, bool kernel, u64 wed,
 			    u64 amr);
 int cxl_detach_process(struct cxl_context *ctx);
@@ -658,6 +662,7 @@ int cxl_afu_slbia(struct cxl_afu *afu);
 int cxl_tlb_slb_invalidate(struct cxl *adapter);
 int cxl_afu_disable(struct cxl_afu *afu);
 int __cxl_afu_reset(struct cxl_afu *afu);
+int afu_check_and_enable(struct cxl_afu *afu);
 int cxl_psl_purge(struct cxl_afu *afu);
 
 void cxl_stop_trace(struct cxl *cxl);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index f85b6ae..f643bb1 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -83,7 +83,7 @@ int __cxl_afu_reset(struct cxl_afu *afu)
 			   false);
 }
 
-static int afu_check_and_enable(struct cxl_afu *afu)
+int afu_check_and_enable(struct cxl_afu *afu)
 {
 	if (afu->enabled)
 		return 0;
@@ -379,7 +379,7 @@ static int remove_process_element(struct cxl_context *ctx)
 }
 
 
-static void assign_psn_space(struct cxl_context *ctx)
+void assign_psn_space(struct cxl_context *ctx)
 {
 	if (!ctx->afu->pp_size || ctx->master) {
 		ctx->psn_phys = ctx->afu->psn_phys;
-- 
2.1.0
