Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1D2F1A0832
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 15:03:51 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 May 2014 15:03:50 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9DE163578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 15:03:47 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4L4gK5h53477384
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:42:21 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4L53k41028124
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 15:03:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 3/4] drivers/vfio: EEH support for VFIO PCI device
Date: Wed, 21 May 2014 15:03:42 +1000
Message-Id: <1400648623-9127-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400648623-9127-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400648623-9127-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch adds new IOCTL command VFIO_EEH_OP to VFIO PCI device
to support EEH functionality for PCI devices, which have been
passed from host to guest via VFIO.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 Documentation/vfio.txt         |   6 +-
 arch/powerpc/include/asm/eeh.h |  10 ++
 arch/powerpc/kernel/eeh.c      | 323 +++++++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci.c    |  99 ++++++++++++-
 include/uapi/linux/vfio.h      |  43 ++++++
 5 files changed, 474 insertions(+), 7 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index b9ca023..bb17ec7 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -305,7 +305,10 @@ faster, the map/unmap handling has been implemented in real mode which provides
 an excellent performance which has limitations such as inability to do
 locked pages accounting in real time.
 
-So 3 additional ioctls have been added:
+4) PPC64 guests detect PCI errors and recover from them via EEH RTAS services,
+which works on the basis of additional ioctl command VFIO_EEH_OP.
+
+So 4 additional ioctls have been added:
 
 	VFIO_IOMMU_SPAPR_TCE_GET_INFO - returns the size and the start
 		of the DMA window on the PCI bus.
@@ -316,6 +319,7 @@ So 3 additional ioctls have been added:
 
 	VFIO_IOMMU_DISABLE - disables the container.
 
+	VFIO_EEH_OP - EEH dependent operations
 
 The code flow from the example above should be slightly changed:
 
diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 34a2d83..93922ef 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -305,6 +305,16 @@ void eeh_add_device_late(struct pci_dev *);
 void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_add_sysfs_files(struct pci_bus *);
 void eeh_remove_device(struct pci_dev *);
+#ifdef CONFIG_VFIO_PCI_EEH
+int eeh_vfio_open(struct pci_dev *pdev);
+void eeh_vfio_release(struct pci_dev *pdev);
+int eeh_vfio_set_pe_option(struct pci_dev *pdev, int option, int *retval);
+int eeh_vfio_get_pe_addr(struct pci_dev *pdev, int option,
+			 int *retval, int *info);
+int eeh_vfio_get_pe_state(struct pci_dev *pdev, int *retval, int *state);
+int eeh_vfio_reset_pe(struct pci_dev *pdev, int option, int *retval);
+int eeh_vfio_configure_pe(struct pci_dev *pdev, int *retval);
+#endif
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 9c6b899..2aaf90e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1098,6 +1098,329 @@ void eeh_remove_device(struct pci_dev *dev)
 	edev->mode &= ~EEH_DEV_SYSFS;
 }
 
