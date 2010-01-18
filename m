Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Mon, 18 Jan 2010 16:57:21 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100118215721.15684.94223.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100118215704.15684.60646.sendpatchset@norville.austin.ibm.com>
References: <20100118215704.15684.60646.sendpatchset@norville.austin.ibm.com>
Subject: [RFC:PATCH 03/03] powerpc: Add support for BookE Debug Reg. traps,
	exceptions and ptrace
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

powerpc: Add support for BookE Debug Reg. traps, exceptions and ptrace

From: Torez Smith <lnxtorez@linux.vnet.ibm.com>

This patch defines context switch and trap related functionality
for BookE specific Debug Registers. It adds support to ptrace()
for setting and getting BookE related Debug Registers

Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>
Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>
Cc: David Gibson <dwg@au1.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
---

 arch/powerpc/include/asm/system.h |    5 
 arch/powerpc/kernel/process.c     |  105 +++++++--
 arch/powerpc/kernel/ptrace.c      |  453 ++++++++++++++++++++++++++++++++++---
 arch/powerpc/kernel/signal.c      |    6 
 arch/powerpc/kernel/signal_32.c   |    8 -
 arch/powerpc/kernel/traps.c       |   91 ++++++-
 6 files changed, 587 insertions(+), 81 deletions(-)


diff --git a/arch/powerpc/include/asm/system.h b/arch/powerpc/include/asm/system.h
index bb8e006..0634e79 100644
--- a/arch/powerpc/include/asm/system.h
+++ b/arch/powerpc/include/asm/system.h
@@ -112,8 +112,13 @@ static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 #endif
 
 extern int set_dabr(unsigned long dabr);
+#if (defined(CONFIG_40x) || defined(CONFIG_BOOKE))
+extern void do_send_trap(struct pt_regs *regs, unsigned long address,
+			 unsigned long error_code, int signal_code, int brkpt);
+#else
 extern void do_dabr(struct pt_regs *regs, unsigned long address,
 		    unsigned long error_code);
+#endif
 extern void print_backtrace(unsigned long *);
 extern void show_regs(struct pt_regs * regs);
 extern void flush_instruction_cache(void);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index c930ac3..9f4919a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -245,6 +245,24 @@ void discard_lazy_cpu_state(void)
 }
 #endif /* CONFIG_SMP */
 
+#if (defined(CONFIG_40x) || defined(CONFIG_BOOKE))
+void do_send_trap(struct pt_regs *regs, unsigned long address,
+		  unsigned long error_code, int signal_code, int breakpt)
+{
+	siginfo_t info;
+
+	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
+			11, SIGSEGV) == NOTIFY_STOP)
+		return;
+
+	/* Deliver the signal to userspace */
+	info.si_signo = SIGTRAP;
+	info.si_errno = breakpt;	/* breakpoint or watchpoint id */
+	info.si_code = signal_code;
+	info.si_addr = (void __user *)address;
+	force_sig_info(SIGTRAP, &info, current);
+}
+#else	/* !(defined(CONFIG_40x) || defined(CONFIG_BOOKE)) */
 void do_dabr(struct pt_regs *regs, unsigned long address,
 		    unsigned long error_code)
 {
@@ -257,12 +275,6 @@ void do_dabr(struct pt_regs *regs, unsigned long address,
 	if (debugger_dabr_match(regs))
 		return;
 
-	/* Clear the DAC and struct entries.  One shot trigger */
-#if defined(CONFIG_BOOKE)
-	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
-							| DBCR0_IDM));
-#endif
-
 	/* Clear the DABR */
 	set_dabr(0);
 
@@ -273,9 +285,73 @@ void do_dabr(struct pt_regs *regs, unsigned long address,
 	info.si_addr = (void __user *)address;
 	force_sig_info(SIGTRAP, &info, current);
 }
+#endif
 
 static DEFINE_PER_CPU(unsigned long, current_dabr);
 
