Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 151811A0E09
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 16:07:55 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v3 24/24] cxl: Add AFU virtual PHB and kernel API
Date: Wed, 27 May 2015 16:07:18 +1000
Message-Id: <1432706838-20794-25-git-send-email-mikey@neuling.org>
In-Reply-To: <1432706838-20794-1-git-send-email-mikey@neuling.org>
References: <1432706838-20794-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch does two things.

Firstly it presents the Accelerator Function Unit (AFUs) behind the POWER
Service Layer (PSL) as PCI devices on a virtual PCI Host Bridge (vPHB).  This
in in addition to the PSL being a PCI device itself.

As part of the Coherent Accelerator Interface Architecture (CAIA) AFUs can
provide an AFU configuration.  This AFU configuration recored is architected to
be the same as a PCI config space.

This patch sets discovers the AFU configuration records, provides AFU config
space read/write functions to these configuration records.  It then enumerates
the PCI bus.  It also hooks in PCI ops where appropriate.  It also destroys the
vPHB when the physical card is removed.

Secondly, it add an in kernel API for AFU to use CXL.  AFUs must present a
driver that firstly binds as a PCI device.  This PCI device can then be using
to do CXL specific operations (that can't sit in the PCI ops) using this API.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/Makefile |   1 +
 drivers/misc/cxl/api.c    | 331 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/cxl/cxl.h    |   5 +
 drivers/misc/cxl/pci.c    |  17 ++-
 drivers/misc/cxl/vphb.c   | 269 +++++++++++++++++++++++++++++++++++++
 include/misc/cxl.h        | 203 ++++++++++++++++++++++++++++
 6 files changed, 822 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/cxl/api.c
 create mode 100644 drivers/misc/cxl/vphb.c
 create mode 100644 include/misc/cxl.h

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index f9f5514..14e3f82 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1,5 +1,6 @@
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
+cxl-y				+= vphb.o api.o
 obj-$(CONFIG_CXL)		+= cxl.o
 obj-$(CONFIG_CXL_BASE)		+= base.o
 
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
new file mode 100644
index 0000000..0c77240
--- /dev/null
+++ b/drivers/misc/cxl/api.c
@@ -0,0 +1,331 @@
+/*
+ * Copyright 2014 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <misc/cxl.h>
+
+#include "cxl.h"
+
+struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
+{
+	struct cxl_afu *afu;
+	struct cxl_context  *ctx;
+	int rc;
+
+	afu = cxl_pci_to_afu(dev);
+
+	ctx = cxl_context_alloc();
+	if (IS_ERR(ctx))
+		return ctx;
+
+	/* Make it a slave context.  We can promote it later? */
+	rc = cxl_context_init(ctx, afu, false, NULL);
+	if (rc) {
+		kfree(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+	cxl_assign_psn_space(ctx);
+
+	return ctx;
+}
+EXPORT_SYMBOL_GPL(cxl_dev_context_init);
+
+struct cxl_context *cxl_get_context(struct pci_dev *dev)
+{
+	return dev->dev.archdata.cxl_ctx;
+}
+EXPORT_SYMBOL_GPL(cxl_get_context);
+
+struct device *cxl_get_phys_dev(struct pci_dev *dev)
+{
+	struct cxl_afu *afu;
+
+	afu = cxl_pci_to_afu(dev);
+
+	return afu->adapter->dev.parent;
+}
+EXPORT_SYMBOL_GPL(cxl_get_phys_dev);
+
+int cxl_release_context(struct cxl_context *ctx)
+{
+	if (ctx->status != CLOSED)
+		return -EBUSY;
+
+	cxl_context_free(ctx);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_release_context);
+
+int cxl_allocate_afu_irqs(struct cxl_context *ctx, int num)
+{
+	if (num == 0)
+		num = ctx->afu->pp_irqs;
+	return afu_allocate_irqs(ctx, num);
+}
+EXPORT_SYMBOL_GPL(cxl_allocate_afu_irqs);
+
+void cxl_free_afu_irqs(struct cxl_context *ctx)
+{
+	cxl_release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
+}
+EXPORT_SYMBOL_GPL(cxl_free_afu_irqs);
+
+static irq_hw_number_t cxl_find_afu_irq(struct cxl_context *ctx, int num)
+{
+	__u16 range;
+	int r;
+
+	WARN_ON(num == 0);
+
+	for (r = 0; r < CXL_IRQ_RANGES; r++) {
+		range = ctx->irqs.range[r];
+		if (num < range) {
+			return ctx->irqs.offset[r] + num;
+		}
+		num -= range;
+	}
+	return 0;
+}
+
+int cxl_map_afu_irq(struct cxl_context *ctx, int num,
+		    irq_handler_t handler, void *cookie, char *name)
+{
+	irq_hw_number_t hwirq;
+
+	/*
+	 * Find interrupt we are to register.
+	 */
+	hwirq = cxl_find_afu_irq(ctx, num);
+	if (!hwirq)
+		return -ENOENT;
+
+	return cxl_map_irq(ctx->afu->adapter, hwirq, handler, cookie, name);
+}
+EXPORT_SYMBOL_GPL(cxl_map_afu_irq);
+
+void cxl_unmap_afu_irq(struct cxl_context *ctx, int num, void *cookie)
+{
+	irq_hw_number_t hwirq;
+	unsigned int virq;
+
+	hwirq = cxl_find_afu_irq(ctx, num);
+	if (!hwirq)
+		return;
+
+	virq = irq_find_mapping(NULL, hwirq);
+	if (virq)
+		cxl_unmap_irq(virq, cookie);
+}
+EXPORT_SYMBOL_GPL(cxl_unmap_afu_irq);
+
+/*
+ * Start a context
+ * Code here similar to afu_ioctl_start_work().
+ */
+int cxl_start_context(struct cxl_context *ctx, u64 wed,
+		      struct task_struct *task)
+{
+	int rc = 0;
+	bool kernel = true;
+
+	pr_devel("%s: pe: %i\n", __func__, ctx->pe);
+
+	mutex_lock(&ctx->status_mutex);
+	if (ctx->status == STARTED)
+		goto out; /* already started */
+
+	if (task) {
+		ctx->pid = get_task_pid(task, PIDTYPE_PID);
+		get_pid(ctx->pid);
+		kernel = false;
+	}
+
+	cxl_ctx_get();
+
+	if ((rc = cxl_attach_process(ctx, kernel, wed , 0))) {
+		put_pid(ctx->pid);
+		cxl_ctx_put();
+		goto out;
+	}
+
+	ctx->status = STARTED;
+	get_device(&ctx->afu->dev);
+out:
+	mutex_unlock(&ctx->status_mutex);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(cxl_start_context);
+
+int cxl_process_element(struct cxl_context *ctx)
+{
+	return ctx->pe;
+}
+EXPORT_SYMBOL_GPL(cxl_process_element);
+
+/* Stop a context.  Returns 0 on success, otherwise -Errno */
+int cxl_stop_context(struct cxl_context *ctx)
+{
+	int rc;
+
+	rc = __detach_context(ctx);
+	if (!rc)
+		put_device(&ctx->afu->dev);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(cxl_stop_context);
+
+void cxl_set_master(struct cxl_context *ctx)
+{
+	ctx->master = true;
+	cxl_assign_psn_space(ctx);
+}
+EXPORT_SYMBOL_GPL(cxl_set_master);
+
+/* wrappers around afu_* file ops which are EXPORTED */
+int cxl_fd_open(struct inode *inode, struct file *file)
+{
+	return afu_open(inode, file);
+}
+EXPORT_SYMBOL_GPL(cxl_fd_open);
+int cxl_fd_release(struct inode *inode, struct file *file)
+{
+	return afu_release(inode, file);
+}
+EXPORT_SYMBOL_GPL(cxl_fd_release);
+long cxl_fd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	return afu_ioctl(file, cmd, arg);
+}
+EXPORT_SYMBOL_GPL(cxl_fd_ioctl);
+int cxl_fd_mmap(struct file *file, struct vm_area_struct *vm)
+{
+	return afu_mmap(file, vm);
+}
+EXPORT_SYMBOL_GPL(cxl_fd_mmap);
+unsigned int cxl_fd_poll(struct file *file, struct poll_table_struct *poll)
+{
+	return afu_poll(file, poll);
+}
+EXPORT_SYMBOL_GPL(cxl_fd_poll);
+ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
+			loff_t *off)
+{
+	return afu_read(file, buf, count, off);
+}
+EXPORT_SYMBOL_GPL(cxl_fd_read);
+
+#define PATCH_FOPS(NAME) if (!fops->NAME) fops->NAME = afu_fops.NAME
+
+/* Get a struct file and fd for a context and attach the ops */
+struct file *cxl_get_fd(struct cxl_context *ctx, struct file_operations *fops,
+			int *fd)
+{
+	struct file *file;
+	int rc, flags, fdtmp;
+
+	flags = O_RDWR | O_CLOEXEC;
+
+	/* This code is similar to anon_inode_getfd() */
+	rc = get_unused_fd_flags(flags);
+	if (rc < 0)
+		return ERR_PTR(rc);
+	fdtmp = rc;
+
+	/*
+	 * Patch the file ops.  Needs to be careful that this is rentrant safe.
+	 */
+	if (fops) {
+		PATCH_FOPS(open);
+		PATCH_FOPS(poll);
+		PATCH_FOPS(read);
+		PATCH_FOPS(release);
+		PATCH_FOPS(unlocked_ioctl);
+		PATCH_FOPS(compat_ioctl);
+		PATCH_FOPS(mmap);
+	} else /* use default ops */
+		fops = (struct file_operations *)&afu_fops;
+
+	file = anon_inode_getfile("cxl", fops, ctx, flags);
+	if (IS_ERR(file))
+		put_unused_fd(fdtmp);
+	*fd = fdtmp;
+	return file;
+}
+EXPORT_SYMBOL_GPL(cxl_get_fd);
+
+struct cxl_context *cxl_fops_get_context(struct file *file)
+{
+	return file->private_data;
+}
+EXPORT_SYMBOL_GPL(cxl_fops_get_context);
+
+int cxl_start_work(struct cxl_context *ctx,
+		   struct cxl_ioctl_start_work *work)
+{
+	int rc;
+
+	/* code taken from afu_ioctl_start_work */
+	if (!(work->flags & CXL_START_WORK_NUM_IRQS))
+		work->num_interrupts = ctx->afu->pp_irqs;
+	else if ((work->num_interrupts < ctx->afu->pp_irqs) ||
+		 (work->num_interrupts > ctx->afu->irqs_max)) {
+		return -EINVAL;
+	}
+
+	rc = afu_register_irqs(ctx, work->num_interrupts);
+	if (rc)
+		return rc;
+
+	rc = cxl_start_context(ctx, work->work_element_descriptor, current);
+	if (rc < 0) {
+		afu_release_irqs(ctx, ctx);
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_start_work);
+
+void __iomem *cxl_psa_map(struct cxl_context *ctx)
+{
+	struct cxl_afu *afu = ctx->afu;
+	int rc;
+
+	rc = cxl_afu_check_and_enable(afu);
+	if (rc)
+		return NULL;
+
+	pr_devel("%s: psn_phys%llx size:%llx\n",
+		 __func__, afu->psn_phys, afu->adapter->ps_size);
+	return ioremap(ctx->psn_phys, ctx->psn_size);
+}
+EXPORT_SYMBOL_GPL(cxl_psa_map);
+
+void cxl_psa_unmap(void __iomem *addr)
+{
+	iounmap(addr);
+}
+EXPORT_SYMBOL_GPL(cxl_psa_unmap);
+
+int cxl_afu_reset(struct cxl_context *ctx)
+{
+	struct cxl_afu *afu = ctx->afu;
+	int rc;
+
+	rc = __cxl_afu_reset(afu);
+	if (rc)
+		return rc;
+
+	return cxl_afu_check_and_enable(afu);
+}
+EXPORT_SYMBOL_GPL(cxl_afu_reset);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index af67c4b..8473de4 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -377,6 +377,9 @@ struct cxl_afu {
 	int spa_max_procs;
 	unsigned int psl_virq;
 
+	/* pointer to the vphb */
+	struct pci_controller *phb;
+
 	int pp_irqs;
 	int irqs_max;
 	int num_procs;
@@ -667,6 +670,8 @@ int cxl_afu_check_and_enable(struct cxl_afu *afu);
 int cxl_psl_purge(struct cxl_afu *afu);
 
 void cxl_stop_trace(struct cxl *cxl);
+int cxl_pci_vphb_add(struct cxl_afu *afu);
+void cxl_pci_vphb_remove(struct cxl_afu *afu);
 
 extern struct pci_driver cxl_pci_driver;
 int afu_allocate_irqs(struct cxl_context *ctx, u32 count);
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 3879bdf..b326773 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -741,6 +741,9 @@ static int cxl_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
 
 	adapter->afu[afu->slice] = afu;
 
+	if ((rc = cxl_pci_vphb_add(afu)))
+		dev_info(&afu->dev, "Can't register vPHB\n");
+
 	return 0;
 
 err_put2:
@@ -793,8 +796,10 @@ int cxl_reset(struct cxl *adapter)
 
 	dev_info(&dev->dev, "CXL reset\n");
 
-	for (i = 0; i < adapter->slices; i++)
+	for (i = 0; i < adapter->slices; i++) {
+		cxl_pci_vphb_remove(adapter->afu[i]);
 		cxl_remove_afu(adapter->afu[i]);
+	}
 
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
 	 * PERST assert/deassert.  PERST triggers a loading of the image
@@ -1128,14 +1133,18 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 static void cxl_remove(struct pci_dev *dev)
 {
 	struct cxl *adapter = pci_get_drvdata(dev);
-	int afu;
+	struct cxl_afu *afu;
+	int i;
 
 	/*
 	 * Lock to prevent someone grabbing a ref through the adapter list as
 	 * we are removing it
 	 */
-	for (afu = 0; afu < adapter->slices; afu++)
-		cxl_remove_afu(adapter->afu[afu]);
+	for (i = 0; i < adapter->slices; i++) {
+		afu = adapter->afu[i];
+		cxl_pci_vphb_remove(afu);
+		cxl_remove_afu(afu);
+	}
 	cxl_remove_adapter(adapter);
 }
 
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
new file mode 100644
index 0000000..f733309
--- /dev/null
+++ b/drivers/misc/cxl/vphb.c
@@ -0,0 +1,269 @@
+/*
+ * Copyright 2014 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/pci.h>
+#include <misc/cxl.h>
+#include "cxl.h"
+
+static int cxl_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
+{
+	if (dma_mask < DMA_BIT_MASK(64)) {
+		pr_info("%s only 64bit DMA supported on CXL", __func__);
+		return -EIO;
+	}
+
+	*(pdev->dev.dma_mask) = dma_mask;
+	return 0;
+}
+
+static int cxl_pci_probe_mode(struct pci_bus *bus)
+{
+	return PCI_PROBE_NORMAL;
+}
+
+static int cxl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+{
+	return -ENODEV;
+}
+
+static void cxl_teardown_msi_irqs(struct pci_dev *pdev)
+{
+	/*
+	 * MSI should never be set but need still need to provide this call
+	 * back.
+	 */
+}
+
+static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
+{
+	struct pci_controller *phb;
+	struct cxl_afu *afu;
+	struct cxl_context *ctx;
+
+	phb = pci_bus_to_host(dev->bus);
+	afu = (struct cxl_afu *)phb->private_data;
+	set_dma_ops(&dev->dev, &dma_direct_ops);
+	set_dma_offset(&dev->dev, PAGE_OFFSET);
+
+	/*
+	 * Allocate a context to do cxl things too.  If we eventually do real
+	 * DMA ops, we'll need a default context to attach them to
+	 */
+	ctx = cxl_dev_context_init(dev);
+	if (!ctx)
+		return false;
+	dev->dev.archdata.cxl_ctx = ctx;
+
+	return (cxl_afu_check_and_enable(afu) == 0);
+}
+
+static void cxl_pci_disable_device(struct pci_dev *dev)
+{
+	struct cxl_context *ctx = cxl_get_context(dev);
+
+	if (ctx) {
+		if (ctx->status == STARTED) {
+			dev_err(&dev->dev, "Default context started\n");
+			return;
+		}
+		cxl_release_context(ctx);
+	}
+}
+
+static resource_size_t cxl_pci_window_alignment(struct pci_bus *bus,
+						unsigned long type)
+{
+	return 1;
+}
+
+static void cxl_pci_reset_secondary_bus(struct pci_dev *dev)
+{
+	/* Should we do an AFU reset here ? */
+}
+
+static int cxl_pcie_cfg_record(u8 bus, u8 devfn)
+{
+	return (bus << 8) + devfn;
+}
+
+static unsigned long cxl_pcie_cfg_addr(struct pci_controller* phb,
+				       u8 bus, u8 devfn, int offset)
+{
+	int record = cxl_pcie_cfg_record(bus, devfn);
+
+	return (unsigned long)phb->cfg_addr + ((unsigned long)phb->cfg_data * record) + offset;
+}
+
+
+static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
+				int offset, int len,
+				volatile void __iomem **ioaddr,
+				u32 *mask, int *shift)
+{
+	struct pci_controller *phb;
+	struct cxl_afu *afu;
+	unsigned long addr;
+
+	phb = pci_bus_to_host(bus);
+	afu = (struct cxl_afu *)phb->private_data;
+	if (phb == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (cxl_pcie_cfg_record(bus->number, devfn) > afu->crs_num)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (offset >= (unsigned long)phb->cfg_data)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	addr = cxl_pcie_cfg_addr(phb, bus->number, devfn, offset);
+
+	*ioaddr = (void *)(addr & ~0x3ULL);
+	*shift = ((addr & 0x3) * 8);
+	switch (len) {
+	case 1:
+		*mask = 0xff;
+		break;
+	case 2:
+		*mask = 0xffff;
+		break;
+	default:
+		*mask = 0xffffffff;
+		break;
+	}
+	return 0;
+}
+
+static int cxl_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
+				int offset, int len, u32 *val)
+{
+	volatile void __iomem *ioaddr;
+	int shift, rc;
+	u32 mask;
+
+	rc = cxl_pcie_config_info(bus, devfn, offset, len, &ioaddr,
+				  &mask, &shift);
+	if (rc)
+		return rc;
+
+	/* Can only read 32 bits */
+	*val = (in_le32(ioaddr) >> shift) & mask;
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
+				 int offset, int len, u32 val)
+{
+	volatile void __iomem *ioaddr;
+	u32 v, mask;
+	int shift, rc;
+
+	rc = cxl_pcie_config_info(bus, devfn, offset, len, &ioaddr,
+				  &mask, &shift);
+	if (rc)
+		return rc;
+
+	/* Can only write 32 bits so do read-modify-write */
+	mask <<= shift;
+	val <<= shift;
+
+	v = (in_le32(ioaddr) & ~mask) || (val & mask);
+
+	out_le32(ioaddr, v);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops cxl_pcie_pci_ops =
+{
+	.read = cxl_pcie_read_config,
+	.write = cxl_pcie_write_config,
+};
+
+
+static struct pci_controller_ops cxl_pci_controller_ops =
+{
+	.probe_mode = cxl_pci_probe_mode,
+	.enable_device_hook = cxl_pci_enable_device_hook,
+	.disable_device = cxl_pci_disable_device,
+	.release_device = cxl_pci_disable_device,
+	.window_alignment = cxl_pci_window_alignment,
+	.reset_secondary_bus = cxl_pci_reset_secondary_bus,
+	.setup_msi_irqs = cxl_setup_msi_irqs,
+	.teardown_msi_irqs = cxl_teardown_msi_irqs,
+	.dma_set_mask = cxl_dma_set_mask,
+};
+
+int cxl_pci_vphb_add(struct cxl_afu *afu)
+{
+	struct pci_dev *phys_dev;
+	struct pci_controller *phb, *phys_phb;
+
+	phys_dev = to_pci_dev(afu->adapter->dev.parent);
+	phys_phb = pci_bus_to_host(phys_dev->bus);
+
+	/* Alloc and setup PHB data structure */
+	phb = pcibios_alloc_controller(phys_phb->dn);
+
+	if (!phb)
+		return -ENODEV;
+
+	/* Setup parent in sysfs */
+	phb->parent = &phys_dev->dev;
+
+	/* Setup the PHB using arch provided callback */
+	phb->ops = &cxl_pcie_pci_ops;
+	phb->cfg_addr = afu->afu_desc_mmio + afu->crs_offset;
+	phb->cfg_data = (void *)(u64)afu->crs_len;
+	phb->private_data = afu;
+	phb->controller_ops = cxl_pci_controller_ops;
+
+	/* Scan the bus */
+	pcibios_scan_phb(phb);
+	if (phb->bus == NULL)
+		return -ENXIO;
+
+	/* Claim resources. This might need some rework as well depending
+	 * whether we are doing probe-only or not, like assigning unassigned
+	 * resources etc...
+	 */
+	pcibios_claim_one_bus(phb->bus);
+
+	/* Add probed PCI devices to the device model */
+	pci_bus_add_devices(phb->bus);
+
+	afu->phb = phb;
+
+	return 0;
+}
+
+
+void cxl_pci_vphb_remove(struct cxl_afu *afu)
+{
+	struct pci_controller *phb;
+
+	/* If there is no configuration record we won't have one of these */
+	if (!afu || !afu->phb)
+		return;
+
+	phb = afu->phb;
+
+	pci_remove_root_bus(phb->bus);
+}
+
+struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev)
+{
+	struct pci_controller *phb;
+
+	phb = pci_bus_to_host(dev->bus);
+
+	return (struct cxl_afu *)phb->private_data;
+}
+EXPORT_SYMBOL_GPL(cxl_pci_to_afu);
+
+unsigned int cxl_pci_to_cfg_record(struct pci_dev *dev)
+{
+	return cxl_pcie_cfg_record(dev->bus->number, dev->devfn);
+}
+EXPORT_SYMBOL_GPL(cxl_pci_to_cfg_record);
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
new file mode 100644
index 0000000..7a6c1d6
--- /dev/null
+++ b/include/misc/cxl.h
@@ -0,0 +1,203 @@
+/*
+ * Copyright 2015 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _MISC_CXL_H
+#define _MISC_CXL_H
+
+#include <linux/pci.h>
+#include <linux/poll.h>
+#include <linux/interrupt.h>
+#include <uapi/misc/cxl.h>
+
+/*
+ * This documents the in kernel API for driver to use CXL. It allows kernel
+ * drivers to bind to AFUs using an AFU configuration record exposed as a PCI
+ * configuration record.
+ *
+ * This API enables control over AFU and contexts which can't be part of the
+ * generic PCI API. This API is agnostic to the actual AFU.
+ */
+
+/* Get the AFU associated with a pci_dev */
+struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev);
+
+/* Get the AFU conf record number associated with a pci_dev */
+unsigned int cxl_pci_to_cfg_record(struct pci_dev *dev);
+
+/* Get the physical device (ie. the PCIe card) which the AFU is attached */
+struct device *cxl_get_phys_dev(struct pci_dev *dev);
+
+
+/*
+ * Context lifetime overview:
+ *
+ * An AFU context may be inited and then started and stoppped multiple times
+ * before it's released. ie.
+ *    - cxl_dev_context_init()
+ *      - cxl_start_context()
+ *      - cxl_stop_context()
+ *      - cxl_start_context()
+ *      - cxl_stop_context()
+ *     ...repeat...
+ *    - cxl_release_context()
+ * Once released, a context can't be started again.
+ *
+ * One context is inited by the cxl driver for every pci_dev. This is to be
+ * used as a default kernel context. cxl_get_context() will get this
+ * context. This context will be released by PCI hot unplug, so doesn't need to
+ * be released explicitly by drivers.
+ *
+ * Additional kernel contexts may be inited using cxl_dev_context_init().
+ * These must be released using cxl_context_detach().
+ *
+ * Once a context has been inited, IRQs may be configured. Firstly these IRQs
+ * must be allocated (cxl_allocate_afu_irqs()), then individually mapped to
+ * specific handlers (cxl_map_afu_irq()).
+ *
+ * These IRQs can be unmapped (cxl_unmap_afu_irq()) and finally released
+ * (cxl_free_afu_irqs()).
+ *
+ * The AFU can be reset (cxl_afu_reset()). This will cause the PSL/AFU
+ * hardware to lose track of all contexts. It's upto the caller of
+ * cxl_afu_reset() to restart these contexts.
+ */
+
+/*
+ * On pci_enabled_device(), the cxl driver will init a single cxl context for
+ * use by the driver. It doesn't start this context (as that will likely
+ * generate DMA traffic for most AFUs).
+ *
+ * This gets the default context associated with this pci_dev.  This context
+ * doesn't need to be released as this will be done by the PCI subsystem on hot
+ * unplug.
+ */
+struct cxl_context *cxl_get_context(struct pci_dev *dev);
+/*
+ * Allocate and initalise a context associated with a AFU PCI device. This
+ * doesn't start the context in the AFU.
+ */
+struct cxl_context *cxl_dev_context_init(struct pci_dev *dev);
+/*
+ * Release and free a context. Context should be stopped before calling.
+ */
+int cxl_release_context(struct cxl_context *ctx);
+
+/*
+ * Allocate AFU interrupts for this context. num=0 will allocate the default
+ * for this AFU as given in the AFU descriptor. This number doesn't include the
+ * interrupt 0 (CAIA defines AFU IRQ 0 for page faults). Each interrupt to be
+ * used must map a handler with cxl_map_afu_irq.
+ */
+int cxl_allocate_afu_irqs(struct cxl_context *cxl, int num);
+/* Free allocated interrupts */
+void cxl_free_afu_irqs(struct cxl_context *cxl);
+
+/*
+ * Map a handler for an AFU interrupt associated with a particular context. AFU
+ * IRQS numbers start from 1 (CAIA defines AFU IRQ 0 for page faults). cookie
+ * is private data is that will be provided to the interrupt handler.
+ */
+int cxl_map_afu_irq(struct cxl_context *cxl, int num,
+		    irq_handler_t handler, void *cookie, char *name);
+/* unmap mapped IRQ handlers */
+void cxl_unmap_afu_irq(struct cxl_context *cxl, int num, void *cookie);
+
+/*
+ * Start work on the AFU. This starts an cxl context and associates it with a
+ * task. task == NULL will make it a kernel context.
+ */
+int cxl_start_context(struct cxl_context *ctx, u64 wed,
+		      struct task_struct *task);
+/*
+ * Stop a context and remove it from the PSL
+ */
+int cxl_stop_context(struct cxl_context *ctx);
+
+/* Reset the AFU */
+int cxl_afu_reset(struct cxl_context *ctx);
+
+/*
+ * Set a context as a master context.
+ * This sets the default problem space area mapped as the full space, rather
+ * than just the per context area (for slaves).
+ */
+void cxl_set_master(struct cxl_context *ctx);
+
+/*
+ * Map and unmap the AFU Problem Space area. The amount and location mapped
+ * depends on if this context is a master or slave.
+ */
+void __iomem *cxl_psa_map(struct cxl_context *ctx);
+void cxl_psa_unmap(void __iomem *addr);
+
+/*  Get the process element for this context */
+int cxl_process_element(struct cxl_context *ctx);
+
+
+/*
+ * These calls allow drivers to create their own file descriptors and make them
+ * identical to the cxl file descriptor user API. An example use case:
+ *
+ * struct file_operations cxl_my_fops = {};
+ * ......
+ *	// Init the context
+ *	ctx = cxl_dev_context_init(dev);
+ *	if (IS_ERR(ctx))
+ *		return PTR_ERR(ctx);
+ *	// Create and attach a new file descriptor to my file ops
+ *	file = cxl_get_fd(ctx, &cxl_my_fops, &fd);
+ *	// Start context
+ *	rc = cxl_start_work(ctx, &work.work);
+ *	if (rc) {
+ *		fput(file);
+ *		put_unused_fd(fd);
+ *		return -ENODEV;
+ *	}
+ *	// No error paths after installing the fd
+ *	fd_install(fd, file);
+ *	return fd;
+ *
+ * This inits a context, and gets a file descriptor and associates some file
+ * ops to that file descriptor. If the file ops are blank, the cxl driver will
+ * fill them in with the default ones that mimic the standard user API.  Once
+ * completed, the file descriptor can be installed. Once the file descriptor is
+ * installed, it's visible to the user so no errors must occur past this point.
+ *
+ * If cxl_fd_release() file op call is installed, the context will be stopped
+ * and released when the fd is released. Hence the driver won't need to manage
+ * this itself.
+ */
+
+/*
+ * Take a context and associate it with my file ops. Returns the associated
+ * file and file descriptor. Any file ops which are blank are filled in by the
+ * cxl driver with the default ops to mimic the standard API.
+ */
+struct file *cxl_get_fd(struct cxl_context *ctx, struct file_operations *fops,
+			int *fd);
+/* Get the context associated with this file */
+struct cxl_context *cxl_fops_get_context(struct file *file);
+/*
+ * Start a context associated a struct cxl_ioctl_start_work used by the
+ * standard cxl user API.
+ */
+int cxl_start_work(struct cxl_context *ctx,
+		   struct cxl_ioctl_start_work *work);
+/*
+ * Export all the existing fops so drivers can use them
+ */
+int cxl_fd_open(struct inode *inode, struct file *file);
+int cxl_fd_release(struct inode *inode, struct file *file);
+long cxl_fd_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int cxl_fd_mmap(struct file *file, struct vm_area_struct *vm);
+unsigned int cxl_fd_poll(struct file *file, struct poll_table_struct *poll);
+ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
+			   loff_t *off);
+
+#endif /* _MISC_CXL_H */
-- 
2.1.0
