Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNGLW6F81zDrKH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 13:50:59 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v733ntFV099278
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 23:50:57 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3snsy7xn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 23:50:57 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 13:50:55 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v733ohUo22413462
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 13:50:51 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v733oJF9015814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 13:50:19 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v9 05/14] powerpc/irq: Cleanup hard_irq_disable() macro
Date: Thu,  3 Aug 2017 09:19:09 +0530
In-Reply-To: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1501732158-19009-6-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Minor cleanup to use helper function for manipulating
paca->soft_enabled variable.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index f8c970600a12..bf07031c88e6 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -129,12 +129,11 @@ static inline bool arch_irqs_disabled(void)
 #endif
 
 #define hard_irq_disable()	do {			\
-	u8 _was_enabled;				\
+	unsigned long flags;				\
 	__hard_irq_disable();				\
-	_was_enabled = local_paca->soft_enabled;	\
-	local_paca->soft_enabled = IRQ_DISABLED;\
+	flags = soft_enabled_set_return(IRQ_DISABLED);	\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
-	if (_was_enabled == IRQ_ENABLED)	\
+	if (!arch_irqs_disabled_flags(flags))		\
 		trace_hardirqs_off();			\
 } while(0)
 
-- 
2.7.4
