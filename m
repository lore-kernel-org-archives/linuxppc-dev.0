Return-Path: <baolin.wang@linaro.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 138821A1DDE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 15:59:08 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so196412206pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 22:59:06 -0700 (PDT)
From: Baolin Wang <baolin.wang@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 06/11] char/mmtimer:Convert to the 64bit methods for k_clock
 callback function
Date: Mon, 20 Apr 2015 13:57:34 +0800
Message-Id: <1429509459-17068-7-git-send-email-baolin.wang@linaro.org>
In-Reply-To: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
Cc: pang.xunlei@linaro.org, peterz@infradead.org, heiko.carstens@de.ibm.com,
 paulus@samba.org, cl@linux.com, heenasirwani@gmail.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org,
 rafael.j.wysocki@intel.com, ahh@google.com, fweisbec@gmail.com, pjt@google.com,
 riel@redhat.com, arnd@arndb.de, richardcochran@gmail.com,
 schwidefsky@de.ibm.com, john.stultz@linaro.org, rth@twiddle.net,
 baolin.wang@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch converts to the 64bit methods for k_clock callback
function, that converts the timespec type to timespec64 type and
converts the itimerspec type to itimerspec64 type.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/char/mmtimer.c |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/char/mmtimer.c b/drivers/char/mmtimer.c
index 3d6c067..213d0bb 100644
--- a/drivers/char/mmtimer.c
+++ b/drivers/char/mmtimer.c
@@ -478,18 +478,18 @@ static int sgi_clock_period;
 static struct timespec sgi_clock_offset;
 static int sgi_clock_period;
 
-static int sgi_clock_get(clockid_t clockid, struct timespec *tp)
+static int sgi_clock_get(clockid_t clockid, struct timespec64 *tp)
 {
 	u64 nsec;
 
 	nsec = rtc_time() * sgi_clock_period
 			+ sgi_clock_offset.tv_nsec;
-	*tp = ns_to_timespec(nsec);
+	*tp = ns_to_timespec64(nsec);
 	tp->tv_sec += sgi_clock_offset.tv_sec;
 	return 0;
 };
 
-static int sgi_clock_set(const clockid_t clockid, const struct timespec *tp)
+static int sgi_clock_set(const clockid_t clockid, const struct timespec64 *tp)
 {
 
 	u64 nsec;
@@ -657,7 +657,7 @@ static int sgi_timer_del(struct k_itimer *timr)
 }
 
 /* Assumption: it_lock is already held with irq's disabled */
-static void sgi_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
+static void sgi_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
 
 	if (timr->it.mmtimer.clock == TIMER_OFF) {
@@ -668,14 +668,14 @@ static void sgi_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 		return;
 	}
 
-	cur_setting->it_interval = ns_to_timespec(timr->it.mmtimer.incr * sgi_clock_period);
-	cur_setting->it_value = ns_to_timespec((timr->it.mmtimer.expires - rtc_time()) * sgi_clock_period);
+	cur_setting->it_interval = ns_to_timespec64(timr->it.mmtimer.incr * sgi_clock_period);
+	cur_setting->it_value = ns_to_timespec64((timr->it.mmtimer.expires - rtc_time()) * sgi_clock_period);
 }
 
 
 static int sgi_timer_set(struct k_itimer *timr, int flags,
-	struct itimerspec * new_setting,
-	struct itimerspec * old_setting)
+	struct itimerspec64 *new_setting,
+	struct itimerspec64 *old_setting)
 {
 	unsigned long when, period, irqflags;
 	int err = 0;
@@ -687,8 +687,8 @@ static int sgi_timer_set(struct k_itimer *timr, int flags,
 		sgi_timer_get(timr, old_setting);
 
 	sgi_timer_del(timr);
-	when = timespec_to_ns(&new_setting->it_value);
-	period = timespec_to_ns(&new_setting->it_interval);
+	when = timespec64_to_ns(&new_setting->it_value);
+	period = timespec64_to_ns(&new_setting->it_interval);
 
 	if (when == 0)
 		/* Clear timer */
@@ -699,11 +699,9 @@ static int sgi_timer_set(struct k_itimer *timr, int flags,
 		return -ENOMEM;
 
 	if (flags & TIMER_ABSTIME) {
-		struct timespec n;
 		unsigned long now;
 
-		getnstimeofday(&n);
-		now = timespec_to_ns(&n);
+		now = ktime_get_real_ns();
 		if (when > now)
 			when -= now;
 		else
@@ -765,7 +763,7 @@ static int sgi_timer_set(struct k_itimer *timr, int flags,
 	return err;
 }
 
-static int sgi_clock_getres(const clockid_t which_clock, struct timespec *tp)
+static int sgi_clock_getres(const clockid_t which_clock, struct timespec64 *tp)
 {
 	tp->tv_sec = 0;
 	tp->tv_nsec = sgi_clock_period;
@@ -773,13 +771,13 @@ static int sgi_clock_getres(const clockid_t which_clock, struct timespec *tp)
 }
 
 static struct k_clock sgi_clock = {
-	.clock_set	= sgi_clock_set,
-	.clock_get	= sgi_clock_get,
-	.clock_getres	= sgi_clock_getres,
+	.clock_set64	= sgi_clock_set,
+	.clock_get64	= sgi_clock_get,
+	.clock_getres64	= sgi_clock_getres,
 	.timer_create	= sgi_timer_create,
-	.timer_set	= sgi_timer_set,
+	.timer_set64	= sgi_timer_set,
 	.timer_del	= sgi_timer_del,
-	.timer_get	= sgi_timer_get
+	.timer_get64	= sgi_timer_get
 };
 
 /**
-- 
1.7.9.5
