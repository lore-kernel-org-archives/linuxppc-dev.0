Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405s8F3TjTzF0xW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 01:07:57 +1100 (AEDT)
Message-Id: <4fe13c13918bb6c42e4c2e61add9a6937e674da9.1521641042.git.christophe.leroy@c-s.fr>
In-Reply-To: <03c175e506e88e57f48f01de9120768e1b942c6e.1521641042.git.christophe.leroy@c-s.fr>
References: <03c175e506e88e57f48f01de9120768e1b942c6e.1521641042.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  4/4] powerpc/mm: Remove stale_map[] handling on non SMP
 processors
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Mar 2018 15:07:53 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

stale_map[] bits are only set in steal_context_smp() so
on UP processors this map is useless. Only manage it for SMP
processors.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mmu_context_nohash.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 625c17049483..3f13f07f64dd 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -88,7 +88,9 @@
 
 static unsigned int next_context, nr_free_contexts;
 static unsigned long *context_map;
+#ifdef CONFIG_SMP
 static unsigned long *stale_map[NR_CPUS];
+#endif
 static struct mm_struct **context_mm;
 static DEFINE_RAW_SPINLOCK(context_lock);
 
@@ -169,7 +171,9 @@ static unsigned int steal_context_smp(unsigned int id)
 static unsigned int steal_all_contexts(void)
 {
 	struct mm_struct *mm;
+#ifdef CONFIG_SMP
 	int cpu = smp_processor_id();
+#endif
 	unsigned int id;
 
 	for (id = FIRST_CONTEXT; id <= LAST_CONTEXT; id++) {
@@ -187,7 +191,9 @@ static unsigned int steal_all_contexts(void)
 			mm->context.active = 0;
 #endif
 		}
+#ifdef CONFIG_SMP
 		__clear_bit(id, stale_map[cpu]);
+#endif
 	}
 
 	/* Flush the TLB for all contexts (not to be used on SMP) */
@@ -206,7 +212,9 @@ static unsigned int steal_all_contexts(void)
 static unsigned int steal_context_up(unsigned int id)
 {
 	struct mm_struct *mm;
+#ifdef CONFIG_SMP
 	int cpu = smp_processor_id();
+#endif
 
 	/* Pick up the victim mm */
 	mm = context_mm[id];
@@ -220,7 +228,9 @@ static unsigned int steal_context_up(unsigned int id)
 	mm->context.id = MMU_NO_CONTEXT;
 
 	/* XXX This clear should ultimately be part of local_flush_tlb_mm */
+#ifdef CONFIG_SMP
 	__clear_bit(id, stale_map[cpu]);
+#endif
 
 	return id;
 }
@@ -259,7 +269,10 @@ static void context_check_map(void) { }
 void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
-	unsigned int i, id, cpu = smp_processor_id();
+	unsigned int id;
+#ifdef CONFIG_SMP
+	unsigned int i, cpu = smp_processor_id();
+#endif
 	unsigned long *map;
 
 	/* No lockless fast path .. yet */
@@ -333,6 +346,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
 	/* If that context got marked stale on this CPU, then flush the
 	 * local TLB for it and unmark it before we use it
 	 */
+#ifdef CONFIG_SMP
 	if (test_bit(id, stale_map[cpu])) {
 		pr_hardcont(" | stale flush %d [%d..%d]",
 			    id, cpu_first_thread_sibling(cpu),
@@ -347,6 +361,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
 				__clear_bit(id, stale_map[i]);
 		}
 	}
+#endif
 
 	/* Flick the MMU and release lock */
 	pr_hardcont(" -> %d\n", id);
@@ -452,9 +467,7 @@ void __init mmu_context_init(void)
 	 */
 	context_map = memblock_virt_alloc(CTX_MAP_SIZE, 0);
 	context_mm = memblock_virt_alloc(sizeof(void *) * (LAST_CONTEXT + 1), 0);
-#ifndef CONFIG_SMP
-	stale_map[0] = memblock_virt_alloc(CTX_MAP_SIZE, 0);
-#else
+#ifdef CONFIG_SMP
 	stale_map[boot_cpuid] = memblock_virt_alloc(CTX_MAP_SIZE, 0);
 
 	cpuhp_setup_state_nocalls(CPUHP_POWERPC_MMU_CTX_PREPARE,
-- 
2.13.3
