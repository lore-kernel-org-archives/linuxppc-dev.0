Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqWrv1PmNzDqGS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:06 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DL91HU065069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:04 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24567cmsbs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:04 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 14 Jul 2016 07:18:01 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 955342CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:17:58 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DLHwQT26148878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:17:58 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DLHvA0000814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:17:58 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 05/15] cxl: Allow a default context to be associated with an
 external pci_dev
Date: Thu, 14 Jul 2016 07:17:04 +1000
In-Reply-To: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
References: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468444634-1866-6-git-send-email-imunsie@au.ibm.com>
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
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

V2->V3:
	Addressed feedback from Andrew Donnellan:
	- Fixed typo in comment
	- Moved _cxl_pci_associate_default_context and
	  _cxl_pci_disable_device from vphb.c to a new file phb.c since
	  they are used by both the vPHB and peer models.
---
 drivers/misc/cxl/Makefile |  2 +-
 drivers/misc/cxl/base.c   | 35 +++++++++++++++++++++++++++++++++++
 drivers/misc/cxl/cxl.h    |  6 ++++++
 drivers/misc/cxl/main.c   |  2 ++
 drivers/misc/cxl/phb.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/cxl/vphb.c   | 30 +++---------------------------
 include/misc/cxl-base.h   |  6 ++++++
 7 files changed, 97 insertions(+), 28 deletions(-)
 create mode 100644 drivers/misc/cxl/phb.c

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index 8a55c1a..56e9a47 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -3,7 +3,7 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
 
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
-cxl-y				+= vphb.o api.o
+cxl-y				+= vphb.o phb.o api.o
 cxl-$(CONFIG_PPC_PSERIES)	+= flash.o guest.o of.o hcalls.o
 obj-$(CONFIG_CXL)		+= cxl.o
 obj-$(CONFIG_CXL_BASE)		+= base.o
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
 
diff --git a/drivers/misc/cxl/phb.c b/drivers/misc/cxl/phb.c
new file mode 100644
index 0000000..0935d44
--- /dev/null
+++ b/drivers/misc/cxl/phb.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2014-2016 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/pci.h>
+#include "cxl.h"
+
+bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu)
+{
+	struct cxl_context *ctx;
+
+	/*
+	 * Allocate a context to do cxl things to. This is used for interrupts
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
+void _cxl_pci_disable_device(struct pci_dev *dev)
+{
+	struct cxl_context *ctx = cxl_get_context(dev);
+
+	if (ctx) {
+		if (ctx->status == STARTED) {
+			dev_err(&dev->dev, "Default context started\n");
+			return;
+		}
+		dev->dev.archdata.cxl_ctx = NULL;
+		cxl_release_context(ctx);
+	}
+}
+/* exported via cxl_base */
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 012b6aa..c8a759f 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -44,7 +44,6 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct pci_controller *phb;
 	struct cxl_afu *afu;
-	struct cxl_context *ctx;
 
 	phb = pci_bus_to_host(dev->bus);
 	afu = (struct cxl_afu *)phb->private_data;
@@ -57,30 +56,7 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
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
-}
-
-static void cxl_pci_disable_device(struct pci_dev *dev)
-{
-	struct cxl_context *ctx = cxl_get_context(dev);
-
-	if (ctx) {
-		if (ctx->status == STARTED) {
-			dev_err(&dev->dev, "Default context started\n");
-			return;
-		}
-		dev->dev.archdata.cxl_ctx = NULL;
-		cxl_release_context(ctx);
-	}
+	return _cxl_pci_associate_default_context(dev, afu);
 }
 
 static resource_size_t cxl_pci_window_alignment(struct pci_bus *bus,
@@ -197,8 +173,8 @@ static struct pci_controller_ops cxl_pci_controller_ops =
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
