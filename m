Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Dvdd6XwyzF18k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 02:24:37 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5PGO5PK125477
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 12:24:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ju08hkm5e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 12:24:35 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 25 Jun 2018 17:24:32 +0100
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: alastair@au1.ibm.com, andrew.donnellan@au1.ibm.com, vaibhav@linux.ibm.com,
 clombard@linux.ibm.com, felix@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
Subject: [PATCH 10/10] cxl: Remove abandonned capi support for the Mellanox
 CX4, final cleanup
Date: Mon, 25 Jun 2018 18:24:06 +0200
In-Reply-To: <20180625162406.10813-1-fbarrat@linux.ibm.com>
References: <20180625162406.10813-1-fbarrat@linux.ibm.com>
Message-Id: <20180625162406.10813-11-fbarrat@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove a few XSL/CX4 oddities which are no longer needed. A simple
revert of the initial commits was not possible (or not worth it) due
to the history of the code.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 drivers/misc/cxl/context.c |  2 +-
 drivers/misc/cxl/cxl.h     | 12 ------
 drivers/misc/cxl/debugfs.c |  5 ---
 drivers/misc/cxl/pci.c     | 75 +++-----------------------------------
 4 files changed, 7 insertions(+), 87 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 0355d42d367f..5fe529b43ebe 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -95,7 +95,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
 	 */
 	mutex_lock(&afu->contexts_lock);
 	idr_preload(GFP_KERNEL);
-	i = idr_alloc(&ctx->afu->contexts_idr, ctx, ctx->afu->adapter->min_pe,
+	i = idr_alloc(&ctx->afu->contexts_idr, ctx, 0,
 		      ctx->afu->num_procs, GFP_NOWAIT);
 	idr_preload_end();
 	mutex_unlock(&afu->contexts_lock);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index aa453448201d..44bcfafbb579 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -93,11 +93,6 @@ static const cxl_p1_reg_t CXL_PSL_FIR_CNTL  = {0x0148};
 static const cxl_p1_reg_t CXL_PSL_DSNDCTL   = {0x0150};
 static const cxl_p1_reg_t CXL_PSL_SNWRALLOC = {0x0158};
 static const cxl_p1_reg_t CXL_PSL_TRACE     = {0x0170};
-/* XSL registers (Mellanox CX4) */
-static const cxl_p1_reg_t CXL_XSL_Timebase  = {0x0100};
-static const cxl_p1_reg_t CXL_XSL_TB_CTLSTAT = {0x0108};
-static const cxl_p1_reg_t CXL_XSL_FEC       = {0x0158};
-static const cxl_p1_reg_t CXL_XSL_DSNCTL    = {0x0168};
 /* PSL registers - CAIA 2 */
 static const cxl_p1_reg_t CXL_PSL9_CONTROL  = {0x0020};
 static const cxl_p1_reg_t CXL_XSL9_INV      = {0x0110};
@@ -695,7 +690,6 @@ struct cxl {
 	struct bin_attribute cxl_attr;
 	int adapter_num;
 	int user_irqs;
-	int min_pe;
 	u64 ps_size;
 	u16 psl_rev;
 	u16 base_image;
@@ -934,7 +928,6 @@ int cxl_debugfs_afu_add(struct cxl_afu *afu);
 void cxl_debugfs_afu_remove(struct cxl_afu *afu);
 void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir);
 void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir);
-void cxl_debugfs_add_adapter_regs_xsl(struct cxl *adapter, struct dentry *dir);
 void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir);
 void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir);
 
@@ -977,11 +970,6 @@ static inline void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter,
 {
 }
 
-static inline void cxl_debugfs_add_adapter_regs_xsl(struct cxl *adapter,
-						    struct dentry *dir)
-{
-}
-
 static inline void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir)
 {
 }
diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index 1643850d2302..a1921d81593a 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -58,11 +58,6 @@ void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir)
 	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_TRACE));
 }
 
