Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68048B6EEB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286Xq93024941
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:33:52 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bd732302038
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bcsC005134
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/18] powerpc/pmac/smp: Fix 32-bit PowerMac cpu_die
Date: Tue,  8 Mar 2011 17:37:18 +1100
Message-Id: <1299566250-10516-7-git-send-email-benh@kernel.crashing.org>
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

Use generic cpu_state, call idle_task_exit() properly, and
remove smp_core99_cpu_die() which isn't useful, the generic
function does the job just fine.
---
 arch/powerpc/include/asm/smp.h        |    1 +
 arch/powerpc/platforms/powermac/smp.c |   25 +++++--------------------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index a629b6f..9fe5597 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -45,6 +45,7 @@ extern void fixup_irqs(const struct cpumask *map);
 int generic_cpu_disable(void);
 void generic_cpu_die(unsigned int cpu);
 void generic_mach_cpu_die(void);
+DECLARE_PER_CPU(int, cpu_state);
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index ebd2b7e..e0ac7bb 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -880,31 +880,17 @@ int smp_core99_cpu_disable(void)
 	return 0;
 }
 
-static int cpu_dead[NR_CPUS];
-
 void pmac32_cpu_die(void)
 {
 	local_irq_disable();
-	cpu_dead[smp_processor_id()] = 1;
+	idle_task_exit();
+	printk(KERN_DEBUG "CPU%d offline\n", smp_processor_id());
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+	smp_wmb();
 	mb();
 	low_cpu_die();
 }
 
-void smp_core99_cpu_die(unsigned int cpu)
-{
-	int timeout;
-
-	timeout = 1000;
-	while (!cpu_dead[cpu]) {
-		if (--timeout == 0) {
-			printk("CPU %u refused to die!\n", cpu);
-			break;
-		}
-		msleep(1);
-	}
-	cpu_dead[cpu] = 0;
-}
-
 #endif /* CONFIG_HOTPLUG_CPU && CONFIG_PP32 */
 
 /* Core99 Macs (dual G4s and G5s) */
@@ -918,12 +904,11 @@ struct smp_ops_t core99_smp_ops = {
 #if defined(CONFIG_HOTPLUG_CPU)
 # if defined(CONFIG_PPC32)
 	.cpu_disable	= smp_core99_cpu_disable,
-	.cpu_die	= smp_core99_cpu_die,
 # endif
 # if defined(CONFIG_PPC64)
 	.cpu_disable	= generic_cpu_disable,
-	.cpu_die	= generic_cpu_die,
 # endif
+	.cpu_die	= generic_cpu_die,
 #endif
 };
 
-- 
1.7.1
