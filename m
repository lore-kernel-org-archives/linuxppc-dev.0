Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC22D1A04F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 03:22:11 +1100 (AEDT)
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 16:22:08 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5C4EF17D805F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:22:22 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NGM1kO65208396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:22:01 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NGM0pn008643
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 09:22:01 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 01/18] cxl: Move common code away from bare-metal-specific
 files
Date: Tue, 23 Feb 2016 17:21:42 +0100
Message-Id: <1456244519-18934-2-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Lombard <clombard@linux.vnet.ibm.com>

Move around some functions which will be accessed from the bare-metal
and guest environments.
Code in native.c and pci.c is meant to be bare-metal specific.
Other files contain code which may be shared with guests.

Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/cxl.h    |  9 +++++++
 drivers/misc/cxl/irq.c    | 14 +++++-----
 drivers/misc/cxl/main.c   | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/cxl/native.c | 21 ---------------
 drivers/misc/cxl/pci.c    | 48 +--------------------------------
 5 files changed, 84 insertions(+), 75 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index a521bc7..3f88140 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -526,6 +526,7 @@ void cxl_release_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl *adapter);
 int cxl_setup_irq(struct cxl *adapter, unsigned int hwirq, unsigned int virq);
 int cxl_update_image_control(struct cxl *adapter);
 int cxl_reset(struct cxl *adapter);
