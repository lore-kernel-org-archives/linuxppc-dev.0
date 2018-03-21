Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405s8B2MT3zF0tK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 01:07:53 +1100 (AEDT)
Message-Id: <03c175e506e88e57f48f01de9120768e1b942c6e.1521641042.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/4] powerpc/mm: constify FIRST_CONTEXT in mmu_context_nohash
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Mar 2018 15:07:47 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

First context is now 1 for all supported platforms, so it
can be made a constant.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mmu_context_nohash.c | 37 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index be8f5c9d4d08..5051c9363f8c 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -54,7 +54,9 @@
 
 #include "mmu_decl.h"
 
-static unsigned int first_context, last_context;
+#define FIRST_CONTEXT 1
+
+static unsigned int last_context;
 static unsigned int next_context, nr_free_contexts;
 static unsigned long *context_map;
 static unsigned long *stale_map[NR_CPUS];
@@ -87,7 +89,7 @@ static unsigned int steal_context_smp(unsigned int id)
 	struct mm_struct *mm;
 	unsigned int cpu, max, i;
 
-	max = last_context - first_context;
+	max = last_context - FIRST_CONTEXT;
 
 	/* Attempt to free next_context first and then loop until we manage */
 	while (max--) {
@@ -100,7 +102,7 @@ static unsigned int steal_context_smp(unsigned int id)
 		if (mm->context.active) {
 			id++;
 			if (id > last_context)
-				id = first_context;
+				id = FIRST_CONTEXT;
 			continue;
 		}
 		pr_hardcont(" | steal %d from 0x%p", id, mm);
@@ -142,7 +144,7 @@ static unsigned int steal_all_contexts(void)
 	int cpu = smp_processor_id();
 	unsigned int id;
 
-	for (id = first_context; id <= last_context; id++) {
+	for (id = FIRST_CONTEXT; id <= last_context; id++) {
 		/* Pick up the victim mm */
 		mm = context_mm[id];
 
@@ -150,7 +152,7 @@ static unsigned int steal_all_contexts(void)
 
 		/* Mark this mm as having no context anymore */
 		mm->context.id = MMU_NO_CONTEXT;
-		if (id != first_context) {
+		if (id != FIRST_CONTEXT) {
 			context_mm[id] = NULL;
 			__clear_bit(id, context_map);
 #ifdef DEBUG_MAP_CONSISTENCY
@@ -163,9 +165,9 @@ static unsigned int steal_all_contexts(void)
 	/* Flush the TLB for all contexts (not to be used on SMP) */
 	_tlbil_all();
 
-	nr_free_contexts = last_context - first_context;
+	nr_free_contexts = last_context - FIRST_CONTEXT;
 
-	return first_context;
+	return FIRST_CONTEXT;
 }
 
 /* Note that this will also be called on SMP if all other CPUs are
@@ -201,7 +203,7 @@ static void context_check_map(void)
 	unsigned int id, nrf, nact;
 
 	nrf = nact = 0;
-	for (id = first_context; id <= last_context; id++) {
+	for (id = FIRST_CONTEXT; id <= last_context; id++) {
 		int used = test_bit(id, context_map);
 		if (!used)
 			nrf++;
@@ -219,7 +221,7 @@ static void context_check_map(void)
 	if (nact > num_online_cpus())
 		pr_err("MMU: More active contexts than CPUs ! (%d vs %d)\n",
 		       nact, num_online_cpus());
-	if (first_context > 0 && !test_bit(0, context_map))
+	if (FIRST_CONTEXT > 0 && !test_bit(0, context_map))
 		pr_err("MMU: Context 0 has been freed !!!\n");
 }
 #else
@@ -264,7 +266,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
 	/* We really don't have a context, let's try to acquire one */
 	id = next_context;
 	if (id > last_context)
-		id = first_context;
+		id = FIRST_CONTEXT;
 	map = context_map;
 
 	/* No more free contexts, let's try to steal one */
@@ -289,7 +291,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
 	while (__test_and_set_bit(id, map)) {
 		id = find_next_zero_bit(map, last_context+1, id);
 		if (id > last_context)
-			id = first_context;
+			id = FIRST_CONTEXT;
 	}
  stolen:
 	next_context = id + 1;
@@ -439,15 +441,12 @@ void __init mmu_context_init(void)
 	 *      -- BenH
 	 */
 	if (mmu_has_feature(MMU_FTR_TYPE_8xx)) {
-		first_context = 1;
 		last_context = 16;
 		no_selective_tlbil = true;
 	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
-		first_context = 1;
 		last_context = 65535;
 		no_selective_tlbil = false;
 	} else {
-		first_context = 1;
 		last_context = 255;
 		no_selective_tlbil = false;
 	}
@@ -473,16 +472,16 @@ void __init mmu_context_init(void)
 	printk(KERN_INFO
 	       "MMU: Allocated %zu bytes of context maps for %d contexts\n",
 	       2 * CTX_MAP_SIZE + (sizeof(void *) * (last_context + 1)),
-	       last_context - first_context + 1);
+	       last_context - FIRST_CONTEXT + 1);
 
 	/*
 	 * Some processors have too few contexts to reserve one for
 	 * init_mm, and require using context 0 for a normal task.
 	 * Other processors reserve the use of context zero for the kernel.
-	 * This code assumes first_context < 32.
+	 * This code assumes FIRST_CONTEXT < 32.
 	 */
-	context_map[0] = (1 << first_context) - 1;
-	next_context = first_context;
-	nr_free_contexts = last_context - first_context + 1;
+	context_map[0] = (1 << FIRST_CONTEXT) - 1;
+	next_context = FIRST_CONTEXT;
+	nr_free_contexts = last_context - FIRST_CONTEXT + 1;
 }
 
-- 
2.13.3
