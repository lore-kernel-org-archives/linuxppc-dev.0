Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79A201A1D61
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 14:14:15 +1000 (AEST)
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC86A1401E7
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2015 14:14:14 +1000 (AEST)
Received: by pdrg1 with SMTP id g1so14523564pdr.2
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 21:14:13 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, cyrilbur@gmail.com,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey@neuling.org, imunsie@au.ibm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 02/11] cxl: Drop commands if the PCI channel is not in
 normal state
Date: Thu, 13 Aug 2015 14:11:20 +1000
Message-Id: <1439439089-25151-3-git-send-email-dja@axtens.net>
In-Reply-To: <1439439089-25151-1-git-send-email-dja@axtens.net>
References: <1439439089-25151-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the PCI channel has gone down, don't attempt to poke the hardware.

We need to guard every time cxl_whatever_(read|write) is called. This
is because a call to those functions will dereference an offset into an
mmio register, and the mmio mappings get invalidated in the EEH
teardown.

Check in the read/write functions in the header.
We give them the same semantics as usual PCI operations:
 - a write to a channel that is down is ignored.
 - a read from a channel that is down returns all fs.

Also, we try to access the MMIO space of a vPHB device as part of the
PCI disable path. Because that's a read that bypasses most of our usual
checks, we handle it explicitly.

As far as user visible warnings go:
 - Check link state in file ops, return -EIO if down.
 - Be reasonably quiet if there's an error in a teardown path,
   or when we already know the hardware is going down.
 - Throw a big WARN if someone tries to start a CXL operation
   while the card is down. This gives a useful stacktrace for
   debugging whatever is doing that.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/context.c |  6 +++-
 drivers/misc/cxl/cxl.h     | 44 ++++++++++++++++++++++------
 drivers/misc/cxl/file.c    | 19 +++++++++++++
 drivers/misc/cxl/native.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/misc/cxl/vphb.c    | 26 +++++++++++++++++
 5 files changed, 154 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 1287148629c0..615842115848 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -193,7 +193,11 @@ int __detach_context(struct cxl_context *ctx)
 	if (status != STARTED)
 		return -EBUSY;
 
-	WARN_ON(cxl_detach_process(ctx));
+	/* Only warn if we detached while the link was OK.
+	 * If detach fails when hw is down, we don't care.
+	 */
+	WARN_ON(cxl_detach_process(ctx) &&
+		cxl_adapter_link_ok(ctx->afu->adapter));
 	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
 	put_pid(ctx->pid);
 	cxl_ctx_put();
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 6a93bfbcd826..9b9e89fd02cc 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -531,6 +531,14 @@ struct cxl_process_element {
 	__be32 software_state;
 } __packed;
 