+#ifdef CONFIG_VFIO_PCI_EEH
+int eeh_vfio_open(struct pci_dev *pdev)
+{
+	struct eeh_dev *edev;
+
+	/* No PCI device ? */
+	if (!pdev)
+		return -ENODEV;
+
+	/* No EEH device ? */
+	edev = pci_dev_to_eeh_dev(pdev);
+	if (!edev || !edev->pe)
+		return -ENODEV;
+
+	eeh_dev_set_passed(edev, true);
+	eeh_pe_set_passed(edev->pe, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(eeh_vfio_open);
+
+void eeh_vfio_release(struct pci_dev *pdev)
+{
+	bool release_pe = true;
+	struct eeh_pe *pe = NULL;
+	struct eeh_dev *tmp, *edev;
+
+	/* No PCI device ? */
+	if (!pdev)
+		return;
+
+	/* No EEH device ? */
+	edev = pci_dev_to_eeh_dev(pdev);
+	if (!edev || !eeh_dev_passed(edev) ||
+	    !edev->pe || !eeh_pe_passed(pe))
+		return;
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
+}
+EXPORT_SYMBOL(eeh_vfio_release);
+
+static int eeh_vfio_check_dev(struct pci_dev *pdev,
+			      struct eeh_dev **pedev,
+			      struct eeh_pe **ppe)
+{
+	struct eeh_dev *edev;
+
+	/* No device ? */
+	if (!pdev)
+		return -ENODEV;
+
+	edev = pci_dev_to_eeh_dev(pdev);
+	if (!edev || !eeh_dev_passed(edev) ||
+	    !edev->pe || !eeh_pe_passed(edev->pe))
+		return -ENODEV;
+
+	if (pedev)
+		*pedev = edev;
+	if (ppe)
+		*ppe = edev->pe;
+
+	return 0;
+}
+
+int eeh_vfio_set_pe_option(struct pci_dev *pdev, int option, int *retval)
+{
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int ret = 0;
+
+	/* Device existing ? */
+	ret = eeh_vfio_check_dev(pdev, &edev, &pe);
+	if (ret) {
+		pr_debug("%s: Cannot find device %s\n",
+			__func__, pdev ? pci_name(pdev) : "NULL");
+		*retval = -7;
+		goto out;
+	}
+
+	/* Invalid option ? */
+	if (option < EEH_OPT_DISABLE ||
+	    option > EEH_OPT_THAW_DMA) {
+		pr_debug("%s: Option %d out of range (%d, %d)\n",
+			__func__, option, EEH_OPT_DISABLE, EEH_OPT_THAW_DMA);
+		*retval = -3;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (option == EEH_OPT_DISABLE ||
+	    option == EEH_OPT_ENABLE) {
+		*retval = 0;
+	} else {
+		if (!eeh_ops || !eeh_ops->set_option) {
+			*retval = -7;
+			ret = -ENOENT;
+			goto out;
+		}
+
+		ret = eeh_ops->set_option(pe, option);
+		if (ret) {
+			pr_debug("%s: Failure %d from backend\n",
+				__func__, ret);
+			*retval = -1;
+			goto out;
+		}
+
+		*retval = 0;
+	}
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_vfio_set_pe_option);
+
+int eeh_vfio_get_pe_addr(struct pci_dev *pdev, int option,
+			 int *retval, int *info)
+{
+	struct pci_bus *bus;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int ret = 0;
+
+	/* Device existing ? */
+	ret = eeh_vfio_check_dev(pdev, &edev, &pe);
+	if (ret) {
+		*retval = -3;
+		goto out;
+	}
+
+	/* Invalid option ? */
+	if (option != 0 && option != 1) {
+		pr_debug("%s: option %d out of range (0, 1)\n",
+			__func__, option);
+		*retval = -3;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Fill result according to option. We don't differentiate
+	 * PCI bus and device dependent PE here. So all PEs are
+	 * built in "shared" mode. Also, the PE address has the format
+	 * of "00BBSS00".
+	 */
+	if (option == 0) {
+		bus = eeh_pe_bus_get(pe);
+		if (!bus) {
+			*retval = -3;
+			ret = -ENODEV;
+			goto out;
+		}
+
+		*retval = 0;
+		*info = bus->number << 16;
+	} else {
+		*retval = 0;
+		*info = 1;
+	}
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_vfio_get_pe_addr);
+
+int eeh_vfio_get_pe_state(struct pci_dev *pdev, int *retval, int *state)
+{
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int result, ret = 0;
+
+	/* Device existing ? */
+	ret = eeh_vfio_check_dev(pdev, &edev, &pe);
+	if (ret) {
+		*retval = -3;
+		goto out;
+	}
+
+	if (!eeh_ops || !eeh_ops->get_state) {
+		pr_debug("%s: Unsupported request\n",
+			__func__);
+		ret = -ENOENT;
+		*retval = -3;
+		goto out;
+	}
+
+	result = eeh_ops->get_state(pe, NULL);
+	if (!(result & EEH_STATE_RESET_ACTIVE) &&
+	     (result & EEH_STATE_DMA_ENABLED) &&
+	     (result & EEH_STATE_MMIO_ENABLED))
+		*state = 0;
+	else if (result & EEH_STATE_RESET_ACTIVE)
+		*state = 1;
+	else if (!(result & EEH_STATE_RESET_ACTIVE) &&
+		 !(result & EEH_STATE_DMA_ENABLED) &&
+		 !(result & EEH_STATE_MMIO_ENABLED))
+		*state = 2;
+	else if (!(result & EEH_STATE_RESET_ACTIVE) &&
+		 (result & EEH_STATE_DMA_ENABLED) &&
+		 !(result & EEH_STATE_MMIO_ENABLED))
+		*state = 4;
+	else
+		*state = 5;
+
+	*retval = 0;
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_vfio_get_pe_state);
+
+int eeh_vfio_reset_pe(struct pci_dev *pdev, int option, int *retval)
+{
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int ret = 0;
+
+	/* Device existing ? */
+	ret = eeh_vfio_check_dev(pdev, &edev, &pe);
+	if (ret) {
+		*retval = -3;
+		goto out;
+	}
+
+	/* Invalid option ? */
+	if (option != EEH_RESET_DEACTIVATE &&
+	    option != EEH_RESET_HOT &&
+	    option != EEH_RESET_FUNDAMENTAL) {
+		pr_debug("%s: Unsupported option %d\n",
+			__func__, option);
+		ret = -EINVAL;
+		*retval = -3;
+		goto out;
+	}
+
+	if (!eeh_ops || !eeh_ops->set_option || !eeh_ops->reset) {
+		pr_debug("%s: Unsupported request\n",
+			__func__);
+		ret = -ENOENT;
+		*retval = -7;
+		goto out;
+	}
+
+	ret = eeh_ops->reset(pe, option);
+	if (ret) {
+		pr_debug("%s: Failure %d from backend\n",
+			 __func__, ret);
+		*retval = -1;
+		goto out;
+	}
+
+	/*
+	 * The PE is still in frozen state and we need clear that.
+	 * It's good to clear frozen state after deassert to avoid
+	 * messy IO access during reset, which might cause recrusive
+	 * frozen PE.
+	 */
+	if (option == EEH_RESET_DEACTIVATE) {
+		ret = eeh_ops->set_option(pe, EEH_OPT_THAW_MMIO);
+		if (ret) {
+			pr_debug("%s: Cannot enable IO for PHB#%d-PE#%d (%d)\n",
+				__func__, pe->phb->global_number, pe->addr, ret);
+			*retval = -1;
+			goto out;
+		}
+
+		ret = eeh_ops->set_option(pe, EEH_OPT_THAW_DMA);
+		if (ret) {
+			pr_debug("%s: Cannot enable DMA for PHB#%d-PE#%d (%d)\n",
+				__func__, pe->phb->global_number, pe->addr, ret);
+			*retval = -1;
+			goto out;
+		}
+
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+	}
+
+	*retval = 0;
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_vfio_reset_pe);
+
+int eeh_vfio_configure_pe(struct pci_dev *pdev, int *retval)
+{
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int ret = 0;
+
+	/* Device existing ? */
+	ret = eeh_vfio_check_dev(pdev, &edev, &pe);
+	if (ret) {
+		*retval = -3;
+		goto out;
+	}
+
+	/*
+	 * The access to PCI config space on VFIO device has some
+	 * limitations. Part of PCI config space, including BAR
+	 * registers are not readable and writable. So the guest
+	 * should have stale values for those registers and we have
+	 * to restore them in host side.
+	 */
+	eeh_pe_restore_bars(pe);
+	*retval = 0;
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_vfio_configure_pe);
+
+#endif /* CONFIG_VFIO_PCI_EEH */
+
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	if (!eeh_enabled()) {
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 7ba0424..05c3dde 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -25,6 +25,9 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
+#ifdef CONFIG_VFIO_PCI_EEH
+#include <asm/eeh.h>
+#endif
 
 #include "vfio_pci_private.h"
 
@@ -152,32 +155,57 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 	pci_restore_state(pdev);
 }
 
+static void vfio_eeh_pci_release(struct pci_dev *pdev)
+{
+#ifdef CONFIG_VFIO_PCI_EEH
+	eeh_vfio_release(pdev);
+#endif
+}
+
 static void vfio_pci_release(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
 
-	if (atomic_dec_and_test(&vdev->refcnt))
+	if (atomic_dec_and_test(&vdev->refcnt)) {
+		vfio_eeh_pci_release(vdev->pdev);
 		vfio_pci_disable(vdev);
+	}
 
 	module_put(THIS_MODULE);
 }
 
+static int vfio_eeh_pci_open(struct pci_dev *pdev)
+{
+	int ret = 0;
+
+#ifdef CONFIG_VFIO_PCI_EEH
+	ret = eeh_vfio_open(pdev);
+#endif
+	return ret;
+}
+
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
+		ret = vfio_eeh_pci_open(vdev->pdev);
+		if (ret)
+			goto error;
 	}
 
 	return 0;
+error:
+	module_put(THIS_MODULE);
+	return ret;
 }
 
 static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
@@ -321,6 +349,51 @@ static int vfio_pci_for_each_slot_or_bus(struct pci_dev *pdev,
 	return walk.ret;
 }
 
+static int vfio_eeh_pci_ioctl(struct pci_dev *pdev, struct vfio_eeh_op *info)
+{
+	int ret = 0;
+
+#ifdef CONFIG_VFIO_PCI_EEH
+	switch (info->op) {
+	case VFIO_EEH_OP_SET_OPTION:
+		ret = eeh_vfio_set_pe_option(pdev,
+					     info->option.option,
+					     &info->option.ret);
+		break;
+	case VFIO_EEH_OP_GET_ADDR:
+		ret = eeh_vfio_get_pe_addr(pdev,
+					   info->addr.option,
+					   &info->addr.ret,
+					   &info->addr.info);
+		break;
+	case VFIO_EEH_OP_GET_STATE:
+		ret = eeh_vfio_get_pe_state(pdev,
+					    &info->state.ret,
+					    &info->state.reset_state);
+		info->state.cfg_cap = 1;
+		info->state.pe_unavail_info = 1000;
+		info->state.pe_recovery_info = 0;
+		break;
+	case VFIO_EEH_OP_PE_RESET:
+		ret = eeh_vfio_reset_pe(pdev,
+					info->reset.option,
+					&info->reset.ret);
+		break;
+	case VFIO_EEH_OP_PE_CONFIG:
+		ret = eeh_vfio_configure_pe(pdev,
+					    &info->config.ret);
+	default:
+		ret = -EINVAL;
+		pr_debug("%s: Cannot handle op#%d\n",
+			__func__, info->op);
+	}
+#else
+	ret = -ENOENT;
+#endif
+
+	return ret;
+}
+
 static long vfio_pci_ioctl(void *device_data,
 			   unsigned int cmd, unsigned long arg)
 {
@@ -682,6 +755,20 @@ hot_reset_release:
 
 		kfree(groups);
 		return ret;
+	} else if (cmd == VFIO_EEH_OP) {
+		struct vfio_eeh_op info;
+		int ret = 0;
+
+		minsz = sizeof(info);
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		ret = vfio_eeh_pci_ioctl(vdev->pdev, &info);
+		if (copy_to_user((void __user *)arg, &info, minsz))
+			ret = -EFAULT;
+		return ret;
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index cb9023d..518961d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -455,6 +455,49 @@ struct vfio_iommu_spapr_tce_info {
 
 #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
 
+/*
+ * The VFIO operation struct provides way to support EEH functionality
+ * for PCI device that is passed from host to guest via VFIO.
+ */
+#define VFIO_EEH_OP_SET_OPTION	0
+#define VFIO_EEH_OP_GET_ADDR	1
+#define VFIO_EEH_OP_GET_STATE	2
+#define VFIO_EEH_OP_PE_RESET	3
+#define VFIO_EEH_OP_PE_CONFIG	4
+
+struct vfio_eeh_op {
+	__u32 argsz;
+	__u32 op;
+
+	union {
+		struct vfio_eeh_set_option {
+			__u32 option;
+			__s32 ret;
+		} option;
+		struct vfio_eeh_pe_addr {
+			__u32 option;
+			__s32 ret;
+			__u32 info;
+		} addr;
+		struct vfio_eeh_pe_state {
+			__s32 ret;
+			__u32 reset_state;
+			__u32 cfg_cap;
+			__u32 pe_unavail_info;
+			__u32 pe_recovery_info;
+		} state;
+		struct vfio_eeh_reset {
+			__u32 option;
+			__s32 ret;
+		} reset;
+		struct vfio_eeh_config {
+			__s32 ret;
+		} config;
+	};
+};
+
+#define VFIO_EEH_OP	_IO(VFIO_TYPE, VFIO_BASE + 21)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
1.8.3.2
