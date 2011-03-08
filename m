Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 89ADCB6EEB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286bdH5009430
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:40 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bdPw2302040
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bd8r021106
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/18] powerpc/smp: Don't expose per-cpu "cpu_state" array
Date: Tue,  8 Mar 2011 17:37:27 +1100
Message-Id: <1299566250-10516-16-git-send-email-benh@kernel.crashing.org>
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

Instead, keep it static, expose an accessor and use that from
the PowerMac code. Avoids easy namespace collisions and will
make it easier to consolidate with other implementations.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/smp.h        |    2 +-
 arch/powerpc/kernel/smp.c             |    7 ++++++-
 arch/powerpc/platforms/powermac/smp.c |   12 ++++++++----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 7e99771..a902a0d 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -45,7 +45,7 @@ extern void migrate_irqs(void);
 int generic_cpu_disable(void);
 void generic_cpu_die(unsigned int cpu);
 void generic_mach_cpu_die(void);
-DECLARE_PER_CPU(int, cpu_state);
+void generic_set_cpu_dead(unsigned int cpu);
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index df37397..7beb001 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -305,7 +305,7 @@ void __devinit smp_prepare_boot_cpu(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* State of each CPU during hotplug phases */
-DEFINE_PER_CPU(int, cpu_state) = { 0 };
+static DEFINE_PER_CPU(int, cpu_state) = { 0 };
 
 int generic_cpu_disable(void)
 {
@@ -348,6 +348,11 @@ void generic_mach_cpu_die(void)
 	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
 		cpu_relax();
 }
+
+void generic_set_cpu_dead(unsigned int cpu)
+{
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+}
 #endif
 
 int __cpuinit __cpu_up(unsigned int cpu)
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 74a43c6..ce5b4f5 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -920,10 +920,12 @@ static int smp_core99_cpu_disable(void)
 
 static void pmac_cpu_die(void)
 {
+	int cpu = smp_processor_id();
+
 	local_irq_disable();
 	idle_task_exit();
-	printk(KERN_DEBUG "CPU%d offline\n", smp_processor_id());
-	__get_cpu_var(cpu_state) = CPU_DEAD;
+	pr_debug("CPU%d offline\n", cpu);
+	generic_set_cpu_dead(cpu);
 	smp_wmb();
 	mb();
 	low_cpu_die();
@@ -933,6 +935,8 @@ static void pmac_cpu_die(void)
 
 static void pmac_cpu_die(void)
 {
+	int cpu = smp_processor_id();
+
 	local_irq_disable();
 	idle_task_exit();
 
@@ -942,8 +946,8 @@ static void pmac_cpu_die(void)
 	 * on core99 platforms for now ...
 	 */
 
-	printk(KERN_INFO "CPU#%d offline\n", smp_processor_id());
-	__get_cpu_var(cpu_state) = CPU_DEAD;
+	printk(KERN_INFO "CPU#%d offline\n", cpu);
+	generic_set_cpu_dead(cpu);
 	smp_wmb();
 
 	/*
-- 
1.7.1
