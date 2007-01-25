Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:09 +1100
Subject: [RFC/PATCH 5/16] Ops based MSI implementation
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083411.5D935DE2FD@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the guts of our ops based MSI implementation. We need to use the
ops approach to accommodate RTAS, where firmware handles all MSI
configuration, and also so we can build a single kernel which boots on
multiple hardware configurations.

So that we don't have to replace the existing code in a single patch, we
add PCI_MSI_NEW and PCI_MSI_OLD Kconfig symbols. These will vanish once
all platforms are using the new code.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/pci/Kconfig      |   21 ++++
 drivers/pci/Makefile     |    3 
 drivers/pci/msi/Makefile |    9 +
 drivers/pci/msi/core.c   |  224 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msi-ops.h  |  168 +++++++++++++++++++++++++++++++++++
 include/linux/pci.h      |    5 +
 6 files changed, 429 insertions(+), 1 deletion(-)

Index: msi/drivers/pci/Kconfig
===================================================================
--- msi.orig/drivers/pci/Kconfig
+++ msi/drivers/pci/Kconfig
@@ -17,6 +17,27 @@ config PCI_MSI
 
 	   If you don't know what to do here, say N.
 
+config PCI_MSI_NEW
+	bool
+	depends on PCI_MSI && !PCI_MSI_OLD
+
+config PCI_MSI_OLD
+	bool
+	depends on PCI_MSI && !PCI_MSI_NEW
+	default y
+
+config PCI_MSI_DEBUG
+	bool "PCI MSI Debugging"
+	depends on PCI_MSI_NEW && DEBUG_KERNEL
+	default y
+	help
+	  Say Y here if you want the PCI MSI code to produce a bunch of
+	  debug messages. This is probably only useful if you're working
+	  on MSI support for your platform, or debugging a driver that
+	  uses MSI.
+
+	  If in doubt, say N.
+
 config PCI_MULTITHREAD_PROBE
 	bool "PCI Multi-threaded probe (EXPERIMENTAL)"
 	depends on PCI && EXPERIMENTAL && BROKEN
Index: msi/drivers/pci/Makefile
===================================================================
--- msi.orig/drivers/pci/Makefile
+++ msi/drivers/pci/Makefile
@@ -15,7 +15,8 @@ obj-$(CONFIG_HOTPLUG) += hotplug.o
 obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
 
 # Build the PCI MSI interrupt support
-obj-$(CONFIG_PCI_MSI) += msi.o
+obj-$(CONFIG_PCI_MSI_OLD) += msi.o
+obj-$(CONFIG_PCI_MSI_NEW) += msi/
 
 # Build the Hypertransport interrupt support
 obj-$(CONFIG_HT_IRQ) += htirq.o
