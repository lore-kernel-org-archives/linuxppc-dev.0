Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29B431A0642
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:41:14 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 27 May 2014 18:41:12 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B03B7357805E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:41:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4R8JTQm61341714
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:19:33 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4R8esRN008462
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:40:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
Date: Tue, 27 May 2014 18:40:52 +1000
Message-Id: <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch adds new IOCTL commands for sPAPR VFIO container device
to support EEH functionality for PCI devices, which have been passed
through from host to somebody else via VFIO.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 Documentation/vfio.txt              | 92 ++++++++++++++++++++++++++++++++++++-
 drivers/vfio/pci/Makefile           |  1 +
 drivers/vfio/pci/vfio_pci.c         | 20 +++++---
 drivers/vfio/pci/vfio_pci_eeh.c     | 46 +++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h |  5 ++
 drivers/vfio/vfio_iommu_spapr_tce.c | 85 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h           | 66 ++++++++++++++++++++++++++
 7 files changed, 308 insertions(+), 7 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_eeh.c

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index b9ca023..d890fed 100644
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
+So 7 additional ioctls have been added:
 
 	VFIO_IOMMU_SPAPR_TCE_GET_INFO - returns the size and the start
 		of the DMA window on the PCI bus.
@@ -316,6 +324,17 @@ So 3 additional ioctls have been added:
 
 	VFIO_IOMMU_DISABLE - disables the container.
 
+	VFIO_EEH_PE_SET_OPTION - enables or disables EEH functionality on the
+		specified device. Also, it can be used to remove IO or DMA
+		stopped state on the frozen PE.
+
+	VFIO_EEH_PE_GET_STATE - retrieve PE's state: frozen or normal state.
+
+	VFIO_EEH_PE_RESET - do PE reset, which is one of the major steps for
+		error recovering.
+
+	VFIO_EEH_PE_CONFIGURE - configure the PCI bridges after PE reset. It's
+		one of the major steps for error recoverying.
 
 The code flow from the example above should be slightly changed:
 
@@ -346,6 +365,77 @@ The code flow from the example above should be slightly changed:
 	ioctl(container, VFIO_IOMMU_MAP_DMA, &dma_map);
 	.....
 
+Based on the initial example we have, the following piece of code could be
+reference for EEH setup and error handling:
+
+	struct vfio_eeh_pe_set_option option = { .argsz = sizeof(option) };
+	struct vfio_eeh_pe_get_state state = { .argsz = sizeof(state) };
+	struct vfio_eeh_pe_reset reset = { .argsz = sizeof(reset) };
+	struct vfio_eeh_pe_configure configure = { .argsz = sizeof(configure) };
+
+	....
+
+	/* Get a file descriptor for the device */
+	device = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "0000:06:0d.0");
+
+	/* Enable the EEH functionality on the device */
+	option.option = VFIO_EEH_PE_SET_OPT_ENABLE;
+	ioctl(container, VFIO_EEH_PE_SET_OPTION, &option);
+
+	/* You're suggested to create additional data struct to represent
+	 * PE, and put child devices belonging to same IOMMU group to the
+	 * PE instance for later reference.
+	 */
+
+	/* Check the PE's state and make sure it's in functional state */
+	ioctl(container, VFIO_EEH_PE_GET_STATE, &state);
+
+	/* Save device's state. pci_save_state() would be good enough
+	 * as an example.
+	 */
+
+	/* Test and setup the device */
+	ioctl(device, VFIO_DEVICE_GET_INFO, &device_info);
+
+	....
+
+	/* When 0xFF's returned from reading PCI config space or IO BARs
+	 * of the PCI device. Check the PE state to see if that has been
+	 * frozen.
+	 */
+	ioctl(container, VFIO_EEH_PE_GET_STATE, &state);
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
+	option.option = VFIO_EEH_PE_SET_OPT_IO;
+	ioctl(container, VFIO_EEH_PE_SET_OPTION, &option);
+
+	/* Issue PE reset */
+	reset.option = VFIO_EEH_PE_RESET_HOT;
+	ioctl(container, VFIO_EEH_PE_RESET, &reset);
+	reset.option = VFIO_EEH_PE_RESET_DEACTIVATE;
+	ioctl(container, VFIO_EEH_PE_RESET, &reset);
+
+	/* Configure the PCI bridges for the affected PE */
+	ioctl(container, VFIO_EEH_PE_CONFIGURE, &configure);
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
+
 -------------------------------------------------------------------------------
 
 [1] VFIO was originally an acronym for "Virtual Function I/O" in its
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 1310792..faad885 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -1,4 +1,5 @@
 
 vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
