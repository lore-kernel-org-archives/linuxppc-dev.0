Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYYcX0blDzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 11:49:48 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 67so585689pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 16:49:47 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 4/5] powerpc/smp: add cpu_cache_mask
Date: Thu,  2 Mar 2017 11:49:19 +1100
Message-Id: <20170302004920.21948-4-oohall@gmail.com>
In-Reply-To: <20170302004920.21948-1-oohall@gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Traditionally we have only ever tracked which CPUs are in the same core
(cpu_sibling_mask) and on the same die (cpu_core_mask). For Power9 we
need to be aware of which CPUs share cache with each other so this patch
adds cpu_cache_mask and the underlying cpu_cache_map variable to track
this.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/smp.h | 6 ++++++
 arch/powerpc/kernel/smp.c      | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 32db16d2e7ad..a7fc3a105d61 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -94,6 +94,7 @@ static inline void set_hard_smp_processor_id(int cpu, int phys)
 #endif
 
 DECLARE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DECLARE_PER_CPU(cpumask_var_t, cpu_cache_map);
 DECLARE_PER_CPU(cpumask_var_t, cpu_core_map);
 
 static inline struct cpumask *cpu_sibling_mask(int cpu)
@@ -106,6 +107,11 @@ static inline struct cpumask *cpu_core_mask(int cpu)
 	return per_cpu(cpu_core_map, cpu);
 }
 
+static inline struct cpumask *cpu_cache_mask(int cpu)
+{
+	return per_cpu(cpu_cache_map, cpu);
+}
+
 extern int cpu_to_core_id(int cpu);
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3922cace927e..5571f30ff72d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -72,9 +72,11 @@ static DEFINE_PER_CPU(int, cpu_state) = { 0 };
 struct thread_info *secondary_ti;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DEFINE_PER_CPU(cpumask_var_t, cpu_cache_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_core_map);
 
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
+EXPORT_PER_CPU_SYMBOL(cpu_cache_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 
 /* SMP operations for this machine */
@@ -415,6 +417,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(cpu) {
 		zalloc_cpumask_var_node(&per_cpu(cpu_sibling_map, cpu),
 					GFP_KERNEL, cpu_to_node(cpu));
+		zalloc_cpumask_var_node(&per_cpu(cpu_cache_map, cpu),
+					GFP_KERNEL, cpu_to_node(cpu));
 		zalloc_cpumask_var_node(&per_cpu(cpu_core_map, cpu),
 					GFP_KERNEL, cpu_to_node(cpu));
 		/*
@@ -428,6 +432,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
+	cpumask_set_cpu(boot_cpuid, cpu_cache_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
 
 	if (smp_ops && smp_ops->probe)
-- 
2.9.3