+static inline bool cxl_adapter_link_ok(struct cxl *cxl)
+{
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(cxl->dev.parent);
+	return !pci_channel_offline(pdev);
+}
+
 static inline void __iomem *_cxl_p1_addr(struct cxl *cxl, cxl_p1_reg_t reg)
 {
 	WARN_ON(!cpu_has_feature(CPU_FTR_HVMODE));
@@ -539,12 +547,16 @@ static inline void __iomem *_cxl_p1_addr(struct cxl *cxl, cxl_p1_reg_t reg)
 
 static inline void cxl_p1_write(struct cxl *cxl, cxl_p1_reg_t reg, u64 val)
 {
-	out_be64(_cxl_p1_addr(cxl, reg), val);
+	if (likely(cxl_adapter_link_ok(cxl)))
+		out_be64(_cxl_p1_addr(cxl, reg), val);
 }
 
 static inline u64 cxl_p1_read(struct cxl *cxl, cxl_p1_reg_t reg)
 {
-	return in_be64(_cxl_p1_addr(cxl, reg));
+	if (likely(cxl_adapter_link_ok(cxl)))
+		return in_be64(_cxl_p1_addr(cxl, reg));
+	else
+		return ~0ULL;
 }
 
 static inline void __iomem *_cxl_p1n_addr(struct cxl_afu *afu, cxl_p1n_reg_t reg)
@@ -555,12 +567,16 @@ static inline void __iomem *_cxl_p1n_addr(struct cxl_afu *afu, cxl_p1n_reg_t reg
 
 static inline void cxl_p1n_write(struct cxl_afu *afu, cxl_p1n_reg_t reg, u64 val)
 {
-	out_be64(_cxl_p1n_addr(afu, reg), val);
+	if (likely(cxl_adapter_link_ok(afu->adapter)))
+		out_be64(_cxl_p1n_addr(afu, reg), val);
 }
 
 static inline u64 cxl_p1n_read(struct cxl_afu *afu, cxl_p1n_reg_t reg)
 {
-	return in_be64(_cxl_p1n_addr(afu, reg));
+	if (likely(cxl_adapter_link_ok(afu->adapter)))
+		return in_be64(_cxl_p1n_addr(afu, reg));
+	else
+		return ~0ULL;
 }
 
 static inline void __iomem *_cxl_p2n_addr(struct cxl_afu *afu, cxl_p2n_reg_t reg)
@@ -570,22 +586,34 @@ static inline void __iomem *_cxl_p2n_addr(struct cxl_afu *afu, cxl_p2n_reg_t reg
 
 static inline void cxl_p2n_write(struct cxl_afu *afu, cxl_p2n_reg_t reg, u64 val)
 {
-	out_be64(_cxl_p2n_addr(afu, reg), val);
+	if (likely(cxl_adapter_link_ok(afu->adapter)))
+		out_be64(_cxl_p2n_addr(afu, reg), val);
 }
 
 static inline u64 cxl_p2n_read(struct cxl_afu *afu, cxl_p2n_reg_t reg)
 {
-	return in_be64(_cxl_p2n_addr(afu, reg));
+	if (likely(cxl_adapter_link_ok(afu->adapter)))
+		return in_be64(_cxl_p2n_addr(afu, reg));
+	else
+		return ~0ULL;
 }
 
 static inline u64 cxl_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off)
 {
-	return in_le64((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off));
+	if (likely(cxl_adapter_link_ok(afu->adapter)))
+		return in_le64((afu)->afu_desc_mmio + (afu)->crs_offset +
+			       ((cr) * (afu)->crs_len) + (off));
+	else
+		return ~0ULL;
 }
 
 static inline u32 cxl_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off)
 {
-	return in_le32((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off));
+	if (likely(cxl_adapter_link_ok(afu->adapter)))
+		return in_le32((afu)->afu_desc_mmio + (afu)->crs_offset +
+			       ((cr) * (afu)->crs_len) + (off));
+	else
+		return 0xffffffff;
 }
 u16 cxl_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off);
 u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off);
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index c8c8bfa2679b..57bdb473749f 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -73,6 +73,11 @@ static int __afu_open(struct inode *inode, struct file *file, bool master)
 	if (!afu->current_mode)
 		goto err_put_afu;
 
