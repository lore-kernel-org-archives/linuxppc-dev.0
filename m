Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgBw91K1VzF0p4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 04:08:57 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id k8so5278209pli.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 09:08:57 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 08/12] powerpc/setup: cpu_to_phys_id array
Date: Tue, 13 Feb 2018 03:08:18 +1000
Message-Id: <20180212170822.14612-9-npiggin@gmail.com>
In-Reply-To: <20180212170822.14612-1-npiggin@gmail.com>
References: <20180212170822.14612-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Build an array that finds hardware CPU number from logical CPU
number in firmware CPU discovery. Use that rather than setting
paca of other CPUs directly, to begin with. Subsequent patch will
not have pacas allocated at this point.
---
 arch/powerpc/include/asm/smp.h     |  1 +
 arch/powerpc/kernel/prom.c         |  9 ++++++++-
 arch/powerpc/kernel/setup-common.c | 25 ++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index ec7b299350d9..cfecfee1194b 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -31,6 +31,7 @@
 
 extern int boot_cpuid;
 extern int spinning_secondaries;
+extern u32 *cpu_to_phys_id;
 
 extern void cpu_die(void);
 extern int cpu_to_chip_id(int cpu);
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4dffef947b8a..6b29eb1d06f4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -872,7 +872,14 @@ int cpu_to_chip_id(int cpu)
 }
 EXPORT_SYMBOL(cpu_to_chip_id);
 
-bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+bool arch_match_ucpu_phys_id(int cpu, u64 phys_id)
 {
+	/*
+	 * Early firmware scanning must use this rather than
+	 * get_hard_smp_processor_id because we don't have pacas allocated
+	 * until memory topology is discovered.
+	 */
+	if (cpu_to_phys_id != NULL)
+		return (int)phys_id == cpu_to_phys_id[cpu];
 	return (int)phys_id == get_hard_smp_processor_id(cpu);
 }
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index f8a6b8ad13b4..169d7e730aa4 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -437,6 +437,8 @@ static void __init cpu_init_thread_core_maps(int tpc)
 }
 
 
+u32 *cpu_to_phys_id = NULL;
+
 /**
  * setup_cpu_maps - initialize the following cpu maps:
  *                  cpu_possible_mask
@@ -463,6 +465,10 @@ void __init smp_setup_cpu_maps(void)
 
 	DBG("smp_setup_cpu_maps()\n");
 
+	cpu_to_phys_id = __va(memblock_alloc(nr_cpu_ids * sizeof(u32),
+							__alignof__(u32)));
+	memset(cpu_to_phys_id, 0, nr_cpu_ids * sizeof(u32));
+
 	for_each_node_by_type(dn, "cpu") {
 		const __be32 *intserv;
 		__be32 cpu_be;
@@ -480,6 +486,7 @@ void __init smp_setup_cpu_maps(void)
 			intserv = of_get_property(dn, "reg", &len);
 			if (!intserv) {
 				cpu_be = cpu_to_be32(cpu);
+				/* XXX: what is this? uninitialized?? */
 				intserv = &cpu_be;	/* assume logical == phys */
 				len = 4;
 			}
@@ -499,8 +506,8 @@ void __init smp_setup_cpu_maps(void)
 						"enable-method", "spin-table");
 
 			set_cpu_present(cpu, avail);
-			set_hard_smp_processor_id(cpu, be32_to_cpu(intserv[j]));
 			set_cpu_possible(cpu, true);
+			cpu_to_phys_id[cpu] = be32_to_cpu(intserv[j]);
 			cpu++;
 		}
 
@@ -835,6 +842,22 @@ static __init void print_system_info(void)
 	pr_info("-----------------------------------------------------\n");
 }
 
+#ifdef CONFIG_SMP
+static void smp_setup_pacas(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		set_hard_smp_processor_id(cpu, cpu_to_phys_id[cpu]);
+	}
+
+	memblock_free(__pa(cpu_to_phys_id), nr_cpu_ids * sizeof(u32));
+	cpu_to_phys_id = NULL;
+}
+#endif
+
 /*
  * Called into from start_kernel this initializes memblock, which is used
  * to manage page allocation until mem_init is called.
-- 
2.16.1
