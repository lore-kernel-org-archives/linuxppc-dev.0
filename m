Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 82D7ADE13B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 11:40:05 +1100 (EST)
Message-ID: <47EAEC87.9030103@am.sony.com>
Date: Wed, 26 Mar 2008 17:38:31 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 4/6] PS3: Save power in busy loops on halt
References: <20080327001821.827672589@am.sony.com>
In-Reply-To: <20080327001821.827672589@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

PS3 save power on halt:
  - Replace infinite busy loops by smarter loops calling
    lv1_pause() to save power.
  - Add ps3_halt() and ps3_sys_manager_halt().
  - Add __noreturn annotations.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/setup.c |   12 +++++++++++-
 drivers/ps3/ps3-sys-manager.c      |   30 ++++++++++++++++++++----------
 drivers/ps3/sys-manager-core.c     |   16 ++++++++++------
 include/asm-powerpc/ps3.h          |    5 +++--
 4 files changed, 44 insertions(+), 19 deletions(-)

--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -95,6 +95,14 @@ static void ps3_power_off(void)
 	ps3_sys_manager_power_off(); /* never returns */
 }
 
+static void ps3_halt(void)
+{
+	DBG("%s:%d\n", __func__, __LINE__);
+
+	smp_send_stop();
+	ps3_sys_manager_halt(); /* never returns */
+}
+
 static void ps3_panic(char *str)
 {
 	DBG("%s:%d %s\n", __func__, __LINE__, str);
@@ -105,7 +113,8 @@ static void ps3_panic(char *str)
 	printk("   Please press POWER button.\n");
 	printk("\n");
 
-	while(1);
+	while(1)
+		lv1_pause(1);
 }
 
 #if defined(CONFIG_FB_PS3) || defined(CONFIG_FB_PS3_MODULE) || \
@@ -266,6 +275,7 @@ define_machine(ps3) {
 	.progress			= ps3_progress,
 	.restart			= ps3_restart,
 	.power_off			= ps3_power_off,
+	.halt				= ps3_halt,
 #if defined(CONFIG_KEXEC)
 	.kexec_cpu_down			= ps3_kexec_cpu_down,
 	.machine_kexec			= default_machine_kexec,
--- a/drivers/ps3/ps3-sys-manager.c
+++ b/drivers/ps3/ps3-sys-manager.c
@@ -24,6 +24,7 @@
 #include <linux/reboot.h>
 
 #include <asm/firmware.h>
+#include <asm/lv1call.h>
 #include <asm/ps3.h>
 
 #include "vuart.h"
@@ -581,6 +582,23 @@ fail_id:
 	return -EIO;
 }
 
+static void ps3_sys_manager_fin(struct ps3_system_bus_device *dev)
+{
+	ps3_sys_manager_send_request_shutdown(dev);
+
+	pr_emerg("System Halted, OK to turn off power\n");
+
+	while (ps3_sys_manager_handle_msg(dev)) {
+		/* pause until next DEC interrupt */
+		lv1_pause(0);
+	}
+
+	while (1) {
+		/* pause, ignoring DEC interrupt */
+		lv1_pause(1);
+	}
+}
+
 /**
  * ps3_sys_manager_final_power_off - The final platform machine_power_off routine.
  *
@@ -602,12 +620,8 @@ static void ps3_sys_manager_final_power_
 
 	ps3_sys_manager_send_next_op(dev, PS3_SM_NEXT_OP_SYS_SHUTDOWN,
 		PS3_SM_WAKE_DEFAULT);
-	ps3_sys_manager_send_request_shutdown(dev);
-
-	pr_emerg("System Halted, OK to turn off power\n");
 
-	while (1)
-		ps3_sys_manager_handle_msg(dev);
+	ps3_sys_manager_fin(dev);
 }
 
 /**
@@ -639,12 +653,8 @@ static void ps3_sys_manager_final_restar
 	ps3_sys_manager_send_attr(dev, 0);
 	ps3_sys_manager_send_next_op(dev, PS3_SM_NEXT_OP_SYS_REBOOT,
 		PS3_SM_WAKE_DEFAULT);
-	ps3_sys_manager_send_request_shutdown(dev);
-
-	pr_emerg("System Halted, OK to turn off power\n");
 
-	while (1)
-		ps3_sys_manager_handle_msg(dev);
+	ps3_sys_manager_fin(dev);
 }
 
 /**
--- a/drivers/ps3/sys-manager-core.c
+++ b/drivers/ps3/sys-manager-core.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/kernel.h>
+#include <asm/lv1call.h>
 #include <asm/ps3.h>
 
 /**
@@ -50,10 +51,7 @@ void ps3_sys_manager_power_off(void)
 	if (ps3_sys_manager_ops.power_off)
 		ps3_sys_manager_ops.power_off(ps3_sys_manager_ops.dev);
 
-	printk(KERN_EMERG "System Halted, OK to turn off power\n");
-	local_irq_disable();
-	while (1)
-		(void)0;
+	ps3_sys_manager_halt();
 }
 
 void ps3_sys_manager_restart(void)
@@ -61,8 +59,14 @@ void ps3_sys_manager_restart(void)
 	if (ps3_sys_manager_ops.restart)
 		ps3_sys_manager_ops.restart(ps3_sys_manager_ops.dev);
 
-	printk(KERN_EMERG "System Halted, OK to turn off power\n");
+	ps3_sys_manager_halt();
+}
+
+void ps3_sys_manager_halt(void)
+{
+	pr_emerg("System Halted, OK to turn off power\n");
 	local_irq_disable();
 	while (1)
-		(void)0;
+		lv1_pause(1);
 }
+
--- a/include/asm-powerpc/ps3.h
+++ b/include/asm-powerpc/ps3.h
@@ -434,8 +434,9 @@ struct ps3_sys_manager_ops {
 };
 
 void ps3_sys_manager_register_ops(const struct ps3_sys_manager_ops *ops);
-void ps3_sys_manager_power_off(void);
-void ps3_sys_manager_restart(void);
+void __noreturn ps3_sys_manager_power_off(void);
+void __noreturn ps3_sys_manager_restart(void);
+void __noreturn ps3_sys_manager_halt(void);
 
 struct ps3_prealloc {
     const char *name;

-- 