+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+/*
+ * Set the debug registers back to their default "safe" values.
+ */
+static void set_debug_reg_defaults(struct thread_struct *thread)
+{
+	thread->iac1 = thread->iac2 = thread->iac3 = thread->iac4 = 0;
+	thread->dac1 = thread->dac2 = 0;
+	thread->dvc1 = thread->dvc2 = 0;
+	thread->dbcr0 = 0;
+#ifdef CONFIG_BOOKE
+	/*
+	 * Force User/Supervisor bits to b11 (user-only MSR[PR]=1)
+	 */
+	thread->dbcr1 = DBCR1_IAC1US | DBCR1_IAC2US |	\
+			DBCR1_IAC3US | DBCR1_IAC4US;
+	/*
+	 * Force Data Address Compare User/Supervisor bits to be User-only
+	 * (0b11 MSR[PR]=1) and set all other bits in DBCR2 register to be 0.
+	 */
+	thread->dbcr2 = DBCR2_DAC1US | DBCR2_DAC2US;
+#else
+	thread->dbcr1 = 0;
+#endif
+}
+
+static void prime_debug_regs(struct thread_struct *thread)
+{
+	mtspr(SPRN_IAC1, thread->iac1);
+	mtspr(SPRN_IAC2, thread->iac2);
+	mtspr(SPRN_IAC3, thread->iac3);
+	mtspr(SPRN_IAC4, thread->iac4);
+	mtspr(SPRN_DAC1, thread->dac1);
+	mtspr(SPRN_DAC2, thread->dac2);
+	mtspr(SPRN_DVC1, thread->dvc1);
+	mtspr(SPRN_DVC2, thread->dvc2);
+	mtspr(SPRN_DBCR0, thread->dbcr0);
+	mtspr(SPRN_DBCR1, thread->dbcr1);
+#ifdef CONFIG_BOOKE
+	mtspr(SPRN_DBCR2, thread->dbcr2);
+#endif
+}
+/*
+ * Unless neither the old or new thread are making use of the
+ * debug registers, set the debug registers from the values
+ * stored in the new thread.
+ */
+static void switch_booke_debug_regs(struct thread_struct *new_thread)
+{
+	if ((current->thread.dbcr0 & DBCR0_IDM)
+		|| (new_thread->dbcr0 & DBCR0_IDM))
+			prime_debug_regs(new_thread);
+}
+#else	/* !(defined(CONFIG_BOOKE) || defined(CONFIG_40x)) */
+static void set_debug_reg_defaults(struct thread_struct *thread)
+{
+	if (thread->dabr) {
+		thread->dabr = 0;
+		set_dabr(0);
+	}
+}
+#endif
+
 int set_dabr(unsigned long dabr)
 {
 	__get_cpu_var(current_dabr) = dabr;
@@ -284,7 +360,7 @@ int set_dabr(unsigned long dabr)
 		return ppc_md.set_dabr(dabr);
 
 	/* XXX should we have a CPU_FTR_HAS_DABR ? */
-#if defined(CONFIG_BOOKE)
+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 	mtspr(SPRN_DAC1, dabr);
 #elif defined(CONFIG_PPC_BOOK3S)
 	mtspr(SPRN_DABR, dabr);
@@ -371,10 +447,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 #endif /* CONFIG_SMP */
 
-#if defined(CONFIG_BOOKE)
-	/* If new thread DAC (HW breakpoint) is the same then leave it */
-	if (new->thread.dabr)
-		set_dabr(new->thread.dabr);
+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+	switch_booke_debug_regs(&new->thread);
 #else
 	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
 		set_dabr(new->thread.dabr);
@@ -568,14 +642,7 @@ void flush_thread(void)
 
 	discard_lazy_cpu_state();
 
-	if (current->thread.dabr) {
-		current->thread.dabr = 0;
-		set_dabr(0);
-
-#if defined(CONFIG_BOOKE)
-		current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W);
-#endif
-	}
+	set_debug_reg_defaults(&current->thread);
 }
 
 void
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 33ab496..d0b74b3 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -737,17 +737,25 @@ void user_disable_single_step(struct task_struct *task)
 	struct pt_regs *regs = task->thread.regs;
 
 	if (regs != NULL) {
-#if defined(CONFIG_BOOKE)
-		/* If DAC don't clear DBCRO_IDM or MSR_DE */
-		if (task->thread.dabr)
-			task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_BT);
-		else {
-			task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_BT | DBCR0_IDM);
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+		/*
+		 * The logic to disable single stepping should be as
+		 * simple as turning off the Instruction Complete flag.
+		 * And, after doing so, if all debug flags are off, turn
+		 * off DBCR0(IDM) and MSR(DE) .... Torez
+		 */
+		task->thread.dbcr0 &= ~DBCR0_IC;
+		/*
+		 * Test to see if any of the DBCR_ACTIVE_EVENTS bits are set.
+		 */
+		if (!DBCR_ACTIVE_EVENTS(task->thread.dbcr0,
+					task->thread.dbcr1)) {
+			/*
+			 * All debug events were off.....
+			 */
+			task->thread.dbcr0 &= ~DBCR0_IDM;
 			regs->msr &= ~MSR_DE;
 		}
