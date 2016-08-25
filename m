Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKZ7H09g7zDrfH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 16:30:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7P6SMqd064650
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:30:48 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 250wupu0pt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:30:48 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 12:00:44 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 47C063940062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:41 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7P6UfMR21364898
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:41 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7P6Uc8p031684
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:40 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 08/12] powerpc: Introduce new mask bit for soft_enabled
Date: Thu, 25 Aug 2016 11:59:59 +0530
In-Reply-To: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472106603-23336-9-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently soft_enabled is used as the flag to determine
the interrupt state. Patch extends the soft_enabled
to be used as a mask instead of a flag. So, each MASKABLE_*
macro will carry additionaly "bitmask" paramater to specify
the interrupt maskable level.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 4 ++--
 arch/powerpc/include/asm/hw_irq.h        | 1 +
 arch/powerpc/include/asm/irqflags.h      | 4 ++--
 arch/powerpc/kernel/entry_64.S           | 4 ++--
 arch/powerpc/kernel/exceptions-64e.S     | 6 +++---
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index dd3253bd0d8e..1eea4ab75607 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -430,9 +430,9 @@ label##_relon_hv:						\
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	cmpwi	r10,IRQ_DISABLE_MASK_LINUX;							\
+	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
-	beq	masked_##h##interrupt
+	bne	masked_##h##interrupt
 #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
 
 #define SOFTEN_TEST_PR(vec)						\
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index c19169ac1fbb..e457438c6fdf 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -32,6 +32,7 @@
  */
 #define IRQ_DISABLE_MASK_NONE		0
 #define IRQ_DISABLE_MASK_LINUX		1
+#define IRQ_DISABLE_MASK_PMU		2
 
 #endif /* CONFIG_PPC64 */
 
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index d0ed2a7d7d10..9ff09747a226 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -48,11 +48,11 @@
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACASOFTIRQEN(r13);	\
 	lbz	__rB,PACAIRQHAPPENED(r13);	\
-	cmpwi	cr0,__rA,IRQ_DISABLE_MASK_LINUX;\
+	andi.	__rA,__rA,IRQ_DISABLE_MASK_LINUX;\
 	li	__rA,IRQ_DISABLE_MASK_LINUX;	\
 	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACAIRQHAPPENED(r13);	\
-	beq	44f;				\
+	bne	44f;				\
 	stb	__rA,PACASOFTIRQEN(r13);	\
 	TRACE_DISABLE_INTS;			\
 44:
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b50d79e5bfbc..99bab5c65734 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -764,8 +764,8 @@ restore:
 	 */
 	ld	r5,SOFTE(r1)
 	lbz	r6,PACASOFTIRQEN(r13)
-	cmpwi	cr0,r5,IRQ_DISABLE_MASK_LINUX
-	beq	restore_irq_off
+	andi.	r5,r5,IRQ_DISABLE_MASK_LINUX
+	bne	restore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
 	cmpwi	cr0,r6,IRQ_DISABLE_MASK_NONE
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 5c628b5696f6..8e40df2c2f30 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -212,8 +212,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	/* Interrupts had better not already be enabled... */
 	twnei	r6,IRQ_DISABLE_MASK_LINUX
 
-	cmpwi	cr0,r5,IRQ_DISABLE_MASK_LINUX
-	beq	1f
+	andi.	r5,r5,IRQ_DISABLE_MASK_LINUX
+	bne	1f
 
 	TRACE_ENABLE_INTS
 	stb	r5,PACASOFTIRQEN(r13)
@@ -352,7 +352,7 @@ ret_from_mc_except:
 
 #define PROLOG_ADDITION_MASKABLE_GEN(n)					    \
 	lbz	r10,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
-	cmpwi	cr0,r10,IRQ_DISABLE_MASK_LINUX;/* yes -> go out of line */ \
+	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;/* yes -> go out of line */ \
 	beq	masked_interrupt_book3e_##n
 
 #define PROLOG_ADDITION_2REGS_GEN(n)					    \
-- 
2.7.4
