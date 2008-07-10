Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 3A0F9DDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 23:57:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: latencytop support for powerpc?
Date: Thu, 10 Jul 2008 15:57:22 +0200
References: <48755237.9070701@nortel.com>
In-Reply-To: <48755237.9070701@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807101557.22354.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 July 2008, Chris Friesen wrote:
> Just wondering if anyone has looked at what it would take to support 
> latency top on powerpc?

Just guessing something like the patch below, not more that that, but
without the bugs ;-). Haven't tested at all, so it will probably
fall apart, but give it a try if you like.

Subject: powerpc: support for latencytop

Implement save_stack_trace_tsk on powerpc, so that we can run with
latencytop.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ff5217a..b1fd369 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -53,6 +53,9 @@ config STACKTRACE_SUPPORT
 	bool
 	default y
 
+config HAVE_LATENCYTOP_SUPPORT
+	def_bool y
+
 config TRACE_IRQFLAGS_SUPPORT
 	bool
 	depends on PPC64
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 9861f17..2b8c14d 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -10,19 +10,18 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 #include <asm/ptrace.h>
+#include <asm/processor.h>
 
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
-void save_stack_trace(struct stack_trace *trace)
+static void save_context_stack(struct stack_trace *trace, unsigned long sp,
+			struct task_struct *tsk, int savesched)
 {
-	unsigned long sp;
-
-	asm("mr %0,1" : "=r" (sp));
-
 	for (;;) {
 		unsigned long *stack = (unsigned long *) sp;
 		unsigned long newsp, ip;
@@ -33,10 +32,12 @@ void save_stack_trace(struct stack_trace *trace)
 		newsp = stack[0];
 		ip = stack[STACK_FRAME_LR_SAVE];
 
-		if (!trace->skip)
-			trace->entries[trace->nr_entries++] = ip;
-		else
-			trace->skip--;
+		if (savesched || !in_sched_functions(ip)) {
+			if (!trace->skip)
+				trace->entries[trace->nr_entries++] = ip;
+			else
+				trace->skip--;
+		}
 
 		if (trace->nr_entries >= trace->max_entries)
 			return;
@@ -44,4 +45,19 @@ void save_stack_trace(struct stack_trace *trace)
 		sp = newsp;
 	}
 }
+
+void save_stack_trace(struct stack_trace *trace)
+{
+	unsigned long sp;
+
+	asm("mr %0,1" : "=r" (sp));
+
+	save_context_stack(trace, sp, current, 1);
+}
 EXPORT_SYMBOL_GPL(save_stack_trace);
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	save_context_stack(trace, tsk->thread.regs->gpr[1], tsk, 0);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