+void cxl_release_afu(struct device *dev);
 
 /* common == phyp + powernv */
 struct cxl_process_element_common {
@@ -679,6 +680,9 @@ void cxl_sysfs_afu_remove(struct cxl_afu *afu);
 int cxl_sysfs_afu_m_add(struct cxl_afu *afu);
 void cxl_sysfs_afu_m_remove(struct cxl_afu *afu);
 
+struct cxl *cxl_alloc_adapter(void);
+struct cxl_afu *cxl_alloc_afu(struct cxl *adapter, int slice);
+
 int cxl_afu_activate_mode(struct cxl_afu *afu, int mode);
 int _cxl_afu_deactivate_mode(struct cxl_afu *afu, int mode);
 int cxl_afu_deactivate_mode(struct cxl_afu *afu);
@@ -733,6 +737,11 @@ struct cxl_irq_info {
 };
 
 void cxl_assign_psn_space(struct cxl_context *ctx);
+irqreturn_t cxl_irq(int irq, void *ctx, struct cxl_irq_info *irq_info);
+int cxl_register_one_irq(struct cxl *adapter, irq_handler_t handler,
+			void *cookie, irq_hw_number_t *dest_hwirq,
+			unsigned int *dest_virq, const char *name);
+
 int cxl_attach_process(struct cxl_context *ctx, bool kernel, u64 wed,
 			    u64 amr);
 int cxl_detach_process(struct cxl_context *ctx);
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 09a4060..e468e6c 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -93,7 +93,7 @@ static irqreturn_t schedule_cxl_fault(struct cxl_context *ctx, u64 dsisr, u64 da
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
+irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
 {
 	struct cxl_context *ctx = data;
 	u64 dsisr, dar;
@@ -291,12 +291,12 @@ void cxl_unmap_irq(unsigned int virq, void *cookie)
 	irq_dispose_mapping(virq);
 }
 
-static int cxl_register_one_irq(struct cxl *adapter,
-				irq_handler_t handler,
-				void *cookie,
-				irq_hw_number_t *dest_hwirq,
-				unsigned int *dest_virq,
-				const char *name)
+int cxl_register_one_irq(struct cxl *adapter,
+			irq_handler_t handler,
+			void *cookie,
+			irq_hw_number_t *dest_hwirq,
+			unsigned int *dest_virq,
+			const char *name)
 {
 	int hwirq, virq;
 
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index 9fde75e..7ef5b43 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -32,6 +32,27 @@ uint cxl_verbose;
 module_param_named(verbose, cxl_verbose, uint, 0600);
 MODULE_PARM_DESC(verbose, "Enable verbose dmesg output");
 
+int cxl_afu_slbia(struct cxl_afu *afu)
+{
+	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
+
+	pr_devel("cxl_afu_slbia issuing SLBIA command\n");
+	cxl_p2n_write(afu, CXL_SLBIA_An, CXL_TLB_SLB_IQ_ALL);
+	while (cxl_p2n_read(afu, CXL_SLBIA_An) & CXL_TLB_SLB_P) {
+		if (time_after_eq(jiffies, timeout)) {
+			dev_warn(&afu->dev, "WARNING: CXL AFU SLBIA timed out!\n");
+			return -EBUSY;
+		}
+		/* If the adapter has gone down, we can assume that we
+		 * will PERST it and that will invalidate everything.
+		 */
+		if (!cxl_adapter_link_ok(afu->adapter))
+			return -EIO;
+		cpu_relax();
+	}
+	return 0;
+}
+
 static inline void _cxl_slbia(struct cxl_context *ctx, struct mm_struct *mm)
 {
 	struct task_struct *task;
@@ -174,6 +195,52 @@ void cxl_remove_adapter_nr(struct cxl *adapter)
 	idr_remove(&cxl_adapter_idr, adapter->adapter_num);
 }
 
+struct cxl *cxl_alloc_adapter(void)
+{
+	struct cxl *adapter;
+
+	if (!(adapter = kzalloc(sizeof(struct cxl), GFP_KERNEL)))
+		return NULL;
+
+	spin_lock_init(&adapter->afu_list_lock);
+
+	if (cxl_alloc_adapter_nr(adapter))
+		goto err1;
+
+	if (dev_set_name(&adapter->dev, "card%i", adapter->adapter_num))
+		goto err2;
+
+	return adapter;
+
+err2:
+	cxl_remove_adapter_nr(adapter);
+err1:
+	kfree(adapter);
+	return NULL;
+}
+
+struct cxl_afu *cxl_alloc_afu(struct cxl *adapter, int slice)
+{
+	struct cxl_afu *afu;
+
+	if (!(afu = kzalloc(sizeof(struct cxl_afu), GFP_KERNEL)))
+		return NULL;
+
+	afu->adapter = adapter;
+	afu->dev.parent = &adapter->dev;
+	afu->dev.release = cxl_release_afu;
+	afu->slice = slice;
+	idr_init(&afu->contexts_idr);
+	mutex_init(&afu->contexts_lock);
+	spin_lock_init(&afu->afu_cntl_lock);
+	mutex_init(&afu->spa_mutex);
+
+	afu->prefault_mode = CXL_PREFAULT_NONE;
+	afu->irqs_max = afu->adapter->user_irqs;
+
+	return afu;
+}
+
 int cxl_afu_select_best_mode(struct cxl_afu *afu)
 {
 	if (afu->modes_supported & CXL_MODE_DIRECTED)
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index f409097..0b0a4c8 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -265,27 +265,6 @@ int cxl_tlb_slb_invalidate(struct cxl *adapter)
 	return 0;
 }
 
-int cxl_afu_slbia(struct cxl_afu *afu)
-{
-	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
-
-	pr_devel("cxl_afu_slbia issuing SLBIA command\n");
-	cxl_p2n_write(afu, CXL_SLBIA_An, CXL_TLB_SLB_IQ_ALL);
-	while (cxl_p2n_read(afu, CXL_SLBIA_An) & CXL_TLB_SLB_P) {
-		if (time_after_eq(jiffies, timeout)) {
-			dev_warn(&afu->dev, "WARNING: CXL AFU SLBIA timed out!\n");
-			return -EBUSY;
-		}
-		/* If the adapter has gone down, we can assume that we
-		 * will PERST it and that will invalidate everything.
-		 */
-		if (!cxl_adapter_link_ok(afu->adapter))
-			return -EIO;
-		cpu_relax();
-	}
-	return 0;
-}
-
 static int cxl_write_sstp(struct cxl_afu *afu, u64 sstp0, u64 sstp1)
 {
 	int rc;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 4c1903f..ad28c56 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -604,7 +604,7 @@ static void cxl_unmap_slice_regs(struct cxl_afu *afu)
 	}
 }
 
-static void cxl_release_afu(struct device *dev)
+void cxl_release_afu(struct device *dev)
 {
 	struct cxl_afu *afu = to_cxl_afu(dev);
 
@@ -616,28 +616,6 @@ static void cxl_release_afu(struct device *dev)
 	kfree(afu);
 }
 
-static struct cxl_afu *cxl_alloc_afu(struct cxl *adapter, int slice)
-{
-	struct cxl_afu *afu;
-
-	if (!(afu = kzalloc(sizeof(struct cxl_afu), GFP_KERNEL)))
-		return NULL;
-
-	afu->adapter = adapter;
-	afu->dev.parent = &adapter->dev;
-	afu->dev.release = cxl_release_afu;
-	afu->slice = slice;
-	idr_init(&afu->contexts_idr);
-	mutex_init(&afu->contexts_lock);
-	spin_lock_init(&afu->afu_cntl_lock);
-	mutex_init(&afu->spa_mutex);
-
-	afu->prefault_mode = CXL_PREFAULT_NONE;
-	afu->irqs_max = afu->adapter->user_irqs;
-
-	return afu;
-}
-
 /* Expects AFU struct to have recently been zeroed out */
 static int cxl_read_afu_descriptor(struct cxl_afu *afu)
 {
@@ -1105,30 +1083,6 @@ static void cxl_release_adapter(struct device *dev)
 	kfree(adapter);
 }
 
-static struct cxl *cxl_alloc_adapter(void)
-{
-	struct cxl *adapter;
-
-	if (!(adapter = kzalloc(sizeof(struct cxl), GFP_KERNEL)))
-		return NULL;
-
-	spin_lock_init(&adapter->afu_list_lock);
-
-	if (cxl_alloc_adapter_nr(adapter))
-		goto err1;
-
-	if (dev_set_name(&adapter->dev, "card%i", adapter->adapter_num))
-		goto err2;
-
-	return adapter;
-
-err2:
-	cxl_remove_adapter_nr(adapter);
-err1:
-	kfree(adapter);
-	return NULL;
-}
-
 #define CXL_PSL_ErrIVTE_tberror (0x1ull << (63-31))
 
 static int sanitise_adapter_regs(struct cxl *adapter)
-- 
1.9.1
