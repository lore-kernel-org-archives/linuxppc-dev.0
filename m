Return-Path: <adlai@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC2F22C025B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 09:11:13 +1000 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <adlai@linux.vnet.ibm.com>;
 Thu, 9 Aug 2012 19:11:11 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3CB65C90026
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 19:11:08 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q79NB7Xu160698
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2012 19:11:07 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q79NB6xX009350
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2012 17:11:07 -0600
Message-ID: <1344553986.28791.13.camel@footlong>
Subject: [PATCH V2 3/3] drivers/char/tpm: Add securityfs support for event log
From: Ashley Lai <adlai@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 09 Aug 2012 18:13:06 -0500
In-Reply-To: <1344553253.28791.7.camel@footlong>
References: <1344553253.28791.7.camel@footlong>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, adlai@linux.vnet.ibm.com,
 linux-security-module@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
 adlai@us.ibm.com, key@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch retrieves the event log data from the device tree
during file open. The event log data will then displayed through
securityfs.

Signed-off-by: Ashley Lai <adlai@us.ibm.com>
---
 drivers/char/tpm/Makefile         |    8 ++++-
 drivers/char/tpm/tpm.h            |   12 ------
 drivers/char/tpm/tpm_eventlog.c   |    7 ++++
 drivers/char/tpm/tpm_eventlog.h   |   14 +++++++
 drivers/char/tpm/tpm_noeventlog.c |   21 +++++++++++
 drivers/char/tpm/tpm_of.c         |   68 +++++++++++++++++++++++++++++++++++++
 6 files changed, 117 insertions(+), 13 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_noeventlog.c
 create mode 100644 drivers/char/tpm/tpm_of.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 547509d..b53da57 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -2,9 +2,15 @@
 # Makefile for the kernel tpm device drivers.
 #
 obj-$(CONFIG_TCG_TPM) += tpm.o
+obj-$(CONFIG_TCG_TPM) += tpm_bios.o
 ifdef CONFIG_ACPI
-	obj-$(CONFIG_TCG_TPM) += tpm_bios.o
 	tpm_bios-objs += tpm_eventlog.o tpm_acpi.o
+else
+ifdef CONFIG_TCG_IBMVTPM
+	tpm_bios-objs += tpm_eventlog.o tpm_of.o
+else
+	tpm_bios-objs += tpm_eventlog.o tpm_noeventlog.o
+endif
 endif
 obj-$(CONFIG_TCG_TIS) += tpm_tis.o
 obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index aece857..08f6a07 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -304,15 +304,3 @@ extern int tpm_pm_suspend(struct device *, pm_message_t);
 extern int tpm_pm_resume(struct device *);
 extern int wait_for_tpm_stat(struct tpm_chip *, u8, unsigned long,
 			     wait_queue_head_t *);
-#ifdef CONFIG_ACPI
-extern struct dentry ** tpm_bios_log_setup(char *);
-extern void tpm_bios_log_teardown(struct dentry **);
-#else
-static inline struct dentry ** tpm_bios_log_setup(char *name)
-{
-	return NULL;
-}
-static inline void tpm_bios_log_teardown(struct dentry **dir)
-{
-}
-#endif
diff --git a/drivers/char/tpm/tpm_eventlog.c b/drivers/char/tpm/tpm_eventlog.c
index 84ddc55..814b202 100644
--- a/drivers/char/tpm/tpm_eventlog.c
+++ b/drivers/char/tpm/tpm_eventlog.c
@@ -24,6 +24,7 @@
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include "tpm.h"
 #include "tpm_eventlog.h"
