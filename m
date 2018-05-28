Return-Path: <hoeun.ryu@lge.com.com>
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
 by lists.ozlabs.org (Postfix) with ESMTP id 40vvFS6wzMzDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 10:08:12 +1000 (AEST)
From: Hoeun Ryu <hoeun.ryu@lge.com.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cyril Bur <cyrilbur@gmail.com>,
 Ram Pai <linuxram@us.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Neuling <mikey@neuling.org>, Thomas Gleixner <tglx@linutronix.de>,
 Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
 Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 "Liu, Changcheng" <changcheng.liu@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hoeun Ryu <hoeun.ryu@lge.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org
Subject: [PATCH] printk: make printk_safe_flush safe in NMI context
Date: Tue, 29 May 2018 08:34:14 +0900
Message-Id: <1527550647-3953-1-git-send-email-hoeun.ryu@lge.com.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hoeun Ryu <hoeun.ryu@lge.com>

 Make printk_safe_flush() safe in NMI context. And printk_safe_flush_on_panic() is
folded into this function. The prototype of printk_safe_flush() is changed to
"void printk_safe_flush(bool panic)".

 nmi_trigger_cpumask_backtrace() can be called in NMI context. For example the
function is called in watchdog_overflow_callback() if the flag of hardlockup
backtrace (sysctl_hardlockup_all_cpu_backtrace) is true and
watchdog_overflow_callback() function is called in NMI context on some
architectures.
 Calling printk_safe_flush() in nmi_trigger_cpumask_backtrace() eventually tries to
lock logbuf_lock in vprintk_emit() but the logbuf_lock can be already locked in
preempted contexts (task or irq in this case) or by other CPUs and it may cause
deadlocks.
 By making printk_safe_flush() safe in NMI context, the backtrace triggering CPU
just skips flushing if the lock is not avaiable in NMI context. The messages in
per-cpu nmi buffer of the backtrace triggering CPU can be lost if the CPU is in
hard lockup (because irq is disabled here) but if panic() is not called. The
flushing can be delayed by the next irq work in normal cases.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Hoeun Ryu <hoeun.ryu@lge.com>
---
 arch/powerpc/kernel/traps.c    |  2 +-
 arch/powerpc/kernel/watchdog.c |  2 +-
 include/linux/printk.h         |  9 ++----
 kernel/kexec_core.c            |  2 +-
 kernel/panic.c                 |  4 +--
 kernel/printk/printk_safe.c    | 62 +++++++++++++++++++++---------------------
 lib/nmi_backtrace.c            |  2 +-
 7 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0904492..c50749c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -160,7 +160,7 @@ extern void panic_flush_kmsg_start(void)
 
 extern void panic_flush_kmsg_end(void)
 {
-	printk_safe_flush_on_panic();
+	printk_safe_flush(true);
 	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(0);
 	debug_locks_off();
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 6256dc3..3c9138b 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -173,7 +173,7 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 
 	wd_smp_unlock(&flags);
 
-	printk_safe_flush();
+	printk_safe_flush(false);
 	/*
 	 * printk_safe_flush() seems to require another print
 	 * before anything actually goes out to console.
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6d7e800..495fe26 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -203,8 +203,7 @@ void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack(void) __cold;
 extern void printk_safe_init(void);
-extern void printk_safe_flush(void);
-extern void printk_safe_flush_on_panic(void);
+extern void printk_safe_flush(bool panic);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -273,11 +272,7 @@ static inline void printk_safe_init(void)
 {
 }
 
-static inline void printk_safe_flush(void)
-{
-}
-
-static inline void printk_safe_flush_on_panic(void)
+static inline void printk_safe_flush(bool panic)
 {
 }
 #endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 20fef1a..1b0876e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -961,7 +961,7 @@ void crash_kexec(struct pt_regs *regs)
 	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
 	if (old_cpu == PANIC_CPU_INVALID) {
 		/* This is the 1st CPU which comes here, so go ahead. */
-		printk_safe_flush_on_panic();
+		printk_safe_flush(true);
 		__crash_kexec(regs);
 
 		/*
diff --git a/kernel/panic.c b/kernel/panic.c
index 42e4874..2f2c86c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -193,7 +193,7 @@ void panic(const char *fmt, ...)
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
 	if (!_crash_kexec_post_notifiers) {
-		printk_safe_flush_on_panic();
+		printk_safe_flush(true);
 		__crash_kexec(NULL);
 
 		/*
@@ -218,7 +218,7 @@ void panic(const char *fmt, ...)
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
 	/* Call flush even twice. It tries harder with a single online CPU */
-	printk_safe_flush_on_panic();
+	printk_safe_flush(true);
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 3e3c200..35ea941 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -244,49 +244,49 @@ static void __printk_safe_flush(struct irq_work *work)
 }
 
 /**
- * printk_safe_flush - flush all per-cpu nmi buffers.
+ * printk_safe_flush - flush all per-cpu nmi buffers. it can be called even in NMI
+ *                     context.
+ * @panic: true when the system goes down. It does the best effort to get NMI messages
+ *         into the main ring buffer. Note that it could try harder when there is only
+ *         one CPU online.
  *
- * The buffers are flushed automatically via IRQ work. This function
+ * The buffers are flushed automatically via IRQ work in normal cases. This function
  * is useful only when someone wants to be sure that all buffers have
  * been flushed at some point.
  */
