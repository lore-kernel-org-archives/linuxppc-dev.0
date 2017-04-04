Return-Path: <srs0=tvro=3m=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyG2W6GDczDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 03:20:35 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vyG2W4Y5Hz8w6j
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 03:20:35 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vyG2V51Rvz9s9c
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2017 03:20:34 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v34HJVre054469
 for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2017 13:20:23 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29m0j55xfr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 04 Apr 2017 13:20:23 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 11:20:19 -0600
Date: Tue, 4 Apr 2017 10:20:05 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadevatlinux.vnet.ibm.com@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 Michael Ellerman <mpe@ellerman.id.au>, apopple@au1.ibm.com,
 hbabu@us.ibm.com, oohall@gmail.com, bsingharora@gmail.com,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/11] VAS: Define vas_init() and vas_exit()
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490937224-29149-5-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490937224-29149-5-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <20170404172005.GB17226@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu [sukadevatlinux.vnet.ibm.com] wrote:
> Implement vas_init() and vas_exit() functions for a new VAS module.
> This VAS module is essentially a library for other device drivers
> and kernel users of the NX coprocessors like NX-842 and NX-GZIP.
> In the future this will be extended to add support for user space
> to access the NX coprocessors.

Add "depends on PPC_64K_PAGES" to the Kconfig for VAS.
---

>From ff6fb584282363f6917fd956ccac05822d1912d7 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 02:16:10 -0500
Subject: [PATCH v4 04/11] VAS: Define vas_init() and vas_exit()

Implement vas_init() and vas_exit() functions for a new VAS module.
This VAS module is essentially a library for other device drivers
and kernel users of the NX coprocessors like NX-842 and NX-GZIP.
In the future this will be extended to add support for user space
to access the NX coprocessors.

VAS is currently only supported with 64K page size.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v4]:
	- [Michael Neuling] Fix some accidental deletions; fix help text
	  in Kconfig; change vas_initialized to a function; move from
	  drivers/misc to arch/powerpc/kernel
	- Drop the vas_window_reset() interface. It is not needed as
	  window will be initialized before each use.
	- Add a "depends on PPC_64K_PAGES"
Changelog[v3]:
	- Zero vas_instances memory on allocation
	- [Haren Myneni] Fix description in Kconfig
Changelog[v2]:
	- Get HVWC, UWC and window address parameters from device tree.
---
 arch/powerpc/platforms/powernv/Kconfig      |  14 +++
 arch/powerpc/platforms/powernv/Makefile     |   1 +
 arch/powerpc/platforms/powernv/vas-window.c |  19 ++++
 arch/powerpc/platforms/powernv/vas.c        | 145 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.h        |   3 +
 5 files changed, 182 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/vas-window.c
 create mode 100644 arch/powerpc/platforms/powernv/vas.c

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 3a07e4d..34c344c 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -27,3 +27,17 @@ config OPAL_PRD
 	help
 	  This enables the opal-prd driver, a facility to run processor
 	  recovery diagnostics on OpenPower machines
+
+config VAS
+	tristate "IBM Virtual Accelerator Switchboard (VAS)"
+	depends on PPC_POWERNV && PPC_64K_PAGES
+	default n
+	help
+	  This enables support for IBM Virtual Accelerator Switchboard (VAS).
+
+	  VAS allows accelerators in co-processors like NX-GZIP and NX-842
+	  to be accessible to kernel subsystems.
+
+	  VAS adapters are found in POWER9 based systems.
+
+	  If unsure, say N.
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb..ebef20b 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
 obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
