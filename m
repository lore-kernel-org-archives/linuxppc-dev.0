Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryklR4GyqzDrLF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:23 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PEnF1C030817
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:53:22 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c3vk85kt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:53:21 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 00:53:18 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E94062BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:16 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6PErGsh27000866
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:16 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6PErGRS012698
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:16 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH 8/9] powerpc: Support to replay PMIs
Date: Mon, 25 Jul 2016 20:22:21 +0530
In-Reply-To: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1469458342-26233-9-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Code to replay the Performance Monitoring Interrupts(PMI).
In the masked_interrupt handler, for PMIs we reset the MSR[EE]
and return. This is due the fact that PMIs are level triggered.
In the __check_irq_replay(), we enabled the MSR[EE] which will
fire the interrupt for us.

Patch also adds a new arch_local_irq_disable_var() variant. New
variant takes an input value to write to the paca->soft_enabled.
This will be used in following patch to implement the tri-state
value for soft-enabled.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 14 ++++++++++++++
 arch/powerpc/kernel/irq.c         |  9 ++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index cc69dde6eb84..863179654452 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -81,6 +81,20 @@ static inline unsigned long arch_local_irq_disable(void)
 	return flags;
 }
 
+static inline unsigned long arch_local_irq_disable_var(int value)
+{
+	unsigned long flags, zero;
+
+	asm volatile(
+		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
+		: "=r" (flags), "=&r" (zero)
+		: "i" (offsetof(struct paca_struct, soft_enabled)),\
+		  "i" (value)
+		: "memory");
+
+	return flags;
+}
+
 extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 597c20d1814c..81fe0da1f86d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -158,9 +158,16 @@ notrace unsigned int __check_irq_replay(void)
 	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow())
 		return 0x900;
 
+	/*
+	 * In masked_handler() for PMI, we disable MSR[EE] and return.
+	 * When replaying it, just enabling the MSR[EE] will do
+	 * trick, since the PMI are "level" triggered.
+	 */
+	local_paca->irq_happened &= ~PACA_IRQ_PMI;
+
 	/* Finally check if an external interrupt happened */
 	local_paca->irq_happened &= ~PACA_IRQ_EE;
-	if (happened & PACA_IRQ_EE)
+	if ((happened & PACA_IRQ_EE) || (happened & PACA_IRQ_PMI))
 		return 0x500;
 
 #ifdef CONFIG_PPC_BOOK3E
-- 
2.7.4
