Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd27p3g5bzF1C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:26:30 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w194NkuU084564
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Feb 2018 23:26:28 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g11rmwwdh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 23:26:28 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 04:26:26 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
Subject: [PATCH 1/3] cxl: Introduce various enums/defines for PSL9 trace arrays
Date: Fri,  9 Feb 2018 09:55:33 +0530
In-Reply-To: <20180209042535.16845-1-vaibhav@linux.vnet.ibm.com>
References: <20180209042535.16845-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20180209042535.16845-2-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We introduce a new enum named cxl_psl9_traceid that represents
individual trace-arrays available on PSL9. In addition a set of new
defines named s CXL_PSL9_TRACESTATE_XXX are introduced that represent
various states a trace-array can be in. Value of each define is the
value reported by PSL_CTCCFG register for the corresponding state of
trace-array. Also a new macro named CXL_PSL9_TRACE_STATE() is
introduced that makes it convenient to evaluate state of a trace-array
from the PSL_CTCCFG register.

The patch re-factors cxl_stop_trace_psl9() to use these new
enums/defines and renames 'cxl_service_layer_ops.debugfs_stoptrace'
function pointer to 'cxl_service_layer_ops.stop_psltrace'.

This patch shouldn't cause any behavioral changes.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h    | 29 ++++++++++++++++++++++++++---
 drivers/misc/cxl/native.c |  8 ++++----
 drivers/misc/cxl/pci.c    | 15 +++++++--------
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 4f015da78f28..81da307b60c0 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -418,8 +418,31 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_CARD_MINOR(adapter) (adapter->adapter_num * CXL_DEV_MINORS)
 #define CXL_DEVT_ADAPTER(dev) (MINOR(dev) / CXL_DEV_MINORS)
 
