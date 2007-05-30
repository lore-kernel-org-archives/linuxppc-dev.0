Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 6CEEFDE00C
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 10:56:34 +1000 (EST)
Date: Tue, 29 May 2007 17:56:58 -0700
From: Dave Jiang <djiang@mvista.com>
To: galak@kernel.crashing.org
Subject: [PATCH/RFC 2/2] powerpc: BOOKE watchdog add panic and reboot handlers
Message-ID: <20070530005658.GB8239@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A reboot notifier handler and a panic notifier handler is added to the BOOKE
watchdog driver in order to address this watchdog in situations of panic calls
and kexec calls. 

The BOOKE watchdog cannot be disabled once it has been enabled. When a panic
handler is called, there's a possibility of a soft reboot or crash_kexec being
called. We need to make sure that the watchdog hardware reset does not happen
during those situations. The watchdog is configured so that it would timeout
after hopefully a reasonable amount of time (roughly 5mins + panic_timeout). 
This way we can proceed with the panic handler. If we hang for some reason 
during panic, the watchdog can still reset eventually.

When kexec happens, the reboot notifier is called. We set the watchdog to the
max value, which is 2^63 TB ticks on FSL BOOKE (or 2^29 on 440). This is the
best we can do to ensure that the watchdog does not go off until the new kernel
is able to re-initialize the watchdog timer.  

Signed-off-by: Dave Jiang <djiang@mvista.com>

---

 booke_wdt.c |  160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 157 insertions(+), 3 deletions(-)

diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
index 0f5c77d..29e4f03 100644
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -19,10 +19,12 @@
 #include <linux/miscdevice.h>
 #include <linux/notifier.h>
 #include <linux/watchdog.h>
+#include <linux/reboot.h>
 
 #include <asm/reg_booke.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
+#include <asm/time.h>
 
 /* If the kernel parameter wdt=1, the watchdog will be enabled at boot.
  * Also, the wdt_period sets the watchdog timer period timeout.
@@ -33,18 +35,36 @@
  */
 
 #ifdef	CONFIG_FSL_BOOKE
-#define WDT_PERIOD_DEFAULT 63	/* Ex. wdt_period=28 bus=333Mhz , reset=~40sec */
+/* Ex. wdt_period=28 bus=333Mhz , reset=~40sec */
+#define WDT_PERIOD_MAX		63
 #else
-#define WDT_PERIOD_DEFAULT 3	/* Refer to the PPC40x and PPC4xx manuals */
-#endif				/* for timing information */
+/* 
+ * Refer to the PPC40x and PPC4xx manuals
+ * for timing information 
+ */
+#define WDT_PERIOD_MAX		WP_2_29
+#endif				
+
+#define WDT_PERIOD_DEFAULT	WDT_PERIOD_MAX
 
 u32 booke_wdt_enabled = 0;
 u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
 
 #ifdef	CONFIG_FSL_BOOKE
+
 #define WDTP(x)		((((63-x)&0x3)<<30)|(((63-x)&0x3c)<<15))
+#define WDTP_TO_NUM(x)	(63 - (((x >> 30) & 0x3) | (((x >> 17) & 0xf) << 2)))
+
+#ifdef TCR_WP_MASK
+#undef TCR_WP_MASK
+#define TCR_WP_MASK		WDTP(0)
+#endif
+
 #else
+
 #define WDTP(x)		(TCR_WP(x))
