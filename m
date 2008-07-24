Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 75A9DDDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 09:09:22 +1000 (EST)
Date: Thu, 24 Jul 2008 18:09:13 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Update cpu_sibling_maps dynamically
Message-ID: <20080724230913.GH9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The per-cpu cpu_sibling_maps get out of sync if CPUs are
onlined/offlined at runtime.  I don't believe this can cause any
oopses, but it does cause incorrect information to be displayed by
/sys/devices/system/cpu/cpu*/topology/thread_siblings.

Rather doing one initialization pass over all CPUs at boot, update the
maps at cpu online/offline time.

Note: while this is a bug fix, it is also a behavior change -- the
thread_siblings attribute now reflects only online siblings, whereas
it would display offline siblings before.  The new behavior matches
that of x86.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/setup-common.c |   24 ------------------------
 arch/powerpc/kernel/setup_64.c     |    3 ---
 arch/powerpc/kernel/smp.c          |   32 +++++++++++++++++++++++++++++---
 3 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 61a3f41..9cc5a52 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -367,7 +367,6 @@ static void __init cpu_init_thread_core_maps(int tpc)
  * setup_cpu_maps - initialize the following cpu maps:
  *                  cpu_possible_map
  *                  cpu_present_map
- *                  cpu_sibling_map
  *
  * Having the possible map set up early allows us to restrict allocations
  * of things like irqstacks to num_possible_cpus() rather than NR_CPUS.
@@ -475,29 +474,6 @@ void __init smp_setup_cpu_maps(void)
 	 */
 	cpu_init_thread_core_maps(nthreads);
 }
-
-/*
- * Being that cpu_sibling_map is now a per_cpu array, then it cannot
- * be initialized until the per_cpu areas have been created.  This
- * function is now called from setup_per_cpu_areas().
- */
-void __init smp_setup_cpu_sibling_map(void)
-{
-#ifdef CONFIG_PPC64
-	int i, cpu, base;
-
-	for_each_possible_cpu(cpu) {
-		DBG("Sibling map for CPU %d:", cpu);
-		base = cpu_first_thread_in_core(cpu);
-		for (i = 0; i < threads_per_core; i++) {
-			cpu_set(base + i, per_cpu(cpu_sibling_map, cpu));
-			DBG(" %d", base + i);
-		}
-		DBG("\n");
-	}
-
-#endif /* CONFIG_PPC64 */
-}
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PCSPKR_PLATFORM
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 04d8de9..8b25f51 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -611,9 +611,6 @@ void __init setup_per_cpu_areas(void)
 		paca[i].data_offset = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
 	}
-
-	/* Now that per_cpu is setup, initialize cpu_sibling_map */
-	smp_setup_cpu_sibling_map();
 }
 #endif
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index f5ae9fa..3c4d07e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -41,6 +41,7 @@
 #include <asm/smp.h>
 #include <asm/time.h>
 #include <asm/machdep.h>
+#include <asm/cputhreads.h>
 #include <asm/cputable.h>
 #include <asm/system.h>
 #include <asm/mpic.h>
@@ -228,6 +229,7 @@ void __devinit smp_prepare_boot_cpu(void)
 	BUG_ON(smp_processor_id() != boot_cpuid);
 
 	cpu_set(boot_cpuid, cpu_online_map);
+	cpu_set(boot_cpuid, per_cpu(cpu_sibling_map, boot_cpuid));
 #ifdef CONFIG_PPC64
 	paca[boot_cpuid].__current = current;
 #endif
@@ -380,6 +382,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 int __devinit start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
+	int i, base;
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
@@ -400,6 +403,14 @@ int __devinit start_secondary(void *unused)
 
 	ipi_call_lock();
 	cpu_set(cpu, cpu_online_map);
+	/* Update sibling maps */
+	base = cpu_first_thread_in_core(cpu);
+	for (i = 0; i < threads_per_core; i++) {
+		if (cpu_is_offline(base + i))
+			continue;
+		cpu_set(cpu, per_cpu(cpu_sibling_map, base + i));
+		cpu_set(base + i, per_cpu(cpu_sibling_map, cpu));
+	}
 	ipi_call_unlock();
 
 	local_irq_enable();
@@ -437,10 +448,25 @@ void __init smp_cpus_done(unsigned int max_cpus)
 #ifdef CONFIG_HOTPLUG_CPU
 int __cpu_disable(void)
 {
-	if (smp_ops->cpu_disable)
-		return smp_ops->cpu_disable();
+	int cpu = smp_processor_id();
+	int base, i;
+	int err;
 
-	return -ENOSYS;
+	if (!smp_ops->cpu_disable)
+		return -ENOSYS;
+
+	err = smp_ops->cpu_disable();
+	if (err)
+		return err;
+
+	/* Update sibling maps */
+	base = cpu_first_thread_in_core(cpu);
+	for (i = 0; i < threads_per_core; i++) {
+		cpu_clear(cpu, per_cpu(cpu_sibling_map, base + i));
+		cpu_clear(base + i, per_cpu(cpu_sibling_map, cpu));
+	}
+
+	return 0;
 }
 
 void __cpu_die(unsigned int cpu)
-- 
1.5.6.2
