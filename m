Return-Path: <michael@ozlabs.org>
To: <linux-kernel@vger.kernel.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 29 Sep 2006 07:53:37 +1000
Subject: [RFC/PATCH 3/7] Powerpc MSI ops layer
In-Reply-To: <1159480412.269240.988552559176.qpush@concordia>
Message-Id: <20060928215339.D911C67BFA@ozlabs.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powerpc MSI ops layer.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/msi.c        |  347 +++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/machdep.h    |    6 
 include/asm-powerpc/msi.h        |  175 +++++++++++++++++++
 include/asm-powerpc/pci-bridge.h |    4 
 4 files changed, 532 insertions(+)

Index: to-merge/arch/powerpc/kernel/msi.c
===================================================================
--- /dev/null
+++ to-merge/arch/powerpc/kernel/msi.c
@@ -0,0 +1,347 @@
+/*
+ * Copyright 2006 (C), Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <asm/msi.h>
+#include <asm/machdep.h>
+
+static struct ppc_msi_ops *get_msi_ops(struct pci_dev *pdev)
+{
+	if (ppc_md.get_msi_ops)
+		return ppc_md.get_msi_ops(pdev);
+	return NULL;
+}
+
+/* Activated by pci=nomsi on the command line. */
+static int no_msi;
+
+void pci_no_msi(void)
+{
+	no_msi = 1;
+}
+
+
+/* msi_info helpers */
+
+static struct pci_dn *get_pdn(struct pci_dev *pdev)
+{
+	struct device_node *dn;
+	struct pci_dn *pdn;
+
+	dn = pci_device_to_OF_node(pdev);
+	if (!dn) {
+		pr_debug("get_pdn: no dn found for %s\n", pci_name(pdev));
+		return NULL;
+	}
+
+	pdn = PCI_DN(dn);
+	if (!pdn) {
+		pr_debug("get_pdn: no pci_dn found for %s\n", pci_name(pdev));
+		return NULL;
+	}
+
+	return pdn;
+}
+
+static int alloc_msi_info(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	struct msi_info *info;
+	unsigned int entries_size;
+	struct pci_dn *pdn;
+
+	entries_size = sizeof(struct msix_entry) * num;
+
+	info = kzalloc(sizeof(struct msi_info) + entries_size, GFP_KERNEL);
+	if (!info) {
+		pr_debug("alloc_msi_info: kzalloc failed for %s\n",
+				pci_name(pdev));
+		return -ENOMEM;
+	}
+
+	info->type = type;
+	info->num = num;
+	memcpy(info->entries, entries, entries_size);
+
+	pdn = get_pdn(pdev);
+	if (!pdn || pdn->msi_info)	/* don't leak info structs */
+		BUG();
+
+	pdn->msi_info = info;
+
+	return 0;
+}
+
+static struct msi_info *get_msi_info(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn;
+
+	pdn = get_pdn(pdev);
+	if (!pdn)
+		return NULL;
+
+	return pdn->msi_info;
+}
+
+static void free_msi_info(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn;
+
+	pdn = get_pdn(pdev);
+	if (!pdn) {
+		pr_debug("free_msi_info: No pdn for %s\n", pci_name(pdev));
+		return;
+	}
+
+	kfree(pdn->msi_info);
+	pdn->msi_info = NULL;
+}
+
+
+/* Generic helpers */
+
+static int generic_msi_enable(struct pci_dev *pdev, int nvec,
+				struct msix_entry *entries, int type)
+{
+	struct ppc_msi_ops *ops;
+	int i, rc;
+
+	if (no_msi || !pdev || !entries || !nvec || !get_pdn(pdev)
+			|| get_msi_info(pdev))
+		return -EINVAL;
+
+	ops = get_msi_ops(pdev);
+	if (!ops)
+		return -EINVAL;
+
+	for (i = 0; i < nvec; i++)
+		entries[i].vector = NO_IRQ;
+
+	rc = ops->check(pdev, nvec, entries, type);
+	if (rc) {
+		pr_debug("generic_msi_enable: check failed (%d) for %s\n",
+			rc, pci_name(pdev));
+		return rc;
+	}
+
+	rc = ops->alloc(pdev, nvec, entries, type);
+	if (rc) {
+		pr_debug("generic_msi_enable: alloc failed (%d) for %s\n",
+			rc, pci_name(pdev));
+		return rc;
+	}
+
+	if (ops->enable) {
+		rc = ops->enable(pdev, nvec, entries, type);
+		if (rc) {
+			pr_debug("generic_msi_enable: enable failed (%d) "
+				"for %s\n", rc, pci_name(pdev));
+			goto out_free;
+		}
+	}
+
+	rc = alloc_msi_info(pdev, nvec, entries, type);
+	if (rc)
+		goto out_free;
+
+	return 0;
+
+ out_free:
+	ops->free(pdev, nvec, entries, type);
+
+	return rc;
+}
+
+static int generic_msi_disable(struct pci_dev *pdev, int type)
+{
+	struct ppc_msi_ops *ops;
+	struct msi_info *info;
+
+	if (no_msi || !pdev || !get_pdn(pdev))
+		return -1;
+
+	info = get_msi_info(pdev);
+	if (!info) {
+		pr_debug("generic_msi_disable: No info for %s\n",
+			pci_name(pdev));
+		return -1;
+	}
+
+	ops = get_msi_ops(pdev);
+	if (!ops)
+		return -1;
+
+	if (ops->disable)
+		ops->disable(pdev, info->num, info->entries, type);
+
+	ops->free(pdev, info->num, info->entries, type);
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
+	get_msi_info(pdev)->saved_irq = pdev->irq;
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
+	pdev->irq = get_msi_info(pdev)->saved_irq;
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
+void pci_scan_msi_device(struct pci_dev *dev)
+{
+	return;
+}
+
+void msi_remove_pci_irq_vectors(struct pci_dev* dev)
+{
+	return;
+}
+
+
+/* Bare metal enable/disable */
+
+int msi_raw_enable(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	struct ppc_msi_ops *ops;
+	struct msi_msg msg;
+	int pos;
+	u16 control;
+
+	pos = pci_find_capability(pdev, type);
+	if (!pos)
+		return -1;
+
+	ops = get_msi_ops(pdev);
+	BUG_ON(!ops);
+
+	pci_read_config_word(pdev, pos + PCI_MSI_FLAGS, &control);
+
+	switch (type) {
+	case PCI_CAP_ID_MSI:
+		BUG_ON(!ops->setup_msi_msg);
+
+		ops->setup_msi_msg(pdev, &entries[0], &msg, type);
+
+		pci_write_config_dword(pdev, pos + PCI_MSI_ADDRESS_LO,
+			msg.address_lo);
+
+		if (control & PCI_MSI_FLAGS_64BIT) {
+			pci_write_config_dword(pdev, pos + PCI_MSI_ADDRESS_HI,
+						msg.address_hi);
+			pci_write_config_dword(pdev, pos + PCI_MSI_DATA_64,
+						msg.data);
+		} else {
+			pci_write_config_dword(pdev, pos + PCI_MSI_DATA_32,
+						msg.data);
+		}
+
+		control |= PCI_MSI_FLAGS_ENABLE;
+		break;
+	case PCI_CAP_ID_MSIX:
+		/* XXX implement me */
+		BUG();
+		break;
+	default:
+		BUG();
+	}
+
+	pci_write_config_word(pdev, pos + PCI_MSI_FLAGS, control);
+
+	return 0;
+}
+
+void msi_raw_disable(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	int pos;
+	u16 control;
+
+	pos = pci_find_capability(pdev, type);
+	BUG_ON(!pos);
+
+	pci_read_config_word(pdev, pos + PCI_MSI_FLAGS, &control);
+
+	switch (type) {
+	case PCI_CAP_ID_MSI:
+		control &= ~PCI_MSI_FLAGS_ENABLE;
+		break;
+	case PCI_CAP_ID_MSIX:
+		control &= ~PCI_MSIX_FLAGS_ENABLE;
+		break;
+	default:
+		BUG();
+	}
+
+	pci_write_config_word(pdev, pos + PCI_MSI_FLAGS, control);
+
+	return;
+}
Index: to-merge/include/asm-powerpc/machdep.h
===================================================================
--- to-merge.orig/include/asm-powerpc/machdep.h
+++ to-merge/include/asm-powerpc/machdep.h
@@ -29,6 +29,9 @@ struct file;
 #ifdef CONFIG_KEXEC
 struct kimage;
 #endif
+#ifdef CONFIG_PCI_MSI
+struct ppc_msi_ops;
+#endif
 
 #ifdef CONFIG_SMP
 struct smp_ops_t {
@@ -106,6 +109,9 @@ struct machdep_calls {
 	/* Called after scanning the bus, before allocating resources */
 	void		(*pcibios_fixup)(void);
 	int		(*pci_probe_mode)(struct pci_bus *);
+#ifdef CONFIG_PCI_MSI
+	struct ppc_msi_ops*	(*get_msi_ops)(struct pci_dev *pdev);
+#endif
 
 	void		(*restart)(char *cmd);
 	void		(*power_off)(void);
Index: to-merge/include/asm-powerpc/msi.h
===================================================================
--- /dev/null
+++ to-merge/include/asm-powerpc/msi.h
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2006 Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_POWERPC_MSI_H
+#define _ASM_POWERPC_MSI_H
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+
+#include <linux/pci.h>
+
+struct msi_msg {
+	u32	address_lo;	/* low 32 bits of msi message address */
+	u32	address_hi;	/* high 32 bits of msi message address */
+	u32	data;		/* 32 bits of msi message data */
+};
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
+struct ppc_msi_ops
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
+	void *priv;
+};
+
+extern int msi_raw_enable(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type);
+extern int msi_raw_disable(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type);
+
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_MSI_H */
Index: to-merge/include/asm-powerpc/pci-bridge.h
===================================================================
--- to-merge.orig/include/asm-powerpc/pci-bridge.h
+++ to-merge/include/asm-powerpc/pci-bridge.h
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/list.h>
+#include <asm/msi.h>
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -81,6 +82,9 @@ struct pci_dn {
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 	struct	device_node *node;	/* back-pointer to the device_node */
 	u32	config_space[16];	/* saved PCI config space */
+#ifdef CONFIG_PCI_MSI
+	struct	msi_info *msi_info;
+#endif
 };
 
 /* Get the pointer to a device_node's pci_dn */
