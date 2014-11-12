Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 886061A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 17:03:26 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D3DBD1400F1
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 17:03:25 +1100 (AEDT)
Message-ID: <1415772194.5124.37.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/powernv: Support OPAL requested heartbeat
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Wed, 12 Nov 2014 17:03:14 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If OPAL requests it, call it back via opal_poll_events() at a
regular interval. Some versions of OPAL on some machines require
this to operate some internal timeouts properly.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal.c | 64 ++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f1e0d8c..0153064 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -22,6 +22,8 @@
 #include <linux/kobject.h>
 #include <linux/delay.h>
 #include <linux/memblock.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
 
 #include <asm/machdep.h>
 #include <asm/opal.h>
@@ -58,6 +60,7 @@ static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
 static DEFINE_SPINLOCK(opal_notifier_lock);
 static uint64_t last_notified_mask = 0x0ul;
 static atomic_t opal_notifier_hold = ATOMIC_INIT(0);
+static uint32_t opal_heartbeat;
 
 static void opal_reinit_cores(void)
 {
@@ -633,17 +636,9 @@ static void opal_ipmi_init(struct device_node *opal_node)
 			of_platform_device_create(np, NULL, NULL);
 }
 
-static int __init opal_init(void)
+static void opal_console_create_devs(void)
 {
 	struct device_node *np, *consoles;
-	const __be32 *irqs;
-	int rc, i, irqlen;
-
-	opal_node = of_find_node_by_path("/ibm,opal");
-	if (!opal_node) {
-		pr_warn("opal: Node not found\n");
-		return -ENODEV;
-	}
 
 	/* Register OPAL consoles if any ports */
 	if (firmware_has_feature(FW_FEATURE_OPALv2))
@@ -659,6 +654,13 @@ static int __init opal_init(void)
 		of_node_put(consoles);
 	}
 
+}
+
+static void opal_request_interrupts(void)
+{
+	const __be32 *irqs;
+	int rc, i, irqlen;
+
 	/* Find all OPAL interrupts and request them */
 	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
 	pr_debug("opal: Found %d interrupts reserved for OPAL\n",
@@ -678,6 +680,49 @@ static int __init opal_init(void)
 				   " (0x%x)\n", rc, irq, hwirq);
 		opal_irqs[i] = irq;
 	}
+}
+
+static int kopald(void *unused)
+{
+	set_freezable();
+	do {
+		try_to_freeze();
+		opal_poll_events(NULL);
+		msleep_interruptible(opal_heartbeat);
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+static void opal_init_heartbeat(void)
+{
+	/* Old firwmware, we assume the HVC heartbeat is sufficient */
+	if (of_property_read_u32(opal_node, "ibm,heartbeat-freq",
+				 &opal_heartbeat) != 0)
+		opal_heartbeat = 0;
+
+	if (opal_heartbeat)
+		kthread_run(kopald, NULL, "kopald");
+}
+
+static int __init opal_init(void)
+{
+	int rc;
+
+	opal_node = of_find_node_by_path("/ibm,opal");
+	if (!opal_node) {
+		pr_warn("opal: Node not found\n");
+		return -ENODEV;
+	}
+
+	/* Setup a heatbeat thread if requested by OPAL */
+	opal_init_heartbeat();
+
+	/* Create console platform devices */
+	opal_console_create_devs();
+
+	/* Register OPAL interrupts */
+	opal_request_interrupts();
 
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
@@ -696,6 +741,7 @@ static int __init opal_init(void)
 		opal_msglog_init();
 	}
 
+	/* Initialize OPAL IPMI backend */
 	opal_ipmi_init(opal_node);
 
 	return 0;
