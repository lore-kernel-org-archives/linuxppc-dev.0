Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMh9G2YM8zF0lM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 22:11:29 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] watchdog: core: make sure the watchdog_worker is not deferred
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-watchdog@vger.kernel.org
Message-Id: <20180118111121.4542E65A3A@localhost.localdomain>
Date: Thu, 18 Jan 2018 12:11:21 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 4cd13c21b207e ("softirq: Let ksoftirqd do its job") has the
effect of deferring timer handling in case of high CPU load, hence
delaying the delayed work allthought the worker is running which
high realtime priority.

As hrtimers are not managed by softirqs, this patch replaces the
delayed work by a plain work and uses an hrtimer to schedule that work.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/watchdog/watchdog_dev.c | 86 +++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 68bc29e6e79e..ffbdc4642ea5 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -36,10 +36,10 @@
 #include <linux/errno.h>	/* For the -ENODEV/... values */
 #include <linux/fs.h>		/* For file operations */
 #include <linux/init.h>		/* For __init/__exit/... */
-#include <linux/jiffies.h>	/* For timeout functions */
+#include <linux/hrtimer.h>	/* For hrtimers */
 #include <linux/kernel.h>	/* For printk/panic/... */
 #include <linux/kref.h>		/* For data references */
-#include <linux/kthread.h>	/* For kthread_delayed_work */
+#include <linux/kthread.h>	/* For kthread_work */
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/module.h>	/* For module stuff/... */
 #include <linux/mutex.h>	/* For mutexes */
@@ -67,9 +67,10 @@ struct watchdog_core_data {
 	struct cdev cdev;
 	struct watchdog_device *wdd;
 	struct mutex lock;
-	unsigned long last_keepalive;
-	unsigned long last_hw_keepalive;
-	struct kthread_delayed_work work;
+	ktime_t last_keepalive;
+	ktime_t last_hw_keepalive;
+	struct hrtimer timer;
+	struct kthread_work work;
 	unsigned long status;		/* Internal status bits */
 #define _WDOG_DEV_OPEN		0	/* Opened ? */
 #define _WDOG_ALLOW_RELEASE	1	/* Did we receive the magic char ? */
@@ -109,18 +110,19 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 		(t && !watchdog_active(wdd) && watchdog_hw_running(wdd));
 }
 
-static long watchdog_next_keepalive(struct watchdog_device *wdd)
+static ktime_t watchdog_next_keepalive(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
 	unsigned int timeout_ms = wdd->timeout * 1000;
-	unsigned long keepalive_interval;
-	unsigned long last_heartbeat;
-	unsigned long virt_timeout;
+	ktime_t keepalive_interval;
+	ktime_t last_heartbeat, latest_heartbeat;
+	ktime_t virt_timeout;
 	unsigned int hw_heartbeat_ms;
 
-	virt_timeout = wd_data->last_keepalive + msecs_to_jiffies(timeout_ms);
+	virt_timeout = ktime_add(wd_data->last_keepalive,
+				 ms_to_ktime(timeout_ms));
 	hw_heartbeat_ms = min_not_zero(timeout_ms, wdd->max_hw_heartbeat_ms);
-	keepalive_interval = msecs_to_jiffies(hw_heartbeat_ms / 2);
+	keepalive_interval = ms_to_ktime(hw_heartbeat_ms / 2);
 
 	if (!watchdog_active(wdd))
 		return keepalive_interval;
@@ -130,8 +132,11 @@ static long watchdog_next_keepalive(struct watchdog_device *wdd)
 	 * after the most recent ping from userspace, the last
 	 * worker ping has to come in hw_heartbeat_ms before this timeout.
 	 */
-	last_heartbeat = virt_timeout - msecs_to_jiffies(hw_heartbeat_ms);
-	return min_t(long, last_heartbeat - jiffies, keepalive_interval);
+	last_heartbeat = ktime_sub(virt_timeout, ms_to_ktime(hw_heartbeat_ms));
+	latest_heartbeat = ktime_sub(last_heartbeat, ktime_get());
+	if (ktime_before(latest_heartbeat, keepalive_interval))
+		return latest_heartbeat;
+	return keepalive_interval;
 }
 
 static inline void watchdog_update_worker(struct watchdog_device *wdd)
