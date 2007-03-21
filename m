Return-Path: <anton@ozlabs.org>
Message-Id: <20070321013825.179096000@samba.org>
References: <20070321013810.404636000@samba.org>
Date: Tue, 20 Mar 2007 20:38:15 -0500
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 05/10] Use KERN_EMERG everywhere in oops printout
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Turn the volume up to 11. Distros will silence our oops messages no more.
Use of sunglasses recommended.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/traps.c	2007-03-20 09:53:57.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/traps.c	2007-03-20 09:53:58.000000000 -0500
@@ -140,7 +140,10 @@
 	}
 
 	if (++die.lock_owner_depth < 3) {
-		printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
+		printk(KERN_EMERG "Oops: %s, sig: %ld [#%d]\n", str, err,
+		       ++die_counter);
+
+		printk(KERN_EMERG);
 #ifdef CONFIG_PREEMPT
 		printk("PREEMPT ");
 #endif
@@ -155,10 +158,11 @@
 #endif
 		printk("%s\n", ppc_md.name ? ppc_md.name : "");
 
+		printk(KERN_EMERG);
 		print_modules();
-		show_regs(regs);
+		show_regs_log_lvl(regs, KERN_EMERG);
 	} else {
-		printk("Recursive die() failure, output suppressed\n");
+		printk(KERN_EMERG "Recursive die() failure, output suppressed\n");
 	}
 
 	bust_spinlocks(0);
Index: linux-2.6/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/process.c	2007-03-20 09:53:47.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/process.c	2007-03-20 09:53:58.000000000 -0500
@@ -49,8 +49,6 @@
 #include <asm/firmware.h>
 #endif
 
-extern unsigned long _get_SP(void);
-
 #ifndef CONFIG_SMP
 struct task_struct *last_task_used_math = NULL;
 struct task_struct *last_task_used_altivec = NULL;
@@ -347,13 +345,13 @@
 	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
 			sizeof(int));
 
-	printk("Instruction dump:");
+	printk(KERN_EMERG "Instruction dump:");
 
 	for (i = 0; i < instructions_to_print; i++) {
 		int instr;
 
 		if (!(i % 8))
-			printk("\n");
+			printk("\n%s", KERN_EMERG);
 
 		/* We use __get_user here *only* to avoid an OOPS on a
 		 * bad address because the pc *should* only be a
@@ -411,21 +409,25 @@
 #define LAST_VOLATILE	12
 #endif
 
-void show_regs(struct pt_regs * regs)
+static void show_stack_log_lvl(struct task_struct *tsk, unsigned long *stack,
+                               char *log_lvl);
+
+void show_regs_log_lvl(struct pt_regs *regs, char *log_lvl)
 {
 	int i, trap;
 
-	printk("NIP: "REG" LR: "REG" CTR: "REG"\n",
-	       regs->nip, regs->link, regs->ctr);
-	printk("REGS: %p TRAP: %04lx   %s  (%s)\n",
+	printk("%sNIP: "REG" LR: "REG" CTR: "REG"\n",
+	       log_lvl, regs->nip, regs->link, regs->ctr);
+	printk("%sREGS: %p TRAP: %04lx   %s  (%s)\n", log_lvl,
 	       regs, regs->trap, print_tainted(), init_utsname()->release);
-	printk("MSR: "REG" ", regs->msr);
+	printk("%sMSR: "REG" ", log_lvl, regs->msr);
 	printbits(regs->msr, msr_bits);
 	printk("  CR: %08lX  XER: %08lX\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
 	if (trap == 0x300 || trap == 0x600)
-		printk("DAR: "REG", DSISR: "REG"\n", regs->dar, regs->dsisr);
-	printk("TASK = %p[%d] '%s' THREAD: %p",
+		printk("%sDAR: "REG", DSISR: "REG"\n", log_lvl, regs->dar,
+		       regs->dsisr);
+	printk("%sTASK = %p[%d] '%s' THREAD: %p", log_lvl,
 	       current, current->pid, current->comm, task_thread_info(current));
 
 #ifdef CONFIG_SMP
@@ -434,7 +436,7 @@
 
 	for (i = 0;  i < 32;  i++) {
 		if ((i % REGS_PER_LINE) == 0)
-			printk("\n" KERN_INFO "GPR%02d: ", i);
+			printk("\n%sGPR%02d: ", log_lvl, i);
 		printk(REG " ", regs->gpr[i]);
 		if (i == LAST_VOLATILE && !FULL_REGS(regs))
 			break;
@@ -445,16 +447,21 @@
 	 * Lookup NIP late so we have the best change of getting the
 	 * above info out without failing
 	 */
-	printk("NIP ["REG"] ", regs->nip);
+	printk("%sNIP ["REG"] ", log_lvl, regs->nip);
 	print_symbol("%s\n", regs->nip);
-	printk("LR ["REG"] ", regs->link);
+	printk("%sLR ["REG"] ", log_lvl, regs->link);
 	print_symbol("%s\n", regs->link);
 #endif
-	show_stack(current, (unsigned long *) regs->gpr[1]);
+	show_stack_log_lvl(current, (unsigned long *) regs->gpr[1], KERN_EMERG);
 	if (!user_mode(regs))
 		show_instructions(regs);
 }
 
