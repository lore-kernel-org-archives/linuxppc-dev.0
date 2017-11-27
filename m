Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yllFK59GvzDrMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 22:39:17 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: mpic_timer: avoid struct timeval
Date: Mon, 27 Nov 2017 12:31:56 +0100
Message-Id: <20171127113234.2186374-2-arnd@arndb.de>
In-Reply-To: <20171127113234.2186374-1-arnd@arndb.de>
References: <20171127113234.2186374-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In an effort to remove all instances of 'struct timeval'
from the kernel, I'm changing the powerpc mpic_timer interface
to use plain seconds instead. There is only one user of this
interface, and that doesn't use the microseconds portion, so
the code gets noticeably simpler in the process.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/mpic_timer.h       |  8 ++---
 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c | 16 ++++-----
 arch/powerpc/sysdev/mpic_timer.c            | 55 ++++++-----------------------
 3 files changed, 21 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic_timer.h b/arch/powerpc/include/asm/mpic_timer.h
index 0e23cd4ac8aa..13e6702ec458 100644
--- a/arch/powerpc/include/asm/mpic_timer.h
+++ b/arch/powerpc/include/asm/mpic_timer.h
@@ -29,17 +29,17 @@ struct mpic_timer {
 
 #ifdef CONFIG_MPIC_TIMER
 struct mpic_timer *mpic_request_timer(irq_handler_t fn,  void *dev,
-		const struct timeval *time);
+		time64_t time);
 void mpic_start_timer(struct mpic_timer *handle);
 void mpic_stop_timer(struct mpic_timer *handle);
-void mpic_get_remain_time(struct mpic_timer *handle, struct timeval *time);
+void mpic_get_remain_time(struct mpic_timer *handle, time64_t *time);
 void mpic_free_timer(struct mpic_timer *handle);
 #else
 struct mpic_timer *mpic_request_timer(irq_handler_t fn,  void *dev,
-		const struct timeval *time) { return NULL; }
+		time64_t time) { return NULL; }
 void mpic_start_timer(struct mpic_timer *handle) { }
 void mpic_stop_timer(struct mpic_timer *handle) { }
-void mpic_get_remain_time(struct mpic_timer *handle, struct timeval *time) { }
+void mpic_get_remain_time(struct mpic_timer *handle, time64_t *time) { }
 void mpic_free_timer(struct mpic_timer *handle) { }
 #endif
 
diff --git a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
index 1707bf04dec6..94278e8af192 100644
--- a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
+++ b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
@@ -56,17 +56,16 @@ static ssize_t fsl_timer_wakeup_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct timeval interval;
-	int val = 0;
+	time64_t interval = 0;
 
 	mutex_lock(&sysfs_lock);
 	if (fsl_wakeup->timer) {
 		mpic_get_remain_time(fsl_wakeup->timer, &interval);
-		val = interval.tv_sec + 1;
+		interval++;
 	}
 	mutex_unlock(&sysfs_lock);
 
