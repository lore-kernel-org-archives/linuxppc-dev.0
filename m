Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2X5K3T8QzDqQF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 05:07:01 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6VJ3i83119248
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 15:06:58 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24grck62na-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 15:06:58 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 05:06:55 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 87C4F3578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 05:06:53 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6VJ6rUx24182990
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 05:06:53 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6VJ6qpM009710
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 05:06:53 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 05/11] powerpc: reverse the soft_enable logic
Date: Mon,  1 Aug 2016 00:36:23 +0530
In-Reply-To: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1469991989-28409-6-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"paca->soft_enabled" is used as a flag to mask some of interrupts.
Currently supported flags values and their details:

soft_enabled	MSR[EE]

0		0	Disabled (PMI and HMI not masked)
1		1	Enabled

"paca->soft_enabled" is initialized to 1 to make the interripts as
enabled. arch_local_irq_disable() will toggle the value when interrupts
needs to disbled. At this point, the interrupts are not actually disabled,
instead, interrupt vector has code to check for the flag and mask it when it occurs.
By "mask it", it update interrupt paca->irq_happened and return.
arch_local_irq_restore() is called to re-enable interrupts, which checks and
replays interrupts if any occured.

Now, as mentioned, current logic doesnot mask "performance monitoring interrupts"
and PMIs are implemented as NMI. But this patchset depends on local_irq_*
for a successful local_* update. Meaning, mask all possible interrupts during
local_* update and replay them after the update.

So the idea here is to reserve the "paca->soft_enabled" logic. New values and
details:

soft_enabled	MSR[EE]

1		0	Disabled  (PMI and HMI not masked)
0		1       Enabled

Reason for the this change is to create foundation for a third flag value "2"
for "soft_enabled" to add support to mask PMIs. When ->soft_enabled is
set to a value "2", PMI interrupts are mask and when set to a value
of "1", PMI are not mask.

Foundation patch to support checking of new flag value for "paca->soft_enabled".
Modify the condition checking for the "soft_enabled" from "equal" to
"greater than or equal to".

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 2 +-
 arch/powerpc/include/asm/hw_irq.h        | 8 ++++----
 arch/powerpc/include/asm/irqflags.h      | 2 +-
 arch/powerpc/kernel/entry_64.S           | 4 ++--
 arch/powerpc/kernel/irq.c                | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index a664586301d2..bbba44c2d5b0 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -408,7 +408,7 @@ label##_relon_hv:						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	r10,IRQ_DISABLE_LEVEL_LINUX;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
-	beq	masked_##h##interrupt
+	bge	masked_##h##interrupt
 #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
 
 #define SOFTEN_TEST_PR(vec)						\
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index ba4ade085aef..0206a6c493c7 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -30,8 +30,8 @@
 /*
  * flags for paca->soft_enabled
  */
-#define IRQ_DISABLE_LEVEL_NONE		1
-#define IRQ_DISABLE_LEVEL_LINUX		0
+#define IRQ_DISABLE_LEVEL_NONE		0
+#define IRQ_DISABLE_LEVEL_LINUX		1
 
 
 #endif /* CONFIG_PPC64 */
@@ -94,7 +94,7 @@ static inline unsigned long arch_local_irq_save(void)
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags == IRQ_DISABLE_LEVEL_LINUX;
+	return flags >= IRQ_DISABLE_LEVEL_LINUX;
 }
 
 static inline bool arch_irqs_disabled(void)
@@ -139,7 +139,7 @@ static inline void may_hard_irq_enable(void)
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
-	return (regs->softe == IRQ_DISABLE_LEVEL_LINUX);
+	return (regs->softe >= IRQ_DISABLE_LEVEL_LINUX);
 }
 
 extern bool prep_irq_for_idle(void);
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index 2796eceb5707..dcc6c9abb9b9 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -52,7 +52,7 @@
 	li	__rA,IRQ_DISABLE_LEVEL_LINUX;	\
 	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACAIRQHAPPENED(r13);	\
-	beq	44f;				\
+	bge	44f;				\
 	stb	__rA,PACASOFTIRQEN(r13);	\
 	TRACE_DISABLE_INTS;			\
 44:
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 47ab7ac3d039..7d755442ed83 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -766,7 +766,7 @@ restore:
 	ld	r5,SOFTE(r1)
 	lbz	r6,PACASOFTIRQEN(r13)
 	cmpwi	cr0,r5,IRQ_DISABLE_LEVEL_LINUX
-	beq	restore_irq_off
+	bge	restore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
 	cmpwi	cr0,r6,IRQ_DISABLE_LEVEL_NONE
@@ -1012,7 +1012,7 @@ _GLOBAL(enter_rtas)
 	 * check it with the asm equivalent of WARN_ON
 	 */
 	lbz	r0,PACASOFTIRQEN(r13)
-1:	tdnei	r0,IRQ_DISABLE_LEVEL_LINUX
+1:	tdeqi	r0,IRQ_DISABLE_LEVEL_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 	
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 84edd25c8d51..857e1e8188e5 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -202,7 +202,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 	/* Write the new soft-enabled value */
 	set_soft_enabled(en);
-	if (en == IRQ_DISABLE_LEVEL_LINUX)
+	if (en >= IRQ_DISABLE_LEVEL_LINUX)
 		return;
 	/*
 	 * From this point onward, we can take interrupts, preempt,
-- 
2.7.4