-void cxl_debugfs_add_adapter_regs_xsl(struct cxl *adapter, struct dentry *dir)
-{
-	debugfs_create_io_x64("fec", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_XSL_FEC));
-}
-
 int cxl_debugfs_adapter_add(struct cxl *adapter)
 {
 	struct dentry *dir;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 0ca818396524..6dfb4ed345d3 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -593,27 +593,7 @@ static int init_implementation_adapter_regs_psl8(struct cxl *adapter, struct pci
 	return 0;
 }
 
-static int init_implementation_adapter_regs_xsl(struct cxl *adapter, struct pci_dev *dev)
-{
-	u64 xsl_dsnctl;
-	u64 chipid;
-	u32 phb_index;
-	u64 capp_unit_id;
-	int rc;
-
-	rc = cxl_calc_capp_routing(dev, &chipid, &phb_index, &capp_unit_id);
-	if (rc)
-		return rc;
-
-	/* Tell XSL where to route data to */
-	xsl_dsnctl = 0x0000600000000000ULL | (chipid << (63-5));
-	xsl_dsnctl |= (capp_unit_id << (63-13));
-	cxl_p1_write(adapter, CXL_XSL_DSNCTL, xsl_dsnctl);
-
-	return 0;
-}
-
-/* PSL & XSL */
+/* PSL */
 #define TBSYNC_CAL(n) (((u64)n & 0x7) << (63-3))
 #define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
 /* For the PSL this is a multiple for 0 < n <= 7: */
@@ -625,21 +605,6 @@ static void write_timebase_ctrl_psl8(struct cxl *adapter)
 		     TBSYNC_CNT(2 * PSL_2048_250MHZ_CYCLES));
 }
 
-/* XSL */
-#define TBSYNC_ENA (1ULL << 63)
-/* For the XSL this is 2**n * 2000 clocks for 0 < n <= 6: */
-#define XSL_2000_CLOCKS 1
-#define XSL_4000_CLOCKS 2
-#define XSL_8000_CLOCKS 3
-
-static void write_timebase_ctrl_xsl(struct cxl *adapter)
-{
-	cxl_p1_write(adapter, CXL_XSL_TB_CTLSTAT,
-		     TBSYNC_ENA |
-		     TBSYNC_CAL(3) |
-		     TBSYNC_CNT(XSL_4000_CLOCKS));
-}
-
 static u64 timebase_read_psl9(struct cxl *adapter)
 {
 	return cxl_p1_read(adapter, CXL_PSL9_Timebase);
@@ -650,11 +615,6 @@ static u64 timebase_read_psl8(struct cxl *adapter)
 	return cxl_p1_read(adapter, CXL_PSL_Timebase);
 }
 
-static u64 timebase_read_xsl(struct cxl *adapter)
-{
-	return cxl_p1_read(adapter, CXL_XSL_Timebase);
-}
-
 static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 {
 	struct device_node *np;
@@ -1671,37 +1631,14 @@ static const struct cxl_service_layer_ops psl8_ops = {
 	.needs_reset_before_disable = true,
 };
 
-static const struct cxl_service_layer_ops xsl_ops = {
-	.adapter_regs_init = init_implementation_adapter_regs_xsl,
-	.invalidate_all = cxl_invalidate_all_psl8,
-	.sanitise_afu_regs = sanitise_afu_regs_psl8,
-	.handle_interrupt = cxl_irq_psl8,
-	.fail_irq = cxl_fail_irq_psl,
-	.activate_dedicated_process = cxl_activate_dedicated_process_psl8,
-	.attach_afu_directed = cxl_attach_afu_directed_psl8,
-	.attach_dedicated_process = cxl_attach_dedicated_process_psl8,
-	.update_dedicated_ivtes = cxl_update_dedicated_ivtes_psl8,
-	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_xsl,
-	.write_timebase_ctrl = write_timebase_ctrl_xsl,
-	.timebase_read = timebase_read_xsl,
-	.capi_mode = OPAL_PHB_CAPI_MODE_DMA,
-};
-
 static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
 {
-	if (dev->vendor == PCI_VENDOR_ID_MELLANOX && dev->device == 0x1013) {
-		/* Mellanox CX-4 */
-		dev_info(&dev->dev, "Device uses an XSL\n");
-		adapter->native->sl_ops = &xsl_ops;
-		adapter->min_pe = 1; /* Workaround for CX-4 hardware bug */
+	if (cxl_is_power8()) {
+		dev_info(&dev->dev, "Device uses a PSL8\n");
+		adapter->native->sl_ops = &psl8_ops;
 	} else {
-		if (cxl_is_power8()) {
-			dev_info(&dev->dev, "Device uses a PSL8\n");
-			adapter->native->sl_ops = &psl8_ops;
-		} else {
-			dev_info(&dev->dev, "Device uses a PSL9\n");
-			adapter->native->sl_ops = &psl9_ops;
-		}
+		dev_info(&dev->dev, "Device uses a PSL9\n");
+		adapter->native->sl_ops = &psl9_ops;
 	}
 }
 
-- 
2.17.1
