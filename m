Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18023.64811.643218.556485@cargo.ozlabs.ibm.com>
Date: Thu, 7 Jun 2007 22:42:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix per-cpu allocation on oldworld SMP powermacs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The per-cpu area(a) for the secondary CPU(s) isn't getting allocated
on old SMP powermacs that don't have the secondary CPU(s) listed in
the device tree, as per-cpu areas are now only allocated for CPUs in
the cpu_possible_map, and we aren't setting the bits for the secondary
CPU(s) until smp_prepare_cpus(), which is after per-cpu allocation.
Therefore this sets the bits for CPUs 1..3 in cpu_possible_map in
pmac_setup_arch, so they get per-cpu data allocated.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 07b1c4e..c519b2a 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -363,8 +363,19 @@ static void __init pmac_setup_arch(void)
 		smp_ops = &core99_smp_ops;
 	}
 #ifdef CONFIG_PPC32
-	else
+	else {
+		/*
+		 * We have to set bits in cpu_possible_map here since the
+		 * secondary CPU(s) aren't in the device tree, and
+		 * setup_per_cpu_areas only allocates per-cpu data for
+		 * CPUs in the cpu_possible_map.
+		 */
+		int cpu;
+
+		for (cpu = 1; cpu < 4 && cpu < NR_CPUS; ++cpu)
+			cpu_set(cpu, cpu_possible_map);
 		smp_ops = &psurge_smp_ops;
+	}
 #endif
 #endif /* CONFIG_SMP */
 
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 686ed82..cb2d894 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -317,7 +317,6 @@ static int __init smp_psurge_probe(void)
 		ncpus = NR_CPUS;
 	for (i = 1; i < ncpus ; ++i) {
 		cpu_set(i, cpu_present_map);
-		cpu_set(i, cpu_possible_map);
 		set_hard_smp_processor_id(i, i);
 	}
 
