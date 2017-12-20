Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gtp5jFszF08V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:56:34 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3scwE133788
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:32 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eyf64j950-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:32 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:56:30 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 06/17] powerpc/64: Implement and use soft_enabled_return
 API
Date: Wed, 20 Dec 2017 09:25:46 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-7-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a new wrapper function, soft_enabled_return(), added to return
paca->soft_enabled value.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h | 21 +++++++++++++--------
 arch/powerpc/kernel/time.c        |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 6441a0498234..fbffeecb913f 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -49,6 +49,18 @@ extern void unknown_exception(struct pt_regs *regs);
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 
+static inline notrace unsigned long soft_enabled_return(void)
+{
+	unsigned long flags;
+
+	asm volatile(
+		"lbz %0,%1(13)"
+		: "=r" (flags)
+		: "i" (offsetof(struct paca_struct, soft_enabled)));
+
+	return flags;
+}
+
 /*
  * The "memory" clobber acts as both a compiler barrier
  * for the critical section and as a clobber because
@@ -66,14 +78,7 @@ static inline notrace void soft_enabled_set(unsigned long enable)
 
 static inline unsigned long arch_local_save_flags(void)
 {
-	unsigned long flags;
-
-	asm volatile(
-		"lbz %0,%1(13)"
-		: "=r" (flags)
-		: "i" (offsetof(struct paca_struct, soft_enabled)));
-
-	return flags;
+	return soft_enabled_return();
 }
 
 static inline void arch_local_irq_disable(void)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index f1ecf40fc6c1..9b483520c010 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -244,7 +244,7 @@ static u64 scan_dispatch_log(u64 stop_tb)
 void accumulate_stolen_time(void)
 {
 	u64 sst, ust;
-	u8 save_soft_enabled = local_paca->soft_enabled;
+	unsigned long save_soft_enabled = soft_enabled_return();
 	struct cpu_accounting_data *acct = &local_paca->accounting;
 
 	/* We are called early in the exception entry, before
-- 
2.7.4
