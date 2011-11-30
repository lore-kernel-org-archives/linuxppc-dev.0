Return-Path: <anton@samba.org>
Message-Id: <20111130102415.403402837@samba.org>
Date: Wed, 30 Nov 2011 21:23:16 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 hbabu@us.ibm.com
Subject: [PATCH 8/9] powerpc/kdump: Delay before sending IPI on a system reset
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

If we enter the kdump code via system reset, wait a bit before
sending the IPI to capture all secondary CPUs. Without it we race
with the hypervisor that is issuing the system reset to each CPU.
If the IPI gets there first the system reset oops output then shows
the register state of the IPI handler which is not what we want.

I took the opportunity to add defines for all the various delays
we have. There's no need for cpu_relax when we are doing an mdelay,
so remove them too.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/crash.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/crash.c	2011-11-28 11:44:42.222009861 +1100
+++ linux-build/arch/powerpc/kernel/crash.c	2011-11-28 14:01:58.033283718 +1100
@@ -30,6 +30,20 @@
 #include <asm/system.h>
 #include <asm/setjmp.h>
 
+/*
+ * The primary CPU waits a while for all secondary CPUs to enter. This is to
+ * avoid sending an IPI if the secondary CPUs are entering
+ * crash_kexec_secondary on their own (eg via a system reset).
+ *
+ * The secondary timeout has to be longer than the primary. Both timeouts are
+ * in milliseconds.
+ */
+#define PRIMARY_TIMEOUT		500
+#define SECONDARY_TIMEOUT	1000
+
+#define IPI_TIMEOUT		10000
+#define REAL_MODE_TIMEOUT	10000
+
 /* This keeps a track of which one is the crashing cpu. */
 int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
@@ -99,11 +113,9 @@ again:
 	 * FIXME: Until we will have the way to stop other CPUs reliably,
 	 * the crash CPU will send an IPI and wait for other CPUs to
 	 * respond.
-	 * Delay of at least 10 seconds.
 	 */
-	msecs = 10000;
+	msecs = IPI_TIMEOUT;
 	while ((cpumask_weight(&cpus_in_crash) < ncpus) && (--msecs > 0)) {
-		cpu_relax();
 		mdelay(1);
 	}
 
@@ -163,11 +175,11 @@ again:
 void crash_kexec_secondary(struct pt_regs *regs)
 {
 	unsigned long flags;
-	int msecs = 500;
+	int msecs = SECONDARY_TIMEOUT;
 
 	local_irq_save(flags);
 
-	/* Wait 500ms for the primary crash CPU to signal its progress */
+	/* Wait for the primary crash CPU to signal its progress */
 	while (crashing_cpu < 0) {
 		if (--msecs < 0) {
 			/* No response, kdump image may not have been loaded */
@@ -176,7 +188,6 @@ void crash_kexec_secondary(struct pt_reg
 		}
 
 		mdelay(1);
-		cpu_relax();
 	}
 
 	crash_ipi_callback(regs);
@@ -211,7 +222,7 @@ static void crash_kexec_wait_realmode(in
 	unsigned int msecs;
 	int i;
 
-	msecs = 10000;
+	msecs = REAL_MODE_TIMEOUT;
 	for (i=0; i < nr_cpu_ids && msecs > 0; i++) {
 		if (i == cpu)
 			continue;
@@ -306,6 +317,14 @@ void default_machine_crash_shutdown(stru
 	 */
 	crashing_cpu = smp_processor_id();
 	crash_save_cpu(regs, crashing_cpu);
+
+	/*
+	 * If we came in via system reset, wait a while for the secondary
+	 * CPUs to enter.
+	 */
+	if (TRAP(regs) == 0x100)
+		mdelay(PRIMARY_TIMEOUT);
+
 	crash_kexec_prepare_cpus(crashing_cpu);
 	cpumask_set_cpu(crashing_cpu, &cpus_in_crash);
 	crash_kexec_wait_realmode(crashing_cpu);
