Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2X5G51f8zDqQL
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 05:06:58 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6VJ3edf060730
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 15:06:56 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gpcurust-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 15:06:56 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 05:06:52 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7FA1B3578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 05:06:50 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6VJ6oFJ32833666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 05:06:50 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6VJ6nXI009685
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 05:06:50 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 04/11] powerpc: Use set_soft_enabled api to update
 paca->soft_enabled
Date: Mon,  1 Aug 2016 00:36:22 +0530
In-Reply-To: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1469991989-28409-5-git-send-email-maddy@linux.vnet.ibm.com>
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
index fec6d5e92dab..103c5501982d 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -707,7 +707,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	local_paca->soft_enabled = IRQ_DISABLE_LEVEL_NONE;
+	set_soft_enabled(IRQ_DISABLE_LEVEL_NONE);
 #endif
 }
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 1d0e82a6c861..84edd25c8d51 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -331,7 +331,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	local_paca->soft_enabled = IRQ_DISABLE_LEVEL_NONE;
+	set_soft_enabled(IRQ_DISABLE_LEVEL_NONE);
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 8b60b894abeb..389caca3d5d2 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -206,7 +206,7 @@ static void fixup_boot_paca(void)
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
 	/* Mark interrupts disabled in PACA */
-	get_paca()->soft_enabled = IRQ_DISABLE_LEVEL_LINUX;
+	set_soft_enabled(IRQ_DISABLE_LEVEL_LINUX);
 }
 
 static void cpu_ready_for_interrupts(void)
@@ -325,7 +325,7 @@ void __init early_setup(unsigned long dt_ptr)
 void early_setup_secondary(void)
 {
 	/* Mark interrupts enabled in PACA */
-	get_paca()->soft_enabled = 0;
+	set_soft_enabled(IRQ_DISABLE_LEVEL_LINUX);
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 6bf2546ac372..42f6ca367b09 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -258,7 +258,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	local_paca->soft_enabled = IRQ_DISABLE_LEVEL_LINUX;
+	set_soft_enabled(IRQ_DISABLE_LEVEL_LINUX);
 
 	sst = scan_dispatch_log(local_paca->starttime_user);
 	ust = scan_dispatch_log(local_paca->starttime);
@@ -266,7 +266,7 @@ void accumulate_stolen_time(void)
 	local_paca->user_time -= ust;
 	local_paca->stolen_time += ust + sst;
 
-	local_paca->soft_enabled = save_soft_enabled;
+	set_soft_enabled(save_soft_enabled);
 }
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
-- 
2.7.4
