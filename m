Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bdqd209qzF2ST
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 23:07:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [RFC PATCH 1/4] powerpc/64: Save stack pointer when we hard disable
 interrupts
Date: Wed,  2 May 2018 23:07:26 +1000
Message-Id: <20180502130729.24077-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A CPU that gets stuck with interrupts hard disable can be difficult to
debug, as on some platforms we have no way to interrupt the CPU to
find out what it's doing.

A stop-gap is to have the CPU save it's stack pointer (r1) in its paca
when it hard disables interrupts. That way if we can't interrupt it,
we can at least trace the stack based on where it last disabled
interrupts.

In some cases that will be total junk, but the stack trace code should
handle that. In the simple case of a CPU that disable interrupts and
then gets stuck in a loop, the stack trace should be informative.

We could clear the saved stack pointer when we enable interrupts, but
that loses information which could be useful if we have nothing else
to go on.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/hw_irq.h    | 6 +++++-
 arch/powerpc/include/asm/paca.h      | 2 +-
 arch/powerpc/kernel/exceptions-64s.S | 1 +
 arch/powerpc/xmon/xmon.c             | 2 ++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 855e17d158b1..35cb37be61fe 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -237,8 +237,12 @@ static inline bool arch_irqs_disabled(void)
 	__hard_irq_disable();						\
 	flags = irq_soft_mask_set_return(IRQS_ALL_DISABLED);		\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;			\
-	if (!arch_irqs_disabled_flags(flags))				\
+	if (!arch_irqs_disabled_flags(flags)) {				\
+		asm ("stdx %%r1, 0, %1 ;"				\
+		     : "=m" (local_paca->saved_r1)			\
+		     : "b" (&local_paca->saved_r1));			\
 		trace_hardirqs_off();					\
+	}								\
 } while(0)
 
 static inline bool lazy_irq_pending(void)
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 3f109a3e3edb..e7814d948c7a 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -161,7 +161,7 @@ struct paca_struct {
 	struct task_struct *__current;	/* Pointer to current */
 	u64 kstack;			/* Saved Kernel stack addr */
 	u64 stab_rr;			/* stab/slb round-robin counter */
-	u64 saved_r1;			/* r1 save for RTAS calls or PM */
+	u64 saved_r1;			/* r1 save for RTAS calls or PM or EE=0 */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
 	u8 irq_soft_mask;		/* mask for irq soft masking */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ae6a849db60b..bb26fe9e90ce 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1499,6 +1499,7 @@ masked_##_H##interrupt:					\
 	xori	r10,r10,MSR_EE; /* clear MSR_EE */	\
 	mtspr	SPRN_##_H##SRR1,r10;			\
 2:	mtcrf	0x80,r9;				\
+	std	r1,PACAR1(r13);				\
 	ld	r9,PACA_EXGEN+EX_R9(r13);		\
 	ld	r10,PACA_EXGEN+EX_R10(r13);		\
 	ld	r11,PACA_EXGEN+EX_R11(r13);		\
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a0842f1ff72c..94cc8ba36c14 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1161,6 +1161,8 @@ static int cpu_cmd(void)
 	/* try to switch to cpu specified */
 	if (!cpumask_test_cpu(cpu, &cpus_in_xmon)) {
 		printf("cpu 0x%x isn't in xmon\n", cpu);
+		printf("backtrace of paca[0x%x].saved_r1 (possibly stale):\n", cpu);
+		xmon_show_stack(paca_ptrs[cpu]->saved_r1, 0, 0);
 		return 0;
 	}
 	xmon_taken = 0;
-- 
2.14.1