-#elif defined(CONFIG_40x)
-		task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_BT | DBCR0_IDM);
-		regs->msr &= ~MSR_DE;
 #else
 		regs->msr &= ~(MSR_SE | MSR_BE);
 #endif
@@ -769,8 +777,7 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	if ((data & ~0x7UL) >= TASK_SIZE)
 		return -EIO;
 
-#ifndef CONFIG_BOOKE
-
+#if !(defined(CONFIG_40x) || defined(CONFIG_BOOKE))
 	/* For processors using DABR (i.e. 970), the bottom 3 bits are flags.
 	 *  It was assumed, on previous implementations, that 3 bits were
 	 *  passed together with the data address, fitting the design of the
@@ -789,21 +796,22 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 
 	/* Move contents to the DABR register */
 	task->thread.dabr = data;
-
-#endif
-#if defined(CONFIG_BOOKE)
-
+#else
 	/* As described above, it was assumed 3 bits were passed with the data
 	 *  address, but we will assume only the mode bits will be passed
 	 *  as to not cause alignment restrictions for DAC-based processors.
 	 */
 
 	/* DAC's hold the whole address without any mode flags */
-	task->thread.dabr = data & ~0x3UL;
-
-	if (task->thread.dabr == 0) {
-		task->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W | DBCR0_IDM);
-		task->thread.regs->msr &= ~MSR_DE;
+	task->thread.dac1 = data & ~0x3UL;
+
+	if (task->thread.dac1 == 0) {
+		dbcr_dac(task) &= ~(DBCR_DAC1R | DBCR_DAC1W);
+		if (!DBCR_ACTIVE_EVENTS(task->thread.dbcr0,
+					task->thread.dbcr1)) {
+			task->thread.regs->msr &= ~MSR_DE;
+			task->thread.dbcr0 &= ~DBCR0_IDM;
+		}
 		return 0;
 	}
 
@@ -814,15 +822,15 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 
 	/* Set the Internal Debugging flag (IDM bit 1) for the DBCR0
 	   register */
-	task->thread.dbcr0 = DBCR0_IDM;
+	task->thread.dbcr0 |= DBCR0_IDM;
 
 	/* Check for write and read flags and set DBCR0
 	   accordingly */
+	dbcr_dac(task) &= ~(DBCR_DAC1R|DBCR_DAC1W);
 	if (data & 0x1UL)
-		task->thread.dbcr0 |= DBSR_DAC1R;
+		dbcr_dac(task) |= DBCR_DAC1R;
 	if (data & 0x2UL)
-		task->thread.dbcr0 |= DBSR_DAC1W;
-
+		dbcr_dac(task) |= DBCR_DAC1W;
 	task->thread.regs->msr |= MSR_DE;
 #endif
 	return 0;
