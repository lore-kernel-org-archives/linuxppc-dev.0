Return-Path: <adlai@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C2DD2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 09:33:33 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <adlai@linux.vnet.ibm.com>;
 Tue, 14 Aug 2012 17:33:31 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9AE6C19D803D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 17:33:23 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7ENXTCI145256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 17:33:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7ENXRdX024152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 17:33:28 -0600
Message-ID: <1344987332.4430.28.camel@footlong>
Subject: [PATCH V3 3/3] drivers/char/tpm: Add securityfs support for event log
From: Ashley Lai <adlai@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 14 Aug 2012 18:35:32 -0500
In-Reply-To: <1344986638.4430.22.camel@footlong>
References: <1344986638.4430.22.camel@footlong>
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
 drivers/char/tpm/Makefile       |    5 +++
 drivers/char/tpm/tpm.h          |   12 ------
 drivers/char/tpm/tpm_eventlog.h |   15 ++++++++
 drivers/char/tpm/tpm_of.c       |   73 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 12 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_of.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 547509d..9080cc4 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -5,6 +5,11 @@ obj-$(CONFIG_TCG_TPM) += tpm.o
 ifdef CONFIG_ACPI
 	obj-$(CONFIG_TCG_TPM) += tpm_bios.o
 	tpm_bios-objs += tpm_eventlog.o tpm_acpi.o
+else
+ifdef CONFIG_TCG_IBMVTPM
+	obj-$(CONFIG_TCG_TPM) += tpm_bios.o
+	tpm_bios-objs += tpm_eventlog.o tpm_of.o
+endif
 endif
 obj-$(CONFIG_TCG_TIS) += tpm_tis.o
 obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 870fde7..f1af738 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -327,15 +327,3 @@ extern int tpm_pm_suspend(struct device *);
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
diff --git a/drivers/char/tpm/tpm_eventlog.h b/drivers/char/tpm/tpm_eventlog.h
index 8e23ccd..e7da086 100644
--- a/drivers/char/tpm/tpm_eventlog.h
+++ b/drivers/char/tpm/tpm_eventlog.h
@@ -68,4 +68,19 @@ enum tcpa_pc_event_ids {
 };
 
 int read_log(struct tpm_bios_log *log);
+
+#if defined(CONFIG_TCG_IBMVTPM) || defined(CONFIG_TCG_IBMVTPM_MODULE) || \
+	defined(CONFIG_ACPI)
+extern struct dentry **tpm_bios_log_setup(char *);
+extern void tpm_bios_log_teardown(struct dentry **);
+#else
+static inline struct dentry **tpm_bios_log_setup(char *name)
+{
+	return NULL;
+}
+static inline void tpm_bios_log_teardown(struct dentry **dir)
+{
+}
+#endif
+
 #endif
diff --git a/drivers/char/tpm/tpm_of.c b/drivers/char/tpm/tpm_of.c
new file mode 100644
index 0000000..98ba2bd
--- /dev/null
+++ b/drivers/char/tpm/tpm_of.c
@@ -0,0 +1,73 @@
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
+		goto cleanup_eio;
+	}
+	if (*sizep == 0) {
+		pr_err("%s: ERROR - event log area empty\n", __func__);
+		goto cleanup_eio;
+	}
+
+	basep = of_get_property(np, "linux,sml-base", NULL);
+	if (basep == NULL) {
+		pr_err(KERN_ERR "%s: ERROR - SML not found\n", __func__);
+		goto cleanup_eio;
+	}
+
+	of_node_put(np);
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
+
+cleanup_eio:
+	of_node_put(np);
+	return -EIO;
+}
-- 
1.7.1
