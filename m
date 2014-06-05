Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EF301A02AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 16:36:18 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 5 Jun 2014 16:36:16 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9A6C12CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 16:36:13 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s556KFpR7995570
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 16:20:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s556aCbH030201
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 16:36:12 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 3/3] drivers/vfio: EEH support for VFIO PCI device
Date: Thu,  5 Jun 2014 16:36:09 +1000
Message-Id: <1401950169-30206-4-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch adds new IOCTL commands for sPAPR VFIO container device
to support EEH functionality for PCI devices, which have been passed
through from host to somebody else via VFIO.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 Documentation/vfio.txt              | 87 ++++++++++++++++++++++++++++++++++--
 drivers/vfio/Makefile               |  1 +
 drivers/vfio/pci/vfio_pci.c         | 20 ++++++---
 drivers/vfio/vfio_iommu_spapr_tce.c | 17 ++++++-
 drivers/vfio/vfio_spapr_eeh.c       | 89 +++++++++++++++++++++++++++++++++++++
 include/linux/vfio.h                | 23 ++++++++++
 include/uapi/linux/vfio.h           | 35 +++++++++++++++
 7 files changed, 262 insertions(+), 10 deletions(-)
 create mode 100644 drivers/vfio/vfio_spapr_eeh.c

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index b9ca023..3fa4538 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -305,7 +305,15 @@ faster, the map/unmap handling has been implemented in real mode which provides
 an excellent performance which has limitations such as inability to do
 locked pages accounting in real time.
 
-So 3 additional ioctls have been added:
+4) According to sPAPR specification, A Partitionable Endpoint (PE) is an I/O
+subtree that can be treated as a unit for the purposes of partitioning and
+error recovery. A PE may be a single or multi-function IOA (IO Adapter), a
+function of a multi-function IOA, or multiple IOAs (possibly including switch
+and bridge structures above the multiple IOAs). PPC64 guests detect PCI errors
+and recover from them via EEH RTAS services, which works on the basis of
+additional ioctl commands.
+
+So 4 additional ioctls have been added:
 
 	VFIO_IOMMU_SPAPR_TCE_GET_INFO - returns the size and the start
 		of the DMA window on the PCI bus.
@@ -316,9 +324,12 @@ So 3 additional ioctls have been added:
 
 	VFIO_IOMMU_DISABLE - disables the container.
 
+	VFIO_EEH_PE_OP - provides an API for EEH setup, error detection and recovery.
 
 The code flow from the example above should be slightly changed:
 
+	struct vfio_eeh_pe_op pe_op = { .argsz = sizeof(pe_op) };
+
 	.....
 	/* Add the group to the container */
 	ioctl(group, VFIO_GROUP_SET_CONTAINER, &container);
@@ -342,9 +353,79 @@ The code flow from the example above should be slightly changed:
 	dma_map.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
 
 	/* Check here is .iova/.size are within DMA window from spapr_iommu_info */
-
 	ioctl(container, VFIO_IOMMU_MAP_DMA, &dma_map);
-	.....
+
+	/* Get a file descriptor for the device */
+	device = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "0000:06:0d.0");
+
+	....
+
+	/* Gratuitous device reset and go... */
+	ioctl(device, VFIO_DEVICE_RESET);
+
+	/* Make sure EEH is supported */
+	ioctl(container, VFIO_CHECK_EXTENSION, VFIO_EEH);
+
+	/* Enable the EEH functionality on the device */
+	pe_op.op = VFIO_EEH_PE_ENABLE;
+	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+
+	/* You're suggested to create additional data struct to represent
+	 * PE, and put child devices belonging to same IOMMU group to the
+	 * PE instance for later reference.
+	 */
+
+	/* Check the PE's state and make sure it's in functional state */
+	pe_op.op = VFIO_EEH_PE_GET_STATE;
+	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+
+	/* Save device state using pci_save_state().
+	 * EEH should be enabled on the specified device.
+	 */
+
+	....
+
+	/* When 0xFF's returned from reading PCI config space or IO BARs
+	 * of the PCI device. Check the PE's state to see if that has been
+	 * frozen.
+	 */
+	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+
+	/* Waiting for pending PCI transactions to be completed and don't
+	 * produce any more PCI traffic from/to the affected PE until
+	 * recovery is finished.
+	 */
+
+	/* Enable IO for the affected PE and collect logs. Usually, the
+	 * standard part of PCI config space, AER registers are dumped
+	 * as logs for further analysis.
+	 */
+	pe_op.op = VFIO_EEH_PE_UNFREEZE_IO;
+	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+
+	/*
+	 * Issue PE reset: hot or fundamental reset. Usually, hot reset
+	 * is enough. However, the firmware of some PCI adapters would
+	 * require fundamental reset.
+	 */
+	pe_op.op = VFIO_EEH_PE_RESET_HOT;
+	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+	pe_op.op = VFIO_EEH_PE_RESET_DEACTIVATE;
+	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+
+	/* Configure the PCI bridges for the affected PE */
+	pe_op.op = VFIO_EEH_PE_CONFIGURE;
+	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+
+	/* Restored state we saved at initialization time. pci_restore_state()
+	 * is good enough as an example.
+	 */
+
+	/* Hopefully, error is recovered successfully. Now, you can resume to
+	 * start PCI traffic to/from the affected PE.
+	 */
+
+	....
 
 -------------------------------------------------------------------------------
 
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index 72bfabc..50e30bc 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_VFIO) += vfio.o
 obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
 obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