@@ -839,11 +847,346 @@ void ptrace_disable(struct task_struct *child)
 	user_disable_single_step(child);
 }
 
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+static long set_intruction_bp(struct task_struct *child,
+			      struct ppc_hw_breakpoint *bp_info)
+{
+	int slot;
+	int slot1_in_use = ((child->thread.dbcr0 & DBCR0_IAC1) != 0);
+	int slot2_in_use = ((child->thread.dbcr0 & DBCR0_IAC2) != 0);
+	int slot3_in_use = ((child->thread.dbcr0 & DBCR0_IAC3) != 0);
+	int slot4_in_use = ((child->thread.dbcr0 & DBCR0_IAC4) != 0);
+
+	if (dbcr_iac_range(child) & DBCR_IAC12MODE)
+		slot2_in_use = 1;
+	if (dbcr_iac_range(child) & DBCR_IAC34MODE)
+		slot4_in_use = 1;
+
+	if (bp_info->addr >= TASK_SIZE)
+		return -EIO;
+
+	if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) {
+
+		/* Make sure range is valid. */
+		if (bp_info->addr2 >= TASK_SIZE)
+			return -EIO;
+
+		/* We need a pair of IAC regsisters */
+		if ((!slot1_in_use) && (!slot2_in_use)) {
+			slot = 1;
+			child->thread.iac1 = bp_info->addr;
+			child->thread.iac2 = bp_info->addr2;
+			child->thread.dbcr0 |= DBCR0_IAC1;
+			if (bp_info->addr_mode ==
+					PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE)
+				dbcr_iac_range(child) |= DBCR_IAC12X;
+			else
+				dbcr_iac_range(child) |= DBCR_IAC12I;
+		} else if ((!slot3_in_use) && (!slot4_in_use)) {
+			slot = 3;
+			child->thread.iac3 = bp_info->addr;
+			child->thread.iac4 = bp_info->addr2;
+			child->thread.dbcr0 |= DBCR0_IAC3;
+			if (bp_info->addr_mode ==
+					PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE)
+				dbcr_iac_range(child) |= DBCR_IAC34X;
+			else
+				dbcr_iac_range(child) |= DBCR_IAC34I;
+		} else
+			return -ENOSPC;
+	} else {
+		/* We only need one.  If possible leave a pair free in
+		 * case a range is needed later
+		 */
+		if (!slot1_in_use) {
+			/*
+			 * Don't use iac1 if iac1-iac2 are free and either
+			 * iac3 or iac4 (but not both) are free
+			 */
+			if (slot2_in_use || (slot3_in_use == slot4_in_use)) {
+				slot = 1;
+				child->thread.iac1 = bp_info->addr;
+				child->thread.dbcr0 |= DBCR0_IAC1;
+				goto out;
+			}
+		}
+		if (!slot2_in_use) {
+			slot = 2;
+			child->thread.iac2 = bp_info->addr;
+			child->thread.dbcr0 |= DBCR0_IAC2;
+		} else if (!slot3_in_use) {
+			slot = 3;
+			child->thread.iac3 = bp_info->addr;
+			child->thread.dbcr0 |= DBCR0_IAC3;
+		} else if (!slot4_in_use) {
+			slot = 4;
+			child->thread.iac4 = bp_info->addr;
+			child->thread.dbcr0 |= DBCR0_IAC4;
+		} else
+			return -ENOSPC;
+	}
+out:
+	child->thread.dbcr0 |= DBCR0_IDM;
+	child->thread.regs->msr |= MSR_DE;
+
+	return slot;
+}
+
+static int del_instruction_bp(struct task_struct *child, int slot)
+{
+	switch (slot) {
+	case 1:
+		if (child->thread.iac1 == 0)
+			return -ENOENT;
+
+		if (dbcr_iac_range(child) & DBCR_IAC12MODE) {
+			/* address range - clear slots 1 & 2 */
+			child->thread.iac2 = 0;
+			dbcr_iac_range(child) &= ~DBCR_IAC12MODE;
+		}
+		child->thread.iac1 = 0;
+		child->thread.dbcr0 &= ~DBCR0_IAC1;
+		break;
+	case 2:
+		if (child->thread.iac2 == 0)
+			return -ENOENT;
+
+		if (dbcr_iac_range(child) & DBCR_IAC12MODE)
+			/* used in a range */
+			return -EINVAL;
+		child->thread.iac2 = 0;
+		child->thread.dbcr0 &= ~DBCR0_IAC2;
+		break;
+	case 3:
+		if (child->thread.iac3 == 0)
+			return -ENOENT;
+
+		if (dbcr_iac_range(child) & DBCR_IAC34MODE) {
+			/* address range - clear slots 3 & 4 */
+			child->thread.iac4 = 0;
+			dbcr_iac_range(child) &= ~DBCR_IAC34MODE;
+		}
+		child->thread.iac3 = 0;
+		child->thread.dbcr0 &= ~DBCR0_IAC3;
+		break;
+	case 4:
+		if (child->thread.iac4 == 0)
+			return -ENOENT;
+
+		if (dbcr_iac_range(child) & DBCR_IAC34MODE)
+			/* Used in a range */
+			return -EINVAL;
+		child->thread.iac4 = 0;
+		child->thread.dbcr0 &= ~DBCR0_IAC4;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int set_dac(struct task_struct *child, struct ppc_hw_breakpoint *bp_info)
+{
+	int byte_enable =
+		(bp_info->condition_mode >> PPC_BREAKPOINT_CONDITION_BE_SHIFT)
+		& 0xf;
+	int condition_mode =
+		bp_info->condition_mode & PPC_BREAKPOINT_CONDITION_MODE;
+	int slot;
+
+	if (byte_enable && (condition_mode == 0))
+		return -EINVAL;
+
+	if (bp_info->addr >= TASK_SIZE)
+		return -EIO;
+
+	if ((dbcr_dac(child) & (DBCR_DAC1R | DBCR_DAC1W)) == 0) {
+		slot = 1;
+		if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
+			dbcr_dac(child) |= DBCR_DAC1R;
+		if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
+			dbcr_dac(child) |= DBCR_DAC1W;
+		child->thread.dac1 = (unsigned long)bp_info->addr;
+#ifdef CONFIG_BOOKE
+		if (byte_enable) {
+			child->thread.dvc1 =
+				(unsigned long)bp_info->condition_value;
+			child->thread.dbcr2 |=
+				((byte_enable << DBCR2_DVC1BE_SHIFT) |
+				 (condition_mode << DBCR2_DVC1M_SHIFT));
+		}
+	} else if (child->thread.dbcr2 & DBCR2_DAC12MODE) {
+		/* Both dac1 and dac2 are part of a range */
+		return -ENOSPC;
+#endif
+	} else if ((dbcr_dac(child) & (DBCR_DAC2R | DBCR_DAC2W)) == 0) {
+		slot = 2;
+		if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
+			dbcr_dac(child) |= DBCR_DAC2R;
+		if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
+			dbcr_dac(child) |= DBCR_DAC2W;
+		child->thread.dac2 = (unsigned long)bp_info->addr;
+#ifdef CONFIG_BOOKE
+		if (byte_enable) {
+			child->thread.dvc2 =
+				(unsigned long)bp_info->condition_value;
+			child->thread.dbcr2 |=
+				((byte_enable << DBCR2_DVC2BE_SHIFT) |
+				 (condition_mode << DBCR2_DVC2M_SHIFT));
+		}
+#endif
+	} else
+		return -ENOSPC;
+	child->thread.dbcr0 |= DBCR0_IDM;
+	child->thread.regs->msr |= MSR_DE;
+
+	return slot + 4;
+}
+
+static int del_dac(struct task_struct *child, int slot)
+{
+	if (slot == 1) {
+		if (child->thread.dac1 == 0)
+			return -ENOENT;
+
+		child->thread.dac1 = 0;
+		dbcr_dac(child) &= ~(DBCR_DAC1R | DBCR_DAC1W);
+#ifdef CONFIG_BOOKE
+		if (child->thread.dbcr2 & DBCR2_DAC12MODE) {
+			child->thread.dac2 = 0;
+			child->thread.dbcr2 &= ~DBCR2_DAC12MODE;
+		}
+		child->thread.dbcr2 &= ~(DBCR2_DVC1M | DBCR2_DVC1BE);
+#endif
+		child->thread.dvc1 = 0;
+	} else if (slot == 2) {
+		if (child->thread.dac1 == 0)
+			return -ENOENT;
+
+#ifdef CONFIG_BOOKE
+		if (child->thread.dbcr2 & DBCR2_DAC12MODE)
+			/* Part of a range */
+			return -EINVAL;
+		child->thread.dbcr2 &= ~(DBCR2_DVC2M | DBCR2_DVC2BE);
+#endif
+		child->thread.dvc2 = 0;
+		child->thread.dac2 = 0;
+		dbcr_dac(child) &= ~(DBCR_DAC2R | DBCR_DAC2W);
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+#endif /* CONFIG_40x || CONFIG_BOOKE */
+
+#ifdef CONFIG_BOOKE
+static int set_dac_range(struct task_struct *child,
+			 struct ppc_hw_breakpoint *bp_info)
+{
+	int mode = bp_info->addr_mode & PPC_BREAKPOINT_MODE_MASK;
+
+	/* We don't allow range watchpoints to be used with DVC */
+	if (bp_info->condition_mode)
+		return -EINVAL;
+
+	if (bp_info->addr >= TASK_SIZE)
+		return -EIO;
+	if (mode == PPC_BREAKPOINT_MODE_MASK) {
+		/*
+		 * dac2 is a bitmask.  Don't allow a mask that makes a
+		 * kernel space address from a valid dac1 value
+		 */
+		if (~bp_info->addr2 >= TASK_SIZE)
+			return -EIO;
+	} else {
+		/*
+		 * For range breakpoints, addr2 must also be a valid address
+		 *
+		 * XXX - How do we protect kernel space when in range exclusive
+		 * mode?  bookE will only trap in user mode, but what about
+		 * 405?
+		 */
+		if (bp_info->addr >= TASK_SIZE)
+			return -EIO;
+	}
+
+
+	if (child->thread.dbcr0 &
+	    (DBCR0_DAC1R | DBCR0_DAC1W | DBCR0_DAC2R | DBCR0_DAC2W))
+		return -ENOSPC;
+
+	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
+		child->thread.dbcr0 |= (DBCR0_DAC1R | DBCR0_IDM);
+	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
+		child->thread.dbcr0 |= (DBCR0_DAC1W | DBCR0_IDM);
+	child->thread.dac1 = bp_info->addr;
+	child->thread.dac2 = bp_info->addr2;
+	if (mode == PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE)
+		child->thread.dbcr2  |= DBCR2_DAC12M;
+	else if (mode == PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE)
+		child->thread.dbcr2  |= DBCR2_DAC12MX;
+	else	/* PPC_BREAKPOINT_MODE_MASK */
+		child->thread.dbcr2  |= DBCR2_DAC12MM;
+	child->thread.regs->msr |= MSR_DE;
+
+	return 5;
+}
+#endif /* CONFIG_BOOKE */
+
 static long ppc_set_hwdebug(struct task_struct *child,
 		     struct ppc_hw_breakpoint *bp_info)
 {
+	if (bp_info->version != 1)
+		return -ENOTSUPP;
+
+#ifdef CONFIG_BOOKE
+	/*
+	 * Check for invalid flags and combinations
+	 */
+	if ((bp_info->trigger_type == 0) ||
+	    (bp_info->trigger_type & ~(PPC_BREAKPOINT_TRIGGER_EXECUTE |
+				       PPC_BREAKPOINT_TRIGGER_RW)) ||
+	    (bp_info->addr_mode & ~PPC_BREAKPOINT_MODE_MASK) ||
+	    (bp_info->condition_mode &
+	     ~(PPC_BREAKPOINT_CONDITION_MODE |
+	       PPC_BREAKPOINT_CONDITION_BE_ALL)))
+		return -EINVAL;
+
+	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_EXECUTE) {
+		if (bp_info->trigger_type != PPC_BREAKPOINT_TRIGGER_EXECUTE)
+			/* At least another bit was set */
+			return -EINVAL;
+		return set_intruction_bp(child, bp_info);
+	}
+
+	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_EXACT)
+		return set_dac(child, bp_info);
+
+	return set_dac_range(child, bp_info);
+#elif defined(CONFIG_40x)
+	/*
+	 * Check for invalid flags and combinations
+	 */
+	if ((bp_info->trigger_type == 0) ||
+	    (bp_info->trigger_type & ~(PPC_BREAKPOINT_TRIGGER_EXECUTE |
+				       PPC_BREAKPOINT_TRIGGER_RW)) ||
+	    (bp_info->addr_mode & ~PPC_BREAKPOINT_MODE_MASK) ||
+	    (bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE))
+		return -EINVAL;
+
+	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_EXECUTE) {
+		if (bp_info->trigger_type != PPC_BREAKPOINT_TRIGGER_EXECUTE)
+			/* At least another bit was set */
+			return -EINVAL;
+		return set_intruction_bp(child, bp_info);
+	}
+	if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT)
+		return -EINVAL;
+
+	return set_dac(child, bp_info);
+#else
 	/*
-	 * We currently support one data breakpoint
+	 * We only support one data breakpoint
 	 */
 	if (((bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_RW) == 0) ||
 	    ((bp_info->trigger_type & ~PPC_BREAKPOINT_TRIGGER_RW) != 0) ||
@@ -859,30 +1202,37 @@ static long ppc_set_hwdebug(struct task_struct *child,
 		return -EIO;
 
 	child->thread.dabr = (unsigned long)bp_info->addr;
-#ifdef CONFIG_BOOKE
-	child->thread.dbcr0 = DBCR0_IDM;
-	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
-		child->thread.dbcr0 |= DBSR_DAC1R;
-	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
-		child->thread.dbcr0 |= DBSR_DAC1W;
-	child->thread.regs->msr |= MSR_DE;
-#endif
 	return 1;
+#endif
 }
 
 static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
 {
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+	int rc;
+
+	if (data <= 4)
+		rc = del_instruction_bp(child, (int)data);
+	else
+		rc = del_dac(child, (int)data - 4);
+
+	if (!rc) {
+		if (!DBCR_ACTIVE_EVENTS(child->thread.dbcr0,
+					child->thread.dbcr1)) {
+			child->thread.dbcr0 &= ~DBCR0_IDM;
+			child->thread.regs->msr &= ~MSR_DE;
+		}
+	}
+	return rc;
+#else
 	if (data != 1)
 		return -EINVAL;
 	if (child->thread.dabr == 0)
 		return -ENOENT;
 
 	child->thread.dabr = 0;
-#ifdef CONFIG_BOOKE
-	child->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W | DBCR0_IDM);
-	child->thread.regs->msr &= ~MSR_DE;
-#endif
 	return 0;
+#endif
 }
 
 /*
@@ -982,6 +1332,29 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 		struct ppc_debug_info dbginfo;
 
 		dbginfo.version = 1;
+#ifdef CONFIG_BOOKE
+		dbginfo.num_instruction_bps = 4;
+		dbginfo.num_data_bps = 2;
+		dbginfo.num_condition_regs = 2;
+		dbginfo.data_bp_alignment = 4;
+		dbginfo.sizeof_condition = 4;
+		dbginfo.features = PPC_DEBUG_FEATURE_INSN_BP_RANGE |
+				   PPC_DEBUG_FEATURE_INSN_BP_MASK |
+				   PPC_DEBUG_FEATURE_DATA_BP_RANGE |
+				   PPC_DEBUG_FEATURE_DATA_BP_MASK;
+#elif defined(CONFIG_40x)
+		/*
+		 * I don't know how the DVCs work on 40x, I'm not going
+		 * to support it now. -- Shaggy
+		 */
+		dbginfo.num_instruction_bps = 4;
+		dbginfo.num_data_bps = 2;
+		dbginfo.num_condition_regs = 0;
+		dbginfo.data_bp_alignment = 4;
+		dbginfo.sizeof_condition = 0;
+		dbginfo.features = PPC_DEBUG_FEATURE_INSN_BP_RANGE |
+				   PPC_DEBUG_FEATURE_INSN_BP_MASK;
+#else
 		dbginfo.num_instruction_bps = 0;
 		dbginfo.num_data_bps = 1;
 		dbginfo.num_condition_regs = 0;
@@ -992,6 +1365,7 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 #endif
 		dbginfo.sizeof_condition = 0;
 		dbginfo.features = 0;
+#endif
 
 		if (!access_ok(VERIFY_WRITE, data,
 			       sizeof(struct ppc_debug_info)))
@@ -1027,8 +1401,13 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 		/* We only support one DABR and no IABRS at the moment */
 		if (addr > 0)
 			break;
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+		ret = put_user(child->thread.dac1,
+			       (unsigned long __user *)data);
+#else
 		ret = put_user(child->thread.dabr,
 			       (unsigned long __user *)data);
+#endif
 		break;
 	}
 
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 00b5078..94df779 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -140,17 +140,15 @@ static int do_signal_pending(sigset_t *oldset, struct pt_regs *regs)
 		return 0;               /* no signals delivered */
 	}
 
