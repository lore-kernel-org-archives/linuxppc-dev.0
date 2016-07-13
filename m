Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqWrx108qzDqFd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:08 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DL9iQO016300
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:07 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2455fde8nw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:06 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 14 Jul 2016 07:18:03 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E3F562BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:01 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DLI1LO19005526
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:01 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DLI1OE015835
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:01 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 07/15] powerpc/powernv: Add support for the cxl kernel api on
 the real phb
Date: Thu, 14 Jul 2016 07:17:06 +1000
In-Reply-To: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
References: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468444634-1866-8-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This adds support for the peer model of the cxl kernel api to the
PowerNV PHB, in which physical function 0 represents the cxl function on
the card (an XSL in the case of the CX4), which other physical functions
will use for memory access and interrupt services. It is referred to as
the peer model as these functions are peers of one another, as opposed
to the Virtual PHB model which forms a hierarchy.

This patch exports APIs to enable the peer mode, check if a PCI device
is attached to a PHB in this mode, and to set and get the peer AFU for
this mode.

The cxl driver will enable this mode for supported cards by calling
pnv_cxl_enable_phb_kernel_api(). This will set a flag in the PHB to note
that this mode is enabled, and switch out it's controller_ops for the
cxl version.

The cxl version of the controller_ops struct implements it's own
versions of the enable_device_hook and release_device to handle
refcounting on the peer AFU and to allocate a default context for the
device.

Once enabled, the cxl kernel API may not be disabled on a PHB. Currently
there is no safe way to disable cxl mode short of a reboot, so until
that changes there is no reason to support the disable path.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

V1->V2:
	- Add an explanation of the peer model to the commit message,
	  and a comment above the pnv_cxl_enable_device_hook function.
V2->V3
	Addressed comments from Andrew Donnellan:
	- Fix typo in comment
	- Changed two exported symbols to EXPORT_SYMBOL_GPL
	- Undid change to remove static from pnv_pci_release_device and
	  pci_controller_ops and declare them in the header, both of
	  which were left over from an earlier cut.
---
 arch/powerpc/include/asm/pnv-pci.h        |   7 ++
 arch/powerpc/platforms/powernv/pci-cxl.c  | 120 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |  18 ++++-
 arch/powerpc/platforms/powernv/pci.h      |  14 ++++
 4 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 791db1b..c47097f 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -38,6 +38,13 @@ int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
 			       struct pci_dev *dev, int num);
 void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
 				  struct pci_dev *dev);
+
+/* Support for the cxl kernel api on the real PHB (instead of vPHB) */
+int pnv_cxl_enable_phb_kernel_api(struct pci_controller *hose, bool enable);
+bool pnv_pci_on_cxl_phb(struct pci_dev *dev);
+struct cxl_afu *pnv_cxl_phb_to_afu(struct pci_controller *hose);
+void pnv_cxl_phb_set_peer_afu(struct pci_dev *dev, struct cxl_afu *afu);
+
 #endif
 
 #endif
diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
index e0eeb00..831bbfb 100644
--- a/arch/powerpc/platforms/powernv/pci-cxl.c
+++ b/arch/powerpc/platforms/powernv/pci-cxl.c
@@ -7,8 +7,11 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/module.h>
+#include <asm/pci-bridge.h>
 #include <asm/pnv-pci.h>
 #include <asm/opal.h>
+#include <misc/cxl.h>
 
 #include "pci.h"
 
@@ -161,3 +164,120 @@ int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 	return 0;
 }
 EXPORT_SYMBOL(pnv_cxl_ioda_msi_setup);
