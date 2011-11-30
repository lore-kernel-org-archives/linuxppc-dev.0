Return-Path: <anton@samba.org>
Message-Id: <20111130102414.861342670@samba.org>
Date: Wed, 30 Nov 2011 21:23:10 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 hbabu@us.ibm.com
Subject: [PATCH 2/9] powerpc: Remove broken and complicated kdump system reset
 code
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

We have a lot of complicated logic that handles possible recursion between
kdump and a system reset exception. We can solve this in a much simpler
way using the same setjmp/longjmp tricks xmon does.

As a first step, this patch removes the old system reset code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/kexec.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/kexec.h	2011-11-09 16:27:35.918705307 +1100
+++ linux-build/arch/powerpc/include/asm/kexec.h	2011-11-14 08:31:02.111805931 +1100
@@ -73,11 +73,6 @@ extern void kexec_smp_wait(void);	/* get
 					  master to copy new code to 0 */
 extern int crashing_cpu;
 extern void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *));
-extern cpumask_t cpus_in_sr;
-static inline int kexec_sr_activated(int cpu)
-{
-	return cpumask_test_cpu(cpu, &cpus_in_sr);
-}
 
 struct kimage;
 struct pt_regs;
@@ -94,7 +89,6 @@ extern void reserve_crashkernel(void);
 extern void machine_kexec_mask_interrupts(void);
 
 #else /* !CONFIG_KEXEC */
-static inline int kexec_sr_activated(int cpu) { return 0; }
 static inline void crash_kexec_secondary(struct pt_regs *regs) { }
 
 static inline int overlaps_crashkernel(unsigned long start, unsigned long size)
Index: linux-build/arch/powerpc/kernel/crash.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/crash.c	2011-11-09 16:27:35.950705892 +1100
+++ linux-build/arch/powerpc/kernel/crash.c	2011-11-14 08:31:02.111805931 +1100
@@ -47,7 +47,6 @@
 /* This keeps a track of which one is crashing cpu. */
 int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
-cpumask_t cpus_in_sr = CPU_MASK_NONE;
 
 #define CRASH_HANDLER_MAX 3
 /* NULL terminated list of shutdown handles */
@@ -55,7 +54,6 @@ static crash_shutdown_t crash_shutdown_h
 static DEFINE_SPINLOCK(crash_handlers_lock);
 
 #ifdef CONFIG_SMP