+	if (!cxl_adapter_link_ok(adapter)) {
+		rc = -EIO;
+		goto err_put_afu;
+	}
+
 	if (!(ctx = cxl_context_alloc())) {
 		rc = -ENOMEM;
 		goto err_put_afu;
@@ -238,6 +243,9 @@ long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (ctx->status == CLOSED)
 		return -EIO;
 
+	if (!cxl_adapter_link_ok(ctx->afu->adapter))
+		return -EIO;
+
 	pr_devel("afu_ioctl\n");
 	switch (cmd) {
 	case CXL_IOCTL_START_WORK:
@@ -265,6 +273,9 @@ int afu_mmap(struct file *file, struct vm_area_struct *vm)
 	if (ctx->status != STARTED)
 		return -EIO;
 
+	if (!cxl_adapter_link_ok(ctx->afu->adapter))
+		return -EIO;
+
 	return cxl_context_iomap(ctx, vm);
 }
 
@@ -309,6 +320,9 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	int rc;
 	DEFINE_WAIT(wait);
 
+	if (!cxl_adapter_link_ok(ctx->afu->adapter))
+		return -EIO;
+
 	if (count < CXL_READ_MIN_SIZE)
 		return -EINVAL;
 
@@ -319,6 +333,11 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 		if (ctx_event_pending(ctx))
 			break;
 
+		if (!cxl_adapter_link_ok(ctx->afu->adapter)) {
+			rc = -EIO;
+			goto out;
+		}
+
 		if (file->f_flags & O_NONBLOCK) {
 			rc = -EAGAIN;
 			goto out;
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 0c94ba27e658..cd1dda5fcd3a 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -41,6 +41,12 @@ static int afu_control(struct cxl_afu *afu, u64 command,
 			rc = -EBUSY;
 			goto out;
 		}
+		if (!cxl_adapter_link_ok(afu->adapter)) {
+			afu->enabled = enabled;
+			rc = -EIO;
+			goto out;
+		}
+
 		pr_devel_ratelimited("AFU control... (0x%.16llx)\n",
 				     AFU_Cntl | command);
 		cpu_relax();
@@ -85,6 +91,10 @@ int __cxl_afu_reset(struct cxl_afu *afu)
 
 int cxl_afu_check_and_enable(struct cxl_afu *afu)
 {
+	if (!cxl_adapter_link_ok(afu->adapter)) {
+		WARN(1, "Refusing to enable afu while link down!\n");
+		return -EIO;
+	}
 	if (afu->enabled)
 		return 0;
 	return afu_enable(afu);
@@ -103,6 +113,12 @@ int cxl_psl_purge(struct cxl_afu *afu)
 
 	pr_devel("PSL purge request\n");
 
+	if (!cxl_adapter_link_ok(afu->adapter)) {
+		dev_warn(&afu->dev, "PSL Purge called with link down, ignoring\n");
+		rc = -EIO;
+		goto out;
+	}
+
 	if ((AFU_Cntl & CXL_AFU_Cntl_An_ES_MASK) != CXL_AFU_Cntl_An_ES_Disabled) {
 		WARN(1, "psl_purge request while AFU not disabled!\n");
 		cxl_afu_disable(afu);
@@ -119,6 +135,11 @@ int cxl_psl_purge(struct cxl_afu *afu)
 			rc = -EBUSY;
 			goto out;
 		}
+		if (!cxl_adapter_link_ok(afu->adapter)) {
+			rc = -EIO;
+			goto out;
+		}
+
 		dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
 		pr_devel_ratelimited("PSL purging... PSL_CNTL: 0x%.16llx  PSL_DSISR: 0x%.16llx\n", PSL_CNTL, dsisr);
 		if (dsisr & CXL_PSL_DSISR_TRANS) {
@@ -215,6 +236,8 @@ int cxl_tlb_slb_invalidate(struct cxl *adapter)
 			dev_warn(&adapter->dev, "WARNING: CXL adapter wide TLBIA timed out!\n");
 			return -EBUSY;
 		}
+		if (!cxl_adapter_link_ok(adapter))
+			return -EIO;
 		cpu_relax();
 	}
 
@@ -224,6 +247,8 @@ int cxl_tlb_slb_invalidate(struct cxl *adapter)
 			dev_warn(&adapter->dev, "WARNING: CXL adapter wide SLBIA timed out!\n");
 			return -EBUSY;
 		}
+		if (!cxl_adapter_link_ok(adapter))
+			return -EIO;
 		cpu_relax();
 	}
 	return 0;
@@ -240,6 +265,11 @@ int cxl_afu_slbia(struct cxl_afu *afu)
 			dev_warn(&afu->dev, "WARNING: CXL AFU SLBIA timed out!\n");
 			return -EBUSY;
 		}
+		/* If the adapter has gone down, we can assume that we
+		 * will PERST it and that will invalidate everything.
+		 */
+		if (!cxl_adapter_link_ok(afu->adapter))
+			return -EIO;
 		cpu_relax();
 	}
 	return 0;
