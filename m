Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gth6CvGzF08K
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:56:28 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3sa31103576
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:26 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ey9mtqta8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:26 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:56:24 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 04/17] powerpc/64: Fix arch_local_irq_disable() prototype
Date: Wed, 20 Dec 2017 09:25:44 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-5-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In powerpc/64, the arch_local_irq_disable() function returns unsigned
long, which is not consistent with other architectures.

Move that set-return asm implementation into arch_local_irq_save(),
and make arch_local_irq_disable() return void, simplifying the
assembly.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index d1e76298e393..a946b0285334 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -61,18 +61,14 @@ static inline unsigned long arch_local_save_flags(void)
 	return flags;
 }
 
-static inline unsigned long arch_local_irq_disable(void)
+static inline void arch_local_irq_disable(void)
 {
-	unsigned long flags;
-
 	asm volatile(
-		"lbz %0,%1(13); stb %2,%1(13)"
-		: "=&r" (flags)
-		: "i" (offsetof(struct paca_struct, soft_enabled)),
-		  "r" (IRQ_DISABLED)
+		"stb %0,%1(13)"
+		:
+		: "r" (IRQ_DISABLED),
+		  "i" (offsetof(struct paca_struct, soft_enabled))
 		: "memory");
-
-	return flags;
 }
 
 extern void arch_local_irq_restore(unsigned long);
@@ -84,7 +80,16 @@ static inline void arch_local_irq_enable(void)
 
 static inline unsigned long arch_local_irq_save(void)
 {
-	return arch_local_irq_disable();
+	unsigned long flags;
+
+	asm volatile(
+		"lbz %0,%1(13); stb %2,%1(13)"
+		: "=&r" (flags)
+		: "i" (offsetof(struct paca_struct, soft_enabled)),
+		  "r" (IRQ_DISABLED)
+		: "memory");
+
+	return flags;
 }
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
-- 
2.7.4
