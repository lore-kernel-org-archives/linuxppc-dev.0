Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 6/7] powerpc: Hardware breakpoints rewrite to handle non DABR
 breakpoint registers
Date: Fri, 21 Dec 2012 11:06:44 +1100
Message-Id: <1356048405-20560-7-git-send-email-mikey@neuling.org>
In-Reply-To: <1356048405-20560-1-git-send-email-mikey@neuling.org>
References: <1356048405-20560-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a rewrite so that we don't assume we are using the DABR throughout the
code.  We now use the arch_hw_breakpoint to store the breakpoint in a generic
manner in the thread_struct, rather than storing the raw DABR value.

The ptrace GET/SET_DEBUGREG interface currently passes the raw DABR in from
userspace.  We keep this functionality, so that future changes (like the POWER8
DAWR), will still fake the DABR to userspace.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/debug.h         |   15 ++++---
 arch/powerpc/include/asm/hw_breakpoint.h |   33 +++++++++++---
 arch/powerpc/include/asm/processor.h     |    4 +-
 arch/powerpc/include/asm/reg.h           |    3 --
 arch/powerpc/kernel/exceptions-64s.S     |    2 +-
 arch/powerpc/kernel/hw_breakpoint.c      |   72 +++++++++++++-----------------
 arch/powerpc/kernel/kgdb.c               |   10 ++---
 arch/powerpc/kernel/process.c            |   67 ++++++++++++++++++---------
 arch/powerpc/kernel/ptrace.c             |   60 +++++++++++++------------
 arch/powerpc/kernel/ptrace32.c           |    8 +++-
 arch/powerpc/kernel/signal.c             |    5 ++-
 arch/powerpc/kernel/traps.c              |    4 +-
 arch/powerpc/mm/fault.c                  |    4 +-
 arch/powerpc/xmon/xmon.c                 |   21 ++++++---
 14 files changed, 180 insertions(+), 128 deletions(-)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index 32de257..8d85ffb 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -4,6 +4,8 @@
 #ifndef _ASM_POWERPC_DEBUG_H
 #define _ASM_POWERPC_DEBUG_H
 
+#include <asm/hw_breakpoint.h>
+
 struct pt_regs;
 
 extern struct dentry *powerpc_debugfs_root;
@@ -15,7 +17,7 @@ extern int (*__debugger_ipi)(struct pt_regs *regs);
 extern int (*__debugger_bpt)(struct pt_regs *regs);
 extern int (*__debugger_sstep)(struct pt_regs *regs);
 extern int (*__debugger_iabr_match)(struct pt_regs *regs);
-extern int (*__debugger_dabr_match)(struct pt_regs *regs);
+extern int (*__debugger_break_match)(struct pt_regs *regs);
 extern int (*__debugger_fault_handler)(struct pt_regs *regs);
 
 #define DEBUGGER_BOILERPLATE(__NAME) \
@@ -31,7 +33,7 @@ DEBUGGER_BOILERPLATE(debugger_ipi)
 DEBUGGER_BOILERPLATE(debugger_bpt)
 DEBUGGER_BOILERPLATE(debugger_sstep)
 DEBUGGER_BOILERPLATE(debugger_iabr_match)
-DEBUGGER_BOILERPLATE(debugger_dabr_match)
+DEBUGGER_BOILERPLATE(debugger_break_match)
 DEBUGGER_BOILERPLATE(debugger_fault_handler)
 
 #else
@@ -40,17 +42,18 @@ static inline int debugger_ipi(struct pt_regs *regs) { return 0; }
 static inline int debugger_bpt(struct pt_regs *regs) { return 0; }
 static inline int debugger_sstep(struct pt_regs *regs) { return 0; }
 static inline int debugger_iabr_match(struct pt_regs *regs) { return 0; }
-static inline int debugger_dabr_match(struct pt_regs *regs) { return 0; }
+static inline int debugger_break_match(struct pt_regs *regs) { return 0; }
 static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 #endif
 
