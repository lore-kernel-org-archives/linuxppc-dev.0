Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Mon, 8 Feb 2010 14:50:57 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100208215057.17930.30833.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100208215049.17930.8586.sendpatchset@norville.austin.ibm.com>
References: <20100208215049.17930.8586.sendpatchset@norville.austin.ibm.com>
Subject: [PATCH 01/04] powerpc/booke: Introduce new CONFIG options for
	advanced debug registers
Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>, David Gibson <dwg@au1.ibm.com>,
	Torez Smith <torez@us.ibm.com>, Thiago Jung Bauermann <bauerman@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/booke: Introduce new CONFIG options for advanced debug registers

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

Introduce new config options to simplify the ifdefs pertaining to the
advanced debug registers for booke and 40x processors:

CONFIG_PPC_ADV_DEBUG_REGS - boolean: true for dac-based processors
CONFIG_PPC_ADV_DEBUG_IACS - number of IAC registers
CONFIG_PPC_ADV_DEBUG_DACS - number of DAC registers
CONFIG_PPC_ADV_DEBUG_DVCS - number of DVC registers
CONFIG_PPC_ADV_DEBUG_DAC_RANGE - DAC ranges supported

Beginning conservatively, since I only have the facilities to test 440
hardware.  I believe all 40x and booke platforms support at least 2 IAC
and 2 DAC registers.  For 440, 4 IAC and 2 DVC registers are enabled, as
well as the DAC ranges.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/Kconfig            |   27 +++++++++++++++++++++++++++
 arch/powerpc/kernel/kgdb.c      |    2 +-
 arch/powerpc/kernel/kprobes.c   |    4 ++--
 arch/powerpc/kernel/process.c   |   10 +++++-----
 arch/powerpc/kernel/ptrace.c    |   18 +++++++-----------
 arch/powerpc/kernel/signal.c    |    2 +-
 arch/powerpc/kernel/signal_32.c |    8 ++++----
 arch/powerpc/kernel/traps.c     |    6 +++---
 8 files changed, 50 insertions(+), 27 deletions(-)


diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ba3948c..32840fb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -240,6 +240,33 @@ config PPC_OF_PLATFORM_PCI
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y
 
+config PPC_ADV_DEBUG_REGS
+	bool
+	depends on 40x || BOOKE
+	default y
+
+config PPC_ADV_DEBUG_IACS
+	int
+	depends on PPC_ADV_DEBUG_REGS
+	default 4 if 44x
+	default 2
+
+config PPC_ADV_DEBUG_DACS
+	int
+	depends on PPC_ADV_DEBUG_REGS
+	default 2
+
+config PPC_ADV_DEBUG_DVCS
+	int
+	depends on PPC_ADV_DEBUG_REGS
+	default 2 if 44x
+	default 0
+
+config PPC_ADV_DEBUG_DAC_RANGE
+	bool
+	depends on PPC_ADV_DEBUG_REGS && 44x
+	default y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index b6bd1ea..41bada0 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -333,7 +333,7 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
 		atomic_set(&kgdb_cpu_doing_single_step, -1);
 		/* set the trace bit if we're stepping */
 		if (remcom_in_buffer[0] == 's') {
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 			mtspr(SPRN_DBCR0,
 			      mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
 			linux_regs->msr |= MSR_DE;
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index c932978..3fd1af9 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -36,7 +36,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-#ifdef CONFIG_BOOKE
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 #define MSR_SINGLESTEP	(MSR_DE)
 #else
 #define MSR_SINGLESTEP	(MSR_SE)
@@ -110,7 +110,7 @@ static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 	 * like Decrementer or External Interrupt */
 	regs->msr &= ~MSR_EE;
 	regs->msr |= MSR_SINGLESTEP;
-#ifdef CONFIG_BOOKE
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	regs->msr &= ~MSR_CE;
 	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
 #endif
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 7b816da..9be77e3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -258,7 +258,7 @@ void do_dabr(struct pt_regs *regs, unsigned long address,
 		return;
 
 	/* Clear the DAC and struct entries.  One shot trigger */
-#if defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
 							| DBCR0_IDM));
 #endif
@@ -284,7 +284,7 @@ int set_dabr(unsigned long dabr)
 		return ppc_md.set_dabr(dabr);
 
 	/* XXX should we have a CPU_FTR_HAS_DABR ? */
-#if defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	mtspr(SPRN_DAC1, dabr);
 #elif defined(CONFIG_PPC_BOOK3S)
 	mtspr(SPRN_DABR, dabr);
@@ -371,7 +371,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 #endif /* CONFIG_SMP */
 
-#if defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	/* If new thread DAC (HW breakpoint) is the same then leave it */
 	if (new->thread.dabr)
 		set_dabr(new->thread.dabr);
@@ -514,7 +514,7 @@ void show_regs(struct pt_regs * regs)
 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
 	if (trap == 0x300 || trap == 0x600)
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, regs->dsisr);
 #else
 		printk("DAR: "REG", DSISR: "REG"\n", regs->dar, regs->dsisr);
@@ -560,7 +560,7 @@ void flush_thread(void)
 		current->thread.dabr = 0;
 		set_dabr(0);
 
