Return-Path: <anton@ozlabs.org>
Date: Mon, 15 Oct 2007 01:43:59 -0500
From: Anton Blanchard <anton@samba.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] Hook compat_sys_nanosleep up to high res timer code
Message-ID: <20071015064359.GB15396@kryten>
References: <20071014215437.GF26693@kryten> <200710150028.06493.arnd@arndb.de>
	<20071014231616.GA24519@kryten>
	<alpine.LFD.0.9999.0710150804290.22612@localhost.localdomain>
	<20071015063833.GA15396@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071015063833.GA15396@kryten>
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Now we have high res timers on ppc64 I thought Id test them. It turns
out compat_sys_nanosleep hasnt been converted to the hrtimer code and so
is limited to HZ resolution.

The follow patch converts compat_sys_nanosleep to use high res timers.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/kernel/compat.c b/kernel/compat.c
index 3bae374..729f63d 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -40,62 +40,26 @@ int put_compat_timespec(const struct timespec *ts, struct compat_timespec __user
 			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
 }
 
-static long compat_nanosleep_restart(struct restart_block *restart)
-{
-	unsigned long expire = restart->arg0, now = jiffies;
-	struct compat_timespec __user *rmtp;
-
-	/* Did it expire while we handled signals? */
-	if (!time_after(expire, now))
-		return 0;
-
-	expire = schedule_timeout_interruptible(expire - now);
-	if (expire == 0)
-		return 0;
-
-	rmtp = (struct compat_timespec __user *)restart->arg1;
-	if (rmtp) {
-		struct compat_timespec ct;
-		struct timespec t;
-
-		jiffies_to_timespec(expire, &t);
-		ct.tv_sec = t.tv_sec;
-		ct.tv_nsec = t.tv_nsec;
-		if (copy_to_user(rmtp, &ct, sizeof(ct)))
-			return -EFAULT;
-	}
-	/* The 'restart' block is already filled in */
-	return -ERESTART_RESTARTBLOCK;
-}
-
 asmlinkage long compat_sys_nanosleep(struct compat_timespec __user *rqtp,
-		struct compat_timespec __user *rmtp)
+				     struct compat_timespec __user *rmtp)
 {
-	struct timespec t;
-	struct restart_block *restart;
-	unsigned long expire;
+	struct timespec tu, rmt;
+	long ret;
 
-	if (get_compat_timespec(&t, rqtp))
+	if (get_compat_timespec(&tu, rqtp))
 		return -EFAULT;
 
-	if ((t.tv_nsec >= 1000000000L) || (t.tv_nsec < 0) || (t.tv_sec < 0))
+	if (!timespec_valid(&tu))
 		return -EINVAL;
 
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
-	expire = schedule_timeout_interruptible(expire);
-	if (expire == 0)
-		return 0;
+	ret = hrtimer_nanosleep(&tu, &rmt, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 
-	if (rmtp) {
-		jiffies_to_timespec(expire, &t);
-		if (put_compat_timespec(&t, rmtp))
+	if (ret && rmtp) {
+		if (put_compat_timespec(&rmt, rmtp))
 			return -EFAULT;
 	}
-	restart = &current_thread_info()->restart_block;
-	restart->fn = compat_nanosleep_restart;
-	restart->arg0 = jiffies + expire;
-	restart->arg1 = (unsigned long) rmtp;
-	return -ERESTART_RESTARTBLOCK;
+
+	return ret;
 }
 
 static inline long get_compat_itimerval(struct itimerval *o,
