Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 20 May 2009 12:56:42 +1000
Subject: [PATCH] powerpc/mm: Fix some SMP issues with MMU context handling
Message-Id: <20090520025646.A4896DE189@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a couple of issues that can happen as a result
of steal_context() dropping the context_lock when all possible
PIDs are ineligible for stealing (hopefully an extremely hard to
hit occurence).

This case exposes the possibility of a stale context_mm[] entry
to be seen since destroy_context() doesn't clear it and the free
map isn't re-tested. It also means steal_context() will not notice
a context freed while the lock was help, thus possibly trying to
steal a context when a free one was available.

This fixes it by always returning to the caller from steal_context
when it dropped the lock with a return value that causes the
caller to re-samble the number of free contexts, along with
properly clearing the context_mm[] array for destroyed contexts.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/mm/mmu_context_nohash.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- linux-work.orig/arch/powerpc/mm/mmu_context_nohash.c	2009-05-20 12:39:21.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2009-05-20 12:49:45.000000000 +1000
@@ -73,7 +73,6 @@ static unsigned int steal_context_smp(un
 	struct mm_struct *mm;
 	unsigned int cpu, max;
 
- again:
 	max = last_context - first_context;
 
 	/* Attempt to free next_context first and then loop until we manage */
@@ -108,7 +107,9 @@ static unsigned int steal_context_smp(un
 	spin_unlock(&context_lock);
 	cpu_relax();
 	spin_lock(&context_lock);
-	goto again;
+
+	/* This will cause the caller to try again */
+	return MMU_NO_CONTEXT;
 }
 #endif  /* CONFIG_SMP */
 
@@ -194,6 +195,8 @@ void switch_mmu_context(struct mm_struct
 		WARN_ON(prev->context.active < 1);
 		prev->context.active--;
 	}
+
+ again:
 #endif /* CONFIG_SMP */
 
 	/* If we already have a valid assigned context, skip all that */
@@ -212,7 +215,8 @@ void switch_mmu_context(struct mm_struct
 #ifdef CONFIG_SMP
 		if (num_online_cpus() > 1) {
 			id = steal_context_smp(id);
-			goto stolen;
+			if (id == MMU_NO_CONTEXT)
+				goto again;
 		}
 #endif /* CONFIG_SMP */
 		id = steal_context_up(id);
@@ -286,8 +290,8 @@ void destroy_context(struct mm_struct *m
 		mm->context.id = MMU_NO_CONTEXT;
 #ifdef DEBUG_MAP_CONSISTENCY
 		mm->context.active = 0;
-		context_mm[id] = NULL;
 #endif
+		context_mm[id] = NULL;
 		nr_free_contexts++;
 	}
 	spin_unlock(&context_lock);
