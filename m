Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7DDA6B6F12
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286WWtB019360
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:32:32 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bdQj2052142
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bcvT005139
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/18] powerpc/pmac/smp: Rename fixup_irqs() to migrate_irqs()
	and use it on ppc32
Date: Tue,  8 Mar 2011 17:37:19 +1100
Message-Id: <1299566250-10516-8-git-send-email-benh@kernel.crashing.org>
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
 arch/powerpc/include/asm/smp.h |    2 +-
 arch/powerpc/kernel/irq.c      |    3 ++-
 arch/powerpc/kernel/smp.c      |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 9fe5597..7e99771 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -41,7 +41,7 @@ extern void start_secondary_resume(void);
 DECLARE_PER_CPU(unsigned int, cpu_pvr);
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern void fixup_irqs(const struct cpumask *map);
+extern void migrate_irqs(void);
 int generic_cpu_disable(void);
 void generic_cpu_die(unsigned int cpu);
 void generic_mach_cpu_die(void);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ce557f6..cab8654 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -303,12 +303,13 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-void fixup_irqs(const struct cpumask *map)
+void migrate_irqs(void)
 {
 	struct irq_desc *desc;
 	unsigned int irq;
 	static int warned;
 	cpumask_var_t mask;
+	const struct cpumask *map = cpu_online_mask;
 
 	alloc_cpumask_var(&mask, GFP_KERNEL);
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index be7d728..f6cc5c1 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -317,8 +317,8 @@ int generic_cpu_disable(void)
 	set_cpu_online(cpu, false);
 #ifdef CONFIG_PPC64
 	vdso_data->processorCount--;
-	fixup_irqs(cpu_online_mask);
 #endif
+	migrate_irqs();
 	return 0;
 }
 
-- 
1.7.1
