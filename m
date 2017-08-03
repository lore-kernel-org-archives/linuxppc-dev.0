Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNGLr52hnzDrJj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 13:51:16 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v733oD77096417
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 23:51:15 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3qmwbjuw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 23:51:15 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 13:51:12 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v733p1rt26149068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 13:51:09 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v733oaA8016242
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 13:50:37 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v9 13/14] powerpc: Add new set of soft_disable_mask_ functions
Date: Thu,  3 Aug 2017 09:19:17 +0530
In-Reply-To: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1501732158-19009-14-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/hw_irq.h | 60 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/irq.c         |  4 +++
 2 files changed, 64 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 8c1057b20b48..adb531cdf33b 100644
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
index f4dc72f1841d..297ee8a411f3 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -226,6 +226,10 @@ notrace void arch_local_irq_restore(unsigned long en)
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
