Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rD5Sr3N8jzDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 03:41:48 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 24 May 2016 03:41:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D76A13578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 03:41:43 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4NHfZ1k9240866
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 03:41:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4NHfBqS011248
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 03:41:11 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] cxl: Abstract the differences between the PSL and XSL
Date: Tue, 24 May 2016 03:39:18 +1000
Message-Id: <1464025158-23849-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

The XSL (Translation Service Layer) is a stripped down version of the
PSL (Power Service Layer) used in some cards such as the Mellanox CX4.

Like the PSL, it implements the CAIA architecture, but has a number of
differences, mostly in it's implementation dependent registers. This
adds an ops structure to abstract these differences to bring initial
support for XSL CAPI devices.

The XSL does not implement the optional architected SERR register,
however while it treats it as a reserved register and should work with
no special treatment, attempting to access it will cause the XSL_FEC
(First Error Capture) register to be filled out, preventing it from
capturing any subsequent errors. Therefore, this patch also prevents the
kernel from trying to set up the SERR register so that the FEC register
may still be useful, and to save one interrupt.

The XSL also uses a special DMA cxl mode, which uses a slightly
different init sequence for the CAPP and PHB. The kernel support for
this will be in a future patch once the corresponding support has been
merged into skiboot.

Co-authored-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/cxl.h     |  26 ++++++++
 drivers/misc/cxl/debugfs.c |  35 ++++++++---
 drivers/misc/cxl/native.c  |  53 +++++++++++-----
 drivers/misc/cxl/pci.c     | 152 ++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 218 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index d12a035..92e7f19 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -81,6 +81,7 @@ static const cxl_p1_reg_t CXL_PSL_TLBIA   = {0x00A8};
 static const cxl_p1_reg_t CXL_PSL_AFUSEL  = {0x00B0};
 
 /* 0x00C0:7EFF Implementation dependent area */
+/* PSL registers */
 static const cxl_p1_reg_t CXL_PSL_FIR1      = {0x0100};
 static const cxl_p1_reg_t CXL_PSL_FIR2      = {0x0108};
 static const cxl_p1_reg_t CXL_PSL_Timebase  = {0x0110};
@@ -91,6 +92,11 @@ static const cxl_p1_reg_t CXL_PSL_FIR_CNTL  = {0x0148};
 static const cxl_p1_reg_t CXL_PSL_DSNDCTL   = {0x0150};
 static const cxl_p1_reg_t CXL_PSL_SNWRALLOC = {0x0158};
 static const cxl_p1_reg_t CXL_PSL_TRACE     = {0x0170};
+/* XSL registers (Mellanox CX4) */
+static const cxl_p1_reg_t CXL_XSL_Timebase  = {0x0100};
+static const cxl_p1_reg_t CXL_XSL_TB_CTLSTAT = {0x0108};
+static const cxl_p1_reg_t CXL_XSL_FEC       = {0x0158};
+static const cxl_p1_reg_t CXL_XSL_DSNCTL    = {0x0168};
 /* 0x7F00:7FFF Reserved PCIe MSI-X Pending Bit Array area */
 /* 0x8000:FFFF Reserved PCIe MSI-X Table Area */
 
@@ -524,6 +530,20 @@ struct cxl_context {
 	struct rcu_head rcu;
 };
 
