Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSbtm4Pm5zDrnt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 03:14:24 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85HD70m000903
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 13:14:21 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 258bu0de07-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 13:14:21 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 6 Sep 2016 03:14:18 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EB46E2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 03:14:15 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85HEFNt6357464
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 03:14:15 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85HEFJO012859
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 03:14:15 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v5 11/12] powerpc: Add a Kconfig and a function to set new
 soft_enabled mask
Date: Mon,  5 Sep 2016 22:42:54 +0530
In-Reply-To: <1473095575-21023-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473095575-21023-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1473095575-21023-12-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two new arch_local_irq_and_pmu_*() functions are added. These are primarily
intended to be used for disabling multiple interrupts. Also the current
arch_local_irq_save() have be modified to "OR" and "Store" value
instead of just "store" function. This is to avoid any lose of interrupts
bits incase of Nested arch_local_irq*()s.

New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add a warn_on
to alert the usage of arch_local_irq_and_pmu_save() for disabling lower
bitmask interrupts.

Have also moved the code under the CONFIG_TRACE_IRQFLAGS in
arch_local_irq_restore() to new Kconfig as suggested.

Patch also adds a new soft_irq_set_mask() to update paca->soft_enabled.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig              |  4 ++++
 arch/powerpc/include/asm/hw_irq.h | 26 +++++++++++++++++++++++++-
 arch/powerpc/kernel/irq.c         |  4 ++--
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 927d2ab2ce08..878f05925340 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -51,6 +51,10 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
+config IRQ_DEBUG_SUPPORT
+	bool
+	default n
+
 config LOCKDEP_SUPPORT
 	bool
 	default y
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 415734c07cfa..0b5fb60889ee 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -8,6 +8,7 @@
 
 #include <linux/errno.h>
 #include <linux/compiler.h>
+#include <linux/irqflags.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 
@@ -72,7 +73,7 @@ static inline unsigned long arch_local_irq_disable(void)
 	unsigned long flags, zero;
 
 	asm volatile(
-		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
+		"li %1,%3; lbz %0,%2(13); or %1,%0,%1; stb %1,%2(13)"
 		: "=r" (flags), "=&r" (zero)
 		: "i" (offsetof(struct paca_struct, soft_enabled)),\
 		  "i" (IRQ_DISABLE_MASK_LINUX)
@@ -81,8 +82,31 @@ static inline unsigned long arch_local_irq_disable(void)
 	return flags;
 }
 
+static inline unsigned long arch_local_irq_and_pmu_save(int value)
+{
+	unsigned long flags, zero;
+
+#ifdef CONFIG_IRQ_DEBUG_SUPPORT
+	WARN_ON(value & local_paca->soft_enabled) != local_paca->soft_enabled);
+#endif
+
+	asm volatile(
+		"li %1,%3; lbz %0,%2(13); or %1,%0,%1; stb %1,%2(13)"
+		: "=r" (flags), "=&r" (zero)
+		: "i" (offsetof(struct paca_struct, soft_enabled)),\
+		 "i" (value)
+		: "memory");
+
+	return flags;
+}
+
 extern void arch_local_irq_restore(unsigned long);
 
+static inline void arch_local_irq_and_pmu_restore(unsigned long flags)
+{
+	arch_local_irq_restore(flags);
+}
+
 static inline void arch_local_irq_enable(void)
 {
 	arch_local_irq_restore(IRQ_DISABLE_MASK_NONE);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2af3a933d117..a02c6a3bc6fa 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -248,7 +248,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	 */
 	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
 		__hard_irq_disable();
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_IRQ_DEBUG_SUPPORT
 	else {
 		/*
 		 * We should already be hard disabled here. We had bugs
@@ -259,7 +259,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 		if (WARN_ON(mfmsr() & MSR_EE))
 			__hard_irq_disable();
 	}
-#endif /* CONFIG_TRACE_IRQFLAGS */
+#endif /* CONFIG_IRQ_DEBUG_SUPPORT */
 
 	set_soft_enabled(IRQ_DISABLE_MASK_LINUX);
 
-- 
2.7.4
