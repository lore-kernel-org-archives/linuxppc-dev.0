Return-Path: <joel@jms.id.au>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4D5C1A0D4C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 17:43:24 +1100 (AEDT)
Received: by mail-pa0-f52.google.com with SMTP id kx10so48643110pab.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 22:43:22 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powernv: Add OPAL soft-poweroff routine
Date: Fri, 30 Jan 2015 17:13:08 +1030
Message-Id: <1422600188-27488-1-git-send-email-joel@jms.id.au>
Cc: jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Register a notifier for a OPAL message indicating that the machine
should prepare itself for a graceful power off.

OPAL will tell us if the power off is a reboot or shutdown, but for now
we perform the same orderly_poweroff action.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
  - combine the reboot and off cases, as they are the same code

 arch/powerpc/include/asm/opal.h             |  2 +-
 arch/powerpc/platforms/powernv/Makefile     |  2 +-
 arch/powerpc/platforms/powernv/opal-power.c | 66 +++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-power.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ca2dd45..cdf32c0 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -250,7 +250,7 @@ enum OpalMessageType {
 					 */
 	OPAL_MSG_MEM_ERR,
 	OPAL_MSG_EPOW,
-	OPAL_MSG_SHUTDOWN,
+	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
 	OPAL_MSG_HMI_EVT,
 	OPAL_MSG_TYPE_MAX,
 };
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index f241acc..6f3c5d3 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,7 +1,7 @@
 obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
-obj-y			+= opal-msglog.o opal-hmi.o
+obj-y			+= opal-msglog.o opal-hmi.o opal-power.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/opal-power.c b/arch/powerpc/platforms/powernv/opal-power.c
new file mode 100644
index 0000000..bbc1054
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-power.c
@@ -0,0 +1,66 @@
+/*
+ * PowerNV OPAL power control for graceful shutdown handling
+ *
+ * Copyright 2015 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/reboot.h>
+#include <linux/notifier.h>
+
+#include <asm/opal.h>
+#include <asm/machdep.h>
+
+#define SOFT_OFF 0x00
+#define SOFT_REBOOT 0x01
+
+static int opal_power_control_event(struct notifier_block *nb,
+				    unsigned long msg_type, void *msg)
+{
+	struct opal_msg *power_msg = msg;
+	uint64_t type;
+
+	type = be64_to_cpu(power_msg->params[0]);
+
+	switch (type) {
+	case SOFT_REBOOT:
+		/* Fall through. The service processor is responsible for
+		 * bringing the machine back up */
+	case SOFT_OFF:
+		pr_info("OPAL: poweroff requested\n");
+		orderly_poweroff(true);
+		break;
+	default:
+		pr_err("OPAL: power control type unexpected %016llx\n", type);
+	}
+
+	return 0;
+}
+
+static struct notifier_block opal_power_control_nb = {
+	.notifier_call	= opal_power_control_event,
+	.next		= NULL,
+	.priority	= 0,
+};
+
+static int __init opal_power_control_init(void)
+{
+	int ret;
+
+	ret = opal_message_notifier_register(OPAL_MSG_SHUTDOWN,
+					     &opal_power_control_nb);
+	if (ret) {
+		pr_err("%s: Can't register OPAL event notifier (%d)\n",
+				__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+machine_subsys_initcall(powernv, opal_power_control_init);
-- 
2.1.4