+
+/*
+ * Sets flags and switches the controller ops to enable the cxl kernel api.
+ * Originally the cxl kernel API operated on a virtual PHB, but certain cards
+ * such as the Mellanox CX4 use a peer model instead and for these cards the
+ * cxl kernel api will operate on the real PHB.
+ */
+int pnv_cxl_enable_phb_kernel_api(struct pci_controller *hose, bool enable)
+{
+	struct pnv_phb *phb = hose->private_data;
+	struct module *cxl_module;
+
+	if (!enable) {
+		/*
+		 * Once cxl mode is enabled on the PHB, there is currently no
+		 * known safe method to disable it again, and trying risks a
+		 * checkstop. If we can find a way to safely disable cxl mode
+		 * in the future we can revisit this, but for now the only sane
+		 * thing to do is to refuse to disable cxl mode:
+		 */
+		return -EPERM;
+	}
+
+	/*
+	 * Hold a reference to the cxl module since several PHB operations now
+	 * depend on it, and it would be insane to allow it to be removed so
+	 * long as we are in this mode (and since we can't safely disable this
+	 * mode once enabled...).
+	 */
+	mutex_lock(&module_mutex);
+	cxl_module = find_module("cxl");
+	if (cxl_module)
+		__module_get(cxl_module);
+	mutex_unlock(&module_mutex);
+	if (!cxl_module)
+		return -ENODEV;
+
+	phb->flags |= PNV_PHB_FLAG_CXL;
+	hose->controller_ops = pnv_cxl_cx4_ioda_controller_ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_cxl_enable_phb_kernel_api);
+
+bool pnv_pci_on_cxl_phb(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	return !!(phb->flags & PNV_PHB_FLAG_CXL);
+}
+EXPORT_SYMBOL_GPL(pnv_pci_on_cxl_phb);
+
+struct cxl_afu *pnv_cxl_phb_to_afu(struct pci_controller *hose)
+{
+	struct pnv_phb *phb = hose->private_data;
+
+	return (struct cxl_afu *)phb->cxl_afu;
+}
+EXPORT_SYMBOL_GPL(pnv_cxl_phb_to_afu);
+
+void pnv_cxl_phb_set_peer_afu(struct pci_dev *dev, struct cxl_afu *afu)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	phb->cxl_afu = afu;
+}
+EXPORT_SYMBOL_GPL(pnv_cxl_phb_set_peer_afu);
+
+/*
+ * In the peer cxl model, the XSL/PSL is physical function 0, and will be used
+ * by other functions on the device for memory access and interrupts. When the
+ * other functions are enabled we explicitly take a reference on the cxl
+ * function since they will use it, and allocate a default context associated
+ * with that function just like the vPHB model of the cxl kernel API.
+ */
+bool pnv_cxl_enable_device_hook(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct cxl_afu *afu = phb->cxl_afu;
+
+	if (!pnv_pci_enable_device_hook(dev))
+		return false;
+
+
+	/* No special handling for the cxl function, which is always PF 0 */
+	if (PCI_FUNC(dev->devfn) == 0)
+		return true;
+
+	if (!afu) {
+		dev_WARN(&dev->dev, "Attempted to enable function > 0 on CXL PHB without a peer AFU\n");
+		return false;
+	}
+
+	dev_info(&dev->dev, "Enabling function on CXL enabled PHB with peer AFU\n");
+
+	/* Make sure the peer AFU can't go away while this device is active */
+	cxl_afu_get(afu);
+
+	return cxl_pci_associate_default_context(dev, afu);
+}
+
+void pnv_cxl_disable_device(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct cxl_afu *afu = phb->cxl_afu;
+
+	/* No special handling for cxl function: */
+	if (PCI_FUNC(dev->devfn) == 0)
+		return;
+
+	cxl_pci_disable_device(dev);
+	cxl_afu_put(afu);
+}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index e0d8103..104c040 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3222,7 +3222,7 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 /* Prevent enabling devices for which we couldn't properly
  * assign a PE
  */
-static bool pnv_pci_enable_device_hook(struct pci_dev *dev)
+bool pnv_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -3461,6 +3461,22 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
+#ifdef CONFIG_CXL_BASE
+const struct pci_controller_ops pnv_cxl_cx4_ioda_controller_ops = {
+	.dma_dev_setup		= pnv_pci_dma_dev_setup,
+	.dma_bus_setup		= pnv_pci_dma_bus_setup,
+	.enable_device_hook	= pnv_cxl_enable_device_hook,
+	.disable_device		= pnv_cxl_disable_device,
+	.release_device		= pnv_pci_release_device,
+	.window_alignment	= pnv_pci_window_alignment,
+	.setup_bridge		= pnv_pci_setup_bridge,
+	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
+	.dma_set_mask		= pnv_pci_ioda_dma_set_mask,
+	.dma_get_required_mask	= pnv_pci_ioda_dma_get_required_mask,
+	.shutdown		= pnv_pci_ioda_shutdown,
+};
+#endif
+
 static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 					 u64 hub_id, int ioda_type)
 {
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 49c2997..20c9a6b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -76,6 +76,7 @@ struct pnv_ioda_pe {
 };
 
 #define PNV_PHB_FLAG_EEH	(1 << 0)
+#define PNV_PHB_FLAG_CXL	(1 << 1) /* Real PHB supporting the cxl kernel API */
 
 struct pnv_phb {
 	struct pci_controller	*hose;
@@ -177,6 +178,9 @@ struct pnv_phb {
 		struct OpalIoP7IOCErrorData 	hub_diag;
 	} diag;
 
+#ifdef CONFIG_CXL_BASE
+	struct cxl_afu *cxl_afu;
+#endif
 };
 
 extern struct pci_ops pnv_pci_ops;
@@ -218,6 +222,7 @@ extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
 extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
 extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
+extern bool pnv_pci_enable_device_hook(struct pci_dev *dev);
 
 extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...);
@@ -238,4 +243,13 @@ extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
 extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
 extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
 
+
+/* cxl functions */
+extern bool pnv_cxl_enable_device_hook(struct pci_dev *dev);
+extern void pnv_cxl_disable_device(struct pci_dev *dev);
+
+
+/* phb ops (cxl switches these when enabling the kernel api on the phb) */
+extern const struct pci_controller_ops pnv_cxl_cx4_ioda_controller_ops;
+
 #endif /* __POWERNV_PCI_H */
-- 
2.8.1
