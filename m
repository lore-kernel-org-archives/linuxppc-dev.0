Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6027BB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 05:21:17 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1E6DDDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2009 05:21:16 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Fix SMP compile error and allow NULL for smp_ops
Date: Tue,  8 Sep 2009 14:21:08 -0500
Message-Id: <1252437668-28508-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following commit introduced a compile error since it removed
the implementation of smp_85xx_basic_setup:

commit 77c0a700c1c292edafa11c1e52821ce4636f81b0
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Fri Aug 28 14:25:04 2009 +1000

    powerpc: Properly start decrementer on BookE secondary CPUs

Make it so that smp_ops probe() and setup_cpu() can be set to NULL.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/smp.c         |   10 +++++++---
 arch/powerpc/platforms/85xx/smp.c |   13 +++----------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 96f107c..d387b39 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -269,7 +269,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	cpu_callin_map[boot_cpuid] = 1;
 
 	if (smp_ops)
-		max_cpus = smp_ops->probe();
+		if (smp_ops->probe)
+			max_cpus = smp_ops->probe();
+		else
+			max_cpus = NR_CPUS;
 	else
 		max_cpus = 1;
  
@@ -493,7 +496,8 @@ int __devinit start_secondary(void *unused)
 	preempt_disable();
 	cpu_callin_map[cpu] = 1;
 
-	smp_ops->setup_cpu(cpu);
+	if (smp_ops->setup_cpu)
+		smp_ops->setup_cpu(cpu);
 	if (smp_ops->take_timebase)
 		smp_ops->take_timebase();
 
@@ -556,7 +560,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	old_mask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(boot_cpuid));
 	
-	if (smp_ops)
+	if (smp_ops && smp_ops->setup_cpu)
 		smp_ops->setup_cpu(boot_cpuid);
 
 	set_cpus_allowed(current, old_mask);
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 94f901d..d3cf357 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -85,28 +85,21 @@ smp_85xx_setup_cpu(int cpu_nr)
 }
 
 struct smp_ops_t smp_85xx_ops = {
+	.message_pass = NULL,
+	.probe = NULL,
 	.kick_cpu = smp_85xx_kick_cpu,
+	.setup_cpu = NULL,
 };
 
-static int __init smp_dummy_probe(void)
-{
-	return NR_CPUS;
-}
-
 void __init mpc85xx_smp_init(void)
 {
 	struct device_node *np;
 
-	smp_85xx_ops.message_pass = NULL;
-
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (np) {
 		smp_85xx_ops.probe = smp_mpic_probe;
 		smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
 		smp_85xx_ops.message_pass = smp_mpic_message_pass;
-	} else {
-		smp_85xx_ops.probe = smp_dummy_probe;
-		smp_85xx_ops.setup_cpu = smp_85xx_basic_setup;
 	}
 
 	if (cpu_has_feature(CPU_FTR_DBELL))
-- 
1.6.0.6
