Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: rename set_break to avoid naming conflict
In-reply-to: <20130110105513.GA19224@localhost>
References: <50ee8554.VPKmpSyDNCfRKVZL%yuanhan.liu@linux.intel.com>
 <20130110105513.GA19224@localhost>
Date: Fri, 11 Jan 2013 11:25:34 +1100
Message-ID: <12844.1357863934@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Fengguang Wu <fengguang.wu@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With allmodconfig we are getting:
  drivers/tty/synclink_gt.c:160:12: error: conflicting types for 'set_break'
  arch/powerpc/include/asm/debug.h:49:5: note: previous declaration of 'set_break' was here

  drivers/tty/synclinkmp.c:526:12: error: conflicting types for 'set_break'
  arch/powerpc/include/asm/debug.h:49:5: note: previous declaration of 'set_break' was here

This renames set_break to set_breakpoint to avoid this naming conflict

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index 8d85ffb..d251630 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -46,7 +46,7 @@ static inline int debugger_break_match(struct pt_regs *regs) { return 0; }
 static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 #endif
 
-int set_break(struct arch_hw_breakpoint *brk);
+int set_breakpoint(struct arch_hw_breakpoint *brk);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
 			 unsigned long error_code, int signal_code, int brkpt);
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 2c91faf..96437e5 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -81,7 +81,7 @@ static inline void hw_breakpoint_disable(void)
 	brk.address = 0;
 	brk.type = 0;
 	brk.len = 0;
-	set_break(&brk);
+	set_breakpoint(&brk);
 }
 extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
 
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index c7483d0..2a3e8dd 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -73,7 +73,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	 * If so, DABR will be populated in single_step_dabr_instruction().
 	 */
 	if (current->thread.last_hit_ubp != bp)
-		set_break(info);
+		set_breakpoint(info);
 
 	return 0;
 }
@@ -191,7 +191,7 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 
 	info = counter_arch_bp(tsk->thread.last_hit_ubp);
 	regs->msr &= ~MSR_SE;
-	set_break(info);
+	set_breakpoint(info);
 	tsk->thread.last_hit_ubp = NULL;
 }
 
@@ -276,7 +276,7 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	if (!(info->type & HW_BRK_TYPE_EXTRANEOUS_IRQ))
 		perf_bp_event(bp, regs);
 
-	set_break(info);
+	set_breakpoint(info);
 out:
 	rcu_read_unlock();
 	return rc;
@@ -308,7 +308,7 @@ int __kprobes single_step_dabr_instruction(struct die_args *args)
 	if (!(info->type & HW_BRK_TYPE_EXTRANEOUS_IRQ))
 		perf_bp_event(bp, regs);
 
-	set_break(info);
+	set_breakpoint(info);
 	current->thread.last_hit_ubp = NULL;
 
 	/*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8d56452..99550d3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -366,7 +366,7 @@ static void set_debug_reg_defaults(struct thread_struct *thread)
 {
 	thread->hw_brk.address = 0;
 	thread->hw_brk.type = 0;
-	set_break(&thread->hw_brk);
+	set_breakpoint(&thread->hw_brk);
 }
 #endif /* !CONFIG_HAVE_HW_BREAKPOINT */
 #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
@@ -427,7 +427,7 @@ static inline int set_dawr(struct arch_hw_breakpoint *brk)
 	return 0;
 }
 
-int set_break(struct arch_hw_breakpoint *brk)
+int set_breakpoint(struct arch_hw_breakpoint *brk)
 {
 	__get_cpu_var(current_brk) = *brk;
 
@@ -538,7 +538,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
  */
 #ifndef CONFIG_HAVE_HW_BREAKPOINT
 	if (unlikely(hw_brk_match(&__get_cpu_var(current_brk), &new->thread.hw_brk)))
-		set_break(&new->thread.hw_brk);
+		set_breakpoint(&new->thread.hw_brk);
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
 
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 1f26956..3003d89 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -132,7 +132,7 @@ static int do_signal(struct pt_regs *regs)
 	 */
 	if (current->thread.hw_brk.address &&
 		current->thread.hw_brk.type)
-		set_break(&current->thread.hw_brk);
+		set_breakpoint(&current->thread.hw_brk);
 #endif
 	/* Re-enable the breakpoints for the signal stack */
 	thread_change_pc(current, regs);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 529c1ed..13f85de 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -747,7 +747,7 @@ static void insert_cpu_bpts(void)
 		brk.address = dabr.address;
 		brk.type = (dabr.enabled & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
 		brk.len = 8;
-		set_break(&brk);
+		set_breakpoint(&brk);
 	}
 	if (iabr && cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, iabr->address
