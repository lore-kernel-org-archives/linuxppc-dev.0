Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 1 Oct 2005 00:00:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20051001000001.1f1d8c48.sfr@canb.auug.org.au>
In-Reply-To: <20050930233602.138b6e27.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 6/9] powerpc: merge idle_power4.S and fixup traps.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use idle_power4.S from ppc64 as we are not going to support
32 bit power4 in the merged tree.

create traps{32,64}.c as these are hard to merge.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/Kconfig              |    4 
 arch/powerpc/kernel/Makefile      |    4 
 arch/powerpc/kernel/idle_power4.S |   78 +++
 arch/powerpc/kernel/traps.c       | 1047 -------------------------------------
 arch/powerpc/kernel/traps32.c     | 1047 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/traps64.c     |  568 ++++++++++++++++++++
 arch/ppc64/kernel/Makefile        |   10 
 arch/ppc64/kernel/idle_power4.S   |   79 ---
 arch/ppc64/kernel/traps.c         |  568 --------------------
 9 files changed, 1707 insertions(+), 1698 deletions(-)
 create mode 100644 arch/powerpc/kernel/idle_power4.S
 delete mode 100644 arch/powerpc/kernel/traps.c
 create mode 100644 arch/powerpc/kernel/traps32.c
 create mode 100644 arch/powerpc/kernel/traps64.c
 delete mode 100644 arch/ppc64/kernel/idle_power4.S
 delete mode 100644 arch/ppc64/kernel/traps.c

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

bbc83a78c1c417cc6bb44e5a1bdcd5a56e625bc5
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -142,8 +142,8 @@ config POWER4
 	def_bool y
 
 config PPC_FPU
-	bool
-	default y if PPC64
+	depends on PPC32
+	def_bool y
 
 config BOOKE
 	bool
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -13,6 +13,8 @@ extra-$(CONFIG_POWER4)		+= idle_power4.o
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-y				+= vmlinux.lds
 
