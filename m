Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8F902C00D4
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 19:39:37 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 27 Aug 2013 15:01:26 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8B9B23940058
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 15:09:20 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7R9fBgK40239346
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 15:11:12 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7R9dTNl022784
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 15:09:29 +0530
Subject: [PATCH] powerpc/powernv: Create opal sysfs directory
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Tue, 27 Aug 2013 15:09:52 +0530
Message-ID: <20130827093936.15620.7721.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create /sys/firmware/opal directory. We wil use this
interface to fetch opal error logs, firmware update, etc.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h       |    3 +++
 arch/powerpc/platforms/powernv/opal.c |   21 ++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ba6ffe6..4432b7a 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -523,6 +523,9 @@ typedef struct oppanel_line {
 	uint64_t 	line_len;
 } oppanel_line_t;
 
+/* /sys/firmware/opal */
+extern struct kobject *opal_kobj;
+
 /* API functions */
 int64_t opal_console_write(int64_t term_number, int64_t *length,
 			   const uint8_t *buffer);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 106301f..1c48a68 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -17,11 +17,15 @@
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/slab.h>
+#include <linux/kobject.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
 
 #include "powernv.h"
 
+/* /sys/firmware/opal */
+struct kobject *opal_kobj;
+
 struct opal {
 	u64 base;
 	u64 entry;
@@ -369,6 +373,17 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int opal_sysfs_init(void)
+{
+	opal_kobj = kobject_create_and_add("opal", firmware_kobj);
+	if (!opal_kobj) {
+		pr_warn("kobject_create_and_add opal failed\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int __init opal_init(void)
 {
 	struct device_node *np, *consoles;
@@ -412,7 +427,11 @@ static int __init opal_init(void)
 				   " (0x%x)\n", rc, irq, hwirq);
 		opal_irqs[i] = irq;
 	}
-	return 0;
+
+	/* Create "opal" kobject under /sys/firmware */
+	rc = opal_sysfs_init();
+
+	return rc;
 }
 subsys_initcall(opal_init);
 