+struct cxl_service_layer_ops {
+	int (*adapter_regs_init)(struct cxl *adapter, struct pci_dev *dev);
+	int (*afu_regs_init)(struct cxl_afu *afu);
+	int (*register_serr_irq)(struct cxl_afu *afu);
+	void (*release_serr_irq)(struct cxl_afu *afu);
+	void (*debugfs_add_adapter_sl_regs)(struct cxl *adapter, struct dentry *dir);
+	void (*debugfs_add_afu_sl_regs)(struct cxl_afu *afu, struct dentry *dir);
+	void (*psl_irq_dump_registers)(struct cxl_context *ctx);
+	void (*err_irq_dump_registers)(struct cxl *adapter);
+	void (*debugfs_stop_trace)(struct cxl *adapter);
+	void (*write_timebase_ctrl)(struct cxl *adapter);
+	u64 (*timebase_read)(struct cxl *adapter);
+};
+
 struct cxl_native {
 	u64 afu_desc_off;
 	u64 afu_desc_size;
@@ -532,6 +552,7 @@ struct cxl_native {
 	irq_hw_number_t err_hwirq;
 	unsigned int err_virq;
 	u64 ps_off;
+	const struct cxl_service_layer_ops *sl_ops;
 };
 
 struct cxl_guest {
@@ -804,6 +825,11 @@ int cxl_tlb_slb_invalidate(struct cxl *adapter);
 int cxl_afu_disable(struct cxl_afu *afu);
 int cxl_psl_purge(struct cxl_afu *afu);
 
+void cxl_debugfs_add_adapter_psl_regs(struct cxl *adapter, struct dentry *dir);
+void cxl_debugfs_add_adapter_xsl_regs(struct cxl *adapter, struct dentry *dir);
+void cxl_debugfs_add_afu_psl_regs(struct cxl_afu *afu, struct dentry *dir);
+void cxl_native_psl_irq_dump_regs(struct cxl_context *ctx);
+void cxl_native_err_irq_dump_regs(struct cxl *adapter);
 void cxl_stop_trace(struct cxl *cxl);
 int cxl_pci_vphb_add(struct cxl_afu *afu);
 void cxl_pci_vphb_remove(struct cxl_afu *afu);
diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index 5751899..ec7b8a0 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -51,6 +51,19 @@ static struct dentry *debugfs_create_io_x64(const char *name, umode_t mode,
 	return debugfs_create_file(name, mode, parent, (void __force *)value, &fops_io_x64);
 }
 
+void cxl_debugfs_add_adapter_psl_regs(struct cxl *adapter, struct dentry *dir)
+{
+	debugfs_create_io_x64("fir1", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR1));
+	debugfs_create_io_x64("fir2", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR2));
+	debugfs_create_io_x64("fir_cntl", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR_CNTL));
+	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_TRACE));
+}
+
+void cxl_debugfs_add_adapter_xsl_regs(struct cxl *adapter, struct dentry *dir)
+{
+	debugfs_create_io_x64("fec", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_XSL_FEC));
+}
+
 int cxl_debugfs_adapter_add(struct cxl *adapter)
 {
 	struct dentry *dir;
@@ -65,13 +78,10 @@ int cxl_debugfs_adapter_add(struct cxl *adapter)
 		return PTR_ERR(dir);
 	adapter->debugfs = dir;
 
-	debugfs_create_io_x64("fir1",     S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR1));
-	debugfs_create_io_x64("fir2",     S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR2));
-	debugfs_create_io_x64("fir_cntl", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR_CNTL));
 	debugfs_create_io_x64("err_ivte", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_ErrIVTE));
 
-	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_TRACE));
-
+	if (adapter->native->sl_ops->debugfs_add_adapter_sl_regs)
+		adapter->native->sl_ops->debugfs_add_adapter_sl_regs(adapter, dir);
 	return 0;
 }
 
@@ -80,6 +90,14 @@ void cxl_debugfs_adapter_remove(struct cxl *adapter)
 	debugfs_remove_recursive(adapter->debugfs);
 }
 
