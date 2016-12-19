Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thtnp5xvNzDwKv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:58 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJ83foe014107
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 03:07:57 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27eav1j04n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 03:07:56 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 18:07:54 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 972D62CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:52 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBJ87qjX47841386
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:52 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBJ87pLP028530
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:07:52 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v4 12/12] powerpc: Rename soft_enabled to soft_disabled_mask
Date: Mon, 19 Dec 2016 13:37:08 +0530
In-Reply-To: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1482134828-18811-13-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename the paca->soft_enabled to paca->soft_disabled_mask as
it is no more used as a flag for interrupt state.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h  | 32 ++++++++++++++++----------------
 arch/powerpc/include/asm/kvm_ppc.h |  2 +-
 arch/powerpc/include/asm/paca.h    |  2 +-
 arch/powerpc/kernel/asm-offsets.c  |  2 +-
 arch/powerpc/kernel/irq.c          | 10 +++++-----
 arch/powerpc/kernel/setup_64.c     |  4 ++--
 arch/powerpc/kernel/time.c         |  6 +++---
 arch/powerpc/mm/hugetlbpage.c      |  2 +-
 arch/powerpc/xmon/xmon.c           |  4 ++--
 9 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 7be90b73a943..e0c22f528aaf 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -29,7 +29,7 @@
 #define PACA_IRQ_PMI		0x40
 
 /*
- * flags for paca->soft_enabled
+ * flags for paca->soft_disabled_mask
  */
 #define IRQ_DISABLE_MASK_NONE	0
 #define IRQ_DISABLE_MASK_LINUX	1
@@ -52,52 +52,52 @@ extern void unknown_exception(struct pt_regs *regs);
 /*
  *TODO:
  * Currently none of the soft_eanbled modification helpers have clobbers
- * for modifying the r13->soft_enabled memory itself. Secondly they only
+ * for modifying the r13->soft_disabled_mask memory itself. Secondly they only
  * include "memory" clobber as a hint. Ideally, if all the accesses to
- * soft_enabled go via these helpers, we could avoid the "memory" clobber.
+ * soft_disabled_mask go via these helpers, we could avoid the "memory" clobber.
  * Former could be taken care by having location in the constraints.
  */
-static inline notrace void soft_enabled_set(unsigned long enable)
+static inline notrace void soft_disabled_mask_set(unsigned long enable)
 {
 	__asm__ __volatile__("stb %0,%1(13)"
-	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled))
+	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_disabled_mask))
 	: "memory");
 }
 
-static inline notrace unsigned long soft_enabled_return(void)
+static inline notrace unsigned long soft_disabled_mask_return(void)
 {
 	unsigned long flags;
 
 	asm volatile(
 		"lbz %0,%1(13)"
 		: "=r" (flags)
-		: "i" (offsetof(struct paca_struct, soft_enabled)));
+		: "i" (offsetof(struct paca_struct, soft_disabled_mask)));
 
 	return flags;
 }
 
-static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
+static inline notrace unsigned long soft_disabled_mask_set_return(unsigned long enable)
 {
 	unsigned long flags, zero;
 
 	asm volatile(
 		"mr %1,%3; lbz %0,%2(13); stb %1,%2(13)"
 		: "=r" (flags), "=&r" (zero)
-		: "i" (offsetof(struct paca_struct, soft_enabled)),\
+		: "i" (offsetof(struct paca_struct, soft_disabled_mask)),\
 		  "r" (enable)
 		: "memory");
 
 	return flags;
 }
 
-static inline notrace unsigned long soft_enabled_or_return(unsigned long enable)
+static inline notrace unsigned long soft_disabled_mask_or_return(unsigned long enable)
 {
 	unsigned long flags, zero;
 
 	asm volatile(
 		"mr %1,%3; lbz %0,%2(13); or %1,%0,%1; stb %1,%2(13)"
 		: "=r" (flags), "=&r"(zero)
-		: "i" (offsetof(struct paca_struct, soft_enabled)),\
+		: "i" (offsetof(struct paca_struct, soft_disabled_mask)),\
 		 "r" (enable)
 		: "memory");
 
@@ -106,12 +106,12 @@ static inline notrace unsigned long soft_enabled_or_return(unsigned long enable)
 
 static inline unsigned long arch_local_save_flags(void)
 {
-	return soft_enabled_return();
+	return soft_disabled_mask_return();
 }
 
 static inline unsigned long arch_local_irq_disable(void)
 {
-	return soft_enabled_set_return(IRQ_DISABLE_MASK_LINUX);
+	return soft_disabled_mask_set_return(IRQ_DISABLE_MASK_LINUX);
 }
 
 extern void arch_local_irq_restore(unsigned long);
@@ -145,7 +145,7 @@ static inline bool arch_irqs_disabled(void)
 #define raw_local_irq_pmu_save(flags)					\
 	do {								\
 		typecheck(unsigned long, flags);			\
-		flags = soft_enabled_or_return(IRQ_DISABLE_MASK_LINUX | \
+		flags = soft_disabled_mask_or_return(IRQ_DISABLE_MASK_LINUX | \
 				IRQ_DISABLE_MASK_PMU);			\
 	} while(0)
 
@@ -193,8 +193,8 @@ static inline bool arch_irqs_disabled(void)
 #define hard_irq_disable()	do {			\
 	u8 _was_enabled;				\
 	__hard_irq_disable();				\
-	_was_enabled = local_paca->soft_enabled;	\
-	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;\
+	_was_enabled = local_paca->soft_disabled_mask;	\
+	local_paca->soft_disabled_mask = IRQ_DISABLE_MASK_LINUX;\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
 	if (_was_enabled == IRQ_DISABLE_MASK_NONE)	\
 		trace_hardirqs_off();			\
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 1f384287ccaa..f89027cbe56f 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -778,7 +778,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
+	soft_disabled_mask_set(IRQ_DISABLE_MASK_NONE);
 #endif
 }
 
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 6a6792bb39fb..43a65abdaea8 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -154,7 +154,7 @@ struct paca_struct {
 	u64 saved_r1;			/* r1 save for RTAS calls or PM */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
-	u8 soft_enabled;		/* irq soft-enable flag */
+	u8 soft_disabled_mask;		/* irq soft disabled mask */
 	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 0601e6a7297c..dc146095dd5d 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -181,7 +181,7 @@ int main(void)
 	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
 	DEFINE(PACAKBASE, offsetof(struct paca_struct, kernelbase));
 	DEFINE(PACAKMSR, offsetof(struct paca_struct, kernel_msr));
-	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
+	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_disabled_mask));
 	DEFINE(PACAIRQHAPPENED, offsetof(struct paca_struct, irq_happened));
 #ifdef CONFIG_PPC_BOOK3S
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, mm_ctx_id));
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 9010f996e238..4fdb7be7ba6b 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -228,11 +228,11 @@ notrace void arch_local_irq_restore(unsigned long en)
 	unsigned int replay;
 
 #ifdef CONFIG_IRQ_DEBUG_SUPPORT
