Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgmCQ2PsNzF1P0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 02:09:06 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id p5so6752191plo.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:09:06 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 09/14] powerpc/64: defer paca allocation until memory topology
 is discovered
Date: Wed, 14 Feb 2018 01:08:19 +1000
Message-Id: <20180213150824.27689-10-npiggin@gmail.com>
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

---
 arch/powerpc/include/asm/paca.h    |  3 +-
 arch/powerpc/kernel/paca.c         | 90 ++++++++++++--------------------------
 arch/powerpc/kernel/prom.c         |  5 ++-
 arch/powerpc/kernel/setup-common.c | 24 +++++++---
 4 files changed, 51 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index f266b0a7be95..407a8076edd7 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -252,7 +252,8 @@ extern void copy_mm_to_paca(struct mm_struct *mm);
 extern struct paca_struct **paca_ptrs;
 extern void initialise_paca(struct paca_struct *new_paca, int cpu);
 extern void setup_paca(struct paca_struct *new_paca);
-extern void allocate_pacas(void);
+extern void allocate_paca_ptrs(void);
+extern void allocate_paca(int cpu);
 extern void free_unused_pacas(void);
 
 #else /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index e560072f122b..12d329467631 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -57,16 +57,6 @@ static struct lppaca * __init new_lppaca(int cpu, unsigned long limit)
 
 	return lp;
 }
-
-static void __init free_lppaca(struct lppaca *lp)
-{
-	size_t size = 0x400;
-
-	if (early_cpu_has_feature(CPU_FTR_HVMODE))
-		return;
-
-	memblock_free(__pa(lp), size);
-}
 #endif /* CONFIG_PPC_BOOK3S */
 
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -169,12 +159,24 @@ void setup_paca(struct paca_struct *new_paca)
 
 static int __initdata paca_nr_cpu_ids;
 static int __initdata paca_ptrs_size;
+static int __initdata paca_struct_size;
+
+void __init allocate_paca_ptrs(void)
+{
+	paca_nr_cpu_ids = nr_cpu_ids;
+
+	paca_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
+	paca_ptrs = __va(memblock_alloc(paca_ptrs_size, 0));
+	memset(paca_ptrs, 0x88, paca_ptrs_size);
+}
 
