Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qsJNX1zZ4zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 13:47:55 +1000 (AEST)
Received: by mail-pf0-x232.google.com with SMTP id 184so47388588pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 20:47:55 -0700 (PDT)
Date: Sat, 23 Apr 2016 12:49:24 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Chris Metcalf <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk/nmi: flush NMI messages on the system panic
Message-ID: <20160423034924.GA535@swordfish>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-5-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461239325-22779-5-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Petr,

On (04/21/16 13:48), Petr Mladek wrote:
>  extern void printk_nmi_flush(void);
> +extern void printk_nmi_flush_on_panic(void);
>  #else
>  static inline void printk_nmi_flush(void) { }
> +static inline void printk_nmi_flush_on_panic(void) { }
[..]
> +void printk_nmi_flush_on_panic(void)
> +{
> +	/*
> +	 * Make sure that we could access the main ring buffer.
> +	 * Do not risk a double release when more CPUs are up.
> +	 */
> +	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
> +		if (num_online_cpus() > 1)
> +			return;
> +
> +		debug_locks_off();
> +		raw_spin_lock_init(&logbuf_lock);
> +	}
> +
> +	printk_nmi_flush();
> +}
[..]
> -static DEFINE_RAW_SPINLOCK(logbuf_lock);
> +DEFINE_RAW_SPINLOCK(logbuf_lock);

just an idea,

how about doing it a bit differently?


move printk_nmi_flush_on_panic() to printk.c, and place it next to
printk_flush_on_panic() (so we will have two printk "flush-on-panic"
functions sitting together). /* printk_nmi_flush() is in printk.h,
so it's visible to printk anyway */

it also will let us keep logbuf_lock static, it's a bit too internal
to printk to expose it, I think.


IOW, something like this?

---

 kernel/printk/internal.h |  2 --
 kernel/printk/nmi.c      | 27 ---------------------------
 kernel/printk/printk.c   | 29 ++++++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 7fd2838..341bedc 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -22,8 +22,6 @@ int __printf(1, 0) vprintk_default(const char *fmt, va_list args);
 
 #ifdef CONFIG_PRINTK_NMI
 
-extern raw_spinlock_t logbuf_lock;
-
 /*
  * printk() could not take logbuf_lock in NMI context. Instead,
  * it temporary stores the strings into a per-CPU buffer.
diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index b69eb8a..b68a9864 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -204,33 +204,6 @@ void printk_nmi_flush(void)
 		__printk_nmi_flush(&per_cpu(nmi_print_seq, cpu).work);
 }
 
-/**
- * printk_nmi_flush_on_panic - flush all per-cpu nmi buffers when the system
- *	goes down.
- *
- * Similar to printk_nmi_flush() but it can be called even in NMI context when
- * the system goes down. It does the best effort to get NMI messages into
- * the main ring buffer.
- *
- * Note that it could try harder when there is only one CPU online.
- */
-void printk_nmi_flush_on_panic(void)
-{
-	/*
-	 * Make sure that we could access the main ring buffer.
-	 * Do not risk a double release when more CPUs are up.
-	 */
-	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
-		if (num_online_cpus() > 1)
-			return;
-
-		debug_locks_off();
-		raw_spin_lock_init(&logbuf_lock);
-	}
-
-	printk_nmi_flush();
-}
-
 void __init printk_nmi_init(void)
 {
 	int cpu;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0a0e789..1509baa 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -245,7 +245,7 @@ __packed __aligned(4)
  * within the scheduler's rq lock. It must be released before calling
  * console_unlock() or anything else that might wake up a process.
  */
-DEFINE_RAW_SPINLOCK(logbuf_lock);
+static DEFINE_RAW_SPINLOCK(logbuf_lock);
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
@@ -2447,6 +2447,33 @@ void console_unblank(void)
 }
 
 /**
+ * printk_nmi_flush_on_panic - flush all per-cpu nmi buffers when the system
+ *	goes down.
+ *
+ * Similar to printk_nmi_flush() but it can be called even in NMI context when
+ * the system goes down. It does the best effort to get NMI messages into
+ * the main ring buffer.
+ *
+ * Note that it could try harder when there is only one CPU online.
+ */
+void printk_nmi_flush_on_panic(void)
+{
+	/*
+	 * Make sure that we could access the main ring buffer.
+	 * Do not risk a double release when more CPUs are up.
+	 */
+	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
+		if (num_online_cpus() > 1)
+			return;
+
+		debug_locks_off();
+		raw_spin_lock_init(&logbuf_lock);
+	}
+
+	printk_nmi_flush();
+}
+
+/**
  * console_flush_on_panic - flush console content on panic
  *
  * Immediately output all pending messages no matter what.
