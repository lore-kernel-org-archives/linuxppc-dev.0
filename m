Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 631D11A0B51
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 22:27:24 +1100 (AEDT)
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 11:27:20 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 32C87219005E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:26:41 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24BQvwt58720466
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:26:57 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24BQvpC007420
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 04:26:57 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 11/20] cxl: Separate bare-metal fields in adapter and AFU
 data structures
Date: Fri,  4 Mar 2016 12:26:35 +0100
Message-Id: <1457090804-9719-12-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Lombard <clombard@linux.vnet.ibm.com>

Introduce sub-structures containing the bare-metal specific fields in
the structures describing the adapter (struct cxl) and AFU (struct
cxl_afu).
Update all their references.

Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c |  2 +-
 drivers/misc/cxl/cxl.h     | 84 +++++++++++++++++++++++++++-------------
 drivers/misc/cxl/irq.c     |  2 +-
 drivers/misc/cxl/main.c    |  1 -
 drivers/misc/cxl/native.c  | 85 +++++++++++++++++++++--------------------
 drivers/misc/cxl/pci.c     | 95 +++++++++++++++++++++++++++-------------------
 drivers/misc/cxl/sysfs.c   |  2 +-
 drivers/misc/cxl/vphb.c    |  4 +-
 8 files changed, 164 insertions(+), 111 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 46f9844..200837f 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -96,7 +96,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 
 	ctx->pe = i;
 	if (cpu_has_feature(CPU_FTR_HVMODE))