+vfio-pci-y += vfio_pci_eeh.o
 
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 7ba0424..7c8d26a 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -156,8 +156,10 @@ static void vfio_pci_release(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
 
-	if (atomic_dec_and_test(&vdev->refcnt))
+	if (atomic_dec_and_test(&vdev->refcnt)) {
+		vfio_pci_eeh_release(vdev->pdev);
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
+		ret = vfio_pci_eeh_open(vdev->pdev);
+		if (ret)
+			goto error;
 	}
 
 	return 0;
+error:
+	module_put(THIS_MODULE);
+	return ret;
 }
 
 static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
diff --git a/drivers/vfio/pci/vfio_pci_eeh.c b/drivers/vfio/pci/vfio_pci_eeh.c
new file mode 100644
index 0000000..9c25207
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_eeh.c
@@ -0,0 +1,46 @@
+/*
+ * EEH functionality support for VFIO PCI devices.
+ *
+ * Copyright Gavin Shan, IBM Corporation 2014.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/vfio.h>
+#ifdef CONFIG_EEH
+#include <asm/eeh.h>
+#endif
+
+#include "vfio_pci_private.h"
+
+int vfio_pci_eeh_open(struct pci_dev *pdev)
+{
+	int ret = 0;
+
+#ifdef CONFIG_EEH
+	ret = eeh_dev_open(pdev);
+#endif
+	return ret;
+}
+
+void vfio_pci_eeh_release(struct pci_dev *pdev)
+{
+#ifdef CONFIG_EEH
+	eeh_dev_release(pdev);
+#endif
+}
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 9c6d5d0..c3cbe40 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -90,4 +90,9 @@ extern void vfio_pci_virqfd_exit(void);
 
 extern int vfio_config_init(struct vfio_pci_device *vdev);
 extern void vfio_config_free(struct vfio_pci_device *vdev);
+
+/* EEH stub */
+extern int vfio_pci_eeh_open(struct pci_dev *pdev);
+extern void vfio_pci_eeh_release(struct pci_dev *pdev);
+
 #endif /* VFIO_PCI_PRIVATE_H */
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index a84788b..666691b 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -21,6 +21,9 @@
 #include <linux/vfio.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
+#ifdef CONFIG_EEH
+#include <asm/eeh.h>
+#endif
 
 #define DRIVER_VERSION  "0.1"
 #define DRIVER_AUTHOR   "aik@ozlabs.ru"
@@ -147,6 +150,83 @@ static void tce_iommu_release(void *iommu_data)
 	kfree(container);
 }
 
