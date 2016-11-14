Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHdj548C6zDvXK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 05:05:13 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAEI4Bkp123495
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 13:05:11 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26qfswrdd5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 13:05:10 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 23:35:07 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 765371258026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:35:58 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAEI552i27787362
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:35:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAEI52HK010851
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:35:04 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v3 02/11] powerpc: move set_soft_enabled() and rename
Date: Mon, 14 Nov 2016 23:34:43 +0530
In-Reply-To: <1479146692-15726-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1479146692-15726-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1479146692-15726-3-git-send-email-maddy@linux.vnet.ibm.com>
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
index c6f1e13ff441..204fa51cdc9e 100644
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