@@ -369,6 +370,9 @@ struct dentry **tpm_bios_log_setup(char *name)
 {
 	struct dentry **ret = NULL, *tpm_dir, *bin_file, *ascii_file;
 
+	if (TPM_NO_EVENT_LOG)
+		return NULL;
+
 	tpm_dir = securityfs_create_dir(name, NULL);
 	if (is_bad(tpm_dir))
 		goto out;
@@ -412,6 +416,9 @@ void tpm_bios_log_teardown(struct dentry **lst)
 {
 	int i;
 
+	if (TPM_NO_EVENT_LOG)
+		return;
+
 	for (i = 0; i < 3; i++)
 		securityfs_remove(lst[i]);
 }
diff --git a/drivers/char/tpm/tpm_eventlog.h b/drivers/char/tpm/tpm_eventlog.h
index 8e23ccd..21ac6af 100644
--- a/drivers/char/tpm/tpm_eventlog.h
+++ b/drivers/char/tpm/tpm_eventlog.h
@@ -68,4 +68,18 @@ enum tcpa_pc_event_ids {
 };
 
 int read_log(struct tpm_bios_log *log);
+
+extern struct dentry **tpm_bios_log_setup(char *);
+extern void tpm_bios_log_teardown(struct dentry **);
+
+#ifdef CONFIG_PPC64
+#define TPM_NO_EVENT_LOG !of_find_node_by_name(NULL, "ibm,vtpm")
+#else
+#ifdef CONFIG_ACPI
+#define TPM_NO_EVENT_LOG 0
+#else
+#define TPM_NO_EVENT_LOG 1
+#endif
+#endif
+
 #endif
diff --git a/drivers/char/tpm/tpm_noeventlog.c b/drivers/char/tpm/tpm_noeventlog.c
new file mode 100644
index 0000000..f30a2bf
--- /dev/null
+++ b/drivers/char/tpm/tpm_noeventlog.c
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2012 IBM Corporation
+ *
+ * Author: Ashley Lai <adlai@us.ibm.com>
+ *
+ * Maintained by: <tpmdd-devel@lists.sourceforge.net>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/slab.h>
+#include "tpm_eventlog.h"
+
+int read_log(struct tpm_bios_log *log)
+{
+	return -EINVAL;
+}
diff --git a/drivers/char/tpm/tpm_of.c b/drivers/char/tpm/tpm_of.c
new file mode 100644
index 0000000..6d44adb
--- /dev/null
+++ b/drivers/char/tpm/tpm_of.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright 2012 IBM Corporation
+ *
+ * Author: Ashley Lai <adlai@us.ibm.com>
+ *
+ * Maintained by: <tpmdd-devel@lists.sourceforge.net>
+ *
+ * Read the event log created by the firmware on PPC64
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/of.h>
+
+#include "tpm.h"
+#include "tpm_eventlog.h"
+
+int read_log(struct tpm_bios_log *log)
+{
+	struct device_node *np;
+	const u32 *sizep;
+	const __be64 *basep;
+
+	if (log->bios_event_log != NULL) {
+		pr_err("%s: ERROR - Eventlog already initialized\n", __func__);
+		return -EFAULT;
+	}
+
+	np = of_find_node_by_name(NULL, "ibm,vtpm");
+	if (!np) {
+		pr_err("%s: ERROR - IBMVTPM not supported\n", __func__);
+		return -ENODEV;
+	}
+
+	sizep = of_get_property(np, "linux,sml-size", NULL);
+	if (sizep == NULL) {
+		pr_err("%s: ERROR - SML size not found\n", __func__);
+		return -EIO;
+	}
+	if (*sizep == 0) {
+		pr_err("%s: ERROR - event log area empty\n", __func__);
+		return -EIO;
+	}
+
+	basep = of_get_property(np, "linux,sml-base", NULL);
+	if (basep == NULL) {
+		pr_err(KERN_ERR "%s: ERROR - SML not found\n", __func__);
+		return -EIO;
+	}
+
+	log->bios_event_log = kmalloc(*sizep, GFP_KERNEL);
+	if (!log->bios_event_log) {
+		pr_err("%s: ERROR - Not enough memory for BIOS measurements\n",
+		       __func__);
+		return -ENOMEM;
+	}
+
+	log->bios_event_log_end = log->bios_event_log + *sizep;
+
+	memcpy(log->bios_event_log, __va(be64_to_cpup(basep)), *sizep);
+
+	return 0;
+}
-- 
1.7.1