-	return sprintf(buf, "%d\n", val);
+	return sprintf(buf, "%lld\n", interval);
 }
 
 static ssize_t fsl_timer_wakeup_store(struct device *dev,
@@ -74,11 +73,10 @@ static ssize_t fsl_timer_wakeup_store(struct device *dev,
 				const char *buf,
 				size_t count)
 {
-	struct timeval interval;
+	time64_t interval;
 	int ret;
 
-	interval.tv_usec = 0;
-	if (kstrtol(buf, 0, &interval.tv_sec))
+	if (kstrtoll(buf, 0, &interval))
 		return -EINVAL;
 
 	mutex_lock(&sysfs_lock);
@@ -89,13 +87,13 @@ static ssize_t fsl_timer_wakeup_store(struct device *dev,
 		fsl_wakeup->timer = NULL;
 	}
 
-	if (!interval.tv_sec) {
+	if (!interval) {
 		mutex_unlock(&sysfs_lock);
 		return count;
 	}
 
 	fsl_wakeup->timer = mpic_request_timer(fsl_mpic_timer_irq,
-						fsl_wakeup, &interval);
+						fsl_wakeup, interval);
 	if (!fsl_wakeup->timer) {
 		mutex_unlock(&sysfs_lock);
 		return -EINVAL;
diff --git a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
index a418579591be..87e7c42777a8 100644
--- a/arch/powerpc/sysdev/mpic_timer.c
+++ b/arch/powerpc/sysdev/mpic_timer.c
@@ -47,9 +47,6 @@
 #define MAX_TICKS_CASCADE		(~0U)
 #define TIMER_OFFSET(num)		(1 << (TIMERS_PER_GROUP - 1 - num))
 
-/* tv_usec should be less than ONE_SECOND, otherwise use tv_sec */
-#define ONE_SECOND			1000000
-
 struct timer_regs {
 	u32	gtccr;
 	u32	res0[3];
@@ -90,51 +87,23 @@ static struct cascade_priv cascade_timer[] = {
 static LIST_HEAD(timer_group_list);
 
 static void convert_ticks_to_time(struct timer_group_priv *priv,
-		const u64 ticks, struct timeval *time)
+		const u64 ticks, time64_t *time)
 {
-	u64 tmp_sec;
-
-	time->tv_sec = (__kernel_time_t)div_u64(ticks, priv->timerfreq);
-	tmp_sec = (u64)time->tv_sec * (u64)priv->timerfreq;
-
-	time->tv_usec = 0;
-
-	if (tmp_sec <= ticks)
-		time->tv_usec = (__kernel_suseconds_t)
-			div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);
-
-	return;
+	*time = (u64)div_u64(ticks, priv->timerfreq);
 }
 
 /* the time set by the user is converted to "ticks" */
 static int convert_time_to_ticks(struct timer_group_priv *priv,
-		const struct timeval *time, u64 *ticks)
+		time64_t time, u64 *ticks)
 {
 	u64 max_value;		/* prevent u64 overflow */
-	u64 tmp = 0;
-
-	u64 tmp_sec;
-	u64 tmp_ms;
-	u64 tmp_us;
 
 	max_value = div_u64(ULLONG_MAX, priv->timerfreq);
 
-	if (time->tv_sec > max_value ||
-			(time->tv_sec == max_value && time->tv_usec > 0))
+	if (time > max_value)
 		return -EINVAL;
 
-	tmp_sec = (u64)time->tv_sec * (u64)priv->timerfreq;
-	tmp += tmp_sec;
-
-	tmp_ms = time->tv_usec / 1000;
-	tmp_ms = div_u64((u64)tmp_ms * (u64)priv->timerfreq, 1000);
-	tmp += tmp_ms;
-
-	tmp_us = time->tv_usec % 1000;
-	tmp_us = div_u64((u64)tmp_us * (u64)priv->timerfreq, 1000000);
-	tmp += tmp_us;
-
-	*ticks = tmp;
+	*ticks = (u64)time * (u64)priv->timerfreq;
 
 	return 0;
 }
@@ -223,7 +192,7 @@ static struct mpic_timer *get_cascade_timer(struct timer_group_priv *priv,
 	return allocated_timer;
 }
 
-static struct mpic_timer *get_timer(const struct timeval *time)
+static struct mpic_timer *get_timer(time64_t time)
 {
 	struct timer_group_priv *priv;
 	struct mpic_timer *timer;
@@ -277,7 +246,7 @@ static struct mpic_timer *get_timer(const struct timeval *time)
  * @handle: the timer to be started.
  *
  * It will do ->fn(->dev) callback from the hardware interrupt at
- * the ->timeval point in the future.
+ * the 'time64_t' point in the future.
  */
 void mpic_start_timer(struct mpic_timer *handle)
 {
@@ -319,7 +288,7 @@ EXPORT_SYMBOL(mpic_stop_timer);
  *
  * Query timer remaining time.
  */
-void mpic_get_remain_time(struct mpic_timer *handle, struct timeval *time)
+void mpic_get_remain_time(struct mpic_timer *handle, time64_t *time)
 {
 	struct timer_group_priv *priv = container_of(handle,
 			struct timer_group_priv, timer[handle->num]);
@@ -391,7 +360,7 @@ EXPORT_SYMBOL(mpic_free_timer);
  * else "handle" on success.
  */
 struct mpic_timer *mpic_request_timer(irq_handler_t fn, void *dev,
-					const struct timeval *time)
+				      time64_t time)
 {
 	struct mpic_timer *allocated_timer;
 	int ret;
@@ -399,11 +368,7 @@ struct mpic_timer *mpic_request_timer(irq_handler_t fn, void *dev,
 	if (list_empty(&timer_group_list))
 		return NULL;
 
-	if (!(time->tv_sec + time->tv_usec) ||
-			time->tv_sec < 0 || time->tv_usec < 0)
-		return NULL;
-
-	if (time->tv_usec > ONE_SECOND)
+	if (time < 0)
 		return NULL;
 
 	allocated_timer = get_timer(time);
-- 
2.9.0
