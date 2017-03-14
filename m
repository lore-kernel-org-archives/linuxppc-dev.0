Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjBny0FmDzDqYP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 22:09:25 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2EB8guX163937
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 07:09:22 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 296f3vh0ss-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 07:09:22 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 11:09:20 -0000
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH V2 3/6] cxl: Update implementation service layer
Date: Tue, 14 Mar 2017 12:08:39 +0100
In-Reply-To: <1489489722-935-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1489489722-935-1-git-send-email-clombard@linux.vnet.ibm.com>
Message-Id: <1489489722-935-4-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The service layer API (in cxl.h) lists some low-level functions whose
implementation is different on PSL8, PSL9 and XSL:
- Init implementation for the adapter and the afu.
- Invalidate TLB/SLB.
- Attach process for dedicated/directed models.
- Handle psl interrupts.
- Debug registers for the adapter and the afu.
- Traces.
Each environment implements its own functions, and the common code uses
them through function pointers, defined in cxl_service_layer_ops.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h     | 34 ++++++++++++++++++++++---------
 drivers/misc/cxl/debugfs.c | 16 +++++++--------
 drivers/misc/cxl/guest.c   |  2 +-
 drivers/misc/cxl/irq.c     |  2 +-
 drivers/misc/cxl/native.c  | 50 +++++++++++++++++++++++++++-------------------
 drivers/misc/cxl/pci.c     | 47 +++++++++++++++++++++++++++++--------------
 6 files changed, 97 insertions(+), 54 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 4d1b704..3e03a66 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -553,13 +553,23 @@ struct cxl_context {
 	struct mm_struct *mm;
 };
 
