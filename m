Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgmCM2QhqzF11p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 02:09:03 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id x2so2776367plr.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:09:03 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 08/14] powerpc/setup: cpu_to_phys_id array
Date: Wed, 14 Feb 2018 01:08:18 +1000
Message-Id: <20180213150824.27689-9-npiggin@gmail.com>
In-Reply-To: <20180213150824.27689-1-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
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
 arch/powerpc/kernel/prom.c         |  7 +++++++
 arch/powerpc/kernel/setup-common.c | 15 ++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

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
index 4dffef947b8a..5979e34ba90e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -874,5 +874,12 @@ EXPORT_SYMBOL(cpu_to_chip_id);
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
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
index 9eaf26318d20..bd79a5644c78 100644
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
 
@@ -570,6 +577,12 @@ void __init smp_setup_cpu_maps(void)
 	setup_nr_cpu_ids();
 
 	free_unused_pacas();
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		set_hard_smp_processor_id(cpu, cpu_to_phys_id[cpu]);
+	}
 }
 #endif /* CONFIG_SMP */
 
-- 
2.16.1
