Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb4Mw37ppzDqkh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:40 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7KHx141006670
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:34 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cehfu7xf6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:34 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 03:59:31 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7KHxUee40173616
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:30 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7KHxK2Z009887
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:21 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 08/14] powerpc: Rename soft_enabled to soft_disable_mask
Date: Sun, 20 Aug 2017 23:28:25 +0530
In-Reply-To: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1503251911-30637-9-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename the paca->soft_enabled to paca->soft_disable_mask as
it is no more used as a flag for interrupt state.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_irq.h  | 22 +++++++++++-----------
 arch/powerpc/include/asm/kvm_ppc.h |  2 +-
 arch/powerpc/include/asm/paca.h    |  2 +-
 arch/powerpc/kernel/asm-offsets.c  |  2 +-
 arch/powerpc/kernel/irq.c          | 10 +++++-----
 arch/powerpc/kernel/ptrace.c       |  2 +-
 arch/powerpc/kernel/setup_64.c     |  4 ++--
 arch/powerpc/kernel/time.c         |  6 +++---
 arch/powerpc/mm/hugetlbpage.c      |  2 +-
 arch/powerpc/xmon/xmon.c           |  4 ++--
 10 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index cfea88260e85..efbf5ebc03de 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -28,7 +28,7 @@
 #define PACA_IRQ_HMI		0x20
 
 /*
- * flags for paca->soft_enabled
+ * flags for paca->soft_disable_mask
  */
 #define IRQ_DISABLE_MASK_NONE	0
 #define IRQ_DISABLE_MASK_LINUX	1
@@ -50,35 +50,35 @@ extern void unknown_exception(struct pt_regs *regs);
 /*
  * The "memory" clobber acts as both a compiler barrier
  * for the critical section and as a clobber because
- * we changed paca->soft_enabled
+ * we changed paca->soft_disable_mask
  */
-static inline notrace void soft_enabled_set(unsigned long enable)
+static inline notrace void soft_disable_mask_set(unsigned long enable)
 {
 	__asm__ __volatile__("stb %0,%1(13)"
-	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled))
+	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_disable_mask))
 	: "memory");
 }
 
-static inline notrace unsigned long soft_enabled_return(void)
+static inline notrace unsigned long soft_disable_mask_return(void)
 {
 	unsigned long flags;
 
 	asm volatile(
 		"lbz %0,%1(13)"
 		: "=r" (flags)
-		: "i" (offsetof(struct paca_struct, soft_enabled)));
+		: "i" (offsetof(struct paca_struct, soft_disable_mask)));
 
 	return flags;
 }
 