+struct cxl_irq_info;
+
 struct cxl_service_layer_ops {
 	int (*adapter_regs_init)(struct cxl *adapter, struct pci_dev *dev);
+	int (*invalidate_all)(struct cxl *adapter);
 	int (*afu_regs_init)(struct cxl_afu *afu);
+	int (*sanitise_afu_regs)(struct cxl_afu *afu);
 	int (*register_serr_irq)(struct cxl_afu *afu);
 	void (*release_serr_irq)(struct cxl_afu *afu);
-	void (*debugfs_add_adapter_sl_regs)(struct cxl *adapter, struct dentry *dir);
-	void (*debugfs_add_afu_sl_regs)(struct cxl_afu *afu, struct dentry *dir);
+	irqreturn_t (*handle_interrupt)(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
+	irqreturn_t (*fail_irq)(struct cxl_afu *afu, struct cxl_irq_info *irq_info);
+	int (*activate_dedicated_process)(struct cxl_afu *afu);
+	int (*attach_afu_directed)(struct cxl_context *ctx, u64 wed, u64 amr);
+	int (*attach_dedicated_process)(struct cxl_context *ctx, u64 wed, u64 amr);
+	void (*update_dedicated_ivtes)(struct cxl_context *ctx);
+	void (*debugfs_add_adapter_regs)(struct cxl *adapter, struct dentry *dir);
+	void (*debugfs_add_afu_regs)(struct cxl_afu *afu, struct dentry *dir);
 	void (*psl_irq_dump_registers)(struct cxl_context *ctx);
 	void (*err_irq_dump_registers)(struct cxl *adapter);
 	void (*debugfs_stop_trace)(struct cxl *adapter);
@@ -805,16 +815,21 @@ void afu_irq_name_free(struct cxl_context *ctx);
 
 #ifdef CONFIG_DEBUG_FS
 
+int cxl_attach_afu_directed_psl(struct cxl_context *ctx, u64 wed, u64 amr);
+int cxl_activate_dedicated_process_psl(struct cxl_afu *afu);
+int cxl_attach_dedicated_process_psl(struct cxl_context *ctx, u64 wed, u64 amr);
+void cxl_update_dedicated_ivtes_psl(struct cxl_context *ctx);
+
 int cxl_debugfs_init(void);
 void cxl_debugfs_exit(void);
 int cxl_debugfs_adapter_add(struct cxl *adapter);
 void cxl_debugfs_adapter_remove(struct cxl *adapter);
 int cxl_debugfs_afu_add(struct cxl_afu *afu);
 void cxl_debugfs_afu_remove(struct cxl_afu *afu);
-void cxl_stop_trace(struct cxl *cxl);
-void cxl_debugfs_add_adapter_psl_regs(struct cxl *adapter, struct dentry *dir);
-void cxl_debugfs_add_adapter_xsl_regs(struct cxl *adapter, struct dentry *dir);
-void cxl_debugfs_add_afu_psl_regs(struct cxl_afu *afu, struct dentry *dir);
+void cxl_stop_trace_psl(struct cxl *cxl);
+void cxl_debugfs_add_adapter_regs_psl(struct cxl *adapter, struct dentry *dir);
+void cxl_debugfs_add_adapter_regs_xsl(struct cxl *adapter, struct dentry *dir);
+void cxl_debugfs_add_afu_regs_psl(struct cxl_afu *afu, struct dentry *dir);
 
 #else /* CONFIG_DEBUG_FS */
 
@@ -916,19 +931,20 @@ struct cxl_irq_info {
 };
 
 void cxl_assign_psn_space(struct cxl_context *ctx);
-irqreturn_t cxl_irq(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
+int cxl_invalidate_all_psl(struct cxl *adapter);
+irqreturn_t cxl_irq_psl(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
+irqreturn_t cxl_fail_irq_psl(struct cxl_afu *afu, struct cxl_irq_info *irq_info);
 int cxl_register_one_irq(struct cxl *adapter, irq_handler_t handler,
 			void *cookie, irq_hw_number_t *dest_hwirq,
 			unsigned int *dest_virq, const char *name);
 
 int cxl_check_error(struct cxl_afu *afu);
 int cxl_afu_slbia(struct cxl_afu *afu);
-int cxl_tlb_slb_invalidate(struct cxl *adapter);
 int cxl_data_cache_flush(struct cxl *adapter);
 int cxl_afu_disable(struct cxl_afu *afu);
 int cxl_psl_purge(struct cxl_afu *afu);
 
-void cxl_native_psl_irq_dump_regs(struct cxl_context *ctx);
+void cxl_native_irq_dump_regs_psl(struct cxl_context *ctx);
 void cxl_native_err_irq_dump_regs(struct cxl *adapter);
 int cxl_pci_vphb_add(struct cxl_afu *afu);
 void cxl_pci_vphb_remove(struct cxl_afu *afu);
diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index 9c06ac8..4848ebf 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -15,7 +15,7 @@
 
 static struct dentry *cxl_debugfs;
 
-void cxl_stop_trace(struct cxl *adapter)
+void cxl_stop_trace_psl(struct cxl *adapter)
 {
 	int slice;
 
@@ -53,7 +53,7 @@ static struct dentry *debugfs_create_io_x64(const char *name, umode_t mode,
 					  (void __force *)value, &fops_io_x64);
 }
 
-void cxl_debugfs_add_adapter_psl_regs(struct cxl *adapter, struct dentry *dir)
+void cxl_debugfs_add_adapter_regs_psl(struct cxl *adapter, struct dentry *dir)
 {
 	debugfs_create_io_x64("fir1", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR1));
 	debugfs_create_io_x64("fir2", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR2));
@@ -61,7 +61,7 @@ void cxl_debugfs_add_adapter_psl_regs(struct cxl *adapter, struct dentry *dir)
 	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_TRACE));
 }
 
-void cxl_debugfs_add_adapter_xsl_regs(struct cxl *adapter, struct dentry *dir)
+void cxl_debugfs_add_adapter_regs_xsl(struct cxl *adapter, struct dentry *dir)
 {
 	debugfs_create_io_x64("fec", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_XSL_FEC));
 }
@@ -82,8 +82,8 @@ int cxl_debugfs_adapter_add(struct cxl *adapter)
 
 	debugfs_create_io_x64("err_ivte", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_ErrIVTE));
 
-	if (adapter->native->sl_ops->debugfs_add_adapter_sl_regs)
-		adapter->native->sl_ops->debugfs_add_adapter_sl_regs(adapter, dir);
+	if (adapter->native->sl_ops->debugfs_add_adapter_regs)
+		adapter->native->sl_ops->debugfs_add_adapter_regs(adapter, dir);
 	return 0;
 }
 
@@ -92,7 +92,7 @@ void cxl_debugfs_adapter_remove(struct cxl *adapter)
 	debugfs_remove_recursive(adapter->debugfs);
 }
 
-void cxl_debugfs_add_afu_psl_regs(struct cxl_afu *afu, struct dentry *dir)
+void cxl_debugfs_add_afu_regs_psl(struct cxl_afu *afu, struct dentry *dir)
 {
 	debugfs_create_io_x64("fir", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_FIR_SLICE_An));
 	debugfs_create_io_x64("serr", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SERR_An));
@@ -121,8 +121,8 @@ int cxl_debugfs_afu_add(struct cxl_afu *afu)
 	debugfs_create_io_x64("sstp1",      S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP1_An));
 	debugfs_create_io_x64("err_status", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_PSL_ErrStat_An));
 
