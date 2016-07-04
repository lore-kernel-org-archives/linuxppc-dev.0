Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjnkm1yVyzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:22:56 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u64DIeX8111648
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 09:22:54 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x7xefran-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 09:22:54 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 4 Jul 2016 23:22:51 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B0EFC2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:22:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u64DMn0U2228588
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:22:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u64DMmEC009377
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:22:49 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 09/14] cxl: Add preliminary workaround for CX4 interrupt
 limitation
Date: Mon,  4 Jul 2016 23:22:07 +1000
In-Reply-To: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1467638532-9250-10-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The Mellanox CX4 has a hardware limitation where only 4 bits of the
AFU interrupt number can be passed to the XSL when sending an interrupt,
limiting it to only 15 interrupts per context (AFU interrupt number 0 is
invalid).

In order to overcome this, we will allocate additional contexts linked
to the default context as extra address space for the extra interrupts -
this will be implemented in the next patch.

This patch adds the preliminary support to allow this, by way of adding
a linked list in the context structure that we use to keep track of the
contexts dedicated to interrupts, and an API to simultaneously iterate
over the related context structures, AFU interrupt numbers and hardware
interrupt numbers. The point of using a single API to iterate these is
to hide some of the details of the iteration from external code, and to
reduce the number of APIs that need to be exported via base.c to allow
built in code to call.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/api.c     | 15 +++++++++++++++
 drivers/misc/cxl/base.c    | 17 +++++++++++++++++
 drivers/misc/cxl/context.c |  1 +
 drivers/misc/cxl/cxl.h     | 10 ++++++++++
 drivers/misc/cxl/main.c    |  1 +
 include/misc/cxl.h         |  9 +++++++++
 6 files changed, 53 insertions(+)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 1e2c0d9..f02a859 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -97,6 +97,21 @@ static irq_hw_number_t cxl_find_afu_irq(struct cxl_context *ctx, int num)
 	return 0;
 }
 
+int _cxl_next_msi_hwirq(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq)
+{
+	if (*ctx == NULL || *afu_irq == 0) {
+		*afu_irq = 1;
+		*ctx = cxl_get_context(pdev);
+	} else {
+		(*afu_irq)++;
+		if (*afu_irq > cxl_get_max_irqs_per_process(pdev)) {
+			*ctx = list_next_entry(*ctx, extra_irq_contexts);
+			*afu_irq = 1;
+		}
+	}
+	return cxl_find_afu_irq(*ctx, *afu_irq);
+}
+/* Exported via cxl_base */
 
 int cxl_set_priv(struct cxl_context *ctx, void *priv)
 {
diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index af20b34..0f89ea9 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -141,6 +141,23 @@ void cxl_pci_disable_device(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(cxl_pci_disable_device);
 
+int cxl_next_msi_hwirq(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq)
+{
+	int ret;
+	struct cxl_calls *calls;
+
+	calls = cxl_calls_get();
+	if (!calls)
+		return -EBUSY;
+
+	ret = calls->cxl_next_msi_hwirq(pdev, ctx, afu_irq);
+
+	cxl_calls_put(calls);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cxl_next_msi_hwirq);
+
 static int __init cxl_base_init(void)
 {
 	struct device_node *np = NULL;
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index edbb99e..2616cddb 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -68,6 +68,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 	ctx->pending_afu_err = false;
 
 	INIT_LIST_HEAD(&ctx->irq_names);
+	INIT_LIST_HEAD(&ctx->extra_irq_contexts);
 
 	/*
 	 * When we have to destroy all contexts in cxl_context_detach_all() we
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index c94b54f..67464c9 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -525,6 +525,14 @@ struct cxl_context {
 	atomic_t afu_driver_events;
 
 	struct rcu_head rcu;
+
+	/*
+	 * Only used when more interrupts are allocated via
+	 * pci_enable_msix_range than are supported in the default context, to
+	 * use additional contexts to overcome the limitation. i.e. Mellanox
+	 * CX4 only:
+	 */
+	struct list_head extra_irq_contexts;
 };
 
 struct cxl_service_layer_ops {
@@ -710,11 +718,13 @@ ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
 /* Internal functions wrapped in cxl_base to allow PHB to call them */
 bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu);
 void _cxl_pci_disable_device(struct pci_dev *dev);
+int _cxl_next_msi_hwirq(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq);
 
 struct cxl_calls {
 	void (*cxl_slbia)(struct mm_struct *mm);
 	bool (*cxl_pci_associate_default_context)(struct pci_dev *dev, struct cxl_afu *afu);
 	void (*cxl_pci_disable_device)(struct pci_dev *dev);
+	int (*cxl_next_msi_hwirq)(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq);
 
 	struct module *owner;
 };
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index 4e5474b..66fac71 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -112,6 +112,7 @@ static struct cxl_calls cxl_calls = {
 	.cxl_slbia = cxl_slbia_core,
 	.cxl_pci_associate_default_context = _cxl_pci_associate_default_context,
 	.cxl_pci_disable_device = _cxl_pci_disable_device,
+	.cxl_next_msi_hwirq = _cxl_next_msi_hwirq,
 	.owner = THIS_MODULE,
 };
 
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index fc07ed4..ed81a17 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -178,6 +178,15 @@ int cxl_set_max_irqs_per_process(struct pci_dev *dev, int irqs);
 int cxl_get_max_irqs_per_process(struct pci_dev *dev);
 
 /*
+ * Use to simultaneously iterate over hardware interrupt numbers, contexts and
+ * afu interrupt numbers allocated for the device via pci_enable_msix_range and
+ * is a useful convinience function when working with hardware that has
+ * limitations on the number of interrupts per process. *ctx and *afu_irq
+ * should be NULL and 0 to start the iteration.
+ */
+int cxl_next_msi_hwirq(struct pci_dev *pdev, struct cxl_context **ctx, int *afu_irq);
+
+/*
  * These calls allow drivers to create their own file descriptors and make them
  * identical to the cxl file descriptor user API. An example use case:
  *
-- 
2.8.1
