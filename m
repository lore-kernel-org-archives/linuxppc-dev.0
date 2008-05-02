Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 61D3FDDE26
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 06:35:28 +1000 (EST)
Message-Id: <200805022034.m42KY234013256@imap1.linux-foundation.org>
Subject: [patch 1/5] macintosh: therm_pm72: driver_lock semaphore to mutex
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Fri, 02 May 2008 13:34:01 -0700
Cc: akpm@linux-foundation.org, dwalker@mvista.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Daniel Walker <dwalker@mvista.com>

Signed-off-by: Daniel Walker <dwalker@mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/macintosh/therm_pm72.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff -puN drivers/macintosh/therm_pm72.c~macintosh-therm_pm72-driver_lock-semaphore-to-mutex drivers/macintosh/therm_pm72.c
--- a/drivers/macintosh/therm_pm72.c~macintosh-therm_pm72-driver_lock-semaphore-to-mutex
+++ a/drivers/macintosh/therm_pm72.c
@@ -122,6 +122,7 @@
 #include <linux/kmod.h>
 #include <linux/i2c.h>
 #include <linux/kthread.h>
+#include <linux/mutex.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -169,7 +170,7 @@ static int				rackmac;
 static s32				dimm_output_clamp;
 static int 				fcu_rpm_shift;
 static int				fcu_tickle_ticks;
-static DECLARE_MUTEX(driver_lock);
+static DEFINE_MUTEX(driver_lock);
 
 /*
  * We have 3 types of CPU PID control. One is "split" old style control
@@ -729,9 +730,9 @@ static void fetch_cpu_pumps_minmax(void)
 static ssize_t show_##name(struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	ssize_t r;						\
-	down(&driver_lock);					\
+	mutex_lock(&driver_lock);					\
 	r = sprintf(buf, "%d.%03d", FIX32TOPRINT(data));	\
-	up(&driver_lock);					\
+	mutex_unlock(&driver_lock);					\
 	return r;						\
 }
 #define BUILD_SHOW_FUNC_INT(name, data)				\
@@ -1803,11 +1804,11 @@ static int main_control_loop(void *x)
 {
 	DBG("main_control_loop started\n");
 
-	down(&driver_lock);
+	mutex_lock(&driver_lock);
 
 	if (start_fcu() < 0) {
 		printk(KERN_ERR "kfand: failed to start FCU\n");
-		up(&driver_lock);
+		mutex_unlock(&driver_lock);
 		goto out;
 	}
 
@@ -1822,14 +1823,14 @@ static int main_control_loop(void *x)
 
 	fcu_tickle_ticks = FCU_TICKLE_TICKS;
 
-	up(&driver_lock);
+	mutex_unlock(&driver_lock);
 
 	while (state == state_attached) {
 		unsigned long elapsed, start;
 
 		start = jiffies;
 
-		down(&driver_lock);
+		mutex_lock(&driver_lock);
 
 		/* Tickle the FCU just in case */
 		if (--fcu_tickle_ticks < 0) {
@@ -1861,7 +1862,7 @@ static int main_control_loop(void *x)
 			do_monitor_slots(&slots_state);
 		else
 			do_monitor_drives(&drives_state);
-		up(&driver_lock);
+		mutex_unlock(&driver_lock);
 
 		if (critical_state == 1) {
 			printk(KERN_WARNING "Temperature control detected a critical condition\n");
@@ -2019,13 +2020,13 @@ static void detach_fcu(void)
  */
 static int therm_pm72_attach(struct i2c_adapter *adapter)
 {
-	down(&driver_lock);
+	mutex_lock(&driver_lock);
 
 	/* Check state */
 	if (state == state_detached)
 		state = state_attaching;
 	if (state != state_attaching) {
-		up(&driver_lock);
+		mutex_unlock(&driver_lock);
 		return 0;
 	}
 
@@ -2054,7 +2055,7 @@ static int therm_pm72_attach(struct i2c_
 		state = state_attached;
 		start_control_loops();
 	}
-	up(&driver_lock);
+	mutex_unlock(&driver_lock);
 
 	return 0;
 }
@@ -2065,16 +2066,16 @@ static int therm_pm72_attach(struct i2c_
  */
 static int therm_pm72_detach(struct i2c_adapter *adapter)
 {
-	down(&driver_lock);
+	mutex_lock(&driver_lock);
 
 	if (state != state_detached)
 		state = state_detaching;
 
 	/* Stop control loops if any */
 	DBG("stopping control loops\n");
-	up(&driver_lock);
+	mutex_unlock(&driver_lock);
 	stop_control_loops();
-	down(&driver_lock);
+	mutex_lock(&driver_lock);
 
 	if (u3_0 != NULL && !strcmp(adapter->name, "u3 0")) {
 		DBG("lost U3-0, disposing control loops\n");
@@ -2090,7 +2091,7 @@ static int therm_pm72_detach(struct i2c_
 	if (u3_0 == NULL && u3_1 == NULL)
 		state = state_detached;
 
-	up(&driver_lock);
+	mutex_unlock(&driver_lock);
 
 	return 0;
 }
_
