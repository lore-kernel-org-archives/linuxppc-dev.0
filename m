Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40csFJ03y8zDsQ6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:45:55 +1000 (AEST)
Date: Fri, 4 May 2018 14:38:34 +0200
From: Torsten Duwe <duwe@lst.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: [PATCH v3] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20180504123834.GA16581@lst.de>
References: <20180305164928.GA17953@lst.de>
 <20180308162616.yhbymodggnfzpskx@treble>
 <20180309174718.2700b29e@blackhole.lan>
 <20180312153536.7avozx64ku4lvd3e@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180312153536.7avozx64ku4lvd3e@treble>
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

Feel free to add other ppc variants, but so far only ppc64le got tested.

This change also implements save_stack_trace_tsk_reliable() for ppc64le
that checks for the above conditions, where possible.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Nicolai Stange <nstange@suse.de>

---
v3:
 * big bunch of fixes, credits go to Nicolai Stange:
   - get the correct return address from the graph tracer,
     should it be active.
     IMO this should be moved into to generic code, but I'll
     leave it like this for now, to get things going.
   - bail out on a kretprobe
   - also stop at an exception frame
   - accomodate for the different stack layout of the idle task
   - use an even more beautiful test: __kernel_text_address()

v2:
 * implemented save_stack_trace_tsk_reliable(), with a bunch of sanity
   checks. The test for a kernel code pointer is much nicer now, and
   the exit condition is exact (when compared to last week's follow-up)

---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c32a181a7cbb..54f1daf4f9e5 100644
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
index d534ed901538..3d62ecb2587b 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -2,7 +2,7 @@
  * Stack trace utility
  *
  * Copyright 2008 Christoph Hellwig, IBM Corp.
- *
+ * Copyright 2018 SUSE Linux GmbH
  *
  *      This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
@@ -11,11 +11,16 @@
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
+#include <linux/ftrace.h>
+#include <asm/kprobes.h>
 
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
@@ -76,3 +81,114 @@ save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
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
+	unsigned long stack_end;
+	int graph_idx = 0;
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
+	stack_end = stack_page + THREAD_SIZE;
+	if (!is_idle_task(tsk)) {
+		/*
+		 * For user tasks, this is the SP value loaded on
+		 * kernel entry, see "PACAKSAVE(r13)" in _switch() and
+		 * system_call_common()/EXCEPTION_PROLOG_COMMON().
+		 *
+		 * Likewise for non-swapper kernel threads,
+		 * this also happens to be the top of the stack
+		 * as setup by copy_thread().
+		 *
+		 * Note that stack backlinks are not properly setup by
+		 * copy_thread() and thus, a forked task() will have
+		 * an unreliable stack trace until it's been
+		 * _switch()'ed to for the first time.
+		 */
+		stack_end -= STACK_FRAME_OVERHEAD + sizeof(struct pt_regs);
+	} else {
+		/*
+		 * idle tasks have a custom stack layout,
+		 * c.f. cpu_idle_thread_init().
+		 */
+		stack_end -= STACK_FRAME_OVERHEAD;
+	}
+
+	if (sp < stack_page + sizeof(struct thread_struct) ||
+	    sp > stack_end - STACK_FRAME_MIN_SIZE) {
+		return 1;
+	}
+
+	for (;;) {
+		unsigned long *stack = (unsigned long *) sp;
+		unsigned long newsp, ip;
+
+		/* sanity check: ABI requires SP to be aligned 16 bytes. */
+		if (sp & 0xF)
+			return 1;
+
+		/* Mark stacktraces with exception frames as unreliable. */
+		if (sp <= stack_end - STACK_INT_FRAME_SIZE &&
+		    stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
+			return 1;
+		}
+
+		newsp = stack[0];
+		/* Stack grows downwards; unwinder may only go up. */
+		if (newsp <= sp)
+			return 1;
+
+		if (newsp != stack_end &&
+		    newsp > stack_end - STACK_FRAME_MIN_SIZE) {
+			return 1; /* invalid backlink, too far up. */
+		}
+
+		/* Examine the saved LR: it must point into kernel code. */
+		ip = stack[STACK_FRAME_LR_SAVE];
+		if (!firstframe && !__kernel_text_address(ip))
+			return 1;
+		firstframe = 0;
+
+		/*
+		 * FIXME: IMHO these tests do not belong in
+		 * arch-dependent code, they are generic.
+		 */
+		ip = ftrace_graph_ret_addr(tsk, &graph_idx, ip, NULL);
+
+		/*
+		 * Mark stacktraces with kretprobed functions on them
+		 * as unreliable.
+		 */
+		if (ip == (unsigned long)kretprobe_trampoline)
+			return 1;
+
+		if (!trace->skip)
+			trace->entries[trace->nr_entries++] = ip;
+		else
+			trace->skip--;
+
+		if (newsp == stack_end)
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
