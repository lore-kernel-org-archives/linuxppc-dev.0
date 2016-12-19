Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thtnh0KxpzDwKs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:51 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJ83iZt141918
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 03:07:49 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27dkfggrfg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 03:07:49 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 18:07:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A23052CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:44 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBJ87i6i32440348
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:44 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBJ87hCI028283
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:44 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v4 09/12] powerpc:Add new kconfig IRQ_DEBUG_SUPPORT
Date: Mon, 19 Dec 2016 13:37:05 +0530
In-Reply-To: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1482134828-18811-10-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add warn_on
to alert the invalid transitions. Also moved the code under
the CONFIG_TRACE_IRQFLAGS in arch_local_irq_restore() to new Kconfig.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig      | 4 ++++
 arch/powerpc/kernel/irq.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3da87e198878..70465b9d893c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -46,6 +46,10 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
+config IRQ_DEBUG_SUPPORT
+	bool
+	default n
+
 config LOCKDEP_SUPPORT
 	bool
 	default y
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index c030ccd0a7aa..299b55071612 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -263,7 +263,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	 */
 	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
 		__hard_irq_disable();
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_IRQ_DEBUG_SUPPORT
 	else {
 		/*
 		 * We should already be hard disabled here. We had bugs
@@ -274,7 +274,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 		if (WARN_ON(mfmsr() & MSR_EE))
 			__hard_irq_disable();
 	}
-#endif /* CONFIG_TRACE_IRQFLAGS */
+#endif /* CONFIG_IRQ_DEBUG_SUPPORT */
 
 	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
 
-- 
2.7.4
