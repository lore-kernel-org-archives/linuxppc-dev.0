Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjnlQ1wwjzDqpY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:23:30 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u64DIedG069659
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 09:23:28 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23x9rkn067-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 09:23:28 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 4 Jul 2016 23:23:24 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A14E03578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:23:22 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u64DNM3317956874
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:23:22 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u64DNMqn015648
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:23:22 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 10/14] cxl: Add support for interrupts on the Mellanox CX4
Date: Mon,  4 Jul 2016 23:22:08 +1000
In-Reply-To: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1467638532-9250-11-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The Mellanox CX4 in cxl mode uses a hybrid interrupt model, where
interrupts are routed from the networking hardware to the XSL using the
MSIX table, and from there will be transformed back into an MSIX
interrupt using the cxl style interrupts (i.e. using IVTE entries and
ranges to map a PE and AFU interrupt number to an MSIX address).

We want to hide the implementation details of cxl interrupts as much as
possible. To this end, we use a special version of the MSI setup &
teardown routines in the PHB while in cxl mode to allocate the cxl
interrupts and configure the IVTE entries in the process element.

This function does not configure the MSIX table - the CX4 card uses a
custom format in that table and it would not be appropriate to fill that
out in generic code. The rest of the functionality is similar to the
"Full MSI-X mode" described in the CAIA, and this could be easily
extended to support other adapters that use that mode in the future.

The interrupts will be associated with the default context. If the
maximum number of interrupts per context has been limited (e.g. by the
mlx5 driver), it will automatically allocate additional kernel contexts
to associate extra interrupts as required. These contexts will be
started using the same WED that was used to start the default context.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-cxl.c  | 84 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |  4 ++
 arch/powerpc/platforms/powernv/pci.h      |  2 +
 drivers/misc/cxl/api.c                    | 71 ++++++++++++++++++++++++++
 drivers/misc/cxl/base.c                   | 31 ++++++++++++
 drivers/misc/cxl/cxl.h                    |  4 ++
 drivers/misc/cxl/main.c                   |  2 +
 include/misc/cxl-base.h                   |  4 ++
 8 files changed, 202 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
index 2f386f5..1559ca2 100644
--- a/arch/powerpc/platforms/powernv/pci-cxl.c
+++ b/arch/powerpc/platforms/powernv/pci-cxl.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <asm/pci-bridge.h>
 #include <asm/pnv-pci.h>
 #include <asm/opal.h>
@@ -273,3 +274,86 @@ void pnv_cxl_disable_device(struct pci_dev *dev)
 	cxl_pci_disable_device(dev);
 	cxl_afu_put(afu);
 }
