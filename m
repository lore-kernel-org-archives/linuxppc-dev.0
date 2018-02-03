Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYQDX58RyzDr42
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 18:18:04 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id q79so1941134pfl.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Feb 2018 23:18:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s: fix may_hard_irq_enable for PMI soft masking
Date: Sat,  3 Feb 2018 17:17:50 +1000
Message-Id: <20180203071750.6469-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The soft IRQ masking code has to hard-disable interrupts in cases
where the exception is not cleared by the masked handler. External
interrupts used this approach for soft masking. Now recently PMU
interrupts do the same thing.

The soft IRQ masking code additionally allowed for interrupt handlers
to hard-enable interrupts after soft-disabling them. The idea is to
allow PMU interrupts through to profile interrupt handlers.

So when interrupts are being replayed when there is a pending
interrupt that requires hard-disabling, there is a test to prevent
those handlers from hard-enabling them if there is a pending external
interrupt. may_hard_irq_enable() handles this.

After f442d00480 ("powerpc/64s: Add support to mask perf interrupts
and replay them"), may_hard_irq_enable() could prematurely enable
MSR[EE] when a PMU exception exists, which would result in the
interrupt firing again while masked, and MSR[EE] being disabled again.

I haven't seen that this could cause a serious problem, but it's
more consistent to handle these soft-masked interrupts in the same
way. So introduce a define for all types of interrupts that require
MSR[EE] masking in their soft-disable handlers, and use that in
may_hard_irq_enable().

Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi,

A review of this would be helpful. I think it probably might as well
go into 4.16 unless I misunderstood the code. My changelog got a bit
long-winded in the end, I could try improve it if it's hard to
understand.

Thanks,
Nick

 arch/powerpc/include/asm/hw_irq.h    | 12 +++++++++++-
 arch/powerpc/kernel/exceptions-64e.S |  2 ++
 arch/powerpc/kernel/exceptions-64s.S |  6 +++---
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 88e5e8f17e98..855e17d158b1 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -29,6 +29,16 @@
 #define PACA_IRQ_HMI		0x20
 #define PACA_IRQ_PMI		0x40
 
+/*
+ * Some soft-masked interrupts must be hard masked until they are replayed
+ * (e.g., because the soft-masked handler does not clear the exception).
+ */
+#ifdef CONFIG_PPC_BOOK3S
+#define PACA_IRQ_MUST_HARD_MASK	(PACA_IRQ_EE|PACA_IRQ_PMI)
+#else
+#define PACA_IRQ_MUST_HARD_MASK	(PACA_IRQ_EE)
+#endif
+
 /*
  * flags for paca->irq_soft_mask
  */
@@ -244,7 +254,7 @@ static inline bool lazy_irq_pending(void)
 static inline void may_hard_irq_enable(void)
 {
 	get_paca()->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	if (!(get_paca()->irq_happened & PACA_IRQ_EE))
+	if (!(get_paca()->irq_happened & PACA_IRQ_MUST_HARD_MASK))
 		__hard_irq_enable();
 }
 
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index ee832d344a5a..9b6e653e501a 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -943,6 +943,8 @@ kernel_dbg_exc:
 /*
  * An interrupt came in while soft-disabled; We mark paca->irq_happened
  * accordingly and if the interrupt is level sensitive, we hard disable
+ * hard disable (full_mask) corresponds to PACA_IRQ_MUST_HARD_MASK, so
+ * keep these in synch.
  */
 
 .macro masked_interrupt_book3e paca_irq full_mask
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 243d072a225a..3ac87e53b3da 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1426,7 +1426,7 @@ EXC_COMMON_BEGIN(soft_nmi_common)
  *   triggered and won't automatically refire.
  * - If it was a HMI we return immediately since we handled it in realmode
  *   and it won't refire.
- * - else we hard disable and return.
+ * - Else it is one of PACA_IRQ_MUST_HARD_MASK, so hard disable and return.
  * This is called with r10 containing the value to OR to the paca field.
  */
 #define MASKED_INTERRUPT(_H)				\
@@ -1441,8 +1441,8 @@ masked_##_H##interrupt:					\
 	ori	r10,r10,0xffff;				\
 	mtspr	SPRN_DEC,r10;				\
 	b	MASKED_DEC_HANDLER_LABEL;		\
-1:	andi.	r10,r10,(PACA_IRQ_DBELL|PACA_IRQ_HMI);	\
-	bne	2f;					\
+1:	andi.	r10,r10,PACA_IRQ_MUST_HARD_MASK;	\
+	beq	2f;					\
 	mfspr	r10,SPRN_##_H##SRR1;			\
 	xori	r10,r10,MSR_EE; /* clear MSR_EE */	\
 	mtspr	SPRN_##_H##SRR1,r10;			\
-- 
2.15.1
