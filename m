Return-Path: <anton@samba.org>
Message-Id: <20111130102415.491424469@samba.org>
Date: Wed, 30 Nov 2011 21:23:17 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 hbabu@us.ibm.com
Subject: [PATCH 9/9] powerpc/kdump: Only save CPU state first time through the
 secondary CPU capture code
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

We might enter the secondary CPU capture code twice, eg if we have to
unstick some CPUs with a system reset. In this case we don't want to
overwrite the state on CPUs that had made it into the capture code OK,
so use the cpus_state_saved cpumask for that and make it local to
crash_ipi_callback.

For controlling progress now use atomic_t cpus_in_crash to count how
many CPUs have made it into the kdump code, and time_to_dump to tell
everyone it's time to dump.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/crash.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/crash.c	2011-11-30 07:38:35.131392789 +1100
+++ linux-build/arch/powerpc/kernel/crash.c	2011-11-30 21:22:18.790917413 +1100
@@ -46,7 +46,8 @@
 
 /* This keeps a track of which one is the crashing cpu. */
 int crashing_cpu = -1;
-static cpumask_t cpus_in_crash = CPU_MASK_NONE;
+static atomic_t cpus_in_crash;
+static int time_to_dump;
 
 #define CRASH_HANDLER_MAX 3
 /* NULL terminated list of shutdown handles */
@@ -67,21 +68,27 @@ static int handle_fault(struct pt_regs *
 
 void crash_ipi_callback(struct pt_regs *regs)
 {
+	static cpumask_t cpus_state_saved = CPU_MASK_NONE;
+
 	int cpu = smp_processor_id();
 
 	if (!cpu_online(cpu))
 		return;
 
 	hard_irq_disable();
-	if (!cpumask_test_cpu(cpu, &cpus_in_crash))
+	if (!cpumask_test_cpu(cpu, &cpus_state_saved)) {
 		crash_save_cpu(regs, cpu);
-	cpumask_set_cpu(cpu, &cpus_in_crash);
+		cpumask_set_cpu(cpu, &cpus_state_saved);
+	}
+
+	atomic_inc(&cpus_in_crash);
+	smp_mb__after_atomic_inc();
 
 	/*
 	 * Starting the kdump boot.
 	 * This barrier is needed to make sure that all CPUs are stopped.
 	 */
-	while (!cpumask_test_cpu(crashing_cpu, &cpus_in_crash))
+	while (!time_to_dump)
 		cpu_relax();
 
 	if (ppc_md.kexec_cpu_down)
@@ -115,19 +122,18 @@ again:
 	 * respond.
 	 */
 	msecs = IPI_TIMEOUT;
-	while ((cpumask_weight(&cpus_in_crash) < ncpus) && (--msecs > 0)) {
+	while ((atomic_read(&cpus_in_crash) < ncpus) && (--msecs > 0))
 		mdelay(1);
-	}
 
 	/* Would it be better to replace the trap vector here? */
 
-	if (cpumask_weight(&cpus_in_crash) >= ncpus) {
+	if (atomic_read(&cpus_in_crash) >= ncpus) {
 		printk(KERN_EMERG "IPI complete\n");
 		return;
 	}
 
 	printk(KERN_EMERG "ERROR: %d cpu(s) not responding\n",
-		ncpus - cpumask_weight(&cpus_in_crash));
+		ncpus - atomic_read(&cpus_in_crash));
 
 	/*
 	 * If we have a panic timeout set then we can't wait indefinitely
@@ -155,10 +161,10 @@ again:
 		 * crash code again. We need to reset cpus_in_crash so we
 		 * wait for everyone to do this.
 		 */
-		cpus_in_crash = CPU_MASK_NONE;
+		atomic_set(&cpus_in_crash, 0);
 		smp_mb();
 
-		while (cpumask_weight(&cpus_in_crash) < ncpus)
+		while (atomic_read(&cpus_in_crash) < ncpus)
 			cpu_relax();
 	}
 
@@ -316,7 +322,6 @@ void default_machine_crash_shutdown(stru
 	 * such that another IPI will not be sent.
 	 */
 	crashing_cpu = smp_processor_id();
-	crash_save_cpu(regs, crashing_cpu);
 
 	/*
 	 * If we came in via system reset, wait a while for the secondary
@@ -326,7 +331,11 @@ void default_machine_crash_shutdown(stru
 		mdelay(PRIMARY_TIMEOUT);
 
 	crash_kexec_prepare_cpus(crashing_cpu);
-	cpumask_set_cpu(crashing_cpu, &cpus_in_crash);
+
+	crash_save_cpu(regs, crashing_cpu);
+
+	time_to_dump = 1;
+
 	crash_kexec_wait_realmode(crashing_cpu);
 
 	machine_kexec_mask_interrupts();
