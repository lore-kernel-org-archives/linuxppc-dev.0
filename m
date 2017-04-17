Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w5r5960Y1zDqC5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 11:19:09 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3H1Iuon085901
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 21:18:59 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ug1wxamn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 21:18:59 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 11:18:57 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3H1IleR17367284
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 11:18:55 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3H1INqW023517
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 11:18:23 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v8 04/12] powerpc: Add soft_enabled manipulation functions
Date: Mon, 17 Apr 2017 06:47:29 +0530
In-Reply-To: <1492391857-8606-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1492391857-8606-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1492391857-8606-5-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add new soft_enabled_* manipulation function and implement
arch_local_* using the soft_enabled_* wrappers.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 88f6a8e2b5e3..c292ef4b4bc5 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -62,21 +62,7 @@ static inline notrace void soft_enabled_set(unsigned long enable)
 	: "memory");
 }
 
-static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
-{
-	unsigned long flags;
-
-	asm volatile(
-		"lbz %0,%1(13); stb %2,%1(13)"
-		: "=r" (flags)
-		: "i" (offsetof(struct paca_struct, soft_enabled)),\
-		  "r" (enable)
-		: "memory");
-
-	return flags;
-}
-
-static inline unsigned long arch_local_save_flags(void)
+static inline notrace unsigned long soft_enabled_return(void)
 {
 	unsigned long flags;
 
@@ -88,20 +74,30 @@ static inline unsigned long arch_local_save_flags(void)
 	return flags;
 }
 
-static inline unsigned long arch_local_irq_disable(void)
+static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
 {
 	unsigned long flags, zero;
 
 	asm volatile(
-		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
+		"mr %1,%3; lbz %0,%2(13); stb %1,%2(13)"
 		: "=r" (flags), "=&r" (zero)
 		: "i" (offsetof(struct paca_struct, soft_enabled)),\
-		  "i" (IRQ_DISABLE_MASK_LINUX)
+		  "r" (enable)
 		: "memory");
 
 	return flags;
 }
 
+static inline unsigned long arch_local_save_flags(void)
+{
+	return soft_enabled_return();
+}
+
+static inline unsigned long arch_local_irq_disable(void)
+{
+	return soft_enabled_set_return(IRQ_DISABLE_MASK_LINUX);
+}
+
 extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
-- 
2.7.4