+
+/*
+ * This is a special version of pnv_setup_msi_irqs for cards in cxl mode. This
+ * function handles setting up the IVTE entries for the XSL to use.
+ *
+ * We are currently not filling out the MSIX table, since the only currently
+ * supported adapter (CX4) uses a custom MSIX table format in cxl mode and it
+ * is up to their driver to fill that out. In the future we may fill out the
+ * MSIX table (and change the IVTE entries to be an index to the MSIX table)
+ * for adapters implementing the Full MSI-X mode described in the CAIA.
+ */
+int pnv_cxl_cx4_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct msi_desc *entry;
+	struct cxl_context *ctx = NULL;
+	unsigned int virq;
+	int hwirq;
+	int afu_irq = 0;
+	int rc;
+
+	if (WARN_ON(!phb) || !phb->msi_bmp.bitmap)
+		return -ENODEV;
+
+	if (pdev->no_64bit_msi && !phb->msi32_support)
+		return -ENODEV;
+
+	rc = cxl_cx4_setup_msi_irqs(pdev, nvec, type);
+	if (rc)
+		return rc;
+
+	for_each_pci_msi_entry(entry, pdev) {
+		if (!entry->msi_attrib.is_64 && !phb->msi32_support) {
+			pr_warn("%s: Supports only 64-bit MSIs\n",
+				pci_name(pdev));
+			return -ENXIO;
+		}
+
+		hwirq = cxl_next_msi_hwirq(pdev, &ctx, &afu_irq);
+		if (WARN_ON(hwirq < 0))
+			return hwirq;
+
+		virq = irq_create_mapping(NULL, hwirq);
+		if (virq == NO_IRQ) {
+			pr_warn("%s: Failed to map cxl mode MSI to linux irq\n",
+				pci_name(pdev));
+			return -ENOMEM;
+		}
+
+		rc = pnv_cxl_ioda_msi_setup(pdev, hwirq, virq);
+		if (rc) {
+			pr_warn("%s: Failed to setup cxl mode MSI\n", pci_name(pdev));
+			irq_dispose_mapping(virq);
+			return rc;
+		}
+
+		irq_set_msi_desc(virq, entry);
+	}
+
+	return 0;
+}
+
+void pnv_cxl_cx4_teardown_msi_irqs(struct pci_dev *pdev)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct msi_desc *entry;
+	irq_hw_number_t hwirq;
+
+	if (WARN_ON(!phb))
+		return;
+
+	for_each_pci_msi_entry(entry, pdev) {
+		if (entry->irq == NO_IRQ)
+			continue;
+		hwirq = virq_to_hw(entry->irq);
+		irq_set_msi_desc(entry->irq, NULL);
+		irq_dispose_mapping(entry->irq);
+	}
+
+	cxl_cx4_teardown_msi_irqs(pdev);
+}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 467085f..c8f3b5c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3465,6 +3465,10 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 const struct pci_controller_ops pnv_cxl_cx4_ioda_controller_ops = {
 	.dma_dev_setup		= pnv_pci_dma_dev_setup,
 	.dma_bus_setup		= pnv_pci_dma_bus_setup,
+#ifdef CONFIG_PCI_MSI
+	.setup_msi_irqs		= pnv_cxl_cx4_setup_msi_irqs,
+	.teardown_msi_irqs	= pnv_cxl_cx4_teardown_msi_irqs,
+#endif
 	.enable_device_hook	= pnv_cxl_enable_device_hook,
 	.disable_device		= pnv_cxl_disable_device,
 	.release_device		= pnv_pci_release_device,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 4d003dc..4799127 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -248,6 +248,8 @@ extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
 /* cxl functions */
 extern bool pnv_cxl_enable_device_hook(struct pci_dev *dev);
 extern void pnv_cxl_disable_device(struct pci_dev *dev);
+extern int pnv_cxl_cx4_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
+extern void pnv_cxl_cx4_teardown_msi_irqs(struct pci_dev *pdev);
 
 
 /* phb ops (cxl switches these when enabling the kernel api on the phb) */
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index f02a859..f3d34b9 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -14,6 +14,7 @@
 #include <misc/cxl.h>
 #include <linux/fs.h>
 #include <asm/pnv-pci.h>
+#include <linux/msi.h>
 
 #include "cxl.h"
 
@@ -489,3 +490,73 @@ int cxl_get_max_irqs_per_process(struct pci_dev *dev)
 	return afu->irqs_max;
 }
 EXPORT_SYMBOL_GPL(cxl_get_max_irqs_per_process);
+
+/*
+ * This is a special interrupt allocation routine called from the PHB's MSI
+ * setup function. When capi interrupts are allocated in this manner they must
+ * still be associated with a running context, but since the MSI APIs have no
+ * way to specify this we use the default context associated with the device.
+ *
+ * The Mellanox CX4 has a hardware limitation that restricts the maximum AFU
+ * interrupt number, so in order to overcome this their driver informs us of
+ * the restriction by setting the maximum interrupts per context, and we
+ * allocate additional contexts as necessary so that we can keep the AFU
+ * interrupt number within the supported range.
+ */
+int _cxl_cx4_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+{
+	struct cxl_context *ctx, *new_ctx, *default_ctx;
+	int remaining;
+	int rc;
+
+	ctx = default_ctx = cxl_get_context(pdev);
+	if (WARN_ON(!default_ctx))
+		return -ENODEV;
+
+	remaining = nvec;
+	while (remaining > 0) {
+		rc = cxl_allocate_afu_irqs(ctx, min(remaining, ctx->afu->irqs_max));
+		if (rc) {
+			pr_warn("%s: Failed to find enough free MSIs\n", pci_name(pdev));
+			return rc;
+		}
+		remaining -= ctx->afu->irqs_max;
+
+		if (ctx != default_ctx && default_ctx->status == STARTED) {
+			WARN_ON(cxl_start_context(ctx,
+				be64_to_cpu(default_ctx->elem->common.wed),
+				NULL));
+		}
+
+		if (remaining > 0) {
+			new_ctx = cxl_dev_context_init(pdev);
+			if (!new_ctx) {
+				pr_warn("%s: Failed to allocate enough contexts for MSIs\n", pci_name(pdev));
+				return -ENOSPC;
+			}
+			list_add(&new_ctx->extra_irq_contexts, &ctx->extra_irq_contexts);
+			ctx = new_ctx;
+		}
+	}
+
+	return 0;
+}
+/* Exported via cxl_base */
+
+void _cxl_cx4_teardown_msi_irqs(struct pci_dev *pdev)
+{
+	struct cxl_context *ctx, *pos, *tmp;
+
+	ctx = cxl_get_context(pdev);
+	if (WARN_ON(!ctx))
+		return;
+
+	cxl_free_afu_irqs(ctx);
+	list_for_each_entry_safe(pos, tmp, &ctx->extra_irq_contexts, extra_irq_contexts) {
+		cxl_stop_context(pos);
+		cxl_free_afu_irqs(pos);
+		list_del(&pos->extra_irq_contexts);
+		cxl_release_context(pos);
+	}
+}
+/* Exported via cxl_base */
diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index 0f89ea9..5778a60 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -158,6 +158,37 @@ int cxl_next_msi_hwirq(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_
 }
 EXPORT_SYMBOL_GPL(cxl_next_msi_hwirq);
 
