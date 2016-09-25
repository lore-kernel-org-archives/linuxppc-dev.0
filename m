Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shqB30hlRzDrS8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 00:24:58 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8PEN2X1090268
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 10:24:57 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25p6aheh4v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 10:24:57 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 00:24:54 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DCB893578056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 00:24:51 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8PEOpEb38076492
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 00:24:51 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8PEOprv032606
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 00:24:51 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 09/11] powerpc:Add new kconfig IRQ_DEBUG_SUPPORT
Date: Sun, 25 Sep 2016 19:53:56 +0530
In-Reply-To: <1474813438-25761-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1474813438-25761-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1474813438-25761-10-git-send-email-maddy@linux.vnet.ibm.com>
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
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5ba60f6e7eb8..d1ee6c2a6b09 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -258,7 +258,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	 */
 	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
 		__hard_irq_disable();
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_IRQ_DEBUG_SUPPORT
 	else {
 		/*
 		 * We should already be hard disabled here. We had bugs
@@ -269,7 +269,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 		if (WARN_ON(mfmsr() & MSR_EE))
 			__hard_irq_disable();
 	}
-#endif /* CONFIG_TRACE_IRQFLAGS */
+#endif /* CONFIG_IRQ_DEBUG_SUPPORT */
 
 	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
 
-- 
2.7.4
