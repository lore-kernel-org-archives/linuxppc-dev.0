Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C3681A01DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 16:14:09 +1100 (AEDT)
Message-ID: <1415942030.666.35.camel@kernel.crashing.org>
Subject: [PATCH v2] powerpc/powernv: Support OPAL requested heartbeat
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Fri, 14 Nov 2014 16:13:50 +1100
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

V2. Change device-tree property to "ibm,heartbeat-ms"

 arch/powerpc/platforms/powernv/opal.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index fc2d26a..1ad82ca 100644
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
@@ -687,6 +690,29 @@ static void opal_request_interrupts(void)
 	}
 }
 
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
+	if (of_property_read_u32(opal_node, "ibm,heartbeat-ms",
+				 &opal_heartbeat) != 0)
+		opal_heartbeat = 0;
+
+	if (opal_heartbeat)
+		kthread_run(kopald, NULL, "kopald");
+}
+
 static int __init opal_init(void)
 {
 	int rc;
@@ -703,6 +729,9 @@ static int __init opal_init(void)
 	/* Create i2c platform devices */
 	opal_i2c_create_devs();
 
+	/* Setup a heatbeat thread if requested by OPAL */
+	opal_init_heartbeat();
+
 	/* Register OPAL interrupts */
 	opal_request_interrupts();
 
@@ -723,6 +752,7 @@ static int __init opal_init(void)
 		opal_msglog_init();
 	}
 
+	/* Initialize OPAL IPMI backend */
 	opal_ipmi_init(opal_node);
 
 	return 0;
