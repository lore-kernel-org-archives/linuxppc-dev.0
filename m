Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 585EA1A085C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:24 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 May 2014 18:30:24 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C55FB357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:21 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4K88l3n4850118
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:08:47 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4K8UK1T022857
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 3/4] drivers/vfio: New IOCTL command VFIO_EEH_INFO
Date: Tue, 20 May 2014 18:30:11 +1000
Message-Id: <1400574612-19411-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/Makefile   |   1 +
 arch/powerpc/platforms/powernv/eeh-vfio.c | 445 ++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci.c               |  24 +-
 drivers/vfio/pci/vfio_pci_private.h       |  16 ++
 include/uapi/linux/vfio.h                 |  43 +++
 5 files changed, 523 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/eeh-vfio.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 63cebb9..45cd833 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -6,5 +6,6 @@ obj-y			+= opal-msglog.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
 obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
+obj-$(CONFIG_VFIO_PCI_EEH)	+= eeh-vfio.o
 obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
diff --git a/arch/powerpc/platforms/powernv/eeh-vfio.c b/arch/powerpc/platforms/powernv/eeh-vfio.c
new file mode 100644
index 0000000..11adc55
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/eeh-vfio.c
@@ -0,0 +1,445 @@
+/*
+  * The file intends to support EEH funtionality for those PCI devices,
+  * which have been passed through from host to guest via VFIO. So this
+  * file is naturally part of VFIO implementation on PowerNV platform.
+  *
+  * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2014.
+  *
+  * This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License as published by
+  * the Free Software Foundation; either version 2 of the License, or
+  * (at your option) any later version.
+  */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/vfio.h>
+
+#include <asm/eeh.h>
+#include <asm/eeh_event.h>
+#include <asm/io.h>
+#include <asm/iommu.h>
+#include <asm/opal.h>
+#include <asm/msi_bitmap.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+#include <asm/tce.h>
+#include <asm/uaccess.h>
+
+#include "powernv.h"
+#include "pci.h"
+
+static int powernv_eeh_vfio_check_dev(struct pci_dev *pdev,
+				      struct eeh_dev **pedev,
+				      struct eeh_pe **ppe,
+				      struct pnv_phb **pphb)
+{
+	struct eeh_dev *edev;
+	struct pnv_phb *phb;
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
+	/* EEH isn't supported ? */
+	phb = edev->phb->private_data;
+	if (!(phb->flags & PNV_PHB_FLAG_EEH))
+		return -EACCES;
+
+	if (pedev)
+		*pedev = edev;
+	if (ppe)
+		*ppe = edev->pe;
+	if (pphb)
+		*pphb = phb;
+
+	return 0;
+}
+
+static int powernv_eeh_vfio_set_option(struct pci_dev *pdev,
+				       struct vfio_eeh_op *info)
+{
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct pnv_phb *phb;
+	int opcode = info->option.option;
+	int ret = 0;
+
+	/* Device existing ? */
+	ret = powernv_eeh_vfio_check_dev(pdev, &edev, &pe, &phb);
+	if (ret) {
+		pr_debug("%s: Cannot find device\n",
+			__func__);
+		info->option.ret = -7;
+		goto out;
+	}
+
+	/* Invalid opcode ? */
+	if (opcode < EEH_OPT_DISABLE ||
+	    opcode > EEH_OPT_THAW_DMA) {
+		pr_debug("%s: Opcode#%d out of range (%d, %d)\n",
+			 __func__, opcode, EEH_OPT_DISABLE, EEH_OPT_THAW_DMA);
+		info->option.ret = -3;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (opcode == EEH_OPT_DISABLE ||
+	    opcode == EEH_OPT_ENABLE) {
+		info->option.ret = 0;
+	} else {
+		if (!phb->eeh_ops || !phb->eeh_ops->set_option) {
+			info->option.ret = -7;
+			ret = -ENOENT;
+			goto out;
+		}
+
+		ret = phb->eeh_ops->set_option(pe, opcode);
+		if (ret) {
+			pr_debug("%s: Failure %d from backend\n",
+				__func__, ret);
+			info->option.ret = -3;
+			goto out;
+		}
+
+		info->option.ret = 0;
+	}
+out:
+	return ret;
+}
+
+static int powernv_eeh_vfio_get_addr(struct pci_dev *pdev,
+				     struct vfio_eeh_op *info)
+{
+	struct pci_bus *bus;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct pnv_phb *phb;
+	int opcode = info->addr.option;
+	int ret = 0;
+
+	/* Device existing ? */
+	ret = powernv_eeh_vfio_check_dev(pdev, &edev, &pe, &phb);
+	if (ret) {
+		info->addr.ret = -3;
+		goto out;
+	}
+
+	/* Invalid opcode ? */
+	if (opcode != 0 && opcode != 1) {
+		pr_debug("%s: opcode %d out of range (0, 1)\n",
+			__func__, opcode);
+		info->addr.ret = -3;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Fill result according to opcode. We don't differentiate
+	 * PCI bus and device sensitive PE here.
+	 */
+	if (opcode == 0) {
+		bus = eeh_pe_bus_get(pe);
+		if (!bus) {
+			info->addr.ret = -3;
+			ret = -ENODEV;
+			goto out;
+		}
+
+		info->addr.ret = 0;
+		info->addr.info = bus->number << 16;
+	} else {
+		info->addr.info = 1;
+		info->addr.ret = 1;
+	}
+out:
+	return ret;
+}
+
+static int powernv_eeh_vfio_get_state(struct pci_dev *pdev,
+				      struct vfio_eeh_op *info)
+{
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct pnv_phb *phb;
+	int result, ret = 0;
+
+	/* Device existing ? */
+	ret = powernv_eeh_vfio_check_dev(pdev, &edev, &pe, &phb);
+	if (ret) {
+		info->state.ret = -3;
+		goto out;
+	}
+
+	if (!phb->eeh_ops || !phb->eeh_ops->get_state) {
+		pr_debug("%s: Unsupported request\n",
+			__func__);
+		ret = -ENOENT;
+		info->state.ret = -3;
+		goto out;
+	}
+
+	result = phb->eeh_ops->get_state(pe);
+
+	if (!(result & EEH_STATE_RESET_ACTIVE) &&
+	     (result & EEH_STATE_DMA_ENABLED) &&
+	     (result & EEH_STATE_MMIO_ENABLED))
+		info->state.reset_state = 0;
+	else if (result & EEH_STATE_RESET_ACTIVE)
+		info->state.reset_state = 1;
+	else if (!(result & EEH_STATE_RESET_ACTIVE) &&
+		 !(result & EEH_STATE_DMA_ENABLED) &&
+		 !(result & EEH_STATE_MMIO_ENABLED))
+		info->state.reset_state = 2;
+	else if (!(result & EEH_STATE_RESET_ACTIVE) &&
+		 (result & EEH_STATE_DMA_ENABLED) &&
+		 !(result & EEH_STATE_MMIO_ENABLED))
+		info->state.reset_state = 4;
+	else
+		info->state.reset_state = 5;
+
+	info->state.ret = 0;
+	info->state.cfg_cap = 1;
+	info->state.pe_unavail_info = 1000;
+	info->state.pe_recovery_info = 0;
+
+out:
+	return ret;
+}
+
+static int powernv_eeh_vfio_pe_reset(struct pci_dev *pdev,
+				     struct vfio_eeh_op *info)
+{
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct pnv_phb *phb;
+	int opcode = info->reset.option;
+	int ret = 0;
+
+	/* Device existing ? */
+	ret = powernv_eeh_vfio_check_dev(pdev, &edev, &pe, &phb);
+	if (ret) {
+		info->addr.ret = -3;
+		goto out;
+	}
+
+	/* Invalid opcode ? */
+	if (opcode != EEH_RESET_DEACTIVATE &&
+	    opcode != EEH_RESET_HOT &&
+	    opcode != EEH_RESET_FUNDAMENTAL) {
+		pr_debug("%s: Unsupported opcode %d\n",
+			__func__, opcode);
+		ret = -EINVAL;
+		info->reset.ret = -3;
+		goto out;
+	}
+
+	/* Call into the IODA dependent backend to do the reset */
+	if (!phb->eeh_ops ||
+	    !phb->eeh_ops->set_option ||
+	    !phb->eeh_ops->reset) {
+		pr_debug("%s: Unsupported request\n",
+			__func__);
+		ret = -ENOENT;
+		info->reset.ret = -7;
+		goto out;
+	}
+
+	/*
+	 * The frozen PE might be caused by the mechanism called
+	 * PAPR error injection, which is supposed to be one-shot
+	 * without "sticky" bit as being stated by the spec. But
+	 * the reality isn't that, at least on P7IOC. So we have
+	 * to clear that to avoid recrusive error, which fails the
+	 * recovery eventually.
+	 */
+	if (opcode == EEH_RESET_DEACTIVATE)
+		opal_pci_reset(phb->opal_id,
+			       OPAL_PHB_ERROR,
+			       OPAL_ASSERT_RESET);
+
+	ret = phb->eeh_ops->reset(pe, opcode);
+	if (ret) {
+		pr_debug("%s: Failure %d from backend\n",
+			__func__, ret);
+		info->reset.ret = -1;
+		goto out;
+	}
+
+	/*
+	 * The PE is still in frozen state and we need clear that.
+	 * It's good to clear frozen state after deassert to avoid
+	 * messy IO access during reset, which might cause recrusive
+	 * frozen PE.
+	 */
+	if (opcode == EEH_RESET_DEACTIVATE) {
+		ret = phb->eeh_ops->set_option(pe, EEH_OPT_THAW_MMIO);
+		if (ret) {
+			pr_debug("%s: Cannot enable DMA for PHB#%d-PE#%d (%d)\n",
+				__func__, pe->phb->global_number, pe->addr, ret);
+			info->reset.ret = -1;
+			goto out;
+		}
+
+		ret = phb->eeh_ops->set_option(pe, EEH_OPT_THAW_DMA);
+		if (ret) {
+			pr_debug("%s: Cannot enable IO for PHB#%d-PE#%d (%d)\n",
+				__func__, pe->phb->global_number, pe->addr, ret);
+			info->reset.ret = -1;
+			goto out;
+		}
+
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+	}
+
+	info->reset.ret = 0;
+out:
+	return ret;
+}
+
+static int powernv_eeh_vfio_pe_config(struct pci_dev *pdev,
+				      struct vfio_eeh_op *info)
+{
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct pnv_phb *phb;
+	int ret = 0;
+
+	/* Device existing ? */
+	ret = powernv_eeh_vfio_check_dev(pdev, &edev, &pe, &phb);
+	if (ret) {
+		info->config.ret = -3;
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
+	info->config.ret = 0;
+
+out:
+	return ret;
+}
+
+int eeh_vfio_pci_open(struct pci_dev *pdev)
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
+EXPORT_SYMBOL_GPL(eeh_vfio_pci_open);
+
+void eeh_vfio_pci_release(struct pci_dev *pdev)
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
+EXPORT_SYMBOL(eeh_vfio_pci_release);
+
+int eeh_vfio_pci_ioctl(struct pci_dev *pdev,
+		       unsigned long arg)
+{
+	struct vfio_eeh_op info;
+	unsigned long minsz = sizeof(info);
+	int ret = -EINVAL;
+
+	/* Copy over user argument */
+	if (copy_from_user(&info, (void __user *)arg, minsz)) {
+		pr_debug("%s: Cannot copy parameter 0x%lx\n",
+			__func__, arg);
+		return -EFAULT;
+	}
+
+	/* Sanity check */
+	if (info.argsz < minsz) {
+		pr_debug("%s: Invalid size (%d, %ld)\n",
+			__func__, info.argsz, minsz);
+		return -EINVAL;
+	}
+
+	/* Route according to operation */
+	switch (info.op) {
+	case VFIO_EEH_OP_SET_OPTION:
+		ret = powernv_eeh_vfio_set_option(pdev, &info);
+		break;
+	case VFIO_EEH_OP_GET_ADDR:
+		ret = powernv_eeh_vfio_get_addr(pdev, &info);
+		break;
+	case VFIO_EEH_OP_GET_STATE:
+		ret = powernv_eeh_vfio_get_state(pdev, &info);
+		break;
+	case VFIO_EEH_OP_PE_RESET:
+		ret = powernv_eeh_vfio_pe_reset(pdev, &info);
+		break;
+	case VFIO_EEH_OP_PE_CONFIG:
+		ret = powernv_eeh_vfio_pe_config(pdev, &info);
+		break;
+	default:
+		pr_debug("%s: Cannot handle op#%d\n",
+			__func__, info.op);
+	}
+
+	/* Copy data back */
+	if (copy_to_user((void __user *)arg, &info, minsz)) {
+		pr_debug("%s: Cannot copy parameter to user 0x%lx\n",
+			__func__, arg);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_vfio_pci_ioctl);
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 7ba0424..ee82c7f 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -156,8 +156,11 @@ static void vfio_pci_release(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
 
-	if (atomic_dec_and_test(&vdev->refcnt))
+
+	if (atomic_dec_and_test(&vdev->refcnt)) {
+		eeh_vfio_pci_release(vdev->pdev);
 		vfio_pci_disable(vdev);
+	}
 
 	module_put(THIS_MODULE);
 }
@@ -165,19 +168,26 @@ static void vfio_pci_release(void *device_data)
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
+		ret = eeh_vfio_pci_open(vdev->pdev);
+		if (ret)
+			goto error;
 	}
 
 	return 0;
+
+error:
+	module_put(THIS_MODULE);
+	return ret;
 }
 
 static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
@@ -682,6 +692,8 @@ hot_reset_release:
 
 		kfree(groups);
 		return ret;
+	} else if (cmd == VFIO_EEH_OP) {
+		return eeh_vfio_pci_ioctl(vdev->pdev, arg);
 	}
 
 	return -ENOTTY;
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 9c6d5d0..1273bb6 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -90,4 +90,20 @@ extern void vfio_pci_virqfd_exit(void);
 
 extern int vfio_config_init(struct vfio_pci_device *vdev);
 extern void vfio_config_free(struct vfio_pci_device *vdev);
+
+#ifdef CONFIG_VFIO_PCI_EEH
+extern int eeh_vfio_pci_open(struct pci_dev *pdev);
+extern void eeh_vfio_pci_release(struct pci_dev *pdev);
+extern int eeh_vfio_pci_ioctl(struct pci_dev *pdev, unsigned long arg);
+#else
+static inline int eeh_vfio_pci_open(struct pci_dev *pdev)
+{
+	return 0;
+}
+static inline eeh_vfio_pci_release(struct pci_dev *pdev) { }
+static int eeh_vfio_pci_ioctl(struct pci_dev *pdev, unsigned long arg)
+{
+	return -ENOENT;
+}
+#endif /* COFNIG_VFIO_PCI_EEH */
 #endif /* VFIO_PCI_PRIVATE_H */
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index cb9023d..6e7f033 100644
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
+                } state;
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