-obj-y				:= semaphore.o traps.o process.o
+obj-y				:= semaphore.o process.o
+obj-$(CONFIG_PPC32)		+= traps32.c
+obj-$(CONFIG_PPC64)		+= traps64.c
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -0,0 +1,78 @@
+/*
+ *  This file contains the power_save function for 6xx & 7xxx CPUs
+ *  rewritten in assembler
+ *
+ *  Warning ! This code assumes that if your machine has a 750fx
+ *  it will have PLL 1 set to low speed mode (used during NAP/DOZE).
+ *  if this is not the case some additional changes will have to
+ *  be done to check a runtime var (a bit like powersave-nap)
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+#undef DEBUG
+
+	.text
+
+/*
+ * Here is the power_save_6xx function. This could eventually be
+ * split into several functions & changing the function pointer
+ * depending on the various features.
+ */
+_GLOBAL(power4_idle)
+BEGIN_FTR_SECTION
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
+	/* We must dynamically check for the NAP feature as it
+	 * can be cleared by CPU init after the fixups are done
+	 */
+	LOADBASE(r3,cur_cpu_spec)
+	ld	r4,cur_cpu_spec@l(r3)
+	ld	r4,CPU_SPEC_FEATURES(r4)
+	andi.	r0,r4,CPU_FTR_CAN_NAP
+	beqlr
+	/* Now check if user or arch enabled NAP mode */
+	LOADBASE(r3,powersave_nap)
+	lwz	r4,powersave_nap@l(r3)
+	cmpwi	0,r4,0
+	beqlr
+
+	/* Clear MSR:EE */
+	mfmsr	r7
+	li	r4,0
+	ori	r4,r4,MSR_EE
+	andc	r0,r7,r4
+	mtmsrd	r0
+
+	/* Check current_thread_info()->flags */
+	clrrdi	r4,r1,THREAD_SHIFT
+	ld	r4,TI_FLAGS(r4)
+	andi.	r0,r4,_TIF_NEED_RESCHED
+	beq	1f
+	mtmsrd	r7	/* out of line this ? */
+	blr
+1:
+	/* Go to NAP now */
+BEGIN_FTR_SECTION
+	DSSALL
+	sync
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+	oris	r7,r7,MSR_POW@h
+	sync
+	isync
+	mtmsrd	r7
+	isync
+	sync
+	blr
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
deleted file mode 100644
--- a/arch/powerpc/kernel/traps.c
+++ /dev/null
@@ -1,1047 +0,0 @@
-/*
- *  arch/powerpc/kernel/traps.c
- *
- *  Copyright (C) 1995-1996  Gary Thomas (gdt@linuxppc.org)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- *
- *  Modified by Cort Dougan (cort@cs.nmt.edu)
- *  and Paul Mackerras (paulus@samba.org)
- */
-
-/*
- * This file handles the architecture-dependent parts of hardware exceptions
- */
-
-#include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/ptrace.h>
-#include <linux/slab.h>
-#include <linux/user.h>
-#include <linux/a.out.h>
-#include <linux/interrupt.h>
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/prctl.h>
-#include <linux/delay.h>
-#include <linux/kprobes.h>
-#include <asm/kdebug.h>
-
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/reg.h>
-#include <asm/xmon.h>
-#ifdef CONFIG_PMAC_BACKLIGHT
-#include <asm/backlight.h>
-#endif
-#include <asm/perfmon.h>
-
-#ifdef CONFIG_DEBUGGER
-int (*__debugger)(struct pt_regs *regs);
-int (*__debugger_ipi)(struct pt_regs *regs);
-int (*__debugger_bpt)(struct pt_regs *regs);
-int (*__debugger_sstep)(struct pt_regs *regs);
-int (*__debugger_iabr_match)(struct pt_regs *regs);
-int (*__debugger_dabr_match)(struct pt_regs *regs);
-int (*__debugger_fault_handler)(struct pt_regs *regs);
-
-EXPORT_SYMBOL(__debugger);
-EXPORT_SYMBOL(__debugger_ipi);
-EXPORT_SYMBOL(__debugger_bpt);
-EXPORT_SYMBOL(__debugger_sstep);
-EXPORT_SYMBOL(__debugger_iabr_match);
-EXPORT_SYMBOL(__debugger_dabr_match);
-EXPORT_SYMBOL(__debugger_fault_handler);
-#endif
-
-struct notifier_block *powerpc_die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
-
-int register_die_notifier(struct notifier_block *nb)
-{
-	int err = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&die_notifier_lock, flags);
-	err = notifier_chain_register(&powerpc_die_chain, nb);
-	spin_unlock_irqrestore(&die_notifier_lock, flags);
-	return err;
-}
-
-/*
- * Trap & Exception support
- */
-
-static DEFINE_SPINLOCK(die_lock);
-
-int die(const char *str, struct pt_regs *regs, long err)
-{
-	static int die_counter;
-	int nl = 0;
-
-	if (debugger(regs))
-		return 1;
-
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	bust_spinlocks(1);
-#ifdef CONFIG_PMAC_BACKLIGHT
-	if (_machine == _MACH_Pmac) {
-		set_backlight_enable(1);
-		set_backlight_level(BACKLIGHT_MAX);
-	}
-#endif
-	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
-#ifdef CONFIG_PREEMPT
-	printk("PREEMPT ");
-	nl = 1;
-#endif
-#ifdef CONFIG_SMP
-	printk("SMP NR_CPUS=%d ", NR_CPUS);
-	nl = 1;
-#endif
-#ifdef CONFIG_DEBUG_PAGEALLOC
-	printk("DEBUG_PAGEALLOC ");
-	nl = 1;
-#endif
-#ifdef CONFIG_NUMA
-	printk("NUMA ");
-	nl = 1;
-#endif
-#ifdef CONFIG_PPC64
-	switch (systemcfg->platform) {
-	case PLATFORM_PSERIES:
-		printk("PSERIES ");
-		nl = 1;
-		break;
-	case PLATFORM_PSERIES_LPAR:
-		printk("PSERIES LPAR ");
-		nl = 1;
-		break;
-	case PLATFORM_ISERIES_LPAR:
-		printk("ISERIES LPAR ");
-		nl = 1;
-		break;
-	case PLATFORM_POWERMAC:
-		printk("POWERMAC ");
-		nl = 1;
-		break;
-	case PLATFORM_BPA:
-		printk("BPA ");
-		nl = 1;
-		break;
-	}
-#endif
-	if (nl)
-		printk("\n");
-	print_modules();
-	show_regs(regs);
-	bust_spinlocks(0);
-	spin_unlock_irq(&die_lock);
-
-	if (in_interrupt())
-		panic("Fatal exception in interrupt");
-
-	if (panic_on_oops) {
-		panic("Fatal exception");
-	}
-	do_exit(err);
-
-	return 0;
-}
-
-void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
-{
-	siginfo_t info;
-
-	if (!user_mode(regs)) {
-		if (die("Exception in kernel mode", regs, signr))
-			return;
-	}
-
-	memset(&info, 0, sizeof(info));
-	info.si_signo = signr;
-	info.si_code = code;
-	info.si_addr = (void __user *) addr;
-	force_sig_info(signr, &info, current);
-
-	/*
-	 * Init gets no signals that it doesn't have a handler for.
-	 * That's all very well, but if it has caused a synchronous
-	 * exception and we ignore the resulting signal, it will just
-	 * generate the same exception over and over again and we get
-	 * nowhere.  Better to kill it and let the kernel panic.
-	 */
-	if (current->pid == 1) {
-		__sighandler_t handler;
-
-		spin_lock_irq(&current->sighand->siglock);
-		handler = current->sighand->action[signr-1].sa.sa_handler;
-		spin_unlock_irq(&current->sighand->siglock);
-		if (handler == SIG_DFL) {
-			/* init has generated a synchronous exception
-			   and it doesn't have a handler for the signal */
-			printk(KERN_CRIT "init has generated signal %d "
-			       "but has no handler for it\n", signr);
-			do_exit(signr);
-		}
-	}
-}
-
-#ifdef CONFIG_PPC64
-void system_reset_exception(struct pt_regs *regs)
-{
-	/* See if any machine dependent calls */
-	if (ppc_md.system_reset_exception)
-		ppc_md.system_reset_exception(regs);
-
-	die("System Reset", regs, SIGABRT);
-
-	/* Must die if the interrupt is not recoverable */
-	if (!(regs->msr & MSR_RI))
-		panic("Unrecoverable System Reset");
-
-	/* What should we do here? We could issue a shutdown or hard reset. */
-}
-#endif
-
-/*
- * I/O accesses can cause machine checks on powermacs.
- * Check if the NIP corresponds to the address of a sync
- * instruction for which there is an entry in the exception
- * table.
- * Note that the 601 only takes a machine check on TEA
- * (transfer error ack) signal assertion, and does not
- * set any of the top 16 bits of SRR1.
- *  -- paulus.
- */
-static inline int check_io_access(struct pt_regs *regs)
-{
-#ifdef CONFIG_PPC_PMAC
-	unsigned long msr = regs->msr;
-	const struct exception_table_entry *entry;
-	unsigned int *nip = (unsigned int *)regs->nip;
-
-	if (((msr & 0xffff0000) == 0 || (msr & (0x80000 | 0x40000)))
-	    && (entry = search_exception_tables(regs->nip)) != NULL) {
-		/*
-		 * Check that it's a sync instruction, or somewhere
-		 * in the twi; isync; nop sequence that inb/inw/inl uses.
-		 * As the address is in the exception table
-		 * we should be able to read the instr there.
-		 * For the debug message, we look at the preceding
-		 * load or store.
-		 */
-		if (*nip == 0x60000000)		/* nop */
-			nip -= 2;
-		else if (*nip == 0x4c00012c)	/* isync */
-			--nip;
-		if (*nip == 0x7c0004ac || (*nip >> 26) == 3) {
-			/* sync or twi */
-			unsigned int rb;
-
-			--nip;
-			rb = (*nip >> 11) & 0x1f;
-			printk(KERN_DEBUG "%s bad port %lx at %p\n",
-			       (*nip & 0x100)? "OUT to": "IN from",
-			       regs->gpr[rb] - _IO_BASE, nip);
-			regs->msr |= MSR_RI;
-			regs->nip = entry->fixup;
-			return 1;
-		}
-	}
-#endif /* CONFIG_PPC_PMAC */
-	return 0;
-}
-
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-/* On 4xx, the reason for the machine check or program exception
-   is in the ESR. */
-#define get_reason(regs)	((regs)->dsisr)
-#ifndef CONFIG_FSL_BOOKE
-#define get_mc_reason(regs)	((regs)->dsisr)
-#else
-#define get_mc_reason(regs)	(mfspr(SPRN_MCSR))
-#endif
-#define REASON_FP		ESR_FP
-#define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
-#define REASON_PRIVILEGED	ESR_PPR
-#define REASON_TRAP		ESR_PTR
-
-/* single-step stuff */
-#define single_stepping(regs)	(current->thread.dbcr0 & DBCR0_IC)
-#define clear_single_step(regs)	(current->thread.dbcr0 &= ~DBCR0_IC)
-
-#else
-/* On non-4xx, the reason for the machine check or program
-   exception is in the MSR. */
-#define get_reason(regs)	((regs)->msr)
-#define get_mc_reason(regs)	((regs)->msr)
-#define REASON_FP		0x100000
-#define REASON_ILLEGAL		0x80000
-#define REASON_PRIVILEGED	0x40000
-#define REASON_TRAP		0x20000
-
-#define single_stepping(regs)	((regs)->msr & MSR_SE)
-#define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
-#endif
-
-/*
- * This is "fall-back" implementation for configurations
- * which don't provide platform-specific machine check info
- */
-void __attribute__ ((weak))
-platform_machine_check(struct pt_regs *regs)
-{
-}
-
-void MachineCheckException(struct pt_regs *regs)
-{
-#ifdef CONFIG_PPC64
-	int recover = 0;
-
-	/* See if any machine dependent calls */
-	if (ppc_md.machine_check_exception)
-		recover = ppc_md.machine_check_exception(regs);
-
-	if (recover)
-		return;
-#else
-	unsigned long reason = get_mc_reason(regs);
-
-	if (user_mode(regs)) {
-		regs->msr |= MSR_RI;
-		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
-		return;
-	}
-
-#if defined(CONFIG_8xx) && defined(CONFIG_PCI)
-	/* the qspan pci read routines can cause machine checks -- Cort */
-	bad_page_fault(regs, regs->dar, SIGBUS);
-	return;
-#endif
-
-	if (debugger_fault_handler(regs)) {
-		regs->msr |= MSR_RI;
-		return;
-	}
-
-	if (check_io_access(regs))
-		return;
-
-#if defined(CONFIG_4xx) && !defined(CONFIG_440A)
-	if (reason & ESR_IMCP) {
-		printk("Instruction");
-		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
-	} else
-		printk("Data");
-	printk(" machine check in kernel mode.\n");
-#elif defined(CONFIG_440A)
-	printk("Machine check in kernel mode.\n");
-	if (reason & ESR_IMCP){
-		printk("Instruction Synchronous Machine Check exception\n");
-		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
-	}
-	else {
-		u32 mcsr = mfspr(SPRN_MCSR);
-		if (mcsr & MCSR_IB)
-			printk("Instruction Read PLB Error\n");
-		if (mcsr & MCSR_DRB)
-			printk("Data Read PLB Error\n");
-		if (mcsr & MCSR_DWB)
-			printk("Data Write PLB Error\n");
-		if (mcsr & MCSR_TLBP)
-			printk("TLB Parity Error\n");
-		if (mcsr & MCSR_ICP){
-			flush_instruction_cache();
-			printk("I-Cache Parity Error\n");
-		}
-		if (mcsr & MCSR_DCSP)
-			printk("D-Cache Search Parity Error\n");
-		if (mcsr & MCSR_DCFP)
-			printk("D-Cache Flush Parity Error\n");
-		if (mcsr & MCSR_IMPE)
-			printk("Machine Check exception is imprecise\n");
-
-		/* Clear MCSR */
-		mtspr(SPRN_MCSR, mcsr);
-	}
-#elif defined (CONFIG_E500)
-	printk("Machine check in kernel mode.\n");
-	printk("Caused by (from MCSR=%lx): ", reason);
-
-	if (reason & MCSR_MCP)
-		printk("Machine Check Signal\n");
-	if (reason & MCSR_ICPERR)
-		printk("Instruction Cache Parity Error\n");
-	if (reason & MCSR_DCP_PERR)
-		printk("Data Cache Push Parity Error\n");
-	if (reason & MCSR_DCPERR)
-		printk("Data Cache Parity Error\n");
-	if (reason & MCSR_GL_CI)
-		printk("Guarded Load or Cache-Inhibited stwcx.\n");
-	if (reason & MCSR_BUS_IAERR)
-		printk("Bus - Instruction Address Error\n");
-	if (reason & MCSR_BUS_RAERR)
-		printk("Bus - Read Address Error\n");
-	if (reason & MCSR_BUS_WAERR)
-		printk("Bus - Write Address Error\n");
-	if (reason & MCSR_BUS_IBERR)
-		printk("Bus - Instruction Data Error\n");
-	if (reason & MCSR_BUS_RBERR)
-		printk("Bus - Read Data Bus Error\n");
-	if (reason & MCSR_BUS_WBERR)
-		printk("Bus - Read Data Bus Error\n");
-	if (reason & MCSR_BUS_IPERR)
-		printk("Bus - Instruction Parity Error\n");
-	if (reason & MCSR_BUS_RPERR)
-		printk("Bus - Read Parity Error\n");
-#elif defined (CONFIG_E200)
-	printk("Machine check in kernel mode.\n");
-	printk("Caused by (from MCSR=%lx): ", reason);
-
-	if (reason & MCSR_MCP)
-		printk("Machine Check Signal\n");
-	if (reason & MCSR_CP_PERR)
-		printk("Cache Push Parity Error\n");
-	if (reason & MCSR_CPERR)
-		printk("Cache Parity Error\n");
-	if (reason & MCSR_EXCP_ERR)
-		printk("ISI, ITLB, or Bus Error on first instruction fetch for an exception handler\n");
-	if (reason & MCSR_BUS_IRERR)
-		printk("Bus - Read Bus Error on instruction fetch\n");
-	if (reason & MCSR_BUS_DRERR)
-		printk("Bus - Read Bus Error on data load\n");
-	if (reason & MCSR_BUS_WRERR)
-		printk("Bus - Write Bus Error on buffered store or cache line push\n");
-#else /* !CONFIG_4xx && !CONFIG_E500 && !CONFIG_E200 */
-	printk("Machine check in kernel mode.\n");
-	printk("Caused by (from SRR1=%lx): ", reason);
-	switch (reason & 0x601F0000) {
-	case 0x80000:
-		printk("Machine check signal\n");
-		break;
-	case 0:		/* for 601 */
-	case 0x40000:
-	case 0x140000:	/* 7450 MSS error and TEA */
-		printk("Transfer error ack signal\n");
-		break;
-	case 0x20000:
-		printk("Data parity error signal\n");
-		break;
-	case 0x10000:
-		printk("Address parity error signal\n");
-		break;
-	case 0x20000000:
-		printk("L1 Data Cache error\n");
-		break;
-	case 0x40000000:
-		printk("L1 Instruction Cache error\n");
-		break;
-	case 0x00100000:
-		printk("L2 data cache parity error\n");
-		break;
-	default:
-		printk("Unknown values in msr\n");
-	}
-#endif /* CONFIG_4xx */
-
-	/*
-	 * Optional platform-provided routine to print out
-	 * additional info, e.g. bus error registers.
-	 */
-	platform_machine_check(regs);
-#endif /* CONFIG_PPC64 */
-
-	if (debugger_fault_handler(regs))
-		return;
-	die("Machine check", regs, SIGBUS);
-
-	/* Must die if the interrupt is not recoverable */
-	if (!(regs->msr & MSR_RI))
-		panic("Unrecoverable Machine check");
-}
-
-void SMIException(struct pt_regs *regs)
-{
-	die("System Management Interrupt", regs, SIGABRT);
-}
-
-void UnknownException(struct pt_regs *regs)
-{
-	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
-	       regs->nip, regs->msr, regs->trap);
-
-	_exception(SIGTRAP, regs, 0, 0);
-}
-
-void InstructionBreakpoint(struct pt_regs *regs)
-{
-	if (notify_die(DIE_IABR_MATCH, "iabr_match", regs, 5,
-					5, SIGTRAP) == NOTIFY_STOP)
-		return;
-	if (debugger_iabr_match(regs))
-		return;
-	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
-}
-
-void RunModeException(struct pt_regs *regs)
-{
-	_exception(SIGTRAP, regs, 0, 0);
-}
-
-void SingleStepException(struct pt_regs *regs)
-{
-	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
-
-	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
-					5, SIGTRAP) == NOTIFY_STOP)
-		return;
-	if (debugger_sstep(regs))
-		return;
-
-	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
-}
-
-/*
- * After we have successfully emulated an instruction, we have to
- * check if the instruction was being single-stepped, and if so,
- * pretend we got a single-step exception.  This was pointed out
- * by Kumar Gala.  -- paulus
- */
-static void emulate_single_step(struct pt_regs *regs)
-{
-	if (single_stepping(regs)) {
-		clear_single_step(regs);
-		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
-	}
-}
-
-/* Illegal instruction emulation support.  Originally written to
- * provide the PVR to user applications using the mfspr rd, PVR.
- * Return non-zero if we can't emulate, or -EFAULT if the associated
- * memory access caused an access fault.  Return zero on success.
- *
- * There are a couple of ways to do this, either "decode" the instruction
- * or directly match lots of bits.  In this case, matching lots of
- * bits is faster and easier.
- *
- */
-#define INST_MFSPR_PVR		0x7c1f42a6
-#define INST_MFSPR_PVR_MASK	0xfc1fffff
-
-#define INST_DCBA		0x7c0005ec
-#define INST_DCBA_MASK		0x7c0007fe
-
-#define INST_MCRXR		0x7c000400
-#define INST_MCRXR_MASK		0x7c0007fe
-
-#define INST_STRING		0x7c00042a
-#define INST_STRING_MASK	0x7c0007fe
-#define INST_STRING_GEN_MASK	0x7c00067e
-#define INST_LSWI		0x7c0004aa
-#define INST_LSWX		0x7c00042a
-#define INST_STSWI		0x7c0005aa
-#define INST_STSWX		0x7c00052a
-
-static int emulate_string_inst(struct pt_regs *regs, u32 instword)
-{
-	u8 rT = (instword >> 21) & 0x1f;
-	u8 rA = (instword >> 16) & 0x1f;
-	u8 NB_RB = (instword >> 11) & 0x1f;
-	u32 num_bytes;
-	unsigned long EA;
-	int pos = 0;
-
-	/* Early out if we are an invalid form of lswx */
-	if ((instword & INST_STRING_MASK) == INST_LSWX)
-		if ((rT == rA) || (rT == NB_RB))
-			return -EINVAL;
-
-	EA = (rA == 0) ? 0 : regs->gpr[rA];
-
-	switch (instword & INST_STRING_MASK) {
-		case INST_LSWX:
-		case INST_STSWX:
-			EA += NB_RB;
-			num_bytes = regs->xer & 0x7f;
-			break;
-		case INST_LSWI:
-		case INST_STSWI:
-			num_bytes = (NB_RB == 0) ? 32 : NB_RB;
-			break;
-		default:
-			return -EINVAL;
-	}
-
-	while (num_bytes != 0)
-	{
-		u8 val;
-		u32 shift = 8 * (3 - (pos & 0x3));
-
-		switch ((instword & INST_STRING_MASK)) {
-			case INST_LSWX:
-			case INST_LSWI:
-				if (get_user(val, (u8 __user *)EA))
-					return -EFAULT;
-				/* first time updating this reg,
-				 * zero it out */
-				if (pos == 0)
-					regs->gpr[rT] = 0;
-				regs->gpr[rT] |= val << shift;
-				break;
-			case INST_STSWI:
-			case INST_STSWX:
-				val = regs->gpr[rT] >> shift;
-				if (put_user(val, (u8 __user *)EA))
-					return -EFAULT;
-				break;
-		}
-		/* move EA to next address */
-		EA += 1;
-		num_bytes--;
-
-		/* manage our position within the register */
-		if (++pos == 4) {
-			pos = 0;
-			if (++rT == 32)
-				rT = 0;
-		}
-	}
-
-	return 0;
-}
-
-static int emulate_instruction(struct pt_regs *regs)
-{
-	u32 instword;
-	u32 rd;
-
-	if (!user_mode(regs))
-		return -EINVAL;
-	CHECK_FULL_REGS(regs);
-
-	if (get_user(instword, (u32 __user *)(regs->nip)))
-		return -EFAULT;
-
-	/* Emulate the mfspr rD, PVR. */
-	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
-		rd = (instword >> 21) & 0x1f;
-		regs->gpr[rd] = mfspr(SPRN_PVR);
-		return 0;
-	}
-
-	/* Emulating the dcba insn is just a no-op.  */
-	if ((instword & INST_DCBA_MASK) == INST_DCBA)
-		return 0;
-
-	/* Emulate the mcrxr insn.  */
-	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
-		int shift = (instword >> 21) & 0x1c;
-		unsigned long msk = 0xf0000000UL >> shift;
-
-		regs->ccr = (regs->ccr & ~msk) | ((regs->xer >> shift) & msk);
-		regs->xer &= ~0xf0000000UL;
-		return 0;
-	}
-
-	/* Emulate load/store string insn. */
-	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
-		return emulate_string_inst(regs, instword);
-
-	return -EINVAL;
-}
-
-/*
- * Look through the list of trap instructions that are used for BUG(),
- * BUG_ON() and WARN_ON() and see if we hit one.  At this point we know
- * that the exception was caused by a trap instruction of some kind.
- * Returns 1 if we should continue (i.e. it was a WARN_ON) or 0
- * otherwise.
- */
-extern struct bug_entry __start___bug_table[], __stop___bug_table[];
-
-#ifndef CONFIG_MODULES
-#define module_find_bug(x)	NULL
-#endif
-
-struct bug_entry *find_bug(unsigned long bugaddr)
-{
-	struct bug_entry *bug;
-
-	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
-		if (bugaddr == bug->bug_addr)
-			return bug;
-	return module_find_bug(bugaddr);
-}
-
-int check_bug_trap(struct pt_regs *regs)
-{
-	struct bug_entry *bug;
-	unsigned long addr;
-
-	if (regs->msr & MSR_PR)
-		return 0;	/* not in kernel */
-	addr = regs->nip;	/* address of trap instruction */
-	if (addr < PAGE_OFFSET)
-		return 0;
-	bug = find_bug(regs->nip);
-	if (bug == NULL)
-		return 0;
-	if (bug->line & BUG_WARNING_TRAP) {
-		/* this is a WARN_ON rather than BUG/BUG_ON */
-#ifdef CONFIG_XMON
-		xmon_printf(KERN_ERR "Badness in %s at %s:%d\n",
-		       bug->function, bug->file,
-		       bug->line & ~BUG_WARNING_TRAP);
-#endif /* CONFIG_XMON */		
-		printk(KERN_ERR "Badness in %s at %s:%d\n",
-		       bug->function, bug->file,
-		       bug->line & ~BUG_WARNING_TRAP);
-		dump_stack();
-		return 1;
-	}
-#ifdef CONFIG_XMON
-	xmon_printf(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
-	       bug->function, bug->file, bug->line);
-	xmon(regs);
-#endif /* CONFIG_XMON */
-	printk(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
-	       bug->function, bug->file, bug->line);
-
-	return 0;
-}
-
-void ProgramCheckException(struct pt_regs *regs)
-{
-	unsigned int reason = get_reason(regs);
-	extern int do_mathemu(struct pt_regs *regs);
-
-#ifdef CONFIG_MATH_EMULATION
-	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
-	 * but there seems to be a hardware bug on the 405GP (RevD)
-	 * that means ESR is sometimes set incorrectly - either to
-	 * ESR_DST (!?) or 0.  In the process of chasing this with the
-	 * hardware people - not sure if it can happen on any illegal
-	 * instruction or only on FP instructions, whether there is a
-	 * pattern to occurences etc. -dgibson 31/Mar/2003 */
-	if (!(reason & REASON_TRAP) && do_mathemu(regs) == 0) {
-		emulate_single_step(regs);
-		return;
-	}
-#endif /* CONFIG_MATH_EMULATION */
-
-	if (reason & REASON_FP) {
-		/* IEEE FP exception */
-		int code = 0;
-		u32 fpscr;
-
-		/* We must make sure the FP state is consistent with
-		 * our MSR_FP in regs
-		 */
-		preempt_disable();
-		if (regs->msr & MSR_FP)
-			giveup_fpu(current);
-		preempt_enable();
-
-		fpscr = current->thread.fpscr;
-		fpscr &= fpscr << 22;	/* mask summary bits with enables */
-		if (fpscr & FPSCR_VX)
-			code = FPE_FLTINV;
-		else if (fpscr & FPSCR_OX)
-			code = FPE_FLTOVF;
-		else if (fpscr & FPSCR_UX)
-			code = FPE_FLTUND;
-		else if (fpscr & FPSCR_ZX)
-			code = FPE_FLTDIV;
-		else if (fpscr & FPSCR_XX)
-			code = FPE_FLTRES;
-		_exception(SIGFPE, regs, code, regs->nip);
-		return;
-	}
-
-	if (reason & REASON_TRAP) {
-		/* trap exception */
-		if (debugger_bpt(regs))
-			return;
-		if (check_bug_trap(regs)) {
-			regs->nip += 4;
-			return;
-		}
-		_exception(SIGTRAP, regs, TRAP_BRKPT, 0);
-		return;
-	}
-
-	/* Try to emulate it if we should. */
-	if (reason & (REASON_ILLEGAL | REASON_PRIVILEGED)) {
-		switch (emulate_instruction(regs)) {
-		case 0:
-			regs->nip += 4;
-			emulate_single_step(regs);
-			return;
-		case -EFAULT:
-			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
-			return;
-		}
-	}
-
-	if (reason & REASON_PRIVILEGED)
-		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
-	else
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-}
-
-void AlignmentException(struct pt_regs *regs)
-{
-	int fixed;
-
-	fixed = fix_alignment(regs);
-
-	if (fixed == 1) {
-		regs->nip += 4;	/* skip over emulated instruction */
-		emulate_single_step(regs);
-		return;
-	}
-
-	/* Operand address was bad */	
-	if (fixed == -EFAULT) {
-		if (user_mode(regs))
-			_exception(SIGSEGV, regs, SEGV_ACCERR, regs->dar);
-		else
-			/* Search exception table */
-			bad_page_fault(regs, regs->dar, SIGSEGV);
-		return;
-	}
-	_exception(SIGBUS, regs, BUS_ADRALN, regs->dar);
-}
-
-void StackOverflow(struct pt_regs *regs)
-{
-	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
-	       current, regs->gpr[1]);
-	debugger(regs);
-	show_regs(regs);
-	panic("kernel stack overflow");
-}
-
-void nonrecoverable_exception(struct pt_regs *regs)
-{
-	printk(KERN_ERR "Non-recoverable exception at PC=%lx MSR=%lx\n",
-	       regs->nip, regs->msr);
-	debugger(regs);
-	die("nonrecoverable exception", regs, SIGKILL);
-}
-
-void trace_syscall(struct pt_regs *regs)
-{
-	printk("Task: %p(%d), PC: %08lX/%08lX, Syscall: %3ld, Result: %s%ld    %s\n",
-	       current, current->pid, regs->nip, regs->link, regs->gpr[0],
-	       regs->ccr&0x10000000?"Error=":"", regs->gpr[3], print_tainted());
-}
-
-#ifdef CONFIG_8xx
-void SoftwareEmulation(struct pt_regs *regs)
-{
-	extern int do_mathemu(struct pt_regs *);
-	extern int Soft_emulate_8xx(struct pt_regs *);
-	int errcode;
-
-	CHECK_FULL_REGS(regs);
-
-	if (!user_mode(regs)) {
-		debugger(regs);
-		die("Kernel Mode Software FPU Emulation", regs, SIGFPE);
-	}
-
-#ifdef CONFIG_MATH_EMULATION
-	errcode = do_mathemu(regs);
-#else
-	errcode = Soft_emulate_8xx(regs);
-#endif
-	if (errcode) {
-		if (errcode > 0)
-			_exception(SIGFPE, regs, 0, 0);
-		else if (errcode == -EFAULT)
-			_exception(SIGSEGV, regs, 0, 0);
-		else
-			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-	} else
-		emulate_single_step(regs);
-}
-#endif /* CONFIG_8xx */
-
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-
-void DebugException(struct pt_regs *regs, unsigned long debug_status)
-{
-	if (debug_status & DBSR_IC) {	/* instruction completion */
-		regs->msr &= ~MSR_DE;
-		if (user_mode(regs)) {
-			current->thread.dbcr0 &= ~DBCR0_IC;
-		} else {
-			/* Disable instruction completion */
-			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
-			/* Clear the instruction completion event */
-			mtspr(SPRN_DBSR, DBSR_IC);
-			if (debugger_sstep(regs))
-				return;
-		}
-		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
-	}
-}
-#endif /* CONFIG_4xx || CONFIG_BOOKE */
-
-#if !defined(CONFIG_TAU_INT)
-void TAUException(struct pt_regs *regs)
-{
-	printk("TAU trap at PC: %lx, MSR: %lx, vector=%lx    %s\n",
-	       regs->nip, regs->msr, regs->trap, print_tainted());
-}
-#endif /* CONFIG_INT_TAU */
-
-void AltivecUnavailException(struct pt_regs *regs)
-{
-	static int kernel_altivec_count;
-
-#ifndef CONFIG_ALTIVEC
-	if (user_mode(regs)) {
-		/* A user program has executed an altivec instruction,
-		   but this kernel doesn't support altivec. */
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-		return;
-	}
-#endif
-	/* The kernel has executed an altivec instruction without
-	   first enabling altivec.  Whinge but let it do it. */
-	if (++kernel_altivec_count < 10)
-		printk(KERN_ERR "AltiVec used in kernel (task=%p, pc=%lx)\n",
-		       current, regs->nip);
-	regs->msr |= MSR_VEC;
-}
-
-#ifdef CONFIG_ALTIVEC
-void AltivecAssistException(struct pt_regs *regs)
-{
-	int err;
-
-	preempt_disable();
-	if (regs->msr & MSR_VEC)
-		giveup_altivec(current);
-	preempt_enable();
-	if (!user_mode(regs)) {
-		printk(KERN_EMERG "VMX/Altivec assist exception in kernel mode"
-		       " at %lx\n", regs->nip);
-		die("Kernel Altivec assist exception", regs, SIGILL);
-	}
-
-	err = emulate_altivec(regs);
-	if (err == 0) {
-		regs->nip += 4;		/* skip emulated instruction */
-		emulate_single_step(regs);
-		return;
-	}
-
-	if (err == -EFAULT) {
-		/* got an error reading the instruction */
-		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
-	} else {
-		/* didn't recognize the instruction */
-		/* XXX quick hack for now: set the non-Java bit in the VSCR */
-		if (printk_ratelimit())
-			printk(KERN_ERR "Unrecognized altivec instruction "
-			       "in %s at %lx\n", current->comm, regs->nip);
-		current->thread.vscr.u[3] |= 0x10000;
-	}
-}
-#endif /* CONFIG_ALTIVEC */
-
-#ifdef CONFIG_E500
-void PerformanceMonitorException(struct pt_regs *regs)
-{
-	perf_irq(regs);
-}
-#endif
-
-#ifdef CONFIG_FSL_BOOKE
-void CacheLockingException(struct pt_regs *regs, unsigned long address,
-			   unsigned long error_code)
-{
-	/* We treat cache locking instructions from the user
-	 * as priv ops, in the future we could try to do
-	 * something smarter
-	 */
-	if (error_code & (ESR_DLK|ESR_ILK))
-		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
-	return;
-}
-#endif /* CONFIG_FSL_BOOKE */
-
-#ifdef CONFIG_SPE
-void SPEFloatingPointException(struct pt_regs *regs)
-{
-	unsigned long spefscr;
-	int fpexc_mode;
-	int code = 0;
-
-	spefscr = current->thread.spefscr;
-	fpexc_mode = current->thread.fpexc_mode;
-
-	/* Hardware does not neccessarily set sticky
-	 * underflow/overflow/invalid flags */
-	if ((spefscr & SPEFSCR_FOVF) && (fpexc_mode & PR_FP_EXC_OVF)) {
-		code = FPE_FLTOVF;
-		spefscr |= SPEFSCR_FOVFS;
-	}
-	else if ((spefscr & SPEFSCR_FUNF) && (fpexc_mode & PR_FP_EXC_UND)) {
-		code = FPE_FLTUND;
-		spefscr |= SPEFSCR_FUNFS;
-	}
-	else if ((spefscr & SPEFSCR_FDBZ) && (fpexc_mode & PR_FP_EXC_DIV))
-		code = FPE_FLTDIV;
-	else if ((spefscr & SPEFSCR_FINV) && (fpexc_mode & PR_FP_EXC_INV)) {
-		code = FPE_FLTINV;
-		spefscr |= SPEFSCR_FINVS;
-	}
-	else if ((spefscr & (SPEFSCR_FG | SPEFSCR_FX)) && (fpexc_mode & PR_FP_EXC_RES))
-		code = FPE_FLTRES;
-
-	current->thread.spefscr = spefscr;
-
-	_exception(SIGFPE, regs, code, regs->nip);
-	return;
-}
-#endif
-
-#ifdef CONFIG_BOOKE_WDT
-/*
- * Default handler for a Watchdog exception,
- * spins until a reboot occurs
- */
-void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
-{
-	/* Generic WatchdogHandler, implement your own */
-	mtspr(SPRN_TCR, mfspr(SPRN_TCR)&(~TCR_WIE));
-	return;
-}
-
-void WatchdogException(struct pt_regs *regs)
-{
-	printk (KERN_EMERG "PowerPC Book-E Watchdog Exception\n");
-	WatchdogHandler(regs);
-}
-#endif
-
-void __init trap_init(void)
-{
-}
diff --git a/arch/powerpc/kernel/traps32.c b/arch/powerpc/kernel/traps32.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/kernel/traps32.c
@@ -0,0 +1,1047 @@
+/*
+ *  arch/powerpc/kernel/traps.c
+ *
+ *  Copyright (C) 1995-1996  Gary Thomas (gdt@linuxppc.org)
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ *  Modified by Cort Dougan (cort@cs.nmt.edu)
+ *  and Paul Mackerras (paulus@samba.org)
+ */
+
+/*
+ * This file handles the architecture-dependent parts of hardware exceptions
+ */
+
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/a.out.h>
+#include <linux/interrupt.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/prctl.h>
+#include <linux/delay.h>
+#include <linux/kprobes.h>
+#include <asm/kdebug.h>
+
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/reg.h>
+#include <asm/xmon.h>
+#ifdef CONFIG_PMAC_BACKLIGHT
+#include <asm/backlight.h>
+#endif
+#include <asm/perfmon.h>
+
+#ifdef CONFIG_DEBUGGER
+int (*__debugger)(struct pt_regs *regs);
+int (*__debugger_ipi)(struct pt_regs *regs);
+int (*__debugger_bpt)(struct pt_regs *regs);
+int (*__debugger_sstep)(struct pt_regs *regs);
+int (*__debugger_iabr_match)(struct pt_regs *regs);
+int (*__debugger_dabr_match)(struct pt_regs *regs);
+int (*__debugger_fault_handler)(struct pt_regs *regs);
+
+EXPORT_SYMBOL(__debugger);
+EXPORT_SYMBOL(__debugger_ipi);
+EXPORT_SYMBOL(__debugger_bpt);
+EXPORT_SYMBOL(__debugger_sstep);
+EXPORT_SYMBOL(__debugger_iabr_match);
+EXPORT_SYMBOL(__debugger_dabr_match);
+EXPORT_SYMBOL(__debugger_fault_handler);
+#endif
+
+struct notifier_block *powerpc_die_chain;
+static DEFINE_SPINLOCK(die_notifier_lock);
+
+int register_die_notifier(struct notifier_block *nb)
+{
+	int err = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&die_notifier_lock, flags);
+	err = notifier_chain_register(&powerpc_die_chain, nb);
+	spin_unlock_irqrestore(&die_notifier_lock, flags);
+	return err;
+}
+
+/*
+ * Trap & Exception support
+ */
+
+static DEFINE_SPINLOCK(die_lock);
+
+int die(const char *str, struct pt_regs *regs, long err)
+{
+	static int die_counter;
+	int nl = 0;
+
+	if (debugger(regs))
+		return 1;
+
+	console_verbose();
+	spin_lock_irq(&die_lock);
+	bust_spinlocks(1);
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if (_machine == _MACH_Pmac) {
+		set_backlight_enable(1);
+		set_backlight_level(BACKLIGHT_MAX);
+	}
+#endif
+	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
+#ifdef CONFIG_PREEMPT
+	printk("PREEMPT ");
+	nl = 1;
+#endif
+#ifdef CONFIG_SMP
+	printk("SMP NR_CPUS=%d ", NR_CPUS);
+	nl = 1;
+#endif
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	printk("DEBUG_PAGEALLOC ");
+	nl = 1;
+#endif
+#ifdef CONFIG_NUMA
+	printk("NUMA ");
+	nl = 1;
+#endif
+#ifdef CONFIG_PPC64
+	switch (systemcfg->platform) {
+	case PLATFORM_PSERIES:
+		printk("PSERIES ");
+		nl = 1;
+		break;
+	case PLATFORM_PSERIES_LPAR:
+		printk("PSERIES LPAR ");
+		nl = 1;
+		break;
+	case PLATFORM_ISERIES_LPAR:
+		printk("ISERIES LPAR ");
+		nl = 1;
+		break;
+	case PLATFORM_POWERMAC:
+		printk("POWERMAC ");
+		nl = 1;
+		break;
+	case PLATFORM_BPA:
+		printk("BPA ");
+		nl = 1;
+		break;
+	}
+#endif
+	if (nl)
+		printk("\n");
+	print_modules();
+	show_regs(regs);
+	bust_spinlocks(0);
+	spin_unlock_irq(&die_lock);
+
+	if (in_interrupt())
+		panic("Fatal exception in interrupt");
+
+	if (panic_on_oops) {
+		panic("Fatal exception");
+	}
+	do_exit(err);
+
+	return 0;
+}
+
+void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
+{
+	siginfo_t info;
+
+	if (!user_mode(regs)) {
+		if (die("Exception in kernel mode", regs, signr))
+			return;
+	}
+
+	memset(&info, 0, sizeof(info));
+	info.si_signo = signr;
+	info.si_code = code;
+	info.si_addr = (void __user *) addr;
+	force_sig_info(signr, &info, current);
+
+	/*
+	 * Init gets no signals that it doesn't have a handler for.
+	 * That's all very well, but if it has caused a synchronous
+	 * exception and we ignore the resulting signal, it will just
+	 * generate the same exception over and over again and we get
+	 * nowhere.  Better to kill it and let the kernel panic.
+	 */
+	if (current->pid == 1) {
+		__sighandler_t handler;
+
+		spin_lock_irq(&current->sighand->siglock);
+		handler = current->sighand->action[signr-1].sa.sa_handler;
+		spin_unlock_irq(&current->sighand->siglock);
+		if (handler == SIG_DFL) {
+			/* init has generated a synchronous exception
+			   and it doesn't have a handler for the signal */
+			printk(KERN_CRIT "init has generated signal %d "
+			       "but has no handler for it\n", signr);
+			do_exit(signr);
+		}
+	}
+}
+
+#ifdef CONFIG_PPC64
+void system_reset_exception(struct pt_regs *regs)
+{
+	/* See if any machine dependent calls */
+	if (ppc_md.system_reset_exception)
+		ppc_md.system_reset_exception(regs);
+
+	die("System Reset", regs, SIGABRT);
+
+	/* Must die if the interrupt is not recoverable */
+	if (!(regs->msr & MSR_RI))
+		panic("Unrecoverable System Reset");
+
+	/* What should we do here? We could issue a shutdown or hard reset. */
+}
+#endif
+
+/*
+ * I/O accesses can cause machine checks on powermacs.
+ * Check if the NIP corresponds to the address of a sync
+ * instruction for which there is an entry in the exception
+ * table.
+ * Note that the 601 only takes a machine check on TEA
+ * (transfer error ack) signal assertion, and does not
+ * set any of the top 16 bits of SRR1.
+ *  -- paulus.
+ */
+static inline int check_io_access(struct pt_regs *regs)
+{
+#ifdef CONFIG_PPC_PMAC
+	unsigned long msr = regs->msr;
+	const struct exception_table_entry *entry;
+	unsigned int *nip = (unsigned int *)regs->nip;
+
+	if (((msr & 0xffff0000) == 0 || (msr & (0x80000 | 0x40000)))
+	    && (entry = search_exception_tables(regs->nip)) != NULL) {
+		/*
+		 * Check that it's a sync instruction, or somewhere
+		 * in the twi; isync; nop sequence that inb/inw/inl uses.
+		 * As the address is in the exception table
+		 * we should be able to read the instr there.
+		 * For the debug message, we look at the preceding
+		 * load or store.
+		 */
+		if (*nip == 0x60000000)		/* nop */
+			nip -= 2;
+		else if (*nip == 0x4c00012c)	/* isync */
+			--nip;
+		if (*nip == 0x7c0004ac || (*nip >> 26) == 3) {
+			/* sync or twi */
+			unsigned int rb;
+
+			--nip;
+			rb = (*nip >> 11) & 0x1f;
+			printk(KERN_DEBUG "%s bad port %lx at %p\n",
+			       (*nip & 0x100)? "OUT to": "IN from",
+			       regs->gpr[rb] - _IO_BASE, nip);
+			regs->msr |= MSR_RI;
+			regs->nip = entry->fixup;
+			return 1;
+		}
+	}
+#endif /* CONFIG_PPC_PMAC */
+	return 0;
+}
+
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+/* On 4xx, the reason for the machine check or program exception
+   is in the ESR. */
+#define get_reason(regs)	((regs)->dsisr)
+#ifndef CONFIG_FSL_BOOKE
+#define get_mc_reason(regs)	((regs)->dsisr)
+#else
+#define get_mc_reason(regs)	(mfspr(SPRN_MCSR))
+#endif
+#define REASON_FP		ESR_FP
+#define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
+#define REASON_PRIVILEGED	ESR_PPR
+#define REASON_TRAP		ESR_PTR
+
+/* single-step stuff */
+#define single_stepping(regs)	(current->thread.dbcr0 & DBCR0_IC)
+#define clear_single_step(regs)	(current->thread.dbcr0 &= ~DBCR0_IC)
+
+#else
+/* On non-4xx, the reason for the machine check or program
+   exception is in the MSR. */
+#define get_reason(regs)	((regs)->msr)
+#define get_mc_reason(regs)	((regs)->msr)
+#define REASON_FP		0x100000
+#define REASON_ILLEGAL		0x80000
+#define REASON_PRIVILEGED	0x40000
+#define REASON_TRAP		0x20000
+
+#define single_stepping(regs)	((regs)->msr & MSR_SE)
+#define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
+#endif
+
+/*
+ * This is "fall-back" implementation for configurations
+ * which don't provide platform-specific machine check info
+ */
+void __attribute__ ((weak))
+platform_machine_check(struct pt_regs *regs)
+{
+}
+
+void MachineCheckException(struct pt_regs *regs)
+{
+#ifdef CONFIG_PPC64
+	int recover = 0;
+
+	/* See if any machine dependent calls */
+	if (ppc_md.machine_check_exception)
+		recover = ppc_md.machine_check_exception(regs);
+
+	if (recover)
+		return;
+#else
+	unsigned long reason = get_mc_reason(regs);
+
+	if (user_mode(regs)) {
+		regs->msr |= MSR_RI;
+		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
+		return;
+	}
+
+#if defined(CONFIG_8xx) && defined(CONFIG_PCI)
+	/* the qspan pci read routines can cause machine checks -- Cort */
+	bad_page_fault(regs, regs->dar, SIGBUS);
+	return;
+#endif
+
+	if (debugger_fault_handler(regs)) {
+		regs->msr |= MSR_RI;
+		return;
+	}
+
+	if (check_io_access(regs))
+		return;
+
+#if defined(CONFIG_4xx) && !defined(CONFIG_440A)
+	if (reason & ESR_IMCP) {
+		printk("Instruction");
+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
+	} else
+		printk("Data");
+	printk(" machine check in kernel mode.\n");
+#elif defined(CONFIG_440A)
+	printk("Machine check in kernel mode.\n");
+	if (reason & ESR_IMCP){
+		printk("Instruction Synchronous Machine Check exception\n");
+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
+	}
+	else {
+		u32 mcsr = mfspr(SPRN_MCSR);
+		if (mcsr & MCSR_IB)
+			printk("Instruction Read PLB Error\n");
+		if (mcsr & MCSR_DRB)
+			printk("Data Read PLB Error\n");
+		if (mcsr & MCSR_DWB)
+			printk("Data Write PLB Error\n");
+		if (mcsr & MCSR_TLBP)
+			printk("TLB Parity Error\n");
+		if (mcsr & MCSR_ICP){
+			flush_instruction_cache();
+			printk("I-Cache Parity Error\n");
+		}
+		if (mcsr & MCSR_DCSP)
+			printk("D-Cache Search Parity Error\n");
+		if (mcsr & MCSR_DCFP)
+			printk("D-Cache Flush Parity Error\n");
+		if (mcsr & MCSR_IMPE)
+			printk("Machine Check exception is imprecise\n");
+
+		/* Clear MCSR */
+		mtspr(SPRN_MCSR, mcsr);
+	}
+#elif defined (CONFIG_E500)
+	printk("Machine check in kernel mode.\n");
+	printk("Caused by (from MCSR=%lx): ", reason);
+
+	if (reason & MCSR_MCP)
+		printk("Machine Check Signal\n");
+	if (reason & MCSR_ICPERR)
+		printk("Instruction Cache Parity Error\n");
+	if (reason & MCSR_DCP_PERR)
+		printk("Data Cache Push Parity Error\n");
+	if (reason & MCSR_DCPERR)
+		printk("Data Cache Parity Error\n");
+	if (reason & MCSR_GL_CI)
+		printk("Guarded Load or Cache-Inhibited stwcx.\n");
+	if (reason & MCSR_BUS_IAERR)
+		printk("Bus - Instruction Address Error\n");
+	if (reason & MCSR_BUS_RAERR)
+		printk("Bus - Read Address Error\n");
+	if (reason & MCSR_BUS_WAERR)
+		printk("Bus - Write Address Error\n");
+	if (reason & MCSR_BUS_IBERR)
+		printk("Bus - Instruction Data Error\n");
+	if (reason & MCSR_BUS_RBERR)
+		printk("Bus - Read Data Bus Error\n");
+	if (reason & MCSR_BUS_WBERR)
+		printk("Bus - Read Data Bus Error\n");
+	if (reason & MCSR_BUS_IPERR)
+		printk("Bus - Instruction Parity Error\n");
+	if (reason & MCSR_BUS_RPERR)
+		printk("Bus - Read Parity Error\n");
+#elif defined (CONFIG_E200)
+	printk("Machine check in kernel mode.\n");
+	printk("Caused by (from MCSR=%lx): ", reason);
+
+	if (reason & MCSR_MCP)
+		printk("Machine Check Signal\n");
+	if (reason & MCSR_CP_PERR)
+		printk("Cache Push Parity Error\n");
+	if (reason & MCSR_CPERR)
+		printk("Cache Parity Error\n");
+	if (reason & MCSR_EXCP_ERR)
+		printk("ISI, ITLB, or Bus Error on first instruction fetch for an exception handler\n");
+	if (reason & MCSR_BUS_IRERR)
+		printk("Bus - Read Bus Error on instruction fetch\n");
+	if (reason & MCSR_BUS_DRERR)
+		printk("Bus - Read Bus Error on data load\n");
+	if (reason & MCSR_BUS_WRERR)
+		printk("Bus - Write Bus Error on buffered store or cache line push\n");
+#else /* !CONFIG_4xx && !CONFIG_E500 && !CONFIG_E200 */
+	printk("Machine check in kernel mode.\n");
+	printk("Caused by (from SRR1=%lx): ", reason);
+	switch (reason & 0x601F0000) {
+	case 0x80000:
+		printk("Machine check signal\n");
+		break;
+	case 0:		/* for 601 */
+	case 0x40000:
+	case 0x140000:	/* 7450 MSS error and TEA */
+		printk("Transfer error ack signal\n");
+		break;
+	case 0x20000:
+		printk("Data parity error signal\n");
+		break;
+	case 0x10000:
+		printk("Address parity error signal\n");
+		break;
+	case 0x20000000:
+		printk("L1 Data Cache error\n");
+		break;
+	case 0x40000000:
+		printk("L1 Instruction Cache error\n");
+		break;
+	case 0x00100000:
+		printk("L2 data cache parity error\n");
+		break;
+	default:
+		printk("Unknown values in msr\n");
+	}
+#endif /* CONFIG_4xx */
+
+	/*
+	 * Optional platform-provided routine to print out
+	 * additional info, e.g. bus error registers.
+	 */
+	platform_machine_check(regs);
+#endif /* CONFIG_PPC64 */
+
+	if (debugger_fault_handler(regs))
+		return;
+	die("Machine check", regs, SIGBUS);
+
+	/* Must die if the interrupt is not recoverable */
+	if (!(regs->msr & MSR_RI))
+		panic("Unrecoverable Machine check");
+}
+
+void SMIException(struct pt_regs *regs)
+{
+	die("System Management Interrupt", regs, SIGABRT);
+}
+
+void UnknownException(struct pt_regs *regs)
+{
+	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
+	       regs->nip, regs->msr, regs->trap);
+
+	_exception(SIGTRAP, regs, 0, 0);
+}
+
+void InstructionBreakpoint(struct pt_regs *regs)
+{
+	if (notify_die(DIE_IABR_MATCH, "iabr_match", regs, 5,
+					5, SIGTRAP) == NOTIFY_STOP)
+		return;
+	if (debugger_iabr_match(regs))
+		return;
+	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
+}
+
+void RunModeException(struct pt_regs *regs)
+{
+	_exception(SIGTRAP, regs, 0, 0);
+}
+
+void SingleStepException(struct pt_regs *regs)
+{
+	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
+
+	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
+					5, SIGTRAP) == NOTIFY_STOP)
+		return;
+	if (debugger_sstep(regs))
+		return;
+
+	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
+}
+
+/*
+ * After we have successfully emulated an instruction, we have to
+ * check if the instruction was being single-stepped, and if so,
+ * pretend we got a single-step exception.  This was pointed out
+ * by Kumar Gala.  -- paulus
+ */
+static void emulate_single_step(struct pt_regs *regs)
+{
+	if (single_stepping(regs)) {
+		clear_single_step(regs);
+		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
+	}
+}
+
+/* Illegal instruction emulation support.  Originally written to
+ * provide the PVR to user applications using the mfspr rd, PVR.
+ * Return non-zero if we can't emulate, or -EFAULT if the associated
+ * memory access caused an access fault.  Return zero on success.
+ *
+ * There are a couple of ways to do this, either "decode" the instruction
+ * or directly match lots of bits.  In this case, matching lots of
+ * bits is faster and easier.
+ *
+ */
+#define INST_MFSPR_PVR		0x7c1f42a6
+#define INST_MFSPR_PVR_MASK	0xfc1fffff
+
+#define INST_DCBA		0x7c0005ec
+#define INST_DCBA_MASK		0x7c0007fe
+
+#define INST_MCRXR		0x7c000400
+#define INST_MCRXR_MASK		0x7c0007fe
+
+#define INST_STRING		0x7c00042a
+#define INST_STRING_MASK	0x7c0007fe
+#define INST_STRING_GEN_MASK	0x7c00067e
+#define INST_LSWI		0x7c0004aa
+#define INST_LSWX		0x7c00042a
+#define INST_STSWI		0x7c0005aa
+#define INST_STSWX		0x7c00052a
+
+static int emulate_string_inst(struct pt_regs *regs, u32 instword)
+{
+	u8 rT = (instword >> 21) & 0x1f;
+	u8 rA = (instword >> 16) & 0x1f;
+	u8 NB_RB = (instword >> 11) & 0x1f;
+	u32 num_bytes;
+	unsigned long EA;
+	int pos = 0;
+
+	/* Early out if we are an invalid form of lswx */
+	if ((instword & INST_STRING_MASK) == INST_LSWX)
+		if ((rT == rA) || (rT == NB_RB))
+			return -EINVAL;
+
+	EA = (rA == 0) ? 0 : regs->gpr[rA];
+
+	switch (instword & INST_STRING_MASK) {
+		case INST_LSWX:
+		case INST_STSWX:
+			EA += NB_RB;
+			num_bytes = regs->xer & 0x7f;
+			break;
+		case INST_LSWI:
+		case INST_STSWI:
+			num_bytes = (NB_RB == 0) ? 32 : NB_RB;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	while (num_bytes != 0)
+	{
+		u8 val;
+		u32 shift = 8 * (3 - (pos & 0x3));
+
+		switch ((instword & INST_STRING_MASK)) {
+			case INST_LSWX:
+			case INST_LSWI:
+				if (get_user(val, (u8 __user *)EA))
+					return -EFAULT;
+				/* first time updating this reg,
+				 * zero it out */
+				if (pos == 0)
+					regs->gpr[rT] = 0;
+				regs->gpr[rT] |= val << shift;
+				break;
+			case INST_STSWI:
+			case INST_STSWX:
+				val = regs->gpr[rT] >> shift;
+				if (put_user(val, (u8 __user *)EA))
+					return -EFAULT;
+				break;
+		}
+		/* move EA to next address */
+		EA += 1;
+		num_bytes--;
+
+		/* manage our position within the register */
+		if (++pos == 4) {
+			pos = 0;
+			if (++rT == 32)
+				rT = 0;
+		}
+	}
+
+	return 0;
+}
+
+static int emulate_instruction(struct pt_regs *regs)
+{
+	u32 instword;
+	u32 rd;
+
+	if (!user_mode(regs))
+		return -EINVAL;
+	CHECK_FULL_REGS(regs);
+
+	if (get_user(instword, (u32 __user *)(regs->nip)))
+		return -EFAULT;
+
+	/* Emulate the mfspr rD, PVR. */
+	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
+		rd = (instword >> 21) & 0x1f;
+		regs->gpr[rd] = mfspr(SPRN_PVR);
+		return 0;
+	}
+
+	/* Emulating the dcba insn is just a no-op.  */
+	if ((instword & INST_DCBA_MASK) == INST_DCBA)
+		return 0;
+
+	/* Emulate the mcrxr insn.  */
+	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
+		int shift = (instword >> 21) & 0x1c;
+		unsigned long msk = 0xf0000000UL >> shift;
+
+		regs->ccr = (regs->ccr & ~msk) | ((regs->xer >> shift) & msk);
+		regs->xer &= ~0xf0000000UL;
+		return 0;
+	}
+
+	/* Emulate load/store string insn. */
+	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
+		return emulate_string_inst(regs, instword);
+
+	return -EINVAL;
+}
+
+/*
+ * Look through the list of trap instructions that are used for BUG(),
+ * BUG_ON() and WARN_ON() and see if we hit one.  At this point we know
+ * that the exception was caused by a trap instruction of some kind.
+ * Returns 1 if we should continue (i.e. it was a WARN_ON) or 0
+ * otherwise.
+ */
+extern struct bug_entry __start___bug_table[], __stop___bug_table[];
+
+#ifndef CONFIG_MODULES
+#define module_find_bug(x)	NULL
+#endif
+
+struct bug_entry *find_bug(unsigned long bugaddr)
+{
+	struct bug_entry *bug;
+
+	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
+		if (bugaddr == bug->bug_addr)
+			return bug;
+	return module_find_bug(bugaddr);
+}
+
+int check_bug_trap(struct pt_regs *regs)
+{
+	struct bug_entry *bug;
+	unsigned long addr;
+
+	if (regs->msr & MSR_PR)
+		return 0;	/* not in kernel */
+	addr = regs->nip;	/* address of trap instruction */
+	if (addr < PAGE_OFFSET)
+		return 0;
+	bug = find_bug(regs->nip);
+	if (bug == NULL)
+		return 0;
+	if (bug->line & BUG_WARNING_TRAP) {
+		/* this is a WARN_ON rather than BUG/BUG_ON */
+#ifdef CONFIG_XMON
+		xmon_printf(KERN_ERR "Badness in %s at %s:%d\n",
+		       bug->function, bug->file,
+		       bug->line & ~BUG_WARNING_TRAP);
+#endif /* CONFIG_XMON */		
+		printk(KERN_ERR "Badness in %s at %s:%d\n",
+		       bug->function, bug->file,
+		       bug->line & ~BUG_WARNING_TRAP);
+		dump_stack();
+		return 1;
+	}
+#ifdef CONFIG_XMON
+	xmon_printf(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
+	       bug->function, bug->file, bug->line);
+	xmon(regs);
+#endif /* CONFIG_XMON */
+	printk(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
+	       bug->function, bug->file, bug->line);
+
+	return 0;
+}
+
+void ProgramCheckException(struct pt_regs *regs)
+{
+	unsigned int reason = get_reason(regs);
+	extern int do_mathemu(struct pt_regs *regs);
+
+#ifdef CONFIG_MATH_EMULATION
+	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
+	 * but there seems to be a hardware bug on the 405GP (RevD)
+	 * that means ESR is sometimes set incorrectly - either to
+	 * ESR_DST (!?) or 0.  In the process of chasing this with the
+	 * hardware people - not sure if it can happen on any illegal
+	 * instruction or only on FP instructions, whether there is a
+	 * pattern to occurences etc. -dgibson 31/Mar/2003 */
+	if (!(reason & REASON_TRAP) && do_mathemu(regs) == 0) {
+		emulate_single_step(regs);
+		return;
+	}
+#endif /* CONFIG_MATH_EMULATION */
+
+	if (reason & REASON_FP) {
+		/* IEEE FP exception */
+		int code = 0;
+		u32 fpscr;
+
+		/* We must make sure the FP state is consistent with
+		 * our MSR_FP in regs
+		 */
+		preempt_disable();
+		if (regs->msr & MSR_FP)
+			giveup_fpu(current);
+		preempt_enable();
+
+		fpscr = current->thread.fpscr;
+		fpscr &= fpscr << 22;	/* mask summary bits with enables */
+		if (fpscr & FPSCR_VX)
+			code = FPE_FLTINV;
+		else if (fpscr & FPSCR_OX)
+			code = FPE_FLTOVF;
+		else if (fpscr & FPSCR_UX)
+			code = FPE_FLTUND;
+		else if (fpscr & FPSCR_ZX)
+			code = FPE_FLTDIV;
+		else if (fpscr & FPSCR_XX)
+			code = FPE_FLTRES;
+		_exception(SIGFPE, regs, code, regs->nip);
+		return;
+	}
+
+	if (reason & REASON_TRAP) {
+		/* trap exception */
+		if (debugger_bpt(regs))
+			return;
+		if (check_bug_trap(regs)) {
+			regs->nip += 4;
+			return;
+		}
+		_exception(SIGTRAP, regs, TRAP_BRKPT, 0);
+		return;
+	}
+
+	/* Try to emulate it if we should. */
+	if (reason & (REASON_ILLEGAL | REASON_PRIVILEGED)) {
+		switch (emulate_instruction(regs)) {
+		case 0:
+			regs->nip += 4;
+			emulate_single_step(regs);
+			return;
+		case -EFAULT:
+			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+			return;
+		}
+	}
+
+	if (reason & REASON_PRIVILEGED)
+		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
+	else
+		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+}
+
+void AlignmentException(struct pt_regs *regs)
+{
+	int fixed;
+
+	fixed = fix_alignment(regs);
+
+	if (fixed == 1) {
+		regs->nip += 4;	/* skip over emulated instruction */
+		emulate_single_step(regs);
+		return;
+	}
+
+	/* Operand address was bad */	
+	if (fixed == -EFAULT) {
+		if (user_mode(regs))
+			_exception(SIGSEGV, regs, SEGV_ACCERR, regs->dar);
+		else
+			/* Search exception table */
+			bad_page_fault(regs, regs->dar, SIGSEGV);
+		return;
+	}
+	_exception(SIGBUS, regs, BUS_ADRALN, regs->dar);
+}
+
+void StackOverflow(struct pt_regs *regs)
+{
+	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
+	       current, regs->gpr[1]);
+	debugger(regs);
+	show_regs(regs);
+	panic("kernel stack overflow");
+}
+
+void nonrecoverable_exception(struct pt_regs *regs)
+{
+	printk(KERN_ERR "Non-recoverable exception at PC=%lx MSR=%lx\n",
+	       regs->nip, regs->msr);
+	debugger(regs);
+	die("nonrecoverable exception", regs, SIGKILL);
+}
+
+void trace_syscall(struct pt_regs *regs)
+{
+	printk("Task: %p(%d), PC: %08lX/%08lX, Syscall: %3ld, Result: %s%ld    %s\n",
+	       current, current->pid, regs->nip, regs->link, regs->gpr[0],
+	       regs->ccr&0x10000000?"Error=":"", regs->gpr[3], print_tainted());
+}
+
+#ifdef CONFIG_8xx
+void SoftwareEmulation(struct pt_regs *regs)
+{
+	extern int do_mathemu(struct pt_regs *);
+	extern int Soft_emulate_8xx(struct pt_regs *);
+	int errcode;
+
+	CHECK_FULL_REGS(regs);
+
+	if (!user_mode(regs)) {
+		debugger(regs);
+		die("Kernel Mode Software FPU Emulation", regs, SIGFPE);
+	}
+
+#ifdef CONFIG_MATH_EMULATION
+	errcode = do_mathemu(regs);
+#else
+	errcode = Soft_emulate_8xx(regs);
+#endif
+	if (errcode) {
+		if (errcode > 0)
+			_exception(SIGFPE, regs, 0, 0);
+		else if (errcode == -EFAULT)
+			_exception(SIGSEGV, regs, 0, 0);
+		else
+			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+	} else
+		emulate_single_step(regs);
+}
+#endif /* CONFIG_8xx */
+
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+
+void DebugException(struct pt_regs *regs, unsigned long debug_status)
+{
+	if (debug_status & DBSR_IC) {	/* instruction completion */
+		regs->msr &= ~MSR_DE;
+		if (user_mode(regs)) {
+			current->thread.dbcr0 &= ~DBCR0_IC;
+		} else {
+			/* Disable instruction completion */
+			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
+			/* Clear the instruction completion event */
+			mtspr(SPRN_DBSR, DBSR_IC);
+			if (debugger_sstep(regs))
+				return;
+		}
+		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
+	}
+}
+#endif /* CONFIG_4xx || CONFIG_BOOKE */
+
+#if !defined(CONFIG_TAU_INT)
+void TAUException(struct pt_regs *regs)
+{
+	printk("TAU trap at PC: %lx, MSR: %lx, vector=%lx    %s\n",
+	       regs->nip, regs->msr, regs->trap, print_tainted());
+}
+#endif /* CONFIG_INT_TAU */
+
+void AltivecUnavailException(struct pt_regs *regs)
+{
+	static int kernel_altivec_count;
+
+#ifndef CONFIG_ALTIVEC
+	if (user_mode(regs)) {
+		/* A user program has executed an altivec instruction,
+		   but this kernel doesn't support altivec. */
+		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+		return;
+	}
+#endif
+	/* The kernel has executed an altivec instruction without
+	   first enabling altivec.  Whinge but let it do it. */
+	if (++kernel_altivec_count < 10)
+		printk(KERN_ERR "AltiVec used in kernel (task=%p, pc=%lx)\n",
+		       current, regs->nip);
+	regs->msr |= MSR_VEC;
+}
+
+#ifdef CONFIG_ALTIVEC
+void AltivecAssistException(struct pt_regs *regs)
+{
+	int err;
+
+	preempt_disable();
+	if (regs->msr & MSR_VEC)
+		giveup_altivec(current);
+	preempt_enable();
+	if (!user_mode(regs)) {
+		printk(KERN_EMERG "VMX/Altivec assist exception in kernel mode"
+		       " at %lx\n", regs->nip);
+		die("Kernel Altivec assist exception", regs, SIGILL);
+	}
+
+	err = emulate_altivec(regs);
+	if (err == 0) {
+		regs->nip += 4;		/* skip emulated instruction */
+		emulate_single_step(regs);
+		return;
+	}
+
+	if (err == -EFAULT) {
+		/* got an error reading the instruction */
+		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
+	} else {
+		/* didn't recognize the instruction */
+		/* XXX quick hack for now: set the non-Java bit in the VSCR */
+		if (printk_ratelimit())
+			printk(KERN_ERR "Unrecognized altivec instruction "
+			       "in %s at %lx\n", current->comm, regs->nip);
+		current->thread.vscr.u[3] |= 0x10000;
+	}
+}
+#endif /* CONFIG_ALTIVEC */
+
+#ifdef CONFIG_E500
+void PerformanceMonitorException(struct pt_regs *regs)
+{
+	perf_irq(regs);
+}
+#endif
+
+#ifdef CONFIG_FSL_BOOKE
+void CacheLockingException(struct pt_regs *regs, unsigned long address,
+			   unsigned long error_code)
+{
+	/* We treat cache locking instructions from the user
+	 * as priv ops, in the future we could try to do
+	 * something smarter
+	 */
+	if (error_code & (ESR_DLK|ESR_ILK))
+		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
+	return;
+}
+#endif /* CONFIG_FSL_BOOKE */
+
+#ifdef CONFIG_SPE
+void SPEFloatingPointException(struct pt_regs *regs)
+{
+	unsigned long spefscr;
+	int fpexc_mode;
+	int code = 0;
+
+	spefscr = current->thread.spefscr;
+	fpexc_mode = current->thread.fpexc_mode;
+
+	/* Hardware does not neccessarily set sticky
+	 * underflow/overflow/invalid flags */
+	if ((spefscr & SPEFSCR_FOVF) && (fpexc_mode & PR_FP_EXC_OVF)) {
+		code = FPE_FLTOVF;
+		spefscr |= SPEFSCR_FOVFS;
+	}
+	else if ((spefscr & SPEFSCR_FUNF) && (fpexc_mode & PR_FP_EXC_UND)) {
+		code = FPE_FLTUND;
+		spefscr |= SPEFSCR_FUNFS;
+	}
+	else if ((spefscr & SPEFSCR_FDBZ) && (fpexc_mode & PR_FP_EXC_DIV))
+		code = FPE_FLTDIV;
+	else if ((spefscr & SPEFSCR_FINV) && (fpexc_mode & PR_FP_EXC_INV)) {
+		code = FPE_FLTINV;
+		spefscr |= SPEFSCR_FINVS;
+	}
+	else if ((spefscr & (SPEFSCR_FG | SPEFSCR_FX)) && (fpexc_mode & PR_FP_EXC_RES))
+		code = FPE_FLTRES;
+
+	current->thread.spefscr = spefscr;
+
+	_exception(SIGFPE, regs, code, regs->nip);
+	return;
+}
+#endif
+
+#ifdef CONFIG_BOOKE_WDT
+/*
+ * Default handler for a Watchdog exception,
+ * spins until a reboot occurs
+ */
+void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
+{
+	/* Generic WatchdogHandler, implement your own */
+	mtspr(SPRN_TCR, mfspr(SPRN_TCR)&(~TCR_WIE));
+	return;
+}
+
+void WatchdogException(struct pt_regs *regs)
+{
+	printk (KERN_EMERG "PowerPC Book-E Watchdog Exception\n");
+	WatchdogHandler(regs);
+}
+#endif
+
+void __init trap_init(void)
+{
+}
diff --git a/arch/powerpc/kernel/traps64.c b/arch/powerpc/kernel/traps64.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/kernel/traps64.c
@@ -0,0 +1,568 @@
+/*
+ *  linux/arch/ppc64/kernel/traps.c
+ *
+ *  Copyright (C) 1995-1996  Gary Thomas (gdt@linuxppc.org)
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ *  Modified by Cort Dougan (cort@cs.nmt.edu)
+ *  and Paul Mackerras (paulus@cs.anu.edu.au)
+ */
+
+/*
+ * This file handles the architecture-dependent parts of hardware exceptions
+ */
+
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/a.out.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/kprobes.h>
+#include <asm/kdebug.h>
+
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/ppcdebug.h>
+#include <asm/rtas.h>
+#include <asm/systemcfg.h>
+#include <asm/machdep.h>
+#include <asm/pmc.h>
+
+#ifdef CONFIG_DEBUGGER
+int (*__debugger)(struct pt_regs *regs);
+int (*__debugger_ipi)(struct pt_regs *regs);
+int (*__debugger_bpt)(struct pt_regs *regs);
+int (*__debugger_sstep)(struct pt_regs *regs);
+int (*__debugger_iabr_match)(struct pt_regs *regs);
+int (*__debugger_dabr_match)(struct pt_regs *regs);
+int (*__debugger_fault_handler)(struct pt_regs *regs);
+
+EXPORT_SYMBOL(__debugger);
+EXPORT_SYMBOL(__debugger_ipi);
+EXPORT_SYMBOL(__debugger_bpt);
+EXPORT_SYMBOL(__debugger_sstep);
+EXPORT_SYMBOL(__debugger_iabr_match);
+EXPORT_SYMBOL(__debugger_dabr_match);
+EXPORT_SYMBOL(__debugger_fault_handler);
+#endif
+
+struct notifier_block *powerpc_die_chain;
+static DEFINE_SPINLOCK(die_notifier_lock);
+
+int register_die_notifier(struct notifier_block *nb)
+{
+	int err = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&die_notifier_lock, flags);
+	err = notifier_chain_register(&powerpc_die_chain, nb);
+	spin_unlock_irqrestore(&die_notifier_lock, flags);
+	return err;
+}
+
+/*
+ * Trap & Exception support
+ */
+
+static DEFINE_SPINLOCK(die_lock);
+
+int die(const char *str, struct pt_regs *regs, long err)
+{
+	static int die_counter;
+	int nl = 0;
+
+	if (debugger(regs))
+		return 1;
+
+	console_verbose();
+	spin_lock_irq(&die_lock);
+	bust_spinlocks(1);
+	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
+#ifdef CONFIG_PREEMPT
+	printk("PREEMPT ");
+	nl = 1;
+#endif
+#ifdef CONFIG_SMP
+	printk("SMP NR_CPUS=%d ", NR_CPUS);
+	nl = 1;
+#endif
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	printk("DEBUG_PAGEALLOC ");
+	nl = 1;
+#endif
+#ifdef CONFIG_NUMA
+	printk("NUMA ");
+	nl = 1;
+#endif
+	switch(systemcfg->platform) {
+		case PLATFORM_PSERIES:
+			printk("PSERIES ");
+			nl = 1;
+			break;
+		case PLATFORM_PSERIES_LPAR:
+			printk("PSERIES LPAR ");
+			nl = 1;
+			break;
+		case PLATFORM_ISERIES_LPAR:
+			printk("ISERIES LPAR ");
+			nl = 1;
+			break;
+		case PLATFORM_POWERMAC:
+			printk("POWERMAC ");
+			nl = 1;
+			break;
+		case PLATFORM_BPA:
+			printk("BPA ");
+			nl = 1;
+			break;
+	}
+	if (nl)
+		printk("\n");
+	print_modules();
+	show_regs(regs);
+	bust_spinlocks(0);
+	spin_unlock_irq(&die_lock);
+
+	if (in_interrupt())
+		panic("Fatal exception in interrupt");
+
+	if (panic_on_oops) {
+		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
+		ssleep(5);
+		panic("Fatal exception");
+	}
+	do_exit(SIGSEGV);
+
+	return 0;
+}
+
+void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
+{
+	siginfo_t info;
+
+	if (!user_mode(regs)) {
+		if (die("Exception in kernel mode", regs, signr))
+			return;
+	}
+
+	memset(&info, 0, sizeof(info));
+	info.si_signo = signr;
+	info.si_code = code;
+	info.si_addr = (void __user *) addr;
+	force_sig_info(signr, &info, current);
+}
+
+void system_reset_exception(struct pt_regs *regs)
+{
+	/* See if any machine dependent calls */
+	if (ppc_md.system_reset_exception)
+		ppc_md.system_reset_exception(regs);
+
+	die("System Reset", regs, 0);
+
+	/* Must die if the interrupt is not recoverable */
+	if (!(regs->msr & MSR_RI))
+		panic("Unrecoverable System Reset");
+
+	/* What should we do here? We could issue a shutdown or hard reset. */
+}
+
+void machine_check_exception(struct pt_regs *regs)
+{
+	int recover = 0;
+
+	/* See if any machine dependent calls */
+	if (ppc_md.machine_check_exception)
+		recover = ppc_md.machine_check_exception(regs);
+
+	if (recover)
+		return;
+
+	if (debugger_fault_handler(regs))
+		return;
+	die("Machine check", regs, 0);
+
+	/* Must die if the interrupt is not recoverable */
+	if (!(regs->msr & MSR_RI))
+		panic("Unrecoverable Machine check");
+}
+
+void unknown_exception(struct pt_regs *regs)
+{
+	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
+	       regs->nip, regs->msr, regs->trap);
+
+	_exception(SIGTRAP, regs, 0, 0);
+}
+
+void instruction_breakpoint_exception(struct pt_regs *regs)
+{
+	if (notify_die(DIE_IABR_MATCH, "iabr_match", regs, 5,
+					5, SIGTRAP) == NOTIFY_STOP)
+		return;
+	if (debugger_iabr_match(regs))
+		return;
+	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
+}
+
+void __kprobes single_step_exception(struct pt_regs *regs)
+{
+	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
+
+	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
+					5, SIGTRAP) == NOTIFY_STOP)
+		return;
+	if (debugger_sstep(regs))
+		return;
+
+	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
+}
+
+/*
+ * After we have successfully emulated an instruction, we have to
+ * check if the instruction was being single-stepped, and if so,
+ * pretend we got a single-step exception.  This was pointed out
+ * by Kumar Gala.  -- paulus
+ */
+static inline void emulate_single_step(struct pt_regs *regs)
+{
+	if (regs->msr & MSR_SE)
+		single_step_exception(regs);
+}
+
+static void parse_fpe(struct pt_regs *regs)
+{
+	int code = 0;
+	unsigned long fpscr;
+
+	flush_fp_to_thread(current);
+
+	fpscr = current->thread.fpscr;
+
+	/* Invalid operation */
+	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
+		code = FPE_FLTINV;
+
+	/* Overflow */
+	else if ((fpscr & FPSCR_OE) && (fpscr & FPSCR_OX))
+		code = FPE_FLTOVF;
+
+	/* Underflow */
+	else if ((fpscr & FPSCR_UE) && (fpscr & FPSCR_UX))
+		code = FPE_FLTUND;
+
+	/* Divide by zero */
+	else if ((fpscr & FPSCR_ZE) && (fpscr & FPSCR_ZX))
+		code = FPE_FLTDIV;
+
+	/* Inexact result */
+	else if ((fpscr & FPSCR_XE) && (fpscr & FPSCR_XX))
+		code = FPE_FLTRES;
+
+	_exception(SIGFPE, regs, code, regs->nip);
+}
+
+/*
+ * Illegal instruction emulation support.  Return non-zero if we can't
+ * emulate, or -EFAULT if the associated memory access caused an access
+ * fault.  Return zero on success.
+ */
+
+#define INST_MFSPR_PVR		0x7c1f42a6
+#define INST_MFSPR_PVR_MASK	0xfc1fffff
+
+#define INST_DCBA		0x7c0005ec
+#define INST_DCBA_MASK		0x7c0007fe
+
+#define INST_MCRXR		0x7c000400
+#define INST_MCRXR_MASK		0x7c0007fe
+
+static int emulate_instruction(struct pt_regs *regs)
+{
+	unsigned int instword;
+
+	if (!user_mode(regs))
+		return -EINVAL;
+
+	CHECK_FULL_REGS(regs);
+
+	if (get_user(instword, (unsigned int __user *)(regs->nip)))
+		return -EFAULT;
+
+	/* Emulate the mfspr rD, PVR. */
+	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
+		unsigned int rd;
+
+		rd = (instword >> 21) & 0x1f;
+		regs->gpr[rd] = mfspr(SPRN_PVR);
+		return 0;
+	}
+
+	/* Emulating the dcba insn is just a no-op.  */
+	if ((instword & INST_DCBA_MASK) == INST_DCBA) {
+		static int warned;
+
+		if (!warned) {
+			printk(KERN_WARNING
+			       "process %d (%s) uses obsolete 'dcba' insn\n",
+			       current->pid, current->comm);
+			warned = 1;
+		}
+		return 0;
+	}
+
+	/* Emulate the mcrxr insn.  */
+	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
+		static int warned;
+		unsigned int shift;
+
+		if (!warned) {
+			printk(KERN_WARNING
+			       "process %d (%s) uses obsolete 'mcrxr' insn\n",
+			       current->pid, current->comm);
+			warned = 1;
+		}
+
+		shift = (instword >> 21) & 0x1c;
+		regs->ccr &= ~(0xf0000000 >> shift);
+		regs->ccr |= (regs->xer & 0xf0000000) >> shift;
+		regs->xer &= ~0xf0000000;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * Look through the list of trap instructions that are used for BUG(),
+ * BUG_ON() and WARN_ON() and see if we hit one.  At this point we know
+ * that the exception was caused by a trap instruction of some kind.
+ * Returns 1 if we should continue (i.e. it was a WARN_ON) or 0
+ * otherwise.
+ */
+extern struct bug_entry __start___bug_table[], __stop___bug_table[];
+
+#ifndef CONFIG_MODULES
+#define module_find_bug(x)	NULL
+#endif
+
+struct bug_entry *find_bug(unsigned long bugaddr)
+{
+	struct bug_entry *bug;
+
+	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
+		if (bugaddr == bug->bug_addr)
+			return bug;
+	return module_find_bug(bugaddr);
+}
+
+static int
+check_bug_trap(struct pt_regs *regs)
+{
+	struct bug_entry *bug;
+	unsigned long addr;
+
+	if (regs->msr & MSR_PR)
+		return 0;	/* not in kernel */
+	addr = regs->nip;	/* address of trap instruction */
+	if (addr < PAGE_OFFSET)
+		return 0;
+	bug = find_bug(regs->nip);
+	if (bug == NULL)
+		return 0;
+	if (bug->line & BUG_WARNING_TRAP) {
+		/* this is a WARN_ON rather than BUG/BUG_ON */
+		printk(KERN_ERR "Badness in %s at %s:%d\n",
+		       bug->function, bug->file,
+		       bug->line & ~BUG_WARNING_TRAP);
+		show_stack(current, (void *)regs->gpr[1]);
+		return 1;
+	}
+	printk(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
+	       bug->function, bug->file, bug->line);
+	return 0;
+}
+
+void __kprobes program_check_exception(struct pt_regs *regs)
+{
+	if (debugger_fault_handler(regs))
+		return;
+
+	if (regs->msr & 0x100000) {
+		/* IEEE FP exception */
+		parse_fpe(regs);
+	} else if (regs->msr & 0x20000) {
+		/* trap exception */
+
+		if (notify_die(DIE_BPT, "breakpoint", regs, 5,
+					5, SIGTRAP) == NOTIFY_STOP)
+			return;
+		if (debugger_bpt(regs))
+			return;
+
+		if (check_bug_trap(regs)) {
+			regs->nip += 4;
+			return;
+		}
+		_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
+
+	} else {
+		/* Privileged or illegal instruction; try to emulate it. */
+		switch (emulate_instruction(regs)) {
+		case 0:
+			regs->nip += 4;
+			emulate_single_step(regs);
+			break;
+
+		case -EFAULT:
+			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+			break;
+
+		default:
+			if (regs->msr & 0x40000)
+				/* priveleged */
+				_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
+			else
+				/* illegal */
+				_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+			break;
+		}
+	}
+}
+
+void kernel_fp_unavailable_exception(struct pt_regs *regs)
+{
+	printk(KERN_EMERG "Unrecoverable FP Unavailable Exception "
+			  "%lx at %lx\n", regs->trap, regs->nip);
+	die("Unrecoverable FP Unavailable Exception", regs, SIGABRT);
+}
+
+void altivec_unavailable_exception(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		/* A user program has executed an altivec instruction,
+		   but this kernel doesn't support altivec. */
+		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+		return;
+	}
+	printk(KERN_EMERG "Unrecoverable VMX/Altivec Unavailable Exception "
+			  "%lx at %lx\n", regs->trap, regs->nip);
+	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
+}
+
+extern perf_irq_t perf_irq;
+
+void performance_monitor_exception(struct pt_regs *regs)
+{
+	perf_irq(regs);
+}
+
+void alignment_exception(struct pt_regs *regs)
+{
+	int fixed;
+
+	fixed = fix_alignment(regs);
+
+	if (fixed == 1) {
+		regs->nip += 4;	/* skip over emulated instruction */
+		emulate_single_step(regs);
+		return;
+	}
+
+	/* Operand address was bad */	
+	if (fixed == -EFAULT) {
+		if (user_mode(regs)) {
+			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->dar);
+		} else {
+			/* Search exception table */
+			bad_page_fault(regs, regs->dar, SIGSEGV);
+		}
+
+		return;
+	}
+
+	_exception(SIGBUS, regs, BUS_ADRALN, regs->nip);
+}
+
+#ifdef CONFIG_ALTIVEC
+void altivec_assist_exception(struct pt_regs *regs)
+{
+	int err;
+	siginfo_t info;
+
+	if (!user_mode(regs)) {
+		printk(KERN_EMERG "VMX/Altivec assist exception in kernel mode"
+		       " at %lx\n", regs->nip);
+		die("Kernel VMX/Altivec assist exception", regs, SIGILL);
+	}
+
+	flush_altivec_to_thread(current);
+
+	err = emulate_altivec(regs);
+	if (err == 0) {
+		regs->nip += 4;		/* skip emulated instruction */
+		emulate_single_step(regs);
+		return;
+	}
+
+	if (err == -EFAULT) {
+		/* got an error reading the instruction */
+		info.si_signo = SIGSEGV;
+		info.si_errno = 0;
+		info.si_code = SEGV_MAPERR;
+		info.si_addr = (void __user *) regs->nip;
+		force_sig_info(SIGSEGV, &info, current);
+	} else {
+		/* didn't recognize the instruction */
+		/* XXX quick hack for now: set the non-Java bit in the VSCR */
+		if (printk_ratelimit())
+			printk(KERN_ERR "Unrecognized altivec instruction "
+			       "in %s at %lx\n", current->comm, regs->nip);
+		current->thread.vscr.u[3] |= 0x10000;
+	}
+}
+#endif /* CONFIG_ALTIVEC */
+
+/*
+ * We enter here if we get an unrecoverable exception, that is, one
+ * that happened at a point where the RI (recoverable interrupt) bit
+ * in the MSR is 0.  This indicates that SRR0/1 are live, and that
+ * we therefore lost state by taking this exception.
+ */
+void unrecoverable_exception(struct pt_regs *regs)
+{
+	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
+	       regs->trap, regs->nip);
+	die("Unrecoverable exception", regs, SIGABRT);
+}
+
+/*
+ * We enter here if we discover during exception entry that we are
+ * running in supervisor mode with a userspace value in the stack pointer.
+ */
+void kernel_bad_stack(struct pt_regs *regs)
+{
+	printk(KERN_EMERG "Bad kernel stack pointer %lx at %lx\n",
+	       regs->gpr[1], regs->nip);
+	die("Bad kernel stack pointer", regs, SIGABRT);
+}
+
+void __init trap_init(void)
+{
+}
diff --git a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile
+++ b/arch/ppc64/kernel/Makefile
@@ -2,10 +2,12 @@
 # Makefile for the linux ppc64 kernel.
 #
 