-void __init allocate_pacas(void)
+void __init allocate_paca(int cpu)
 {
 	u64 limit;
-	unsigned long size = 0;
-	int cpu;
+	unsigned long pa;
+	struct paca_struct *paca;
+
+	BUG_ON(cpu >= paca_nr_cpu_ids);
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	/*
@@ -186,69 +188,30 @@ void __init allocate_pacas(void)
 	limit = ppc64_rma_size;
 #endif
 
-	paca_nr_cpu_ids = nr_cpu_ids;
-
-	paca_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
-	paca_ptrs = __va(memblock_alloc_base(paca_ptrs_size, 0, limit));
-	memset(paca_ptrs, 0, paca_ptrs_size);
-
-	size += paca_ptrs_size;
-
-	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
-		unsigned long pa;
-
-		pa = memblock_alloc_base(sizeof(struct paca_struct),
-						L1_CACHE_BYTES, limit);
-		paca_ptrs[cpu] = __va(pa);
-		memset(paca_ptrs[cpu], 0, sizeof(struct paca_struct));
-
-		size += sizeof(struct paca_struct);
-	}
-
-	printk(KERN_DEBUG "Allocated %lu bytes for %u pacas\n",
-			size, nr_cpu_ids);
-
-	/* Can't use for_each_*_cpu, as they aren't functional yet */
-	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
-		struct paca_struct *paca = paca_ptrs[cpu];
+	pa = memblock_alloc_base(sizeof(struct paca_struct),
+					L1_CACHE_BYTES, limit);
+	paca = __va(pa);
+	paca_ptrs[cpu] = paca;
+	memset(paca, 0, sizeof(struct paca_struct));
 
-		initialise_paca(paca, cpu);
+	initialise_paca(paca, cpu);
 #ifdef CONFIG_PPC_PSERIES
-		paca->lppaca_ptr = new_lppaca(cpu, limit);
+	paca->lppaca_ptr = new_lppaca(cpu, limit);
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
-		paca->slb_shadow_ptr = new_slb_shadow(cpu, limit);
+	paca->slb_shadow_ptr = new_slb_shadow(cpu, limit);
 #endif
-	}
+	paca_struct_size += sizeof(struct paca_struct);
 }
 
 void __init free_unused_pacas(void)
 {
-	unsigned long size = 0;
 	int new_ptrs_size;
-	int cpu;
-
-	for (cpu = 0; cpu < paca_nr_cpu_ids; cpu++) {
-		if (!cpu_possible(cpu)) {
-			unsigned long pa = __pa(paca_ptrs[cpu]);
-#ifdef CONFIG_PPC_PSERIES
-			free_lppaca(paca_ptrs[cpu]->lppaca_ptr);
-#endif
-			memblock_free(pa, sizeof(struct paca_struct));
-			paca_ptrs[cpu] = NULL;
-			size += sizeof(struct paca_struct);
-		}
-	}
 
 	new_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
-	if (new_ptrs_size < paca_ptrs_size) {
+	if (new_ptrs_size < paca_ptrs_size)
 		memblock_free(__pa(paca_ptrs) + new_ptrs_size,
 					paca_ptrs_size - new_ptrs_size);
-		size += paca_ptrs_size - new_ptrs_size;
-	}
-
-	if (size)
-		printk(KERN_DEBUG "Freed %lu bytes for unused pacas\n", size);
 
 	paca_nr_cpu_ids = nr_cpu_ids;
 	paca_ptrs_size = new_ptrs_size;
@@ -261,6 +224,9 @@ void __init free_unused_pacas(void)
 		paca_ptrs[boot_cpuid]->slb_shadow_ptr = NULL;
 	}
 #endif
+
+	printk(KERN_DEBUG "Allocated %u bytes for %u pacas\n",
+			paca_ptrs_size + paca_struct_size, nr_cpu_ids);
 }
 
 void copy_mm_to_paca(struct mm_struct *mm)
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5979e34ba90e..a8b6ddbb540f 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -365,7 +365,6 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	DBG("boot cpu: logical %d physical %d\n", found,
 	    be32_to_cpu(intserv[found_thread]));
 	boot_cpuid = found;
-	set_hard_smp_processor_id(found, be32_to_cpu(intserv[found_thread]));
 
 	/*
 	 * PAPR defines "logical" PVR values for cpus that
@@ -403,7 +402,9 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 		cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
 	else if (!dt_cpu_ftrs_in_use())
 		cur_cpu_spec->cpu_features |= CPU_FTR_SMT;
+	allocate_paca(boot_cpuid);
 #endif
+	set_hard_smp_processor_id(found, be32_to_cpu(intserv[found_thread]));
 
 	return 0;
 }
@@ -744,7 +745,7 @@ void __init early_init_devtree(void *params)
 	 * FIXME .. and the initrd too? */
 	move_device_tree();
 
-	allocate_pacas();
+	allocate_paca_ptrs();
 
 	DBG("Scanning CPUs ...\n");
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index bd79a5644c78..af7a47c8fe10 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -577,12 +577,6 @@ void __init smp_setup_cpu_maps(void)
 	setup_nr_cpu_ids();
 
 	free_unused_pacas();
-
-	for_each_possible_cpu(cpu) {
-		if (cpu == smp_processor_id())
-			continue;
-		set_hard_smp_processor_id(cpu, cpu_to_phys_id[cpu]);
-	}
 }
 #endif /* CONFIG_SMP */
 
@@ -848,6 +842,23 @@ static __init void print_system_info(void)
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
+		allocate_paca(cpu);
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
@@ -915,6 +926,7 @@ void __init setup_arch(char **cmdline_p)
 	 * so smp_release_cpus() does nothing for them.
 	 */
 #ifdef CONFIG_SMP
+	smp_setup_pacas();
 	smp_release_cpus();
 #endif
 
-- 
2.16.1
