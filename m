Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKZGn0jlFzDsFs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 16:37:20 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7P6XmPf099287
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:37:19 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 250sc17ynm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:37:18 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 12:07:15 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CFEDA1258026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:10:31 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7P6bCXn62324978
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:07:12 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7P6av6j011164
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:07:12 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 03/12] powerpc: move set_soft_enabled()
Date: Thu, 25 Aug 2016 11:59:54 +0530
In-Reply-To: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472106603-23336-4-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move set_soft_enabled() from powerpc/kernel/irq.c to
asm/hw_irq.c. this way updation of paca->soft_enabled
can be forced wherever possible.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 6 ++++++
 arch/powerpc/kernel/irq.c         | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 1fcc2fd7275a..a7564b8a4831 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -47,6 +47,12 @@ extern void unknown_exception(struct pt_regs *regs);
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 
+static inline notrace void set_soft_enabled(unsigned long enable)
+{
+	__asm__ __volatile__("stb %0,%1(13)"
+	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
+}
+
 static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ed1123125063..7afa6bf96671 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -107,12 +107,6 @@ static inline notrace unsigned long get_irq_happened(void)
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
-- 
2.7.4
