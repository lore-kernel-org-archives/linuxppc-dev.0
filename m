Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 918DC1A0038
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2016 01:07:30 +1100 (AEDT)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Sat, 30 Jan 2016 14:07:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 04FDE1B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 14:07:34 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0UE7PF110224006
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 14:07:25 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0UE7OeV031030
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 09:07:25 -0500
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 05/16] cxl: Isolate a few bare-metal-specific calls
Date: Sat, 30 Jan 2016 15:07:08 +0100
Message-Id: <1454162839-24407-6-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1454162839-24407-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1454162839-24407-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A few functions are mostly common between bare-metal and guest and
just need minor tuning. To avoid crowding the backend API, introduce a
few 'if' based on the CPU being in HV mode.

Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c     |  6 ++++--
 drivers/misc/cxl/context.c |  3 ++-
 drivers/misc/cxl/cxl.h     |  7 +++++--
 drivers/misc/cxl/debugfs.c |  4 ++++
 drivers/misc/cxl/fault.c   | 19 +++++++++++--------
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 4e6bced..5be7cc58 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -51,7 +51,8 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 	if (rc)
 		goto err_mapping;
 
-	cxl_assign_psn_space(ctx);
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		cxl_assign_psn_space(ctx);
 
 	return ctx;
 
@@ -207,7 +208,8 @@ EXPORT_SYMBOL_GPL(cxl_stop_context);
 void cxl_set_master(struct cxl_context *ctx)
 {
 	ctx->master = true;
-	cxl_assign_psn_space(ctx);
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		cxl_assign_psn_space(ctx);
 }
 EXPORT_SYMBOL_GPL(cxl_set_master);
 
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index aa65262..46f9844 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -95,7 +95,8 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 		return i;
 
 	ctx->pe = i;
-	ctx->elem = &ctx->afu->spa[i];
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		ctx->elem = &ctx->afu->spa[i];
 	ctx->pe_inserted = false;
 
 	/*
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 02065b4..40f6783 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -560,8 +560,11 @@ static inline bool cxl_adapter_link_ok(struct cxl *cxl)
 {
 	struct pci_dev *pdev;
 
-	pdev = to_pci_dev(cxl->dev.parent);
-	return !pci_channel_offline(pdev);
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		pdev = to_pci_dev(cxl->dev.parent);
+		return !pci_channel_offline(pdev);
+	}
+	return true;
 }
 
 static inline void __iomem *_cxl_p1_addr(struct cxl *cxl, cxl_p1_reg_t reg)
diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index 18df6f4..5751899 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -118,6 +118,10 @@ void cxl_debugfs_afu_remove(struct cxl_afu *afu)
 int __init cxl_debugfs_init(void)
 {
 	struct dentry *ent;
+
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
+		return 0;
+
 	ent = debugfs_create_dir("cxl", NULL);
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index ab740a1..9a8650b 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -254,14 +254,17 @@ void cxl_handle_fault(struct work_struct *fault_work)
 	u64 dar = ctx->dar;
 	struct mm_struct *mm = NULL;
 
-	if (cxl_p2n_read(ctx->afu, CXL_PSL_DSISR_An) != dsisr ||
-	    cxl_p2n_read(ctx->afu, CXL_PSL_DAR_An) != dar ||
-	    cxl_p2n_read(ctx->afu, CXL_PSL_PEHandle_An) != ctx->pe) {
-		/* Most likely explanation is harmless - a dedicated process
-		 * has detached and these were cleared by the PSL purge, but
-		 * warn about it just in case */
-		dev_notice(&ctx->afu->dev, "cxl_handle_fault: Translation fault regs changed\n");
-		return;
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		if (cxl_p2n_read(ctx->afu, CXL_PSL_DSISR_An) != dsisr ||
+		    cxl_p2n_read(ctx->afu, CXL_PSL_DAR_An) != dar ||
+		    cxl_p2n_read(ctx->afu, CXL_PSL_PEHandle_An) != ctx->pe) {
+			/* Most likely explanation is harmless - a dedicated
+			 * process has detached and these were cleared by the
+			 * PSL purge, but warn about it just in case
+			 */
+			dev_notice(&ctx->afu->dev, "cxl_handle_fault: Translation fault regs changed\n");
+			return;
+		}
 	}
 
 	/* Early return if the context is being / has been detached */
-- 
1.9.1