+void cxl_debugfs_add_afu_psl_regs(struct cxl_afu *afu, struct dentry *dir)
+{
+	debugfs_create_io_x64("fir", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_FIR_SLICE_An));
+	debugfs_create_io_x64("serr", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SERR_An));
+	debugfs_create_io_x64("afu_debug", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_AFU_DEBUG_An));
+	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SLICE_TRACE));
+}
+
 int cxl_debugfs_afu_add(struct cxl_afu *afu)
 {
 	struct dentry *dir;
@@ -94,18 +112,15 @@ int cxl_debugfs_afu_add(struct cxl_afu *afu)
 		return PTR_ERR(dir);
 	afu->debugfs = dir;
 
-	debugfs_create_io_x64("fir",        S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_FIR_SLICE_An));
-	debugfs_create_io_x64("serr",       S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SERR_An));
-	debugfs_create_io_x64("afu_debug",  S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_AFU_DEBUG_An));
 	debugfs_create_io_x64("sr",         S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SR_An));
-
 	debugfs_create_io_x64("dsisr",      S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_PSL_DSISR_An));
 	debugfs_create_io_x64("dar",        S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_PSL_DAR_An));
 	debugfs_create_io_x64("sstp0",      S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP0_An));
 	debugfs_create_io_x64("sstp1",      S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP1_An));
 	debugfs_create_io_x64("err_status", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_PSL_ErrStat_An));
 
-	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SLICE_TRACE));
+	if (afu->adapter->native->sl_ops->debugfs_add_afu_sl_regs)
+		afu->adapter->native->sl_ops->debugfs_add_afu_sl_regs(afu, dir);
 
 	return 0;
 }
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index aa0be79..45f3f09 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -794,26 +794,38 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
 	return 0;
 }
 