+void show_regs(struct pt_regs *regs)
+{
+	show_regs_log_lvl(regs, "");
+}
+
 void exit_thread(void)
 {
 	discard_lazy_cpu_state();
@@ -884,7 +891,8 @@
 
 static int kstack_depth_to_print = 64;
 
-void show_stack(struct task_struct *tsk, unsigned long *stack)
+static void show_stack_log_lvl(struct task_struct *tsk, unsigned long *stack,
+			       char *log_lvl)
 {
 	unsigned long sp, ip, lr, newsp;
 	int count = 0;
@@ -901,7 +909,7 @@
 	}
 
 	lr = 0;
-	printk("Call Trace:\n");
+	printk("%sCall Trace:\n", log_lvl);
 	do {
 		if (!validate_sp(sp, tsk, MIN_STACK_FRAME))
 			return;
@@ -910,7 +918,7 @@
 		newsp = stack[0];
 		ip = stack[FRAME_LR_SAVE];
 		if (!firstframe || ip != lr) {
-			printk("["REG"] ["REG"] ", sp, ip);
+			printk("%s["REG"] ["REG"] ", log_lvl, sp, ip);
 			print_symbol("%s", ip);
 			if (firstframe)
 				printk(" (unreliable)");
@@ -926,9 +934,10 @@
 		    && stack[FRAME_MARKER] == REGS_MARKER) {
 			struct pt_regs *regs = (struct pt_regs *)
 				(sp + STACK_FRAME_OVERHEAD);
-			printk("--- Exception: %lx", regs->trap);
+			printk("%s--- Exception: %lx", log_lvl, regs->trap);
 			print_symbol(" at %s\n", regs->nip);
 			lr = regs->link;
+			printk(KERN_EMERG);
 			print_symbol("    LR = %s\n", lr);
 			firstframe = 1;
 		}
@@ -937,6 +946,11 @@
 	} while (count++ < kstack_depth_to_print);
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *stack)
+{
+	show_stack_log_lvl(tsk, stack, "");
+}
+
 void dump_stack(void)
 {
 	show_stack(current, NULL);
Index: linux-2.6/include/asm-powerpc/system.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/system.h	2007-03-20 09:53:19.000000000 -0500
+++ linux-2.6/include/asm-powerpc/system.h	2007-03-20 09:53:58.000000000 -0500
@@ -103,6 +103,7 @@
 
 extern int set_dabr(unsigned long dabr);
 extern void print_backtrace(unsigned long *);
+extern void show_regs_log_lvl(struct pt_regs * regs, char * log_lvl);
 extern void show_regs(struct pt_regs * regs);
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
Index: linux-2.6/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/fault.c	2007-03-20 09:53:19.000000000 -0500
+++ linux-2.6/arch/powerpc/mm/fault.c	2007-03-20 09:53:58.000000000 -0500
@@ -429,20 +429,20 @@
 	switch (regs->trap) {
 	case 0x300:
 	case 0x380:
-		printk(KERN_ALERT "Unable to handle kernel paging request for "
+		printk(KERN_EMERG "Unable to handle kernel paging request for "
 			"data at address 0x%08lx\n", regs->dar);
 		break;
 	case 0x400:
 	case 0x480:
-		printk(KERN_ALERT "Unable to handle kernel paging request for "
+		printk(KERN_EMERG "Unable to handle kernel paging request for "
 			"instruction fetch\n");
 		break;
 	default:
-		printk(KERN_ALERT "Unable to handle kernel paging request for "
+		printk(KERN_EMERG "Unable to handle kernel paging request for "
 			"unknown fault\n");
 		break;
 	}
-	printk(KERN_ALERT "Faulting instruction address: 0x%08lx\n",
+	printk(KERN_EMERG "Faulting instruction address: 0x%08lx\n",
 		regs->nip);
 
 	die("Kernel access of bad area", regs, sig);

--