-void printk_safe_flush(void)
+void printk_safe_flush(bool panic)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
-#ifdef CONFIG_PRINTK_NMI
-		__printk_safe_flush(&per_cpu(nmi_print_seq, cpu).work);
-#endif
-		__printk_safe_flush(&per_cpu(safe_print_seq, cpu).work);
-	}
-}
-
-/**
- * printk_safe_flush_on_panic - flush all per-cpu nmi buffers when the system
- *	goes down.
- *
- * Similar to printk_safe_flush() but it can be called even in NMI context when
- * the system goes down. It does the best effort to get NMI messages into
- * the main ring buffer.
- *
- * Note that it could try harder when there is only one CPU online.
- */
-void printk_safe_flush_on_panic(void)
-{
 	/*
 	 * Make sure that we could access the main ring buffer.
-	 * Do not risk a double release when more CPUs are up.
+	 * Do not risk a double release when more CPUs are up on panic.
 	 */
-	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
-		if (num_online_cpus() > 1)
+	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK) {
+		if (panic) {
+			if (num_online_cpus() > 1)
+				return;
+
+			debug_locks_off();
+			raw_spin_lock_init(&logbuf_lock);
+		} else {
+			/*
+			 * Just avoid deadlocks here, we could loose the messages in
+			 * per-cpu nmi buffer in the case that hardlockup happens but
+			 * panic() is not called (irq_work won't work).
+			 * The flushing can be delayed by the next irq_work if flushing
+			 * is skiped here in normal cases.
+			 */
 			return;
-
-		debug_locks_off();
-		raw_spin_lock_init(&logbuf_lock);
+		}
 	}
 
-	printk_safe_flush();
+	for_each_possible_cpu(cpu) {
+#ifdef CONFIG_PRINTK_NMI
+		__printk_safe_flush(&per_cpu(nmi_print_seq, cpu).work);
+#endif
+		__printk_safe_flush(&per_cpu(safe_print_seq, cpu).work);
+	}
 }
 
 #ifdef CONFIG_PRINTK_NMI
@@ -404,5 +404,5 @@ void __init printk_safe_init(void)
 	printk_safe_irq_ready = 1;
 
 	/* Flush pending messages that did not have scheduled IRQ works. */
-	printk_safe_flush();
+	printk_safe_flush(false);
 }
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 61a6b5a..6781698 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -79,7 +79,7 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 	 * Force flush any remote buffers that might be stuck in IRQ context
 	 * and therefore could not run their irq_work.
 	 */
-	printk_safe_flush();
+	printk_safe_flush(false);
 
 	clear_bit_unlock(0, &backtrace_flag);
 	put_cpu();
-- 
2.1.4
