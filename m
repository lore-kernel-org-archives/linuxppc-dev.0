Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb4ML2LHKzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:10 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7KHx1nP008762
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:07 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cfag21n6w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:07 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 03:59:04 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7KHx2nA26411010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:02 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7KHwqHs009465
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:58:52 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 02/14] powerpc: move set_soft_enabled() and rename
Date: Sun, 20 Aug 2017 23:28:19 +0530
In-Reply-To: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1503251911-30637-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move set_soft_enabled() from powerpc/kernel/irq.c to
asm/hw_irq.c, to force updates to paca-soft_enabled
done via these access function. Add "memory" clobber
to hint compiler since paca->soft_enabled memory is the target
here

Renaming it as soft_enabled_set() will make
namespaces works better as prefix than a postfix
when new soft_enabled manipulation functions introduced.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 12 ++++++++++++
 arch/powerpc/kernel/irq.c         | 12 +++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index d037a57700b9..a6bbda85a2a9 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -47,6 +47,18 @@ extern void unknown_exception(struct pt_regs *regs);
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 
+/*
+ * The "memory" clobber acts as both a compiler barrier
+ * for the critical section and as a clobber because
+ * we changed paca->soft_enabled
+ */
+static inline notrace void soft_enabled_set(unsigned long enable)
+{
+	__asm__ __volatile__("stb %0,%1(13)"
+	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled))
+	: "memory");
+}
+
 static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 1c92f0c6ef69..8f561ef3508c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -107,12 +107,6 @@ static inline notrace unsigned long get_irq_happened(void)
 	return happened;
 }
 
-static inline notrace void set_soft_enabled(unsigned long enable)
-{
-	__asm__ __volatile__("stb %0,%1(13)"
-	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
-}
-
 static inline notrace int decrementer_check_overflow(void)
 {
  	u64 now = get_tb_or_rtc();
@@ -225,7 +219,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	unsigned int replay;
 
 	/* Write the new soft-enabled value */
-	set_soft_enabled(en);
+	soft_enabled_set(en);
 	if (en == IRQ_DISABLED)
 		return;
 	/*
@@ -271,7 +265,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	set_soft_enabled(IRQ_DISABLED);
+	soft_enabled_set(IRQ_DISABLED);
 
 	/*
 	 * Check if anything needs to be re-emitted. We haven't
@@ -281,7 +275,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	replay = __check_irq_replay();
 
 	/* We can soft-enable now */
-	set_soft_enabled(IRQ_ENABLED);
+	soft_enabled_set(IRQ_ENABLED);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
-- 
2.7.4
