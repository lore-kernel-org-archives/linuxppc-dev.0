Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 44416B72A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 14:13:54 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d554caa95a54f3b545d10b73e64c7780186aa4a3.1245298429.git.michael@ellerman.id.au>
In-Reply-To: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
References: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 7/7] powerpc: Use pr_devel() in
	arch/powerpc/mm/mmu_context_nohash.c
Date: Thu, 18 Jun 2009 14:13:54 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pr_debug() can now result in code being generated even when DEBUG
is not defined. That's not really desirable in some places.

With CONFIG_DYNAMIC_DEBUG=y:

size before:
   text	   data	    bss	    dec	    hex	filename
   1508	     48	     28	   1584	    630	powerpc/mm/mmu_context_nohash.o

size after:
   text	   data	    bss	    dec	    hex	filename
   1088	      0	     28	   1116	    45c	powerpc/mm/mmu_context_nohash.o

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/mmu_context_nohash.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 8343986..92a1971 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -89,7 +89,7 @@ static unsigned int steal_context_smp(unsigned int id)
 				id = first_context;
 			continue;
 		}
-		pr_debug("[%d] steal context %d from mm @%p\n",
+		pr_devel("[%d] steal context %d from mm @%p\n",
 			 smp_processor_id(), id, mm);
 
 		/* Mark this mm has having no context anymore */
@@ -126,7 +126,7 @@ static unsigned int steal_context_up(unsigned int id)
 	/* Pick up the victim mm */
 	mm = context_mm[id];
 
-	pr_debug("[%d] steal context %d from mm @%p\n", cpu, id, mm);
+	pr_devel("[%d] steal context %d from mm @%p\n", cpu, id, mm);
 
 	/* Flush the TLB for that context */
 	local_flush_tlb_mm(mm);
@@ -180,7 +180,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 	spin_lock(&context_lock);
 
 #ifndef DEBUG_STEAL_ONLY
-	pr_debug("[%d] activating context for mm @%p, active=%d, id=%d\n",
+	pr_devel("[%d] activating context for mm @%p, active=%d, id=%d\n",
 		 cpu, next, next->context.active, next->context.id);
 #endif
 
@@ -189,7 +189,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 	next->context.active++;
 	if (prev) {
 #ifndef DEBUG_STEAL_ONLY
-		pr_debug(" old context %p active was: %d\n",
+		pr_devel(" old context %p active was: %d\n",
 			 prev, prev->context.active);
 #endif
 		WARN_ON(prev->context.active < 1);
@@ -236,7 +236,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 	next->context.id = id;
 
 #ifndef DEBUG_STEAL_ONLY
-	pr_debug("[%d] picked up new id %d, nrf is now %d\n",
+	pr_devel("[%d] picked up new id %d, nrf is now %d\n",
 		 cpu, id, nr_free_contexts);
 #endif
 
@@ -247,7 +247,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 	 * local TLB for it and unmark it before we use it
 	 */
 	if (test_bit(id, stale_map[cpu])) {
-		pr_debug("[%d] flushing stale context %d for mm @%p !\n",
+		pr_devel("[%d] flushing stale context %d for mm @%p !\n",
 			 cpu, id, next);
 		local_flush_tlb_mm(next);
 
@@ -314,13 +314,13 @@ static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
 	switch (action) {
 	case CPU_ONLINE:
 	case CPU_ONLINE_FROZEN:
-		pr_debug("MMU: Allocating stale context map for CPU %d\n", cpu);
+		pr_devel("MMU: Allocating stale context map for CPU %d\n", cpu);
 		stale_map[cpu] = kzalloc(CTX_MAP_SIZE, GFP_KERNEL);
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_DEAD:
 	case CPU_DEAD_FROZEN:
-		pr_debug("MMU: Freeing stale context map for CPU %d\n", cpu);
+		pr_devel("MMU: Freeing stale context map for CPU %d\n", cpu);
 		kfree(stale_map[cpu]);
 		stale_map[cpu] = NULL;
 		break;
-- 
1.6.2.1
