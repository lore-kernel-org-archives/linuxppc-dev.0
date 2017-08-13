Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVLrV5m0RzDrCv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 11:34:34 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id j68so6796557pfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 18:34:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 7/9] powerpc/64s: do not allocate lppaca if we are not
 virtualized
Date: Sun, 13 Aug 2017 11:33:44 +1000
Message-Id: <20170813013346.14002-7-npiggin@gmail.com>
In-Reply-To: <20170812113416.15978-1-npiggin@gmail.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "lppaca" is a structure registered with the hypervisor. This
is unnecessary when running on non-virtualised platforms. One field
from the lppaca (pmcregs_in_use) is also used by the host, so move
the host part out into the paca (lppaca field is still updated in
guest mode).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/paca.h         |  8 ++++++--
 arch/powerpc/include/asm/pmc.h          | 10 +++++++++-
 arch/powerpc/kernel/asm-offsets.c       |  7 +++++++
 arch/powerpc/kernel/paca.c              | 16 +++++++++++++---
 arch/powerpc/kernel/prom.c              | 10 +++++++---
 arch/powerpc/kvm/book3s_hv_interrupts.S |  3 +--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  5 ++---
 7 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index dc88a31cc79a..de47c5a4f132 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -57,7 +57,7 @@ struct task_struct;
  * processor.
  */
 struct paca_struct {
-#ifdef CONFIG_PPC_BOOK3S
+#ifdef CONFIG_PPC_PSERIES
 	/*
 	 * Because hw_cpu_id, unlike other paca fields, is accessed
 	 * routinely from other CPUs (from the IRQ code), we stick to
@@ -66,7 +66,8 @@ struct paca_struct {
 	 */
 
 	struct lppaca *lppaca_ptr;	/* Pointer to LpPaca for PLIC */
-#endif /* CONFIG_PPC_BOOK3S */
+#endif /* CONFIG_PPC_PSERIES */
+
 	/*
 	 * MAGIC: the spinlock functions in arch/powerpc/lib/locks.c 
 	 * load lock_token and paca_index with a single lwz
@@ -158,6 +159,9 @@ struct paca_struct {
 	u64 saved_r1;			/* r1 save for RTAS calls or PM */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	u8 pmcregs_in_use;		/* pseries puts this in lppaca */
+#endif
 	u8 soft_enabled;		/* irq soft-enable flag */
 	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
diff --git a/arch/powerpc/include/asm/pmc.h b/arch/powerpc/include/asm/pmc.h
index 5a9ede4962cb..7b672a72cb0b 100644
--- a/arch/powerpc/include/asm/pmc.h
+++ b/arch/powerpc/include/asm/pmc.h
@@ -31,10 +31,18 @@ void ppc_enable_pmcs(void);
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/lppaca.h>
+#include <asm/firmware.h>
 
 static inline void ppc_set_pmu_inuse(int inuse)
 {
-	get_lppaca()->pmcregs_in_use = inuse;
+#ifdef CONFIG_PPC_PSERIES
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		get_lppaca()->pmcregs_in_use = inuse;
+#endif
+
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	get_paca()->pmcregs_in_use = inuse;
+#endif
 }
 
 extern void power4_enable_pmcs(void);
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 6e95c2c19a7e..831b277c91c7 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -221,12 +221,19 @@ int main(void)
 	OFFSET(PACA_EXMC, paca_struct, exmc);
 	OFFSET(PACA_EXSLB, paca_struct, exslb);
 	OFFSET(PACA_EXNMI, paca_struct, exnmi);
+#ifdef CONFIG_PPC_PSERIES
 	OFFSET(PACALPPACAPTR, paca_struct, lppaca_ptr);
+#endif
 	OFFSET(PACA_SLBSHADOWPTR, paca_struct, slb_shadow_ptr);
 	OFFSET(SLBSHADOW_STACKVSID, slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid);
 	OFFSET(SLBSHADOW_STACKESID, slb_shadow, save_area[SLB_NUM_BOLTED - 1].esid);
 	OFFSET(SLBSHADOW_SAVEAREA, slb_shadow, save_area);
+#ifdef CONFIG_PPC_PSERIES
 	OFFSET(LPPACA_PMCINUSE, lppaca, pmcregs_in_use);
+#endif
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	OFFSET(PACA_PMCINUSE, paca_struct, pmcregs_in_use);
+#endif
 	OFFSET(LPPACA_DTLIDX, lppaca, dtl_idx);
 	OFFSET(LPPACA_YIELDCOUNT, lppaca, yield_count);
 	OFFSET(PACA_DTL_RIDX, paca_struct, dtl_ridx);
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 354a955ca377..5afd96980679 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -20,7 +20,7 @@
 
 #include "setup.h"
 
-#ifdef CONFIG_PPC_BOOK3S
+#ifdef CONFIG_PPC_PSERIES
 
 /*
  * The structure which the hypervisor knows about - this structure
@@ -47,6 +47,9 @@ static long __initdata lppaca_size;
 
 static void __init allocate_lppacas(int nr_cpus, unsigned long limit)
 {
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		return;
+
 	if (nr_cpus <= NR_LPPACAS)
 		return;
 
@@ -60,6 +63,9 @@ static struct lppaca * __init new_lppaca(int cpu)
 {
 	struct lppaca *lp;
 
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		return NULL;
+
 	if (cpu < NR_LPPACAS)
 		return &lppaca[cpu];
 
@@ -73,6 +79,9 @@ static void __init free_lppacas(void)
 {
 	long new_size = 0, nr;
 
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		return;
+
 	if (!lppaca_size)
 		return;
 	nr = num_possible_cpus() - NR_LPPACAS;
@@ -157,9 +166,10 @@ EXPORT_SYMBOL(paca);
 
 void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 {
-#ifdef CONFIG_PPC_BOOK3S
+#ifdef CONFIG_PPC_PSERIES
 	new_paca->lppaca_ptr = new_lppaca(cpu);
-#else
+#endif
+#ifdef CONFIG_PPC_BOOK3E
 	new_paca->kernel_pgd = swapper_pg_dir;
 #endif
 	new_paca->lock_token = 0x8000;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f83056297441..6f29c6d1cb76 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -728,6 +728,13 @@ void __init early_init_devtree(void *params)
 	 * FIXME .. and the initrd too? */
 	move_device_tree();
 
+	/*
+	 * Now try to figure out if we are running on LPAR and so on
+	 * This must run before allocate_pacas() in order to allocate
+	 * lppacas or not.
+	 */
+	pseries_probe_fw_features();
+
 	allocate_pacas();
 
 	DBG("Scanning CPUs ...\n");
@@ -758,9 +765,6 @@ void __init early_init_devtree(void *params)
 #endif
 	epapr_paravirt_early_init();
 
-	/* Now try to figure out if we are running on LPAR and so on */
-	pseries_probe_fw_features();
-
 #ifdef CONFIG_PPC_PS3
 	/* Identify PS3 firmware */
 	if (of_flat_dt_is_compatible(of_get_flat_dt_root(), "sony,ps3"))
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index dc54373c8780..0e8493033288 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -79,8 +79,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	li	r5, 0
 	mtspr	SPRN_MMCRA, r5
 	isync
-	ld	r3, PACALPPACAPTR(r13)	/* is the host using the PMU? */
-	lbz	r5, LPPACA_PMCINUSE(r3)
+	lbz	r5, PACA_PMCINUSE(r13)	/* is the host using the PMU? */
 	cmpwi	r5, 0
 	beq	31f			/* skip if not */
 	mfspr	r5, SPRN_MMCR1
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c52184a8efdf..b838348e3a2b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -99,8 +99,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_SPRG_VDSO_WRITE,r3
 
 	/* Reload the host's PMU registers */
-	ld	r3, PACALPPACAPTR(r13)	/* is the host using the PMU? */
-	lbz	r4, LPPACA_PMCINUSE(r3)
+	lbz	r4, PACA_PMCINUSE(r13) /* is the host using the PMU? */
 	cmpwi	r4, 0
 	beq	23f			/* skip if not */
 BEGIN_FTR_SECTION
@@ -1671,7 +1670,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_MMCRA, r7
 	isync
 	beq	21f			/* if no VPA, save PMU stuff anyway */
-	lbz	r7, LPPACA_PMCINUSE(r8)
+	lbz	r7, PACA_PMCINUSE(r13)
 	cmpwi	r7, 0			/* did they ask for PMU stuff to be saved? */
 	bne	21f
 	std	r3, VCPU_MMCR(r9)	/* if not, set saved MMCR0 to FC */
-- 
2.13.3