-extern int set_dabr(unsigned long dabr, unsigned long dabrx);
+int set_break(struct arch_hw_breakpoint *brk);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
 			 unsigned long error_code, int signal_code, int brkpt);
 #else
-extern void do_dabr(struct pt_regs *regs, unsigned long address,
-		    unsigned long error_code);
+
+extern void do_break(struct pt_regs *regs, unsigned long address,
+		     unsigned long error_code);
 #endif
 
 #endif /* _ASM_POWERPC_DEBUG_H */
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 4234245..2c91faf 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -24,16 +24,30 @@
 #define _PPC_BOOK3S_64_HW_BREAKPOINT_H
 
 #ifdef	__KERNEL__
-#ifdef CONFIG_HAVE_HW_BREAKPOINT
-
 struct arch_hw_breakpoint {
 	unsigned long	address;
-	unsigned long	dabrx;
-	int		type;
-	u8		len; /* length of the target data symbol */
-	bool		extraneous_interrupt;
+	u16		type;
+	u16		len; /* length of the target data symbol */
 };
 
+/* Note: Don't change the the first 6 bits below as they are in the same order
+ * as the dabr and dabrx.
+ */
+#define HW_BRK_TYPE_READ		0x01
+#define HW_BRK_TYPE_WRITE		0x02
+#define HW_BRK_TYPE_TRANSLATE		0x04
+#define HW_BRK_TYPE_USER		0x08
+#define HW_BRK_TYPE_KERNEL		0x10
+#define HW_BRK_TYPE_HYP			0x20
+#define HW_BRK_TYPE_EXTRANEOUS_IRQ	0x80
+
+/* bits that overlap with the bottom 3 bits of the dabr */
+#define HW_BRK_TYPE_RDWR	(HW_BRK_TYPE_READ | HW_BRK_TYPE_WRITE)
+#define HW_BRK_TYPE_DABR	(HW_BRK_TYPE_RDWR | HW_BRK_TYPE_TRANSLATE)
+#define HW_BRK_TYPE_PRIV_ALL	(HW_BRK_TYPE_USER | HW_BRK_TYPE_KERNEL | \
+				 HW_BRK_TYPE_HYP)
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
 #include <linux/kdebug.h>
 #include <asm/reg.h>
 #include <asm/debug.h>
@@ -62,7 +76,12 @@ extern void ptrace_triggered(struct perf_event *bp,
 			struct perf_sample_data *data, struct pt_regs *regs);
 static inline void hw_breakpoint_disable(void)
 {
-	set_dabr(0, 0);
+	struct arch_hw_breakpoint brk;
+
+	brk.address = 0;
+	brk.type = 0;
+	brk.len = 0;
+	set_break(&brk);
 }
 extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
 
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index cbbd82d..5a142c5 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -23,6 +23,7 @@
 #include <linux/cache.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
+#include <asm/hw_breakpoint.h>
 
 /* We do _not_ want to define new machine types at all, those must die
  * in favor of using the device-tree
@@ -216,8 +217,7 @@ struct thread_struct {
 	struct perf_event *last_hit_ubp;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
-	unsigned long	dabr;		/* Data address breakpoint register */
-	unsigned long	dabrx;		/*      ... extension  */
+	struct arch_hw_breakpoint hw_brk; /* info on the hardware breakpoint */
 	unsigned long	trap_nr;	/* last trap # on this thread */
 #ifdef CONFIG_ALTIVEC
 	/* Complete AltiVec register set */
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 6cae32d..e9f5c05 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -228,9 +228,6 @@
 #define   DAWRX_KERNEL	(1UL << 1)
 #define   DAWRX_HYP	(1UL << 2)
 #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
-#define   DABR_TRANSLATION	(1UL << 2)
-#define   DABR_DATA_WRITE	(1UL << 1)
-#define   DABR_DATA_READ	(1UL << 0)
 #define SPRN_DABR2	0x13D	/* e300 */
 #define SPRN_DABRX	0x3F7	/* Data Address Breakpoint Register Extension */
 #define   DABRX_USER	(1UL << 0)
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 220b896..8ca5006 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1310,7 +1310,7 @@ handle_dabr_fault:
 	ld      r4,_DAR(r1)
 	ld      r5,_DSISR(r1)
 	addi    r3,r1,STACK_FRAME_OVERHEAD
