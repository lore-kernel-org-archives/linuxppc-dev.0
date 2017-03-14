Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjBny42VDzDqYd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 22:09:26 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2EB8fsm163876
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 07:09:24 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 296f3vh0uf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 07:09:24 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 11:09:22 -0000
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH V2 5/6] cxl: Isolate few psl8 specific calls
Date: Tue, 14 Mar 2017 12:08:41 +0100
In-Reply-To: <1489489722-935-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1489489722-935-1-git-send-email-clombard@linux.vnet.ibm.com>
Message-Id: <1489489722-935-6-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Point out the specific Coherent Accelerator Interface Architecture,
level 1, registers.
Code and functions specific to PSL8 (CAIA1) must be framed.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/context.c | 28 +++++++++++---------
 drivers/misc/cxl/cxl.h     | 35 +++++++++++++++++++------
 drivers/misc/cxl/debugfs.c |  6 +++--
 drivers/misc/cxl/fault.c   | 14 +++++-----
 drivers/misc/cxl/native.c  | 58 ++++++++++++++++++++++++++---------------
 drivers/misc/cxl/pci.c     | 64 +++++++++++++++++++++++++++++++---------------
 6 files changed, 136 insertions(+), 69 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index ed0a447..0fd3cf8 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -39,23 +39,26 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
 {
 	int i;
 
-	spin_lock_init(&ctx->sste_lock);
+	if (cxl_is_psl8(afu))
+		spin_lock_init(&ctx->sste_lock);
 	ctx->afu = afu;
 	ctx->master = master;
 	ctx->pid = NULL; /* Set in start work ioctl */
 	mutex_init(&ctx->mapping_lock);
 	ctx->mapping = NULL;
 
-	/*
-	 * Allocate the segment table before we put it in the IDR so that we
-	 * can always access it when dereferenced from IDR. For the same
-	 * reason, the segment table is only destroyed after the context is
-	 * removed from the IDR.  Access to this in the IOCTL is protected by
-	 * Linux filesytem symantics (can't IOCTL until open is complete).
-	 */
-	i = cxl_alloc_sst(ctx);
-	if (i)
-		return i;
+	if (cxl_is_psl8(afu)) {
+		/*
+		 * Allocate the segment table before we put it in the IDR so that we
+		 * can always access it when dereferenced from IDR. For the same
+		 * reason, the segment table is only destroyed after the context is
+		 * removed from the IDR.  Access to this in the IOCTL is protected by
+		 * Linux filesytem symantics (can't IOCTL until open is complete).
+		 */
+		i = cxl_alloc_sst(ctx);
+		if (i)
+			return i;
+	}
 
 	INIT_WORK(&ctx->fault_work, cxl_handle_fault);
 
@@ -307,7 +310,8 @@ static void reclaim_ctx(struct rcu_head *rcu)
 {
 	struct cxl_context *ctx = container_of(rcu, struct cxl_context, rcu);
 
-	free_page((u64)ctx->sstp);
+	if (cxl_is_psl8(ctx->afu))
+		free_page((u64)ctx->sstp);
 	if (ctx->ff_page)
 		__free_page(ctx->ff_page);
 	ctx->sstp = NULL;
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 1f04238..f6a3a34 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -73,7 +73,7 @@ static const cxl_p1_reg_t CXL_PSL_Control = {0x0020};
 static const cxl_p1_reg_t CXL_PSL_DLCNTL  = {0x0060};
 static const cxl_p1_reg_t CXL_PSL_DLADDR  = {0x0068};
 
-/* PSL Lookaside Buffer Management Area */
+/* PSL Lookaside Buffer Management Area - CAIA 1 */
 static const cxl_p1_reg_t CXL_PSL_LBISEL  = {0x0080};
 static const cxl_p1_reg_t CXL_PSL_SLBIE   = {0x0088};
 static const cxl_p1_reg_t CXL_PSL_SLBIA   = {0x0090};
@@ -82,7 +82,7 @@ static const cxl_p1_reg_t CXL_PSL_TLBIA   = {0x00A8};
 static const cxl_p1_reg_t CXL_PSL_AFUSEL  = {0x00B0};
 
 /* 0x00C0:7EFF Implementation dependent area */
-/* PSL registers */
+/* PSL registers - CAIA 1 */
 static const cxl_p1_reg_t CXL_PSL_FIR1      = {0x0100};
 static const cxl_p1_reg_t CXL_PSL_FIR2      = {0x0108};
 static const cxl_p1_reg_t CXL_PSL_Timebase  = {0x0110};
@@ -109,7 +109,7 @@ static const cxl_p1n_reg_t CXL_PSL_AMBAR_An       = {0x10};
 static const cxl_p1n_reg_t CXL_PSL_SPOffset_An    = {0x18};
 static const cxl_p1n_reg_t CXL_PSL_ID_An          = {0x20};
 static const cxl_p1n_reg_t CXL_PSL_SERR_An        = {0x28};
-/* Memory Management and Lookaside Buffer Management */
+/* Memory Management and Lookaside Buffer Management - CAIA 1*/
 static const cxl_p1n_reg_t CXL_PSL_SDR_An         = {0x30};
 static const cxl_p1n_reg_t CXL_PSL_AMOR_An        = {0x38};
 /* Pointer Area */
@@ -124,6 +124,7 @@ static const cxl_p1n_reg_t CXL_PSL_IVTE_Limit_An  = {0xB8};
 /* 0xC0:FF Implementation Dependent Area */
 static const cxl_p1n_reg_t CXL_PSL_FIR_SLICE_An   = {0xC0};
 static const cxl_p1n_reg_t CXL_AFU_DEBUG_An       = {0xC8};
+/* 0xC0:FF Implementation Dependent Area - CAIA 1 */
 static const cxl_p1n_reg_t CXL_PSL_APCALLOC_A     = {0xD0};
 static const cxl_p1n_reg_t CXL_PSL_COALLOC_A      = {0xD8};
 static const cxl_p1n_reg_t CXL_PSL_RXCTL_A        = {0xE0};
@@ -133,12 +134,14 @@ static const cxl_p1n_reg_t CXL_PSL_SLICE_TRACE    = {0xE8};
 /* Configuration and Control Area */
 static const cxl_p2n_reg_t CXL_PSL_PID_TID_An = {0x000};
 static const cxl_p2n_reg_t CXL_CSRP_An        = {0x008};
+/* Configuration and Control Area - CAIA 1 */
 static const cxl_p2n_reg_t CXL_AURP0_An       = {0x010};
 static const cxl_p2n_reg_t CXL_AURP1_An       = {0x018};
 static const cxl_p2n_reg_t CXL_SSTP0_An       = {0x020};
 static const cxl_p2n_reg_t CXL_SSTP1_An       = {0x028};
+/* Configuration and Control Area - CAIA 1 */
 static const cxl_p2n_reg_t CXL_PSL_AMR_An     = {0x030};
-/* Segment Lookaside Buffer Management */
+/* Segment Lookaside Buffer Management - CAIA 1 */
 static const cxl_p2n_reg_t CXL_SLBIE_An       = {0x040};
 static const cxl_p2n_reg_t CXL_SLBIA_An       = {0x048};
 static const cxl_p2n_reg_t CXL_SLBI_Select_An = {0x050};
@@ -257,7 +260,7 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_SSTP1_An_STVA_L_MASK (~((1ull << (63-55))-1))
 #define CXL_SSTP1_An_V              (1ull << (63-63))
 
-/****** CXL_PSL_SLBIE_[An] **************************************************/
+/****** CXL_PSL_SLBIE_[An] - CAIA 1 **************************************************/
 /* write: */
 #define CXL_SLBIE_C        PPC_BIT(36)         /* Class */
 #define CXL_SLBIE_SS       PPC_BITMASK(37, 38) /* Segment Size */
@@ -267,10 +270,10 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_SLBIE_MAX      PPC_BITMASK(24, 31)
 #define CXL_SLBIE_PENDING  PPC_BITMASK(56, 63)
 
-/****** Common to all CXL_TLBIA/SLBIA_[An] **********************************/
+/****** Common to all CXL_TLBIA/SLBIA_[An] - CAIA 1 **********************************/
 #define CXL_TLB_SLB_P          (1ull) /* Pending (read) */
 
-/****** Common to all CXL_TLB/SLB_IA/IE_[An] registers **********************/
+/****** Common to all CXL_TLB/SLB_IA/IE_[An] registers - CAIA 1 **********************/
 #define CXL_TLB_SLB_IQ_ALL     (0ull) /* Inv qualifier */
 #define CXL_TLB_SLB_IQ_LPID    (1ull) /* Inv qualifier */
 #define CXL_TLB_SLB_IQ_LPIDPID (3ull) /* Inv qualifier */
@@ -278,7 +281,7 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 /****** CXL_PSL_AFUSEL ******************************************************/
 #define CXL_PSL_AFUSEL_A (1ull << (63-55)) /* Adapter wide invalidates affect all AFUs */
 
-/****** CXL_PSL_DSISR_An ****************************************************/
+/****** CXL_PSL_DSISR_An - CAIA 1 ****************************************************/
 #define CXL_PSL_DSISR_An_DS (1ull << (63-0))  /* Segment not found */
 #define CXL_PSL_DSISR_An_DM (1ull << (63-1))  /* PTE not found (See also: M) or protection fault */
 #define CXL_PSL_DSISR_An_ST (1ull << (63-2))  /* Segment Table PTE not found */
@@ -749,6 +752,22 @@ static inline u64 cxl_p2n_read(struct cxl_afu *afu, cxl_p2n_reg_t reg)
 		return ~0ULL;
 }
 
+static inline bool cxl_is_power8(void)
+{
+	if ((pvr_version_is(PVR_POWER8E)) ||
+	    (pvr_version_is(PVR_POWER8NVL)) ||
+	    (pvr_version_is(PVR_POWER8)))
+		return true;
+	return false;
+}
+
+static inline bool cxl_is_psl8(struct cxl_afu *afu)
+{
+	if (afu->adapter->caia_major == 1)
+		return true;
+	return false;
+}
+
 ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
 				loff_t off, size_t count);
 
diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index 2ff10a9..43a1a27 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -94,6 +94,9 @@ void cxl_debugfs_adapter_remove(struct cxl *adapter)
 
 void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir)
 {
+	debugfs_create_io_x64("sstp0", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP0_An));
+	debugfs_create_io_x64("sstp1", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP1_An));
+
 	debugfs_create_io_x64("fir", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_FIR_SLICE_An));
 	debugfs_create_io_x64("serr", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SERR_An));
 	debugfs_create_io_x64("afu_debug", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_AFU_DEBUG_An));
@@ -117,8 +120,7 @@ int cxl_debugfs_afu_add(struct cxl_afu *afu)
 	debugfs_create_io_x64("sr",         S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SR_An));
 	debugfs_create_io_x64("dsisr",      S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_PSL_DSISR_An));
 	debugfs_create_io_x64("dar",        S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_PSL_DAR_An));
-	debugfs_create_io_x64("sstp0",      S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP0_An));
-	debugfs_create_io_x64("sstp1",      S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP1_An));
+
 	debugfs_create_io_x64("err_status", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_PSL_ErrStat_An));
 
 	if (afu->adapter->native->sl_ops->debugfs_add_afu_regs)
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 14a5bfa..9b72b90 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -231,12 +231,14 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		}
 	}
 
