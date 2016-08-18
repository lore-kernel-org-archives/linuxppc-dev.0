Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFR3v4vDLzDr5V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 22:58:35 +1000 (AEST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 rt@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/16] powerpc: mmu nohash: Convert to hotplug state machine
Date: Thu, 18 Aug 2016 14:57:31 +0200
Message-Id: <20160818125731.27256-17-bigeasy@linutronix.de>
In-Reply-To: <20160818125731.27256-1-bigeasy@linutronix.de>
References: <20160818125731.27256-1-bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Install the callbacks via the state machine.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/mm/mmu_context_nohash.c | 54 +++++++++++++++---------------------
 include/linux/cpuhotplug.h           |  1 +
 2 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 7d95bc402dba..f7755fcbe1f8 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -369,44 +369,34 @@ void destroy_context(struct mm_struct *mm)
 }
 
 #ifdef CONFIG_SMP
-
-static int mmu_context_cpu_notify(struct notifier_block *self,
-				  unsigned long action, void *hcpu)
+static int mmu_ctx_cpu_prepare(unsigned int cpu)
 {
-	unsigned int cpu = (unsigned int)(long)hcpu;
-
 	/* We don't touch CPU 0 map, it's allocated at aboot and kept
 	 * around forever
 	 */
 	if (cpu == boot_cpuid)
-		return NOTIFY_OK;
+		return 0;
 
-	switch (action) {
-	case CPU_UP_PREPARE:
-	case CPU_UP_PREPARE_FROZEN:
-		pr_devel("MMU: Allocating stale context map for CPU %d\n", cpu);
-		stale_map[cpu] = kzalloc(CTX_MAP_SIZE, GFP_KERNEL);
-		break;
-#ifdef CONFIG_HOTPLUG_CPU
-	case CPU_UP_CANCELED:
-	case CPU_UP_CANCELED_FROZEN:
-	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
-		pr_devel("MMU: Freeing stale context map for CPU %d\n", cpu);
-		kfree(stale_map[cpu]);
-		stale_map[cpu] = NULL;
-
-		/* We also clear the cpu_vm_mask bits of CPUs going away */
-		clear_tasks_mm_cpumask(cpu);
-	break;
-#endif /* CONFIG_HOTPLUG_CPU */
-	}
-	return NOTIFY_OK;
+	pr_devel("MMU: Allocating stale context map for CPU %d\n", cpu);
+	stale_map[cpu] = kzalloc(CTX_MAP_SIZE, GFP_KERNEL);
+	return 0;
 }
 
-static struct notifier_block mmu_context_cpu_nb = {
-	.notifier_call	= mmu_context_cpu_notify,
-};
+static int mmu_ctx_cpu_dead(unsigned int cpu)
+{
+#ifdef CONFIG_HOTPLUG_CPU
+	if (cpu == boot_cpuid)
+		return 0;
+
+	pr_devel("MMU: Freeing stale context map for CPU %d\n", cpu);
+	kfree(stale_map[cpu]);
+	stale_map[cpu] = NULL;
+
+	/* We also clear the cpu_vm_mask bits of CPUs going away */
+	clear_tasks_mm_cpumask(cpu);
+#endif
+	return 0;
+}
 
 #endif /* CONFIG_SMP */
 
@@ -469,7 +459,9 @@ void __init mmu_context_init(void)
 #else
 	stale_map[boot_cpuid] = memblock_virt_alloc(CTX_MAP_SIZE, 0);
 
-	register_cpu_notifier(&mmu_context_cpu_nb);
+	cpuhp_setup_state_nocalls(CPUHP_POWER_MMU_CTX_PREPARE,
+				  "POWER_MMU_CTX_PREPARE", mmu_ctx_cpu_prepare,
+				  mmu_ctx_cpu_dead);
 #endif
 
 	printk(KERN_INFO
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 4974c9fdbf9a..92b9cf3271b2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -33,6 +33,7 @@ enum cpuhp_state {
 	CPUHP_MD_RAID5_PREPARE,
 	CPUHP_CPUIDLE_COUPLED_PREPARE,
 	CPUHP_POWER_PMAC_PREPARE,
+	CPUHP_POWER_MMU_CTX_PREPARE,
 	CPUHP_NOTIFY_PREPARE,
 	CPUHP_TIMERS_DEAD,
 	CPUHP_BRINGUP_CPU,
-- 
2.9.3