@@ -279,6 +309,8 @@ static void slb_invalid(struct cxl_context *ctx)
 	cxl_p1_write(adapter, CXL_PSL_SLBIA, CXL_TLB_SLB_IQ_LPIDPID);
 
 	while (1) {
+		if (!cxl_adapter_link_ok(adapter))
+			break;
 		slbia = cxl_p1_read(adapter, CXL_PSL_SLBIA);
 		if (!(slbia & CXL_TLB_SLB_P))
 			break;
@@ -308,6 +340,11 @@ static int do_process_element_cmd(struct cxl_context *ctx,
 			rc = -EBUSY;
 			goto out;
 		}
+		if (!cxl_adapter_link_ok(ctx->afu->adapter)) {
+			dev_warn(&ctx->afu->dev, "WARNING: Device link down, aborting Process Element Command!\n");
+			rc = -EIO;
+			goto out;
+		}
 		state = be64_to_cpup(ctx->afu->sw_command_status);
 		if (state == ~0ULL) {
 			pr_err("cxl: Error adding process element to AFU\n");
@@ -355,8 +392,13 @@ static int terminate_process_element(struct cxl_context *ctx)
 
 	mutex_lock(&ctx->afu->spa_mutex);
 	pr_devel("%s Terminate pe: %i started\n", __func__, ctx->pe);
-	rc = do_process_element_cmd(ctx, CXL_SPA_SW_CMD_TERMINATE,
-				    CXL_PE_SOFTWARE_STATE_V | CXL_PE_SOFTWARE_STATE_T);
+	/* We could be asked to terminate when the hw is down. That
+	 * should always succeed: it's not running if the hw has gone
+	 * away and is being reset.
+	 */
+	if (cxl_adapter_link_ok(ctx->afu->adapter))
+		rc = do_process_element_cmd(ctx, CXL_SPA_SW_CMD_TERMINATE,
+					    CXL_PE_SOFTWARE_STATE_V | CXL_PE_SOFTWARE_STATE_T);
 	ctx->elem->software_state = 0;	/* Remove Valid bit */
 	pr_devel("%s Terminate pe: %i finished\n", __func__, ctx->pe);
 	mutex_unlock(&ctx->afu->spa_mutex);
@@ -369,7 +411,14 @@ static int remove_process_element(struct cxl_context *ctx)
 
 	mutex_lock(&ctx->afu->spa_mutex);
 	pr_devel("%s Remove pe: %i started\n", __func__, ctx->pe);
-	if (!(rc = do_process_element_cmd(ctx, CXL_SPA_SW_CMD_REMOVE, 0)))
+
+	/* We could be asked to remove when the hw is down. Again, if
+	 * the hw is down, the PE is gone, so we succeed.
+	 */
+	if (cxl_adapter_link_ok(ctx->afu->adapter))
+		rc = do_process_element_cmd(ctx, CXL_SPA_SW_CMD_REMOVE, 0);
+
+	if (!rc)
 		ctx->pe_inserted = false;
 	slb_invalid(ctx);
 	pr_devel("%s Remove pe: %i finished\n", __func__, ctx->pe);
@@ -612,6 +661,11 @@ int cxl_afu_activate_mode(struct cxl_afu *afu, int mode)
 	if (!(mode & afu->modes_supported))
 		return -EINVAL;
 
+	if (!cxl_adapter_link_ok(afu->adapter)) {
+		WARN(1, "Device link is down, refusing to activate!\n");
+		return -EIO;
+	}
+
 	if (mode == CXL_MODE_DIRECTED)
 		return activate_afu_directed(afu);
 	if (mode == CXL_MODE_DEDICATED)
@@ -622,6 +676,11 @@ int cxl_afu_activate_mode(struct cxl_afu *afu, int mode)
 
 int cxl_attach_process(struct cxl_context *ctx, bool kernel, u64 wed, u64 amr)
 {
+	if (!cxl_adapter_link_ok(ctx->afu->adapter)) {
+		WARN(1, "Device link is down, refusing to attach process!\n");
+		return -EIO;
+	}
+
 	ctx->kernel = kernel;
 	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
 		return attach_afu_directed(ctx, wed, amr);
@@ -666,6 +725,12 @@ int cxl_get_irq(struct cxl_afu *afu, struct cxl_irq_info *info)
 {
 	u64 pidtid;
 
+	/* If the adapter has gone away, we can't get any meaningful
+	 * information.
+	 */
+	if (!cxl_adapter_link_ok(afu->adapter))
+		return -EIO;
+
 	info->dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
 	info->dar = cxl_p2n_read(afu, CXL_PSL_DAR_An);
 	info->dsr = cxl_p2n_read(afu, CXL_PSL_DSR_An);
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 2eba002b580b..2930911c1e42 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -138,6 +138,26 @@ static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
 	return 0;
 }
 
+
+static inline bool cxl_config_link_ok(struct pci_bus *bus)
+{
+	struct pci_controller *phb;
+	struct cxl_afu *afu;
+
+	/* Config space IO is based on phb->cfg_addr, which is based on
+	 * afu_desc_mmio. This isn't safe to read/write when the link
+	 * goes down, as EEH tears down MMIO space.
+	 *
+	 * Check if the link is OK before proceeding.
+	 */
+
+	phb = pci_bus_to_host(bus);
+	if (phb == NULL)
+		return false;
+	afu = (struct cxl_afu *)phb->private_data;
+	return cxl_adapter_link_ok(afu->adapter);
+}
+
 static int cxl_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
 				int offset, int len, u32 *val)
 {
@@ -150,6 +170,9 @@ static int cxl_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
 	if (rc)
 		return rc;
 
+	if (!cxl_config_link_ok(bus))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	/* Can only read 32 bits */
 	*val = (in_le32(ioaddr) >> shift) & mask;
 	return PCIBIOS_SUCCESSFUL;
@@ -167,6 +190,9 @@ static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
 	if (rc)
 		return rc;
 
+	if (!cxl_config_link_ok(bus))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	/* Can only write 32 bits so do read-modify-write */
 	mask <<= shift;
 	val <<= shift;
-- 
2.1.4
