Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp3Nv2bFJzDr11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:52:15 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6BBnIsM067992
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 07:52:13 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2448qjcqtj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 07:52:13 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 11 Jul 2016 21:52:11 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2F9A53578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:52:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6BBq9Up21561468
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:52:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6BBq887017774
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:52:09 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 05/15] cxl: Allow a default context to be associated with an
 external pci_dev
Date: Mon, 11 Jul 2016 21:50:12 +1000
In-Reply-To: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468237822-26276-6-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The cxl kernel API has a concept of a default context associated with
each PCI device under the virtual PHB. The Mellanox CX4 will also use
the cxl kernel API, but it does not use a virtual PHB - rather, the AFU
appears as a physical function as a peer to the networking functions.

In order to allow the kernel API to work with those networking
functions, we will need to associate a default context with them as
well. To this end, refactor the corresponding code to do this in vphb.c
and export it so that it can be called from the PHB code.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/base.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/misc/cxl/cxl.h  |  6 ++++++
 drivers/misc/cxl/main.c |  2 ++
 drivers/misc/cxl/vphb.c | 37 +++++++++++++++++++++++--------------
 include/misc/cxl-base.h |  6 ++++++
 5 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index d7dcf5b..1c3e737f 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -106,6 +106,41 @@ int cxl_update_properties(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(cxl_update_properties);
 
+/*
+ * API calls into the driver that may be called from the PHB code and must be
+ * built in.
+ */
+bool cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu)
+{
+	bool ret;
+	struct cxl_calls *calls;
+
+	calls = cxl_calls_get();
+	if (!calls)
+		return false;
+
+	ret = calls->cxl_pci_associate_default_context(dev, afu);
+
+	cxl_calls_put(calls);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cxl_pci_associate_default_context);
+
+void cxl_pci_disable_device(struct pci_dev *dev)
+{
+	struct cxl_calls *calls;
+
+	calls = cxl_calls_get();
+	if (!calls)
+		return;
+
+	calls->cxl_pci_disable_device(dev);
+
+	cxl_calls_put(calls);
+}
+EXPORT_SYMBOL_GPL(cxl_pci_disable_device);
+
 static int __init cxl_base_init(void)
 {
 	struct device_node *np = NULL;
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index d4aae6f..b81f476 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -719,9 +719,15 @@ static inline u64 cxl_p2n_read(struct cxl_afu *afu, cxl_p2n_reg_t reg)
 ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
 				loff_t off, size_t count);
 
+/* Internal functions wrapped in cxl_base to allow PHB to call them */
+bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu);
+void _cxl_pci_disable_device(struct pci_dev *dev);
 
 struct cxl_calls {
 	void (*cxl_slbia)(struct mm_struct *mm);
+	bool (*cxl_pci_associate_default_context)(struct pci_dev *dev, struct cxl_afu *afu);
+	void (*cxl_pci_disable_device)(struct pci_dev *dev);
+
 	struct module *owner;
 };
 int register_cxl_calls(struct cxl_calls *calls);
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index ae68c32..4e5474b 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -110,6 +110,8 @@ static inline void cxl_slbia_core(struct mm_struct *mm)
 
 static struct cxl_calls cxl_calls = {
 	.cxl_slbia = cxl_slbia_core,
+	.cxl_pci_associate_default_context = _cxl_pci_associate_default_context,
+	.cxl_pci_disable_device = _cxl_pci_disable_device,
 	.owner = THIS_MODULE,
 };
 
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 012b6aa..c5b9c201 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -40,11 +40,28 @@ static void cxl_teardown_msi_irqs(struct pci_dev *pdev)
 	 */
 }
 
+bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu)
+{
+	struct cxl_context *ctx;
+
+	/*
+	 * Allocate a context to do cxl things too. This is used for interrupts
+	 * in the peer model using a real phb, and if we eventually do DMA ops
+	 * in the virtual phb, we'll need a default context to attach them to.
+	 */
+	ctx = cxl_dev_context_init(dev);
+	if (!ctx)
+		return false;
+	dev->dev.archdata.cxl_ctx = ctx;
+
+	return (cxl_ops->afu_check_and_enable(afu) == 0);
+}
+/* exported via cxl_base */
+
 static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct pci_controller *phb;
 	struct cxl_afu *afu;
-	struct cxl_context *ctx;
 
 	phb = pci_bus_to_host(dev->bus);
 	afu = (struct cxl_afu *)phb->private_data;
@@ -57,19 +74,10 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 	set_dma_ops(&dev->dev, &dma_direct_ops);
 	set_dma_offset(&dev->dev, PAGE_OFFSET);
 
-	/*
-	 * Allocate a context to do cxl things too.  If we eventually do real
-	 * DMA ops, we'll need a default context to attach them to
-	 */
-	ctx = cxl_dev_context_init(dev);
-	if (!ctx)
-		return false;
-	dev->dev.archdata.cxl_ctx = ctx;
-
-	return (cxl_ops->afu_check_and_enable(afu) == 0);
+	return _cxl_pci_associate_default_context(dev, afu);
 }
 
-static void cxl_pci_disable_device(struct pci_dev *dev)
+void _cxl_pci_disable_device(struct pci_dev *dev)
 {
 	struct cxl_context *ctx = cxl_get_context(dev);
 
@@ -82,6 +90,7 @@ static void cxl_pci_disable_device(struct pci_dev *dev)
 		cxl_release_context(ctx);
 	}
 }
+/* exported via cxl_base */
 
 static resource_size_t cxl_pci_window_alignment(struct pci_bus *bus,
 						unsigned long type)
@@ -197,8 +206,8 @@ static struct pci_controller_ops cxl_pci_controller_ops =
 {
 	.probe_mode = cxl_pci_probe_mode,
 	.enable_device_hook = cxl_pci_enable_device_hook,
-	.disable_device = cxl_pci_disable_device,
-	.release_device = cxl_pci_disable_device,
+	.disable_device = _cxl_pci_disable_device,
+	.release_device = _cxl_pci_disable_device,
 	.window_alignment = cxl_pci_window_alignment,
 	.reset_secondary_bus = cxl_pci_reset_secondary_bus,
 	.setup_msi_irqs = cxl_setup_msi_irqs,
diff --git a/include/misc/cxl-base.h b/include/misc/cxl-base.h
index f53808f..bb7e629 100644
--- a/include/misc/cxl-base.h
+++ b/include/misc/cxl-base.h
@@ -10,6 +10,8 @@
 #ifndef _MISC_CXL_BASE_H
 #define _MISC_CXL_BASE_H
 
+#include <misc/cxl.h>
+
 #ifdef CONFIG_CXL_BASE
 
 #define CXL_IRQ_RANGES 4
@@ -39,6 +41,8 @@ static inline void cxl_ctx_put(void)
 struct cxl_afu *cxl_afu_get(struct cxl_afu *afu);
 void cxl_afu_put(struct cxl_afu *afu);
 void cxl_slbia(struct mm_struct *mm);
+bool cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu);
+void cxl_pci_disable_device(struct pci_dev *dev);
 
 #else /* CONFIG_CXL_BASE */
 
@@ -46,6 +50,8 @@ static inline bool cxl_ctx_in_use(void) { return false; }
 static inline struct cxl_afu *cxl_afu_get(struct cxl_afu *afu) { return NULL; }
 static inline void cxl_afu_put(struct cxl_afu *afu) {}
 static inline void cxl_slbia(struct mm_struct *mm) {}
+static inline bool cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu) { return false; }
+static inline void cxl_pci_disable_device(struct pci_dev *dev) {}
 
 #endif /* CONFIG_CXL_BASE */
 
-- 
2.8.1
