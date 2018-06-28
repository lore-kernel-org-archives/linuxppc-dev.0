Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Gb4j42FbzF1Q4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 20:05:25 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5SA3ucR051802
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 06:05:23 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jvvfwucs6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 06:05:23 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Thu, 28 Jun 2018 11:05:20 +0100
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: alastair@au1.ibm.com, andrew.donnellan@au1.ibm.com, vaibhav@linux.ibm.com,
 clombard@linux.ibm.com, felix@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
Subject: [PATCH v2 03/10] Revert "cxl: Add preliminary workaround for CX4
 interrupt limitation"
Date: Thu, 28 Jun 2018 12:05:02 +0200
In-Reply-To: <20180628100509.17413-1-fbarrat@linux.ibm.com>
References: <20180628100509.17413-1-fbarrat@linux.ibm.com>
Message-Id: <20180628100509.17413-4-fbarrat@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

Remove abandonned capi support for the Mellanox CX4.

This reverts commit cbce0917e2e47d4bf5aa3b5fd6b1247f33e1a126.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/cxl/api.c     | 15 ---------------
 drivers/misc/cxl/base.c    | 17 -----------------
 drivers/misc/cxl/context.c |  1 -
 drivers/misc/cxl/cxl.h     | 10 ----------
 drivers/misc/cxl/main.c    |  1 -
 include/misc/cxl.h         | 20 --------------------
 6 files changed, 64 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 2e5862b7a074..34ba67bc41bd 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -181,21 +181,6 @@ static irq_hw_number_t cxl_find_afu_irq(struct cxl_context *ctx, int num)
 	return 0;
 }
 
-int _cxl_next_msi_hwirq(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq)
-{
-	if (*ctx == NULL || *afu_irq == 0) {
-		*afu_irq = 1;
-		*ctx = cxl_get_context(pdev);
-	} else {
-		(*afu_irq)++;
-		if (*afu_irq > cxl_get_max_irqs_per_process(pdev)) {
-			*ctx = list_next_entry(*ctx, extra_irq_contexts);
-			*afu_irq = 1;
-		}
-	}
-	return cxl_find_afu_irq(*ctx, *afu_irq);
-}
-/* Exported via cxl_base */
 
 int cxl_set_priv(struct cxl_context *ctx, void *priv)
 {
diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index fe90f895bb10..e1e80cb99ad9 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -141,23 +141,6 @@ void cxl_pci_disable_device(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(cxl_pci_disable_device);
 
-int cxl_next_msi_hwirq(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq)
-{
-	int ret;
-	struct cxl_calls *calls;
-
-	calls = cxl_calls_get();
-	if (!calls)
-		return -EBUSY;
-
-	ret = calls->cxl_next_msi_hwirq(pdev, ctx, afu_irq);
-
-	cxl_calls_put(calls);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(cxl_next_msi_hwirq);
-
 static int __init cxl_base_init(void)
 {
 	struct device_node *np;
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index c6ec872800a2..0355d42d367f 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -74,7 +74,6 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
 	ctx->pending_afu_err = false;
 
 	INIT_LIST_HEAD(&ctx->irq_names);
-	INIT_LIST_HEAD(&ctx->extra_irq_contexts);
 
 	/*
 	 * When we have to destroy all contexts in cxl_context_detach_all() we
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 9688fe8b4d80..d95c2c98f2ab 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -623,14 +623,6 @@ struct cxl_context {
 
 	struct rcu_head rcu;
 
-	/*
-	 * Only used when more interrupts are allocated via
-	 * pci_enable_msix_range than are supported in the default context, to
-	 * use additional contexts to overcome the limitation. i.e. Mellanox
-	 * CX4 only:
-	 */
-	struct list_head extra_irq_contexts;
-
 	struct mm_struct *mm;
 
 	u16 tidr;
@@ -878,13 +870,11 @@ ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
 /* Internal functions wrapped in cxl_base to allow PHB to call them */
 bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu);
 void _cxl_pci_disable_device(struct pci_dev *dev);
-int _cxl_next_msi_hwirq(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq);
 
 struct cxl_calls {
 	void (*cxl_slbia)(struct mm_struct *mm);
 	bool (*cxl_pci_associate_default_context)(struct pci_dev *dev, struct cxl_afu *afu);
 	void (*cxl_pci_disable_device)(struct pci_dev *dev);
-	int (*cxl_next_msi_hwirq)(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq);
 
 	struct module *owner;
 };
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index 59a904efd104..a7e83624034b 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -106,7 +106,6 @@ static struct cxl_calls cxl_calls = {
 	.cxl_slbia = cxl_slbia_core,
 	.cxl_pci_associate_default_context = _cxl_pci_associate_default_context,
 	.cxl_pci_disable_device = _cxl_pci_disable_device,
-	.cxl_next_msi_hwirq = _cxl_next_msi_hwirq,
 	.owner = THIS_MODULE,
 };
 
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 82cc6ffafe2d..6a3711a2e217 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -183,26 +183,6 @@ void cxl_psa_unmap(void __iomem *addr);
 /*  Get the process element for this context */
 int cxl_process_element(struct cxl_context *ctx);
 
-/*
- * Limit the number of interrupts that a single context can allocate via
- * cxl_start_work. If using the api with a real phb, this may be used to
- * request that additional default contexts be created when allocating
- * interrupts via pci_enable_msix_range. These will be set to the same running
- * state as the default context, and if that is running it will reuse the
- * parameters previously passed to cxl_start_context for the default context.
- */
-int cxl_set_max_irqs_per_process(struct pci_dev *dev, int irqs);
-int cxl_get_max_irqs_per_process(struct pci_dev *dev);
-
-/*
- * Use to simultaneously iterate over hardware interrupt numbers, contexts and
- * afu interrupt numbers allocated for the device via pci_enable_msix_range and
- * is a useful convenience function when working with hardware that has
- * limitations on the number of interrupts per process. *ctx and *afu_irq
- * should be NULL and 0 to start the iteration.
- */
-int cxl_next_msi_hwirq(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq);
-
 /*
  * These calls allow drivers to create their own file descriptors and make them
  * identical to the cxl file descriptor user API. An example use case:
-- 
2.17.1