+obj-$(CONFIG_EEH) += vfio_spapr_eeh.o
 obj-$(CONFIG_VFIO_PCI) += pci/
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 7ba0424..26f289d 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -156,8 +156,10 @@ static void vfio_pci_release(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
 
-	if (atomic_dec_and_test(&vdev->refcnt))
+	if (atomic_dec_and_test(&vdev->refcnt)) {
+		vfio_spapr_pci_eeh_release(vdev->pdev);
 		vfio_pci_disable(vdev);
+	}
 
 	module_put(THIS_MODULE);
 }
@@ -165,19 +167,25 @@ static void vfio_pci_release(void *device_data)
 static int vfio_pci_open(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
+	int ret;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
 	if (atomic_inc_return(&vdev->refcnt) == 1) {
-		int ret = vfio_pci_enable(vdev);
-		if (ret) {
-			module_put(THIS_MODULE);
-			return ret;
-		}
+		ret = vfio_pci_enable(vdev);
+		if (ret)
+			goto error;
+
+		ret = vfio_spapr_pci_eeh_open(vdev->pdev);
+		if (ret)
+			goto error;
 	}
 
 	return 0;
+error:
+	module_put(THIS_MODULE);
+	return ret;
 }
 
 static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index a84788b..730b4ef 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -156,7 +156,16 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 	switch (cmd) {
 	case VFIO_CHECK_EXTENSION:
-		return (arg == VFIO_SPAPR_TCE_IOMMU) ? 1 : 0;
+		switch (arg) {
+		case VFIO_SPAPR_TCE_IOMMU:
+			ret = 1;
+			break;
+		default:
+			ret = vfio_spapr_iommu_eeh_ioctl(NULL, cmd, arg);
+			break;
+		}
+
+		return (ret < 0) ? 0 : ret;
 
 	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
 		struct vfio_iommu_spapr_tce_info info;
@@ -283,6 +292,12 @@ static long tce_iommu_ioctl(void *iommu_data,
 		tce_iommu_disable(container);
 		mutex_unlock(&container->lock);
 		return 0;
+	case VFIO_EEH_PE_OP:
+		if (!container->tbl || !container->tbl->it_group)
+			return -ENODEV;
+
+		return vfio_spapr_iommu_eeh_ioctl(container->tbl->it_group,
+						  cmd, arg);
 	}
 
 	return -ENOTTY;
diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
new file mode 100644
index 0000000..691f8d8
--- /dev/null
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -0,0 +1,89 @@
+/*
+ * EEH functionality support for VFIO devices. The feature is only
+ * available on sPAPR compatible platforms.
+ *
+ * Copyright Gavin Shan, IBM Corporation 2014.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/iommu.h>
+#include <linux/pci.h>
+#include <linux/uaccess.h>
+#include <linux/vfio.h>
+#include <asm/eeh.h>
+
+/* We might build address mapping here for "fast" path later */
+int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
+{
+	return eeh_dev_open(pdev);
+}
+
+void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
+{
+	eeh_dev_release(pdev);
+}
+
+long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
+				unsigned int cmd, unsigned long arg)
+{
+	struct eeh_pe *pe;
+	struct vfio_eeh_pe_op op;
+	unsigned long minsz;
+	long ret = -EINVAL;
+
+	switch (cmd) {
+	case VFIO_CHECK_EXTENSION:
+		if (arg == VFIO_EEH)
+			ret = eeh_enabled() ? 1 : 0;
+		else
+			ret = 0;
+		break;
+	case VFIO_EEH_PE_OP:
+		pe = eeh_iommu_group_to_pe(group);
+		if (!pe)
+			return -ENODEV;
+
+		minsz = offsetofend(struct vfio_eeh_pe_op, op);
+		if (copy_from_user(&op, (void __user *)arg, minsz))
+			return -EFAULT;
+		if (op.argsz < minsz)
+			return -EINVAL;
+
+		switch (op.op) {
+		case VFIO_EEH_PE_DISABLE:
+			ret = eeh_pe_set_option(pe, EEH_OPT_DISABLE);
+			break;
+		case VFIO_EEH_PE_ENABLE:
+			ret = eeh_pe_set_option(pe, EEH_OPT_ENABLE);
+			break;
+		case VFIO_EEH_PE_UNFREEZE_IO:
+			ret = eeh_pe_set_option(pe, EEH_OPT_THAW_MMIO);
+			break;
+		case VFIO_EEH_PE_UNFREEZE_DMA:
+			ret = eeh_pe_set_option(pe, EEH_OPT_THAW_DMA);
+			break;
+		case VFIO_EEH_PE_GET_STATE:
+			ret = eeh_pe_get_state(pe);
+			break;
+		case VFIO_EEH_PE_RESET_DEACTIVATE:
+			ret = eeh_pe_reset(pe, EEH_RESET_DEACTIVATE);
+			break;
+		case VFIO_EEH_PE_RESET_HOT:
+			ret = eeh_pe_reset(pe, EEH_RESET_HOT);
+			break;
+		case VFIO_EEH_PE_RESET_FUNDAMENTAL:
+			ret = eeh_pe_reset(pe, EEH_RESET_FUNDAMENTAL);
+			break;
+		case VFIO_EEH_PE_CONFIGURE:
+			ret = eeh_pe_configure(pe);
+			break;
+		default:
+			ret = -EINVAL;
+		}
+	}
+
+	return ret;
+}
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 81022a52..0d3bb8f 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -99,4 +99,27 @@ extern int vfio_external_user_iommu_id(struct vfio_group *group);
 extern long vfio_external_check_extension(struct vfio_group *group,
 					  unsigned long arg);
 
