Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2621B6EEB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:39 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286W64l023930
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:32:06 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bcBP2506888
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bcj6005121
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/18] powerpc/smp: Fix generic_mach_cpu_die()
Date: Tue,  8 Mar 2011 17:37:15 +1100
Message-Id: <1299566250-10516-4-git-send-email-benh@kernel.crashing.org>
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

This is used by some "soft" hotplug implementations. I needs to
call idle_task_exit() when the CPU is going away, and we remove
the now no-longer needed set_cpu_online() and local_irq_enable()
which are handled by the return to start_secondary

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/smp.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 1c9956c..3c0fab5 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -362,14 +362,13 @@ void generic_mach_cpu_die(void)
 	unsigned int cpu;
 
 	local_irq_disable();
+	idle_task_exit();
 	cpu = smp_processor_id();
 	printk(KERN_DEBUG "CPU%d offline\n", cpu);
 	__get_cpu_var(cpu_state) = CPU_DEAD;
 	smp_wmb();
 	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
 		cpu_relax();
-	set_cpu_online(cpu, true);
-	local_irq_enable();
 }
 #endif
 
-- 
1.7.1
