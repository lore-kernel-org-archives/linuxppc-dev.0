Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3156CDDFB8
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 18:16:30 +1000 (EST)
Subject: [PATCH] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 02 May 2007 08:21:12 +0200
Message-Id: <1178086872.13233.27.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
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
 arch/powerpc/kernel/idle_power4.S       |   14 +++++++++----
 arch/powerpc/platforms/powermac/setup.c |   34 +++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powermac/smp.c   |   12 +++++++++--
 include/asm-powerpc/machdep.h           |    2 +
 4 files changed, 55 insertions(+), 7 deletions(-)

--- wireless-dev.orig/arch/powerpc/platforms/powermac/smp.c	2007-05-02 08:14:47.179192713 +0200
+++ wireless-dev/arch/powerpc/platforms/powermac/smp.c	2007-05-02 08:15:08.619192713 +0200
@@ -900,7 +900,7 @@ void smp_core99_cpu_die(unsigned int cpu
 	cpu_dead[cpu] = 0;
 }
 
-#endif
+#endif /* CONFIG_HOTPLUG_CPU && CONFIG_PP32 */
 
 /* Core99 Macs (dual G4s and G5s) */
 struct smp_ops_t core99_smp_ops = {
@@ -910,8 +910,16 @@ struct smp_ops_t core99_smp_ops = {
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
--- wireless-dev.orig/arch/powerpc/platforms/powermac/setup.c	2007-05-02 08:14:47.229192713 +0200
+++ wireless-dev/arch/powerpc/platforms/powermac/setup.c	2007-05-02 08:20:25.049192713 +0200
@@ -444,6 +444,9 @@ static int initializing = 1;
 static int pmac_late_init(void)
 {
 	initializing = 0;
+	/* this is udbg (which is __init) and we can later use it during
+	 * cpu hotplug (in smp_core99_kick_cpu) */
+	ppc_md.progress = NULL;
 	return 0;
 }
 
@@ -661,6 +664,35 @@ static int pmac_pci_probe_mode(struct pc
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
@@ -698,6 +730,6 @@ define_machine(powermac) {
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		= generic_mach_cpu_die,
+	.cpu_die		= pmac_cpu_die,
 #endif
 };
--- wireless-dev.orig/arch/powerpc/kernel/idle_power4.S	2007-05-02 08:14:47.259192713 +0200
+++ wireless-dev/arch/powerpc/kernel/idle_power4.S	2007-05-02 08:15:08.619192713 +0200
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
--- wireless-dev.orig/include/asm-powerpc/machdep.h	2007-05-02 08:14:47.329192713 +0200
+++ wireless-dev/include/asm-powerpc/machdep.h	2007-05-02 08:20:02.179192713 +0200
@@ -249,6 +249,8 @@ struct machdep_calls {
 
 extern void power4_idle(void);
 extern void ppc6xx_idle(void);
+/* this one is for CPU hotplug (e.g. powermac) */
+extern void power4_idle_irqs_softdisabled(void);
 
 /*
  * ppc_md contains a copy of the machine description structure for the
