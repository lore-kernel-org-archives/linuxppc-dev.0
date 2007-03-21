Return-Path: <anton@ozlabs.org>
Message-Id: <20070321013824.856097000@samba.org>
References: <20070321013810.404636000@samba.org>
Date: Tue, 20 Mar 2007 20:38:12 -0500
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 02/10] Clean up pmac_backlight_unblank in oops path
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move pmac_backlight_unblank into its own function and only take the
pmac_backlight_mutex when we are on a pmac for that added bit of 
paranoia.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/traps.c	2007-03-11 10:31:29.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/traps.c	2007-03-11 10:34:44.000000000 -0500
@@ -90,6 +90,24 @@
  * Trap & Exception support
  */
 
+#ifdef CONFIG_PMAC_BACKLIGHT
+static void pmac_backlight_unblank(void)
+{
+	mutex_lock(&pmac_backlight_mutex);
+	if (pmac_backlight) {
+		struct backlight_properties *props;
+
+		props = &pmac_backlight->props;
+		props->brightness = props->max_brightness;
+		props->power = FB_BLANK_UNBLANK;
+		backlight_update_status(pmac_backlight);
+	}
+	mutex_unlock(&pmac_backlight_mutex);
+}
+#else
+static inline void pmac_backlight_unblank(void) { }
+#endif
+
 static DEFINE_SPINLOCK(die_lock);
 
 int die(const char *str, struct pt_regs *regs, long err)
@@ -104,18 +122,9 @@
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-#ifdef CONFIG_PMAC_BACKLIGHT
-	mutex_lock(&pmac_backlight_mutex);
-	if (machine_is(powermac) && pmac_backlight) {
-		struct backlight_properties *props;
+	if (machine_is(powermac))
+		pmac_backlight_unblank();
 
-		props = &pmac_backlight->props;
-		props->brightness = props->max_brightness;
-		props->power = FB_BLANK_UNBLANK;
-		backlight_update_status(pmac_backlight);
-	}
-	mutex_unlock(&pmac_backlight_mutex);
-#endif
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 #ifdef CONFIG_PREEMPT
 	printk("PREEMPT ");

--