+static long tce_iommu_eeh_ioctl(void *iommu_data,
+				unsigned int cmd, unsigned long arg)
+{
+	struct tce_container *container = iommu_data;
+	unsigned long minsz;
+	int ret = 0;
+
+#ifdef CONFIG_EEH
+	switch (cmd) {
+	case VFIO_EEH_PE_SET_OPTION: {
+		struct vfio_eeh_pe_set_option option;
+
+		minsz = offsetofend(struct vfio_eeh_pe_set_option, option);
+		if (copy_from_user(&option, (void __user *)arg, minsz))
+			return -EFAULT;
+		if (option.argsz < minsz)
+			return -EINVAL;
+
+		ret = eeh_pe_set_option(eeh_iommu_table_to_pe(container->tbl),
+					option.option);
+		break;
+	}
+	case VFIO_EEH_PE_GET_STATE: {
+		struct vfio_eeh_pe_get_state state;
+
+		minsz = offsetofend(struct vfio_eeh_pe_get_state, state);
+		if (copy_from_user(&state, (void __user *)arg, minsz))
+			return -EFAULT;
+		if (state.argsz < minsz)
+			return -EINVAL;
+
+		ret = eeh_pe_get_state(eeh_iommu_table_to_pe(container->tbl));
+		if (ret >= 0) {
+			state.state = ret;
+			if (copy_to_user((void __user *)arg, &state, minsz))
+				return -EFAULT;
+			ret = 0;
+		}
+		break;
+	}
+	case VFIO_EEH_PE_RESET: {
+		struct vfio_eeh_pe_reset reset;
+
+		minsz = offsetofend(struct vfio_eeh_pe_reset, option);
+		if (copy_from_user(&reset, (void __user *)arg, minsz))
+			return -EFAULT;
+		if (reset.argsz < minsz)
+			return -EINVAL;
+
+		ret = eeh_pe_reset(eeh_iommu_table_to_pe(container->tbl),
+				   reset.option);
+		break;
+	}
+	case VFIO_EEH_PE_CONFIGURE: {
+		struct vfio_eeh_pe_configure configure;
+
+		minsz = offsetofend(struct vfio_eeh_pe_configure, flags);
+		if (copy_from_user(&configure, (void __user *)arg, minsz))
+			return -EFAULT;
+		if (configure.argsz < minsz)
+			return -EINVAL;
+
+		ret = eeh_pe_configure(eeh_iommu_table_to_pe(container->tbl));
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		pr_debug("%s: Cannot handle command %d\n",
+			__func__, cmd);
+	}
+#else
+	ret = -ENOENT;
+#endif
+
+	return ret;
+}
+
 static long tce_iommu_ioctl(void *iommu_data,
 				 unsigned int cmd, unsigned long arg)
 {
@@ -283,6 +363,11 @@ static long tce_iommu_ioctl(void *iommu_data,
 		tce_iommu_disable(container);
 		mutex_unlock(&container->lock);
 		return 0;
+	case VFIO_EEH_PE_SET_OPTION:
+	case VFIO_EEH_PE_GET_STATE:
+	case VFIO_EEH_PE_RESET:
+	case VFIO_EEH_PE_CONFIGURE:
+		return tce_iommu_eeh_ioctl(iommu_data, cmd, arg);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index cb9023d..c5fac36 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -455,6 +455,72 @@ struct vfio_iommu_spapr_tce_info {
 
 #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
 
+/*
+ * EEH functionality can be enabled or disabled on one specific device.
+ * Also, the DMA or IO frozen state can be removed from the frozen PE
+ * if required.
+ */
+struct vfio_eeh_pe_set_option {
+	__u32 argsz;
+	__u32 flags;
+	__u32 option;
+#define VFIO_EEH_PE_SET_OPT_DISABLE	0	/* Disable EEH	*/
+#define VFIO_EEH_PE_SET_OPT_ENABLE	1	/* Enable EEH	*/
+#define VFIO_EEH_PE_SET_OPT_IO		2	/* Enable IO	*/
+#define VFIO_EEH_PE_SET_OPT_DMA		3	/* Enable DMA	*/
+};
+
+#define VFIO_EEH_PE_SET_OPTION		_IO(VFIO_TYPE, VFIO_BASE + 21)
+
+/*
+ * Each EEH PE should have unique address to be identified. PE's
+ * sharing mode is also useful information as well.
+ */
+#define VFIO_EEH_PE_GET_ADDRESS		0	/* Get address	*/
+#define VFIO_EEH_PE_GET_MODE		1	/* Query mode	*/
+#define VFIO_EEH_PE_MODE_NONE		0	/* Not a PE	*/
+#define VFIO_EEH_PE_MODE_NOT_SHARED	1	/* Exclusive	*/
+#define VFIO_EEH_PE_MODE_SHARED		2	/* Shared mode	*/
+
+/*
+ * EEH PE might have been frozen because of PCI errors. Also, it might
+ * be experiencing reset for error revoery. The following command helps
+ * to get the state.
+ */
+struct vfio_eeh_pe_get_state {
+	__u32 argsz;
+	__u32 flags;
+	__u32 state;
+};
+
+#define VFIO_EEH_PE_GET_STATE		_IO(VFIO_TYPE, VFIO_BASE + 22)
+
+/*
+ * Reset is the major step to recover problematic PE. The following
+ * command helps on that.
+ */
+struct vfio_eeh_pe_reset {
+	__u32 argsz;
+	__u32 flags;
+	__u32 option;
+#define VFIO_EEH_PE_RESET_DEACTIVATE	0	/* Deactivate reset	*/
+#define VFIO_EEH_PE_RESET_HOT		1	/* Hot reset		*/
+#define VFIO_EEH_PE_RESET_FUNDAMENTAL	3	/* Fundamental reset	*/
+};
+
+#define VFIO_EEH_PE_RESET		_IO(VFIO_TYPE, VFIO_BASE + 23)
+
+/*
+ * One of the steps for recovery after PE reset is to configure the
+ * PCI bridges affected by the PE reset.
+ */
+struct vfio_eeh_pe_configure {
+	__u32 argsz;
+	__u32 flags;
+};
+
+#define VFIO_EEH_PE_CONFIGURE		_IO(VFIO_TYPE, VFIO_BASE + 24)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
1.8.3.2