-	bl      .do_dabr
+	bl      .do_break
 12:	b       .ret_from_except_lite
 
 
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index a89cae4..c7483d0 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -73,7 +73,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	 * If so, DABR will be populated in single_step_dabr_instruction().
 	 */
 	if (current->thread.last_hit_ubp != bp)
-		set_dabr(info->address | info->type | DABR_TRANSLATION, info->dabrx);
+		set_break(info);
 
 	return 0;
 }
@@ -97,7 +97,7 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 	}
 
 	*slot = NULL;
-	set_dabr(0, 0);
+	hw_breakpoint_disable();
 }
 
 /*
@@ -127,19 +127,13 @@ int arch_check_bp_in_kernelspace(struct perf_event *bp)
 
 int arch_bp_generic_fields(int type, int *gen_bp_type)
 {
-	switch (type) {
-	case DABR_DATA_READ:
-		*gen_bp_type = HW_BREAKPOINT_R;
-		break;
-	case DABR_DATA_WRITE:
-		*gen_bp_type = HW_BREAKPOINT_W;
-		break;
-	case (DABR_DATA_WRITE | DABR_DATA_READ):
-		*gen_bp_type = (HW_BREAKPOINT_W | HW_BREAKPOINT_R);
-		break;
-	default:
+	*gen_bp_type = 0;
+	if (type & HW_BRK_TYPE_READ)
+		*gen_bp_type |= HW_BREAKPOINT_R;
+	if (type & HW_BRK_TYPE_WRITE)
+		*gen_bp_type |= HW_BREAKPOINT_W;
+	if (*gen_bp_type == 0)
 		return -EINVAL;
-	}
 	return 0;
 }
 
@@ -154,29 +148,22 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	if (!bp)
 		return ret;
 
-	switch (bp->attr.bp_type) {
-	case HW_BREAKPOINT_R:
-		info->type = DABR_DATA_READ;
-		break;
-	case HW_BREAKPOINT_W:
-		info->type = DABR_DATA_WRITE;
-		break;
-	case HW_BREAKPOINT_R | HW_BREAKPOINT_W:
-		info->type = (DABR_DATA_READ | DABR_DATA_WRITE);
-		break;
-	default:
+	info->type = HW_BRK_TYPE_TRANSLATE;
+	if (bp->attr.bp_type & HW_BREAKPOINT_R)
+		info->type |= HW_BRK_TYPE_READ;
+	if (bp->attr.bp_type & HW_BREAKPOINT_W)
+		info->type |= HW_BRK_TYPE_WRITE;
+	if (info->type == HW_BRK_TYPE_TRANSLATE)
+		/* must set alteast read or write */
 		return ret;
-	}
-
+	if (!(bp->attr.exclude_user))
+		info->type |= HW_BRK_TYPE_USER;
+	if (!(bp->attr.exclude_kernel))
+		info->type |= HW_BRK_TYPE_KERNEL;
+	if (!(bp->attr.exclude_hv))
+		info->type |= HW_BRK_TYPE_HYP;
 	info->address = bp->attr.bp_addr;
 	info->len = bp->attr.bp_len;
-	info->dabrx = DABRX_ALL;
-	if (bp->attr.exclude_user)
-		info->dabrx &= ~DABRX_USER;
-	if (bp->attr.exclude_kernel)
-		info->dabrx &= ~DABRX_KERNEL;
-	if (bp->attr.exclude_hv)
-		info->dabrx &= ~DABRX_HYP;
 
 	/*
 	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
@@ -204,7 +191,7 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 
 	info = counter_arch_bp(tsk->thread.last_hit_ubp);
 	regs->msr &= ~MSR_SE;
-	set_dabr(info->address | info->type | DABR_TRANSLATION, info->dabrx);
+	set_break(info);
 	tsk->thread.last_hit_ubp = NULL;
 }
 
@@ -222,7 +209,7 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	unsigned long dar = regs->dar;
 
 	/* Disable breakpoints during exception handling */
