Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4521B6F0B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:39 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286X2Ww021853
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:33:02 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bcHP1671324
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bcIo005124
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/18] powerpc/smp: Remove unused generic_cpu_enable()
Date: Tue,  8 Mar 2011 17:37:16 +1100
Message-Id: <1299566250-10516-5-git-send-email-benh@kernel.crashing.org>
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

Nobody uses it, besides we should always use the normal __cpu_up
path anyways

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/smp.h |    1 -
 arch/powerpc/kernel/smp.c      |   22 ----------------------
 2 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 1de0e97..a629b6f 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -43,7 +43,6 @@ DECLARE_PER_CPU(unsigned int, cpu_pvr);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void fixup_irqs(const struct cpumask *map);
 int generic_cpu_disable(void);
-int generic_cpu_enable(unsigned int cpu);
 void generic_cpu_die(unsigned int cpu);
 void generic_mach_cpu_die(void);
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3c0fab5..19d0c25 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -322,28 +322,6 @@ int generic_cpu_disable(void)
 	return 0;
 }
 
-int generic_cpu_enable(unsigned int cpu)
-{
-	/* Do the normal bootup if we haven't
-	 * already bootstrapped. */
-	if (system_state != SYSTEM_RUNNING)
-		return -ENOSYS;
-
-	/* get the target out of it's holding state */
-	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
-	smp_wmb();
-
-	while (!cpu_online(cpu))
-		cpu_relax();
-
-#ifdef CONFIG_PPC64
-	fixup_irqs(cpu_online_mask);
-	/* counter the irq disable in fixup_irqs */
-	local_irq_enable();
-#endif
-	return 0;
-}
-
 void generic_cpu_die(unsigned int cpu)
 {
 	int i;
-- 
1.7.1