@@ -139,30 +144,33 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd)
 	struct watchdog_core_data *wd_data = wdd->wd_data;
 
 	if (watchdog_need_worker(wdd)) {
-		long t = watchdog_next_keepalive(wdd);
+		ktime_t t = watchdog_next_keepalive(wdd);
 
 		if (t > 0)
-			kthread_mod_delayed_work(watchdog_kworker,
-						 &wd_data->work, t);
+			hrtimer_start(&wd_data->timer, t, HRTIMER_MODE_REL);
 	} else {
-		kthread_cancel_delayed_work_sync(&wd_data->work);
+		hrtimer_cancel(&wd_data->timer);
 	}
 }
 
 static int __watchdog_ping(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
-	unsigned long earliest_keepalive = wd_data->last_hw_keepalive +
-				msecs_to_jiffies(wdd->min_hw_heartbeat_ms);
+	ktime_t earliest_keepalive, now;
 	int err;
 
-	if (time_is_after_jiffies(earliest_keepalive)) {
-		kthread_mod_delayed_work(watchdog_kworker, &wd_data->work,
-					 earliest_keepalive - jiffies);
+	earliest_keepalive = ktime_add(wd_data->last_hw_keepalive,
+				       ms_to_ktime(wdd->min_hw_heartbeat_ms));
+	now = ktime_get();
+
+	if (ktime_after(earliest_keepalive, now)) {
+		hrtimer_start(&wd_data->timer,
+			      ktime_sub(earliest_keepalive, now),
+			      HRTIMER_MODE_REL);
 		return 0;
 	}
 
-	wd_data->last_hw_keepalive = jiffies;
+	wd_data->last_hw_keepalive = now;
 
 	if (wdd->ops->ping)
 		err = wdd->ops->ping(wdd);  /* ping the watchdog */
@@ -195,7 +203,7 @@ static int watchdog_ping(struct watchdog_device *wdd)
 
 	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
 
-	wd_data->last_keepalive = jiffies;
+	wd_data->last_keepalive = ktime_get();
 	return __watchdog_ping(wdd);
 }
 
@@ -210,9 +218,7 @@ static void watchdog_ping_work(struct kthread_work *work)
 {
 	struct watchdog_core_data *wd_data;
 
-	wd_data = container_of(container_of(work, struct kthread_delayed_work,
-					    work),
-			       struct watchdog_core_data, work);
+	wd_data = container_of(work, struct watchdog_core_data, work);
 
 	mutex_lock(&wd_data->lock);
 	if (watchdog_worker_should_ping(wd_data))
@@ -220,6 +226,16 @@ static void watchdog_ping_work(struct kthread_work *work)
 	mutex_unlock(&wd_data->lock);
 }
 
+static enum hrtimer_restart watchdog_timer_expired(struct hrtimer *timer)
+{
+	struct watchdog_core_data *wd_data;
+
+	wd_data = container_of(timer, struct watchdog_core_data, timer);
+
+	kthread_queue_work(watchdog_kworker, &wd_data->work);
+	return HRTIMER_NORESTART;
+}
+
 /*
  *	watchdog_start: wrapper to start the watchdog.
  *	@wdd: the watchdog device to start
@@ -234,7 +250,7 @@ static void watchdog_ping_work(struct kthread_work *work)
 static int watchdog_start(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
-	unsigned long started_at;
+	ktime_t started_at;
 	int err;
 
 	if (watchdog_active(wdd))
@@ -242,7 +258,7 @@ static int watchdog_start(struct watchdog_device *wdd)
 
 	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
 
-	started_at = jiffies;
+	started_at = ktime_get();
 	if (watchdog_hw_running(wdd) && wdd->ops->ping)
 		err = wdd->ops->ping(wdd);
 	else
@@ -928,7 +944,9 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 	if (IS_ERR_OR_NULL(watchdog_kworker))
 		return -ENODEV;
 
-	kthread_init_delayed_work(&wd_data->work, watchdog_ping_work);
+	kthread_init_work(&wd_data->work, watchdog_ping_work);
+	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	wd_data->timer.function = watchdog_timer_expired;
 
 	if (wdd->id == 0) {
 		old_wd_data = wd_data;
@@ -964,7 +982,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 	}
 
 	/* Record time of most recent heartbeat as 'just before now'. */
-	wd_data->last_hw_keepalive = jiffies - 1;
+	wd_data->last_hw_keepalive = ktime_sub(ktime_get(), 1);
 
 	/*
 	 * If the watchdog is running, prevent its driver from being unloaded,
@@ -974,8 +992,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 		__module_get(wdd->ops->owner);
 		kref_get(&wd_data->kref);
 		if (handle_boot_enabled)
-			kthread_queue_delayed_work(watchdog_kworker,
-						   &wd_data->work, 0);
+			hrtimer_start(&wd_data->timer, 0, HRTIMER_MODE_REL);
 		else
 			pr_info("watchdog%d running and kernel based pre-userspace handler disabled\n",
 				wdd->id);
@@ -1012,7 +1029,8 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 		watchdog_stop(wdd);
 	}
 
-	kthread_cancel_delayed_work_sync(&wd_data->work);
+	hrtimer_cancel(&wd_data->timer);
+	kthread_cancel_work_sync(&wd_data->work);
 
 	kref_put(&wd_data->kref, watchdog_core_data_release);
 }
-- 
2.13.3
