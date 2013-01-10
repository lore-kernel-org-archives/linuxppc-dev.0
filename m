Return-Path: <toshi.kani@hp.com>
Received: from g6t0187.atlanta.hp.com (g6t0187.atlanta.hp.com [15.193.32.64])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D40982C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 11:00:38 +1100 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: rjw@sisk.pl, lenb@kernel.org, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org
Subject: [RFC PATCH v2 02/12] ACPI: Add sys_hotplug.h for system device
 hotplug framework
Date: Thu, 10 Jan 2013 16:40:20 -0700
Message-Id: <1357861230-29549-3-git-send-email-toshi.kani@hp.com>
In-Reply-To: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
Cc: linux-s390@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, linux-mm@kvack.org,
 yinghai@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, srivatsa.bhat@linux.vnet.ibm.com,
 guohanjun@huawei.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added include/acpi/sys_hotplug.h, which is ACPI-specific system
device hotplug header and defines the order values of ACPI-specific
handlers.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 include/acpi/sys_hotplug.h |   48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 include/acpi/sys_hotplug.h

diff --git a/include/acpi/sys_hotplug.h b/include/acpi/sys_hotplug.h
new file mode 100644
index 0000000..ad80f61
--- /dev/null
+++ b/include/acpi/sys_hotplug.h
@@ -0,0 +1,48 @@
+/*
+ * sys_hotplug.h - ACPI System device hot-plug framework
+ *
+ * Copyright (C) 2012 Hewlett-Packard Development Company, L.P.
+ *	Toshi Kani <toshi.kani@hp.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ACPI_SYS_HOTPLUG_H
+#define _ACPI_SYS_HOTPLUG_H
+
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/sys_hotplug.h>
+
+/*
+ * System device hot-plug operation proceeds in the following order.
+ *   Validate phase -> Execute phase -> Commit phase
+ *
+ * The order values below define the calling sequence of ACPI-specific
+ * handlers for each phase in ascending order.  The order value of
+ * platform-neutral handlers are defined in <linux/sys_hotplug.h>.
+ */
+
+/* Add Validate order values */
+#define SHP_ACPI_BUS_ADD_VALIDATE_ORDER		0	/* must be first */
+
+/* Add Execute order values */
+#define SHP_ACPI_BUS_ADD_EXECUTE_ORDER		10
+#define SHP_ACPI_RES_ADD_EXECUTE_ORDER		20
+
+/* Add Commit order values */
+#define SHP_ACPI_BUS_ADD_COMMIT_ORDER		10
+
+/* Delete Validate order values */
+#define SHP_ACPI_BUS_DEL_VALIDATE_ORDER		0	/* must be first */
+#define SHP_ACPI_RES_DEL_VALIDATE_ORDER		10
+
+/* Delete Execute order values */
+#define SHP_ACPI_BUS_DEL_EXECUTE_ORDER		100
+
+/* Delete Commit order values */
+#define SHP_ACPI_BUS_DEL_COMMIT_ORDER		100
+
+#endif	/* _ACPI_SYS_HOTPLUG_H */
