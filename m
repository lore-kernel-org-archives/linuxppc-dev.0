Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 378541A0319
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 08:39:24 +1100 (AEDT)
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 21:39:21 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 96D1F1B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:39:34 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1GLdIBu65994842
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:39:18 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1GLdHlh016193
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 14:39:18 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 06/18] cxl: Isolate a few bare-metal-specific calls
Date: Tue, 16 Feb 2016 22:38:59 +0100
Message-Id: <1455658751-16970-7-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1455658751-16970-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1455658751-16970-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c |  3 ++-
 drivers/misc/cxl/cxl.h     |  7 +++++--
 drivers/misc/cxl/debugfs.c |  4 ++++
 drivers/misc/cxl/fault.c   | 19 +++++++++++--------
 4 files changed, 22 insertions(+), 11 deletions(-)

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
