Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgmCS5CfgzF1Q9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 02:09:08 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id p5so6752253plo.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:09:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 10/14] powerpc/64: allocate pacas per node
Date: Wed, 14 Feb 2018 01:08:20 +1000
Message-Id: <20180213150824.27689-11-npiggin@gmail.com>
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

Per-node allocations are possible on 64s with radix that does
not have the bolted SLB limitation.

Hash would be able to do the same if all CPUs had the bottom of
their node-local memory bolted as well. This is left as an
exercise for the reader.
---
 arch/powerpc/kernel/paca.c     | 41 +++++++++++++++++++++++++++++++++++------
 arch/powerpc/kernel/setup_64.c |  4 ++++
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 12d329467631..470ce21af8b5 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -20,6 +20,37 @@
 
 #include "setup.h"
 
+static void *__init alloc_paca_data(unsigned long size, unsigned long align,
+				unsigned long limit, int cpu)
+{
+	unsigned long pa;
+	int nid;
+
+	/*
+	 * boot_cpuid paca is allocated very early before cpu_to_node is up.
+	 * Set bottom-up mode, because the boot CPU should be on node-0,
+	 * which will put its paca in the right place.
+	 */
+	if (cpu == boot_cpuid) {
+		nid = -1;
+		memblock_set_bottom_up(true);
+	} else {
+		nid = early_cpu_to_node(cpu);
+	}
+
+	pa = memblock_alloc_base_nid(size, align, limit, nid, MEMBLOCK_NONE);
+	if (!pa) {
+		pa = memblock_alloc_base(size, align, limit);
+		if (!pa)
+			panic("cannot allocate paca data");
+	}
+
+	if (cpu == boot_cpuid)
+		memblock_set_bottom_up(false);
+
+	return __va(pa);
+}
+
 #ifdef CONFIG_PPC_PSERIES
 
 /*
@@ -52,7 +83,7 @@ static struct lppaca * __init new_lppaca(int cpu, unsigned long limit)
 	if (early_cpu_has_feature(CPU_FTR_HVMODE))
 		return NULL;
 
-	lp = __va(memblock_alloc_base(size, 0x400, limit));
+	lp = alloc_paca_data(size, 0x400, limit, cpu);
 	init_lppaca(lp);
 
 	return lp;
@@ -82,7 +113,7 @@ static struct slb_shadow * __init new_slb_shadow(int cpu, unsigned long limit)
 			return NULL;
 	}
 
-	s = __va(memblock_alloc_base(sizeof(*s), L1_CACHE_BYTES, limit));
+	s = alloc_paca_data(sizeof(*s), L1_CACHE_BYTES, limit, cpu);
 	memset(s, 0, sizeof(*s));
 
 	s->persistent = cpu_to_be32(SLB_NUM_BOLTED);
@@ -173,7 +204,6 @@ void __init allocate_paca_ptrs(void)
 void __init allocate_paca(int cpu)
 {
 	u64 limit;
-	unsigned long pa;
 	struct paca_struct *paca;
 
 	BUG_ON(cpu >= paca_nr_cpu_ids);
@@ -188,9 +218,8 @@ void __init allocate_paca(int cpu)
 	limit = ppc64_rma_size;
 #endif
 
-	pa = memblock_alloc_base(sizeof(struct paca_struct),
-					L1_CACHE_BYTES, limit);
-	paca = __va(pa);
+	paca = alloc_paca_data(sizeof(struct paca_struct), L1_CACHE_BYTES,
+				limit, cpu);
 	paca_ptrs[cpu] = paca;
 	memset(paca, 0, sizeof(struct paca_struct));
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index dde34d35d1e7..02fa358982e6 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -312,6 +312,10 @@ void __init early_setup(unsigned long dt_ptr)
 	early_init_devtree(__va(dt_ptr));
 
 	/* Now we know the logical id of our boot cpu, setup the paca. */
+	if (boot_cpuid != 0) {
+		/* Poison paca_ptrs[0] again if it's not the boot cpu */
+		memset(&paca_ptrs[0], 0x88, sizeof(paca_ptrs[0]));
+	}
 	setup_paca(paca_ptrs[boot_cpuid]);
 	fixup_boot_paca();
 
-- 
2.16.1
