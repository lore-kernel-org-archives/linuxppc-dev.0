Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AD181A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 08:39:30 +1100 (AEDT)
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 21:39:27 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2466917D8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:39:44 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1GLdQTU65142902
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:39:26 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1GLdPwC016316
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 14:39:25 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 15/18] cxl: Parse device tree and create CAPI device(s) at
 boot
Date: Tue, 16 Feb 2016 22:39:08 +0100
Message-Id: <1455658751-16970-16-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1455658751-16970-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1455658751-16970-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add new entry point to scan the device tree at boot in a guest,
looking for CAPI devices.

Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/base.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index 957f4dd..9b90ec6 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -11,6 +11,7 @@
 #include <linux/rcupdate.h>
 #include <asm/errno.h>
 #include <misc/cxl-base.h>
+#include <linux/of_platform.h>
 #include "cxl.h"
 
 /* protected by rcu */
@@ -91,3 +92,27 @@ int cxl_update_properties(struct device_node *dn,
 	return of_update_property(dn, new_prop);
 }
 EXPORT_SYMBOL_GPL(cxl_update_properties);
+
+static int __init cxl_base_init(void)
+{
+	struct device_node *np = NULL;
+	struct platform_device *dev;
+	int count = 0;
+
+	/*
+	 * Scan for compatible devices in guest only
+	 */
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		return 0;
+
+	while ((np = of_find_compatible_node(np, NULL,
+				     "ibm,coherent-platform-facility"))) {
+		dev = of_platform_device_create(np, NULL, NULL);
+		if (dev)
+			count++;
+	}
+	pr_devel("Found %d cxl device(s)\n", count);
+	return 0;
+}
+
+module_init(cxl_base_init);
-- 
1.9.1
