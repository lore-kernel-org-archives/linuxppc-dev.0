Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgBvy3FD0zF0nb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 04:08:46 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id y8so665007pgr.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 09:08:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 04/12] powerpc/64s: allocate slb_shadow structures
 individually
Date: Tue, 13 Feb 2018 03:08:14 +1000
Message-Id: <20180212170822.14612-5-npiggin@gmail.com>
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

Allocate slb_shadow structures individually.

slb_shadow structures are avoided for radix environment.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/paca.c | 65 +++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 6cddb9bdc151..2699f9009286 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -72,41 +72,28 @@ static void __init free_lppaca(struct lppaca *lp)
 #ifdef CONFIG_PPC_BOOK3S_64
 
 /*
- * 3 persistent SLBs are registered here.  The buffer will be zero
+ * 3 persistent SLBs are allocated here.  The buffer will be zero
  * initially, hence will all be invaild until we actually write them.
  *
  * If you make the number of persistent SLB entries dynamic, please also
  * update PR KVM to flush and restore them accordingly.
  */
-static struct slb_shadow * __initdata slb_shadow;
-
-static void __init allocate_slb_shadows(int nr_cpus, int limit)
-{
-	int size = PAGE_ALIGN(sizeof(struct slb_shadow) * nr_cpus);
-
-	if (early_radix_enabled())
-		return;
-
-	slb_shadow = __va(memblock_alloc_base(size, PAGE_SIZE, limit));
-	memset(slb_shadow, 0, size);
-}
-
-static struct slb_shadow * __init init_slb_shadow(int cpu)
+static struct slb_shadow * __init new_slb_shadow(int cpu, unsigned long limit)
 {
 	struct slb_shadow *s;
 
-	if (early_radix_enabled())
-		return NULL;
+	if (cpu != boot_cpuid) {
+		/*
+		 * Boot CPU comes here before early_radix_enabled
+		 * is parsed (e.g., for disable_radix). So allocate
+		 * always and this will be fixed up in free_unused_pacas.
+		 */
+		if (early_radix_enabled())
+			return NULL;
+	}
 
-	s = &slb_shadow[cpu];
-
-	/*
-	 * When we come through here to initialise boot_paca, the slb_shadow
-	 * buffers are not allocated yet. That's OK, we'll get one later in
-	 * boot, but make sure we don't corrupt memory at 0.
-	 */
-	if (!slb_shadow)
-		return NULL;
+	s = __va(memblock_alloc_base(sizeof(*s), L1_CACHE_BYTES, limit));
+	memset(s, 0, sizeof(*s));
 
 	s->persistent = cpu_to_be32(SLB_NUM_BOLTED);
 	s->buffer_length = cpu_to_be32(sizeof(*s));
@@ -114,10 +101,6 @@ static struct slb_shadow * __init init_slb_shadow(int cpu)
 	return s;
 }
 
-#else /* !CONFIG_PPC_BOOK3S_64 */
-
-static void __init allocate_slb_shadows(int nr_cpus, int limit) { }
-
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 /* The Paca is an array with one entry per processor.  Each contains an
@@ -151,7 +134,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 	new_paca->__current = &init_task;
 	new_paca->data_offset = 0xfeeeeeeeeeeeeeeeULL;
 #ifdef CONFIG_PPC_BOOK3S_64
-	new_paca->slb_shadow_ptr = init_slb_shadow(cpu);
+	new_paca->slb_shadow_ptr = NULL;
 #endif
 
 #ifdef CONFIG_PPC_BOOK3E
@@ -222,13 +205,16 @@ void __init allocate_pacas(void)
 	printk(KERN_DEBUG "Allocated %lu bytes for %u pacas\n",
 			size, nr_cpu_ids);
 
-	allocate_slb_shadows(nr_cpu_ids, limit);
-
 	/* Can't use for_each_*_cpu, as they aren't functional yet */
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
-		initialise_paca(paca_ptrs[cpu], cpu);
+		struct paca_struct *paca = paca_ptrs[cpu];
+
+		initialise_paca(paca, cpu);
 #ifdef CONFIG_PPC_PSERIES
-		paca_ptrs[cpu]->lppaca_ptr = new_lppaca(cpu, limit);
+		paca->lppaca_ptr = new_lppaca(cpu, limit);
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+		paca->slb_shadow_ptr = new_slb_shadow(cpu, limit);
 #endif
 	}
 }
@@ -263,6 +249,15 @@ void __init free_unused_pacas(void)
 
 	paca_nr_cpu_ids = nr_cpu_ids;
 	paca_ptrs_size = new_ptrs_size;
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (early_radix_enabled()) {
+		/* Ugly fixup, see new_slb_shadow() */
+		memblock_free(__pa(paca_ptrs[boot_cpuid]->slb_shadow_ptr),
+				sizeof(struct slb_shadow));
+		paca_ptrs[boot_cpuid]->slb_shadow_ptr = NULL;
+	}
+#endif
 }
 
 void copy_mm_to_paca(struct mm_struct *mm)
-- 
2.16.1