+#if !(defined(CONFIG_BOOKE) || defined(CONFIG_40x))
         /*
 	 * Reenable the DABR before delivering the signal to
 	 * user space. The DABR will have been cleared if it
 	 * triggered inside the kernel.
 	 */
-	if (current->thread.dabr) {
+	if (current->thread.dabr)
 		set_dabr(current->thread.dabr);
-#if defined(CONFIG_BOOKE)
-		mtspr(SPRN_DBCR0, current->thread.dbcr0);
 #endif
-	}
 
 	if (is32) {
         	if (ka.sa.sa_flags & SA_SIGINFO)
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index d670429..6cc6e81 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1092,8 +1092,12 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 				new_msr |= MSR_DE;
 				new_dbcr0 |= (DBCR0_IDM | DBCR0_IC);
 			} else {
-				new_msr &= ~MSR_DE;
-				new_dbcr0 &= ~(DBCR0_IDM | DBCR0_IC);
+				new_dbcr0 &= ~DBCR0_IC;
+				if (!DBCR_ACTIVE_EVENTS(new_dbcr0,
+						current->thread.dbcr1)) {
+					new_msr &= ~MSR_DE;
+					new_dbcr0 &= ~DBCR0_IDM;
+				}
 			}
 #else
 			if (op.dbg_value)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d069ff8..49dc5fa 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1025,9 +1025,68 @@ void SoftwareEmulation(struct pt_regs *regs)
 #endif /* CONFIG_8xx */
 
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+static void handle_debug(struct pt_regs *regs, unsigned long debug_status)
+{
+	int changed = 0;
+	/*
+	 * Determine the cause of the debug event, clear the
+	 * event flags and send a trap to the handler. Torez
+	 */
+	if (debug_status & (DBSR_DAC1R | DBSR_DAC1W)) {
+		dbcr_dac(current) &= ~(DBCR_DAC1R | DBCR_DAC1W);
+#ifdef CONFIG_BOOKE
+		current->thread.dbcr2 &= ~DBCR2_DAC12MODE;
+#endif
+		do_send_trap(regs, mfspr(SPRN_DAC1), debug_status, TRAP_HWBKPT,
+			     5);
+		changed |= 0x01;
+	}  else if (debug_status & (DBSR_DAC2R | DBSR_DAC2W)) {
+		dbcr_dac(current) &= ~(DBCR_DAC2R | DBCR_DAC2W);
+		do_send_trap(regs, mfspr(SPRN_DAC2), debug_status, TRAP_HWBKPT,
+			     6);
+		changed |= 0x01;
+	}  else if (debug_status & DBSR_IAC1) {
+		current->thread.dbcr0 &= ~DBCR0_IAC1;
+		dbcr_iac_range(current) &= ~DBCR_IAC12MODE;
+		do_send_trap(regs, mfspr(SPRN_IAC1), debug_status, TRAP_HWBKPT,
+			     1);
+		changed |= 0x01;
+	}  else if (debug_status & DBSR_IAC2) {
+		current->thread.dbcr0 &= ~DBCR0_IAC2;
+		do_send_trap(regs, mfspr(SPRN_IAC2), debug_status, TRAP_HWBKPT,
+			     2);
+		changed |= 0x01;
+	}  else if (debug_status & DBSR_IAC3) {
+		current->thread.dbcr0 &= ~DBCR0_IAC3;
+		dbcr_iac_range(current) &= ~DBCR_IAC34MODE;
+		do_send_trap(regs, mfspr(SPRN_IAC3), debug_status, TRAP_HWBKPT,
+			     3);
+		changed |= 0x01;
+	}  else if (debug_status & DBSR_IAC4) {
+		current->thread.dbcr0 &= ~DBCR0_IAC4;
+		do_send_trap(regs, mfspr(SPRN_IAC4), debug_status, TRAP_HWBKPT,
+			     4);
+		changed |= 0x01;
+	}
+	/*
+	 * At the point this routine was called, the MSR(DE) was turned off.
+	 * Check all other debug flags and see if that bit needs to be turned
+	 * back on or not.
+	 */
+	if (DBCR_ACTIVE_EVENTS(current->thread.dbcr0, current->thread.dbcr1))
+		regs->msr |= MSR_DE;
+	else
+		/* Make sure the IDM flag is off */
+		current->thread.dbcr0 &= ~DBCR0_IDM;
+
+	if (changed & 0x01)
+		mtspr(SPRN_DBCR0, current->thread.dbcr0);
+}
 
 void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
