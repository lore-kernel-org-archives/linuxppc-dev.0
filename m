Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F12EA140108
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:50 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 9 May 2014 17:49:50 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E42163578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:47 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s497SZKa5702140
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:28:35 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s497nkFj021248
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:49:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 05/10] drivers/vfio: New IOCTL command VFIO_EEH_INFO
Date: Fri,  9 May 2014 17:49:37 +1000
Message-Id: <1399621782-23281-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds new IOCTL command VFIO_EEH_INFO to VFIO container
to support EEH functionality for PCI devices, which have been
passed from host to guest via VFIO.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile   |   1 +
 arch/powerpc/platforms/powernv/eeh-vfio.c | 584 ++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_spapr_tce.c       |  12 +
 include/uapi/linux/vfio.h                 |  61 ++++
 4 files changed, 658 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/eeh-vfio.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 63cebb9..2b15a03 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -6,5 +6,6 @@ obj-y			+= opal-msglog.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
 obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
+obj-$(CONFIG_VFIO_EEH)	+= eeh-vfio.o
 obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
diff --git a/arch/powerpc/platforms/powernv/eeh-vfio.c b/arch/powerpc/platforms/powernv/eeh-vfio.c
new file mode 100644
index 0000000..5766715
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/eeh-vfio.c
@@ -0,0 +1,584 @@
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
+static int powernv_eeh_vfio_map(struct vfio_eeh_info *info)
+{
+	struct pci_bus *bus, *pe_bus;
+	struct pci_dev *pdev;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int domain, bus_no, devfn;
+
+	/* Host address */
+	domain = info->map.domain;
+	bus_no = (info->map.bdn >> 8) & 0xff;
+	devfn = info->map.bdn & 0xff;
+
+	/* Find PCI bus */
+	bus = pci_find_bus(domain, bus_no);
+	if (!bus) {
+		pr_warn("%s: PCI bus %04x:%02x not found\n",
+			__func__, domain, bus_no);
+		return -ENODEV;
+	}
+
+	/* Find PCI device */
+	pdev = pci_get_slot(bus, devfn);
+	if (!pdev) {
+		pr_warn("%s: PCI device %04x:%02x:%02x.%01x not found\n",
+			__func__, domain, bus_no,
+			PCI_SLOT(devfn), PCI_FUNC(devfn));
+		return -ENODEV;
+	}
+
+	/* No EEH device - almost impossible */
+	edev = pci_dev_to_eeh_dev(pdev);
+	if (unlikely(!edev)) {
+		pci_dev_put(pdev);
+		pr_warn("%s: No EEH dev for PCI device %s\n",
+			__func__, pci_name(pdev));
+		return -ENODEV;
+	}
+
+	/* Doesn't support PE migration between different PHBs */
+	pe = edev->pe;
+	if (!eeh_pe_passed(pe)) {
+		pe_bus = eeh_pe_bus_get(pe);
+		BUG_ON(!pe_bus);
+
+		/* PE# has format 00BBSS00 */
+		pe->gaddr.buid	  = info->map.gbuid;
+		pe->gaddr.pe_addr = pe_bus->number << 16;
+		eeh_pe_set_passed(pe, true);
+	} else if (pe->gaddr.buid != info->map.gbuid) {
+		pci_dev_put(pdev);
+		pr_warn("%s: Mismatched PHB BUID (0x%llx, 0x%llx)\n",
+			__func__, pe->gaddr.buid, info->map.gbuid);
+		return -EINVAL;
+	}
+
+	edev->gaddr.buid = info->map.gbuid;
+	edev->gaddr.bdn  = info->map.gbdn;
+	eeh_dev_set_passed(edev, true);
+
+	pr_debug("EEH: Host PCI dev %s to %llx-%02x:%02x.%01x\n",
+		 pci_name(pdev), info->map.gbuid,
+		 (info->map.gbdn >> 8) & 0xFF,
+		 PCI_SLOT(info->map.gbdn & 0xFF),
+		 PCI_FUNC(info->map.gbdn & 0xFF));
+
+	pci_dev_put(pdev);
+	return 0;
+}
+
+static int powernv_eeh_vfio_unmap(struct vfio_eeh_info *info)
+{
+	struct eeh_vfio_pci_addr addr;
+	struct pci_dev *pdev;
+	struct eeh_dev *edev, *tmp;
+	struct eeh_pe *pe;
+	bool passed;
+
+	/* Get EEH device */
+	addr.buid = info->unmap.buid;
+	addr.bdn  = info->unmap.bdn;
+	edev = eeh_vfio_dev_get(&addr);
+	if (!edev) {
+		pr_warn("%s: Cannot locate %llx:%02x:%02x.%01x\n",
+			__func__, info->unmap.buid,
+			(info->unmap.bdn >> 8) & 0xFF,
+			PCI_SLOT(info->unmap.bdn & 0xFF),
+			PCI_FUNC(info->unmap.bdn & 0xFF));
+		return -ENODEV;
+	}
+
+	/* Return EEH device */
+	memset(&edev->gaddr, 0, sizeof(edev->gaddr));
+	eeh_dev_set_passed(edev, false);
+	pdev = eeh_dev_to_pci_dev(edev);
+	pr_debug("EEH: Host PCI dev %s returned\n",
+		 pdev ? pci_name(pdev) : "NULL");
+
+	/* Return PE if no EEH device is owned by guest */
+	pe = edev->pe;
+	passed = false;
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (pdev && pdev->subordinate)
+			continue;
+
+		if (eeh_dev_passed(edev)) {
+			passed = true;
+			break;
+		}
+	}
+
+	if (!passed) {
+		memset(&pe->gaddr, 0, sizeof(pe->gaddr));
+		eeh_pe_set_passed(pe, false);
+		pr_debug("EEH: PHB#%x-PE#%x returned to host\n",
+			 pe->phb->global_number, pe->addr);
+	}
+
+	return 0;
+}
+
+static int powernv_eeh_vfio_set_option(struct vfio_eeh_info *info)
+{
+	struct pnv_phb *phb;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct eeh_vfio_pci_addr addr;
+	int opcode = info->option.option;
+	int ret = 0;
+
+	/* Check opcode */
+	if (opcode < EEH_OPT_DISABLE || opcode > EEH_OPT_THAW_DMA) {
+		pr_warn("%s: opcode %d out of range (%d, %d)\n",
+			__func__, opcode, EEH_OPT_DISABLE, EEH_OPT_THAW_DMA);
+		ret = 3;
+		goto out;
+	}
+
+	/* Option "enable" uses PCI config address */
+	if (opcode == EEH_OPT_ENABLE) {
+		addr.buid = info->option.buid;
+		addr.bdn  = (info->option.pe_addr >> 8) & 0xFFFF;
+		edev = eeh_vfio_dev_get(&addr);
+		if (!edev) {
+			pr_warn("%s: Cannot locate %llx:%02x:%02x.%01x\n",
+				__func__, addr.buid,
+				(addr.bdn >> 8) & 0xFF,
+				PCI_SLOT(addr.bdn & 0xFF),
+				PCI_FUNC(addr.bdn & 0xFF));
+			ret = 7;
+			goto out;
+		}
+		phb = edev->phb->private_data;
+	} else {
+		addr.buid    = info->option.buid;
+		addr.pe_addr = info->option.pe_addr;
+		pe = eeh_vfio_pe_get(&addr);
+		if (!pe) {
+			pr_warn("%s: Cannot find PE %llx:%x\n",
+				__func__, addr.buid, addr.pe_addr);
+			ret = 7;
+			goto out;
+		}
+		phb = pe->phb->private_data;
+	}
+
+	/* Insure that the EEH stuff has been initialized */
+	if (!(phb->flags & PNV_PHB_FLAG_EEH)) {
+		pr_warn("%s: EEH disabled on PHB#%d\n",
+			__func__, phb->hose->global_number);
+		ret = 7;
+		goto out;
+	}
+
+	/*
+	 * The EEH functionality has been enabled on all PEs
+	 * by default. So just return success. The same situation
+	 * would be applied while we disable EEH functionality.
+	 * However, the guest isn't expected to disable that
+	 * at all.
+	 */
+	if (opcode == EEH_OPT_DISABLE ||
+	    opcode == EEH_OPT_ENABLE) {
+		ret = 0;
+		goto out;
+	}
+
+	/*
+	 * Call into the IODA dependent backend in order
+	 * to enable DMA or MMIO for the indicated PE.
+	 */
+	if (phb->eeh_ops && phb->eeh_ops->set_option) {
+		if (phb->eeh_ops->set_option(pe, opcode)) {
+			pr_warn("%s: Failure from backend\n", __func__);
+			ret = 1;
+		}
+	} else {
+		pr_warn("%s: Unsupported request\n", __func__);
+		ret = 7;
+	}
+
+out:
+	return ret;
+}
+
+static int powernv_eeh_vfio_get_addr(struct vfio_eeh_info *info)
+{
+	struct pnv_phb *phb;
+	struct eeh_dev *edev;
+	struct eeh_vfio_pci_addr addr;
+	int opcode = info->addr.option;
+	int ret = 0;
+
+	/* Check opcode */
+	if (opcode != 0 && opcode != 1) {
+		pr_warn("%s: opcode %d out of range (0, 1)\n",
+			__func__, opcode);
+		ret = 3;
+		goto out;
+	}
+
+	/* Find EEH device */
+	addr.buid = info->addr.buid;
+	addr.bdn  = (info->addr.bdn >> 8 ) & 0xFFFF;
+	edev = eeh_vfio_dev_get(&addr);
+	if (!edev) {
+		pr_warn("%s: Cannot locate %llx:%02x:%02x.%01x\n",
+			__func__, addr.buid,
+			(addr.bdn >> 8) & 0xFF,
+			PCI_SLOT(addr.bdn & 0xFF),
+			PCI_FUNC(addr.bdn & 0xFF));
+		ret = 7;
+		goto out;
+	}
+	phb = edev->phb->private_data;
+
+	/* EEH enabled ? */
+	if (!(phb->flags & PNV_PHB_FLAG_EEH)) {
+		pr_warn("%s: EEH disabled on PHB#%d\n",
+			__func__, phb->hose->global_number);
+		ret = 3;
+		goto out;
+	}
+
+	/* EEH device passed ? */
+	if (!eeh_dev_passed(edev)) {
+		pr_warn("%s: EEH dev %llx:%02x:%02x.%01x owned by host\n",
+			__func__, addr.buid,
+			(addr.bdn >> 8) & 0xFF,
+			PCI_SLOT(addr.bdn & 0xFF),
+			PCI_FUNC(addr.bdn & 0xFF));
+		ret = 3;
+		goto out;
+	}
+
+	/*
+	 * Fill result according to opcode. We don't differentiate
+	 * PCI bus and device sensitive PE here.
+	 */
+	if (opcode == 0)
+		info->addr.ret = edev->pe->gaddr.pe_addr;
+	else
+		info->addr.ret = 1;
+out:
+	return ret;
+}
+
+static int powernv_eeh_vfio_get_state(struct vfio_eeh_info *info)
+{
+	struct pnv_phb *phb;
+	struct eeh_pe *pe;
+	struct eeh_vfio_pci_addr addr;
+	int result, ret = 0;
+
+	/* Locate the PE */
+	addr.buid    = info->state.buid;
+	addr.pe_addr = info->state.pe_addr;
+	pe = eeh_vfio_pe_get(&addr);
+	if (!pe) {
+		pr_warn("%s: Cannot locate %llx:%x\n",
+			__func__, addr.buid, addr.pe_addr);
+		ret = 3;
+		goto out;
+	}
+	phb = pe->phb->private_data;
+
+	/* EEH enabled ? */
+	if (!(phb->flags & PNV_PHB_FLAG_EEH)) {
+		pr_warn("%s: EEH disabled on PHB#%d\n",
+			__func__, phb->hose->global_number);
+		ret = 3;
+		goto out;
+	}
+
+	/* Call to the IOC dependent function */
+	if (phb->eeh_ops && phb->eeh_ops->get_state) {
+		result = phb->eeh_ops->get_state(pe);
+
+		if (!(result & EEH_STATE_RESET_ACTIVE) &&
+		     (result & EEH_STATE_DMA_ENABLED) &&
+		     (result & EEH_STATE_MMIO_ENABLED))
+			info->state.state = 0;
+		else if (result & EEH_STATE_RESET_ACTIVE)
+			info->state.state = 1;
+		else if (!(result & EEH_STATE_RESET_ACTIVE) &&
+			 !(result & EEH_STATE_DMA_ENABLED) &&
+			 !(result & EEH_STATE_MMIO_ENABLED))
+			info->state.state = 2;
+		else if (!(result & EEH_STATE_RESET_ACTIVE) &&
+			 (result & EEH_STATE_DMA_ENABLED) &&
+			 !(result & EEH_STATE_MMIO_ENABLED))
+			info->state.state = 4;
+		else
+			info->state.state = 5;
+
+		ret = 0;
+	} else {
+		pr_warn("%s: Unsupported request\n", __func__);
+		ret = 3;
+	}
+
+out:
+	return ret;
+}
+
+static int powernv_eeh_vfio_pe_reset(struct vfio_eeh_info *info)
+{
+	struct pnv_phb *phb;
+	struct eeh_pe *pe;
+	struct eeh_vfio_pci_addr addr;
+	int opcode = info->reset.option;
+	int ret = 0;
+
+	/* Check opcode */
+	if (opcode != EEH_RESET_DEACTIVATE &&
+	    opcode != EEH_RESET_HOT &&
+	    opcode != EEH_RESET_FUNDAMENTAL) {
+		pr_warn("%s: Unsupported opcode %d\n", __func__, opcode);
+		ret = 3;
+		goto out;
+	}
+
+	/* Locate the PE */
+	addr.buid    = info->reset.buid;
+	addr.pe_addr = info->reset.pe_addr;
+	pe = eeh_vfio_pe_get(&addr);
+	if (!pe) {
+		pr_warn("%s: Cannot locate %llx:%x\n",
+			__func__, addr.buid, addr.pe_addr);
+		ret = 3;
+		goto out;
+	}
+	phb = pe->phb->private_data;
+
+	/* EEH enabled ? */
+	if (!(phb->flags & PNV_PHB_FLAG_EEH)) {
+		pr_warn("%s: EEH disabled on PHB#%d\n",
+			__func__, phb->hose->global_number);
+		ret = 3;
+		goto out;
+	}
+
+	/* Call into the IODA dependent backend to do the reset */
+	if (!phb->eeh_ops ||
+	    !phb->eeh_ops->set_option ||
+	    !phb->eeh_ops->reset) {
+		pr_warn("%s: Unsupported request\n", __func__);
+		ret = 7;
+	} else {
+		/*
+		 * The frozen PE might be caused by the mechanism called
+		 * PAPR error injection, which is supposed to be one-shot
+		 * without "sticky" bit as being stated by the spec. But
+		 * the reality isn't that, at least on P7IOC. So we have
+		 * to clear that to avoid recrusive error, which fails the
+		 * recovery eventually.
+		 */
+		if (opcode == EEH_RESET_DEACTIVATE)
+			opal_pci_reset(phb->opal_id,
+				       OPAL_PHB_ERROR,
+				       OPAL_ASSERT_RESET);
+
+		if (phb->eeh_ops->reset(pe, opcode)) {
+			pr_warn("%s: Failure from backend\n", __func__);
+			ret = 1;
+			goto out;
+		}
+
+		/*
+		 * The PE is still in frozen state and we need clear that.
+		 * It's good to clear frozen state after deassert to avoid
+		 * messy IO access during reset, which might cause recrusive
+		 * frozen PE.
+		 */
+		if (opcode == EEH_RESET_DEACTIVATE) {
+			phb->eeh_ops->set_option(pe, EEH_OPT_THAW_MMIO);
+			phb->eeh_ops->set_option(pe, EEH_OPT_THAW_DMA);
+		}
+	}
+
+out:
+	return ret;
+}
+
+static int powernv_eeh_vfio_pe_config(struct vfio_eeh_info *info)
+{
+	struct pnv_phb *phb;
+	struct eeh_pe *pe;
+	struct eeh_vfio_pci_addr addr;
+	int ret = 0;
+
+	/* Locate the PE */
+	addr.buid    = info->config.buid;
+	addr.pe_addr = info->config.pe_addr;
+	pe = eeh_vfio_pe_get(&addr);
+	if (!pe) {
+		pr_warn("%s: Cannot locate %llx:%x\n",
+			__func__, addr.buid, addr.pe_addr);
+		ret = 3;
+		goto out;
+	}
+	phb = pe->phb->private_data;
+
+	/* EEH enabled ? */
+	if (!(phb->flags & PNV_PHB_FLAG_EEH)) {
+		pr_warn("%s: EEH disabled on PHB#%d\n",
+			__func__, phb->hose->global_number);
+		ret = 3;
+		goto out;
+        }
+
+	/*
+	 * The access to PCI config space on VFIO device has some
+	 * limitations. Part of PCI config space, including BAR
+	 * registers are not readable and writable. So the guest
+	 * should have stale values for those registers and we have
+	 * to restore them in host side.
+	 */
+	eeh_pe_restore_bars(pe);
+out:
+	return ret;
+}
+
+void eeh_vfio_release(struct iommu_table *tbl)
+{
+	struct pnv_ioda_pe *pnv_pe = container_of(tbl, struct pnv_ioda_pe,
+						  tce32_table);
+	struct pnv_phb *phb = pnv_pe->phb;
+	struct eeh_pe *phb_pe, *pe;
+	struct eeh_dev dev, *edev, *tmp;
+
+	/* Find PHB PE */
+	phb_pe = eeh_phb_pe_get(phb->hose);
+	if (unlikely(!phb_pe)) {
+		pr_warn("%s: Cannot find PHB#%d PE\n",
+			__func__, phb->hose->global_number);
+		return;
+	}
+
+	/* Find PE */
+	memset(&dev, 0, sizeof(struct eeh_dev));
+	dev.phb = phb->hose;
+	dev.pe_config_addr = pnv_pe->pe_number;
+	pe = eeh_pe_get(&dev);
+	if (unlikely(!pe)) {
+		pr_warn("%s: Cannot find PE instance for PHB#%d-PE#%d\n",
+			__func__, phb->hose->global_number,
+			pnv_pe->pe_number);
+		return;
+	}
+
+	/* Release it to host */
+	if (!eeh_pe_passed(pe))
+		return;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		if (!eeh_dev_passed(edev))
+			continue;
+
+		memset(&edev->gaddr, 0, sizeof(edev->gaddr));
+		eeh_dev_set_passed(edev, false);
+	}
+
+	memset(&pe->gaddr, 0, sizeof(pe->gaddr));
+	eeh_pe_set_passed(pe, false);
+}
+EXPORT_SYMBOL(eeh_vfio_release);
+
+int eeh_vfio_ioctl(unsigned long arg)
+{
+	struct vfio_eeh_info info;
+	int ret = -EINVAL;
+
+	/* Copy over user argument */
+	if (copy_from_user(&info, (void __user *)arg, sizeof(info))) {
+		pr_warn("%s: Cannot copy user argument 0x%lx\n",
+			__func__, arg);
+		return -EFAULT;
+	}
+
+	/* Sanity check */
+	if (info.argsz != sizeof(info)) {
+		pr_warn("%s: Invalid argument size (%d, %ld)\n",
+			__func__, info.argsz, sizeof(info));
+		return -EINVAL;
+	}
+
+	/* Route according to operation */
+	switch (info.op) {
+	case vfio_eeh_ops_map:
+		ret = powernv_eeh_vfio_map(&info);
+		break;
+	case vfio_eeh_ops_unmap:
+		ret = powernv_eeh_vfio_unmap(&info);
+		break;
+	case vfio_eeh_ops_set_option:
+		ret = powernv_eeh_vfio_set_option(&info);
+		break;
+	case vfio_eeh_ops_get_addr:
+		ret = powernv_eeh_vfio_get_addr(&info);
+		break;
+	case vfio_eeh_ops_get_state:
+		ret = powernv_eeh_vfio_get_state(&info);
+		break;
+	case vfio_eeh_ops_pe_reset:
+		ret = powernv_eeh_vfio_pe_reset(&info);
+		break;
+	case vfio_eeh_ops_pe_config:
+		ret = powernv_eeh_vfio_pe_config(&info);
+		break;
+	default:
+		pr_info("%s: Cannot handle op#%d (%d, %d)\n",
+			__func__, info.op, vfio_eeh_ops_min,
+			vfio_eeh_ops_max);
+	}
+
+	/* Copy data back */
+	if (!ret && copy_to_user((void __user *)arg, &info, sizeof(info))) {
+		pr_warn("%s: Cannot copy to user 0x%lx\n",
+			__func__, arg);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(eeh_vfio_ioctl);
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index a84788b..c45dece 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -26,6 +26,11 @@
 #define DRIVER_AUTHOR   "aik@ozlabs.ru"
 #define DRIVER_DESC     "VFIO IOMMU SPAPR TCE"
 
+#ifdef CONFIG_VFIO_EEH
+extern void eeh_vfio_release(struct iommu_table *tbl);
+extern int eeh_vfio_ioctl(unsigned long arg);
+#endif
+
 static void tce_iommu_detach_group(void *iommu_data,
 		struct iommu_group *iommu_group);
 
@@ -283,6 +288,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 		tce_iommu_disable(container);
 		mutex_unlock(&container->lock);
 		return 0;
+#ifdef CONFIG_VFIO_EEH
+	case VFIO_EEH_INFO:
+		return eeh_vfio_ioctl(arg);
+#endif
 	}
 
 	return -ENOTTY;
@@ -342,6 +351,9 @@ static void tce_iommu_detach_group(void *iommu_data,
 		/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
 				iommu_group_id(iommu_group), iommu_group); */
 		container->tbl = NULL;
+#ifdef CONFIG_VFIO_EEH
+		eeh_vfio_release(tbl);
+#endif
 		iommu_release_ownership(tbl);
 	}
 	mutex_unlock(&container->lock);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index cb9023d..4e1c7f9 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -455,6 +455,67 @@ struct vfio_iommu_spapr_tce_info {
 
 #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
 
+/*
+ * The VFIO EEH info struct provides way to support EEH functionality
+ * for PCI device that is passed from host to guest via VFIO.
+ */
+enum {
+	vfio_eeh_ops_min	= 0,
+	vfio_eeh_ops_map	= 0,
+	vfio_eeh_ops_unmap	= 1,
+	vfio_eeh_ops_set_option	= 2,
+	vfio_eeh_ops_get_addr	= 3,
+	vfio_eeh_ops_get_state	= 4,
+	vfio_eeh_ops_pe_reset	= 5,
+	vfio_eeh_ops_pe_config	= 6,
+	vfio_eeh_ops_max	= 6
+};
+
+struct vfio_eeh_info {
+	__u32 argsz;
+	__u32 op;
+
+	union {
+		struct vfio_eeh_map {
+			__u32 domain;
+			__u16 bdn;
+			__u64 gbuid;
+			__u16 gbdn;
+		} map;
+		struct vfio_eeh_unmap {
+			__u64 buid;
+			__u16 bdn;
+		} unmap;
+		struct vfio_eeh_set_option {
+			__u64 buid;
+			__u32 pe_addr;
+			__u32 option;
+		} option;
+		struct vfio_eeh_pe_addr {
+			__u64 buid;
+			__u32 bdn;
+			__u32 option;
+			__u32 ret;
+		} addr;
+		struct vfio_eeh_state {
+			__u64 buid;
+			__u32 pe_addr;
+			__u32 state;
+                } state;
+		struct vfio_eeh_reset {
+			__u64 buid;
+			__u32 pe_addr;
+			__u32 option;
+		} reset;
+		struct vfio_eeh_config {
+			__u64 buid;
+			__u32 pe_addr;
+		} config;
+	};
+};
+
+#define VFIO_EEH_INFO	_IO(VFIO_TYPE, VFIO_BASE + 17)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
1.8.3.2
