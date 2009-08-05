Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CCD75B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 13:33:38 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C2EFDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 13:33:37 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: Fix switch_mmu_context to iterate of the proper
	list of cpus
Date: Tue,  4 Aug 2009 22:33:32 -0500
Message-Id: <1249443212-25588-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduced a temporary variable into our iterating over the list cpus
that are threads on the same core.  For some reason Ben forgot how for
loops work.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/mmu_context_nohash.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 6e8d2d9..9859dcd 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -190,7 +190,7 @@ static void context_check_map(void) { }
 
 void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 {
-	unsigned int id, cpu = smp_processor_id();
+	unsigned int i, id, cpu = smp_processor_id();
 	unsigned long *map;
 
 	/* No lockless fast path .. yet */
@@ -268,9 +268,10 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 		local_flush_tlb_mm(next);
 
 		/* XXX This clear should ultimately be part of local_flush_tlb_mm */
-		for (cpu = cpu_first_thread_in_core(cpu);
-		     cpu <= cpu_last_thread_in_core(cpu); cpu++)
-			__clear_bit(id, stale_map[cpu]);
+		for (i = cpu_first_thread_in_core(cpu);
+		     i <= cpu_last_thread_in_core(cpu); i++) {
+			__clear_bit(id, stale_map[i]);
+		}
 	}
 
 	/* Flick the MMU and release lock */
-- 
1.6.0.6