-static irqreturn_t native_handle_psl_slice_error(struct cxl_context *ctx,
-						u64 dsisr, u64 errstat)
+void cxl_native_psl_irq_dump_regs(struct cxl_context *ctx)
 {
 	u64 fir1, fir2, fir_slice, serr, afu_debug;
 
 	fir1 = cxl_p1_read(ctx->afu->adapter, CXL_PSL_FIR1);
 	fir2 = cxl_p1_read(ctx->afu->adapter, CXL_PSL_FIR2);
 	fir_slice = cxl_p1n_read(ctx->afu, CXL_PSL_FIR_SLICE_An);
-	serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
 	afu_debug = cxl_p1n_read(ctx->afu, CXL_AFU_DEBUG_An);
 
-	dev_crit(&ctx->afu->dev, "PSL ERROR STATUS: 0x%016llx\n", errstat);
 	dev_crit(&ctx->afu->dev, "PSL_FIR1: 0x%016llx\n", fir1);
 	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%016llx\n", fir2);
-	dev_crit(&ctx->afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
+	if (ctx->afu->adapter->native->sl_ops->register_serr_irq) {
+		serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
+		dev_crit(&ctx->afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
+	}
 	dev_crit(&ctx->afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
 	dev_crit(&ctx->afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
+}
+
+static irqreturn_t native_handle_psl_slice_error(struct cxl_context *ctx,
+						u64 dsisr, u64 errstat)
+{
+
+	dev_crit(&ctx->afu->dev, "PSL ERROR STATUS: 0x%016llx\n", errstat);
 
-	dev_crit(&ctx->afu->dev, "STOPPING CXL TRACE\n");
-	cxl_stop_trace(ctx->afu->adapter);
+	if (ctx->afu->adapter->native->sl_ops->psl_irq_dump_registers)
+		ctx->afu->adapter->native->sl_ops->psl_irq_dump_registers(ctx);
+
+	if (ctx->afu->adapter->native->sl_ops->debugfs_stop_trace) {
+		dev_crit(&ctx->afu->dev, "STOPPING CXL TRACE\n");
+		ctx->afu->adapter->native->sl_ops->debugfs_stop_trace(ctx->afu->adapter);
+	}
 
 	return cxl_ops->ack_irq(ctx, 0, errstat);
 }
@@ -862,6 +874,9 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
 	struct cxl_afu *afu = data;
 	u64 fir_slice, errstat, serr, afu_debug;
 
+	/*
+	 * slice err interrupt is only used with full PSL (no XSL)
+	 */
 	WARN(irq, "CXL SLICE ERROR interrupt %i\n", irq);
 
 	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
@@ -878,23 +893,33 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+void cxl_native_err_irq_dump_regs(struct cxl *adapter)
+{
+	u64 fir1, fir2;
+
+	fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
+	fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
+
+	dev_crit(&adapter->dev, "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n", fir1, fir2);
+}
+
 static irqreturn_t native_irq_err(int irq, void *data)
 {
 	struct cxl *adapter = data;
-	u64 fir1, fir2, err_ivte;
+	u64 err_ivte;
 
 	WARN(1, "CXL ERROR interrupt %i\n", irq);
 
 	err_ivte = cxl_p1_read(adapter, CXL_PSL_ErrIVTE);
 	dev_crit(&adapter->dev, "PSL_ErrIVTE: 0x%016llx\n", err_ivte);
 
-	dev_crit(&adapter->dev, "STOPPING CXL TRACE\n");
-	cxl_stop_trace(adapter);
-
-	fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
-	fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
+	if (adapter->native->sl_ops->debugfs_stop_trace) {
+		dev_crit(&adapter->dev, "STOPPING CXL TRACE\n");
+		adapter->native->sl_ops->debugfs_stop_trace(adapter);
+	}
 
-	dev_crit(&adapter->dev, "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n", fir1, fir2);
+	if (adapter->native->sl_ops->err_irq_dump_registers)
+		adapter->native->sl_ops->err_irq_dump_registers(adapter);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index a08fcc8..556718d 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -352,13 +352,10 @@ static u64 get_capp_unit_id(struct device_node *np)
 	return 0;
 }
 
-static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev *dev)
+static int calc_capp_routing(struct pci_dev *dev, u64 *chipid, u64 *capp_unit_id)
 {
 	struct device_node *np;
 	const __be32 *prop;
-	u64 psl_dsnctl;
-	u64 chipid;
-	u64 capp_unit_id;
 
 	if (!(np = pnv_pci_get_phb_node(dev)))
 		return -ENODEV;
@@ -367,14 +364,28 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
 		np = of_get_next_parent(np);
 	if (!np)
 		return -ENODEV;
-	chipid = be32_to_cpup(prop);
-	capp_unit_id = get_capp_unit_id(np);
+	*chipid = be32_to_cpup(prop);
+	*capp_unit_id = get_capp_unit_id(np);
 	of_node_put(np);
-	if (!capp_unit_id) {
+	if (!*capp_unit_id) {
 		pr_err("cxl: invalid capp unit id\n");
 		return -ENODEV;
 	}
 
+	return 0;
+}
+
+static int init_implementation_adapter_psl_regs(struct cxl *adapter, struct pci_dev *dev)
+{
+	u64 psl_dsnctl;
+	u64 chipid;
+	u64 capp_unit_id;
+	int rc;
+
+	rc = calc_capp_routing(dev, &chipid, &capp_unit_id);
+	if (rc)
+		return rc;
+
 	psl_dsnctl = 0x0000900000000000ULL; /* pteupd ttype, scdone */
 	psl_dsnctl |= (0x2ULL << (63-38)); /* MMIO hang pulse: 256 us */
 	/* Tell PSL where to route data to */
@@ -393,8 +404,61 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
 	return 0;
 }
 
+static int init_implementation_adapter_xsl_regs(struct cxl *adapter, struct pci_dev *dev)
+{
+	u64 xsl_dsnctl;
+	u64 chipid;
+	u64 capp_unit_id;
+	int rc;
+
+	rc = calc_capp_routing(dev, &chipid, &capp_unit_id);
+	if (rc)
+		return rc;
+
+	/* Tell XSL where to route data to */
+	xsl_dsnctl = 0x0000600000000000ULL | (chipid << (63-5));
+	xsl_dsnctl |= (capp_unit_id << (63-13));
+	cxl_p1_write(adapter, CXL_XSL_DSNCTL, xsl_dsnctl);
+
+	return 0;
+}
+
+/* PSL & XSL */
+#define TBSYNC_CAL(n) (((u64)n & 0x7) << (63-3))
 #define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
-#define _2048_250MHZ_CYCLES 1
+/* For the PSL this is a multiple for 0 < n <= 7: */
+#define PSL_2048_250MHZ_CYCLES 1
+
+static void write_timebase_ctrl_psl(struct cxl *adapter)
+{
+	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT,
+		     TBSYNC_CNT(2 * PSL_2048_250MHZ_CYCLES));
+}
+
+/* XSL */
+#define TBSYNC_ENA (1ULL << 63)
+/* For the XSL this is 2**n * 2000 clocks for 0 < n <= 6: */
+#define XSL_2000_CLOCKS 1
+#define XSL_4000_CLOCKS 2
+#define XSL_8000_CLOCKS 3
+
+static void write_timebase_ctrl_xsl(struct cxl *adapter)
+{
+	cxl_p1_write(adapter, CXL_XSL_TB_CTLSTAT,
+		     TBSYNC_ENA |
+		     TBSYNC_CAL(3) |
+		     TBSYNC_CNT(XSL_4000_CLOCKS));
+}
+
+static u64 timebase_read_psl(struct cxl *adapter)
+{
+	return cxl_p1_read(adapter, CXL_PSL_Timebase);
+}
+
+static u64 timebase_read_xsl(struct cxl *adapter)
+{
+	return cxl_p1_read(adapter, CXL_XSL_Timebase);
+}
 
 static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 {
@@ -421,8 +485,7 @@ static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 	 * Setup PSL Timebase Control and Status register
 	 * with the recommended Timebase Sync Count value
 	 */
-	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT,
-		     TBSYNC_CNT(2 * _2048_250MHZ_CYCLES));
+	adapter->native->sl_ops->write_timebase_ctrl(adapter);
 
 	/* Enable PSL Timebase */
 	cxl_p1_write(adapter, CXL_PSL_Control, 0x0000000000000000);
@@ -435,7 +498,7 @@ static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 			dev_info(&dev->dev, "PSL timebase can't synchronize\n");
 			return;
 		}
-		psl_tb = cxl_p1_read(adapter, CXL_PSL_Timebase);
+		psl_tb = adapter->native->sl_ops->timebase_read(adapter);
 		delta = mftb() - psl_tb;
 		if (delta < 0)
 			delta = -delta;
@@ -445,7 +508,7 @@ static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 	return;
 }
 
-static int init_implementation_afu_regs(struct cxl_afu *afu)
+static int init_implementation_afu_psl_regs(struct cxl_afu *afu)
 {
 	/* read/write masks for this slice */
 	cxl_p1n_write(afu, CXL_PSL_APCALLOC_A, 0xFFFFFFFEFEFEFEFEULL);
@@ -753,11 +816,13 @@ static int sanitise_afu_regs(struct cxl_afu *afu)
 		else
 			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
 	}
-	reg = cxl_p1n_read(afu, CXL_PSL_SERR_An);
-	if (reg) {
-		if (reg & ~0xffff)
-			dev_warn(&afu->dev, "AFU had pending SERR: %#016llx\n", reg);
-		cxl_p1n_write(afu, CXL_PSL_SERR_An, reg & ~0xffff);
+	if (afu->adapter->native->sl_ops->register_serr_irq) {
+		reg = cxl_p1n_read(afu, CXL_PSL_SERR_An);
+		if (reg) {
+			if (reg & ~0xffff)
+				dev_warn(&afu->dev, "AFU had pending SERR: %#016llx\n", reg);
+			cxl_p1n_write(afu, CXL_PSL_SERR_An, reg & ~0xffff);
+		}
 	}
 	reg = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
 	if (reg) {
@@ -835,11 +900,13 @@ static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pc
 	if ((rc = cxl_afu_descriptor_looks_ok(afu)))
 		goto err1;
 
-	if ((rc = init_implementation_afu_regs(afu)))
-		goto err1;
+	if (adapter->native->sl_ops->afu_regs_init)
+		if ((rc = adapter->native->sl_ops->afu_regs_init(afu)))
+			goto err1;
 
-	if ((rc = cxl_native_register_serr_irq(afu)))
-		goto err1;
+	if (adapter->native->sl_ops->register_serr_irq)
+		if ((rc = adapter->native->sl_ops->register_serr_irq(afu)))
+			goto err1;
 
 	if ((rc = cxl_native_register_psl_irq(afu)))
 		goto err2;
@@ -847,7 +914,8 @@ static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pc
 	return 0;
 
 err2:
-	cxl_native_release_serr_irq(afu);
+	if (adapter->native->sl_ops->release_serr_irq)
+		adapter->native->sl_ops->release_serr_irq(afu);
 err1:
 	pci_unmap_slice_regs(afu);
 	return rc;
@@ -856,7 +924,8 @@ err1:
 static void pci_deconfigure_afu(struct cxl_afu *afu)
 {
 	cxl_native_release_psl_irq(afu);
-	cxl_native_release_serr_irq(afu);
+	if (afu->adapter->native->sl_ops->release_serr_irq)
+		afu->adapter->native->sl_ops->release_serr_irq(afu);
 	pci_unmap_slice_regs(afu);
 }
 
@@ -1177,7 +1246,7 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	if ((rc = sanitise_adapter_regs(adapter)))
 		goto err;
 
-	if ((rc = init_implementation_adapter_regs(adapter, dev)))
+	if ((rc = adapter->native->sl_ops->adapter_regs_init(adapter, dev)))
 		goto err;
 
 	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_CAPI)))