-	if (afu->adapter->native->sl_ops->debugfs_add_afu_sl_regs)
-		afu->adapter->native->sl_ops->debugfs_add_afu_sl_regs(afu, dir);
+	if (afu->adapter->native->sl_ops->debugfs_add_afu_regs)
+		afu->adapter->native->sl_ops->debugfs_add_afu_regs(afu, dir);
 
 	return 0;
 }
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index e04bc4d..f6ba698 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -169,7 +169,7 @@ static irqreturn_t guest_psl_irq(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	rc = cxl_irq(irq, ctx, &irq_info);
+	rc = cxl_irq_psl(irq, ctx, &irq_info);
 	return rc;
 }
 
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 1a402bb..2fa119e 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -34,7 +34,7 @@ static irqreturn_t schedule_cxl_fault(struct cxl_context *ctx, u64 dsisr, u64 da
 	return IRQ_HANDLED;
 }
 
-irqreturn_t cxl_irq(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info)
+irqreturn_t cxl_irq_psl(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info)
 {
 	u64 dsisr, dar;
 
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 7257e8b..2d1b0c6 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -258,7 +258,7 @@ void cxl_release_spa(struct cxl_afu *afu)
 	}
 }
 
-int cxl_tlb_slb_invalidate(struct cxl *adapter)
+int cxl_invalidate_all_psl(struct cxl *adapter)
 {
 	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
 
@@ -578,7 +578,7 @@ static void update_ivtes_directed(struct cxl_context *ctx)
 		WARN_ON(add_process_element(ctx));
 }
 
-static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
+int cxl_attach_afu_directed_psl(struct cxl_context *ctx, u64 wed, u64 amr)
 {
 	u32 pid;
 	int result;
@@ -671,7 +671,7 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
 	return 0;
 }
 
-static int activate_dedicated_process(struct cxl_afu *afu)
+int cxl_activate_dedicated_process_psl(struct cxl_afu *afu)
 {
 	dev_info(&afu->dev, "Activating dedicated process mode\n");
 
@@ -694,7 +694,7 @@ static int activate_dedicated_process(struct cxl_afu *afu)
 	return cxl_chardev_d_afu_add(afu);
 }
 
-static void update_ivtes_dedicated(struct cxl_context *ctx)
+void cxl_update_dedicated_ivtes_psl(struct cxl_context *ctx)
 {
 	struct cxl_afu *afu = ctx->afu;
 
@@ -710,7 +710,7 @@ static void update_ivtes_dedicated(struct cxl_context *ctx)
 			((u64)ctx->irqs.range[3] & 0xffff));
 }
 
-static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
+int cxl_attach_dedicated_process_psl(struct cxl_context *ctx, u64 wed, u64 amr)
 {
 	struct cxl_afu *afu = ctx->afu;
 	u64 pid;
@@ -728,7 +728,8 @@ static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
 
 	cxl_prefault(ctx, wed);
 
-	update_ivtes_dedicated(ctx);
+	if (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes)
+		afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
 
 	cxl_p2n_write(afu, CXL_PSL_AMR_An, amr);
 
@@ -778,8 +779,9 @@ static int native_afu_activate_mode(struct cxl_afu *afu, int mode)
 
 	if (mode == CXL_MODE_DIRECTED)
 		return activate_afu_directed(afu);
-	if (mode == CXL_MODE_DEDICATED)
-		return activate_dedicated_process(afu);
+	if ((mode == CXL_MODE_DEDICATED) &&
+	    (afu->adapter->native->sl_ops->activate_dedicated_process))
+		return afu->adapter->native->sl_ops->activate_dedicated_process(afu);
 
 	return -EINVAL;
 }
@@ -793,11 +795,13 @@ static int native_attach_process(struct cxl_context *ctx, bool kernel,
 	}
 
 	ctx->kernel = kernel;
-	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
-		return attach_afu_directed(ctx, wed, amr);
+	if ((ctx->afu->current_mode == CXL_MODE_DIRECTED) &&
+	    (ctx->afu->adapter->native->sl_ops->attach_afu_directed))
+		return ctx->afu->adapter->native->sl_ops->attach_afu_directed(ctx, wed, amr);
 
-	if (ctx->afu->current_mode == CXL_MODE_DEDICATED)
-		return attach_dedicated(ctx, wed, amr);
+	if ((ctx->afu->current_mode == CXL_MODE_DEDICATED) &&
+	    (ctx->afu->adapter->native->sl_ops->attach_dedicated_process))
+		return ctx->afu->adapter->native->sl_ops->attach_dedicated_process(ctx, wed, amr);
 
 	return -EINVAL;
 }