+int cxl_cx4_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+{
+	int ret;
+	struct cxl_calls *calls;
+
+	calls = cxl_calls_get();
+	if (!calls)
+		return false;
+
+	ret = calls->cxl_cx4_setup_msi_irqs(pdev, nvec, type);
+
+	cxl_calls_put(calls);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cxl_cx4_setup_msi_irqs);
+
+void cxl_cx4_teardown_msi_irqs(struct pci_dev *pdev)
+{
+	struct cxl_calls *calls;
+
+	calls = cxl_calls_get();
+	if (!calls)
+		return;
+
+	calls->cxl_cx4_teardown_msi_irqs(pdev);
+
+	cxl_calls_put(calls);
+}
+EXPORT_SYMBOL_GPL(cxl_cx4_teardown_msi_irqs);
+
 static int __init cxl_base_init(void)
 {
 	struct device_node *np = NULL;
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 67464c9..078b268 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -719,12 +719,16 @@ ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
 bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu);
 void _cxl_pci_disable_device(struct pci_dev *dev);
 int _cxl_next_msi_hwirq(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq);
+int _cxl_cx4_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
+void _cxl_cx4_teardown_msi_irqs(struct pci_dev *pdev);
 
 struct cxl_calls {
 	void (*cxl_slbia)(struct mm_struct *mm);
 	bool (*cxl_pci_associate_default_context)(struct pci_dev *dev, struct cxl_afu *afu);
 	void (*cxl_pci_disable_device)(struct pci_dev *dev);
 	int (*cxl_next_msi_hwirq)(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq);
+	int (*cxl_cx4_setup_msi_irqs)(struct pci_dev *pdev, int nvec, int type);
+	void (*cxl_cx4_teardown_msi_irqs)(struct pci_dev *pdev);
 
 	struct module *owner;
 };
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index 66fac71..d9be23b2 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -113,6 +113,8 @@ static struct cxl_calls cxl_calls = {
 	.cxl_pci_associate_default_context = _cxl_pci_associate_default_context,
 	.cxl_pci_disable_device = _cxl_pci_disable_device,
 	.cxl_next_msi_hwirq = _cxl_next_msi_hwirq,
+	.cxl_cx4_setup_msi_irqs = _cxl_cx4_setup_msi_irqs,
+	.cxl_cx4_teardown_msi_irqs = _cxl_cx4_teardown_msi_irqs,
 	.owner = THIS_MODULE,
 };
 
diff --git a/include/misc/cxl-base.h b/include/misc/cxl-base.h
index bb7e629..b2ebc91 100644
--- a/include/misc/cxl-base.h
+++ b/include/misc/cxl-base.h
@@ -43,6 +43,8 @@ void cxl_afu_put(struct cxl_afu *afu);
 void cxl_slbia(struct mm_struct *mm);
 bool cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu);
 void cxl_pci_disable_device(struct pci_dev *dev);
+int cxl_cx4_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
+void cxl_cx4_teardown_msi_irqs(struct pci_dev *pdev);
 
 #else /* CONFIG_CXL_BASE */
 
@@ -52,6 +54,8 @@ static inline void cxl_afu_put(struct cxl_afu *afu) {}
 static inline void cxl_slbia(struct mm_struct *mm) {}
 static inline bool cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu) { return false; }
 static inline void cxl_pci_disable_device(struct pci_dev *dev) {}
+static inline int cxl_cx4_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type) { return -ENODEV; }
+static inline void cxl_cx4_teardown_msi_irqs(struct pci_dev *pdev) {}
 
 #endif /* CONFIG_CXL_BASE */
 
-- 
2.8.1
