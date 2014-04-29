Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C8D94140106
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 09:16:06 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: [PATCH 2/2] powerpc: fix smp_processor_id() in preemptible splat in
 set_breakpoint
Date: Tue, 29 Apr 2014 15:25:17 -0400
Message-ID: <1398799517-47879-3-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1398799517-47879-1-git-send-email-paul.gortmaker@windriver.com>
References: <1398799517-47879-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, on 8641D, which doesn't set CONFIG_HAVE_HW_BREAKPOINT
we get the following splat:

BUG: using smp_processor_id() in preemptible [00000000] code: login/1382
caller is set_breakpoint+0x1c/0xa0
CPU: 0 PID: 1382 Comm: login Not tainted 3.15.0-rc3-00041-g2aafe1a4d451 #1
Call Trace:
[decd5d80] [c0008dc4] show_stack+0x50/0x158 (unreliable)
[decd5dc0] [c03c6fa0] dump_stack+0x7c/0xdc
[decd5de0] [c01f8818] check_preemption_disabled+0xf4/0x104
[decd5e00] [c00086b8] set_breakpoint+0x1c/0xa0
[decd5e10] [c00d4530] flush_old_exec+0x2bc/0x588
[decd5e40] [c011c468] load_elf_binary+0x2ac/0x1164
[decd5ec0] [c00d35f8] search_binary_handler+0xc4/0x1f8
[decd5ef0] [c00d4ee8] do_execve+0x3d8/0x4b8
[decd5f40] [c001185c] ret_from_syscall+0x0/0x38
 --- Exception: c01 at 0xfeee554
    LR = 0xfeee7d4

The call path in this case is:

	flush_thread
	   --> set_debug_reg_defaults
	     --> set_breakpoint
	       --> __get_cpu_var

Since preemption is enabled in the cleanup of flush thread, and
there is no need to disable it, introduce the distinction between
set_breakpoint and __set_breakpoint, leaving only the flush_thread
instance as the current user of set_breakpoint.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/include/asm/debug.h         |  1 +
 arch/powerpc/include/asm/hw_breakpoint.h |  2 +-
 arch/powerpc/kernel/hw_breakpoint.c      |  8 ++++----
 arch/powerpc/kernel/process.c            | 11 +++++++++--
 arch/powerpc/kernel/signal.c             |  2 +-
 arch/powerpc/xmon/xmon.c                 |  2 +-
 6 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index 1d7f966d3b18..a954e4975049 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -47,6 +47,7 @@ static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 #endif
 
 void set_breakpoint(struct arch_hw_breakpoint *brk);
+void __set_breakpoint(struct arch_hw_breakpoint *brk);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
 			 unsigned long error_code, int signal_code, int brkpt);
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index eb0f4ac75c4c..ac6432d9be46 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -79,7 +79,7 @@ static inline void hw_breakpoint_disable(void)
 	brk.address = 0;
 	brk.type = 0;
 	brk.len = 0;
-	set_breakpoint(&brk);
+	__set_breakpoint(&brk);
 }
 extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
 
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index b0a1792279bb..0bb5918faaaf 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -72,7 +72,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	 * If so, DABR will be populated in single_step_dabr_instruction().
 	 */
 	if (current->thread.last_hit_ubp != bp)
-		set_breakpoint(info);
+		__set_breakpoint(info);
 
 	return 0;
 }
@@ -198,7 +198,7 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 
 	info = counter_arch_bp(tsk->thread.last_hit_ubp);
 	regs->msr &= ~MSR_SE;
-	set_breakpoint(info);
+	__set_breakpoint(info);
 	tsk->thread.last_hit_ubp = NULL;
 }
 
@@ -284,7 +284,7 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	if (!(info->type & HW_BRK_TYPE_EXTRANEOUS_IRQ))
 		perf_bp_event(bp, regs);
 
-	set_breakpoint(info);
+	__set_breakpoint(info);
 out:
 	rcu_read_unlock();
 	return rc;
@@ -316,7 +316,7 @@ int __kprobes single_step_dabr_instruction(struct die_args *args)
 	if (!(info->type & HW_BRK_TYPE_EXTRANEOUS_IRQ))
 		perf_bp_event(bp, regs);
 
-	set_breakpoint(info);
+	__set_breakpoint(info);
 	current->thread.last_hit_ubp = NULL;
 
 	/*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index c4e3d50e86f8..bc2d668b68ed 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -495,7 +495,7 @@ static inline int set_dawr(struct arch_hw_breakpoint *brk)
 	return 0;
 }
 
-void set_breakpoint(struct arch_hw_breakpoint *brk)
+void __set_breakpoint(struct arch_hw_breakpoint *brk)
 {
 	__get_cpu_var(current_brk) = *brk;
 
@@ -505,6 +505,13 @@ void set_breakpoint(struct arch_hw_breakpoint *brk)
 		set_dabr(brk);
 }
 
+void set_breakpoint(struct arch_hw_breakpoint *brk)
+{
+	preempt_disable();
+	__set_breakpoint(brk);
+	preempt_enable();
+}
+
 #ifdef CONFIG_PPC64
 DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
 #endif
@@ -834,7 +841,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
  */
 #ifndef CONFIG_HAVE_HW_BREAKPOINT
 	if (unlikely(!hw_brk_match(&__get_cpu_var(current_brk), &new->thread.hw_brk)))
-		set_breakpoint(&new->thread.hw_brk);
+		__set_breakpoint(&new->thread.hw_brk);
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
 
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 8fc4177ed65a..1c794cef2883 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -134,7 +134,7 @@ static int do_signal(struct pt_regs *regs)
 	 */
 	if (current->thread.hw_brk.address &&
 		current->thread.hw_brk.type)
-		set_breakpoint(&current->thread.hw_brk);
+		__set_breakpoint(&current->thread.hw_brk);
 #endif
 	/* Re-enable the breakpoints for the signal stack */
 	thread_change_pc(current, regs);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 08504e75b2c7..d3759b7a5535 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -759,7 +759,7 @@ static void insert_cpu_bpts(void)
 		brk.address = dabr.address;
 		brk.type = (dabr.enabled & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
 		brk.len = 8;
-		set_breakpoint(&brk);
+		__set_breakpoint(&brk);
 	}
 	if (iabr && cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, iabr->address
-- 
1.9.0
