Return-Path: <anton@samba.org>
Message-Id: <20111130102414.961522775@samba.org>
Date: Wed, 30 Nov 2011 21:23:11 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 hbabu@us.ibm.com
Subject: [PATCH 3/9] powerpc/kdump: Use setjmp/longjmp to handle kdump and
 system reset recursion
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

We can handle recursion caused by system reset by reusing the crash
shutdown fault handler.

Since we don't have an OS triggerable NMI, if all CPUs don't make it
into kdump then we tell the user to issue a system reset. However if
we have a panic timeout set we cannot wait forever and must continue
the kdump.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/crash.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/crash.c	2011-11-25 16:41:06.228864087 +1100
+++ linux-build/arch/powerpc/kernel/crash.c	2011-11-25 16:42:05.825915628 +1100
@@ -53,6 +53,16 @@ static cpumask_t cpus_in_crash = CPU_MAS
 static crash_shutdown_t crash_shutdown_handles[CRASH_HANDLER_MAX+1];
 static DEFINE_SPINLOCK(crash_handlers_lock);
 
+static unsigned long crash_shutdown_buf[JMP_BUF_LEN];
+static int crash_shutdown_cpu = -1;
+
+static int handle_fault(struct pt_regs *regs)
+{
+	if (crash_shutdown_cpu == smp_processor_id())
+		longjmp(crash_shutdown_buf, 1);
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 
 void crash_ipi_callback(struct pt_regs *regs)
@@ -89,14 +99,16 @@ void crash_ipi_callback(struct pt_regs *
 static void crash_kexec_prepare_cpus(int cpu)
 {
 	unsigned int msecs;
-
 	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
+	int tries = 0;
+	int (*old_handler)(struct pt_regs *regs);
 
 	printk(KERN_EMERG "Sending IPI to other CPUs\n");
 
 	crash_send_ipi(crash_ipi_callback);
 	smp_wmb();
 
+again:
 	/*
 	 * FIXME: Until we will have the way to stop other CPUs reliably,
 	 * the crash CPU will send an IPI and wait for other CPUs to
@@ -111,12 +123,52 @@ static void crash_kexec_prepare_cpus(int
 
 	/* Would it be better to replace the trap vector here? */
 
-	if (cpumask_weight(&cpus_in_crash) < ncpus) {
-		printk(KERN_EMERG "ERROR: %d CPU(s) not responding\n",
-			ncpus - cpumask_weight(&cpus_in_crash));
+	if (cpumask_weight(&cpus_in_crash) >= ncpus) {
+		printk(KERN_EMERG "IPI complete\n");
+		return;
+	}
+
+	printk(KERN_EMERG "ERROR: %d cpu(s) not responding\n",
+		ncpus - cpumask_weight(&cpus_in_crash));
+
+	/*
+	 * If we have a panic timeout set then we can't wait indefinitely
+	 * for someone to activate system reset. We also give up on the
+	 * second time through if system reset fail to work.
+	 */
+	if ((panic_timeout > 0) || (tries > 0))
+		return;
+
+	/*
+	 * A system reset will cause all CPUs to take an 0x100 exception.
+	 * The primary CPU returns here via setjmp, and the secondary
+	 * CPUs reexecute the crash_kexec_secondary path.
+	 */
+	old_handler = __debugger;
+	__debugger = handle_fault;
+	crash_shutdown_cpu = smp_processor_id();
+
+	if (setjmp(crash_shutdown_buf) == 0) {
+		printk(KERN_EMERG "Activate system reset (dumprestart) "
+				  "to stop other cpu(s)\n");
+
+		/*
+		 * A system reset will force all CPUs to execute the
+		 * crash code again. We need to reset cpus_in_crash so we
+		 * wait for everyone to do this.
+		 */
+		cpus_in_crash = CPU_MASK_NONE;
+		smp_mb();
+
+		while (cpumask_weight(&cpus_in_crash) < ncpus)
+			cpu_relax();
 	}
 
-	printk(KERN_EMERG "IPI complete\n");
+	crash_shutdown_cpu = -1;
+	__debugger = old_handler;
+
+	tries++;
+	goto again;
 }
 
 /*
@@ -245,16 +297,6 @@ int crash_shutdown_unregister(crash_shut
 }
 EXPORT_SYMBOL(crash_shutdown_unregister);
 
-static unsigned long crash_shutdown_buf[JMP_BUF_LEN];
-static int crash_shutdown_cpu = -1;
-
-static int handle_fault(struct pt_regs *regs)
-{
-	if (crash_shutdown_cpu == smp_processor_id())
-		longjmp(crash_shutdown_buf, 1);
-	return 0;
-}
-
 void default_machine_crash_shutdown(struct pt_regs *regs)
 {
 	unsigned int i;
