Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zw5V46YcCzF0qS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 03:49:32 +1100 (AEDT)
Date: Mon, 5 Mar 2018 17:49:28 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <jpoimboe@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: [PATCH v2] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20180305164928.GA17953@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "Power Architecture 64-Bit ELF V2 ABI" says in section 2.3.2.3:

[...] There are several rules that must be adhered to in order to ensure
reliable and consistent call chain backtracing:

* Before a function calls any other function, it shall establish its
  own stack frame, whose size shall be a multiple of 16 bytes.

 – In instances where a function’s prologue creates a stack frame, the
   back-chain word of the stack frame shall be updated atomically with
   the value of the stack pointer (r1) when a back chain is implemented.
   (This must be supported as default by all ELF V2 ABI-compliant
   environments.)
[...]
 – The function shall save the link register that contains its return
   address in the LR save doubleword of its caller’s stack frame before
   calling another function.

To me this sounds like the equivalent of HAVE_RELIABLE_STACKTRACE.
This patch may be unneccessarily limited to ppc64le, but OTOH the only
user of this flag so far is livepatching, which is only implemented on
PPCs with 64-LE, a.k.a. ELF ABI v2.

This change also implements save_stack_trace_tsk_reliable() for ppc64
that checks for the above conditions, where possible.

Signed-off-by:   Torsten Duwe <duwe@suse.de>

---
v2:
 * implemented save_stack_trace_tsk_reliable(), with a bunch of sanity
   checks. The test for a kernel code pointer is much nicer now, and
   the exit condition is exact (when compared to last week's follow-up)

---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd07642..9f49913e19e3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -220,6 +220,7 @@ config PPC
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE		if SMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RELIABLE_STACKTRACE		if PPC64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index d534ed901538..e14c2dfd5311 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -11,8 +11,11 @@
  */
 
 #include <linux/export.h>
+#include <linux/kallsyms.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -76,3 +79,77 @@ save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	save_context_stack(trace, regs->gpr[1], current, 0);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_regs);
+
+#ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
+int
+save_stack_trace_tsk_reliable(struct task_struct *tsk,
+				struct stack_trace *trace)
+{
+	unsigned long sp;
+	unsigned long stack_page = (unsigned long)task_stack_page(tsk);
+
+	/* The last frame (unwinding first) may not yet have saved
+	 * its LR onto the stack.
+	 */
+	int firstframe = 1;
+
+	if (tsk == current)
+		sp = current_stack_pointer();
+	else
+		sp = tsk->thread.ksp;
+
+	if (sp < stack_page + sizeof(struct thread_struct)
+	    || sp > stack_page + THREAD_SIZE - STACK_FRAME_OVERHEAD)
+		return 1;
+
+	for (;;) {
+		unsigned long *stack = (unsigned long *) sp;
+		unsigned long newsp, ip;
+
+		/* sanity check: ABI requires SP to be aligned 16 bytes. */
+		if (sp & 0xF)
+			return 1;
+
+		newsp = stack[0];
+		/* Stack grows downwards; unwinder may only go up. */
+		if (newsp <= sp)
+			return 1;
+
+		if (newsp >= stack_page + THREAD_SIZE)
+			return 1; /* invalid backlink, too far up. */
+
+		/* Examine the saved LR: it must point into kernel code. */
+		ip = stack[STACK_FRAME_LR_SAVE];
+		if (!firstframe) {
+			if (!func_ptr_is_kernel_text((void *)ip)) {
+#ifdef CONFIG_MODULES
+				struct module *mod = __module_text_address(ip);
+
+				if (!mod)
+#endif
+					return 1;
+			}
+		}
+		firstframe = 0;
+
+		if (!trace->skip)
+			trace->entries[trace->nr_entries++] = ip;
+		else
+			trace->skip--;
+
+		/* SP value loaded on kernel entry, see "PACAKSAVE(r13)" in
+		 * _switch() and system_call_common()
+		 */
+		if (newsp == stack_page + THREAD_SIZE - /* SWITCH_FRAME_SIZE */
+		    (STACK_FRAME_OVERHEAD + sizeof(struct pt_regs)))
+			break;
+
+		if (trace->nr_entries >= trace->max_entries)
+			return -E2BIG;
+
+		sp = newsp;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk_reliable);
+#endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
