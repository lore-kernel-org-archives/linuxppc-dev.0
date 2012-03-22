Return-Path: <anton@samba.org>
Date: Thu, 22 Mar 2012 12:49:59 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/6] powerpc/pseries: Parse and handle EPOW interrupts
Message-ID: <20120322124959.32d84480@kryten>
In-Reply-To: <20120322124707.3cd3037f@kryten>
References: <20120322124707.3cd3037f@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We have code to take environmental and power warning (EPOW)
interrupts but it simply prints a terse error message:

EPOW <0x6240040000000b8 0x0 0x0>

which tells us nothing about what happened. Even worse, if we
don't correctly respond to the interrupt we may get terminated
by firmware.

Add code to printk some useful information when we get EPOW events.
We want to make it clear that we have an error, that it was
reported by firmware and that the RTAS error log will have more
detailed information. eg:

	Ambient temperature too high reported by firmware.
	Check RTAS error log for details

Depending on the error encountered, we now issue an immediate or
an orderly power down.

Move initialization of the EPOW interrupt earlier in boot since we
want to respond to them as early as possible.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/ras.c	2012-03-22 12:24:24.980892033 +1100
+++ linux-build/arch/powerpc/platforms/pseries/ras.c	2012-03-22 12:25:06.857659239 +1100
@@ -35,6 +35,8 @@
 #include <linux/random.h>
 #include <linux/sysrq.h>
 #include <linux/bitops.h>
+#include <linux/fs.h>
+#include <linux/reboot.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -95,26 +97,127 @@ static int __init init_ras_IRQ(void)
 
 	return 0;
 }
-__initcall(init_ras_IRQ);
+subsys_initcall(init_ras_IRQ);
 
-/*
- * Handle power subsystem events (EPOW).
- *
- * Presently we just log the event has occurred.  This should be fixed
- * to examine the type of power failure and take appropriate action where
- * the time horizon permits something useful to be done.
- */
+#define EPOW_SHUTDOWN_NORMAL				1
+#define EPOW_SHUTDOWN_ON_UPS				2
+#define EPOW_SHUTDOWN_LOSS_OF_CRITICAL_FUNCTIONS	3
+#define EPOW_SHUTDOWN_AMBIENT_TEMPERATURE_TOO_HIGH	4
+
+static void handle_system_shutdown(char event_modifier)
+{
+	switch (event_modifier) {
+	case EPOW_SHUTDOWN_NORMAL:
+		pr_emerg("Firmware initiated power off");
+		orderly_poweroff(1);
+		break;
+
+	case EPOW_SHUTDOWN_ON_UPS:
+		pr_emerg("Loss of power reported by firmware, system is "
+			"running on UPS/battery");
+		break;
+
+	case EPOW_SHUTDOWN_LOSS_OF_CRITICAL_FUNCTIONS:
+		pr_emerg("Loss of system critical functions reported by "
+			"firmware");
+		pr_emerg("Check RTAS error log for details");
+		orderly_poweroff(1);
+		break;
+
+	case EPOW_SHUTDOWN_AMBIENT_TEMPERATURE_TOO_HIGH:
+		pr_emerg("Ambient temperature too high reported by firmware");
+		pr_emerg("Check RTAS error log for details");
+		orderly_poweroff(1);
+		break;
+
+	default:
+		pr_err("Unknown power/cooling shutdown event (modifier %d)",
+			event_modifier);
+	}
+}
+
+struct epow_errorlog {
+	unsigned char sensor_value;
+	unsigned char event_modifier;
+	unsigned char extended_modifier;
+	unsigned char reserved;
+	unsigned char platform_reason;
+};
+
+#define EPOW_RESET			0
+#define EPOW_WARN_COOLING		1
+#define EPOW_WARN_POWER			2
+#define EPOW_SYSTEM_SHUTDOWN		3
+#define EPOW_SYSTEM_HALT		4
+#define EPOW_MAIN_ENCLOSURE		5
+#define EPOW_POWER_OFF			7
+
+void rtas_parse_epow_errlog(struct rtas_error_log *log)
+{
+	struct pseries_errorlog *pseries_log;
+	struct epow_errorlog *epow_log;
+	char action_code;
+	char modifier;
+
+	pseries_log = get_pseries_errorlog(log, PSERIES_ELOG_SECT_ID_EPOW);
+	if (pseries_log == NULL)
+		return;
+
+	epow_log = (struct epow_errorlog *)pseries_log->data;
+	action_code = epow_log->sensor_value & 0xF;	/* bottom 4 bits */
+	modifier = epow_log->event_modifier & 0xF;	/* bottom 4 bits */
+
+	switch (action_code) {
+	case EPOW_RESET:
+		pr_err("Non critical power or cooling issue cleared");
+		break;
+
+	case EPOW_WARN_COOLING:
+		pr_err("Non critical cooling issue reported by firmware");
+		pr_err("Check RTAS error log for details");
+		break;
+
+	case EPOW_WARN_POWER:
+		pr_err("Non critical power issue reported by firmware");
+		pr_err("Check RTAS error log for details");
+		break;
+
+	case EPOW_SYSTEM_SHUTDOWN:
+		handle_system_shutdown(epow_log->event_modifier);
+		break;
+
+	case EPOW_SYSTEM_HALT:
+		pr_emerg("Firmware initiated power off");
+		orderly_poweroff(1);
+		break;
+
+	case EPOW_MAIN_ENCLOSURE:
+	case EPOW_POWER_OFF:
+		pr_emerg("Critical power/cooling issue reported by firmware");
+		pr_emerg("Check RTAS error log for details");
+		pr_emerg("Immediate power off");
+		emergency_sync();
+		kernel_power_off();
+		break;
+
+	default:
+		pr_err("Unknown power/cooling event (action code %d)",
+			action_code);
+	}
+}
+
+/* Handle environmental and power warning (EPOW) interrupts. */
 static irqreturn_t ras_epow_interrupt(int irq, void *dev_id)
 {
-	int status = 0xdeadbeef;
-	int state = 0;
+	int status;
+	int state;
 	int critical;
 
 	status = rtas_call(ras_get_sensor_state_token, 2, 2, &state,
 			   EPOW_SENSOR_TOKEN, EPOW_SENSOR_INDEX);
 
 	if (state > 3)
-		critical = 1;  /* Time Critical */
+		critical = 1;		/* Time Critical */
 	else
 		critical = 0;
 
@@ -127,14 +230,10 @@ static irqreturn_t ras_epow_interrupt(in
 			   critical, __pa(&ras_log_buf),
 				rtas_get_error_log_max());
 
-	udbg_printf("EPOW <0x%lx 0x%x 0x%x>\n",
-		    *((unsigned long *)&ras_log_buf), status, state);
-	printk(KERN_WARNING "EPOW <0x%lx 0x%x 0x%x>\n",
-	       *((unsigned long *)&ras_log_buf), status, state);
-
-	/* format and print the extended information */
 	log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, 0);
 
+	rtas_parse_epow_errlog((struct rtas_error_log *)ras_log_buf);
+
 	spin_unlock(&ras_log_buf_lock);
 	return IRQ_HANDLED;
 }