-	set_dabr(0, 0);
+	hw_breakpoint_disable();
 
 	/*
 	 * The counter may be concurrently released but that can only
@@ -255,8 +242,9 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	 * we still need to single-step the instruction, but we don't
 	 * generate an event.
 	 */
-	info->extraneous_interrupt = !((bp->attr.bp_addr <= dar) &&
-			(dar - bp->attr.bp_addr < bp->attr.bp_len));
+	if (!((bp->attr.bp_addr <= dar) &&
+	      (dar - bp->attr.bp_addr < bp->attr.bp_len)))
+		info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
 
 	/* Do not emulate user-space instructions, instead single-step them */
 	if (user_mode(regs)) {
@@ -285,10 +273,10 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	 * As a policy, the callback is invoked in a 'trigger-after-execute'
 	 * fashion
 	 */
-	if (!info->extraneous_interrupt)
+	if (!(info->type & HW_BRK_TYPE_EXTRANEOUS_IRQ))
 		perf_bp_event(bp, regs);
 
-	set_dabr(info->address | info->type | DABR_TRANSLATION, info->dabrx);
+	set_break(info);
 out:
 	rcu_read_unlock();
 	return rc;
@@ -317,10 +305,10 @@ int __kprobes single_step_dabr_instruction(struct die_args *args)
 	 * We shall invoke the user-defined callback function in the single
 	 * stepping handler to confirm to 'trigger-after-execute' semantics
 	 */
-	if (!info->extraneous_interrupt)
+	if (!(info->type & HW_BRK_TYPE_EXTRANEOUS_IRQ))
 		perf_bp_event(bp, regs);
 
-	set_dabr(info->address | info->type | DABR_TRANSLATION, info->dabrx);
+	set_break(info);
 	current->thread.last_hit_ubp = NULL;
 
 	/*
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index c470a40..a05f0e4 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -198,7 +198,7 @@ static int kgdb_iabr_match(struct pt_regs *regs)
 	return 1;
 }
 
-static int kgdb_dabr_match(struct pt_regs *regs)
+static int kgdb_break_match(struct pt_regs *regs)
 {
 	if (user_mode(regs))
 		return 0;
@@ -458,7 +458,7 @@ static void *old__debugger;
 static void *old__debugger_bpt;
 static void *old__debugger_sstep;
 static void *old__debugger_iabr_match;
-static void *old__debugger_dabr_match;
+static void *old__debugger_break_match;
 static void *old__debugger_fault_handler;
 
 int kgdb_arch_init(void)
@@ -468,7 +468,7 @@ int kgdb_arch_init(void)
 	old__debugger_bpt = __debugger_bpt;
 	old__debugger_sstep = __debugger_sstep;
 	old__debugger_iabr_match = __debugger_iabr_match;
-	old__debugger_dabr_match = __debugger_dabr_match;
+	old__debugger_break_match = __debugger_break_match;
 	old__debugger_fault_handler = __debugger_fault_handler;
 
 	__debugger_ipi = kgdb_call_nmi_hook;
@@ -476,7 +476,7 @@ int kgdb_arch_init(void)
 	__debugger_bpt = kgdb_handle_breakpoint;
 	__debugger_sstep = kgdb_singlestep;
 	__debugger_iabr_match = kgdb_iabr_match;
-	__debugger_dabr_match = kgdb_dabr_match;
+	__debugger_break_match = kgdb_break_match;
 	__debugger_fault_handler = kgdb_not_implemented;
 
 	return 0;
@@ -489,6 +489,6 @@ void kgdb_arch_exit(void)
 	__debugger_bpt = old__debugger_bpt;
 	__debugger_sstep = old__debugger_sstep;
 	__debugger_iabr_match = old__debugger_iabr_match;
-	__debugger_dabr_match = old__debugger_dabr_match;
+	__debugger_breakx_match = old__debugger_break_match;
 	__debugger_fault_handler = old__debugger_fault_handler;
 }
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9d591de..5a64028 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -282,7 +282,7 @@ void do_send_trap(struct pt_regs *regs, unsigned long address,
 	force_sig_info(SIGTRAP, &info, current);
 }
 #else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
-void do_dabr(struct pt_regs *regs, unsigned long address,
+void do_break (struct pt_regs *regs, unsigned long address,
 		    unsigned long error_code)
 {
 	siginfo_t info;
@@ -292,11 +292,11 @@ void do_dabr(struct pt_regs *regs, unsigned long address,
 			11, SIGSEGV) == NOTIFY_STOP)
 		return;
 
-	if (debugger_dabr_match(regs))
+	if (debugger_break_match(regs))
 		return;
 
-	/* Clear the DABR */
-	set_dabr(0, 0);
+	/* Clear the breakpoint */
+	hw_breakpoint_disable();
 
 	/* Deliver the signal to userspace */
 	info.si_signo = SIGTRAP;
@@ -307,7 +307,7 @@ void do_dabr(struct pt_regs *regs, unsigned long address,
 }
 #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
 
-static DEFINE_PER_CPU(unsigned long, current_dabr);
+static DEFINE_PER_CPU(struct arch_hw_breakpoint, current_brk);
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 /*
@@ -375,35 +375,50 @@ static void switch_booke_debug_regs(struct thread_struct *new_thread)
 #ifndef CONFIG_HAVE_HW_BREAKPOINT
 static void set_debug_reg_defaults(struct thread_struct *thread)
 {
-	if (thread->dabr) {
-		thread->dabr = 0;
-		thread->dabrx = 0;
-		set_dabr(0, 0);
-	}
+	thread->hw_brk.address = 0;
+	thread->hw_brk.type = 0;
+	set_break(&thread->hw_brk);
 }
 #endif /* !CONFIG_HAVE_HW_BREAKPOINT */
 #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
 
-int set_dabr(unsigned long dabr, unsigned long dabrx)
-{
-	__get_cpu_var(current_dabr) = dabr;
-
-	if (ppc_md.set_dabr)
-		return ppc_md.set_dabr(dabr, dabrx);
-
-	/* XXX should we have a CPU_FTR_HAS_DABR ? */
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
+static inline void __set_dabr(unsigned long dabr, unsigned long dabrx)
+{
 	mtspr(SPRN_DAC1, dabr);
 #ifdef CONFIG_PPC_47x
 	isync();
 #endif
+}
 #elif defined(CONFIG_PPC_BOOK3S)
+static inline void __set_dabr(unsigned long dabr, unsigned long dabrx)
+{
 	mtspr(SPRN_DABR, dabr);
 	mtspr(SPRN_DABRX, dabrx);
+}
 #endif
+
+static inline int set_dabr(struct arch_hw_breakpoint *brk)
+{
+	unsigned long dabr, dabrx;
+
+	dabr = brk->address | (brk->type & HW_BRK_TYPE_DABR);
+	dabrx = ((brk->type >> 3) & 0x7);
+
+	if (ppc_md.set_dabr)
+		return ppc_md.set_dabr(dabr, dabrx);
+
+	__set_dabr(dabr, dabrx);
 	return 0;
 }
 
+int set_break(struct arch_hw_breakpoint *brk)
+{
+	__get_cpu_var(current_brk) = *brk;
+
+	return set_dabr(brk);
+}
+
 #ifdef CONFIG_PPC64
 DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
 #endif
@@ -522,6 +537,18 @@ static inline void __switch_to_tm(struct task_struct *prev)
 #define __switch_to_tm(prev)
 #endif /* CONFIG_TRANSACTIONAL_MEM */
 
+static inline bool hw_brk_match(struct arch_hw_breakpoint *a,
+			      struct arch_hw_breakpoint *b)
+{
+	if (a->address != b->address)
+		return false;
+	if (a->type != b->type)
+		return false;
+	if (a->len != b->len)
+		return false;
+	return true;
+}
+
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
@@ -608,8 +635,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
  * schedule DABR
  */
 #ifndef CONFIG_HAVE_HW_BREAKPOINT
-	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
-		set_dabr(new->thread.dabr, new->thread.dabrx);
+	if (unlikely(hw_brk_match(&__get_cpu_var(current_brk), &new->thread.hw_brk)))
+		set_break(&new->thread.hw_brk);
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
 
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index c497000..d4afccc 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -905,6 +905,9 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	struct perf_event *bp;
 	struct perf_event_attr attr;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
+#ifndef CONFIG_PPC_ADV_DEBUG_REGS
+	struct arch_hw_breakpoint hw_brk;
+#endif
 
 	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
 	 *  For embedded processors we support one DAC and no IAC's at the
@@ -931,14 +934,17 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	 */
 
 	/* Ensure breakpoint translation bit is set */
-	if (data && !(data & DABR_TRANSLATION))
+	if (data && !(data & HW_BRK_TYPE_TRANSLATE))
 		return -EIO;
+	hw_brk.address = data & (~HW_BRK_TYPE_DABR);
+	hw_brk.type = (data & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
+	hw_brk.len = 8;
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	if (ptrace_get_breakpoints(task) < 0)
 		return -ESRCH;
 
 	bp = thread->ptrace_bps[0];
-	if ((!data) || !(data & (DABR_DATA_WRITE | DABR_DATA_READ))) {
+	if ((!data) || !(hw_brk.type & HW_BRK_TYPE_RDWR)) {
 		if (bp) {
 			unregister_hw_breakpoint(bp);
 			thread->ptrace_bps[0] = NULL;
@@ -948,10 +954,8 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	}
 	if (bp) {
 		attr = bp->attr;
-		attr.bp_addr = data & ~HW_BREAKPOINT_ALIGN;
-		arch_bp_generic_fields(data &
-					(DABR_DATA_WRITE | DABR_DATA_READ),
-							&attr.bp_type);
+		attr.bp_addr = hw_brk.address;
+		arch_bp_generic_fields(hw_brk.type, &attr.bp_type);
 
 		/* Enable breakpoint */
 		attr.disabled = false;
@@ -963,16 +967,15 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 		}
 		thread->ptrace_bps[0] = bp;
 		ptrace_put_breakpoints(task);
-		thread->dabr = data;
-		thread->dabrx = DABRX_ALL;
+		thread->hw_brk = hw_brk;
 		return 0;
 	}
 
 	/* Create a new breakpoint request if one doesn't exist already */
 	hw_breakpoint_init(&attr);
-	attr.bp_addr = data & ~HW_BREAKPOINT_ALIGN;
-	arch_bp_generic_fields(data & (DABR_DATA_WRITE | DABR_DATA_READ),
-								&attr.bp_type);
+	attr.bp_addr = hw_brk.address;
+	arch_bp_generic_fields(hw_brk.type,
+			       &attr.bp_type);
 
 	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
 					       ptrace_triggered, NULL, task);
@@ -985,10 +988,7 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	ptrace_put_breakpoints(task);
 
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
-
-	/* Move contents to the DABR register */
-	task->thread.dabr = data;
-	task->thread.dabrx = DABRX_ALL;
+	task->thread.hw_brk = hw_brk;
 #else /* CONFIG_PPC_ADV_DEBUG_REGS */
 	/* As described above, it was assumed 3 bits were passed with the data
 	 *  address, but we will assume only the mode bits will be passed
@@ -1349,7 +1349,7 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	struct perf_event_attr attr;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #ifndef CONFIG_PPC_ADV_DEBUG_REGS
-	unsigned long dabr;
+	struct arch_hw_breakpoint brk;
 #endif
 
 	if (bp_info->version != 1)
@@ -1397,12 +1397,12 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	if ((unsigned long)bp_info->addr >= TASK_SIZE)
 		return -EIO;
 
-	dabr = (unsigned long)bp_info->addr & ~7UL;
-	dabr |= DABR_TRANSLATION;
+	brk.address = bp_info->addr & ~7UL;
+	brk.type = HW_BRK_TYPE_TRANSLATE;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
-		dabr |= DABR_DATA_READ;
+		brk.type |= HW_BRK_TYPE_READ;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
-		dabr |= DABR_DATA_WRITE;
+		brk.type |= HW_BRK_TYPE_WRITE;
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	if (ptrace_get_breakpoints(child) < 0)
 		return -ESRCH;
@@ -1427,8 +1427,7 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	hw_breakpoint_init(&attr);
 	attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
 	attr.bp_len = len;
-	arch_bp_generic_fields(dabr & (DABR_DATA_WRITE | DABR_DATA_READ),
-								&attr.bp_type);
+	arch_bp_generic_fields(brk.type, &attr.bp_type);
 
 	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
 					       ptrace_triggered, NULL, child);
@@ -1445,11 +1444,10 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT)
 		return -EINVAL;
 
-	if (child->thread.dabr)
+	if (child->thread.hw_brk.address)
 		return -ENOSPC;
 
-	child->thread.dabr = dabr;
-	child->thread.dabrx = DABRX_ALL;
+	child->thread.hw_brk = brk;
 
 	return 1;
 #endif /* !CONFIG_PPC_ADV_DEBUG_DVCS */
@@ -1495,10 +1493,11 @@ static long ppc_del_hwdebug(struct task_struct *child, long data)
 	ptrace_put_breakpoints(child);
 	return ret;
 #else /* CONFIG_HAVE_HW_BREAKPOINT */
-	if (child->thread.dabr == 0)
+	if (child->thread.hw_brk.address == 0)
 		return -ENOENT;
 
-	child->thread.dabr = 0;
+	child->thread.hw_brk.address = 0;
+	child->thread.hw_brk.type = 0;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	return 0;
@@ -1642,6 +1641,9 @@ long arch_ptrace(struct task_struct *child, long request,
 	}
 
 	case PTRACE_GET_DEBUGREG: {
+#ifndef CONFIG_PPC_ADV_DEBUG_REGS
+		unsigned long dabr_fake;
+#endif
 		ret = -EINVAL;
 		/* We only support one DABR and no IABRS at the moment */
 		if (addr > 0)
@@ -1649,7 +1651,9 @@ long arch_ptrace(struct task_struct *child, long request,
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		ret = put_user(child->thread.dac1, datalp);
 #else
-		ret = put_user(child->thread.dabr, datalp);
+		dabr_fake = ((child->thread.hw_brk.address & (~HW_BRK_TYPE_DABR)) |
+			     (child->thread.hw_brk.type & HW_BRK_TYPE_DABR));
+		ret = put_user(dabr_fake, datalp);
 #endif
 		break;
 	}
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index 8c21658..c0244e7 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -252,6 +252,9 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 	}
 
 	case PTRACE_GET_DEBUGREG: {
+#ifndef CONFIG_PPC_ADV_DEBUG_REGS
+		unsigned long dabr_fake;
+#endif
 		ret = -EINVAL;
 		/* We only support one DABR and no IABRS at the moment */
 		if (addr > 0)
@@ -259,7 +262,10 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		ret = put_user(child->thread.dac1, (u32 __user *)data);
 #else
-		ret = put_user(child->thread.dabr, (u32 __user *)data);
+		dabr_fake = (
+			(child->thread.hw_brk.address & (~HW_BRK_TYPE_DABR)) |
+			(child->thread.hw_brk.type & HW_BRK_TYPE_DABR));
+		ret = put_user(dabr_fake, (u32 __user *)data);
 #endif
 		break;
 	}
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 3b99711..1f26956 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -130,8 +130,9 @@ static int do_signal(struct pt_regs *regs)
 	 * user space. The DABR will have been cleared if it
 	 * triggered inside the kernel.
 	 */
-	if (current->thread.dabr)
-		set_dabr(current->thread.dabr, current->thread.dabrx);
+	if (current->thread.hw_brk.address &&
+		current->thread.hw_brk.type)
+		set_break(&current->thread.hw_brk);
 #endif
 	/* Re-enable the breakpoints for the signal stack */
 	thread_change_pc(current, regs);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index cb04fc7..6a67a0d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -67,7 +67,7 @@ int (*__debugger_ipi)(struct pt_regs *regs) __read_mostly;
 int (*__debugger_bpt)(struct pt_regs *regs) __read_mostly;
 int (*__debugger_sstep)(struct pt_regs *regs) __read_mostly;
 int (*__debugger_iabr_match)(struct pt_regs *regs) __read_mostly;
-int (*__debugger_dabr_match)(struct pt_regs *regs) __read_mostly;
+int (*__debugger_break_match)(struct pt_regs *regs) __read_mostly;
 int (*__debugger_fault_handler)(struct pt_regs *regs) __read_mostly;
 
 EXPORT_SYMBOL(__debugger);
@@ -75,7 +75,7 @@ EXPORT_SYMBOL(__debugger_ipi);
 EXPORT_SYMBOL(__debugger_bpt);
 EXPORT_SYMBOL(__debugger_sstep);
 EXPORT_SYMBOL(__debugger_iabr_match);
-EXPORT_SYMBOL(__debugger_dabr_match);
+EXPORT_SYMBOL(__debugger_break_match);
 EXPORT_SYMBOL(__debugger_fault_handler);
 #endif
 
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 3a8489a..229951f 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -249,8 +249,8 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE) || \
 			     defined(CONFIG_PPC_BOOK3S_64))
   	if (error_code & DSISR_DABRMATCH) {
-		/* DABR match */
-		do_dabr(regs, address, error_code);
+		/* breakpoint match */
+		do_break(regs, address, error_code);
 		return 0;
 	}
 #endif
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 1f8d2f1..529c1ed 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -43,6 +43,7 @@
 #include <asm/setjmp.h>
 #include <asm/reg.h>
 #include <asm/debug.h>
+#include <asm/hw_breakpoint.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
@@ -607,7 +608,7 @@ static int xmon_sstep(struct pt_regs *regs)
 	return 1;
 }
 