-static atomic_t enter_on_soft_reset = ATOMIC_INIT(0);
 
 void crash_ipi_callback(struct pt_regs *regs)
 {
@@ -70,23 +68,8 @@ void crash_ipi_callback(struct pt_regs *
 	cpumask_set_cpu(cpu, &cpus_in_crash);
 
 	/*
-	 * Entered via soft-reset - could be the kdump
-	 * process is invoked using soft-reset or user activated
-	 * it if some CPU did not respond to an IPI.
-	 * For soft-reset, the secondary CPU can enter this func
-	 * twice. 1 - using IPI, and 2. soft-reset.
-	 * Tell the kexec CPU that entered via soft-reset and ready
-	 * to go down.
-	 */
-	if (cpumask_test_cpu(cpu, &cpus_in_sr)) {
-		cpumask_clear_cpu(cpu, &cpus_in_sr);
-		atomic_inc(&enter_on_soft_reset);
-	}
-
-	/*
 	 * Starting the kdump boot.
 	 * This barrier is needed to make sure that all CPUs are stopped.
-	 * If not, soft-reset will be invoked to bring other CPUs.
 	 */
 	while (!cpumask_test_cpu(crashing_cpu, &cpus_in_crash))
 		cpu_relax();
@@ -103,25 +86,14 @@ void crash_ipi_callback(struct pt_regs *
 	/* NOTREACHED */
 }
 
-/*
- * Wait until all CPUs are entered via soft-reset.
- */
-static void crash_soft_reset_check(int cpu)
-{
-	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
-
-	cpumask_clear_cpu(cpu, &cpus_in_sr);
-	while (atomic_read(&enter_on_soft_reset) != ncpus)
-		cpu_relax();
-}
-
-
 static void crash_kexec_prepare_cpus(int cpu)
 {
 	unsigned int msecs;
 
 	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
 
+	printk(KERN_EMERG "Sending IPI to other CPUs\n");
+
 	crash_send_ipi(crash_ipi_callback);
 	smp_wmb();
 
@@ -131,7 +103,6 @@ static void crash_kexec_prepare_cpus(int
 	 * respond.
 	 * Delay of at least 10 seconds.
 	 */
-	printk(KERN_EMERG "Sending IPI to other cpus...\n");
 	msecs = 10000;
 	while ((cpumask_weight(&cpus_in_crash) < ncpus) && (--msecs > 0)) {
 		cpu_relax();
@@ -140,69 +111,36 @@ static void crash_kexec_prepare_cpus(int
 
 	/* Would it be better to replace the trap vector here? */
 
-	/*
-	 * FIXME: In case if we do not get all CPUs, one possibility: ask the
-	 * user to do soft reset such that we get all.
-	 * Soft-reset will be used until better mechanism is implemented.
-	 */
 	if (cpumask_weight(&cpus_in_crash) < ncpus) {
-		printk(KERN_EMERG "done waiting: %d cpu(s) not responding\n",
+		printk(KERN_EMERG "ERROR: %d CPU(s) not responding\n",
 			ncpus - cpumask_weight(&cpus_in_crash));
-		printk(KERN_EMERG "Activate soft-reset to stop other cpu(s)\n");
-		cpumask_clear(&cpus_in_sr);
-		atomic_set(&enter_on_soft_reset, 0);
-		while (cpumask_weight(&cpus_in_crash) < ncpus)
-			cpu_relax();
 	}
-	/*
-	 * Make sure all CPUs are entered via soft-reset if the kdump is
-	 * invoked using soft-reset.
-	 */
-	if (cpumask_test_cpu(cpu, &cpus_in_sr))
-		crash_soft_reset_check(cpu);
-	/* Leave the IPI callback set */
+
+	printk(KERN_EMERG "IPI complete\n");
 }
 
 /*
- * This function will be called by secondary cpus or by kexec cpu
- * if soft-reset is activated to stop some CPUs.
+ * This function will be called by secondary cpus.
  */
 void crash_kexec_secondary(struct pt_regs *regs)
 {
-	int cpu = smp_processor_id();
 	unsigned long flags;
-	int msecs = 5;
+	int msecs = 500;
 
 	local_irq_save(flags);
-	/* Wait 5ms if the kexec CPU is not entered yet. */
+
+	/* Wait 500ms for the primary crash CPU to signal its progress */
 	while (crashing_cpu < 0) {
 		if (--msecs < 0) {
-			/*
-			 * Either kdump image is not loaded or
-			 * kdump process is not started - Probably xmon
-			 * exited using 'x'(exit and recover) or
-			 * kexec_should_crash() failed for all running tasks.
-			 */
-			cpumask_clear_cpu(cpu, &cpus_in_sr);
+			/* No response, kdump image may not have been loaded */
 			local_irq_restore(flags);
 			return;
 		}
+
 		mdelay(1);
 		cpu_relax();
 	}
-	if (cpu == crashing_cpu) {
-		/*
-		 * Panic CPU will enter this func only via soft-reset.
-		 * Wait until all secondary CPUs entered and
-		 * then start kexec boot.
-		 */
-		crash_soft_reset_check(cpu);
-		cpumask_set_cpu(crashing_cpu, &cpus_in_crash);
-		if (ppc_md.kexec_cpu_down)
-			ppc_md.kexec_cpu_down(1, 0);
-		machine_kexec(kexec_crash_image);
-		/* NOTREACHED */
-	}
+
 	crash_ipi_callback(regs);
 }
 
@@ -225,7 +163,6 @@ static void crash_kexec_prepare_cpus(int
 
 void crash_kexec_secondary(struct pt_regs *regs)
 {
-	cpumask_clear(&cpus_in_sr);
 }
 #endif	/* CONFIG_SMP */
 
Index: linux-build/arch/powerpc/kernel/traps.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/traps.c	2011-11-14 08:31:01.519795547 +1100
+++ linux-build/arch/powerpc/kernel/traps.c	2011-11-14 08:31:02.111805931 +1100
@@ -162,10 +162,20 @@ int die(const char *str, struct pt_regs
 	printk("\n");
 	raw_spin_unlock_irqrestore(&die.lock, flags);
 
-	if (kexec_should_crash(current) ||
-		kexec_sr_activated(smp_processor_id()))
+	/*
+	 * A system reset (0x100) is a request to dump, so we always send
+	 * it through the crashdump code.
+	 */
+	if (kexec_should_crash(current) || (TRAP(regs) == 0x100)) {
 		crash_kexec(regs);
-	crash_kexec_secondary(regs);
+
+		/*
+		 * We aren't the primary crash CPU. We need to send it
+		 * to a holding pattern to avoid it ending up in the panic
+		 * code.
+		 */
+		crash_kexec_secondary(regs);
+	}
 
 	/*
 	 * While our oops output is serialised by a spinlock, output
@@ -232,25 +242,8 @@ void system_reset_exception(struct pt_re
 			return;
 	}
 
-#ifdef CONFIG_KEXEC
-	cpumask_set_cpu(smp_processor_id(), &cpus_in_sr);
-#endif
-
 	die("System Reset", regs, SIGABRT);
 
-	/*
-	 * Some CPUs when released from the debugger will execute this path.
-	 * These CPUs entered the debugger via a soft-reset. If the CPU was
-	 * hung before entering the debugger it will return to the hung
-	 * state when exiting this function.  This causes a problem in
-	 * kdump since the hung CPU(s) will not respond to the IPI sent
-	 * from kdump. To prevent the problem we call crash_kexec_secondary()
-	 * here. If a kdump had not been initiated or we exit the debugger
-	 * with the "exit and recover" command (x) crash_kexec_secondary()
-	 * will return after 5ms and the CPU returns to its previous state.
-	 */
-	crash_kexec_secondary(regs);
-
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		panic("Unrecoverable System Reset");