+	current->thread.dbsr = debug_status;
+
 	/* Hack alert: On BookE, Branch Taken stops on the branch itself, while
 	 * on server, it stops on the target of the branch. In order to simulate
 	 * the server behaviour, we thus restart right away with a single step
@@ -1071,27 +1130,21 @@ void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 		if (debugger_sstep(regs))
 			return;
 
-		if (user_mode(regs))
-			current->thread.dbcr0 &= ~(DBCR0_IC);
-
-		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
-	} else if (debug_status & (DBSR_DAC1R | DBSR_DAC1W)) {
-		regs->msr &= ~MSR_DE;
-
 		if (user_mode(regs)) {
-			current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W |
-								DBCR0_IDM);
-		} else {
-			/* Disable DAC interupts */
-			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R |
-						DBSR_DAC1W | DBCR0_IDM));
-
-			/* Clear the DAC event */
-			mtspr(SPRN_DBSR, (DBSR_DAC1R | DBSR_DAC1W));
+			current->thread.dbcr0 &= ~DBCR0_IC;
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+			if (DBCR_ACTIVE_EVENTS(current->thread.dbcr0,
+					       current->thread.dbcr1))
+				regs->msr |= MSR_DE;
+			else
+				/* Make sure the IDM bit is off */
+				current->thread.dbcr0 &= ~DBCR0_IDM;
+#endif
 		}
-		/* Setup and send the trap to the handler */
-		do_dabr(regs, mfspr(SPRN_DAC1), debug_status);
-	}
+
+		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
+	} else
+		handle_debug(regs, debug_status);
 }
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
 

-- 
Dave Kleikamp
IBM Linux Technology Center
