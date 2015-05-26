Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 042E51A0EAD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 10:22:46 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v2 13/21] cxl: Export some symbols
Date: Tue, 26 May 2015 10:20:10 +1000
Message-Id: <1432599618-26844-14-git-send-email-mikey@neuling.org>
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

Export some symbols which will soon be used elsewhere in this driver.

Now they are global we rename them so to avoid collisions.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/cxl.h    |  5 +++++
 drivers/misc/cxl/native.c | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 8180680..58a9b2b 100644
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
 
+void cxl_assign_psn_space(struct cxl_context *ctx);
 int cxl_attach_process(struct cxl_context *ctx, bool kernel, u64 wed,
 			    u64 amr);
 int cxl_detach_process(struct cxl_context *ctx);
@@ -658,6 +662,7 @@ int cxl_afu_slbia(struct cxl_afu *afu);
 int cxl_tlb_slb_invalidate(struct cxl *adapter);
 int cxl_afu_disable(struct cxl_afu *afu);
 int __cxl_afu_reset(struct cxl_afu *afu);
+int cxl_afu_check_and_enable(struct cxl_afu *afu);
 int cxl_psl_purge(struct cxl_afu *afu);
 
 void cxl_stop_trace(struct cxl *cxl);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index f85b6ae..615ccbf 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -83,7 +83,7 @@ int __cxl_afu_reset(struct cxl_afu *afu)
 			   false);
 }
 
-static int afu_check_and_enable(struct cxl_afu *afu)
+int cxl_afu_check_and_enable(struct cxl_afu *afu)
 {
 	if (afu->enabled)
 		return 0;
@@ -379,7 +379,7 @@ static int remove_process_element(struct cxl_context *ctx)
 }
 
 
-static void assign_psn_space(struct cxl_context *ctx)
+void cxl_assign_psn_space(struct cxl_context *ctx)
 {
 	if (!ctx->afu->pp_size || ctx->master) {
 		ctx->psn_phys = ctx->afu->psn_phys;
@@ -435,7 +435,7 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
 	u64 sr;
 	int r, result;
 
-	assign_psn_space(ctx);
+	cxl_assign_psn_space(ctx);
 
 	ctx->elem->ctxtime = 0; /* disable */
 	ctx->elem->lpid = cpu_to_be32(mfspr(SPRN_LPID));
@@ -477,7 +477,7 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
 	ctx->elem->common.wed = cpu_to_be64(wed);
 
 	/* first guy needs to enable */
-	if ((result = afu_check_and_enable(ctx->afu)))
+	if ((result = cxl_afu_check_and_enable(ctx->afu)))
 		return result;
 
 	add_process_element(ctx);
@@ -564,7 +564,7 @@ static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
 	cxl_p2n_write(afu, CXL_PSL_AMR_An, amr);
 
 	/* master only context for dedicated */
-	assign_psn_space(ctx);
+	cxl_assign_psn_space(ctx);
 
 	if ((rc = __cxl_afu_reset(afu)))
 		return rc;
-- 
2.1.0