-		ctx->elem = &ctx->afu->spa[i];
+		ctx->elem = &ctx->afu->native->spa[i];
 	ctx->pe_inserted = false;
 
 	/*
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index ac655a6..3a1fabd 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -344,18 +344,44 @@ struct cxl_sste {
 #define to_cxl_adapter(d) container_of(d, struct cxl, dev)
 #define to_cxl_afu(d) container_of(d, struct cxl_afu, dev)
 
-struct cxl_afu {
+struct cxl_afu_native {
+	void __iomem *p1n_mmio;
+	void __iomem *afu_desc_mmio;
 	irq_hw_number_t psl_hwirq;
+	unsigned int psl_virq;
+	struct mutex spa_mutex;
+	/*
+	 * Only the first part of the SPA is used for the process element
+	 * linked list. The only other part that software needs to worry about
+	 * is sw_command_status, which we store a separate pointer to.
+	 * Everything else in the SPA is only used by hardware
+	 */
+	struct cxl_process_element *spa;
+	__be64 *sw_command_status;
+	unsigned int spa_size;
+	int spa_order;
+	int spa_max_procs;
+	u64 pp_offset;
+};
+
+struct cxl_afu_guest {
+	u64 handle;
+	phys_addr_t p2n_phys;
+	u64 p2n_size;
+	int max_ints;
+};
+
+struct cxl_afu {
+	struct cxl_afu_native *native;
+	struct cxl_afu_guest *guest;
 	irq_hw_number_t serr_hwirq;
-	char *err_irq_name;
-	char *psl_irq_name;
 	unsigned int serr_virq;
-	void __iomem *p1n_mmio;
+	char *psl_irq_name;
+	char *err_irq_name;
 	void __iomem *p2n_mmio;
 	phys_addr_t psn_phys;
-	u64 pp_offset;
 	u64 pp_size;
-	void __iomem *afu_desc_mmio;
+
 	struct cxl *adapter;
 	struct device dev;
 	struct cdev afu_cdev_s, afu_cdev_m, afu_cdev_d;
@@ -363,26 +389,12 @@ struct cxl_afu {
 	struct idr contexts_idr;
 	struct dentry *debugfs;
 	struct mutex contexts_lock;
-	struct mutex spa_mutex;
 	spinlock_t afu_cntl_lock;
 
 	/* AFU error buffer fields and bin attribute for sysfs */
 	u64 eb_len, eb_offset;
 	struct bin_attribute attr_eb;
 
-	/*
-	 * Only the first part of the SPA is used for the process element
-	 * linked list. The only other part that software needs to worry about
-	 * is sw_command_status, which we store a separate pointer to.
-	 * Everything else in the SPA is only used by hardware
-	 */
-	struct cxl_process_element *spa;
-	__be64 *sw_command_status;
-	unsigned int spa_size;
-	int spa_order;
-	int spa_max_procs;
-	unsigned int psl_virq;
-
 	/* pointer to the vphb */
 	struct pci_controller *phb;
 
@@ -488,11 +500,34 @@ struct cxl_context {
 	struct rcu_head rcu;
 };
 
-struct cxl {
+struct cxl_native {
+	u64 afu_desc_off;
+	u64 afu_desc_size;
 	void __iomem *p1_mmio;
 	void __iomem *p2_mmio;
 	irq_hw_number_t err_hwirq;
 	unsigned int err_virq;
+	u64 ps_off;
+};
+
+struct cxl_guest {
+	struct platform_device *pdev;
+	int irq_nranges;
+	struct cdev cdev;
+	irq_hw_number_t irq_base_offset;
+	struct irq_avail *irq_avail;
+	spinlock_t irq_alloc_lock;
+	u64 handle;
+	char *status;
+	u16 vendor;
+	u16 device;
+	u16 subsystem_vendor;
+	u16 subsystem;
+};
+
+struct cxl {
+	struct cxl_native *native;
+	struct cxl_guest *guest;
 	spinlock_t afu_list_lock;
 	struct cxl_afu *afu[CXL_MAX_SLICES];
 	struct device dev;
@@ -503,9 +538,6 @@ struct cxl {
 	struct bin_attribute cxl_attr;
 	int adapter_num;
 	int user_irqs;
-	u64 afu_desc_off;
-	u64 afu_desc_size;
-	u64 ps_off;
 	u64 ps_size;
 	u16 psl_rev;
 	u16 base_image;
@@ -570,7 +602,7 @@ static inline bool cxl_adapter_link_ok(struct cxl *cxl)
 static inline void __iomem *_cxl_p1_addr(struct cxl *cxl, cxl_p1_reg_t reg)
 {
 	WARN_ON(!cpu_has_feature(CPU_FTR_HVMODE));
-	return cxl->p1_mmio + cxl_reg_off(reg);
+	return cxl->native->p1_mmio + cxl_reg_off(reg);
 }
 
 static inline void cxl_p1_write(struct cxl *cxl, cxl_p1_reg_t reg, u64 val)
@@ -590,7 +622,7 @@ static inline u64 cxl_p1_read(struct cxl *cxl, cxl_p1_reg_t reg)
 static inline void __iomem *_cxl_p1n_addr(struct cxl_afu *afu, cxl_p1n_reg_t reg)
 {
 	WARN_ON(!cpu_has_feature(CPU_FTR_HVMODE));
-	return afu->p1n_mmio + cxl_reg_off(reg);
+	return afu->native->p1n_mmio + cxl_reg_off(reg);
 }
 
 static inline void cxl_p1n_write(struct cxl_afu *afu, cxl_p1n_reg_t reg, u64 val)
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 3c04c14..be646dc 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -270,7 +270,7 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
 		/* Multiplexed PSL Interrupt */
-		ctx->irqs.offset[0] = ctx->afu->psl_hwirq;
+		ctx->irqs.offset[0] = ctx->afu->native->psl_hwirq;
 		ctx->irqs.range[0] = 1;
 	}
 
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index 814257b..927ba5a 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -261,7 +261,6 @@ struct cxl_afu *cxl_alloc_afu(struct cxl *adapter, int slice)
 	idr_init(&afu->contexts_idr);
 	mutex_init(&afu->contexts_lock);
 	spin_lock_init(&afu->afu_cntl_lock);
-	mutex_init(&afu->spa_mutex);
 
 	afu->prefault_mode = CXL_PREFAULT_NONE;
 	afu->irqs_max = afu->adapter->user_irqs;
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 7d52629..c0bca59 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -186,22 +186,22 @@ static int spa_max_procs(int spa_size)
 int cxl_alloc_spa(struct cxl_afu *afu)
 {
 	/* Work out how many pages to allocate */
-	afu->spa_order = 0;
+	afu->native->spa_order = 0;
 	do {
-		afu->spa_order++;
-		afu->spa_size = (1 << afu->spa_order) * PAGE_SIZE;
-		afu->spa_max_procs = spa_max_procs(afu->spa_size);
-	} while (afu->spa_max_procs < afu->num_procs);
+		afu->native->spa_order++;
+		afu->native->spa_size = (1 << afu->native->spa_order) * PAGE_SIZE;
+		afu->native->spa_max_procs = spa_max_procs(afu->native->spa_size);
+	} while (afu->native->spa_max_procs < afu->num_procs);
 
-	WARN_ON(afu->spa_size > 0x100000); /* Max size supported by the hardware */
+	WARN_ON(afu->native->spa_size > 0x100000); /* Max size supported by the hardware */
 
-	if (!(afu->spa = (struct cxl_process_element *)
-	      __get_free_pages(GFP_KERNEL | __GFP_ZERO, afu->spa_order))) {
+	if (!(afu->native->spa = (struct cxl_process_element *)
+	      __get_free_pages(GFP_KERNEL | __GFP_ZERO, afu->native->spa_order))) {
 		pr_err("cxl_alloc_spa: Unable to allocate scheduled process area\n");
 		return -ENOMEM;
 	}
 	pr_devel("spa pages: %i afu->spa_max_procs: %i   afu->num_procs: %i\n",
-		 1<<afu->spa_order, afu->spa_max_procs, afu->num_procs);
+		 1<<afu->native->spa_order, afu->native->spa_max_procs, afu->num_procs);
 
 	return 0;
 }
@@ -210,13 +210,15 @@ static void attach_spa(struct cxl_afu *afu)
 {
 	u64 spap;
 
-	afu->sw_command_status = (__be64 *)((char *)afu->spa +
-					    ((afu->spa_max_procs + 3) * 128));
+	afu->native->sw_command_status = (__be64 *)((char *)afu->native->spa +
+					    ((afu->native->spa_max_procs + 3) * 128));
 
-	spap = virt_to_phys(afu->spa) & CXL_PSL_SPAP_Addr;
-	spap |= ((afu->spa_size >> (12 - CXL_PSL_SPAP_Size_Shift)) - 1) & CXL_PSL_SPAP_Size;
+	spap = virt_to_phys(afu->native->spa) & CXL_PSL_SPAP_Addr;
+	spap |= ((afu->native->spa_size >> (12 - CXL_PSL_SPAP_Size_Shift)) - 1) & CXL_PSL_SPAP_Size;
 	spap |= CXL_PSL_SPAP_V;
-	pr_devel("cxl: SPA allocated at 0x%p. Max processes: %i, sw_command_status: 0x%p CXL_PSL_SPAP_An=0x%016llx\n", afu->spa, afu->spa_max_procs, afu->sw_command_status, spap);
+	pr_devel("cxl: SPA allocated at 0x%p. Max processes: %i, sw_command_status: 0x%p CXL_PSL_SPAP_An=0x%016llx\n",
+		afu->native->spa, afu->native->spa_max_procs,
+		afu->native->sw_command_status, spap);
 	cxl_p1n_write(afu, CXL_PSL_SPAP_An, spap);
 }
 
@@ -227,9 +229,10 @@ static inline void detach_spa(struct cxl_afu *afu)
 
 void cxl_release_spa(struct cxl_afu *afu)
 {
-	if (afu->spa) {
-		free_pages((unsigned long) afu->spa, afu->spa_order);
-		afu->spa = NULL;
+	if (afu->native->spa) {
+		free_pages((unsigned long) afu->native->spa,
+			afu->native->spa_order);
+		afu->native->spa = NULL;
 	}
 }
 
@@ -291,7 +294,7 @@ static void slb_invalid(struct cxl_context *ctx)
 	struct cxl *adapter = ctx->afu->adapter;
 	u64 slbia;
 
-	WARN_ON(!mutex_is_locked(&ctx->afu->spa_mutex));
+	WARN_ON(!mutex_is_locked(&ctx->afu->native->spa_mutex));
 
 	cxl_p1_write(adapter, CXL_PSL_LBISEL,
 			((u64)be32_to_cpu(ctx->elem->common.pid) << 32) |
@@ -321,7 +324,7 @@ static int do_process_element_cmd(struct cxl_context *ctx,
 
 	ctx->elem->software_state = cpu_to_be32(pe_state);
 	smp_wmb();
-	*(ctx->afu->sw_command_status) = cpu_to_be64(cmd | 0 | ctx->pe);
+	*(ctx->afu->native->sw_command_status) = cpu_to_be64(cmd | 0 | ctx->pe);
 	smp_mb();
 	cxl_p1n_write(ctx->afu, CXL_PSL_LLCMD_An, cmd | ctx->pe);
 	while (1) {
@@ -335,7 +338,7 @@ static int do_process_element_cmd(struct cxl_context *ctx,
 			rc = -EIO;
 			goto out;
 		}
-		state = be64_to_cpup(ctx->afu->sw_command_status);
+		state = be64_to_cpup(ctx->afu->native->sw_command_status);
 		if (state == ~0ULL) {
 			pr_err("cxl: Error adding process element to AFU\n");
 			rc = -1;
@@ -363,12 +366,12 @@ static int add_process_element(struct cxl_context *ctx)
 {
 	int rc = 0;
 
-	mutex_lock(&ctx->afu->spa_mutex);
+	mutex_lock(&ctx->afu->native->spa_mutex);
 	pr_devel("%s Adding pe: %i started\n", __func__, ctx->pe);
 	if (!(rc = do_process_element_cmd(ctx, CXL_SPA_SW_CMD_ADD, CXL_PE_SOFTWARE_STATE_V)))
 		ctx->pe_inserted = true;
 	pr_devel("%s Adding pe: %i finished\n", __func__, ctx->pe);
-	mutex_unlock(&ctx->afu->spa_mutex);
+	mutex_unlock(&ctx->afu->native->spa_mutex);
 	return rc;
 }
 
@@ -380,7 +383,7 @@ static int terminate_process_element(struct cxl_context *ctx)
 	if (!(ctx->elem->software_state & cpu_to_be32(CXL_PE_SOFTWARE_STATE_V)))
 		return rc;
 
-	mutex_lock(&ctx->afu->spa_mutex);
+	mutex_lock(&ctx->afu->native->spa_mutex);
 	pr_devel("%s Terminate pe: %i started\n", __func__, ctx->pe);
 	/* We could be asked to terminate when the hw is down. That
 	 * should always succeed: it's not running if the hw has gone
@@ -391,7 +394,7 @@ static int terminate_process_element(struct cxl_context *ctx)
 					    CXL_PE_SOFTWARE_STATE_V | CXL_PE_SOFTWARE_STATE_T);
 	ctx->elem->software_state = 0;	/* Remove Valid bit */
 	pr_devel("%s Terminate pe: %i finished\n", __func__, ctx->pe);
-	mutex_unlock(&ctx->afu->spa_mutex);
+	mutex_unlock(&ctx->afu->native->spa_mutex);
 	return rc;
 }
 
@@ -399,7 +402,7 @@ static int remove_process_element(struct cxl_context *ctx)
 {
 	int rc = 0;
 
-	mutex_lock(&ctx->afu->spa_mutex);
+	mutex_lock(&ctx->afu->native->spa_mutex);
 	pr_devel("%s Remove pe: %i started\n", __func__, ctx->pe);
 
 	/* We could be asked to remove when the hw is down. Again, if
@@ -412,7 +415,7 @@ static int remove_process_element(struct cxl_context *ctx)
 		ctx->pe_inserted = false;
 	slb_invalid(ctx);
 	pr_devel("%s Remove pe: %i finished\n", __func__, ctx->pe);
-	mutex_unlock(&ctx->afu->spa_mutex);
+	mutex_unlock(&ctx->afu->native->spa_mutex);
 
 	return rc;
 }
@@ -425,7 +428,7 @@ void cxl_assign_psn_space(struct cxl_context *ctx)
 		ctx->psn_size = ctx->afu->adapter->ps_size;
 	} else {
 		ctx->psn_phys = ctx->afu->psn_phys +
-			(ctx->afu->pp_offset + ctx->afu->pp_size * ctx->pe);
+			(ctx->afu->native->pp_offset + ctx->afu->pp_size * ctx->pe);
 		ctx->psn_size = ctx->afu->pp_size;
 	}
 }
@@ -437,7 +440,7 @@ static int activate_afu_directed(struct cxl_afu *afu)
 	dev_info(&afu->dev, "Activating AFU directed mode\n");
 
 	afu->num_procs = afu->max_procs_virtualised;
-	if (afu->spa == NULL) {
+	if (afu->native->spa == NULL) {
 		if (cxl_alloc_spa(afu))
 			return -ENOMEM;
 	}
@@ -846,27 +849,27 @@ int cxl_native_register_psl_err_irq(struct cxl *adapter)
 		return -ENOMEM;
 
 	if ((rc = cxl_register_one_irq(adapter, native_irq_err, adapter,
-				       &adapter->err_hwirq,
-				       &adapter->err_virq,
+				       &adapter->native->err_hwirq,
+				       &adapter->native->err_virq,
 				       adapter->irq_name))) {
 		kfree(adapter->irq_name);
 		adapter->irq_name = NULL;
 		return rc;
 	}
 
-	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, adapter->err_hwirq & 0xffff);
+	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, adapter->native->err_hwirq & 0xffff);
 
 	return 0;
 }
 
 void cxl_native_release_psl_err_irq(struct cxl *adapter)
 {
-	if (adapter->err_virq != irq_find_mapping(NULL, adapter->err_hwirq))
+	if (adapter->native->err_virq != irq_find_mapping(NULL, adapter->native->err_hwirq))
 		return;
 
 	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);
-	cxl_unmap_irq(adapter->err_virq, adapter);
-	cxl_ops->release_one_irq(adapter, adapter->err_hwirq);
+	cxl_unmap_irq(adapter->native->err_virq, adapter);
+	cxl_ops->release_one_irq(adapter, adapter->native->err_hwirq);
 	kfree(adapter->irq_name);
 }
 
@@ -915,8 +918,8 @@ int cxl_native_register_psl_irq(struct cxl_afu *afu)
 	if (!afu->psl_irq_name)
 		return -ENOMEM;
 
-	if ((rc = cxl_register_one_irq(afu->adapter, native_irq_multiplexed, afu,
-				    &afu->psl_hwirq, &afu->psl_virq,
+	if ((rc = cxl_register_one_irq(afu->adapter, native_irq_multiplexed,
+				    afu, &afu->native->psl_hwirq, &afu->native->psl_virq,
 				    afu->psl_irq_name))) {
 		kfree(afu->psl_irq_name);
 		afu->psl_irq_name = NULL;
@@ -926,11 +929,11 @@ int cxl_native_register_psl_irq(struct cxl_afu *afu)
 
 void cxl_native_release_psl_irq(struct cxl_afu *afu)
 {
-	if (afu->psl_virq != irq_find_mapping(NULL, afu->psl_hwirq))
+	if (afu->native->psl_virq != irq_find_mapping(NULL, afu->native->psl_hwirq))
 		return;
 
-	cxl_unmap_irq(afu->psl_virq, afu);
-	cxl_ops->release_one_irq(afu->adapter, afu->psl_hwirq);
+	cxl_unmap_irq(afu->native->psl_virq, afu);
+	cxl_ops->release_one_irq(afu->adapter, afu->native->psl_hwirq);
 	kfree(afu->psl_irq_name);
 }
 
@@ -970,7 +973,7 @@ static int native_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off, u64 *out)
 		return -EIO;
 	if (unlikely(off >= afu->crs_len))
 		return -ERANGE;
-	*out = in_le64(afu->afu_desc_mmio + afu->crs_offset +
+	*out = in_le64(afu->native->afu_desc_mmio + afu->crs_offset +
 		(cr * afu->crs_len) + off);
 	return 0;
 }
@@ -981,7 +984,7 @@ static int native_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off, u32 *out)
 		return -EIO;
 	if (unlikely(off >= afu->crs_len))
 		return -ERANGE;
-	*out = in_le32(afu->afu_desc_mmio + afu->crs_offset +
+	*out = in_le32(afu->native->afu_desc_mmio + afu->crs_offset +
 		(cr * afu->crs_len) + off);
 	return 0;
 }
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 23b84c5..fb4fd45 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -90,8 +90,8 @@
 
 /* This works a little different than the p1/p2 register accesses to make it
  * easier to pull out individual fields */
-#define AFUD_READ(afu, off)		in_be64(afu->afu_desc_mmio + off)
-#define AFUD_READ_LE(afu, off)		in_le64(afu->afu_desc_mmio + off)
+#define AFUD_READ(afu, off)		in_be64(afu->native->afu_desc_mmio + off)
+#define AFUD_READ_LE(afu, off)		in_le64(afu->native->afu_desc_mmio + off)
 #define EXTRACT_PPC_BIT(val, bit)	(!!(val & PPC_BIT(bit)))
 #define EXTRACT_PPC_BITS(val, bs, be)	((val & PPC_BITMASK(bs, be)) >> PPC_BITLSHIFT(be))
 
@@ -550,15 +550,15 @@ static int pci_map_slice_regs(struct cxl_afu *afu, struct cxl *adapter, struct p
 
 	p1n_base = p1_base(dev) + 0x10000 + (afu->slice * p1n_size);
 	p2n_base = p2_base(dev) + (afu->slice * p2n_size);
-	afu->psn_phys = p2_base(dev) + (adapter->ps_off + (afu->slice * adapter->ps_size));
-	afu_desc = p2_base(dev) + adapter->afu_desc_off + (afu->slice * adapter->afu_desc_size);
+	afu->psn_phys = p2_base(dev) + (adapter->native->ps_off + (afu->slice * adapter->ps_size));
+	afu_desc = p2_base(dev) + adapter->native->afu_desc_off + (afu->slice * adapter->native->afu_desc_size);
 
-	if (!(afu->p1n_mmio = ioremap(p1n_base, p1n_size)))
+	if (!(afu->native->p1n_mmio = ioremap(p1n_base, p1n_size)))
 		goto err;
 	if (!(afu->p2n_mmio = ioremap(p2n_base, p2n_size)))
 		goto err1;
 	if (afu_desc) {
-		if (!(afu->afu_desc_mmio = ioremap(afu_desc, adapter->afu_desc_size)))
+		if (!(afu->native->afu_desc_mmio = ioremap(afu_desc, adapter->native->afu_desc_size)))
 			goto err2;
 	}
 
@@ -566,7 +566,7 @@ static int pci_map_slice_regs(struct cxl_afu *afu, struct cxl *adapter, struct p
 err2:
 	iounmap(afu->p2n_mmio);
 err1:
-	iounmap(afu->p1n_mmio);
+	iounmap(afu->native->p1n_mmio);
 err:
 	dev_err(&afu->dev, "Error mapping AFU MMIO regions\n");
 	return -ENOMEM;
@@ -578,13 +578,13 @@ static void pci_unmap_slice_regs(struct cxl_afu *afu)
 		iounmap(afu->p2n_mmio);
 		afu->p2n_mmio = NULL;
 	}
-	if (afu->p1n_mmio) {
-		iounmap(afu->p1n_mmio);
-		afu->p1n_mmio = NULL;
+	if (afu->native->p1n_mmio) {
+		iounmap(afu->native->p1n_mmio);
+		afu->native->p1n_mmio = NULL;
 	}
-	if (afu->afu_desc_mmio) {
-		iounmap(afu->afu_desc_mmio);
-		afu->afu_desc_mmio = NULL;
+	if (afu->native->afu_desc_mmio) {
+		iounmap(afu->native->afu_desc_mmio);
+		afu->native->afu_desc_mmio = NULL;
 	}
 }
 
@@ -597,6 +597,7 @@ void cxl_pci_release_afu(struct device *dev)
 	idr_destroy(&afu->contexts_idr);
 	cxl_release_spa(afu);
 
+	kfree(afu->native);
 	kfree(afu);
 }
 
@@ -621,7 +622,7 @@ static int cxl_read_afu_descriptor(struct cxl_afu *afu)
 	afu->pp_size = AFUD_PPPSA_LEN(val) * 4096;
 	afu->psa = AFUD_PPPSA_PSA(val);
 	if ((afu->pp_psa = AFUD_PPPSA_PP(val)))
-		afu->pp_offset = AFUD_READ_PPPSA_OFF(afu);
+		afu->native->pp_offset = AFUD_READ_PPPSA_OFF(afu);
 
 	val = AFUD_READ_CR(afu);
 	afu->crs_len = AFUD_CR_LEN(val) * 256;
@@ -652,7 +653,7 @@ static int cxl_afu_descriptor_looks_ok(struct cxl_afu *afu)
 	u32 val;
 
 	if (afu->psa && afu->adapter->ps_size <
-			(afu->pp_offset + afu->pp_size*afu->max_procs_virtualised)) {
+			(afu->native->pp_offset + afu->pp_size*afu->max_procs_virtualised)) {
 		dev_err(&afu->dev, "per-process PSA can't fit inside the PSA!\n");
 		return -ENODEV;
 	}
@@ -737,7 +738,7 @@ ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
 	loff_t aligned_start, aligned_end;
 	size_t aligned_length;
 	void *tbuf;
-	const void __iomem *ebuf = afu->afu_desc_mmio + afu->eb_offset;
+	const void __iomem *ebuf = afu->native->afu_desc_mmio + afu->eb_offset;
 
 	if (count == 0 || off < 0 || (size_t)off >= afu->eb_len)
 		return 0;
@@ -819,19 +820,25 @@ static void pci_deconfigure_afu(struct cxl_afu *afu)
 static int pci_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
 {
 	struct cxl_afu *afu;
-	int rc;
+	int rc = -ENOMEM;
 
 	afu = cxl_alloc_afu(adapter, slice);
 	if (!afu)
 		return -ENOMEM;
 
+	afu->native = kzalloc(sizeof(struct cxl_afu_native), GFP_KERNEL);
+	if (!afu->native)
+		goto err_free_afu;
+
+	mutex_init(&afu->native->spa_mutex);
+
 	rc = dev_set_name(&afu->dev, "afu%i.%i", adapter->adapter_num, slice);
 	if (rc)
-		goto err_free;
+		goto err_free_native;
 
 	rc = pci_configure_afu(afu, adapter, dev);
 	if (rc)
-		goto err_free;
+		goto err_free_native;
 
 	/* Don't care if this fails */
 	cxl_debugfs_afu_add(afu);
@@ -859,7 +866,9 @@ err_put1:
 	device_unregister(&afu->dev);
 	return rc;
 
-err_free:
+err_free_native:
+	kfree(afu->native);
+err_free_afu:
 	kfree(afu);
 	return rc;
 
@@ -920,17 +929,17 @@ static int cxl_map_adapter_regs(struct cxl *adapter, struct pci_dev *dev)
 	pr_devel("cxl_map_adapter_regs: p1: %#016llx %#llx, p2: %#016llx %#llx",
 			p1_base(dev), p1_size(dev), p2_base(dev), p2_size(dev));
 
-	if (!(adapter->p1_mmio = ioremap(p1_base(dev), p1_size(dev))))
+	if (!(adapter->native->p1_mmio = ioremap(p1_base(dev), p1_size(dev))))
 		goto err3;
 
-	if (!(adapter->p2_mmio = ioremap(p2_base(dev), p2_size(dev))))
+	if (!(adapter->native->p2_mmio = ioremap(p2_base(dev), p2_size(dev))))
 		goto err4;
 
 	return 0;
 
 err4:
-	iounmap(adapter->p1_mmio);
-	adapter->p1_mmio = NULL;
+	iounmap(adapter->native->p1_mmio);
+	adapter->native->p1_mmio = NULL;
 err3:
 	pci_release_region(dev, 0);
 err2:
@@ -941,14 +950,14 @@ err1:
 
 static void cxl_unmap_adapter_regs(struct cxl *adapter)
 {
-	if (adapter->p1_mmio) {
-		iounmap(adapter->p1_mmio);
-		adapter->p1_mmio = NULL;
+	if (adapter->native->p1_mmio) {
+		iounmap(adapter->native->p1_mmio);
+		adapter->native->p1_mmio = NULL;
 		pci_release_region(to_pci_dev(adapter->dev.parent), 2);
 	}
-	if (adapter->p2_mmio) {
-		iounmap(adapter->p2_mmio);
-		adapter->p2_mmio = NULL;
+	if (adapter->native->p2_mmio) {
+		iounmap(adapter->native->p2_mmio);
+		adapter->native->p2_mmio = NULL;
 		pci_release_region(to_pci_dev(adapter->dev.parent), 0);
 	}
 }
@@ -989,10 +998,10 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
 
 	/* Convert everything to bytes, because there is NO WAY I'd look at the
 	 * code a month later and forget what units these are in ;-) */
-	adapter->ps_off = ps_off * 64 * 1024;
+	adapter->native->ps_off = ps_off * 64 * 1024;
 	adapter->ps_size = ps_size * 64 * 1024;
-	adapter->afu_desc_off = afu_desc_off * 64 * 1024;
-	adapter->afu_desc_size = afu_desc_size *64 * 1024;
+	adapter->native->afu_desc_off = afu_desc_off * 64 * 1024;
+	adapter->native->afu_desc_size = afu_desc_size * 64 * 1024;
 
 	/* Total IRQs - 1 PSL ERROR - #AFU*(1 slice error + 1 DSI) */
 	adapter->user_irqs = pnv_cxl_get_irq_count(dev) - 1 - 2*adapter->slices;
@@ -1043,15 +1052,15 @@ static int cxl_vsec_looks_ok(struct cxl *adapter, struct pci_dev *dev)
 		return -EINVAL;
 	}
 
-	if (!adapter->afu_desc_off || !adapter->afu_desc_size) {
+	if (!adapter->native->afu_desc_off || !adapter->native->afu_desc_size) {
 		dev_err(&dev->dev, "ABORTING: VSEC shows no AFU descriptors\n");
 		return -EINVAL;
 	}
 
-	if (adapter->ps_size > p2_size(dev) - adapter->ps_off) {
+	if (adapter->ps_size > p2_size(dev) - adapter->native->ps_off) {
 		dev_err(&dev->dev, "ABORTING: Problem state size larger than "
 				   "available in BAR2: 0x%llx > 0x%llx\n",
-			 adapter->ps_size, p2_size(dev) - adapter->ps_off);
+			 adapter->ps_size, p2_size(dev) - adapter->native->ps_off);
 		return -EINVAL;
 	}
 
@@ -1066,6 +1075,7 @@ static void cxl_release_adapter(struct device *dev)
 
 	cxl_remove_adapter_nr(adapter);
 
+	kfree(adapter->native);
 	kfree(adapter);
 }
 
@@ -1162,6 +1172,12 @@ static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
 	if (!adapter)
 		return ERR_PTR(-ENOMEM);
 
+	adapter->native = kzalloc(sizeof(struct cxl_native), GFP_KERNEL);
+	if (!adapter->native) {
+		rc = -ENOMEM;
+		goto err_release;
+	}
+
 	/* Set defaults for parameters which need to persist over
 	 * configure/reconfigure
 	 */
@@ -1171,8 +1187,7 @@ static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
 	rc = cxl_configure_adapter(adapter, dev);
 	if (rc) {
 		pci_disable_device(dev);
-		cxl_release_adapter(&adapter->dev);
-		return ERR_PTR(rc);
+		goto err_release;
 	}
 
 	/* Don't care if this one fails: */
@@ -1198,6 +1213,10 @@ err_put1:
 	cxl_deconfigure_adapter(adapter);
 	device_unregister(&adapter->dev);
 	return ERR_PTR(rc);
+
+err_release:
+	cxl_release_adapter(&adapter->dev);
+	return ERR_PTR(rc);
 }
 
 static void cxl_pci_remove_adapter(struct cxl *adapter)
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 300eafe..1a1409c 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -165,7 +165,7 @@ static ssize_t pp_mmio_off_show(struct device *device,
 {
 	struct cxl_afu *afu = to_afu_chardev_m(device);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->pp_offset);
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->native->pp_offset);
 }
 
 static ssize_t pp_mmio_len_show(struct device *device,
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index e8a8eed..baa4087 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -248,7 +248,7 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
 
 	/* Setup the PHB using arch provided callback */
 	phb->ops = &cxl_pcie_pci_ops;
-	phb->cfg_addr = afu->afu_desc_mmio + afu->crs_offset;
+	phb->cfg_addr = afu->native->afu_desc_mmio + afu->crs_offset;
 	phb->cfg_data = (void *)(u64)afu->crs_len;
 	phb->private_data = afu;
 	phb->controller_ops = cxl_pci_controller_ops;
@@ -278,7 +278,7 @@ void cxl_pci_vphb_reconfigure(struct cxl_afu *afu)
 	 * and remapped. We need to reflect this in the PHB's view of
 	 * the world.
 	 */
-	afu->phb->cfg_addr = afu->afu_desc_mmio + afu->crs_offset;
+	afu->phb->cfg_addr = afu->native->afu_desc_mmio + afu->crs_offset;
 }
 
 void cxl_pci_vphb_remove(struct cxl_afu *afu)
-- 
1.9.1
