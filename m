Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb4NK3h5DzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 04:00:01 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7KHx059145827
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 14:00:00 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cefnrbf3c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:59 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 03:59:57 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7KHxrWs24838230
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7KHxiVI010294
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:44 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 13/14] powerpc: Add new set of soft_disable_mask_ functions
Date: Sun, 20 Aug 2017 23:28:30 +0530
In-Reply-To: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1503251911-30637-14-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To support disabling and enabling of irq with PMI, set of new
powerpc_local_irq_pmu_save() and powerpc_local_irq_restore()
functions are added. And powerpc_local_irq_save() implemented,
by adding a new soft_disable_mask manipulation function
soft_disable_mask_or_return(). Local_irq_pmu_* macros are
provided to access these powerpc_local_irq_pmu* functions
which includes trace_hardirqs_on|off() to match what we
have in include/linux/irqflags.h.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index f93de4b3b700..381e3a27c167 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -88,6 +88,20 @@ static inline notrace unsigned long soft_disable_mask_set_return(unsigned long e
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
@@ -120,6 +134,52 @@ static inline bool arch_irqs_disabled(void)
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
-- 
2.7.4
