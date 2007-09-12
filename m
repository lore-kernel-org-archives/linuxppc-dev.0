Return-Path: <travis@sgi.com>
Received: from relay.sgi.com (netops-testserver-4-out.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id D3790DDE0C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 11:56:49 +1000 (EST)
Message-Id: <20070912015647.486500682@sgi.com>
References: <20070912015644.927677070@sgi.com>
Date: Tue, 11 Sep 2007 18:56:53 -0700
From: travis@sgi.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 09/10] ppc64: Convert cpu_sibling_map to a per_cpu data array
	(v3)
Cc: linux-mm@kvack.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert cpu_sibling_map to a per_cpu cpumask_t array for the ppc64
architecture.  This fixes build errors in block/blktrace.c and
kernel/sched.c when CONFIG_SCHED_SMT is defined.

Note: these changes have not been built nor tested.

Signed-off-by: Mike Travis <travis@sgi.com>
---
 arch/powerpc/kernel/setup-common.c        |    4 ++--
 arch/powerpc/kernel/smp.c                 |    4 ++--
 arch/powerpc/platforms/cell/cbe_cpufreq.c |    2 +-
 include/asm-powerpc/smp.h                 |    4 +++-
 include/asm-powerpc/topology.h            |    2 +-
 5 files changed, 9 insertions(+), 7 deletions(-)

--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -415,9 +415,9 @@
 	 * Do the sibling map; assume only two threads per processor.
 	 */
 	for_each_possible_cpu(cpu) {
-		cpu_set(cpu, cpu_sibling_map[cpu]);
+		cpu_set(cpu, cpu_sibling_map(cpu));
 		if (cpu_has_feature(CPU_FTR_SMT))
-			cpu_set(cpu ^ 0x1, cpu_sibling_map[cpu]);
+			cpu_set(cpu ^ 0x1, cpu_sibling_map(cpu));
 	}
 
 	vdso_data->processorCount = num_present_cpus();
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -61,11 +61,11 @@
 
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
 cpumask_t cpu_online_map = CPU_MASK_NONE;
-cpumask_t cpu_sibling_map[NR_CPUS] = { [0 ... NR_CPUS-1] = CPU_MASK_NONE };
+DEFINE_PER_CPU(cpumask_t, cpu_sibling_map) = CPU_MASK_NONE;
 
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_possible_map);
-EXPORT_SYMBOL(cpu_sibling_map);
+EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 
 /* SMP operations for this machine */
 struct smp_ops_t *smp_ops;
--- a/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ b/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -119,7 +119,7 @@
 	policy->cur = cbe_freqs[cur_pmode].frequency;
 
 #ifdef CONFIG_SMP
-	policy->cpus = cpu_sibling_map[policy->cpu];
+	policy->cpus = cpu_sibling_map(policy->cpu);
 #endif
 
 	cpufreq_frequency_table_get_attr(cbe_freqs, policy->cpu);
--- a/include/asm-powerpc/smp.h
+++ b/include/asm-powerpc/smp.h
@@ -25,6 +25,7 @@
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
+#include <asm/percpu.h>
 #endif
 
 extern int boot_cpuid;
@@ -58,7 +59,8 @@
 					(smp_hw_index[(cpu)] = (phys))
 #endif
 
-extern cpumask_t cpu_sibling_map[NR_CPUS];
+DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
+#define cpu_sibling_map(cpu) per_cpu(cpu_sibling_map, cpu)
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  *
--- a/include/asm-powerpc/topology.h
+++ b/include/asm-powerpc/topology.h
@@ -108,7 +108,7 @@
 #ifdef CONFIG_PPC64
 #include <asm/smp.h>
 
-#define topology_thread_siblings(cpu)	(cpu_sibling_map[cpu])
+#define topology_thread_siblings(cpu)	(cpu_sibling_map(cpu))
 #endif
 #endif
 

-- 
