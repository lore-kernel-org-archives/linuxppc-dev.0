Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4305A1A0591
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:41:02 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 27 May 2014 18:40:59 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E6B42357805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:40:54 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4R8edi866060300
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:40:39 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4R8erqN017547
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:40:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v7 2/3] powerpc/eeh: EEH support for VFIO PCI device
Date: Tue, 27 May 2014 18:40:51 +1000
Message-Id: <1401180052-6060-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch exports functions to be used by new ioctl commands, which
will be introduced in subsequent patch, to support EEH functinality
for VFIO PCI device.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  15 +++
 arch/powerpc/kernel/eeh.c      | 286 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 301 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 34a2d83..ffc95e7 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -26,6 +26,7 @@
 #include <linux/string.h>
 #include <linux/time.h>
 
+struct iommu_table;
 struct pci_dev;
 struct pci_bus;
 struct device_node;
@@ -191,6 +192,8 @@ enum {
 #define EEH_OPT_ENABLE		1	/* EEH enable	*/
 #define EEH_OPT_THAW_MMIO	2	/* MMIO enable	*/
 #define EEH_OPT_THAW_DMA	3	/* DMA enable	*/
+#define EEH_OPT_GET_PE_ADDR	0	/* Get PE addr	*/
+#define EEH_OPT_GET_PE_MODE	1	/* Get PE mode	*/
 #define EEH_STATE_UNAVAILABLE	(1 << 0)	/* State unavailable	*/
 #define EEH_STATE_NOT_SUPPORT	(1 << 1)	/* EEH not supported	*/
 #define EEH_STATE_RESET_ACTIVE	(1 << 2)	/* Active reset		*/
@@ -198,6 +201,11 @@ enum {
 #define EEH_STATE_DMA_ACTIVE	(1 << 4)	/* Active DMA		*/
 #define EEH_STATE_MMIO_ENABLED	(1 << 5)	/* MMIO enabled		*/
 #define EEH_STATE_DMA_ENABLED	(1 << 6)	/* DMA enabled		*/
+#define EEH_PE_STATE_NORMAL		0	/* Normal state		*/
+#define EEH_PE_STATE_RESET		1		/* PE reset	*/
+#define EEH_PE_STATE_STOPPED_IO_DMA	2		/* Stopped	*/
+#define EEH_PE_STATE_STOPPED_DMA	4		/* Stopped DMA	*/
+#define EEH_PE_STATE_UNAVAIL		5		/* Unavailable	*/
 #define EEH_RESET_DEACTIVATE	0	/* Deactivate the PE reset	*/
 #define EEH_RESET_HOT		1	/* Hot reset			*/
 #define EEH_RESET_FUNDAMENTAL	3	/* Fundamental reset		*/
@@ -305,6 +313,13 @@ void eeh_add_device_late(struct pci_dev *);
 void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_add_sysfs_files(struct pci_bus *);
 void eeh_remove_device(struct pci_dev *);
+int eeh_dev_open(struct pci_dev *pdev);
+void eeh_dev_release(struct pci_dev *pdev);
+struct eeh_pe *eeh_iommu_table_to_pe(struct iommu_table *tbl);
+int eeh_pe_set_option(struct eeh_pe *pe, int option);
+int eeh_pe_get_state(struct eeh_pe *pe);
+int eeh_pe_reset(struct eeh_pe *pe, int option);
+int eeh_pe_configure(struct eeh_pe *pe);
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 3bc8b12..30693c1 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -40,6 +40,7 @@
 #include <asm/eeh.h>
 #include <asm/eeh_event.h>
 #include <asm/io.h>
+#include <asm/iommu.h>
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 #include <asm/rtas.h>
@@ -108,6 +109,9 @@ struct eeh_ops *eeh_ops = NULL;
 /* Lock to avoid races due to multiple reports of an error */
 DEFINE_RAW_SPINLOCK(confirm_error_lock);
 
+/* Lock to protect passed flags */
+static DEFINE_MUTEX(eeh_dev_mutex);
+
 /* Buffer for reporting pci register dumps. Its here in BSS, and
  * not dynamically alloced, so that it ends up in RMO where RTAS
  * can access it.
@@ -1106,6 +1110,288 @@ void eeh_remove_device(struct pci_dev *dev)
 	edev->mode &= ~EEH_DEV_SYSFS;
 }
 
+/**
+ * eeh_dev_open - Mark EEH device and PE as passed through
+ * @pdev: PCI device
+ *
+ * Mark the indicated EEH device and PE as passed through.
+ * In the result, the EEH errors detected on the PE won't be
+ * reported. The owner of the device will be responsible for
+ * detection and recovery.
+ */
+int eeh_dev_open(struct pci_dev *pdev)
+{
+	struct eeh_dev *edev;
+
+	mutex_lock(&eeh_dev_mutex);
+
+	/* No PCI device ? */
+	if (!pdev) {
+		mutex_unlock(&eeh_dev_mutex);
+		return -ENODEV;
+	}
+
+	/* No EEH device ? */
+	edev = pci_dev_to_eeh_dev(pdev);
+	if (!edev || !edev->pe) {
+		mutex_unlock(&eeh_dev_mutex);
+		return -ENODEV;
+	}
+
+	eeh_dev_set_passed(edev, true);
+	eeh_pe_set_passed(edev->pe, true);
+	mutex_unlock(&eeh_dev_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(eeh_dev_open);
+
+/**
+ * eeh_dev_release - Reclaim the ownership of EEH device
+ * @pdev: PCI device
+ *
+ * Reclaim ownership of EEH device, potentially the corresponding
+ * PE. In the result, the EEH errors detected on the PE will be
+ * reported and handled as usual.
+ */
+void eeh_dev_release(struct pci_dev *pdev)
+{
+	bool release_pe = true;
+	struct eeh_pe *pe = NULL;
+	struct eeh_dev *tmp, *edev;
+
+	mutex_lock(&eeh_dev_mutex);
+
+	/* No PCI device ? */
+	if (!pdev) {
+		mutex_unlock(&eeh_dev_mutex);
+		return;
+	}
+
+	/* No EEH device ? */
+	edev = pci_dev_to_eeh_dev(pdev);
+	if (!edev || !eeh_dev_passed(edev) ||
+	    !edev->pe || !eeh_pe_passed(pe)) {
+		mutex_unlock(&eeh_dev_mutex);
+		return;
+	}
+
+	/* Release device */
+	pe = edev->pe;
+	eeh_dev_set_passed(edev, false);
+
+	/* Release PE */
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		if (eeh_dev_passed(edev)) {
+			release_pe = false;
+			break;
+		}
+	}
+
+	if (release_pe)
+		eeh_pe_set_passed(pe, false);
+
+	mutex_unlock(&eeh_dev_mutex);
+}
+EXPORT_SYMBOL(eeh_dev_release);
+
+/**
+ * eeh_iommu_table_to_pe - Convert IOMMU table to EEH PE
+ * @tbl: IOMMU table
+ *
+ * The routine is called to convert IOMMU table to EEH PE.
+ */
+struct eeh_pe *eeh_iommu_table_to_pe(struct iommu_table *tbl)
+{
+	struct pci_dev *pdev = NULL;
+	struct eeh_dev *edev;
+	bool found = false;
+
+	/* No IOMMU table ? */
+	if (!tbl)
+		return NULL;
+
+	/* No PCI device ? */
+	for_each_pci_dev(pdev) {
+		if (get_iommu_table_base(&pdev->dev) == tbl) {
+			found = true;
+			break;
+		}
+	}
+	if (!found)
+		return NULL;
+
+	/* No EEH device or PE ? */
+	edev = pci_dev_to_eeh_dev(pdev);
+	if (!edev || !edev->pe)
+		return NULL;
+
+	return edev->pe;
+}
+
+/**
+ * eeh_pe_set_option - Set options for the indicated PE
+ * @pe: EEH PE
+ * @option: requested option
+ *
+ * The routine is called to enable or disable EEH functionality
+ * on the indicated PE, to enable IO or DMA for the frozen PE.
+ */
+int eeh_pe_set_option(struct eeh_pe *pe, int option)
+{
+	int ret = 0;
+
+	/* Invalid PE ? */
+	if (!pe)
+		return -ENODEV;
+
+	/*
+	 * EEH functionality could possibly be disabled, just
+	 * return error for the case. And the EEH functinality
+	 * isn't expected to be disabled on one specific PE.
+	 */
+	switch (option) {
+	case EEH_OPT_ENABLE:
+		if (eeh_enabled())
+			break;
+		ret = -EIO;
+		break;
+	case EEH_OPT_DISABLE:
+		break;
+	case EEH_OPT_THAW_MMIO:
+	case EEH_OPT_THAW_DMA:
+		if (!eeh_ops || !eeh_ops->set_option) {
+			ret = -ENOENT;
+			break;
+		}
+
+		ret = eeh_ops->set_option(pe, option);
+		break;
+	default:
+		pr_debug("%s: Option %d out of range (%d, %d)\n",
+			__func__, option, EEH_OPT_DISABLE, EEH_OPT_THAW_DMA);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_pe_set_option);
+
+/**
+ * eeh_pe_get_state - Retrieve PE's state
+ * @pe: EEH PE
+ *
+ * Retrieve the PE's state, which includes 3 aspects: enabled
+ * DMA, enabled IO and asserted reset.
+ */
+int eeh_pe_get_state(struct eeh_pe *pe)
+{
+	int result, ret = 0;
+
+	/* Existing PE ? */
+	if (!pe)
+		return -ENODEV;
+
+	if (!eeh_ops || !eeh_ops->get_state)
+		return -ENOENT;
+
+	result = eeh_ops->get_state(pe, NULL);
+	if (!(result & EEH_STATE_RESET_ACTIVE) &&
+	     (result & EEH_STATE_DMA_ENABLED) &&
+	     (result & EEH_STATE_MMIO_ENABLED))
+		ret = EEH_PE_STATE_NORMAL;
+	else if (result & EEH_STATE_RESET_ACTIVE)
+		ret = EEH_PE_STATE_RESET;
+	else if (!(result & EEH_STATE_RESET_ACTIVE) &&
+		 !(result & EEH_STATE_DMA_ENABLED) &&
+		 !(result & EEH_STATE_MMIO_ENABLED))
+		ret = EEH_PE_STATE_STOPPED_IO_DMA;
+	else if (!(result & EEH_STATE_RESET_ACTIVE) &&
+		 (result & EEH_STATE_DMA_ENABLED) &&
+		 !(result & EEH_STATE_MMIO_ENABLED))
+		ret = EEH_PE_STATE_STOPPED_DMA;
+	else
+		ret = EEH_PE_STATE_UNAVAIL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_pe_get_state);
+
+/**
+ * eeh_pe_reset - Issue PE reset according to specified type
+ * @pe: EEH PE
+ * @option: reset type
+ *
+ * The routine is called to reset the specified PE with the
+ * indicated type, either fundamental reset or hot reset.
+ * PE reset is the most important part for error recovery.
+ */
+int eeh_pe_reset(struct eeh_pe *pe, int option)
+{
+	int ret = 0;
+
+	/* Invalid PE ? */
+	if (!pe)
+		return -ENODEV;
+
+	if (!eeh_ops || !eeh_ops->set_option || !eeh_ops->reset)
+		return -ENOENT;
+
+	switch (option) {
+	case EEH_RESET_DEACTIVATE:
+		ret = eeh_ops->reset(pe, option);
+		if (ret)
+			break;
+
+		/*
+		 * The PE is still in frozen state and we need to clear
+		 * that. It's good to clear frozen state after deassert
+		 * to avoid messy IO access during reset, which might
+		 * cause recursive frozen PE.
+		 */
+		ret = eeh_ops->set_option(pe, EEH_OPT_THAW_MMIO);
+		if (!ret)
+			ret = eeh_ops->set_option(pe, EEH_OPT_THAW_DMA);
+		if (!ret)
+			eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+		break;
+	case EEH_RESET_HOT:
+	case EEH_RESET_FUNDAMENTAL:
+		ret = eeh_ops->reset(pe, option);
+		break;
+	default:
+		pr_debug("%s: Unsupported option %d\n",
+			__func__, option);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_pe_reset);
+
+/**
+ * eeh_pe_configure - Configure PCI bridges after PE reset
+ * @pe: EEH PE
+ *
+ * The routine is called to restore the PCI config space for
+ * those PCI devices, especially PCI bridges affected by PE
+ * reset issued previously.
+ */
+int eeh_pe_configure(struct eeh_pe *pe)
+{
+	int ret = 0;
+
+	/* Invalid PE ? */
+	if (!pe)
+		return -ENODEV;
+
+	/* Restore config space for the affected devices */
+	eeh_pe_restore_bars(pe);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_pe_configure);
+
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	if (!eeh_enabled()) {
-- 
1.8.3.2