-#define CXL_PSL9_TRACEID_MAX 0xAU
-#define CXL_PSL9_TRACESTATE_FIN 0x3U
+/* Various trace arrays available on PSL9 */
+enum cxl_psl9_traceid {
+	CXL_PSL9_TRACEID_RX0 = 0,
+	CXL_PSL9_TRACEID_RX1, /* 1 */
+	CXL_PSL9_TRACEID_XSL, /* 2 */
+	CXL_PSL9_TRACEID_CT0, /* 3 */
+	CXL_PSL9_TRACEID_CT1, /* 4 */
+	CXL_PSL9_TRACEID_LA0, /* 5 */
+	CXL_PSL9_TRACEID_LA1, /* 6 */
+	CXL_PSL9_TRACEID_JM0, /* 7 */
+	CXL_PSL9_TRACEID_DMA0, /* 8 */
+	CXL_PSL9_TRACEID_DMA1, /* 9 */
+	CXL_PSL9_TRACEID_REOA, /* 10 */
+	CXL_PSL9_TRACEID_MAX
+};
+
+/* State of tracearray as reported in PSL9_CTCCFG */
+#define CXL_PSL9_TRACESTATE_IDLE	0x0U
+#define CXL_PSL9_TRACESTATE_INIT	0x1U
+#define CXL_PSL9_TRACESTATE_WFT		0x2U
+#define CXL_PSL9_TRACESTATE_FIN		0x3U
+
+/* Find the Trace Array state from PSL9_CTCCFG Reg */
+#define CXL_PSL9_TRACE_STATE(STATE, TRACE_ID)		\
+	((STATE) >> (62 - (TRACE_ID) * 2) & 0x3)
 
 enum cxl_context_status {
 	CLOSED,
@@ -654,7 +677,7 @@ struct cxl_service_layer_ops {
 	void (*debugfs_add_afu_regs)(struct cxl_afu *afu, struct dentry *dir);
 	void (*psl_irq_dump_registers)(struct cxl_context *ctx);
 	void (*err_irq_dump_registers)(struct cxl *adapter);
-	void (*debugfs_stop_trace)(struct cxl *adapter);
+	void (*stop_psltrace)(struct cxl *adapter);
 	void (*write_timebase_ctrl)(struct cxl *adapter);
 	u64 (*timebase_read)(struct cxl *adapter);
 	int capi_mode;
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 1b3d7c65ea3f..bba9e1bb8b4d 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -1135,9 +1135,9 @@ static irqreturn_t native_handle_psl_slice_error(struct cxl_context *ctx,
 	if (ctx->afu->adapter->native->sl_ops->psl_irq_dump_registers)
 		ctx->afu->adapter->native->sl_ops->psl_irq_dump_registers(ctx);
 
-	if (ctx->afu->adapter->native->sl_ops->debugfs_stop_trace) {
+	if (ctx->afu->adapter->native->sl_ops->stop_psltrace) {
 		dev_crit(&ctx->afu->dev, "STOPPING CXL TRACE\n");
-		ctx->afu->adapter->native->sl_ops->debugfs_stop_trace(ctx->afu->adapter);
+		ctx->afu->adapter->native->sl_ops->stop_psltrace(ctx->afu->adapter);
 	}
 
 	return cxl_ops->ack_irq(ctx, 0, errstat);
@@ -1303,9 +1303,9 @@ static irqreturn_t native_irq_err(int irq, void *data)
 	err_ivte = cxl_p1_read(adapter, CXL_PSL_ErrIVTE);
 	dev_crit(&adapter->dev, "PSL_ErrIVTE: 0x%016llx\n", err_ivte);
 
-	if (adapter->native->sl_ops->debugfs_stop_trace) {
+	if (adapter->native->sl_ops->stop_psltrace) {
 		dev_crit(&adapter->dev, "STOPPING CXL TRACE\n");
-		adapter->native->sl_ops->debugfs_stop_trace(adapter);
+		adapter->native->sl_ops->stop_psltrace(adapter);
 	}
 
 	if (adapter->native->sl_ops->err_irq_dump_registers)
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 9bc30c20b66b..926b13973b73 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1747,15 +1747,14 @@ static void cxl_deconfigure_adapter(struct cxl *adapter)
 static void cxl_stop_trace_psl9(struct cxl *adapter)
 {
 	int traceid;
-	u64 trace_state, trace_mask;
+	u64 trace_cfg, trace_state;
 	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
 
+	trace_cfg = cxl_p1_read(adapter, CXL_PSL9_CTCCFG);
 	/* read each tracearray state and issue mmio to stop them is needed */
-	for (traceid = 0; traceid <= CXL_PSL9_TRACEID_MAX; ++traceid) {
-		trace_state = cxl_p1_read(adapter, CXL_PSL9_CTCCFG);
-		trace_mask = (0x3ULL << (62 - traceid * 2));
-		trace_state = (trace_state & trace_mask) >> (62 - traceid * 2);
-		dev_dbg(&dev->dev, "cxl: Traceid-%d trace_state=0x%0llX\n",
+	for (traceid = 0; traceid < CXL_PSL9_TRACEID_MAX; ++traceid) {
+		trace_state = CXL_PSL9_TRACE_STATE(trace_cfg, traceid);
+		dev_dbg(&dev->dev, "Traceid-%d trace_state=0x%0llX\n",
 			traceid, trace_state);
 
 		/* issue mmio if the trace array isn't in FIN state */
@@ -1799,7 +1798,7 @@ static const struct cxl_service_layer_ops psl9_ops = {
 	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl9,
 	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl9,
 	.err_irq_dump_registers = cxl_native_err_irq_dump_regs_psl9,
-	.debugfs_stop_trace = cxl_stop_trace_psl9,
+	.stop_psltrace = cxl_stop_trace_psl9,
 	.timebase_read = timebase_read_psl9,
 	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
 	.needs_reset_before_disable = true,
@@ -1822,7 +1821,7 @@ static const struct cxl_service_layer_ops psl8_ops = {
 	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl8,
 	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl8,
 	.err_irq_dump_registers = cxl_native_err_irq_dump_regs_psl8,
-	.debugfs_stop_trace = cxl_stop_trace_psl8,
+	.stop_psltrace = cxl_stop_trace_psl8,
 	.write_timebase_ctrl = write_timebase_ctrl_psl8,
 	.timebase_read = timebase_read_psl8,
 	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
-- 
2.14.3