@@ -1212,6 +1281,39 @@ static void cxl_deconfigure_adapter(struct cxl *adapter)
 	pci_disable_device(pdev);
 }
 
+static const struct cxl_service_layer_ops psl_ops = {
+	.adapter_regs_init = init_implementation_adapter_psl_regs,
+	.afu_regs_init = init_implementation_afu_psl_regs,
+	.register_serr_irq = cxl_native_register_serr_irq,
+	.release_serr_irq = cxl_native_release_serr_irq,
+	.debugfs_add_adapter_sl_regs = cxl_debugfs_add_adapter_psl_regs,
+	.debugfs_add_afu_sl_regs = cxl_debugfs_add_afu_psl_regs,
+	.psl_irq_dump_registers = cxl_native_psl_irq_dump_regs,
+	.err_irq_dump_registers = cxl_native_err_irq_dump_regs,
+	.debugfs_stop_trace = cxl_stop_trace,
+	.write_timebase_ctrl = write_timebase_ctrl_psl,
+	.timebase_read = timebase_read_psl,
+};
+
+static const struct cxl_service_layer_ops xsl_ops = {
+	.adapter_regs_init = init_implementation_adapter_xsl_regs,
+	.debugfs_add_adapter_sl_regs = cxl_debugfs_add_adapter_xsl_regs,
+	.write_timebase_ctrl = write_timebase_ctrl_xsl,
+	.timebase_read = timebase_read_xsl,
+};
+
+static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
+{
+	if (dev->vendor == PCI_VENDOR_ID_MELLANOX && dev->device == 0x1013) {
+		dev_info(&adapter->dev, "Device uses an XSL\n");
+		adapter->native->sl_ops = &xsl_ops;
+	} else {
+		dev_info(&adapter->dev, "Device uses a PSL\n");
+		adapter->native->sl_ops = &psl_ops;
+	}
+}
+
+
 static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
 {
 	struct cxl *adapter;
@@ -1227,6 +1329,8 @@ static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
 		goto err_release;
 	}
 
+	set_sl_ops(adapter, dev);
+
 	/* Set defaults for parameters which need to persist over
 	 * configure/reconfigure
 	 */
-- 
2.8.1
