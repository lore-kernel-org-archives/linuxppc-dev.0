Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZgmZ1k1bzDsXr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 00:30:05 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id pp5so2200240pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 07:30:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] powerpc: do not use kprobe section to exempt exception
 handlers
Date: Fri, 16 Sep 2016 00:29:44 +1000
Message-Id: <20160915142944.9322-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the blacklist macros instead. This allows the linker to move
exception handler functions close to callers and avoids trampolines in
larger kernels.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/asm-prototypes.h |  6 +++---
 arch/powerpc/kernel/hw_breakpoint.c       |  9 ++++++---
 arch/powerpc/kernel/traps.c               | 21 ++++++++++++++-------
 arch/powerpc/mm/fault.c                   |  4 ++--
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index e71b909..b1c3abe 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -52,8 +52,8 @@ void SMIException(struct pt_regs *regs);
 void handle_hmi_exception(struct pt_regs *regs);
 void instruction_breakpoint_exception(struct pt_regs *regs);
 void RunModeException(struct pt_regs *regs);
-void __kprobes single_step_exception(struct pt_regs *regs);
-void __kprobes program_check_exception(struct pt_regs *regs);
+void single_step_exception(struct pt_regs *regs);
+void program_check_exception(struct pt_regs *regs);
 void alignment_exception(struct pt_regs *regs);
 void StackOverflow(struct pt_regs *regs);
 void nonrecoverable_exception(struct pt_regs *regs);
@@ -70,6 +70,6 @@ void unrecoverable_exception(struct pt_regs *regs);
 void kernel_bad_stack(struct pt_regs *regs);
 void system_reset_exception(struct pt_regs *regs);
 void machine_check_exception(struct pt_regs *regs);
-void __kprobes emulation_assist_interrupt(struct pt_regs *regs);
+void emulation_assist_interrupt(struct pt_regs *regs);
 
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index aec9a1b..9781c69 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -206,7 +206,7 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 /*
  * Handle debug exception notifications.
  */
-int __kprobes hw_breakpoint_handler(struct die_args *args)
+int hw_breakpoint_handler(struct die_args *args)
 {
 	int rc = NOTIFY_STOP;
 	struct perf_event *bp;
@@ -290,11 +290,12 @@ out:
 	rcu_read_unlock();
 	return rc;
 }
+NOKPROBE_SYMBOL(hw_breakpoint_handler);
 
 /*
  * Handle single-step exceptions following a DABR hit.
  */
-static int __kprobes single_step_dabr_instruction(struct die_args *args)
+static int single_step_dabr_instruction(struct die_args *args)
 {
 	struct pt_regs *regs = args->regs;
 	struct perf_event *bp = NULL;
@@ -329,11 +330,12 @@ static int __kprobes single_step_dabr_instruction(struct die_args *args)
 
 	return NOTIFY_STOP;
 }
+NOKPROBE_SYMBOL(single_step_dabr_instruction);
 
 /*
  * Handle debug exception notifications.
  */
