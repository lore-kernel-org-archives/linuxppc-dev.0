Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D6E21A0246
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 16:36:15 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 5 Jun 2014 16:36:14 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A81F43578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 16:36:12 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s556EIH046530662
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 16:14:18 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s556aBAg018426
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 16:36:11 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 2/3] powerpc/eeh: EEH support for VFIO PCI device
Date: Thu,  5 Jun 2014 16:36:08 +1000
Message-Id: <1401950169-30206-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1401950169-30206-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1401950169-30206-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch exports functions to be used by new VFIO ioctl command,
which will be introduced in subsequent patch, to support EEH
functinality for VFIO PCI devices.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  14 +++
 arch/powerpc/kernel/eeh.c      | 268 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 282 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 653d981..5b4cc4e 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -166,6 +166,8 @@ enum {
 #define EEH_OPT_ENABLE		1	/* EEH enable	*/
 #define EEH_OPT_THAW_MMIO	2	/* MMIO enable	*/
 #define EEH_OPT_THAW_DMA	3	/* DMA enable	*/
+#define EEH_OPT_GET_PE_ADDR	0	/* Get PE addr	*/
+#define EEH_OPT_GET_PE_MODE	1	/* Get PE mode	*/
 #define EEH_STATE_UNAVAILABLE	(1 << 0)	/* State unavailable	*/
 #define EEH_STATE_NOT_SUPPORT	(1 << 1)	/* EEH not supported	*/
 #define EEH_STATE_RESET_ACTIVE	(1 << 2)	/* Active reset		*/
@@ -173,6 +175,11 @@ enum {
 #define EEH_STATE_DMA_ACTIVE	(1 << 4)	/* Active DMA		*/
 #define EEH_STATE_MMIO_ENABLED	(1 << 5)	/* MMIO enabled		*/
 #define EEH_STATE_DMA_ENABLED	(1 << 6)	/* DMA enabled		*/
+#define EEH_PE_STATE_NORMAL		0	/* Normal state		*/
+#define EEH_PE_STATE_RESET		1	/* PE reset asserted	*/
+#define EEH_PE_STATE_STOPPED_IO_DMA	2	/* Frozen PE		*/
+#define EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA, Enabled IO */
+#define EEH_PE_STATE_UNAVAIL		5	/* Unavailable		*/
 #define EEH_RESET_DEACTIVATE	0	/* Deactivate the PE reset	*/
 #define EEH_RESET_HOT		1	/* Hot reset			*/
 #define EEH_RESET_FUNDAMENTAL	3	/* Fundamental reset		*/
@@ -280,6 +287,13 @@ void eeh_add_device_late(struct pci_dev *);
 void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_add_sysfs_files(struct pci_bus *);
 void eeh_remove_device(struct pci_dev *);
+int eeh_dev_open(struct pci_dev *pdev);
+void eeh_dev_release(struct pci_dev *pdev);
+struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
+int eeh_pe_set_option(struct eeh_pe *pe, int option);
+int eeh_pe_get_state(struct eeh_pe *pe);
+int eeh_pe_reset(struct eeh_pe *pe, int option);
+int eeh_pe_configure(struct eeh_pe *pe);
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 3bc8b12..fc90df0 100644
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
@@ -1106,6 +1110,270 @@ void eeh_remove_device(struct pci_dev *dev)
 	edev->mode &= ~EEH_DEV_SYSFS;
 }
 
+/**
+ * eeh_dev_open - Increase count of pass through devices for PE
+ * @pdev: PCI device
+ *
+ * Increase count of passed through devices for the indicated
+ * PE. In the result, the EEH errors detected on the PE won't be
+ * reported. The PE owner will be responsible for detection
+ * and recovery.
+ */
+int eeh_dev_open(struct pci_dev *pdev)
+{
+	struct eeh_dev *edev;
+
+	mutex_lock(&eeh_dev_mutex);
+
+	/* No PCI device ? */
+	if (!pdev)
+		goto out;
+
+	/* No EEH device or PE ? */
+	edev = pci_dev_to_eeh_dev(pdev);
+	if (!edev || !edev->pe)
+		goto out;
+
+	/* Increase PE's pass through count */
+	atomic_inc(&edev->pe->pass_dev_cnt);
+	mutex_unlock(&eeh_dev_mutex);
+
+	return 0;
+out:
+	mutex_unlock(&eeh_dev_mutex);
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(eeh_dev_open);
+
+/**
+ * eeh_dev_release - Decrease count of pass through devices for PE
+ * @pdev: PCI device
+ *
+ * Decrease count of pass through devices for the indicated PE. If
+ * there is no passed through device in PE, the EEH errors detected
+ * on the PE will be reported and handled as usual.
+ */
+void eeh_dev_release(struct pci_dev *pdev)
+{
+	struct eeh_dev *edev;
+
+	mutex_lock(&eeh_dev_mutex);
+
+	/* No PCI device ? */
+	if (!pdev)
+		goto out;
+
+	/* No EEH device ? */
+	edev = pci_dev_to_eeh_dev(pdev);
+	if (!edev || !edev->pe || !eeh_pe_passed(edev->pe))
+		goto out;
+
+	/* Decrease PE's pass through count */
+	atomic_dec(&edev->pe->pass_dev_cnt);
+	WARN_ON(atomic_read(&edev->pe->pass_dev_cnt) < 0);
+out:
+	mutex_unlock(&eeh_dev_mutex);
+}
+EXPORT_SYMBOL(eeh_dev_release);
+
+/**
+ * eeh_iommu_group_to_pe - Convert IOMMU group to EEH PE
+ * @group: IOMMU group
+ *
+ * The routine is called to convert IOMMU group to EEH PE.
+ */
+struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group)
+{
+	struct iommu_table *tbl;
+	struct pci_dev *pdev = NULL;
+	struct eeh_dev *edev;
+	bool found = false;
+
+	/* No IOMMU group ? */
+	if (!group)
+		return NULL;
+
+	/* No PCI device ? */
+	for_each_pci_dev(pdev) {
+		tbl = get_iommu_table_base(&pdev->dev);
+		if (tbl && tbl->it_group == group) {
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
+	bool rst_active, dma_en, mmio_en;
+
+	/* Existing PE ? */
+	if (!pe)
+		return -ENODEV;
+
+	if (!eeh_ops || !eeh_ops->get_state)
+		return -ENOENT;
+
+	result = eeh_ops->get_state(pe, NULL);
+	rst_active = !!(result & EEH_STATE_RESET_ACTIVE);
+	dma_en = !!(result & EEH_STATE_DMA_ENABLED);
+	mmio_en = !!(result & EEH_STATE_MMIO_ENABLED);
+
+	if (rst_active)
+		ret = EEH_PE_STATE_RESET;
+	else if (dma_en && mmio_en)
+		ret = EEH_PE_STATE_NORMAL;
+	else if (!dma_en && !mmio_en)
+		ret = EEH_PE_STATE_STOPPED_IO_DMA;
+	else if (!dma_en && mmio_en)
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