-static int xmon_dabr_match(struct pt_regs *regs)
+static int xmon_break_match(struct pt_regs *regs)
 {
 	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) != (MSR_IR|MSR_64BIT))
 		return 0;
@@ -740,8 +741,14 @@ static void insert_bpts(void)
 
 static void insert_cpu_bpts(void)
 {
-	if (dabr.enabled)
-		set_dabr(dabr.address | (dabr.enabled & 7), DABRX_ALL);
+	struct arch_hw_breakpoint brk;
+
+	if (dabr.enabled) {
+		brk.address = dabr.address;
+		brk.type = (dabr.enabled & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
+		brk.len = 8;
+		set_break(&brk);
+	}
 	if (iabr && cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, iabr->address
 			 | (iabr->enabled & (BP_IABR|BP_IABR_TE)));
@@ -769,7 +776,7 @@ static void remove_bpts(void)
 
 static void remove_cpu_bpts(void)
 {
-	set_dabr(0, 0);
+	hw_breakpoint_disable();
 	if (cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, 0);
 }
@@ -1138,7 +1145,7 @@ bpt_cmds(void)
 				printf(badaddr);
 				break;
 			}
-			dabr.address &= ~7;
+			dabr.address &= ~HW_BRK_TYPE_DABR;
 			dabr.enabled = mode | BP_DABR;
 		}
 		break;
@@ -2917,7 +2924,7 @@ static void xmon_init(int enable)
 		__debugger_bpt = xmon_bpt;
 		__debugger_sstep = xmon_sstep;
 		__debugger_iabr_match = xmon_iabr_match;
-		__debugger_dabr_match = xmon_dabr_match;
+		__debugger_break_match = xmon_break_match;
 		__debugger_fault_handler = xmon_fault_handler;
 	} else {
 		__debugger = NULL;
@@ -2925,7 +2932,7 @@ static void xmon_init(int enable)
 		__debugger_bpt = NULL;
 		__debugger_sstep = NULL;
 		__debugger_iabr_match = NULL;
-		__debugger_dabr_match = NULL;
+		__debugger_break_match = NULL;
 		__debugger_fault_handler = NULL;
 	}
 }
-- 
1.7.10.4
