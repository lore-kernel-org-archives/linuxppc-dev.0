Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id DD2811008BF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:36 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <f1fe966892eb8d8e688f0de38a0a839e5d29a5af.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:28:52 -0500
Subject: [PATCH 06/37] powerpc: use nr_cpu_ids in initial paca allocation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we never set a cpu above nr_cpu_ids possible we can
limit our initial paca allocation to nr_cpu_ids.  We can then
clamp the number of cpus in platforms/iseries/setup.c.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/kernel/paca.c             |   17 ++++++-----------
 arch/powerpc/platforms/iseries/setup.c |    5 +++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 102244e..efeb881 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -7,7 +7,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#include <linux/threads.h>
+#include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/memblock.h>
 
@@ -178,7 +178,7 @@ static int __initdata paca_size;
 
 void __init allocate_pacas(void)
 {
-	int nr_cpus, cpu, limit;
+	int cpu, limit;
 
 	/*
 	 * We can't take SLB misses on the paca, and we want to access them
@@ -190,23 +190,18 @@ void __init allocate_pacas(void)
 	if (firmware_has_feature(FW_FEATURE_ISERIES))
 		limit = min(limit, HvPagesToMap * HVPAGESIZE);
 
-	nr_cpus = NR_CPUS;
-	/* On iSeries we know we can never have more than 64 cpus */
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		nr_cpus = min(64, nr_cpus);
-
-	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpus);
+	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
 
 	paca = __va(memblock_alloc_base(paca_size, PAGE_SIZE, limit));
 	memset(paca, 0, paca_size);
 
 	printk(KERN_DEBUG "Allocated %u bytes for %d pacas at %p\n",
-		paca_size, nr_cpus, paca);
+		paca_size, nr_cpu_ids, paca);
 
-	allocate_lppacas(nr_cpus, limit);
+	allocate_lppacas(nr_cpu_ids, limit);
 
 	/* Can't use for_each_*_cpu, as they aren't functional yet */
-	for (cpu = 0; cpu < nr_cpus; cpu++)
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
 		initialise_paca(&paca[cpu], cpu);
 }
 
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 81cb8d2..c25a081 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -685,6 +685,11 @@ void * __init iSeries_early_setup(void)
 	powerpc_firmware_features |= FW_FEATURE_ISERIES;
 	powerpc_firmware_features |= FW_FEATURE_LPAR;
 
+#ifdef CONFIG_SMP
+	/* On iSeries we know we can never have more than 64 cpus */
+	nr_cpu_ids = max(nr_cpu_ids, 64);
+#endif
+
 	iSeries_fixup_klimit();
 
 	/*
-- 
1.7.0.4