-	if (dsisr & CXL_PSL_DSISR_An_DS)
-		cxl_handle_segment_miss(ctx, mm, dar);
-	else if (dsisr & CXL_PSL_DSISR_An_DM)
-		cxl_handle_page_fault(ctx, mm, dsisr, dar);
-	else
-		WARN(1, "cxl_handle_fault has nothing to handle\n");
+	if (cxl_is_psl8(ctx->afu)) {
+		if (dsisr & CXL_PSL_DSISR_An_DS)
+			cxl_handle_segment_miss(ctx, mm, dar);
+		else if (dsisr & CXL_PSL_DSISR_An_DM)
+			cxl_handle_page_fault(ctx, mm, dsisr, dar);
+		else
+			WARN(1, "cxl_handle_fault has nothing to handle\n");
+	}
 
 	if (mm)
 		mmput(mm);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index ea08605..51aefcb 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -155,16 +155,25 @@ int cxl_psl_purge(struct cxl_afu *afu)
 		}
 
 		dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
-		pr_devel_ratelimited("PSL purging... PSL_CNTL: 0x%016llx  PSL_DSISR: 0x%016llx\n", PSL_CNTL, dsisr);
-		if (dsisr & CXL_PSL_DSISR_TRANS) {
-			dar = cxl_p2n_read(afu, CXL_PSL_DAR_An);
-			dev_notice(&afu->dev, "PSL purge terminating pending translation, DSISR: 0x%016llx, DAR: 0x%016llx\n", dsisr, dar);
-			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
-		} else if (dsisr) {
-			dev_notice(&afu->dev, "PSL purge acknowledging pending non-translation fault, DSISR: 0x%016llx\n", dsisr);
-			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
-		} else {
-			cpu_relax();
+		pr_devel_ratelimited("PSL purging... PSL_CNTL: 0x%016llx"
+				     "  PSL_DSISR: 0x%016llx\n",
+				     PSL_CNTL, dsisr);
+		if (cxl_is_psl8(afu)) {
+			if (dsisr & CXL_PSL_DSISR_TRANS) {
+				dar = cxl_p2n_read(afu, CXL_PSL_DAR_An);
+				dev_notice(&afu->dev, "PSL purge terminating "
+						      "pending translation, "
+						      "DSISR: 0x%016llx, DAR: 0x%016llx\n",
+						       dsisr, dar);
+				cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
+			} else if (dsisr) {
+				dev_notice(&afu->dev, "PSL purge acknowledging "
+						      "pending non-translation fault, "
+						      "DSISR: 0x%016llx\n", dsisr);
+				cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
+			} else {
+				cpu_relax();
+			}
 		}
 		PSL_CNTL = cxl_p1n_read(afu, CXL_PSL_SCNTL_An);
 	}
