Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gtm0nF6zF08C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:56:31 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3sdQD079093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:30 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eyav94gu9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:29 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:56:28 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 05/17] powerpc/64: move set_soft_enabled(), rename it,
 add memory clobber
Date: Wed, 20 Dec 2017 09:25:45 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-6-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move set_soft_enabled() from powerpc/kernel/irq.c to asm/hw_irq.c, and
have existing open-coded updates to paca->soft_enabled go via this
access function.

Add a "memory" clobber to tell the compiler that paca->soft_enabled
has changed (gcc can't see the access through the r13 paca register).

It is renamed to soft_enabled_set(), which makes a prefix namespace
that is helpful when new soft_enabled manipulation functions are
introduced.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h  | 22 ++++++++++++++++------
 arch/powerpc/include/asm/kvm_ppc.h |  2 +-
 arch/powerpc/kernel/irq.c          | 14 ++++----------
 arch/powerpc/kernel/setup_64.c     |  4 ++--
 arch/powerpc/kernel/time.c         |  4 ++--
 5 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index a946b0285334..6441a0498234 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -49,6 +49,21 @@ extern void unknown_exception(struct pt_regs *regs);
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 
+/*
+ * The "memory" clobber acts as both a compiler barrier
+ * for the critical section and as a clobber because
+ * we changed paca->soft_enabled
+ */
+static inline notrace void soft_enabled_set(unsigned long enable)
+{
+	asm volatile(
+		"stb %0,%1(13)"
+		:
+		: "r" (enable),
+		  "i" (offsetof(struct paca_struct, soft_enabled))
+		: "memory");
+}
+
 static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
@@ -63,12 +78,7 @@ static inline unsigned long arch_local_save_flags(void)
 
 static inline void arch_local_irq_disable(void)
 {
-	asm volatile(
-		"stb %0,%1(13)"
-		:
-		: "r" (IRQ_DISABLED),
-		  "i" (offsetof(struct paca_struct, soft_enabled))
-		: "memory");
+	soft_enabled_set(IRQ_DISABLED);
 }
 
 extern void arch_local_irq_restore(unsigned long);
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 70a38ba46dc0..d038c627f07f 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -873,7 +873,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	local_paca->soft_enabled = IRQ_ENABLED;
+	soft_enabled_set(IRQ_ENABLED);
 #endif
 }
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 1ba8f6632cd2..bf519fc7913f 100644
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
@@ -231,7 +225,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	unsigned int replay;
 
 	/* Write the new soft-enabled value */
-	set_soft_enabled(en);
+	soft_enabled_set(en);
 	if (en == IRQ_DISABLED)
 		return;
 	/*
@@ -277,7 +271,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	set_soft_enabled(IRQ_DISABLED);
+	soft_enabled_set(IRQ_DISABLED);
 	trace_hardirqs_off();
 
 	/*
@@ -289,7 +283,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 	/* We can soft-enable now */
 	trace_hardirqs_on();
-	set_soft_enabled(IRQ_ENABLED);
+	soft_enabled_set(IRQ_ENABLED);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
@@ -364,7 +358,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	local_paca->soft_enabled = IRQ_ENABLED;
+	soft_enabled_set(IRQ_ENABLED);
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 909903f042ff..adb069af4baf 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -191,7 +191,7 @@ static void __init fixup_boot_paca(void)
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
 	/* Mark interrupts disabled in PACA */
-	get_paca()->soft_enabled = IRQ_DISABLED;
+	soft_enabled_set(IRQ_DISABLED);
 }
 
 static void __init configure_exceptions(void)
@@ -354,7 +354,7 @@ void __init early_setup(unsigned long dt_ptr)
 void early_setup_secondary(void)
 {
 	/* Mark interrupts disabled in PACA */
-	get_paca()->soft_enabled = 0;
+	soft_enabled_set(IRQ_DISABLED);
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index d0d730c61758..f1ecf40fc6c1 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -253,7 +253,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	local_paca->soft_enabled = IRQ_DISABLED;
+	soft_enabled_set(IRQ_DISABLED);
 
 	sst = scan_dispatch_log(acct->starttime_user);
 	ust = scan_dispatch_log(acct->starttime);
@@ -261,7 +261,7 @@ void accumulate_stolen_time(void)
 	acct->utime -= ust;
 	acct->steal_time += ust + sst;
 
-	local_paca->soft_enabled = save_soft_enabled;
+	soft_enabled_set(save_soft_enabled);
 }
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
-- 
2.7.4
