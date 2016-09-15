Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZdqx6C5TzDsY2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 23:02:53 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FCw6TH091131
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 09:02:52 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fu1dv87d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 09:02:51 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 23:02:49 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 25EA83578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 23:02:46 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FD2kXk6881738
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 23:02:46 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FD2jDv032017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 23:02:45 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 12/13] powerpc: Add a Kconfig and a functions to set new
 soft_enabled mask
Date: Thu, 15 Sep 2016 18:32:02 +0530
In-Reply-To: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1473944523-624-13-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add warn_on
to alert the invalid transitions. Have also moved the code under
the CONFIG_TRACE_IRQFLAGS in arch_local_irq_restore() to new Kconfig
as suggested.

To support disabling and enabling of irq with PMI, set of
new powerpc_local_irq_pmu_save() and powerpc_local_irq_restore()
functions are added. And powerpc_local_irq_save() implemented,
by adding a new soft_enabled manipulation function soft_enabled_or_return().
Local_irq_pmu_* macros are provided to access these powerpc_local_irq_pmu*
functions which includes trace_hardirqs_on|off() to match what we
have in include/linux/irqflags.h.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig              |  4 +++
 arch/powerpc/include/asm/hw_irq.h | 69 ++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/irq.c         |  8 +++--
 3 files changed, 78 insertions(+), 3 deletions(-)

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
index 850fdffb59eb..86f9736fdbb1 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -81,6 +81,20 @@ static inline notrace unsigned long soft_enabled_set_return(unsigned long enable
 	return flags;
 }
 
+static inline notrace unsigned long soft_enabled_or_return(unsigned long enable)
+{
+	unsigned long flags, zero;
+
+	asm volatile(
+		"mr %1,%3; lbz %0,%2(13); or %1,%0,%1; stb %1,%2(13)"
+		: "=r" (flags), "=&r"(zero)
+		: "i" (offsetof(struct paca_struct, soft_enabled)),\
+		  "r" (enable)
+		: "memory");
+
+	return flags;
+}
+
 static inline unsigned long arch_local_save_flags(void)
 {
 	return soft_enabled_return();
@@ -105,7 +119,7 @@ static inline unsigned long arch_local_irq_save(void)
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags == IRQ_DISABLE_MASK_LINUX;
+	return (flags);
 }
 
 static inline bool arch_irqs_disabled(void)
@@ -113,6 +127,59 @@ static inline bool arch_irqs_disabled(void)
 	return arch_irqs_disabled_flags(arch_local_save_flags());
 }
 
+static inline void powerpc_local_irq_pmu_restore(unsigned long flags)
+{
+	arch_local_irq_restore(flags);
+}
+
+static inline unsigned long powerpc_local_irq_pmu_disable(void)
+{
+	return soft_enabled_or_return(IRQ_DISABLE_MASK_LINUX | IRQ_DISABLE_MASK_PMU);
+}
+
+static inline unsigned long powerpc_local_irq_pmu_save(void)
+{
+	return powerpc_local_irq_pmu_disable();
+}
+
+#define raw_local_irq_pmu_save(flags)					\
+	do {								\
+		typecheck(unsigned long, flags);			\
+		flags = powerpc_local_irq_pmu_save();			\
+	} while(0)
+
+#define raw_local_irq_pmu_restore(flags)				\
+	do {								\
+		typecheck(unsigned long, flags);			\
+		powerpc_local_irq_pmu_restore(flags);			\
+	} while(0)
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+#define local_irq_pmu_save(flags)		\
+	do {					\
+		raw_local_irq_pmu_save(flags);	\
+		trace_hardirqs_off();		\
+	} while(0)
+#define local_irq_pmu_restore(flags)			\
+	do {						\
+		if (raw_irqs_disabled_flags(flags)) {   \
+			raw_local_irq_pmu_restore(flags);\
+			trace_hardirqs_off();		\
+		} else {				\
+			trace_hardirqs_on();		\
+			raw_local_irq_pmu_restore(flags);\
+		}					\
+	} while(0)
+#else
+#define local_irq_pmu_save(flags)		\
+	do {					\
+		raw_local_irq_pmu_save(flags);	\
+	} while(0)
+#define local_irq_pmu_restore(flags)			\
+	do { raw_local_irq_pmu_restore(flags); } while (0)
+#endif /* CONFIG_TRACE_IRQFLAGS */
+
+
 #ifdef CONFIG_PPC_BOOK3E
 #define __hard_irq_enable()	asm volatile("wrteei 1" : : : "memory")
 #define __hard_irq_disable()	asm volatile("wrteei 0" : : : "memory")
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 9e5e9a6d4147..ae31b1e85fdb 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -209,6 +209,10 @@ notrace void arch_local_irq_restore(unsigned long en)
 	unsigned char irq_happened;
 	unsigned int replay;
 
+#ifdef CONFIG_IRQ_DEBUG_SUPPORT
+	WARN_ON(en & local_paca->soft_enabled & ~IRQ_DISABLE_MASK_LINUX);
+#endif
+
 	/* Write the new soft-enabled value */
 	soft_enabled_set(en);
 
@@ -245,7 +249,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	 */
 	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
 		__hard_irq_disable();
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_IRQ_DEBUG_SUPPORT
 	else {
 		/*
 		 * We should already be hard disabled here. We had bugs
@@ -256,7 +260,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 		if (WARN_ON(mfmsr() & MSR_EE))
 			__hard_irq_disable();
 	}
-#endif /* CONFIG_TRACE_IRQFLAGS */
+#endif /* CONFIG_IRQ_DEBUG_SUPPORT */
 
 	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
 
-- 
2.7.4
