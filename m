Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9251DDDD0A
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 20:01:43 +1100 (EST)
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17875.55046.873365.575945@cargo.ozlabs.ibm.com>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170973463.2620.373.camel@localhost.localdomain>
	<1171035382.4520.7.camel@johannes.berg>
	<1171293354.10344.6.camel@johannes.berg>
	<17875.55046.873365.575945@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 20:43:49 +0100
Message-Id: <1171568629.5220.51.camel@johannes.berg>
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org, linuxppc-dev@ozlabs.org
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
This makes more sense... Thanks for pointing that out. I wonder why it
actually worked.

 arch/powerpc/kernel/idle_power4.S       |   15 ++++++++++----
 arch/powerpc/platforms/powermac/setup.c |   34 +++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powermac/smp.c   |   12 +++++++++--
 include/asm-powerpc/machdep.h           |    2 +
 4 files changed, 56 insertions(+), 7 deletions(-)

--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/smp.c	2007-02-12 19:14:13.584037567 +0100
+++ linux-2.6-git/arch/powerpc/platforms/powermac/smp.c	2007-02-12 19:14:32.345037567 +0100
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
--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/setup.c	2007-02-12 19:14:32.182037567 +0100
+++ linux-2.6-git/arch/powerpc/platforms/powermac/setup.c	2007-02-12 19:14:32.347037567 +0100
@@ -425,6 +425,9 @@ static int initializing = 1;
 static int pmac_late_init(void)
 {
 	initializing = 0;
+	/* this is udbg (which is __init) and we can later use it during
+	 * cpu hotplug (in smp_core99_kick_cpu) */
+	ppc_md.progress = NULL;
 	return 0;
 }
 
@@ -651,6 +654,35 @@ static int pmac_pci_probe_mode(struct pc
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
+
+		power4_idle_irqs_softdisabled();
+	}
+}
+#endif
+
 #endif
 
 define_machine(powermac) {
@@ -689,6 +721,6 @@ define_machine(powermac) {
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		= generic_mach_cpu_die,
+	.cpu_die		= pmac_cpu_die,
 #endif
 };
--- linux-2.6-git.orig/arch/powerpc/kernel/idle_power4.S	2007-02-12 19:14:13.624037567 +0100
+++ linux-2.6-git/arch/powerpc/kernel/idle_power4.S	2007-02-15 20:16:06.906249905 +0100
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
+	bne+	1b
+	blr
--- linux-2.6-git.orig/include/asm-powerpc/machdep.h	2007-02-12 19:14:13.645037567 +0100
+++ linux-2.6-git/include/asm-powerpc/machdep.h	2007-02-15 20:15:27.287249905 +0100
@@ -252,6 +252,8 @@ struct machdep_calls {
 
 extern void power4_idle(void);
 extern void ppc6xx_idle(void);
+/* this one is for CPU hotplug (e.g. powermac) */
+extern void power4_idle_irqs_softdisabled(void);
 
 /*
  * ppc_md contains a copy of the machine description structure for the
