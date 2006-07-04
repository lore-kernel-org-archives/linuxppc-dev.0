Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0B9367B7F
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 14:09:42 +1000 (EST)
Subject: [PATCH] powerpc: Fix non-MPIC CHRPs with CONFIG_SMP set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 14:09:36 +1000
Message-Id: <1151986176.13828.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pseudo-CHRP machines like Pegasos without an MPIC would crash at boot if
CONFIG_SMP was set because the "smp_ops" pointer was set to MPIC related
ops unconditionally. This patch makes it NULL on machines that don't
support SMP and provides proper default behaviour in the callers when
smp_ops is NULL.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/kernel/smp.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/smp.c	2006-07-04 13:01:13.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/smp.c	2006-07-04 13:03:32.000000000 +1000
@@ -144,13 +144,15 @@
 
 void smp_send_reschedule(int cpu)
 {
-	smp_ops->message_pass(cpu, PPC_MSG_RESCHEDULE);
+	if (likely(smp_ops))
+		smp_ops->message_pass(cpu, PPC_MSG_RESCHEDULE);
 }
 
 #ifdef CONFIG_DEBUGGER
 void smp_send_debugger_break(int cpu)
 {
-	smp_ops->message_pass(cpu, PPC_MSG_DEBUGGER_BREAK);
+	if (likely(smp_ops))
+		smp_ops->message_pass(cpu, PPC_MSG_DEBUGGER_BREAK);
 }
 #endif
 
@@ -158,7 +160,7 @@
 void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 {
 	crash_ipi_function_ptr = crash_ipi_callback;
-	if (crash_ipi_callback) {
+	if (crash_ipi_callback && smp_ops) {
 		mb();
 		smp_ops->message_pass(MSG_ALL_BUT_SELF, PPC_MSG_DEBUGGER_BREAK);
 	}
@@ -220,6 +222,9 @@
 	/* Can deadlock when called with interrupts disabled */
 	WARN_ON(irqs_disabled());
 
+	if (unlikely(smp_ops == NULL))
+		return -1;
+
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
@@ -357,7 +362,10 @@
 	smp_store_cpu_info(boot_cpuid);
 	cpu_callin_map[boot_cpuid] = 1;
 
-	max_cpus = smp_ops->probe();
+	if (smp_ops)
+		max_cpus = smp_ops->probe();
+	else
+		max_cpus = 1;
  
 	smp_space_timers(max_cpus);
 
@@ -453,7 +461,7 @@
 
 static int __devinit cpu_enable(unsigned int cpu)
 {
-	if (smp_ops->cpu_enable)
+	if (smp_ops && smp_ops->cpu_enable)
 		return smp_ops->cpu_enable(cpu);
 
 	return -ENOSYS;
@@ -467,7 +475,8 @@
 	if (!cpu_enable(cpu))
 		return 0;
 
-	if (smp_ops->cpu_bootable && !smp_ops->cpu_bootable(cpu))
+	if (smp_ops == NULL ||
+	    (smp_ops->cpu_bootable && !smp_ops->cpu_bootable(cpu)))
 		return -EINVAL;
 
 	/* Make sure callin-map entry is 0 (can be leftover a CPU
@@ -568,7 +577,8 @@
 	old_mask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(boot_cpuid));
 	
-	smp_ops->setup_cpu(boot_cpuid);
+	if (smp_ops)
+		smp_ops->setup_cpu(boot_cpuid);
 
 	set_cpus_allowed(current, old_mask);
 
Index: linux-irq-work/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/chrp/setup.c	2006-07-04 13:01:13.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/chrp/setup.c	2006-07-04 13:03:32.000000000 +1000
@@ -291,10 +291,6 @@
 
 	pci_create_OF_bus_map();
 
-#ifdef CONFIG_SMP
-	smp_ops = &chrp_smp_ops;
-#endif /* CONFIG_SMP */
-
 	/*
 	 * Print the banner, then scroll down so boot progress
 	 * can be printed.  -- Cort
@@ -479,6 +475,14 @@
 	chrp_find_openpic();
 	chrp_find_8259();
 
+#ifdef CONFIG_SMP
+	/* Pegasos has no MPIC, those ops would make it crash. It might be an
+	 * option to move setting them to after we probe the PIC though
+	 */
+	if (chrp_mpic != NULL)
+		smp_ops = &chrp_smp_ops;
+#endif /* CONFIG_SMP */
+
 	if (_chrp_type == _CHRP_Pegasos)
 		ppc_md.get_irq        = i8259_irq;
 
