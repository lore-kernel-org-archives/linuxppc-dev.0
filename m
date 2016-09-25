Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shq9V37CnzDrQx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 00:24:30 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8PEMpj4130898
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 10:24:28 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25p703dfx8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 10:24:28 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 00:24:25 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CD09B2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 00:24:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8PEONCI1966568
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 00:24:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8PEONCO032262
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 00:24:23 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 03/11] powerpc: Use soft_enabled_set api to update
 paca->soft_enabled
Date: Sun, 25 Sep 2016 19:53:50 +0530
In-Reply-To: <1474813438-25761-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1474813438-25761-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1474813438-25761-4-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Force use of soft_enabled_set() wrapper to update paca-soft_enabled
wherever possisble. Also add a new wrapper function, soft_enabled_set_return(),
added to force the paca->soft_enabled updates.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h  | 14 ++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h |  2 +-
 arch/powerpc/kernel/irq.c          |  2 +-
 arch/powerpc/kernel/setup_64.c     |  4 ++--
 arch/powerpc/kernel/time.c         |  6 +++---
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 45243c8579db..6d263168fc0a 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -62,6 +62,20 @@ static inline notrace void soft_enabled_set(unsigned long enable)
 	: "memory");
 }
 
+static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
+{
+	unsigned long flags;
+
+	asm volatile(
+		"lbz %0,%1(13); stb %2,%1(13)"
+		: "=r" (flags)
+		: "i" (offsetof(struct paca_struct, soft_enabled)),\
+		  "r" (enable)
+		: "memory");
+
+	return flags;
+}
+
 static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 740ee309cea8..07f6a51ae99f 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -707,7 +707,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	local_paca->soft_enabled = IRQ_DISABLE_MASK_NONE;
+	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
 #endif
 }
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5a926ea5bd0b..58462ce186fa 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -332,7 +332,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	local_paca->soft_enabled = IRQ_DISABLE_MASK_NONE;
+	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f31930b9bfc1..f0f882166dcc 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -197,7 +197,7 @@ static void __init fixup_boot_paca(void)
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
 	/* Mark interrupts disabled in PACA */
-	get_paca()->soft_enabled = IRQ_DISABLE_MASK_LINUX;
+	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
 }
 
 static void __init configure_exceptions(void)
@@ -334,7 +334,7 @@ void __init early_setup(unsigned long dt_ptr)
 void early_setup_secondary(void)
 {
 	/* Mark interrupts disabled in PACA */
-	get_paca()->soft_enabled = 0;
+	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7105757cdb90..483313aa311f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -259,7 +259,7 @@ static u64 scan_dispatch_log(u64 stop_tb)
 void accumulate_stolen_time(void)
 {
 	u64 sst, ust;
-	u8 save_soft_enabled = local_paca->soft_enabled;
+	unsigned long save_soft_enabled;
 	struct cpu_accounting_data *acct = &local_paca->accounting;
 
 	/* We are called early in the exception entry, before
@@ -268,7 +268,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;
+	save_soft_enabled = soft_enabled_set_return(IRQ_DISABLE_MASK_LINUX);
 
 	sst = scan_dispatch_log(acct->starttime_user);
 	ust = scan_dispatch_log(acct->starttime);
@@ -276,7 +276,7 @@ void accumulate_stolen_time(void)
 	acct->user_time -= ust;
 	local_paca->stolen_time += ust + sst;
 
-	local_paca->soft_enabled = save_soft_enabled;
+	soft_enabled_set(save_soft_enabled);
 }
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
-- 
2.7.4
