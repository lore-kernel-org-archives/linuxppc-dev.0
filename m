Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06043DDE30
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:21:25 +1000 (EST)
Date: Tue, 02 Oct 2007 17:21:21 +0900 (JST)
Message-Id: <20071002.172121.-1625870824.kouish@swc.toshiba.co.jp>
Subject: [PATCH 2/5] Celleb: Support for Power/Reset buttons
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a patch to support Power/Reset buttons on Beat on Celleb.

On Beat, we have an event from Beat if Power button or Reset button
is pressed. This patch catches the event and convert it to a signal
to INIT process by calling ctrl_alt_del() function.

/sbin/inittab have no entry to turn the machine power off so we have
to detect if power button is pressed or not internally in our driver.
This idea is taken from PS3's event handling subsystem.

Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
---

This patch is taken after "[PATCH 1/5] Move pause() and kexec_cpu_down()
to beat.c" applied, so some lines are taken in from that patch.
No functional dependency is incorporated.


Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/beat.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat.c
@@ -22,16 +22,24 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/rtc.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/reboot.h>
 
 #include <asm/hvconsole.h>
 #include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/firmware.h>
 
 #include "beat_wrapper.h"
 #include "beat.h"
+#include "interrupt.h"
+
+static int beat_pm_poweroff_flag;
 
 void beat_restart(char *cmd)
 {
-	beat_shutdown_logical_partition(1);
+	beat_shutdown_logical_partition(!beat_pm_poweroff_flag);
 }
 
 void beat_power_off(void)
@@ -170,6 +178,90 @@ void beat_kexec_cpu_down(int crash, int 
 }
 #endif
 
+static irqreturn_t beat_power_event(int virq, void *arg)
+{
+	printk(KERN_DEBUG "Beat: power button pressed\n");
+	beat_pm_poweroff_flag = 1;
+	ctrl_alt_del();
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t beat_reset_event(int virq, void *arg)
+{
+	printk(KERN_DEBUG "Beat: reset button pressed\n");
+	beat_pm_poweroff_flag = 0;
+	ctrl_alt_del();
+	return IRQ_HANDLED;
+}
+
+static struct beat_event_list {
+	const char *typecode;
+	irq_handler_t handler;
+	unsigned int virq;
+} beat_event_list[] = {
+	{ "power", beat_power_event, 0 },
+	{ "reset", beat_reset_event, 0 },
+};
+
+static int __init beat_register_event(void)
+{
+	u64 path[4], data[2];
+	int rc, i;
+	unsigned int virq;
+
+	for (i = 0; i < ARRAY_SIZE(beat_event_list); i++) {
+		struct beat_event_list *ev = &beat_event_list[i];
+
+		if (beat_construct_event_receive_port(data) != 0) {
+			printk(KERN_ERR "Beat: "
+			       "cannot construct event receive port for %s\n",
+			       ev->typecode);
+			return -EINVAL;
+		}
+
+		virq = irq_create_mapping(NULL, data[0]);
+		if (virq == NO_IRQ) {
+			printk(KERN_ERR "Beat: failed to get virtual IRQ"
+			       " for event receive port for %s\n",
+			       ev->typecode);
+			beat_destruct_event_receive_port(data[0]);
+			return -EIO;
+		}
+		ev->virq = virq;
+
+		rc = request_irq(virq, ev->handler, IRQF_DISABLED,
+				      ev->typecode, NULL);
+		if (rc != 0) {
+			printk(KERN_ERR "Beat: failed to request virtual IRQ"
+			       " for event receive port for %s\n",
+			       ev->typecode);
+			beat_destruct_event_receive_port(data[0]);
+			return rc;
+		}
+
+		path[0] = 0x1000000065780000ul;	/* 1,ex */
+		path[1] = 0x627574746f6e0000ul;	/* button */
+		path[2] = 0;
+		strncpy((char *)&path[2], ev->typecode, 8);
+		path[3] = 0;
+		data[1] = 0;
+
+		beat_create_repository_node(path, data);
+	}
+	return 0;
+}
+
+static int __init beat_event_init(void)
+{
+	if (!firmware_has_feature(FW_FEATURE_BEAT))
+		return -EINVAL;
+
+	beat_pm_poweroff_flag = 0;
+	return beat_register_event();
+}
+
+device_initcall(beat_event_init);
+
 EXPORT_SYMBOL(beat_get_term_char);
 EXPORT_SYMBOL(beat_put_term_char);
 EXPORT_SYMBOL(beat_halt_code);
