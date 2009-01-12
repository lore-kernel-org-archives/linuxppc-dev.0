Return-Path: <travis@cthulhu.engr.sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id 11270DE183
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 09:05:23 +1100 (EST)
Message-Id: <20090112220520.566552000@polaris-admin.engr.sgi.com>
References: <20090112220519.566749000@polaris-admin.engr.sgi.com>
Date: Mon, 12 Jan 2009 14:05:26 -0800
From: Mike Travis <travis@sgi.com>
To: Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 7/8] powerpc irq: update powerpc for new irq_desc
Cc: Jack Steiner <steiner@sgi.com>, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: cleanup, update to new cpumask API

Irq_desc.affinity and irq_desc.pending_mask are now cpumask_var_t's
so access to them should be using the new cpumask API.

Signed-off-by: Mike Travis <travis@sgi.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: <linuxppc-dev@ozlabs.org>
---
 arch/powerpc/kernel/irq.c             |    2 +-
 arch/powerpc/platforms/pseries/xics.c |    5 +++--
 arch/powerpc/sysdev/mpic.c            |    3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6-for-ingo.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6-for-ingo/arch/powerpc/kernel/irq.c
@@ -231,7 +231,7 @@ void fixup_irqs(cpumask_t map)
 		if (irq_desc[irq].status & IRQ_PER_CPU)
 			continue;
 
-		cpus_and(mask, irq_desc[irq].affinity, map);
+		cpumask_and(&mask, irq_desc[irq].affinity, &map);
 		if (any_online_cpu(mask) == NR_CPUS) {
 			printk("Breaking affinity for irq %i\n", irq);
 			mask = map;
--- linux-2.6-for-ingo.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6-for-ingo/arch/powerpc/platforms/pseries/xics.c
@@ -153,9 +153,10 @@ static int get_irq_server(unsigned int v
 {
 	int server;
 	/* For the moment only implement delivery to all cpus or one cpu */
-	cpumask_t cpumask = irq_desc[virq].affinity;
+	cpumask_t cpumask;
 	cpumask_t tmp = CPU_MASK_NONE;
 
+	cpumask_copy(&cpumask, irq_desc[virq].affinity);
 	if (!distribute_irqs)
 		return default_server;
 
@@ -869,7 +870,7 @@ void xics_migrate_irqs_away(void)
 		       virq, cpu);
 
 		/* Reset affinity to all cpus */
-		irq_desc[virq].affinity = CPU_MASK_ALL;
+		cpumask_setall(irq_desc[virq].affinity);
 		desc->chip->set_affinity(virq, cpu_all_mask);
 unlock:
 		spin_unlock_irqrestore(&desc->lock, flags);
--- linux-2.6-for-ingo.orig/arch/powerpc/sysdev/mpic.c
+++ linux-2.6-for-ingo/arch/powerpc/sysdev/mpic.c
@@ -566,9 +566,10 @@ static void __init mpic_scan_ht_pics(str
 #ifdef CONFIG_SMP
 static int irq_choose_cpu(unsigned int virt_irq)
 {
-	cpumask_t mask = irq_desc[virt_irq].affinity;
+	cpumask_t mask;
 	int cpuid;
 
+	cpumask_copy(&mask, irq_desc[virt_irq].affinity);
 	if (cpus_equal(mask, CPU_MASK_ALL)) {
 		static int irq_rover;
 		static DEFINE_SPINLOCK(irq_rover_lock);

-- 
