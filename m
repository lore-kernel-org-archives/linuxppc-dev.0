Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35F98DDE22
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 23:12:41 +1100 (EST)
Message-Id: <20070321104210.090659000@sipsolutions.net>
References: <20070321104037.696668000@sipsolutions.net>
Date: Wed, 21 Mar 2007 11:40:38 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 1/6] powermac: support G5 CPU hotplug
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
disabled are put into an idle loop with the decrementer frequency set
to minimum. To wake them up again we kick them just like when bringing
them up. To stop those CPUs from messing with any global state we stop
them from entering the timer interrupt.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 arch/powerpc/kernel/idle_power4.S       |   14 +++++++++---
 arch/powerpc/platforms/powermac/setup.c |   35 +++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powermac/smp.c   |   12 +++++++++-
 include/asm-powerpc/machdep.h           |    2 +
 4 files changed, 56 insertions(+), 7 deletions(-)

--- linux-2.6.orig/arch/powerpc/platforms/powermac/smp.c	2007-03-21 11:18:47.542243895 +0100
+++ linux-2.6/arch/powerpc/platforms/powermac/smp.c	2007-03-21 11:23:27.332243895 +0100
@@ -897,7 +897,7 @@ void smp_core99_cpu_die(unsigned int cpu
 	cpu_dead[cpu] = 0;
 }
 
-#endif
+#endif /* CONFIG_HOTPLUG_CPU && CONFIG_PP32 */
 
 /* Core99 Macs (dual G4s and G5s) */
 struct smp_ops_t core99_smp_ops = {
@@ -907,8 +907,16 @@ struct smp_ops_t core99_smp_ops = {
 	.setup_cpu	= smp_core99_setup_cpu,
 	.give_timebase	= smp_core99_give_timebase,
 	.take_timebase	= smp_core99_take_timebase,
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
+#if defined(CONFIG_HOTPLUG_CPU)
+# if defined(CONFIG_PPC32)
 	.cpu_disable	= smp_core99_cpu_disable,
 	.cpu_die	= smp_core99_cpu_die,
+# endif
+# if defined(CONFIG_PPC64)
+	.cpu_disable	= generic_cpu_disable,
+	.cpu_die	= generic_cpu_die,
+	/* intentionally do *NOT* assign cpu_enable,
+	 * the generic code will use kick_cpu then! */
+# endif
 #endif
 };
--- linux-2.6.orig/arch/powerpc/platforms/powermac/setup.c	2007-03-21 11:18:47.612243895 +0100
+++ linux-2.6/arch/powerpc/platforms/powermac/setup.c	2007-03-21 11:28:28.542243895 +0100
@@ -425,6 +425,9 @@ static int initializing = 1;
 static int pmac_late_init(void)
 {
 	initializing = 0;
+	/* this is udbg (which is __init) and we can later use it during
+	 * cpu hotplug (in smp_core99_kick_cpu) */
+	ppc_md.progress = NULL;
 	return 0;
 }
 
@@ -651,6 +654,36 @@ static int pmac_pci_probe_mode(struct pc
 		return PCI_PROBE_NORMAL;
 	return PCI_PROBE_DEVTREE;
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+/* access per cpu vars from generic smp.c */
+DECLARE_PER_CPU(int, cpu_state);
+
+static void pmac_cpu_die(void)
+{
+	/* turn off as much as possible, we'll be
+	 * kicked out as this will only be invoked
+	 * on core99 platforms for now ... */
+
+	printk(KERN_INFO "CPU#%d offline\n", smp_processor_id());
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+	smp_wmb();
+
+	/* during the path that leads here preemption is disabled,
+	 * reenable it now so that when coming up preempt count is
+	 * zero correctly */
+	preempt_enable();
+
+	while (1) {
+		/* let's not take timer interrupts too often ... */
+		set_dec(0x7fffffff);
+		printk("CPU %d dead\n", smp_processor_id());
+
+		power4_idle_irqs_softdisabled();
+	}
+}
+#endif
+
 #endif
 
 define_machine(powermac) {
@@ -689,6 +722,6 @@ define_machine(powermac) {
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		= generic_mach_cpu_die,
+	.cpu_die		= pmac_cpu_die,
 #endif
 };
--- linux-2.6.orig/arch/powerpc/kernel/idle_power4.S	2007-03-21 11:18:47.662243895 +0100
+++ linux-2.6/arch/powerpc/kernel/idle_power4.S	2007-03-21 11:23:27.342243895 +0100
@@ -19,7 +19,12 @@
 
 	.text
 
+_GLOBAL(power4_idle_irqs_softdisabled)
+	li	r6,0
+	b	0f
 _GLOBAL(power4_idle)
+	li	r6,1
+0:
 BEGIN_FTR_SECTION
 	blr
 END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
@@ -35,8 +40,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	rotldi	r0,r0,16
 	mtmsrd	r0,1			/* hard-disable interrupts */
 	li	r0,1
-	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
-	stb	r0,PACAHARDIRQEN(r13)
+	stb	r0,PACAHARDIRQEN(r13)	/* we'll hard-enable shortly */
+	stb	r6,PACASOFTIRQEN(r13)	/* set softirqs enabled bit */
 BEGIN_FTR_SECTION
 	DSSALL
 	sync
@@ -51,5 +56,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	isync
 	mtmsrd	r7
 	isync
-	b	1b
-
+	cmpdi	0,r6,0
+	bne+	1b			/* return for softirq-disabled case */
+	blr
--- linux-2.6.orig/include/asm-powerpc/machdep.h	2007-03-21 11:18:47.682243895 +0100
+++ linux-2.6/include/asm-powerpc/machdep.h	2007-03-21 11:27:55.412243895 +0100
@@ -252,6 +252,8 @@ struct machdep_calls {
 
 extern void power4_idle(void);
 extern void ppc6xx_idle(void);
+/* this one is for CPU hotplug (e.g. powermac) */
+extern void power4_idle_irqs_softdisabled(void);
 
 /*
  * ppc_md contains a copy of the machine description structure for the

--
