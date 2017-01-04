Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttpyv2qYMzDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 22:50:15 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v04Bo26g050729
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 06:50:12 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27rx21wfuw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 06:50:12 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 4 Jan 2017 21:50:09 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 33E273578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 22:50:06 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v04Bo6T235520584
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 22:50:06 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v04Bo5u2010614
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 22:50:06 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v5 02/12] powerpc: move set_soft_enabled() and rename
Date: Wed,  4 Jan 2017 17:19:40 +0530
In-Reply-To: <1483530590-30274-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483530590-30274-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1483530590-30274-3-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/hw_irq.h | 15 +++++++++++++++
 arch/powerpc/kernel/irq.c         | 12 +++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 05b81bca15e9..ab1e6da7825c 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -47,6 +47,21 @@ extern void unknown_exception(struct pt_regs *regs);
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 
+/*
+ *TODO:
+ * Currently none of the soft_eanbled modification helpers have clobbers
+ * for modifying the r13->soft_enabled memory itself. Secondly they only
+ * include "memory" clobber as a hint. Ideally, if all the accesses to
+ * soft_enabled go via these helpers, we could avoid the "memory" clobber.
+ * Former could be taken care by having location in the constraints.
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
index 60c15fb05f45..a856e0fed7b6 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -108,12 +108,6 @@ static inline notrace unsigned long get_irq_happened(void)
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
@@ -213,7 +207,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	unsigned int replay;
 
 	/* Write the new soft-enabled value */
-	set_soft_enabled(en);
+	soft_enabled_set(en);
 	if (en == IRQ_DISABLE_MASK_LINUX)
 		return;
 	/*
@@ -259,7 +253,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	set_soft_enabled(IRQ_DISABLE_MASK_LINUX);
+	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
 
 	/*
 	 * Check if anything needs to be re-emitted. We haven't
@@ -269,7 +263,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	replay = __check_irq_replay();
 
 	/* We can soft-enable now */
-	set_soft_enabled(IRQ_DISABLE_MASK_NONE);
+	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
-- 
2.7.4
