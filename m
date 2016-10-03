Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3snXW56hfJzDrDv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Oct 2016 17:41:05 +1100 (AEDT)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: During context switch,
 check before setting mm_cpumask
Date: Mon,  3 Oct 2016 17:40:29 +1100
Message-Id: <1475476829-6296-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

During context switch, switch_mm() sets our current CPU in mm_cpumask.
We can avoid this atomic sequence in most cases by checking before
setting the bit.

Testing on a POWER8 using our context switch microbenchmark:

tools/testing/selftests/powerpc/benchmarks/context_switch \
	--process --no-fp --no-altivec --no-vector

Performance improves 2%.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/mmu_context.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 475d1be..5c45114 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -72,7 +72,8 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
 	/* Mark this context has been used on the new CPU */
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
+	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next)))
+		cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
 
 	/* 32-bit keeps track of the current PGDIR in the thread struct */
 #ifdef CONFIG_PPC32
-- 
2.7.4