+obj-$(CONFIG_VAS)	+= vas.o vas-window.o
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
new file mode 100644
index 0000000..6156fbe
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/vas-window.c
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
+
+#include "vas.h"
+
+/* stub for now */
+int vas_win_close(struct vas_window *window)
+{
+	return -1;
+}
diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
new file mode 100644
index 0000000..9bf8f57
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -0,0 +1,145 @@
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
+#include <linux/of.h>
+
+#include "vas.h"
+
+static bool init_done;
+int vas_num_instances;
+struct vas_instance *vas_instances;
+
+static int init_vas_instance(struct device_node *dn,
+				struct vas_instance *vinst)
+{
+	int rc;
+	const __be32 *p;
+	u64 values[6];
+
+	ida_init(&vinst->ida);
+	mutex_init(&vinst->mutex);
+
+	p = of_get_property(dn, "vas-id", NULL);
+	if (!p) {
+		pr_err("VAS: NULL vas-id? %p\n", p);
+		return -ENODEV;
+	}
+
+	vinst->vas_id = of_read_number(p, 1);
+
+	/*
+	 * Hardcoded 6 is tied to corresponding code in
+	 *      skiboot.git/core/vas.c
+	 */
+	rc = of_property_read_variable_u64_array(dn, "reg", values, 6, 6);
+	if (rc != 6) {
+		pr_err("VAS %d: Unable to read reg properties, rc %d\n",
+				vinst->vas_id, rc);
+		return rc;
+	}
+
+	vinst->hvwc_bar_start = values[0];
+	vinst->hvwc_bar_len = values[1];
+	vinst->uwc_bar_start = values[2];
+	vinst->uwc_bar_len = values[3];
+	vinst->win_base_addr = values[4];
+	vinst->win_id_shift = values[5];
+
+	return 0;
+}
+
+/*
+ * Although this is read/used multiple times, it is written to only
+ * during initialization.
+ */
+struct vas_instance *find_vas_instance(int vasid)
+{
+	int i;
+	struct vas_instance *vinst;
+
+	for (i = 0; i < vas_num_instances; i++) {
+		vinst = &vas_instances[i];
+		if (vinst->vas_id == vasid)
+			return vinst;
+	}
+	pr_err("VAS instance for vas-id %d not found\n", vasid);
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
+
+bool vas_initialized(void)
+{
+	return init_done;
+}
+
+int vas_init(void)
+{
+	int rc;
+	struct device_node *dn;
+	struct vas_instance *vinst;
+
+	if (!pvr_version_is(PVR_POWER9))
+		return -ENODEV;
+
+	vas_num_instances = 0;
+	for_each_node_by_name(dn, "vas")
+		vas_num_instances++;
+
+	if (!vas_num_instances)
+		return -ENODEV;
+
+	vas_instances = kcalloc(vas_num_instances, sizeof(*vinst), GFP_KERNEL);
+	if (!vas_instances)
+		return -ENOMEM;
+
+	vinst = &vas_instances[0];
+	for_each_node_by_name(dn, "vas") {
+		rc = init_vas_instance(dn, vinst);
+		if (rc) {
+			pr_err("Error %d initializing VAS instance %ld\n", rc,
+					(vinst-&vas_instances[0]));
+			goto cleanup;
+		}
+		vinst++;
+	}
+
+	rc = -ENODEV;
+	if (vinst == &vas_instances[0]) {
+		/* Should not happen as we saw some above. */
+		pr_err("VAS: Did not find any VAS DT nodes now!\n");
+		goto cleanup;
+	}
+
+	pr_devel("VAS: Initialized %d instances\n", vas_num_instances);
+	init_done = true;
+
+	return 0;
+
+cleanup:
+	kfree(vas_instances);
+	return rc;
+}
+
+void vas_exit(void)
+{
+	init_done = false;
+	kfree(vas_instances);
+}
+
+module_init(vas_init);
+module_exit(vas_exit);
+MODULE_DESCRIPTION("IBM Virtual Accelerator Switchboard");
+MODULE_AUTHOR("Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>");
+MODULE_LICENSE("GPL");
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 4953856..ba1e5b2 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -376,4 +376,7 @@ struct vas_winctx {
 	enum vas_notify_after_count notify_after_count;
 };
 
+extern bool vas_initialized(void);
+extern struct vas_instance *find_vas_instance(int vasid);
+
 #endif /* _VAS_H */
-- 
2.7.4
