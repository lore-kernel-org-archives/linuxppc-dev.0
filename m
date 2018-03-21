Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405s8D6nPczF0kV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 01:07:56 +1100 (AEDT)
Message-Id: <f8748288f4e87201d35a7f183b924f3f6a4d7f81.1521641042.git.christophe.leroy@c-s.fr>
In-Reply-To: <03c175e506e88e57f48f01de9120768e1b942c6e.1521641042.git.christophe.leroy@c-s.fr>
References: <03c175e506e88e57f48f01de9120768e1b942c6e.1521641042.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  3/4] powerpc/mm: constify LAST_CONTEXT in mmu_context_nohash
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Mar 2018 15:07:51 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

last_context is 16 on the 8xx, 65535 on the 47x and 255 on other ones.

The kernel is exclusively built for the 8xx, for the 47x or for
another processor so the last context can be defined as a constant
depending on the processor.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mmu_context_nohash.c | 88 ++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 3fbe36266838..625c17049483 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -54,9 +54,38 @@
 
 #include "mmu_decl.h"
 
+/*
+ *   The MPC8xx has only 16 contexts.  We rotate through them on each
+ * task switch.  A better way would be to keep track of tasks that
+ * own contexts, and implement an LRU usage.  That way very active
+ * tasks don't always have to pay the TLB reload overhead.  The
+ * kernel pages are mapped shared, so the kernel can run on behalf
+ * of any task that makes a kernel entry.  Shared does not mean they
+ * are not protected, just that the ASID comparison is not performed.
+ *      -- Dan
+ *
+ * The IBM4xx has 256 contexts, so we can just rotate through these
+ * as a way of "switching" contexts.  If the TID of the TLB is zero,
+ * the PID/TID comparison is disabled, so we can use a TID of zero
+ * to represent all kernel pages as shared among all contexts.
+ * 	-- Dan
+ *
+ * The IBM 47x core supports 16-bit PIDs, thus 65535 contexts. We
+ * should normally never have to steal though the facility is
+ * present if needed.
+ *      -- BenH
+ */
 #define FIRST_CONTEXT 1
+#ifdef DEBUG_CLAMP_LAST_CONTEXT
+#define LAST_CONTEXT DEBUG_CLAMP_LAST_CONTEXT
+#elif defined(CONFIG_PPC_8xx)
+#define LAST_CONTEXT 16
+#elif defined(CONFIG_PPC_47x)
+#define LAST_CONTEXT 65535
+#else
+#define LAST_CONTEXT 255
+#endif
 
-static unsigned int last_context;
 static unsigned int next_context, nr_free_contexts;
 static unsigned long *context_map;
 static unsigned long *stale_map[NR_CPUS];
@@ -64,7 +93,7 @@ static struct mm_struct **context_mm;
 static DEFINE_RAW_SPINLOCK(context_lock);
 
 #define CTX_MAP_SIZE	\
