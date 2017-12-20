Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gtt59b5zF08G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:56:38 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3sYmK072781
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:36 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eyecfm8kr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:35 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:56:33 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 07/17] powerpc/64: Implement and use
 soft_enabled_set_return API
Date: Wed, 20 Dec 2017 09:25:47 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-8-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a new wrapper function, soft_enabled_set_return(), added to do the
paca->soft_enabled updates requiring a set-return.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index fbffeecb913f..8b1476609ba7 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -76,6 +76,20 @@ static inline notrace void soft_enabled_set(unsigned long enable)
 		: "memory");
 }
 
+static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
+{
+	unsigned long flags;
+
+	asm volatile(
+		"lbz %0,%1(13); stb %2,%1(13)"
+		: "=&r" (flags)
+		: "i" (offsetof(struct paca_struct, soft_enabled)),
+		  "r" (enable)
+		: "memory");
+
+	return flags;
+}
+
 static inline unsigned long arch_local_save_flags(void)
 {
 	return soft_enabled_return();
@@ -95,16 +109,7 @@ static inline void arch_local_irq_enable(void)
 
 static inline unsigned long arch_local_irq_save(void)
 {
-	unsigned long flags;
-
-	asm volatile(
-		"lbz %0,%1(13); stb %2,%1(13)"
-		: "=&r" (flags)
-		: "i" (offsetof(struct paca_struct, soft_enabled)),
-		  "r" (IRQ_DISABLED)
-		: "memory");
-
-	return flags;
+	return soft_enabled_set_return(IRQ_DISABLED);
 }
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
-- 
2.7.4
