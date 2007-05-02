Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 988D2DE00F
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 18:40:32 +1000 (EST)
Subject: [PATCH v2] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17976.28170.695715.416339@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 02 May 2007 22:33:51 +0200
Message-Id: <1178138031.13233.69.camel@johannes.berg>
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
 arch/powerpc/kernel/idle_power4.S       |   21 ++++++++++++
 arch/powerpc/platforms/powermac/setup.c |   52 ++++++++++++++++++++++++++++++--
 arch/powerpc/platforms/powermac/smp.c   |   12 ++++++-
 include/asm-powerpc/machdep.h           |    1 
 4 files changed, 82 insertions(+), 4 deletions(-)

--- wireless-dev.orig/arch/powerpc/platforms/powermac/smp.c	2007-05-02 16:30:42.149177080 +0200
+++ wireless-dev/arch/powerpc/platforms/powermac/smp.c	2007-05-02 16:32:07.629177080 +0200
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
--- wireless-dev.orig/arch/powerpc/platforms/powermac/setup.c	2007-05-02 16:30:42.199177080 +0200
+++ wireless-dev/arch/powerpc/platforms/powermac/setup.c	2007-05-02 21:20:43.239175543 +0200
@@ -444,6 +444,9 @@ static int initializing = 1;
 static int pmac_late_init(void)
 {
 	initializing = 0;
+	/* this is udbg (which is __init) and we can later use it during
+	 * cpu hotplug (in smp_core99_kick_cpu) */
+	ppc_md.progress = NULL;
 	return 0;
 }
 
@@ -661,7 +664,52 @@ static int pmac_pci_probe_mode(struct pc
 		return PCI_PROBE_NORMAL;
 	return PCI_PROBE_DEVTREE;
 }
-#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+/* access per cpu vars from generic smp.c */
+DECLARE_PER_CPU(int, cpu_state);
+
+static void pmac_cpu_die(void)
+{
+	/*
+	 * turn off as much as possible, we'll be
+	 * kicked out as this will only be invoked
+	 * on core99 platforms for now ...
+	 */
+
+	printk(KERN_INFO "CPU#%d offline\n", smp_processor_id());
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+	smp_wmb();
+
+	/*
+	 * during the path that leads here preemption is disabled,
+	 * reenable it now so that when coming up preempt count is
+	 * zero correctly
+	 */
+	preempt_enable();
+
+	/*
+	 * hard-disable interrupts for the non-NAP case, the NAP code
+	 * needs to re-enable interrupts (but soft-disables them)
+	 */
+	hard_irq_disable();
+
+	while (1) {
+		/* let's not take timer interrupts too often ... */
+		set_dec(0x7fffffff);
+
+		/* should always be true at this point */
+		if (cpu_has_feature(CPU_FTR_CAN_NAP))
+			power4_cpu_offline_powersave();
+		else {
+			HMT_low();
+			HMT_very_low();
+		}
+	}
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+#endif /* CONFIG_PPC64 */
 
 define_machine(powermac) {
 	.name			= "PowerMac",
@@ -698,6 +746,6 @@ define_machine(powermac) {
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		= generic_mach_cpu_die,
+	.cpu_die		= pmac_cpu_die,
 #endif
 };
--- wireless-dev.orig/arch/powerpc/kernel/idle_power4.S	2007-05-02 16:30:42.229177080 +0200
+++ wireless-dev/arch/powerpc/kernel/idle_power4.S	2007-05-02 16:47:02.219177080 +0200
@@ -53,3 +53,24 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	isync
 	b	1b
 
+_GLOBAL(power4_cpu_offline_powersave)
+	/* Go to NAP now */
+	mfmsr	r7
+	rldicl	r0,r7,48,1
+	rotldi	r0,r0,16
+	mtmsrd	r0,1			/* hard-disable interrupts */
+	li	r0,1
+	li	r6,0
+	stb	r0,PACAHARDIRQEN(r13)	/* we'll hard-enable shortly */
+	stb	r6,PACASOFTIRQEN(r13)	/* soft-disable irqs */
+BEGIN_FTR_SECTION
+	DSSALL
+	sync
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+	ori	r7,r7,MSR_EE
+	oris	r7,r7,MSR_POW@h
+	sync
+	isync
+	mtmsrd	r7
+	isync
+	blr
--- wireless-dev.orig/include/asm-powerpc/machdep.h	2007-05-02 16:30:42.299177080 +0200
+++ wireless-dev/include/asm-powerpc/machdep.h	2007-05-02 21:20:10.449175543 +0200
@@ -248,6 +248,7 @@ struct machdep_calls {
 };
 
 extern void power4_idle(void);
+extern void power4_cpu_offline_powersave(void);
 extern void ppc6xx_idle(void);
 
 /*