-	WARN_ON(en & local_paca->soft_enabled & ~IRQ_DISABLE_MASK_LINUX);
+	WARN_ON(en & local_paca->soft_disabled_mask & ~IRQ_DISABLE_MASK_LINUX);
 #endif
 
 	/* Write the new soft-enabled value */
-	soft_enabled_set(en);
+	soft_disabled_mask_set(en);
 
 	/* any bits still disabled */
 	if (en)
@@ -280,7 +280,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_IRQ_DEBUG_SUPPORT */
 
-	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
+	soft_disabled_mask_set(IRQ_DISABLE_MASK_LINUX);
 
 	/*
 	 * Check if anything needs to be re-emitted. We haven't
@@ -290,7 +290,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	replay = __check_irq_replay();
 
 	/* We can soft-enable now */
-	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
+	soft_disabled_mask_set(IRQ_DISABLE_MASK_NONE);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
@@ -364,7 +364,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
+	soft_disabled_mask_set(IRQ_DISABLE_MASK_NONE);
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 8e075487d559..01cc929b9f25 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -197,7 +197,7 @@ static void __init fixup_boot_paca(void)
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
 	/* Mark interrupts disabled in PACA */
-	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
+	soft_disabled_mask_set(IRQ_DISABLE_MASK_LINUX);
 }
 
 static void __init configure_exceptions(void)
@@ -342,7 +342,7 @@ void __init early_setup(unsigned long dt_ptr)
 void early_setup_secondary(void)
 {
 	/* Mark interrupts disabled in PACA */
-	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
+	soft_disabled_mask_set(IRQ_DISABLE_MASK_LINUX);
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 118a2503f10d..c4986fb36883 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -258,7 +258,7 @@ static u64 scan_dispatch_log(u64 stop_tb)
 void accumulate_stolen_time(void)
 {
 	u64 sst, ust;
-	unsigned long save_soft_enabled;
+	unsigned long save_soft_disabled_mask;
 	struct cpu_accounting_data *acct = &local_paca->accounting;
 
 	/* We are called early in the exception entry, before
@@ -267,7 +267,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	save_soft_enabled = soft_enabled_set_return(IRQ_DISABLE_MASK_LINUX);
+	save_soft_disabled_mask = soft_disabled_mask_set_return(IRQ_DISABLE_MASK_LINUX);
 
 	sst = scan_dispatch_log(acct->starttime_user);
 	ust = scan_dispatch_log(acct->starttime);
@@ -275,7 +275,7 @@ void accumulate_stolen_time(void)
 	acct->user_time -= ust;
 	local_paca->stolen_time += ust + sst;
 
-	soft_enabled_set(save_soft_enabled);
+	soft_disabled_mask_set(save_soft_disabled_mask);
 }
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index c340dfd2928e..d0ac7d67f027 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -890,7 +890,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  * So long as we atomically load page table pointers we are safe against teardown,
  * we can follow the address down to the the page and take a ref on it.
  * This function need to be called with interrupts disabled. We use this variant
- * when we have MSR[EE] = 0 but the paca->soft_enabled = IRQ_DISABLE_MASK_NONE
+ * when we have MSR[EE] = 0 but the paca->soft_disabled_mask = IRQ_DISABLE_MASK_NONE
  */
 
 pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17cf6886..33827a860ad9 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1541,7 +1541,7 @@ static void excprint(struct pt_regs *fp)
 	printf("  current = 0x%lx\n", current);
 #ifdef CONFIG_PPC64
 	printf("  paca    = 0x%lx\t softe: %d\t irq_happened: 0x%02x\n",
-	       local_paca, local_paca->soft_enabled, local_paca->irq_happened);
+	       local_paca, local_paca->soft_disabled_mask, local_paca->irq_happened);
 #endif
 	if (current) {
 		printf("    pid   = %ld, comm = %s\n",
@@ -2269,7 +2269,7 @@ static void dump_one_paca(int cpu)
 	DUMP(p, stab_rr, "lx");
 	DUMP(p, saved_r1, "lx");
 	DUMP(p, trap_save, "x");
-	DUMP(p, soft_enabled, "x");
+	DUMP(p, soft_disabled_mask, "x");
 	DUMP(p, irq_happened, "x");
 	DUMP(p, io_sync, "x");
 	DUMP(p, irq_work_pending, "x");
-- 
2.7.4
