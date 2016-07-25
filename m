Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryklC6MW1zDrJB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:11 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PEn3Xk039914
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:53:10 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c1fjknsp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:53:10 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 00:53:07 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7F0A83578058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:05 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6PEr5m026083344
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:05 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6PEr4tT012560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:05 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH 6/9] powerpc: modify __SOFTEN_TEST to support tri-state
 soft_enabled flag
Date: Mon, 25 Jul 2016 20:22:19 +0530
In-Reply-To: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1469458342-26233-7-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Foundation patch to support checking of new flag for "paca->soft_enabled".
Modify the condition checking for the "soft_enabled" from "equal" to
"greater than or equal to".

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 2 +-
 arch/powerpc/include/asm/hw_irq.h        | 4 ++--
 arch/powerpc/include/asm/irqflags.h      | 2 +-
 arch/powerpc/kernel/entry_64.S           | 4 ++--
 arch/powerpc/kernel/irq.c                | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index e24e63d216c4..44d3f539d8a5 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -408,7 +408,7 @@ label##_relon_hv:						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	r10,LAZY_INTERRUPT_DISABLED;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
-	beq	masked_##h##interrupt
+	bge	masked_##h##interrupt
 #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
 
 #define SOFTEN_TEST_PR(vec)						\
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 2b87930e0e82..b7c7f1c6706f 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -94,7 +94,7 @@ static inline unsigned long arch_local_irq_save(void)
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags == LAZY_INTERRUPT_DISABLED;
+	return flags >= LAZY_INTERRUPT_DISABLED;
 }
 
 static inline bool arch_irqs_disabled(void)
@@ -139,7 +139,7 @@ static inline void may_hard_irq_enable(void)
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
-	return (regs->softe == LAZY_INTERRUPT_DISABLED);
+	return (regs->softe >= LAZY_INTERRUPT_DISABLED);
 }
 
 extern bool prep_irq_for_idle(void);
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index 6091e46f2455..235055fabf65 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -52,7 +52,7 @@
 	li	__rA,LAZY_INTERRUPT_DISABLED;	\
 	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACAIRQHAPPENED(r13);	\
-	beq	44f;				\
+	bge	44f;				\
 	stb	__rA,PACASOFTIRQEN(r13);	\
 	TRACE_DISABLE_INTS;			\
 44:
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index cade169a7517..7ab6bfff653e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -766,7 +766,7 @@ restore:
 	ld	r5,SOFTE(r1)
 	lbz	r6,PACASOFTIRQEN(r13)
 	cmpwi	cr0,r5,LAZY_INTERRUPT_DISABLED
-	beq	restore_irq_off
+	bge	restore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
 	cmpwi	cr0,r6,LAZY_INTERRUPT_ENABLED
@@ -1012,7 +1012,7 @@ _GLOBAL(enter_rtas)
 	 * check it with the asm equivalent of WARN_ON
 	 */
 	lbz	r0,PACASOFTIRQEN(r13)
-1:	tdnei	r0,LAZY_INTERRUPT_DISABLED
+1:	tdeqi	r0,LAZY_INTERRUPT_ENABLED
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 	
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 9b9b6df8d83d..597c20d1814c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -202,7 +202,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 	/* Write the new soft-enabled value */
 	set_soft_enabled(en);
-	if (en == LAZY_INTERRUPT_DISABLED)
+	if (en >= LAZY_INTERRUPT_DISABLED)
 		return;
 	/*
 	 * From this point onward, we can take interrupts, preempt,
@@ -247,7 +247,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_TRACE_IRQFLAG */
 
-	set_soft_enabled(LAZY_INTERRUPT_DISABLED);
+	set_soft_enabled(en);
 
 	/*
 	 * Check if anything needs to be re-emitted. We haven't
-- 
2.7.4