Index: msi/drivers/pci/msi/Makefile
===================================================================
--- /dev/null
+++ msi/drivers/pci/msi/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for the PCI MSI support
+#
+
+obj-y			+= core.o
+
+ifeq ($(CONFIG_PCI_MSI_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
Index: msi/drivers/pci/msi/core.c
===================================================================
--- /dev/null
+++ msi/drivers/pci/msi/core.c
@@ -0,0 +1,224 @@
+/*
+ * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/msi.h>
+#include <linux/msi-ops.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <asm/msi.h>
+
+static int no_msi;
+
+void pci_no_msi(void)
+{
+	printk(KERN_DEBUG "PCI MSI disabled on command line.\n");
+	no_msi = 1;
+}
+
+
+/* msi_info helpers */
+
+static int alloc_msi_info(struct pci_dev *pdev, int num,
+			  struct msix_entry *entries, int type)
+{
+	struct msi_info *info;
+	unsigned int entries_size;
+
+	entries_size = sizeof(struct msix_entry) * num;
+
+	info = kzalloc(sizeof(struct msi_info) + entries_size, GFP_KERNEL);
+	if (!info) {
+		msi_debug("kzalloc failed for %s\n", pci_name(pdev));
+		return -ENOMEM;
+	}
+
+	info->type = type;
+	info->num = num;
+	info->entries = (struct msix_entry *)(info + 1);
+
+	BUG_ON(pdev->msi_info); /* don't leak info structs */
+	pdev->msi_info = info;
+
+	return 0;
+}
+
+static void free_msi_info(struct pci_dev *pdev)
+{
+	kfree(pdev->msi_info);
+	pdev->msi_info = NULL;
+}
+
+
+/* Generic helpers */
+
+static int generic_msi_enable(struct pci_dev *pdev, int nvec,
+				struct msix_entry *entries, int type)
+{
+	struct msi_ops *ops;
+	int i, rc;
+
+	if (no_msi || !pdev || !entries || !nvec || pdev->msi_info) {
+		msi_debug("precondition failed for %p\n", pdev);
+		return -EINVAL;
+	}
+
+	ops = arch_get_msi_ops(pdev);
+	if (!ops) {
+		msi_debug("no ops for %s\n", pci_name(pdev));
+		return -EINVAL;
+	}
+
+	for (i = 0; i < nvec; i++)
+		entries[i].vector = NO_IRQ;
+
+	rc = ops->check(pdev, nvec, entries, type);
+	if (rc) {
+		msi_debug("check failed (%d) for %s\n", rc, pci_name(pdev));
+		return rc;
+	}
+
+	rc = alloc_msi_info(pdev, nvec, entries, type);
+	if (rc)
+		return rc;
+
+	rc = ops->alloc(pdev, nvec, entries, type);
+	if (rc) {
+		msi_debug("alloc failed (%d) for %s\n", rc, pci_name(pdev));
+		goto out_free_info;
+	}
+
+	if (ops->enable) {
+		rc = ops->enable(pdev, nvec, entries, type);
+		if (rc) {
+			msi_debug("enable failed (%d) for %s\n", rc,
+				pci_name(pdev));
+			goto out_ops_free;
+		}
+	}
+
+	/* Copy the updated entries into the msi_info */
+	memcpy(pdev->msi_info->entries, entries,
+			sizeof(struct msix_entry) * nvec);
+	pci_intx(pdev, 0);
+
+	return 0;
+
+ out_ops_free:
+	ops->free(pdev, nvec, entries, type);
+ out_free_info:
+	free_msi_info(pdev);
+
+	return rc;
+}
+
+static int generic_msi_disable(struct pci_dev *pdev, int type)
+{
+	struct msi_ops *ops;
+	struct msi_info *info;
+
+	if (no_msi || !pdev) {
+		msi_debug("precondition failed for %p\n", pdev);
+		return -1;
+	}
+
+	info = pdev->msi_info;
+	if (!info) {
+		msi_debug("No info for %s\n", pci_name(pdev));
+		return -1;
+	}
+
+	ops = arch_get_msi_ops(pdev);
+	if (!ops) {
+		msi_debug("no ops for %s\n", pci_name(pdev));
+		return -1;
+	}
+
+	if (ops->disable)
+		ops->disable(pdev, info->num, info->entries, type);
+
+	ops->free(pdev, info->num, info->entries, type);
+
+	pci_intx(pdev, 1);
+
+	return 0;
+}
+
+
+/* MSI */
+
+int pci_enable_msi(struct pci_dev *pdev)
+{
+	struct msix_entry entry;
+	int rc;
+
+	entry.entry = 0;
+
+	rc = generic_msi_enable(pdev, 1, &entry, PCI_CAP_ID_MSI);
+	if (rc)
+		return rc;
+
+	pdev->msi_info->saved_irq = pdev->irq;
+	pdev->irq = entry.vector;
+	pdev->msi_enabled = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_enable_msi);
+
+void pci_disable_msi(struct pci_dev *pdev)
+{
+	if (generic_msi_disable(pdev, PCI_CAP_ID_MSI) != 0)
+		return;
+
+	pdev->irq = pdev->msi_info->saved_irq;
+	free_msi_info(pdev);
+	pdev->msi_enabled = 0;
+}
+EXPORT_SYMBOL_GPL(pci_disable_msi);
+
+
+/* MSI-X */
+
+int pci_enable_msix(struct pci_dev *pdev, struct msix_entry *entries, int nvec)
+{
+	int rc;
+
+	rc = generic_msi_enable(pdev, nvec, entries, PCI_CAP_ID_MSIX);
+	if (rc)
+		return rc;
+
+	pdev->msix_enabled = 1;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_enable_msix);
+
+void pci_disable_msix(struct pci_dev *pdev)
+{
+	if (generic_msi_disable(pdev, PCI_CAP_ID_MSIX) != 0)
+		return;
+
+	free_msi_info(pdev);
+	pdev->msix_enabled = 0;
+}
+EXPORT_SYMBOL_GPL(pci_disable_msix);
+
+
+/* Stubs for now */
+
+void disable_msi_mode(struct pci_dev *dev, int pos, int type)
+{
+	return;
+}
+
+void msi_remove_pci_irq_vectors(struct pci_dev* dev)
+{
+	return;
+}
Index: msi/include/linux/msi-ops.h
===================================================================
--- /dev/null
+++ msi/include/linux/msi-ops.h
@@ -0,0 +1,168 @@
+/*
+ * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef LINUX_MSI_OPS_H
+#define LINUX_MSI_OPS_H
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+
+#include <linux/pci.h>
+#include <linux/msi.h>
+
+/*
+ * MSI and MSI-X although different in some details, are also similar in
+ * many respects, and ultimately achieve the same end. Given that, this code
+ * tries as far as possible to implement both MSI and MSI-X with a minimum
+ * of code duplication. We will use "MSI" to refer to both MSI and MSI-X,
+ * except where it is important to differentiate between the two.
+ *
+ * Enabling MSI for a device can be broken down into:
+ *  1) Checking the device can support the type/number of MSIs requested.
+ *  2) Allocating irqs for the MSIs and setting up the irq_descs.
+ *  3) Writing the appropriate configuration to the device and enabling MSIs.
+ *
+ * To implement that we have the following callbacks:
+ *  1) check(pdev, num, msix_entries, type)
+ *  2) alloc(pdev, num, msix_entries, type)
+ *  3) enable(pdev, num, msix_entries, type)
+ *	a) setup_msi_msg(pdev, msix_entry, msi_msg, type)
+ *
+ * We give platforms full control over the enable step. However many
+ * platforms will simply want to program the device using standard PCI
+ * accessors. These platforms can use a generic enable callback and define
+ * a setup_msi_msg() callback which simply fills in the "magic" address and
+ * data values. Other platforms may leave setup_msi_msg() empty.
+ *
+ * Disabling MSI requires:
+ *  1) Disabling MSI on the device.
+ *  2) Freeing the irqs and any associated accounting information.
+ *
+ * Which maps directly to the two callbacks:
+ *  1) disable(pdev, num, msix_entries, type)
+ *  2) free(pdev, num, msix_entries, type)
+ */
+
+struct msi_ops
+{
+	/* check - Check that the requested MSI allocation is OK.
+	 *
+	 * @pdev:	PCI device structure.
+	 * @num:	The number of MSIs being requested.
+	 * @entries:	An array of @num msix_entry structures.
+	 * @type:	The type, MSI or MSI-X.
+	 *
+	 * This routine is responsible for checking that the given PCI device
+	 * can be allocated the requested type and number of MSIs.
+	 *
+	 * It is up to this routine to determine if the requested number of
+	 * MSIs is valid for the device in question. If the number of MSIs,
+	 * or the particular MSI entries, can not be supported for any
+	 * reason this routine must return non-zero.
+	 *
+	 * If the check is succesful this routine must return 0.
+	 */
+	int (*check) (struct pci_dev *pdev, int num,
+				struct msix_entry *entries, int type);
+
+	/* alloc - Allocate MSIs for the given device.
+	 *
+	 * @pdev:	PCI device structure.
+	 * @num:	The number of MSIs being requested.
+	 * @entries:	An array of @num msix_entry structures.
+	 * @type:	The type, MSI or MSI-X.
+	 *
+	 * This routine is responsible for allocating the number of
+	 * MSIs to the given PCI device.
+	 *
+	 * Upon completion there must be @num MSIs assigned to this device,
+	 * the "vector" member of each struct msix_entry must be filled in
+	 * with the Linux irq number allocated to it. The corresponding
+	 * irq_descs must also be setup with an appropriate handler if
+	 * required.
+	 *
+	 * If the allocation completes succesfully this routine must return 0.
+	 */
+	int (*alloc) (struct pci_dev *pdev, int num,
+				struct msix_entry *entries, int type);
+
+	/* enable - Enable the MSIs on the given device.
+	 *
+	 * @pdev:	PCI device structure.
+	 * @num:	The number of MSIs being requested.
+	 * @entries:	An array of @num msix_entry structures.
+	 * @type:	The type, MSI or MSI-X.
+	 *
+	 * This routine enables the MSIs on the given PCI device.
+	 *
+	 * If the enable completes succesfully this routine must return 0.
+	 *
+	 * This callback is optional.
+	 */
+	int (*enable) (struct pci_dev *pdev, int num,
+				struct msix_entry *entries, int type);
+
+	/* setup_msi_msg - Setup an MSI message for the given device.
+	 *
+	 * @pdev:	PCI device structure.
+	 * @entry:	The MSI entry to create a msi_msg for.
+	 * @msg:	Written with the magic address and data.
+	 * @type:	The type, MSI or MSI-X.
+	 *
+	 * Returns the "magic address and data" used to trigger the msi.
+	 * If the setup is succesful this routine must return 0.
+	 *
+	 * This callback is optional.
+	 */
+	int (*setup_msi_msg) (struct pci_dev *pdev, struct msix_entry *entry,
+				struct msi_msg *msg, int type);
+
+	/* disable - disable the MSI for the given device.
+	 *
+	 * @pdev:	PCI device structure.
+	 * @num:	The number of MSIs to disable.
+	 * @entries:	An array of @num msix_entry structures.
+	 * @type:	The type, MSI or MSI-X.
+	 *
+         * This routine should perform the inverse of enable.
+	 */
+	void (*disable) (struct pci_dev *pdev, int num,
+				struct msix_entry *entries, int type);
+
+	/* free - free the MSIs assigned to the device.
+	 *
+	 * @pdev:	PCI device structure.
+	 * @num:	The number of MSIs.
+	 * @entries:	An array of @num msix_entry structures.
+	 * @type:	The type, MSI or MSI-X.
+	 *
+	 * Free all MSIs and associated resources for the device. If any
+	 * MSIs have been enabled they will have been disabled already by
+	 * the generic code.
+	 */
+	void (*free) (struct pci_dev *pdev, int num,
+				struct msix_entry *entries, int type);
+};
+
+
+/* Used by the MSI code to track MSI info for a pci_dev */
+struct msi_info {
+	int type;
+	unsigned int saved_irq;
+	unsigned int num;
+	struct msix_entry *entries;
+	void __iomem *msix_base;
+};
+
+#define msi_debug(fmt, args...)	\
+	pr_debug("MSI:%s:%d: " fmt, __FUNCTION__, __LINE__, ## args)
+
+#endif /* __KERNEL__ */
+#endif /* __ASSEMBLY__ */
+#endif /* LINUX_MSI_OPS_H */
Index: msi/include/linux/pci.h
===================================================================
--- msi.orig/include/linux/pci.h
+++ msi/include/linux/pci.h
@@ -107,6 +107,8 @@ struct pci_cap_saved_state {
 	u32 data[0];
 };
 
+struct msi_info;
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -174,6 +176,9 @@ struct pci_dev {
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
+#if defined(CONFIG_PCI_MSI_NEW)
+	struct	msi_info *msi_info;
+#endif
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