+#ifdef CONFIG_EEH
+extern int vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
+extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
+extern long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
+				       unsigned int cmd,
+				       unsigned long arg);
+#else
+static inline int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
+{
+	return 0;
+}
+
+static inline void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
+{
+}
+
+static inline long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
+					      unsigned int cmd,
+					      unsigned long arg)
+{
+	return -ENOTTY;
+}
+#endif /* CONFIG_EEH */
 #endif /* VFIO_H */
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index cb9023d..b93c619 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -30,6 +30,9 @@
  */
 #define VFIO_DMA_CC_IOMMU		4
 
+/* Check if EEH is supported */
+#define VFIO_EEH			5
+
 /*
  * The IOCTL interface is designed for extensibility by embedding the
  * structure length (argsz) and flags into structures passed between
@@ -455,6 +458,38 @@ struct vfio_iommu_spapr_tce_info {
 
 #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
 
+/*
+ * EEH PE operation struct provides ways to:
+ * - enable/disable EEH functionality;
+ * - unfreeze IO/DMA for frozen PE;
+ * - read PE state;
+ * - reset PE;
+ * - configure PE.
+ */
+struct vfio_eeh_pe_op {
+	__u32 argsz;
+	__u32 flags;
+	__u32 op;
+};
+
+#define VFIO_EEH_PE_DISABLE		0	/* Disable EEH functionality */
+#define VFIO_EEH_PE_ENABLE		1	/* Enable EEH functionality  */
+#define VFIO_EEH_PE_UNFREEZE_IO		2	/* Enable IO for frozen PE   */
+#define VFIO_EEH_PE_UNFREEZE_DMA	3	/* Enable DMA for frozen PE  */
+#define VFIO_EEH_PE_GET_STATE		4	/* PE state retrieval        */
+#define VFIO_EEH_PE_RESET_DEACTIVATE	5	/* Deassert PE reset         */
+#define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
+#define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  */
+#define VFIO_EEH_PE_CONFIGURE		8	/* PE configuration          */
+
+#define VFIO_EEH_PE_STATE_NORMAL	0	/* PE in functional state    */
+#define VFIO_EEH_PE_STATE_RESET		1	/* PE reset in progress      */
+#define VFIO_EEH_PE_STATE_STOPPED	2	/* Stopped DMA and IO        */
+#define VFIO_EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA only          */
+#define VFIO_EEH_PE_STATE_UNAVAIL	5	/* State unavailable         */
+
+#define VFIO_EEH_PE_OP			_IO(VFIO_TYPE, VFIO_BASE + 21)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
1.8.3.2
