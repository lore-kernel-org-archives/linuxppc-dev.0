Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 74782DDFB7
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 15:25:13 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/6] make core sibling information available to userspace
Date: Sun, 27 Jul 2008 00:24:53 -0500
Message-Id: <1217136295-18693-5-git-send-email-ntl@pobox.com>
In-Reply-To: <1217136295-18693-1-git-send-email-ntl@pobox.com>
References: <1217136295-18693-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement the notion of "core siblings" for powerpc.  This makes
/sys/devices/system/cpu/cpu*/topology/core_siblings present sensible
values, indicating online CPUs which share an L2 cache.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/smp.c      |   71 ++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/smp.h      |    1 +
 include/asm-powerpc/topology.h |    1 +
 3 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3c4d07e..e8bc6a0 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -63,10 +63,12 @@ struct thread_info *secondary_ti;
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 DEFINE_PER_CPU(cpumask_t, cpu_sibling_map) = CPU_MASK_NONE;
+DEFINE_PER_CPU(cpumask_t, cpu_core_map) = CPU_MASK_NONE;
 
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_possible_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
+EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 
 /* SMP operations for this machine */
 struct smp_ops_t *smp_ops;
@@ -230,6 +232,7 @@ void __devinit smp_prepare_boot_cpu(void)
 
 	cpu_set(boot_cpuid, cpu_online_map);
 	cpu_set(boot_cpuid, per_cpu(cpu_sibling_map, boot_cpuid));
+	cpu_set(boot_cpuid, per_cpu(cpu_core_map, boot_cpuid));
 #ifdef CONFIG_PPC64
 	paca[boot_cpuid].__current = current;
 #endif
@@ -377,11 +380,43 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	return 0;
 }
 
+/* Must be called when no change can occur to cpu_present_map,
+ * i.e. during cpu online or offline.
+ */
+static struct device_node *cpu_to_l2cache(int cpu)
+{
+	struct device_node *np;
+	const u32 *l2cache_phandle;
+
+	if (!cpu_present(cpu))
+		return NULL;
+
+	np = of_get_cpu_node(cpu, NULL);
+
+	l2cache_phandle = of_get_property(np, "l2-cache", NULL);
+
+	of_node_put(np);
+
+	if (!l2cache_phandle)
+		return NULL;
+
+	np = NULL;
+	for_each_node_by_type(np, "cache") {
+		const u32 *phandle = of_get_property(np, "ibm,phandle", NULL);
+		if (!phandle)
+			continue;
+		if (*phandle == *l2cache_phandle)
+			return np;
+	}
+
+	return NULL;
+}
 
 /* Activate a secondary processor. */
 int __devinit start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
+	struct device_node *l2_cache;
 	int i, base;
 
 	atomic_inc(&init_mm.mm_count);
@@ -410,7 +445,26 @@ int __devinit start_secondary(void *unused)
 			continue;
 		cpu_set(cpu, per_cpu(cpu_sibling_map, base + i));
 		cpu_set(base + i, per_cpu(cpu_sibling_map, cpu));
+
+		/* cpu_core_map should be a superset of
+		 * cpu_sibling_map even if we don't have cache
+		 * information, so update the former here, too.
+		 */
+		cpu_set(cpu, per_cpu(cpu_core_map, base +i));
+		cpu_set(base + i, per_cpu(cpu_core_map, cpu));
+	}
+	l2_cache = cpu_to_l2cache(cpu);
+	for_each_online_cpu(i) {
+		struct device_node *np = cpu_to_l2cache(i);
+		if (!np)
+			continue;
+		if (np == l2_cache) {
+			cpu_set(cpu, per_cpu(cpu_core_map, i));
+			cpu_set(i, per_cpu(cpu_core_map, cpu));
+		}
+		of_node_put(np);
 	}
+	of_node_put(l2_cache);
 	ipi_call_unlock();
 
 	local_irq_enable();
@@ -448,6 +502,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 #ifdef CONFIG_HOTPLUG_CPU
 int __cpu_disable(void)
 {
+	struct device_node *l2_cache;
 	int cpu = smp_processor_id();
 	int base, i;
 	int err;
@@ -464,8 +519,24 @@ int __cpu_disable(void)
 	for (i = 0; i < threads_per_core; i++) {
 		cpu_clear(cpu, per_cpu(cpu_sibling_map, base + i));
 		cpu_clear(base + i, per_cpu(cpu_sibling_map, cpu));
+		cpu_clear(cpu, per_cpu(cpu_core_map, base +i));
+		cpu_clear(base + i, per_cpu(cpu_core_map, cpu));
 	}
 
+	l2_cache = cpu_to_l2cache(cpu);
+	for_each_present_cpu(i) {
+		struct device_node *np = cpu_to_l2cache(i);
+		if (!np)
+			continue;
+		if (np == l2_cache) {
+			cpu_clear(cpu, per_cpu(cpu_core_map, i));
+			cpu_clear(i, per_cpu(cpu_core_map, cpu));
+		}
+		of_node_put(np);
+	}
+	of_node_put(l2_cache);
+
+
 	return 0;
 }
 
diff --git a/include/asm-powerpc/smp.h b/include/asm-powerpc/smp.h
index 416d4c2..32e9100 100644
--- a/include/asm-powerpc/smp.h
+++ b/include/asm-powerpc/smp.h
@@ -62,6 +62,7 @@ extern int smp_hw_index[];
 #endif
 
 DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
+DECLARE_PER_CPU(cpumask_t, cpu_core_map);
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  *
diff --git a/include/asm-powerpc/topology.h b/include/asm-powerpc/topology.h
index 100c6fb..f00e8e5 100644
--- a/include/asm-powerpc/topology.h
+++ b/include/asm-powerpc/topology.h
@@ -108,6 +108,7 @@ static inline void sysfs_remove_device_from_node(struct sys_device *dev,
 #include <asm/smp.h>
 
 #define topology_thread_siblings(cpu)	(per_cpu(cpu_sibling_map, cpu))
+#define topology_core_siblings(cpu)	(per_cpu(cpu_core_map, cpu))
 #endif
 #endif
 
-- 
1.5.6.2
