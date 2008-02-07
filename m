Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18347.34100.60973.215093@cargo.ozlabs.ibm.com>
Date: Fri, 8 Feb 2008 09:24:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	tglx@linutronix.de
Subject: [PATCH] Fix compilation of powerpc asm-offsets.c with old gcc
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Tony Breeds <tony@bakeyournoodle.com>

Commit ad7f71674ad7c3c4467e48f6ab9e85516dae2720 corrected the clock
resolution reported by the VDSO clock_getres() but introduced another
problem in that older versions of gcc (gcc-4.0 and earlier) fail to
compile the new code in arch/powerpc/kernel/asm-offsets.c.

This fixes it by introducing a new MONOTONIC_RES_NSEC define in the
generic code which is equivalent to KTIME_MONOTONIC_RES but is just an
integer constant, not a ktime union.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---

Linus, I'm sending you this as a patch since it touches generic code.
Please apply, since mainline is broken for powerpc users who are using
gcc-4.0 or earlier.

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e6e4928..4b749c4 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -313,7 +313,7 @@ int main(void)
 	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
 	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
 	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
-	DEFINE(CLOCK_REALTIME_RES, (KTIME_MONOTONIC_RES).tv64);
+	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 8371b66..203591e 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -225,11 +225,14 @@ static inline int hrtimer_is_hres_active(struct hrtimer *timer)
  * idea of the (in)accuracy of timers. Timer values are rounded up to
  * this resolution values.
  */
-# define KTIME_HIGH_RES		(ktime_t) { .tv64 = 1 }
+# define HIGH_RES_NSEC		1
+# define KTIME_HIGH_RES		(ktime_t) { .tv64 = HIGH_RES_NSEC }
+# define MONOTONIC_RES_NSEC	HIGH_RES_NSEC
 # define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
 
 #else
 
+# define MONOTONIC_RES_NSEC	LOW_RES_NSEC
 # define KTIME_MONOTONIC_RES	KTIME_LOW_RES
 
 /*
diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index a6ddec1..36c542b 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -316,7 +316,8 @@ static inline ktime_t ktime_sub_us(const ktime_t kt, const u64 usec)
  * idea of the (in)accuracy of timers. Timer values are rounded up to
  * this resolution values.
  */
-#define KTIME_LOW_RES		(ktime_t){ .tv64 = TICK_NSEC }
+#define LOW_RES_NSEC		TICK_NSEC
+#define KTIME_LOW_RES		(ktime_t){ .tv64 = LOW_RES_NSEC }
 
 /* Get the monotonic time in timespec format: */
 extern void ktime_get_ts(struct timespec *ts);