@@ -466,7 +475,8 @@ static int remove_process_element(struct cxl_context *ctx)
 
 	if (!rc)
 		ctx->pe_inserted = false;
-	slb_invalid(ctx);
+	if (cxl_is_power8())
+		slb_invalid(ctx);
 	pr_devel("%s Remove pe: %i finished\n", __func__, ctx->pe);
 	mutex_unlock(&ctx->afu->native->spa_mutex);
 
@@ -499,7 +509,8 @@ static int activate_afu_directed(struct cxl_afu *afu)
 	attach_spa(afu);
 
 	cxl_p1n_write(afu, CXL_PSL_SCNTL_An, CXL_PSL_SCNTL_An_PM_AFU);
-	cxl_p1n_write(afu, CXL_PSL_AMOR_An, 0xFFFFFFFFFFFFFFFFULL);
+	if (cxl_is_power8())
+		cxl_p1n_write(afu, CXL_PSL_AMOR_An, 0xFFFFFFFFFFFFFFFFULL);
 	cxl_p1n_write(afu, CXL_PSL_ID_An, CXL_PSL_ID_An_F | CXL_PSL_ID_An_L);
 
 	afu->current_mode = CXL_MODE_DIRECTED;
@@ -872,7 +883,8 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
 
 	info->dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
 	info->dar = cxl_p2n_read(afu, CXL_PSL_DAR_An);