-static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
+static inline notrace unsigned long soft_disable_mask_set_return(unsigned long enable)
 {
 	unsigned long flags, zero;
 
 	asm volatile(
 		"mr %1,%3; lbz %0,%2(13); stb %1,%2(13)"
 		: "=r" (flags), "=&r" (zero)
-		: "i" (offsetof(struct paca_struct, soft_enabled)),\
+		: "i" (offsetof(struct paca_struct, soft_disable_mask)),\
 		  "r" (enable)
 		: "memory");
 
@@ -87,7 +87,7 @@ static inline notrace unsigned long soft_enabled_set_return(unsigned long enable
 
 static inline unsigned long arch_local_save_flags(void)
 {
-	return soft_enabled_return();
+	return soft_disable_mask_return();
 }
 
 extern void arch_local_irq_restore(unsigned long);
@@ -99,7 +99,7 @@ static inline void arch_local_irq_enable(void)
 
 static inline unsigned long arch_local_irq_save(void)
 {
-	return soft_enabled_set_return(IRQ_DISABLE_MASK_LINUX);
+	return soft_disable_mask_set_return(IRQ_DISABLE_MASK_LINUX);
 }
 
 static inline void arch_local_irq_disable(void)
@@ -128,7 +128,7 @@ static inline bool arch_irqs_disabled(void)
 #define hard_irq_disable()	do {			\
 	unsigned long flags;				\
 	__hard_irq_disable();				\
-	flags = soft_enabled_set_return(IRQ_DISABLE_MASK_LINUX);\
+	flags = soft_disable_mask_set_return(IRQ_DISABLE_MASK_LINUX);\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
 	if (!arch_irqs_disabled_flags(flags))		\
 		trace_hardirqs_off();			\
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 0e90dbe46b5b..ec2086a76324 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -869,7 +869,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
+	soft_disable_mask_set(IRQ_DISABLE_MASK_NONE);
 #endif
 }
 
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index dc88a31cc79a..000b3b397b04 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -158,7 +158,7 @@ struct paca_struct {
 	u64 saved_r1;			/* r1 save for RTAS calls or PM */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
-	u8 soft_enabled;		/* irq soft-enable flag */
+	u8 soft_disable_mask;		/* mask for irq soft disable */
 	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 6e95c2c19a7e..0afb57036e6f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -178,7 +178,7 @@ int main(void)
 	OFFSET(PACATOC, paca_struct, kernel_toc);
 	OFFSET(PACAKBASE, paca_struct, kernelbase);
 	OFFSET(PACAKMSR, paca_struct, kernel_msr);
-	OFFSET(PACASOFTIRQEN, paca_struct, soft_enabled);
+	OFFSET(PACASOFTIRQEN, paca_struct, soft_disable_mask);
 	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
 #ifdef CONFIG_PPC_BOOK3S
 	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 8e8dfd022f15..6348b5d10ddd 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -219,11 +219,11 @@ notrace void arch_local_irq_restore(unsigned long en)
 	unsigned int replay;
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-	WARN_ON(en & soft_enabled_return() & ~IRQ_DISABLE_MASK_LINUX);
+	WARN_ON(en & soft_disable_mask_return() & ~IRQ_DISABLE_MASK_LINUX);
 #endif
 
 	/* Write the new soft-enabled value */
-	soft_enabled_set(en);
+	soft_disable_mask_set(en);
 	if (en == IRQ_DISABLE_MASK_LINUX)
 		return;
 	/*
@@ -269,7 +269,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
+	soft_disable_mask_set(IRQ_DISABLE_MASK_LINUX);
 
 	/*
 	 * Check if anything needs to be re-emitted. We haven't
@@ -279,7 +279,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	replay = __check_irq_replay();
 
 	/* We can soft-enable now */
-	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
+	soft_disable_mask_set(IRQ_DISABLE_MASK_NONE);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
@@ -354,7 +354,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
+	soft_disable_mask_set(IRQ_DISABLE_MASK_NONE);
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 39c139d46c09..595c1f163d04 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -284,7 +284,7 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 		return get_user_dscr(task, data);
 
 	/*
-	 * softe copies paca->soft_enabled variable state. Since soft_enabled is
+	 * softe copies paca->soft_disable_mask variable state. Since soft_disable_mask is
 	 * no more used as a flag, lets force usr to alway see the softe value as 1
 	 * which means interrupts are not soft disabled.
 	 */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 23a10bb0d5b6..de557830a689 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -189,7 +189,7 @@ static void __init fixup_boot_paca(void)
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
 	/* Mark interrupts disabled in PACA */
-	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
+	soft_disable_mask_set(IRQ_DISABLE_MASK_LINUX);
 }
 
 static void __init configure_exceptions(void)
@@ -345,7 +345,7 @@ void __init early_setup(unsigned long dt_ptr)
 void early_setup_secondary(void)
 {
 	/* Mark interrupts disabled in PACA */
-	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
+	soft_disable_mask_set(IRQ_DISABLE_MASK_LINUX);
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 96402dcb38d1..f505d8fe4c05 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -244,7 +244,7 @@ static u64 scan_dispatch_log(u64 stop_tb)
 void accumulate_stolen_time(void)
 {
 	u64 sst, ust;
-	unsigned long save_soft_enabled;
+	unsigned long save_soft_disable_mask;
 	struct cpu_accounting_data *acct = &local_paca->accounting;
 
 	/* We are called early in the exception entry, before
@@ -253,7 +253,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	save_soft_enabled = soft_enabled_set_return(IRQ_DISABLE_MASK_LINUX);
+	save_soft_disable_mask = soft_disable_mask_set_return(IRQ_DISABLE_MASK_LINUX);
 
 	sst = scan_dispatch_log(acct->starttime_user);
 	ust = scan_dispatch_log(acct->starttime);
@@ -261,7 +261,7 @@ void accumulate_stolen_time(void)
 	acct->utime -= ust;
 	acct->steal_time += ust + sst;
 
-	soft_enabled_set(save_soft_enabled);
+	soft_disable_mask_set(save_soft_disable_mask);
 }
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 4df4925a14d1..93a36680e95a 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -884,7 +884,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  * So long as we atomically load page table pointers we are safe against teardown,
  * we can follow the address down to the the page and take a ref on it.
  * This function need to be called with interrupts disabled. We use this variant
- * when we have MSR[EE] = 0 but the paca->soft_enabled = IRQ_DISABLE_MASK_NONE
+ * when we have MSR[EE] = 0 but the paca->soft_disable_mask = IRQ_DISABLE_MASK_NONE
  */
 
 pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 08e367e3e8c3..f9f4f2b1df29 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1580,7 +1580,7 @@ static void excprint(struct pt_regs *fp)
 	printf("  current = 0x%lx\n", current);
 #ifdef CONFIG_PPC64
 	printf("  paca    = 0x%lx\t softe: %d\t irq_happened: 0x%02x\n",
-	       local_paca, local_paca->soft_enabled, local_paca->irq_happened);
+	       local_paca, local_paca->soft_disable_mask, local_paca->irq_happened);
 #endif
 	if (current) {
 		printf("    pid   = %ld, comm = %s\n",
@@ -2310,7 +2310,7 @@ static void dump_one_paca(int cpu)
 	DUMP(p, stab_rr, "lx");
 	DUMP(p, saved_r1, "lx");
 	DUMP(p, trap_save, "x");
-	DUMP(p, soft_enabled, "x");
+	DUMP(p, soft_disable_mask, "x");
 	DUMP(p, irq_happened, "x");
 	DUMP(p, io_sync, "x");
 	DUMP(p, irq_work_pending, "x");
-- 
2.7.4