@@ -830,8 +834,9 @@ static void native_update_ivtes(struct cxl_context *ctx)
 {
 	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
 		return update_ivtes_directed(ctx);
-	if (ctx->afu->current_mode == CXL_MODE_DEDICATED)
-		return update_ivtes_dedicated(ctx);
+	if ((ctx->afu->current_mode == CXL_MODE_DEDICATED) &&
+	    (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes))
+		return ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
 	WARN(1, "native_update_ivtes: Bad mode\n");
 }
 
@@ -875,7 +880,7 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
 	return 0;
 }
 
-void cxl_native_psl_irq_dump_regs(struct cxl_context *ctx)
+void cxl_native_irq_dump_regs_psl(struct cxl_context *ctx)
 {
 	u64 fir1, fir2, fir_slice, serr, afu_debug;
 
@@ -911,7 +916,7 @@ static irqreturn_t native_handle_psl_slice_error(struct cxl_context *ctx,
 	return cxl_ops->ack_irq(ctx, 0, errstat);
 }
 
-static irqreturn_t fail_psl_irq(struct cxl_afu *afu, struct cxl_irq_info *irq_info)
+irqreturn_t cxl_fail_irq_psl(struct cxl_afu *afu, struct cxl_irq_info *irq_info)
 {
 	if (irq_info->dsisr & CXL_PSL_DSISR_TRANS)
 		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
@@ -927,7 +932,7 @@ static irqreturn_t native_irq_multiplexed(int irq, void *data)
 	struct cxl_context *ctx;
 	struct cxl_irq_info irq_info;
 	u64 phreg = cxl_p2n_read(afu, CXL_PSL_PEHandle_An);
-	int ph, ret;
+	int ph, ret = IRQ_HANDLED;
 
 	/* check if eeh kicked in while the interrupt was in flight */
 	if (unlikely(phreg == ~0ULL)) {
@@ -940,13 +945,16 @@ static irqreturn_t native_irq_multiplexed(int irq, void *data)
 	ph = phreg & 0xffff;
 	if ((ret = native_get_irq_info(afu, &irq_info))) {
 		WARN(1, "Unable to get CXL IRQ Info: %i\n", ret);
-		return fail_psl_irq(afu, &irq_info);
+		if (afu->adapter->native->sl_ops->fail_irq)
+			return afu->adapter->native->sl_ops->fail_irq(afu, &irq_info);
+		return IRQ_HANDLED;
 	}
 
 	rcu_read_lock();
 	ctx = idr_find(&afu->contexts_idr, ph);
 	if (ctx) {
-		ret = cxl_irq(irq, ctx, &irq_info);
+		if (afu->adapter->native->sl_ops->handle_interrupt)
+			ret = afu->adapter->native->sl_ops->handle_interrupt(irq, ctx, &irq_info);
 		rcu_read_unlock();
 		return ret;
 	}
@@ -956,7 +964,9 @@ static irqreturn_t native_irq_multiplexed(int irq, void *data)
 		" %016llx\n(Possible AFU HW issue - was a term/remove acked"
 		" with outstanding transactions?)\n", ph, irq_info.dsisr,
 		irq_info.dar);
-	return fail_psl_irq(afu, &irq_info);
+	if (afu->adapter->native->sl_ops->fail_irq)
+		ret = afu->adapter->native->sl_ops->fail_irq(afu, &irq_info);
+	return ret;
 }
 
 static void native_irq_wait(struct cxl_context *ctx)
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index e82a207..4d475a5 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -377,7 +377,7 @@ static int calc_capp_routing(struct pci_dev *dev, u64 *chipid, u64 *capp_unit_id
 	return 0;
 }
 
-static int init_implementation_adapter_psl_regs(struct cxl *adapter, struct pci_dev *dev)
+static int init_implementation_adapter_regs_psl(struct cxl *adapter, struct pci_dev *dev)
 {
 	u64 psl_dsnctl, psl_fircntl;
 	u64 chipid;
@@ -409,7 +409,7 @@ static int init_implementation_adapter_psl_regs(struct cxl *adapter, struct pci_
 	return 0;
 }
 
-static int init_implementation_adapter_xsl_regs(struct cxl *adapter, struct pci_dev *dev)
+static int init_implementation_adapter_regs_xsl(struct cxl *adapter, struct pci_dev *dev)
 {
 	u64 xsl_dsnctl;
 	u64 chipid;
@@ -513,7 +513,7 @@ static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 	return;
 }
 
-static int init_implementation_afu_psl_regs(struct cxl_afu *afu)
+static int init_implementation_afu_regs_psl(struct cxl_afu *afu)
 {
 	/* read/write masks for this slice */
 	cxl_p1n_write(afu, CXL_PSL_APCALLOC_A, 0xFFFFFFFEFEFEFEFEULL);
@@ -996,7 +996,7 @@ static int cxl_afu_descriptor_looks_ok(struct cxl_afu *afu)
 	return 0;
 }
 
-static int sanitise_afu_regs(struct cxl_afu *afu)
+static int sanitise_afu_regs_psl(struct cxl_afu *afu)
 {
 	u64 reg;
 
@@ -1102,8 +1102,11 @@ static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pc
 	if ((rc = pci_map_slice_regs(afu, adapter, dev)))
 		return rc;
 
-	if ((rc = sanitise_afu_regs(afu)))
-		goto err1;
+	if (adapter->native->sl_ops->sanitise_afu_regs) {
+		rc = adapter->native->sl_ops->sanitise_afu_regs(afu);
+		if (rc)
+			goto err1;
+	}
 
 	/* We need to reset the AFU before we can read the AFU descriptor */
 	if ((rc = cxl_ops->afu_reset(afu)))
@@ -1432,9 +1435,15 @@ static void cxl_release_adapter(struct device *dev)
 
 static int sanitise_adapter_regs(struct cxl *adapter)
 {
+	int rc = 0;
+
 	/* Clear PSL tberror bit by writing 1 to it */
 	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, CXL_PSL_ErrIVTE_tberror);
-	return cxl_tlb_slb_invalidate(adapter);
+
+	if (adapter->native->sl_ops->invalidate_all)
+		rc = adapter->native->sl_ops->invalidate_all(adapter);
+
+	return rc;
 }
 
 /* This should contain *only* operations that can safely be done in
@@ -1518,15 +1527,23 @@ static void cxl_deconfigure_adapter(struct cxl *adapter)
 }
 
 static const struct cxl_service_layer_ops psl_ops = {
-	.adapter_regs_init = init_implementation_adapter_psl_regs,
-	.afu_regs_init = init_implementation_afu_psl_regs,
+	.adapter_regs_init = init_implementation_adapter_regs_psl,
+	.invalidate_all = cxl_invalidate_all_psl,
+	.afu_regs_init = init_implementation_afu_regs_psl,
+	.sanitise_afu_regs = sanitise_afu_regs_psl,
 	.register_serr_irq = cxl_native_register_serr_irq,
 	.release_serr_irq = cxl_native_release_serr_irq,
-	.debugfs_add_adapter_sl_regs = cxl_debugfs_add_adapter_psl_regs,
-	.debugfs_add_afu_sl_regs = cxl_debugfs_add_afu_psl_regs,
-	.psl_irq_dump_registers = cxl_native_psl_irq_dump_regs,
+	.handle_interrupt = cxl_irq_psl,
+	.fail_irq = cxl_fail_irq_psl,
+	.activate_dedicated_process = cxl_activate_dedicated_process_psl,
+	.attach_afu_directed = cxl_attach_afu_directed_psl,
+	.attach_dedicated_process = cxl_attach_dedicated_process_psl,
+	.update_dedicated_ivtes = cxl_update_dedicated_ivtes_psl,
+	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl,
+	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl,
+	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl,
 	.err_irq_dump_registers = cxl_native_err_irq_dump_regs,
-	.debugfs_stop_trace = cxl_stop_trace,
+	.debugfs_stop_trace = cxl_stop_trace_psl,
 	.write_timebase_ctrl = write_timebase_ctrl_psl,
 	.timebase_read = timebase_read_psl,
 	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
@@ -1534,8 +1551,8 @@ static const struct cxl_service_layer_ops psl_ops = {
 };
 
 static const struct cxl_service_layer_ops xsl_ops = {
-	.adapter_regs_init = init_implementation_adapter_xsl_regs,
-	.debugfs_add_adapter_sl_regs = cxl_debugfs_add_adapter_xsl_regs,
+	.adapter_regs_init = init_implementation_adapter_regs_xsl,
+	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_xsl,
 	.write_timebase_ctrl = write_timebase_ctrl_xsl,
 	.timebase_read = timebase_read_xsl,
 	.capi_mode = OPAL_PHB_CAPI_MODE_DMA,
-- 
2.7.4
