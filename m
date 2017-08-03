Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNGLZ43SWzDrJj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 13:51:02 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v733nXwg016668
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 23:50:59 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3r332b35-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 23:50:59 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 13:50:56 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v733okxA30474396
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 13:50:54 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v733oLnH015869
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 13:50:21 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v9 06/14] powerpc/irq: Fix arch_local_irq_disable() in book3s
Date: Thu,  3 Aug 2017 09:19:10 +0530
In-Reply-To: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1501732158-19009-7-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In powerpc book3s, arch_local_irq_disable() function is not a "void"
when compared to other arch. And only user for this function is
arch_local_irq_save().

Patch modify the arch_local_irq_save() and makes arch_local_irq_disable()
to use arch_local_irq_save() instead.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index bf07031c88e6..8abd18c15650 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -93,11 +93,6 @@ static inline unsigned long arch_local_save_flags(void)
 	return soft_enabled_return();
 }
 
-static inline unsigned long arch_local_irq_disable(void)
-{
-	return soft_enabled_set_return(IRQ_DISABLED);
-}
-
 extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
@@ -107,7 +102,12 @@ static inline void arch_local_irq_enable(void)
 
 static inline unsigned long arch_local_irq_save(void)
 {
-	return arch_local_irq_disable();
+	return soft_enabled_set_return(IRQ_DISABLED);
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	arch_local_irq_save();
 }
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
-- 
2.7.4