-#if defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W);
 #endif
 	}
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index ef14988..292c814 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -46,7 +46,7 @@
 /*
  * Set of msr bits that gdb can change on behalf of a process.
  */
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 #define MSR_DEBUGCHANGE	0
 #else
 #define MSR_DEBUGCHANGE	(MSR_SE | MSR_BE)
@@ -703,7 +703,7 @@ void user_enable_single_step(struct task_struct *task)
 	struct pt_regs *regs = task->thread.regs;
 
 	if (regs != NULL) {
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		task->thread.dbcr0 &= ~DBCR0_BT;
 		task->thread.dbcr0 |= DBCR0_IDM | DBCR0_IC;
 		regs->msr |= MSR_DE;
@@ -720,7 +720,7 @@ void user_enable_block_step(struct task_struct *task)
 	struct pt_regs *regs = task->thread.regs;
 
 	if (regs != NULL) {
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		task->thread.dbcr0 &= ~DBCR0_IC;
 		task->thread.dbcr0 = DBCR0_IDM | DBCR0_BT;
 		regs->msr |= MSR_DE;
@@ -737,7 +737,7 @@ void user_disable_single_step(struct task_struct *task)
 	struct pt_regs *regs = task->thread.regs;
 
 	if (regs != NULL) {
-#if defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		/* If DAC don't clear DBCRO_IDM or MSR_DE */
 		if (task->thread.dabr)
 			task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_BT);
@@ -745,9 +745,6 @@ void user_disable_single_step(struct task_struct *task)
 			task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_BT | DBCR0_IDM);
 			regs->msr &= ~MSR_DE;
 		}
-#elif defined(CONFIG_40x)
-		task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_BT | DBCR0_IDM);
-		regs->msr &= ~MSR_DE;
 #else
 		regs->msr &= ~(MSR_SE | MSR_BE);
 #endif
@@ -769,7 +766,7 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	if ((data & ~0x7UL) >= TASK_SIZE)
 		return -EIO;
 
-#ifndef CONFIG_BOOKE
+#ifndef CONFIG_PPC_ADV_DEBUG_REGS
 
 	/* For processors using DABR (i.e. 970), the bottom 3 bits are flags.
 	 *  It was assumed, on previous implementations, that 3 bits were
@@ -790,8 +787,7 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	/* Move contents to the DABR register */
 	task->thread.dabr = data;
 
-#endif
-#if defined(CONFIG_BOOKE)
+#else /* CONFIG_PPC_ADV_DEBUG_REGS */
 
 	/* As described above, it was assumed 3 bits were passed with the data
 	 *  address, but we will assume only the mode bits will be passed
@@ -824,7 +820,7 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 		task->thread.dbcr0 |= DBSR_DAC1W;
 
 	task->thread.regs->msr |= MSR_DE;
-#endif
+#endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 00b5078..ad7044b 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -147,7 +147,7 @@ static int do_signal_pending(sigset_t *oldset, struct pt_regs *regs)
 	 */
 	if (current->thread.dabr) {
 		set_dabr(current->thread.dabr);
-#if defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		mtspr(SPRN_DBCR0, current->thread.dbcr0);
 #endif
 	}
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index d670429..e4883ae 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1078,7 +1078,7 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 	int i;
 	unsigned char tmp;
 	unsigned long new_msr = regs->msr;
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	unsigned long new_dbcr0 = current->thread.dbcr0;
 #endif
 
@@ -1087,7 +1087,7 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 			return -EFAULT;
 		switch (op.dbg_type) {
 		case SIG_DBG_SINGLE_STEPPING:
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 			if (op.dbg_value) {
 				new_msr |= MSR_DE;
 				new_dbcr0 |= (DBCR0_IDM | DBCR0_IC);
@@ -1103,7 +1103,7 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 #endif
 			break;
 		case SIG_DBG_BRANCH_TRACING:
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 			return -EINVAL;
 #else
 			if (op.dbg_value)
@@ -1124,7 +1124,7 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 	   failure is a problem, anyway, and it's very unlikely unless
 	   the user is really doing something wrong. */
 	regs->msr = new_msr;
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	current->thread.dbcr0 = new_dbcr0;
 #endif
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d069ff8..3623530 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -294,7 +294,7 @@ static inline int check_io_access(struct pt_regs *regs)
 	return 0;
 }
 
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 /* On 4xx, the reason for the machine check or program exception
    is in the ESR. */
 #define get_reason(regs)	((regs)->dsisr)
@@ -1024,7 +1024,7 @@ void SoftwareEmulation(struct pt_regs *regs)
 }
 #endif /* CONFIG_8xx */
 
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 
 void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
@@ -1093,7 +1093,7 @@ void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 		do_dabr(regs, mfspr(SPRN_DAC1), debug_status);
 	}
 }
-#endif /* CONFIG_4xx || CONFIG_BOOKE */
+#endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 
 #if !defined(CONFIG_TAU_INT)
 void TAUException(struct pt_regs *regs)

-- 
Dave Kleikamp
IBM Linux Technology Center
