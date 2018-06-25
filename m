Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DvdY3sfVzF19d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 02:24:33 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5PGO2jU166386
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 12:24:31 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ju267d6ax-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 12:24:31 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 25 Jun 2018 17:24:29 +0100
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: alastair@au1.ibm.com, andrew.donnellan@au1.ibm.com, vaibhav@linux.ibm.com,
 clombard@linux.ibm.com, felix@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
Subject: [PATCH 09/10] Revert "cxl: Allow a default context to be associated
 with an external pci_dev"
Date: Mon, 25 Jun 2018 18:24:05 +0200
In-Reply-To: <20180625162406.10813-1-fbarrat@linux.ibm.com>
References: <20180625162406.10813-1-fbarrat@linux.ibm.com>
Message-Id: <20180625162406.10813-10-fbarrat@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove abandonned capi support for the Mellanox CX4.

This reverts commit a19bd79e31769626d288cc016e21a31b6f47bf6f.
---
 drivers/misc/cxl/Makefile |  2 +-
 drivers/misc/cxl/base.c   | 35 -------------------------------
 drivers/misc/cxl/cxl.h    |  6 ------
 drivers/misc/cxl/main.c   |  2 --
 drivers/misc/cxl/phb.c    | 44 ---------------------------------------
 drivers/misc/cxl/vphb.c   | 30 +++++++++++++++++++++++---
 include/misc/cxl-base.h   |  6 ------
 7 files changed, 28 insertions(+), 97 deletions(-)
 delete mode 100644 drivers/misc/cxl/phb.c

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index 502d41fc9ea5..5eea61b9584f 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -4,7 +4,7 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
 
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o pci.o trace.o
-cxl-y				+= vphb.o phb.o api.o cxllib.o
+cxl-y				+= vphb.o api.o cxllib.o
 cxl-$(CONFIG_PPC_PSERIES)	+= flash.o guest.o of.o hcalls.o
 cxl-$(CONFIG_DEBUG_FS)		+= debugfs.o
 obj-$(CONFIG_CXL)		+= cxl.o
diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index e1e80cb99ad9..7557835cdfcd 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -106,41 +106,6 @@ int cxl_update_properties(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(cxl_update_properties);
 
-/*
- * API calls into the driver that may be called from the PHB code and must be
- * built in.
- */
-bool cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu)
-{
-	bool ret;
-	struct cxl_calls *calls;
-
-	calls = cxl_calls_get();
-	if (!calls)
-		return false;
-
-	ret = calls->cxl_pci_associate_default_context(dev, afu);
-
-	cxl_calls_put(calls);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(cxl_pci_associate_default_context);
-
-void cxl_pci_disable_device(struct pci_dev *dev)
-{
-	struct cxl_calls *calls;
-
-	calls = cxl_calls_get();
-	if (!calls)
-		return;
-
-	calls->cxl_pci_disable_device(dev);
-
-	cxl_calls_put(calls);
-}
-EXPORT_SYMBOL_GPL(cxl_pci_disable_device);
-
 static int __init cxl_base_init(void)
 {
 	struct device_node *np;
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index d95c2c98f2ab..aa453448201d 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -867,15 +867,9 @@ static inline bool cxl_is_power9_dd1(void)
 ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
 				loff_t off, size_t count);
 
-/* Internal functions wrapped in cxl_base to allow PHB to call them */
-bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu);
-void _cxl_pci_disable_device(struct pci_dev *dev);
 
 struct cxl_calls {
 	void (*cxl_slbia)(struct mm_struct *mm);
-	bool (*cxl_pci_associate_default_context)(struct pci_dev *dev, struct cxl_afu *afu);
-	void (*cxl_pci_disable_device)(struct pci_dev *dev);
-
 	struct module *owner;
 };
 int register_cxl_calls(struct cxl_calls *calls);
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index a7e83624034b..334223b802ee 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -104,8 +104,6 @@ static inline void cxl_slbia_core(struct mm_struct *mm)
 
 static struct cxl_calls cxl_calls = {
 	.cxl_slbia = cxl_slbia_core,
-	.cxl_pci_associate_default_context = _cxl_pci_associate_default_context,
-	.cxl_pci_disable_device = _cxl_pci_disable_device,
 	.owner = THIS_MODULE,
 };
 