+ifneq ($(CONFIG_PPC_MERGE),y)
+
 EXTRA_CFLAGS	+= -mno-minimal-toc
 extra-y		:= head.o vmlinux.lds
 
-obj-y               :=	setup.o entry.o traps.o irq.o idle.o dma.o \
+obj-y               :=	setup.o entry.o traps64.o irq.o idle.o dma.o \
 			time.o process.o signal.o syscalls.o misc.o ptrace.o \
 			align.o semaphore.o bitops.o pacaData.o \
 			udbg.o binfmt_elf32.o sys_ppc32.o ioctl32.o \
@@ -77,3 +79,9 @@ endif
 # These are here while we do the architecture merge
 vecemu-y			+= ../../powerpc/kernel/vecemu.o
 vector-y			+= ../../powerpc/kernel/vector.o
+idle_power4-y			+= ../../powerpc/kernel/idle_power4.o
+traps64-y			+= ../../powerpc/kernel/traps64.o
+
+else
+
+endif
diff --git a/arch/ppc64/kernel/idle_power4.S b/arch/ppc64/kernel/idle_power4.S
deleted file mode 100644
--- a/arch/ppc64/kernel/idle_power4.S
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- *  This file contains the power_save function for 6xx & 7xxx CPUs
- *  rewritten in assembler
- *
- *  Warning ! This code assumes that if your machine has a 750fx
- *  it will have PLL 1 set to low speed mode (used during NAP/DOZE).
- *  if this is not the case some additional changes will have to
- *  be done to check a runtime var (a bit like powersave-nap)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#include <linux/config.h>
-#include <linux/threads.h>
-#include <asm/processor.h>
-#include <asm/page.h>
-#include <asm/cputable.h>
-#include <asm/thread_info.h>
-#include <asm/ppc_asm.h>
-#include <asm/asm-offsets.h>
-
-#undef DEBUG
-
-	.text
-
-/*
- * Here is the power_save_6xx function. This could eventually be
- * split into several functions & changing the function pointer
- * depending on the various features.
- */
-_GLOBAL(power4_idle)
-BEGIN_FTR_SECTION
-	blr
-END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
-	/* We must dynamically check for the NAP feature as it
-	 * can be cleared by CPU init after the fixups are done
-	 */
-	LOADBASE(r3,cur_cpu_spec)
-	ld	r4,cur_cpu_spec@l(r3)
-	ld	r4,CPU_SPEC_FEATURES(r4)
-	andi.	r0,r4,CPU_FTR_CAN_NAP
-	beqlr
-	/* Now check if user or arch enabled NAP mode */
-	LOADBASE(r3,powersave_nap)
-	lwz	r4,powersave_nap@l(r3)
-	cmpwi	0,r4,0
-	beqlr
-
-	/* Clear MSR:EE */
-	mfmsr	r7
-	li	r4,0
-	ori	r4,r4,MSR_EE
-	andc	r0,r7,r4
-	mtmsrd	r0
-
-	/* Check current_thread_info()->flags */
-	clrrdi	r4,r1,THREAD_SHIFT
-	ld	r4,TI_FLAGS(r4)
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq	1f
-	mtmsrd	r7	/* out of line this ? */
-	blr
-1:	
-	/* Go to NAP now */	
-BEGIN_FTR_SECTION
-	DSSALL
-	sync
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	oris	r7,r7,MSR_POW@h
-	sync
-	isync
-	mtmsrd	r7
-	isync
-	sync
-	blr
-	
diff --git a/arch/ppc64/kernel/traps.c b/arch/ppc64/kernel/traps.c
deleted file mode 100644
--- a/arch/ppc64/kernel/traps.c
+++ /dev/null
@@ -1,568 +0,0 @@
-/*
- *  linux/arch/ppc64/kernel/traps.c
- *
- *  Copyright (C) 1995-1996  Gary Thomas (gdt@linuxppc.org)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- *
- *  Modified by Cort Dougan (cort@cs.nmt.edu)
- *  and Paul Mackerras (paulus@cs.anu.edu.au)
- */
-
-/*
- * This file handles the architecture-dependent parts of hardware exceptions
- */
-
-#include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/user.h>
-#include <linux/a.out.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/kprobes.h>
-#include <asm/kdebug.h>
-
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/processor.h>
-#include <asm/ppcdebug.h>
-#include <asm/rtas.h>
-#include <asm/systemcfg.h>
-#include <asm/machdep.h>
-#include <asm/pmc.h>
-
-#ifdef CONFIG_DEBUGGER
-int (*__debugger)(struct pt_regs *regs);
-int (*__debugger_ipi)(struct pt_regs *regs);
-int (*__debugger_bpt)(struct pt_regs *regs);
-int (*__debugger_sstep)(struct pt_regs *regs);
-int (*__debugger_iabr_match)(struct pt_regs *regs);
-int (*__debugger_dabr_match)(struct pt_regs *regs);
-int (*__debugger_fault_handler)(struct pt_regs *regs);
-
-EXPORT_SYMBOL(__debugger);
-EXPORT_SYMBOL(__debugger_ipi);
-EXPORT_SYMBOL(__debugger_bpt);
-EXPORT_SYMBOL(__debugger_sstep);
-EXPORT_SYMBOL(__debugger_iabr_match);
-EXPORT_SYMBOL(__debugger_dabr_match);
-EXPORT_SYMBOL(__debugger_fault_handler);
-#endif
-
-struct notifier_block *powerpc_die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
-
-int register_die_notifier(struct notifier_block *nb)
-{
-	int err = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&die_notifier_lock, flags);
-	err = notifier_chain_register(&powerpc_die_chain, nb);
-	spin_unlock_irqrestore(&die_notifier_lock, flags);
-	return err;
-}
-
-/*
- * Trap & Exception support
- */
-
-static DEFINE_SPINLOCK(die_lock);
-
-int die(const char *str, struct pt_regs *regs, long err)
-{
-	static int die_counter;
-	int nl = 0;
-
-	if (debugger(regs))
-		return 1;
-
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	bust_spinlocks(1);
-	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
-#ifdef CONFIG_PREEMPT
-	printk("PREEMPT ");
-	nl = 1;
-#endif
-#ifdef CONFIG_SMP
-	printk("SMP NR_CPUS=%d ", NR_CPUS);
-	nl = 1;
-#endif
-#ifdef CONFIG_DEBUG_PAGEALLOC
-	printk("DEBUG_PAGEALLOC ");
-	nl = 1;
-#endif
-#ifdef CONFIG_NUMA
-	printk("NUMA ");
-	nl = 1;
-#endif
-	switch(systemcfg->platform) {
-		case PLATFORM_PSERIES:
-			printk("PSERIES ");
-			nl = 1;
-			break;
-		case PLATFORM_PSERIES_LPAR:
-			printk("PSERIES LPAR ");
-			nl = 1;
-			break;
-		case PLATFORM_ISERIES_LPAR:
-			printk("ISERIES LPAR ");
-			nl = 1;
-			break;
-		case PLATFORM_POWERMAC:
-			printk("POWERMAC ");
-			nl = 1;
-			break;
-		case PLATFORM_BPA:
-			printk("BPA ");
-			nl = 1;
-			break;
-	}
-	if (nl)
-		printk("\n");
-	print_modules();
-	show_regs(regs);
-	bust_spinlocks(0);
-	spin_unlock_irq(&die_lock);
-
-	if (in_interrupt())
-		panic("Fatal exception in interrupt");
-
-	if (panic_on_oops) {
-		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-		ssleep(5);
-		panic("Fatal exception");
-	}
-	do_exit(SIGSEGV);
-
-	return 0;
-}
-
-void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
-{
-	siginfo_t info;
-
-	if (!user_mode(regs)) {
-		if (die("Exception in kernel mode", regs, signr))
-			return;
-	}
-
-	memset(&info, 0, sizeof(info));
-	info.si_signo = signr;
-	info.si_code = code;
-	info.si_addr = (void __user *) addr;
-	force_sig_info(signr, &info, current);
-}
-
-void system_reset_exception(struct pt_regs *regs)
-{
-	/* See if any machine dependent calls */
-	if (ppc_md.system_reset_exception)
-		ppc_md.system_reset_exception(regs);
-
-	die("System Reset", regs, 0);
-
-	/* Must die if the interrupt is not recoverable */
-	if (!(regs->msr & MSR_RI))
-		panic("Unrecoverable System Reset");
-
-	/* What should we do here? We could issue a shutdown or hard reset. */
-}
-
-void machine_check_exception(struct pt_regs *regs)
-{
-	int recover = 0;
-
-	/* See if any machine dependent calls */
-	if (ppc_md.machine_check_exception)
-		recover = ppc_md.machine_check_exception(regs);
-
-	if (recover)
-		return;
-
-	if (debugger_fault_handler(regs))
-		return;
-	die("Machine check", regs, 0);
-
-	/* Must die if the interrupt is not recoverable */
-	if (!(regs->msr & MSR_RI))
-		panic("Unrecoverable Machine check");
-}
-
-void unknown_exception(struct pt_regs *regs)
-{
-	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
-	       regs->nip, regs->msr, regs->trap);
-
-	_exception(SIGTRAP, regs, 0, 0);
-}
-
-void instruction_breakpoint_exception(struct pt_regs *regs)
-{
-	if (notify_die(DIE_IABR_MATCH, "iabr_match", regs, 5,
-					5, SIGTRAP) == NOTIFY_STOP)
-		return;
-	if (debugger_iabr_match(regs))
-		return;
-	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
-}
-
-void __kprobes single_step_exception(struct pt_regs *regs)
-{
-	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
-
-	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
-					5, SIGTRAP) == NOTIFY_STOP)
-		return;
-	if (debugger_sstep(regs))
-		return;
-
-	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
-}
-
-/*
- * After we have successfully emulated an instruction, we have to
- * check if the instruction was being single-stepped, and if so,
- * pretend we got a single-step exception.  This was pointed out
- * by Kumar Gala.  -- paulus
- */
-static inline void emulate_single_step(struct pt_regs *regs)
-{
-	if (regs->msr & MSR_SE)
-		single_step_exception(regs);
-}
-
-static void parse_fpe(struct pt_regs *regs)
-{
-	int code = 0;
-	unsigned long fpscr;
-
-	flush_fp_to_thread(current);
-
-	fpscr = current->thread.fpscr;
-
-	/* Invalid operation */
-	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
-		code = FPE_FLTINV;
-
-	/* Overflow */
-	else if ((fpscr & FPSCR_OE) && (fpscr & FPSCR_OX))
-		code = FPE_FLTOVF;
-
-	/* Underflow */
-	else if ((fpscr & FPSCR_UE) && (fpscr & FPSCR_UX))
-		code = FPE_FLTUND;
-
-	/* Divide by zero */
-	else if ((fpscr & FPSCR_ZE) && (fpscr & FPSCR_ZX))
-		code = FPE_FLTDIV;
-
-	/* Inexact result */
-	else if ((fpscr & FPSCR_XE) && (fpscr & FPSCR_XX))
-		code = FPE_FLTRES;
-
-	_exception(SIGFPE, regs, code, regs->nip);
-}
-
-/*
- * Illegal instruction emulation support.  Return non-zero if we can't
- * emulate, or -EFAULT if the associated memory access caused an access
- * fault.  Return zero on success.
- */
-
-#define INST_MFSPR_PVR		0x7c1f42a6
-#define INST_MFSPR_PVR_MASK	0xfc1fffff
-
-#define INST_DCBA		0x7c0005ec
-#define INST_DCBA_MASK		0x7c0007fe
-
-#define INST_MCRXR		0x7c000400
-#define INST_MCRXR_MASK		0x7c0007fe
-
-static int emulate_instruction(struct pt_regs *regs)
-{
-	unsigned int instword;
-
-	if (!user_mode(regs))
-		return -EINVAL;
-
-	CHECK_FULL_REGS(regs);
-
-	if (get_user(instword, (unsigned int __user *)(regs->nip)))
-		return -EFAULT;
-
-	/* Emulate the mfspr rD, PVR. */
-	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
-		unsigned int rd;
-
-		rd = (instword >> 21) & 0x1f;
-		regs->gpr[rd] = mfspr(SPRN_PVR);
-		return 0;
-	}
-
-	/* Emulating the dcba insn is just a no-op.  */
-	if ((instword & INST_DCBA_MASK) == INST_DCBA) {
-		static int warned;
-
-		if (!warned) {
-			printk(KERN_WARNING
-			       "process %d (%s) uses obsolete 'dcba' insn\n",
-			       current->pid, current->comm);
-			warned = 1;
-		}
-		return 0;
-	}
-
-	/* Emulate the mcrxr insn.  */
-	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
-		static int warned;
-		unsigned int shift;
-
-		if (!warned) {
-			printk(KERN_WARNING
-			       "process %d (%s) uses obsolete 'mcrxr' insn\n",
-			       current->pid, current->comm);
-			warned = 1;
-		}
-
-		shift = (instword >> 21) & 0x1c;
-		regs->ccr &= ~(0xf0000000 >> shift);
-		regs->ccr |= (regs->xer & 0xf0000000) >> shift;
-		regs->xer &= ~0xf0000000;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-/*
- * Look through the list of trap instructions that are used for BUG(),
- * BUG_ON() and WARN_ON() and see if we hit one.  At this point we know
- * that the exception was caused by a trap instruction of some kind.
- * Returns 1 if we should continue (i.e. it was a WARN_ON) or 0
- * otherwise.
- */
-extern struct bug_entry __start___bug_table[], __stop___bug_table[];
-
-#ifndef CONFIG_MODULES
-#define module_find_bug(x)	NULL
-#endif
-
-struct bug_entry *find_bug(unsigned long bugaddr)
-{
-	struct bug_entry *bug;
-
-	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
-		if (bugaddr == bug->bug_addr)
-			return bug;
-	return module_find_bug(bugaddr);
-}
-
-static int
-check_bug_trap(struct pt_regs *regs)
-{
-	struct bug_entry *bug;
-	unsigned long addr;
-
-	if (regs->msr & MSR_PR)
-		return 0;	/* not in kernel */
-	addr = regs->nip;	/* address of trap instruction */
-	if (addr < PAGE_OFFSET)
-		return 0;
-	bug = find_bug(regs->nip);
-	if (bug == NULL)
-		return 0;
-	if (bug->line & BUG_WARNING_TRAP) {
-		/* this is a WARN_ON rather than BUG/BUG_ON */
-		printk(KERN_ERR "Badness in %s at %s:%d\n",
-		       bug->function, bug->file,
-		       bug->line & ~BUG_WARNING_TRAP);
-		show_stack(current, (void *)regs->gpr[1]);
-		return 1;
-	}
-	printk(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
-	       bug->function, bug->file, bug->line);
-	return 0;
-}
-
-void __kprobes program_check_exception(struct pt_regs *regs)
-{
-	if (debugger_fault_handler(regs))
-		return;
-
-	if (regs->msr & 0x100000) {
-		/* IEEE FP exception */
-		parse_fpe(regs);
-	} else if (regs->msr & 0x20000) {
-		/* trap exception */
-
-		if (notify_die(DIE_BPT, "breakpoint", regs, 5,
-					5, SIGTRAP) == NOTIFY_STOP)
-			return;
-		if (debugger_bpt(regs))
-			return;
-
-		if (check_bug_trap(regs)) {
-			regs->nip += 4;
-			return;
-		}
-		_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
-
-	} else {
-		/* Privileged or illegal instruction; try to emulate it. */
-		switch (emulate_instruction(regs)) {
-		case 0:
-			regs->nip += 4;
-			emulate_single_step(regs);
-			break;
-
-		case -EFAULT:
-			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
-			break;
-
-		default:
-			if (regs->msr & 0x40000)
-				/* priveleged */
-				_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
-			else
-				/* illegal */
-				_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-			break;
-		}
-	}
-}
-
-void kernel_fp_unavailable_exception(struct pt_regs *regs)
-{
-	printk(KERN_EMERG "Unrecoverable FP Unavailable Exception "
-			  "%lx at %lx\n", regs->trap, regs->nip);
-	die("Unrecoverable FP Unavailable Exception", regs, SIGABRT);
-}
-
-void altivec_unavailable_exception(struct pt_regs *regs)
-{
-	if (user_mode(regs)) {
-		/* A user program has executed an altivec instruction,
-		   but this kernel doesn't support altivec. */
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-		return;
-	}
-	printk(KERN_EMERG "Unrecoverable VMX/Altivec Unavailable Exception "
-			  "%lx at %lx\n", regs->trap, regs->nip);
-	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
-}
-
-extern perf_irq_t perf_irq;
-
-void performance_monitor_exception(struct pt_regs *regs)
-{
-	perf_irq(regs);
-}
-
-void alignment_exception(struct pt_regs *regs)
-{
-	int fixed;
-
-	fixed = fix_alignment(regs);
-
-	if (fixed == 1) {
-		regs->nip += 4;	/* skip over emulated instruction */
-		emulate_single_step(regs);
-		return;
-	}
-
-	/* Operand address was bad */	
-	if (fixed == -EFAULT) {
-		if (user_mode(regs)) {
-			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->dar);
-		} else {
-			/* Search exception table */
-			bad_page_fault(regs, regs->dar, SIGSEGV);
-		}
-
-		return;
-	}
-
-	_exception(SIGBUS, regs, BUS_ADRALN, regs->nip);
-}
-
-#ifdef CONFIG_ALTIVEC
-void altivec_assist_exception(struct pt_regs *regs)
-{
-	int err;
-	siginfo_t info;
-
-	if (!user_mode(regs)) {
-		printk(KERN_EMERG "VMX/Altivec assist exception in kernel mode"
-		       " at %lx\n", regs->nip);
-		die("Kernel VMX/Altivec assist exception", regs, SIGILL);
-	}
-
-	flush_altivec_to_thread(current);
-
-	err = emulate_altivec(regs);
-	if (err == 0) {
-		regs->nip += 4;		/* skip emulated instruction */
-		emulate_single_step(regs);
-		return;
-	}
-
-	if (err == -EFAULT) {
-		/* got an error reading the instruction */
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		info.si_code = SEGV_MAPERR;
-		info.si_addr = (void __user *) regs->nip;
-		force_sig_info(SIGSEGV, &info, current);
-	} else {
-		/* didn't recognize the instruction */
-		/* XXX quick hack for now: set the non-Java bit in the VSCR */
-		if (printk_ratelimit())
-			printk(KERN_ERR "Unrecognized altivec instruction "
-			       "in %s at %lx\n", current->comm, regs->nip);
-		current->thread.vscr.u[3] |= 0x10000;
-	}
-}
-#endif /* CONFIG_ALTIVEC */
-
-/*
- * We enter here if we get an unrecoverable exception, that is, one
- * that happened at a point where the RI (recoverable interrupt) bit
- * in the MSR is 0.  This indicates that SRR0/1 are live, and that
- * we therefore lost state by taking this exception.
- */
-void unrecoverable_exception(struct pt_regs *regs)
-{
-	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
-	       regs->trap, regs->nip);
-	die("Unrecoverable exception", regs, SIGABRT);
-}
-
-/*
- * We enter here if we discover during exception entry that we are
- * running in supervisor mode with a userspace value in the stack pointer.
- */
-void kernel_bad_stack(struct pt_regs *regs)
-{
-	printk(KERN_EMERG "Bad kernel stack pointer %lx at %lx\n",
-	       regs->gpr[1], regs->nip);
-	die("Bad kernel stack pointer", regs, SIGABRT);
-}
-
-void __init trap_init(void)
-{
-}
