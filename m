Return-Path: <anton@samba.org>
Message-Id: <20111130102415.123383629@samba.org>
Date: Wed, 30 Nov 2011 21:23:13 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 hbabu@us.ibm.com
Subject: [PATCH 5/9] powerpc: Rework die()
References: <20111130102308.348262468@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Our die() code was based off a very old x86 version. Update it to
mirror the current x86 code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/traps.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/traps.c	2011-11-14 08:31:02.111805931 +1100
+++ linux-build/arch/powerpc/kernel/traps.c	2011-11-14 08:32:21.185192875 +1100
@@ -98,18 +98,14 @@ static void pmac_backlight_unblank(void)
 static inline void pmac_backlight_unblank(void) { }
 #endif
 
-int die(const char *str, struct pt_regs *regs, long err)
+static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+static int die_owner = -1;
+static unsigned int die_nest_count;
+static int die_counter;
+
+static unsigned __kprobes long oops_begin(struct pt_regs *regs)
 {
-	static struct {
-		raw_spinlock_t lock;
-		u32 lock_owner;
-		int lock_owner_depth;
-	} die = {
-		.lock =			__RAW_SPIN_LOCK_UNLOCKED(die.lock),
-		.lock_owner =		-1,
-		.lock_owner_depth =	0
-	};
-	static int die_counter;
+	int cpu;
 	unsigned long flags;
 
 	if (debugger(regs))
@@ -117,50 +113,37 @@ int die(const char *str, struct pt_regs
 
 	oops_enter();
 
-	if (die.lock_owner != raw_smp_processor_id()) {
-		console_verbose();
-		raw_spin_lock_irqsave(&die.lock, flags);
-		die.lock_owner = smp_processor_id();
-		die.lock_owner_depth = 0;
-		bust_spinlocks(1);
-		if (machine_is(powermac))
-			pmac_backlight_unblank();
-	} else {
-		local_save_flags(flags);
-	}
-
-	if (++die.lock_owner_depth < 3) {
-		printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
-#ifdef CONFIG_PREEMPT
-		printk("PREEMPT ");
-#endif
-#ifdef CONFIG_SMP
-		printk("SMP NR_CPUS=%d ", NR_CPUS);
-#endif
-#ifdef CONFIG_DEBUG_PAGEALLOC
-		printk("DEBUG_PAGEALLOC ");
-#endif
-#ifdef CONFIG_NUMA
-		printk("NUMA ");
-#endif
-		printk("%s\n", ppc_md.name ? ppc_md.name : "");
-
-		if (notify_die(DIE_OOPS, str, regs, err, 255,
-			       SIGSEGV) == NOTIFY_STOP)
-			return 1;
-
-		print_modules();
-		show_regs(regs);
-	} else {
-		printk("Recursive die() failure, output suppressed\n");
+	/* racy, but better than risking deadlock. */
+	raw_local_irq_save(flags);
+	cpu = smp_processor_id();
+	if (!arch_spin_trylock(&die_lock)) {
+		if (cpu == die_owner)
+			/* nested oops. should stop eventually */;
+		else
+			arch_spin_lock(&die_lock);
 	}
+	die_nest_count++;
+	die_owner = cpu;
+	console_verbose();
+	bust_spinlocks(1);
+	if (machine_is(powermac))
+		pmac_backlight_unblank();
+	return flags;
+}
 
+static void __kprobes oops_end(unsigned long flags, struct pt_regs *regs,
+			       int signr)
+{
 	bust_spinlocks(0);
-	die.lock_owner = -1;
+	die_owner = -1;
 	add_taint(TAINT_DIE);
+	die_nest_count--;
 	oops_exit();
 	printk("\n");
-	raw_spin_unlock_irqrestore(&die.lock, flags);
+	if (!die_nest_count)
+		/* Nest count reaches zero, release the lock. */
+		arch_spin_unlock(&die_lock);
+	raw_local_irq_restore(flags);
 
 	/*
 	 * A system reset (0x100) is a request to dump, so we always send
@@ -177,6 +160,9 @@ int die(const char *str, struct pt_regs
 		crash_kexec_secondary(regs);
 	}
 
+	if (!signr)
+		return;
+
 	/*
 	 * While our oops output is serialised by a spinlock, output
 	 * from panic() called below can race and corrupt it. If we
@@ -190,15 +176,46 @@ int die(const char *str, struct pt_regs
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
-
 	if (panic_on_oops)
 		panic("Fatal exception");
+	do_exit(signr);
+}
 
-	do_exit(err);
+static int __kprobes __die(const char *str, struct pt_regs *regs, long err)
+{
+	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
+#ifdef CONFIG_PREEMPT
+	printk("PREEMPT ");
+#endif
+#ifdef CONFIG_SMP
+	printk("SMP NR_CPUS=%d ", NR_CPUS);
+#endif
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	printk("DEBUG_PAGEALLOC ");
+#endif
+#ifdef CONFIG_NUMA
+	printk("NUMA ");
+#endif
+	printk("%s\n", ppc_md.name ? ppc_md.name : "");
+
+	if (notify_die(DIE_OOPS, str, regs, err, 255, SIGSEGV) == NOTIFY_STOP)
+		return 1;
+
+	print_modules();
+	show_regs(regs);
 
 	return 0;
 }
 
+void die(const char *str, struct pt_regs *regs, long err)
+{
+	unsigned long flags = oops_begin(regs);
+
+	if (__die(str, regs, err))
+		err = 0;
+	oops_end(flags, regs, err);
+}
+
 void user_single_step_siginfo(struct task_struct *tsk,
 				struct pt_regs *regs, siginfo_t *info)
 {
@@ -217,10 +234,11 @@ void _exception(int signr, struct pt_reg
 			"at %016lx nip %016lx lr %016lx code %x\n";
 
 	if (!user_mode(regs)) {
-		if (die("Exception in kernel mode", regs, signr))
-			return;
-	} else if (show_unhandled_signals &&
-		   unhandled_signal(current, signr)) {
+		die("Exception in kernel mode", regs, signr);
+		return;
+	}
+
+	if (show_unhandled_signals && unhandled_signal(current, signr)) {
 		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
 				   current->comm, current->pid, signr,
 				   addr, regs->nip, regs->link, code);
Index: linux-build/arch/powerpc/include/asm/system.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/system.h	2011-11-08 11:40:10.408778257 +1100
+++ linux-build/arch/powerpc/include/asm/system.h	2011-11-14 08:32:21.185192875 +1100
@@ -193,8 +193,8 @@ extern void cacheable_memzero(void *p, u
 extern void *cacheable_memcpy(void *, const void *, unsigned int);
 extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
-extern int die(const char *, struct pt_regs *, long);
 extern void _exception(int, struct pt_regs *, int, unsigned long);
+extern void die(const char *, struct pt_regs *, long);
 extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
 
 #ifdef CONFIG_BOOKE_WDT
