Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2xGw4v8BzDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:02:32 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3C7rwT5055026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:02:30 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29scje8fj4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:02:30 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 18:02:27 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3C82GAv47644776
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:02:24 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3C81lEv003291
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:01:47 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v7 10/11] powerpc: Add new set of soft_disable_mask_ functions
Date: Wed, 12 Apr 2017 13:30:39 +0530
In-Reply-To: <1491984040-28801-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491984040-28801-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491984040-28801-11-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To support disabling and enabling of irq with PMI, set of
new powerpc_local_irq_pmu_save() and powerpc_local_irq_restore()
functions are added. And powerpc_local_irq_save() implemented,
by adding a new soft_disable_mask manipulation function soft_disable_mask_or_return().
Local_irq_pmu_* macros are provided to access these powerpc_local_irq_pmu*
functions which includes trace_hardirqs_on|off() to match what we
have in include/linux/irqflags.h.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 62 ++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/irq.c         |  4 +++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index e21553e9bfc9..bf1d10f1b7fc 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -91,6 +91,20 @@ static inline notrace unsigned long soft_disable_mask_set_return(unsigned long e
 	return flags;
 }
 
+static inline notrace unsigned long soft_disable_mask_or_return(unsigned long enable)
+{
+	unsigned long flags, zero;
+
+	asm volatile(
+		"mr %1,%3; lbz %0,%2(13); or %1,%0,%1; stb %1,%2(13)"
+		: "=r" (flags), "=&r"(zero)
+		: "i" (offsetof(struct paca_struct, soft_disable_mask)),\
+		 "r" (enable)
+		: "memory");
+
+	return flags;
+}
+
 static inline unsigned long arch_local_save_flags(void)
 {
 	return soft_disable_mask_return();
@@ -115,7 +129,7 @@ static inline unsigned long arch_local_irq_save(void)
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags == IRQ_DISABLE_MASK_LINUX;
+	return flags & IRQ_DISABLE_MASK_LINUX;
 }
 
 static inline bool arch_irqs_disabled(void)
@@ -123,6 +137,52 @@ static inline bool arch_irqs_disabled(void)
 	return arch_irqs_disabled_flags(arch_local_save_flags());
 }
 
+/*
+ * To support disabling and enabling of irq with PMI, set of
+ * new powerpc_local_irq_pmu_save() and powerpc_local_irq_restore()
+ * functions are added. These macros are implemented using generic
+ * linux local_irq_* code from include/linux/irqflags.h.
+ */
+#define raw_local_irq_pmu_save(flags)					\
+	do {								\
+		typecheck(unsigned long, flags);			\
+		flags = soft_disable_mask_or_return(IRQ_DISABLE_MASK_LINUX | \
+				IRQ_DISABLE_MASK_PMU);			\
+	} while(0)
+
+#define raw_local_irq_pmu_restore(flags)				\
+	do {								\
+		typecheck(unsigned long, flags);			\
+		arch_local_irq_restore(flags);				\
+	} while(0)
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+#define powerpc_local_irq_pmu_save(flags)			\
+	 do {							\
+		raw_local_irq_pmu_save(flags);			\
+		trace_hardirqs_off();				\
+	} while(0)
+#define powerpc_local_irq_pmu_restore(flags)			\
+	do {							\
+		if (raw_irqs_disabled_flags(flags)) {		\
+			raw_local_irq_pmu_restore(flags);	\
+			trace_hardirqs_off();			\
+		} else {					\
+			trace_hardirqs_on();			\
+			raw_local_irq_pmu_restore(flags);	\
+		}						\
+	} while(0)
+#else
+#define powerpc_local_irq_pmu_save(flags)			\
+	do {							\
+		raw_local_irq_pmu_save(flags);			\
+	} while(0)
+#define powerpc_local_irq_pmu_restore(flags)			\
+	do {							\
+		raw_local_irq_pmu_restore(flags);		\
+	} while (0)
+#endif  /* CONFIG_TRACE_IRQFLAGS */
+
 #ifdef CONFIG_PPC_BOOK3E
 #define __hard_irq_enable()	asm volatile("wrteei 1" : : : "memory")
 #define __hard_irq_disable()	asm volatile("wrteei 0" : : : "memory")
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index fe16975ae788..38c63155f58c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -227,6 +227,10 @@ notrace void arch_local_irq_restore(unsigned long en)
 	unsigned char irq_happened;
 	unsigned int replay;
 
+#ifdef CONFIG_IRQ_DEBUG_SUPPORT
+	WARN_ON(en & local_paca->soft_disable_mask & ~IRQ_DISABLE_MASK_LINUX);
+#endif
+
 	/* Write the new soft-enabled value */
 	soft_disable_mask_set(en);
 	/* any bits still disabled */
-- 
2.7.4
