Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E7F042C02FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 08:07:49 +1100 (EST)
Received: by mail-ie0-f170.google.com with SMTP id rd18so110856iec.29
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Mar 2014 13:07:46 -0800 (PST)
Subject: [PATCH 2/2] sparc64: Remove unused sparc64_multi_core
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 04 Mar 2014 14:07:44 -0700
Message-ID: <20140304210744.16893.75929.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove sparc64_multi_core because it's not used any more.

It was added by a2f9f6bbb30e ("Fix {mc,smt}_capable()"), and the last uses
were removed by e637d96bf462 ("sched: Remove unused mc_capable() and
smt_capable()").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/include/asm/smp_64.h |    1 -
 arch/sparc/kernel/mdesc.c       |    4 ----
 arch/sparc/kernel/prom_64.c     |    3 ---
 arch/sparc/kernel/smp_64.c      |    2 --
 4 files changed, 10 deletions(-)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index dd3bef4b9896..05710393959f 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -32,7 +32,6 @@
 
 DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
 extern cpumask_t cpu_core_map[NR_CPUS];
-extern int sparc64_multi_core;
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index b90bf23e3aab..a1a4400d4025 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -896,10 +896,6 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
 
 	mdesc_iterate_over_cpus(fill_in_one_cpu, NULL, mask);
 
-#ifdef CONFIG_SMP
-	sparc64_multi_core = 1;
-#endif
-
 	hp = mdesc_grab();
 
 	set_core_ids(hp);
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 6b39125eb927..9a690d39c01b 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -555,9 +555,6 @@ static void *fill_in_one_cpu(struct device_node *dp, int cpuid, int arg)
 
 		cpu_data(cpuid).core_id = portid + 1;
 		cpu_data(cpuid).proc_id = portid;
-#ifdef CONFIG_SMP
-		sparc64_multi_core = 1;
-#endif
 	} else {
 		cpu_data(cpuid).dcache_size =
 			of_getintprop_default(dp, "dcache-size", 16 * 1024);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index b085311dcd0e..9781048161ab 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -53,8 +53,6 @@
 
 #include "cpumap.h"
 
-int sparc64_multi_core __read_mostly;
-
 DEFINE_PER_CPU(cpumask_t, cpu_sibling_map) = CPU_MASK_NONE;
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly =
 	{ [0 ... NR_CPUS-1] = CPU_MASK_NONE };
