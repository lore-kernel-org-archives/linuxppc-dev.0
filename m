Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AD5E4B7B8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 14:13:28 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11913DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 14:13:26 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: Fix SMP issue with MMU context handling code
Date: Wed, 29 Jul 2009 23:13:21 -0500
Message-Id: <1248927201-18047-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In switch_mmu_context() if we call steal_context_smp() to get a context
to use we shouldn't fall through and than call steal_context_up().  Doing
so can be problematic in that the 'mm' that steal_context_up() ends up
using will not get marked dirty in the stale_map[] for other CPUs that
might have used that mm.  Thus we could end up with stale TLB entries in
the other CPUs that can cause all kinda of havoc.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/mmu_context_nohash.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 92a1971..b1a727d 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -217,6 +217,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 			id = steal_context_smp(id);
 			if (id == MMU_NO_CONTEXT)
 				goto again;
+			goto stolen;
 		}
 #endif /* CONFIG_SMP */
 		id = steal_context_up(id);
-- 
1.6.0.6
