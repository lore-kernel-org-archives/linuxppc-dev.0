Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lCTc72f5zDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 21:48:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/64: Disable irq restore warning for now
Date: Tue,  7 Aug 2018 21:48:46 +1000
Message-Id: <20180807114846.6198-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We recently added a warning in arch_local_irq_restore() to check that
the soft masking state matches reality.

Unfortunately it trips in a few places, which are not entirely trivial
to fix. The key problem is if we're doing function_graph tracing of
restore_math(), the warning pops and then seems to recurse. It's not
entirely clear because the system continuously oopses on all CPUs,
with the output interleaved and unreadable.

It's also been observed on a G5 coming out of idle.

Until we can fix those cases disable the warning for now.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ca941f1e83a9..916ddc4aac44 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -261,9 +261,16 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	 */
 	irq_happened = get_irq_happened();
 	if (!irq_happened) {
-#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-		WARN_ON(!(mfmsr() & MSR_EE));
-#endif
+		/*
+		 * FIXME. Here we'd like to be able to do:
+		 *
+		 * #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+		 *   WARN_ON(!(mfmsr() & MSR_EE));
+		 * #endif
+		 *
+		 * But currently it hits in a few paths, we should fix those and
+		 * enable the warning.
+		 */
 		return;
 	}
 
-- 
2.14.1
