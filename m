Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54503B6F06
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286W3gp001530
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:32:03 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bdIE1781924
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bcl7005158
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/18] powerpc/pmac/smp: Consolidate 32-bit and 64-bit
	PowerMac cpu_die in one file
Date: Tue,  8 Mar 2011 17:37:21 +1100
Message-Id: <1299566250-10516-10-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/pmac.h  |    1 -
 arch/powerpc/platforms/powermac/setup.c |   56 -----------------------------
 arch/powerpc/platforms/powermac/smp.c   |   58 +++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index f0bc08f..20468f4 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -33,7 +33,6 @@ extern void pmac_setup_pci_dma(void);
 extern void pmac_check_ht_link(void);
 
 extern void pmac_setup_smp(void);
-extern void pmac32_cpu_die(void);
 extern void low_cpu_die(void) __attribute__((noreturn));
 
 extern int pmac_nvram_init(void);
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index d5aceb7..aa45281 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -650,51 +650,6 @@ static int pmac_pci_probe_mode(struct pci_bus *bus)
 		return PCI_PROBE_NORMAL;
 	return PCI_PROBE_DEVTREE;
 }
-
-#ifdef CONFIG_HOTPLUG_CPU
-/* access per cpu vars from generic smp.c */
-DECLARE_PER_CPU(int, cpu_state);
-
-static void pmac64_cpu_die(void)
-{
-	/*
-	 * turn off as much as possible, we'll be
-	 * kicked out as this will only be invoked
-	 * on core99 platforms for now ...
-	 */
-
-	printk(KERN_INFO "CPU#%d offline\n", smp_processor_id());
-	__get_cpu_var(cpu_state) = CPU_DEAD;
-	smp_wmb();
-
-	/*
-	 * during the path that leads here preemption is disabled,
-	 * reenable it now so that when coming up preempt count is
-	 * zero correctly
-	 */
-	preempt_enable();
-
-	/*
-	 * hard-disable interrupts for the non-NAP case, the NAP code
-	 * needs to re-enable interrupts (but soft-disables them)
-	 */
-	hard_irq_disable();
-
-	while (1) {
-		/* let's not take timer interrupts too often ... */
-		set_dec(0x7fffffff);
-
-		/* should always be true at this point */
-		if (cpu_has_feature(CPU_FTR_CAN_NAP))
-			power4_cpu_offline_powersave();
-		else {
-			HMT_low();
-			HMT_very_low();
-		}
-	}
-}
-#endif /* CONFIG_HOTPLUG_CPU */
-
 #endif /* CONFIG_PPC64 */
 
 define_machine(powermac) {
@@ -726,15 +681,4 @@ define_machine(powermac) {
 	.pcibios_after_init	= pmac_pcibios_after_init,
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
-#ifdef CONFIG_HOTPLUG_CPU
-#ifdef CONFIG_PPC64
-	.cpu_die		= pmac64_cpu_die,
-#endif
-#ifdef CONFIG_PPC32
-	.cpu_die		= pmac32_cpu_die,
-#endif
-#endif
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
-	.cpu_die		= generic_mach_cpu_die,
-#endif
 };
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index eda4709..50e15b4 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -865,7 +865,7 @@ static void __devinit smp_core99_setup_cpu(int cpu_nr)
 }
 
 
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
+#ifdef CONFIG_HOTPLUG_CPU
 
 static int smp_core99_cpu_disable(void)
 {
@@ -878,7 +878,9 @@ static int smp_core99_cpu_disable(void)
 	return 0;
 }
 
-void pmac32_cpu_die(void)
+#ifdef CONFIG_PPC32
+
+static void pmac_cpu_die(void)
 {
 	local_irq_disable();
 	idle_task_exit();
@@ -889,7 +891,52 @@ void pmac32_cpu_die(void)
 	low_cpu_die();
 }
 
-#endif /* CONFIG_HOTPLUG_CPU && CONFIG_PP32 */
+#else /* CONFIG_PPC32 */
+
+static void pmac_cpu_die(void)
+{
+	local_irq_disable();
+	idle_task_exit();
+
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
+
+#endif /* else CONFIG_PPC32 */
+#endif /* CONFIG_HOTPLUG_CPU */
 
 /* Core99 Macs (dual G4s and G5s) */
 struct smp_ops_t core99_smp_ops = {
@@ -933,5 +980,10 @@ void __init pmac_setup_smp(void)
 		smp_ops = &psurge_smp_ops;
 	}
 #endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_HOTPLUG_CPU
+	ppc_md.cpu_die = pmac_cpu_die;
+#endif
 }
 
+
-- 
1.7.1
