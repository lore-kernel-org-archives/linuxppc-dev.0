Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSbsz1jPkzDrpy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 03:13:43 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85HD6Mo000808
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 13:13:40 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 258bu0dd74-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 13:13:40 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 6 Sep 2016 03:13:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5C7B12BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 03:13:34 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85HDYpC39649408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 03:13:34 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85HDXg5012242
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 03:13:34 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v5 04/12] powerpc: Use set_soft_enabled api to update
 paca->soft_enabled
Date: Mon,  5 Sep 2016 22:42:47 +0530
In-Reply-To: <1473095575-21023-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473095575-21023-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1473095575-21023-5-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h | 2 +-
 arch/powerpc/kernel/irq.c          | 2 +-
 arch/powerpc/kernel/setup_64.c     | 4 ++--
 arch/powerpc/kernel/time.c         | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 740ee309cea8..5624ec233664 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -707,7 +707,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	local_paca->soft_enabled = IRQ_DISABLE_MASK_NONE;
+	set_soft_enabled(IRQ_DISABLE_MASK_NONE);
 #endif
 }
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 7afa6bf96671..40af16a102bb 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -332,7 +332,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	local_paca->soft_enabled = IRQ_DISABLE_MASK_NONE;
+	set_soft_enabled(IRQ_DISABLE_MASK_NONE);
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f31930b9bfc1..4333cfc305f8 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -197,7 +197,7 @@ static void __init fixup_boot_paca(void)
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
 	/* Mark interrupts disabled in PACA */
-	get_paca()->soft_enabled = IRQ_DISABLE_MASK_LINUX;
+	set_soft_enabled(IRQ_DISABLE_MASK_LINUX);
 }
 
 static void __init configure_exceptions(void)
@@ -334,7 +334,7 @@ void __init early_setup(unsigned long dt_ptr)
 void early_setup_secondary(void)
 {
 	/* Mark interrupts disabled in PACA */
-	get_paca()->soft_enabled = 0;
+	set_soft_enabled(IRQ_DISABLE_MASK_LINUX);
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7105757cdb90..d2aa6888db43 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -268,7 +268,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;
+	set_soft_enabled(IRQ_DISABLE_MASK_LINUX);
 
 	sst = scan_dispatch_log(acct->starttime_user);
 	ust = scan_dispatch_log(acct->starttime);
@@ -276,7 +276,7 @@ void accumulate_stolen_time(void)
 	acct->user_time -= ust;
 	local_paca->stolen_time += ust + sst;
 
-	local_paca->soft_enabled = save_soft_enabled;
+	set_soft_enabled(save_soft_enabled);
 }
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
-- 
2.7.4
