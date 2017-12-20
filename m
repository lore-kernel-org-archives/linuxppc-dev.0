Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gvH5jHYzF08M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:56:59 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3uU0n125509
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:58 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eyb87ks5x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:57 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:56:55 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 14/17] powerpc: Add new kconfig IRQ_DEBUG_SUPPORT
Date: Wed, 20 Dec 2017 09:25:54 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-15-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add warn_on to
alert the invalid transitions. Also moved the code under the
CONFIG_TRACE_IRQFLAGS in arch_local_irq_restore() to new Kconfig.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig.debug        | 4 ++++
 arch/powerpc/include/asm/hw_irq.h | 4 ++--
 arch/powerpc/kernel/entry_64.S    | 4 ++--
 arch/powerpc/kernel/irq.c         | 4 ++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 657c33cd4eee..8013c62f38a7 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -90,6 +90,10 @@ config MSI_BITMAP_SELFTEST
 	depends on DEBUG_KERNEL
 	default n
 
+config PPC_IRQ_SOFT_MASK_DEBUG
+	bool "Include extra checks for powerpc irq soft masking"
+	default n
+
 config XMON
 	bool "Include xmon kernel debugger"
 	depends on DEBUG_KERNEL
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 6249ebc17608..716fe87a3588 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -71,7 +71,7 @@ static inline notrace unsigned long irq_soft_mask_return(void)
  */
 static inline notrace void irq_soft_mask_set(unsigned long mask)
 {
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
 	/*
 	 * The irq mask must always include the STD bit if any are set.
 	 *
@@ -101,7 +101,7 @@ static inline notrace unsigned long irq_soft_mask_set_return(unsigned long mask)
 {
 	unsigned long flags;
 
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
 	WARN_ON(mask && !(mask & IRQ_SOFT_MASK_STD));
 #endif
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 511a97b62075..f2ffb9aa7ff4 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -128,7 +128,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	 * of irq tracing is used, we additionally check that condition
 	 * is correct
 	 */
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
+#if defined(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG) && defined(CONFIG_BUG)
 	lbz	r10,PACAIRQSOFTMASK(r13)
 1:	tdnei	r10,IRQ_SOFT_MASK_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
@@ -911,7 +911,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
 	stb	r7,PACAIRQHAPPENED(r13)
 1:
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
+#if defined(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG) && defined(CONFIG_BUG)
 	/* The interrupt should not have soft enabled. */
 	lbz	r7,PACAIRQSOFTMASK(r13)
 	tdeqi	r7,IRQ_SOFT_MASK_NONE
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 1cbf6a0caed7..e7619d144c15 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -264,7 +264,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	 */
 	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
 		__hard_irq_disable();
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
 	else {
 		/*
 		 * We should already be hard disabled here. We had bugs
@@ -275,7 +275,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 		if (WARN_ON(mfmsr() & MSR_EE))
 			__hard_irq_disable();
 	}
-#endif /* CONFIG_TRACE_IRQFLAGS */
+#endif
 
 	irq_soft_mask_set(IRQ_SOFT_MASK_ALL);
 	trace_hardirqs_off();
-- 
2.7.4
