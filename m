Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFmT95fcczDvjM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 04:03:25 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFmT91XCcz9tl4
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2016 04:03:24 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABGwqp4120663
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:23 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26neaa0rgj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:23 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 10:03:22 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 02/11] VAS: Define vas_dev_init() and vas_dev_exit()
Date: Fri, 11 Nov 2016 09:02:47 -0800
In-Reply-To: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1478883776-11121-3-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define functions to initialize/terminate the VAS device driver.
These functions will configure the hardware in a follow on patch.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 drivers/misc/Kconfig            |   1 +
 drivers/misc/Makefile           |   1 +
 drivers/misc/vas/Kconfig        |  19 +++++++
 drivers/misc/vas/Makefile       |   3 ++
 drivers/misc/vas/vas-internal.h |   5 ++
 drivers/misc/vas/vas-window.c   |  19 +++++++
 drivers/misc/vas/vas.c          | 113 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 161 insertions(+)
 create mode 100644 drivers/misc/vas/Kconfig
 create mode 100644 drivers/misc/vas/Makefile
 create mode 100644 drivers/misc/vas/vas-window.c
 create mode 100644 drivers/misc/vas/vas.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index d002528..d9a8cf0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -806,4 +806,5 @@ source "drivers/misc/mic/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
+source "drivers/misc/vas/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index fb32516..aa5947b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_VAS)		+= vas/
 obj-$(CONFIG_PANEL)             += panel.o
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
diff --git a/drivers/misc/vas/Kconfig b/drivers/misc/vas/Kconfig
new file mode 100644
index 0000000..f02b887
--- /dev/null
+++ b/drivers/misc/vas/Kconfig
@@ -0,0 +1,19 @@
+#
+# IBM Virtual Accelarator Switchboard (VAS) compatible devices
+#depends on PPC_POWERNV && PCI_MSI && EEH
+#
+
+config VAS
+	tristate "Support for IBM Virtual Accelerator Switchboard (VAS)"
+	default n
+	help
+	  Select this option to enable driver support for IBM Virtual
+	  Accelerator Switchboard (VAS).
+	  VAS allows accelerators in co processors like NX-842 to be
+	  directly available to a user process.  This driver enables
+	  userspace programs to access these accelerators via
+	  /dev/vas/vas-nxM.N devices.
+
+	  VAS adapters are found in POWER9 based systems.
+
+	  If unsure, say N.
diff --git a/drivers/misc/vas/Makefile b/drivers/misc/vas/Makefile
new file mode 100644
index 0000000..7dd7139
--- /dev/null
+++ b/drivers/misc/vas/Makefile
@@ -0,0 +1,3 @@
+ccflags-y			:= $(call cc-disable-warning, unused-const-variable)
+ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
+obj-$(CONFIG_VAS)		+= vas.o vas-window.o
diff --git a/drivers/misc/vas/vas-internal.h b/drivers/misc/vas/vas-internal.h
index f91fd66..282513b 100644
--- a/drivers/misc/vas/vas-internal.h
+++ b/drivers/misc/vas/vas-internal.h
@@ -362,4 +362,9 @@ struct vas_winctx {
 	enum vas_notify_after_count notify_after_count;
 };
 
+extern int vas_initialized;
+
+extern int vas_window_reset(struct vas_instance *vinst, int winid);
+extern struct vas_instance *find_vas_instance(int node, int chip);
+
 #endif
diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
new file mode 100644
index 0000000..468f3bf
--- /dev/null
+++ b/drivers/misc/vas/vas-window.c
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2016 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <asm/vas.h>
+#include "vas-internal.h"
+
+/* stub for now */
+int vas_window_reset(struct vas_instance *vinst, int winid)
+{
+	return 0;
+}
diff --git a/drivers/misc/vas/vas.c b/drivers/misc/vas/vas.c
new file mode 100644
index 0000000..51f9c70
--- /dev/null
+++ b/drivers/misc/vas/vas.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright 2016 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <asm/vas.h>
+#include "vas-internal.h"
+
+int vas_initialized;
+struct vas_instance *vas_instances;
+
+static void init_vas_chip(struct vas_instance *vinst)
+{
+	int i;
+
+	for (i = 0; i < VAS_MAX_WINDOWS_PER_CHIP; i++)
+		vas_window_reset(vinst, i);
+}
+
+/*
+ * Although this is read/used multiple times, it is written to only
+ * during initialization.
+ */
+struct vas_instance *find_vas_instance(int node, int chip)
+{
+	int i = node * VAS_MAX_CHIPS_PER_NODE + chip;
+
+	return &vas_instances[i];
+}
+
+static void init_vas_instance(int node, int chip)
+{
+	struct vas_instance *vinst;
+
+	vinst = find_vas_instance(node, chip);
+
+	ida_init(&vinst->ida);
+
+	vinst->node = node;
+	vinst->chip = chip;
+	mutex_init(&vinst->mutex);
+
+	init_vas_chip(vinst);
+}
+
+int vas_init(void)
+{
+	int n, c;
+
+	vas_instances = kmalloc_array(VAS_MAX_NODES * VAS_MAX_CHIPS_PER_NODE,
+				sizeof(struct vas_instance), GFP_KERNEL);
+	if (!vas_instances)
+		return -ENOMEM;
+
+	/*
+	 * TODO: Get node-id and chip id from device tree?
+	 */
+	for (n = 0; n < VAS_MAX_NODES; n++) {
+		for (c = 0; c < VAS_MAX_CHIPS_PER_NODE; c++)
+			init_vas_instance(n, c);
+	}
+
+	vas_initialized = 1;
+
+	return 0;
+}
+
+void vas_exit(void)
+{
+	vas_initialized = 0;
+	kfree(vas_instances);
+}
+
+/*
+ * We will have a device driver for user space access to VAS.
+ * But for now this is just a wrapper to vas_init()
+ */
+int __init vas_dev_init(void)
+{
+	int rc;
+
+	rc = vas_init();
+	if (rc)
+		return rc;
+
+	vas_initialized = 1;
+
+	pr_err("VAS: initialized\n");
+
+	return 0;
+}
+
+void __init vas_dev_exit(void)
+{
+	pr_err("VAS: exiting\n");
+	vas_exit();
+}
+
+module_init(vas_dev_init);
+module_exit(vas_dev_exit);
+MODULE_DESCRIPTION("IBM Virtual Accelerator Switchboard");
+MODULE_AUTHOR("Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>");
+MODULE_LICENSE("GPL");
-- 
1.8.3.1