-	(sizeof(unsigned long) * (last_context / BITS_PER_LONG + 1))
+	(sizeof(unsigned long) * (LAST_CONTEXT / BITS_PER_LONG + 1))
 
 
 /* Steal a context from a task that has one at the moment.
@@ -88,7 +117,7 @@ static unsigned int steal_context_smp(unsigned int id)
 	struct mm_struct *mm;
 	unsigned int cpu, max, i;
 
-	max = last_context - FIRST_CONTEXT;
+	max = LAST_CONTEXT - FIRST_CONTEXT;
 
 	/* Attempt to free next_context first and then loop until we manage */
 	while (max--) {
@@ -100,7 +129,7 @@ static unsigned int steal_context_smp(unsigned int id)
 		 */
 		if (mm->context.active) {
 			id++;
-			if (id > last_context)
+			if (id > LAST_CONTEXT)
 				id = FIRST_CONTEXT;
 			continue;
 		}
@@ -143,7 +172,7 @@ static unsigned int steal_all_contexts(void)
 	int cpu = smp_processor_id();
 	unsigned int id;
 
-	for (id = FIRST_CONTEXT; id <= last_context; id++) {
+	for (id = FIRST_CONTEXT; id <= LAST_CONTEXT; id++) {
 		/* Pick up the victim mm */
 		mm = context_mm[id];
 
@@ -164,7 +193,7 @@ static unsigned int steal_all_contexts(void)
 	/* Flush the TLB for all contexts (not to be used on SMP) */
 	_tlbil_all();
 
-	nr_free_contexts = last_context - FIRST_CONTEXT;
+	nr_free_contexts = LAST_CONTEXT - FIRST_CONTEXT;
 
 	return FIRST_CONTEXT;
 }
@@ -202,7 +231,7 @@ static void context_check_map(void)
 	unsigned int id, nrf, nact;
 
 	nrf = nact = 0;
-	for (id = FIRST_CONTEXT; id <= last_context; id++) {
+	for (id = FIRST_CONTEXT; id <= LAST_CONTEXT; id++) {
 		int used = test_bit(id, context_map);
 		if (!used)
 			nrf++;
@@ -264,7 +293,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
 
 	/* We really don't have a context, let's try to acquire one */
 	id = next_context;
-	if (id > last_context)
+	if (id > LAST_CONTEXT)
 		id = FIRST_CONTEXT;
 	map = context_map;
 
@@ -288,8 +317,8 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
 
 	/* We know there's at least one free context, try to find it */
 	while (__test_and_set_bit(id, map)) {
-		id = find_next_zero_bit(map, last_context+1, id);
-		if (id > last_context)
+		id = find_next_zero_bit(map, LAST_CONTEXT+1, id);
+		if (id > LAST_CONTEXT)
 			id = FIRST_CONTEXT;
 	}
  stolen:
@@ -419,41 +448,10 @@ void __init mmu_context_init(void)
 	init_mm.context.active = NR_CPUS;
 
 	/*
-	 *   The MPC8xx has only 16 contexts.  We rotate through them on each
-	 * task switch.  A better way would be to keep track of tasks that
-	 * own contexts, and implement an LRU usage.  That way very active
-	 * tasks don't always have to pay the TLB reload overhead.  The
-	 * kernel pages are mapped shared, so the kernel can run on behalf
-	 * of any task that makes a kernel entry.  Shared does not mean they
-	 * are not protected, just that the ASID comparison is not performed.
-	 *      -- Dan
-	 *
-	 * The IBM4xx has 256 contexts, so we can just rotate through these
-	 * as a way of "switching" contexts.  If the TID of the TLB is zero,
-	 * the PID/TID comparison is disabled, so we can use a TID of zero
-	 * to represent all kernel pages as shared among all contexts.
-	 * 	-- Dan
-	 *
-	 * The IBM 47x core supports 16-bit PIDs, thus 65535 contexts. We
-	 * should normally never have to steal though the facility is
-	 * present if needed.
-	 *      -- BenH
-	 */
-	if (mmu_has_feature(MMU_FTR_TYPE_8xx))
-		last_context = 16;
-	else if (mmu_has_feature(MMU_FTR_TYPE_47x))
-		last_context = 65535;
-	else
-		last_context = 255;
-
-#ifdef DEBUG_CLAMP_LAST_CONTEXT
-	last_context = DEBUG_CLAMP_LAST_CONTEXT;
-#endif
-	/*
 	 * Allocate the maps used by context management
 	 */
 	context_map = memblock_virt_alloc(CTX_MAP_SIZE, 0);
-	context_mm = memblock_virt_alloc(sizeof(void *) * (last_context + 1), 0);
+	context_mm = memblock_virt_alloc(sizeof(void *) * (LAST_CONTEXT + 1), 0);
 #ifndef CONFIG_SMP
 	stale_map[0] = memblock_virt_alloc(CTX_MAP_SIZE, 0);
 #else
@@ -466,8 +464,8 @@ void __init mmu_context_init(void)
 
 	printk(KERN_INFO
 	       "MMU: Allocated %zu bytes of context maps for %d contexts\n",
-	       2 * CTX_MAP_SIZE + (sizeof(void *) * (last_context + 1)),
-	       last_context - FIRST_CONTEXT + 1);
+	       2 * CTX_MAP_SIZE + (sizeof(void *) * (LAST_CONTEXT + 1)),
+	       LAST_CONTEXT - FIRST_CONTEXT + 1);
 
 	/*
 	 * Some processors have too few contexts to reserve one for
@@ -477,6 +475,6 @@ void __init mmu_context_init(void)
 	 */
 	context_map[0] = (1 << FIRST_CONTEXT) - 1;
 	next_context = FIRST_CONTEXT;
-	nr_free_contexts = last_context - FIRST_CONTEXT + 1;
+	nr_free_contexts = LAST_CONTEXT - FIRST_CONTEXT + 1;
 }
 
-- 
2.13.3