-	info->dsr = cxl_p2n_read(afu, CXL_PSL_DSR_An);
+	if (cxl_is_power8())
+		info->dsr = cxl_p2n_read(afu, CXL_PSL_DSR_An);
 	info->afu_err = cxl_p2n_read(afu, CXL_AFU_ERR_An);
 	info->errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
 	info->proc_handle = 0;
@@ -984,7 +996,8 @@ static void native_irq_wait(struct cxl_context *ctx)
 		if (ph != ctx->pe)
 			return;
 		dsisr = cxl_p2n_read(ctx->afu, CXL_PSL_DSISR_An);
-		if ((dsisr & CXL_PSL_DSISR_PENDING) == 0)
+		if (cxl_is_psl8(ctx->afu) &&
+		   ((dsisr & CXL_PSL_DSISR_PENDING) == 0))
 			return;
 		/*
 		 * We are waiting for the workqueue to process our
@@ -1001,21 +1014,25 @@ static void native_irq_wait(struct cxl_context *ctx)
 static irqreturn_t native_slice_irq_err(int irq, void *data)
 {
 	struct cxl_afu *afu = data;
-	u64 fir_slice, errstat, serr, afu_debug, afu_error, dsisr;
+	u64 errstat, serr, afu_error, dsisr;
+	u64 fir_slice, afu_debug;
 
 	/*
 	 * slice err interrupt is only used with full PSL (no XSL)
 	 */
 	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
-	fir_slice = cxl_p1n_read(afu, CXL_PSL_FIR_SLICE_An);
 	errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
-	afu_debug = cxl_p1n_read(afu, CXL_AFU_DEBUG_An);
 	afu_error = cxl_p2n_read(afu, CXL_AFU_ERR_An);
 	dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
 	cxl_afu_decode_psl_serr(afu, serr);