+#define WDTP_TO_NUM(x)		((x >> 30) & 0x3)
+
 #endif
 
 /*
@@ -56,6 +76,127 @@ static __inline__ void booke_wdt_ping(void)
 }
 
 /*
+ * wdog_reboot_handler:
+ */
+static int wdog_reboot_handler(struct notifier_block *this,
+				unsigned long	code,
+				void		*unused)
+{
+	static int reboot_event_handled = 0;
+	u32 val;
+
+	val = mfspr(SPRN_TCR);
+
+	if ((val & TCR_WRC(WRC_CHIP)) && !reboot_event_handled) {
+		reboot_event_handled = 1;
+
+		/*
+		 * we probably don't want a watchdog reset in the middle
+		 * of soft reboot, halt, or power off
+		 */
+		if ((code == SYS_RESTART) ||
+			(code == SYS_HALT) ||
+			(code == SYS_POWER_OFF)) {
+			/* clear the current time period */
+			val = val & ~TCR_WP_MASK;
+
+			booke_wdt_ping();
+			/* 
+			 * lets bump the timer up to max value to "disable"
+			 * the WDT
+			 */
+			val |= (TCR_WIE | TCR_WRC(WRC_CHIP) | 
+				WDTP(WDT_PERIOD_MAX));
+			mtspr(SPRN_TCR, val);
+		}
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block wdog_reboot_notifier = {
+	.notifier_call	= wdog_reboot_handler,
+	.next		= NULL,
+	.priority	= 0
+};
+
+/*
+ * the function takes timeout in seconds. 
+ * it looks at the timeout periods provided by the watchdog and matches
+ * to the next longest period
+ */
+#ifdef	CONFIG_FSL_BOOKE
+static int booke_wdt_match_period(int timeout)
+{
+	int i;
+	u64 val;
+
+	for (i=0; i < WDT_PERIOD_MAX; i++) {
+		val = 1ULL << i;
+		__div64_32(&val, tb_ticks_per_sec);
+		if(val >= timeout)
+			return i;
+	}
+
+	return WDT_PERIOD_MAX;
+}
+#else
+static int booke_wdt_match_period(int timeout)
+{
+	int i;
+	u32 val;
+
+	if (((1UL << 17) / tb_ticks_per_sec) >= timeout)
+		return WP_2_17;
+
+	if (((1UL << 21) / tb_ticks_per_sec) >= timeout)
+		return WP_2_21;
+
+	if (((1UL << 25) / tb_ticks_per_sec) >= timeout)
+		return WP_2_25;
+
+	return WP_2_29;
+}
+#endif	/* CONFIG_FSL_BOOKE */
+
+/*
+ * wdog_panic_handler:
+ */
+static int wdog_panic_handler(struct notifier_block *this,
+				unsigned long	event,
+				void		*unused)
+{
+	static int panic_event_handled = 0;
+	u32 val;
+
+	val = mfspr(SPRN_TCR);
+
+	if ((val & TCR_WRC(WRC_CHIP)) && !panic_event_handled) {
+		panic_event_handled = 1;
+
+		/* clear the current time period */
+		val = val & ~TCR_WP_MASK;
+
+		booke_wdt_ping();
+		/* 
+		 * lets bump the timer up to ~5 mins plus panic_timeout 
+		 * to allow us to complete the panic and allow new kernel
+		 * to boot
+		 */
+		val |= (TCR_WIE | TCR_WRC(WRC_CHIP) |
+			WDTP(booke_wdt_match_period(300+panic_timeout)));
+		mtspr(SPRN_TCR, val);
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block wdog_panic_notifier = {
+	.notifier_call	= wdog_panic_handler,
+	.next		= NULL,
+	.priority	= 150
+};
+
+/*
  * booke_wdt_enable:
  */
 static __inline__ void booke_wdt_enable(void)
@@ -164,6 +305,9 @@ static struct miscdevice booke_wdt_miscdev = {
 static void __exit booke_wdt_exit(void)
 {
 	misc_deregister(&booke_wdt_miscdev);
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					&wdog_panic_notifier);
+	unregister_reboot_notifier(&wdog_reboot_notifier);
 }
 
 /*
@@ -172,6 +316,7 @@ static void __exit booke_wdt_exit(void)
 static int __init booke_wdt_init(void)
 {
 	int ret = 0;
+	u32 val;
 
 	printk (KERN_INFO "PowerPC Book-E Watchdog Timer Loaded\n");
 	ident.firmware_version = cur_cpu_spec->pvr_value;
@@ -188,6 +333,15 @@ static int __init booke_wdt_init(void)
 				booke_wdt_period);
 		booke_wdt_enable();
 	}
+	else {
+		val = mfspr(SPRN_TCR);
+		if (val & TCR_WRC(WRC_CHIP))
+			printk (KERN_WARNING "PowerPC Book-E Watchdog Timer previously Enabled (wdt_period=%d)\n", WDTP_TO_NUM(val));
+	}
+
+	register_reboot_notifier(&wdog_reboot_notifier);
+	atomic_notifier_chain_register(&panic_notifier_list,
+					&wdog_panic_notifier);
 
 	return ret;
 }