diff --git a/drivers/misc/cxl/phb.c b/drivers/misc/cxl/phb.c
deleted file mode 100644
index 6ec69ada19f4..000000000000
--- a/drivers/misc/cxl/phb.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright 2014-2016 IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/pci.h>
-#include "cxl.h"
-
-bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu)
-{
-	struct cxl_context *ctx;
-
-	/*
-	 * Allocate a context to do cxl things to. This is used for interrupts
-	 * in the peer model using a real phb, and if we eventually do DMA ops
-	 * in the virtual phb, we'll need a default context to attach them to.
-	 */
-	ctx = cxl_dev_context_init(dev);
-	if (IS_ERR(ctx))
-		return false;
-	dev->dev.archdata.cxl_ctx = ctx;
-
-	return (cxl_ops->afu_check_and_enable(afu) == 0);
-}
-/* exported via cxl_base */
-
-void _cxl_pci_disable_device(struct pci_dev *dev)
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
-}
-/* exported via cxl_base */
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 1a99c9c7a6fb..7908633d9204 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -44,6 +44,7 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct pci_controller *phb;
 	struct cxl_afu *afu;
+	struct cxl_context *ctx;
 
 	phb = pci_bus_to_host(dev->bus);
 	afu = (struct cxl_afu *)phb->private_data;
@@ -56,7 +57,30 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 	set_dma_ops(&dev->dev, &dma_nommu_ops);
 	set_dma_offset(&dev->dev, PAGE_OFFSET);
 
-	return _cxl_pci_associate_default_context(dev, afu);
+	/*
+	 * Allocate a context to do cxl things too.  If we eventually do real
+	 * DMA ops, we'll need a default context to attach them to
+	 */
+	ctx = cxl_dev_context_init(dev);
+	if (IS_ERR(ctx))
+		return false;
+	dev->dev.archdata.cxl_ctx = ctx;
+
+	return (cxl_ops->afu_check_and_enable(afu) == 0);
+}
+
+static void cxl_pci_disable_device(struct pci_dev *dev)
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
 }
 
 static resource_size_t cxl_pci_window_alignment(struct pci_bus *bus,
@@ -190,8 +214,8 @@ static struct pci_controller_ops cxl_pci_controller_ops =
 {
 	.probe_mode = cxl_pci_probe_mode,
 	.enable_device_hook = cxl_pci_enable_device_hook,
-	.disable_device = _cxl_pci_disable_device,
-	.release_device = _cxl_pci_disable_device,
+	.disable_device = cxl_pci_disable_device,
+	.release_device = cxl_pci_disable_device,
 	.window_alignment = cxl_pci_window_alignment,
 	.reset_secondary_bus = cxl_pci_reset_secondary_bus,
 	.setup_msi_irqs = cxl_setup_msi_irqs,
diff --git a/include/misc/cxl-base.h b/include/misc/cxl-base.h
index bb7e629ae492..f53808fa638a 100644
--- a/include/misc/cxl-base.h
+++ b/include/misc/cxl-base.h
@@ -10,8 +10,6 @@
 #ifndef _MISC_CXL_BASE_H
 #define _MISC_CXL_BASE_H
 
-#include <misc/cxl.h>
-
 #ifdef CONFIG_CXL_BASE
 
 #define CXL_IRQ_RANGES 4
@@ -41,8 +39,6 @@ static inline void cxl_ctx_put(void)
 struct cxl_afu *cxl_afu_get(struct cxl_afu *afu);
 void cxl_afu_put(struct cxl_afu *afu);
 void cxl_slbia(struct mm_struct *mm);
-bool cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu);
-void cxl_pci_disable_device(struct pci_dev *dev);
 
 #else /* CONFIG_CXL_BASE */
 
@@ -50,8 +46,6 @@ static inline bool cxl_ctx_in_use(void) { return false; }
 static inline struct cxl_afu *cxl_afu_get(struct cxl_afu *afu) { return NULL; }
 static inline void cxl_afu_put(struct cxl_afu *afu) {}
 static inline void cxl_slbia(struct mm_struct *mm) {}
-static inline bool cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu) { return false; }
-static inline void cxl_pci_disable_device(struct pci_dev *dev) {}
 
 #endif /* CONFIG_CXL_BASE */
 
-- 
2.17.1