-	dev_crit(&afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
+
+	if (cxl_is_power8()) {
+		fir_slice = cxl_p1n_read(afu, CXL_PSL_FIR_SLICE_An);
+		afu_debug = cxl_p1n_read(afu, CXL_AFU_DEBUG_An);
+		dev_crit(&afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
+		dev_crit(&afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
+	}
 	dev_crit(&afu->dev, "CXL_PSL_ErrStat_An: 0x%016llx\n", errstat);
-	dev_crit(&afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
 	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
 	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
 
@@ -1108,7 +1125,8 @@ int cxl_native_register_serr_irq(struct cxl_afu *afu)
 	}
 
 	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
-	serr = (serr & 0x00ffffffffff0000ULL) | (afu->serr_hwirq & 0xffff);
+	if (cxl_is_power8())
+		serr = (serr & 0x00ffffffffff0000ULL) | (afu->serr_hwirq & 0xffff);
 	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
 
 	return 0;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index b952527..5880092 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -324,32 +324,33 @@ static void dump_afu_descriptor(struct cxl_afu *afu)
 #undef show_reg
 }
 
-#define CAPP_UNIT0_ID 0xBA
-#define CAPP_UNIT1_ID 0XBE
+#define P8_CAPP_UNIT0_ID 0xBA
+#define P8_CAPP_UNIT1_ID 0XBE
 
 static u64 get_capp_unit_id(struct device_node *np)
 {
 	u32 phb_index;
 
-	/*
-	 * For chips other than POWER8NVL, we only have CAPP 0,
-	 * irrespective of which PHB is used.
-	 */
-	if (!pvr_version_is(PVR_POWER8NVL))
-		return CAPP_UNIT0_ID;
+	if (of_property_read_u32(np, "ibm,phb-index", &phb_index))
+		return 0;
 
 	/*
-	 * For POWER8NVL, assume CAPP 0 is attached to PHB0 and
-	 * CAPP 1 is attached to PHB1.
+	 * POWER 8:
+	 *  - For chips other than POWER8NVL, we only have CAPP 0,
+	 *    irrespective of which PHB is used.
+	 *  - For POWER8NVL, assume CAPP 0 is attached to PHB0 and
+	 *    CAPP 1 is attached to PHB1.
 	 */
-	if (of_property_read_u32(np, "ibm,phb-index", &phb_index))
-		return 0;
+	if (cxl_is_power8()) {
+		if (!pvr_version_is(PVR_POWER8NVL))
+			return P8_CAPP_UNIT0_ID;
 
-	if (phb_index == 0)
-		return CAPP_UNIT0_ID;
+		if (phb_index == 0)
+			return P8_CAPP_UNIT0_ID;
 
-	if (phb_index == 1)
-		return CAPP_UNIT1_ID;
+		if (phb_index == 1)
+			return P8_CAPP_UNIT1_ID;
+	}
 
 	return 0;
 }
@@ -968,7 +969,7 @@ static int cxl_afu_descriptor_looks_ok(struct cxl_afu *afu)
 	}
 
 	if (afu->pp_psa && (afu->pp_size < PAGE_SIZE))
-		dev_warn(&afu->dev, "AFU uses < PAGE_SIZE per-process PSA!");
+		dev_warn(&afu->dev, "AFU uses pp_size(%#016llx) < PAGE_SIZE per-process PSA!\n", afu->pp_size);
 
 	for (i = 0; i < afu->crs_num; i++) {
 		rc = cxl_ops->afu_cr_read32(afu, i, 0, &val);
@@ -1251,8 +1252,13 @@ int cxl_pci_reset(struct cxl *adapter)
 
 	dev_info(&dev->dev, "CXL reset\n");
 
-	/* the adapter is about to be reset, so ignore errors */
-	cxl_data_cache_flush(adapter);
+	/*
+	 * The adapter is about to be reset, so ignore errors.
+	 * Not supported on P9 DD1 but don't forget to enable it
+	 * on P9 DD2
+	 */
+	if (cxl_is_power8())
+		cxl_data_cache_flush(adapter);
 
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
 	 * PERST assert/deassert.  PERST triggers a loading of the image
@@ -1382,6 +1388,14 @@ static void cxl_fixup_malformed_tlp(struct cxl *adapter, struct pci_dev *dev)
 	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, data);
 }
 
+static bool cxl_compatible_caia_version(struct cxl *adapter)
+{
+	if (cxl_is_power8() && (adapter->caia_major == 1))
+		return true;
+
+	return false;
+}
+
 static int cxl_vsec_looks_ok(struct cxl *adapter, struct pci_dev *dev)
 {
 	if (adapter->vsec_status & CXL_STATUS_SECOND_PORT)
@@ -1392,6 +1406,12 @@ static int cxl_vsec_looks_ok(struct cxl *adapter, struct pci_dev *dev)
 		return -EINVAL;
 	}
 
+	if (!cxl_compatible_caia_version(adapter)) {
+		dev_info(&dev->dev, "Ignoring card. PSL type is not supported "
+				    "(caia version: %d)\n", adapter->caia_major);
+		return -ENODEV;
+	}
+
 	if (!adapter->slices) {
 		/* Once we support dynamic reprogramming we can use the card if
 		 * it supports loadable AFUs */
@@ -1566,8 +1586,10 @@ static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
 		adapter->native->sl_ops = &xsl_ops;
 		adapter->min_pe = 1; /* Workaround for CX-4 hardware bug */
 	} else {
-		dev_info(&dev->dev, "Device uses a PSL8\n");
-		adapter->native->sl_ops = &psl8_ops;
+		if (cxl_is_power8()) {
+			dev_info(&dev->dev, "Device uses a PSL8\n");
+			adapter->native->sl_ops = &psl8_ops;
+		}
 	}
 }
 
-- 
2.7.4