-int __kprobes hw_breakpoint_exceptions_notify(
+int hw_breakpoint_exceptions_notify(
 		struct notifier_block *unused, unsigned long val, void *data)
 {
 	int ret = NOTIFY_DONE;
@@ -349,6 +351,7 @@ int __kprobes hw_breakpoint_exceptions_notify(
 
 	return ret;
 }
+NOKPROBE_SYMBOL(hw_breakpoint_exceptions_notify);
 
 /*
  * Release the user breakpoints used by ptrace
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 62859eb..7cbd6cf 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -117,7 +117,7 @@ static int die_owner = -1;
 static unsigned int die_nest_count;
 static int die_counter;
 
-static unsigned __kprobes long oops_begin(struct pt_regs *regs)
+static unsigned long oops_begin(struct pt_regs *regs)
 {
 	int cpu;
 	unsigned long flags;
@@ -144,8 +144,9 @@ static unsigned __kprobes long oops_begin(struct pt_regs *regs)
 		pmac_backlight_unblank();
 	return flags;
 }
+NOKPROBE_SYMBOL(oops_begin);
 
-static void __kprobes oops_end(unsigned long flags, struct pt_regs *regs,
+static void oops_end(unsigned long flags, struct pt_regs *regs,
 			       int signr)
 {
 	bust_spinlocks(0);
@@ -196,8 +197,9 @@ static void __kprobes oops_end(unsigned long flags, struct pt_regs *regs,
 		panic("Fatal exception");
 	do_exit(signr);
 }
+NOKPROBE_SYMBOL(oops_end);
 
-static int __kprobes __die(const char *str, struct pt_regs *regs, long err)
+static int __die(const char *str, struct pt_regs *regs, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 #ifdef CONFIG_PREEMPT
@@ -221,6 +223,7 @@ static int __kprobes __die(const char *str, struct pt_regs *regs, long err)
 
 	return 0;
 }
+NOKPROBE_SYMBOL(__die);
 
 void die(const char *str, struct pt_regs *regs, long err)
 {
@@ -802,7 +805,7 @@ void RunModeException(struct pt_regs *regs)
 	_exception(SIGTRAP, regs, 0, 0);
 }
 
-void __kprobes single_step_exception(struct pt_regs *regs)
+void single_step_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
 
@@ -819,6 +822,7 @@ void __kprobes single_step_exception(struct pt_regs *regs)
 bail:
 	exception_exit(prev_state);
 }
+NOKPROBE_SYMBOL(single_step_exception);
 
 /*
  * After we have successfully emulated an instruction, we have to
@@ -1140,7 +1144,7 @@ static int emulate_math(struct pt_regs *regs)
 static inline int emulate_math(struct pt_regs *regs) { return -1; }
 #endif
 
-void __kprobes program_check_exception(struct pt_regs *regs)
+void program_check_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
 	unsigned int reason = get_reason(regs);
@@ -1260,16 +1264,18 @@ sigill:
 bail:
 	exception_exit(prev_state);
 }
+NOKPROBE_SYMBOL(program_check_exception);
 
 /*
  * This occurs when running in hypervisor mode on POWER6 or later
  * and an illegal instruction is encountered.
  */
-void __kprobes emulation_assist_interrupt(struct pt_regs *regs)
+void emulation_assist_interrupt(struct pt_regs *regs)
 {
 	regs->msr |= REASON_ILLEGAL;
 	program_check_exception(regs);
 }
+NOKPROBE_SYMBOL(emulation_assist_interrupt);
 
 void alignment_exception(struct pt_regs *regs)
 {
@@ -1656,7 +1662,7 @@ static void handle_debug(struct pt_regs *regs, unsigned long debug_status)
 		mtspr(SPRN_DBCR0, current->thread.debug.dbcr0);
 }
 
-void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
+void DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
 	current->thread.debug.dbsr = debug_status;
 
@@ -1717,6 +1723,7 @@ void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 	} else
 		handle_debug(regs, debug_status);
 }
+NOKPROBE_SYMBOL(DebugException);
 #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 
 #if !defined(CONFIG_TAU_INT)
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index bb1ffc5..d0b137d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -205,7 +205,7 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
  * The return value is 0 if the fault was handled, or the signal
  * number if this is a kernel fault that can't be handled here.
  */
-int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
+int do_page_fault(struct pt_regs *regs, unsigned long address,
 			    unsigned long error_code)
 {
 	enum ctx_state prev_state = exception_enter();
@@ -498,8 +498,8 @@ bad_area_nosemaphore:
 bail:
 	exception_exit(prev_state);
 	return rc;
-
 }
+NOKPROBE_SYMBOL(do_page_fault);
 
 /*
  * bad_page_fault is called when we have a bad access from the kernel.
-- 
2.9.3
