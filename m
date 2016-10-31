Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6dNk6TRnzDvRF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 13:19:50 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: Jack Miller <jack@codezen.org>, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] Revert "powerpc: Load Monitor Register Support"
Date: Mon, 31 Oct 2016 13:19:39 +1100
Message-Id: <20161031021939.30989-2-mikey@neuling.org>
In-Reply-To: <20161031021939.30989-1-mikey@neuling.org>
References: <20161031021939.30989-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Load monitored is no longer supported on POWER9 so let's remove the
code.

This reverts commit bd3ea317fddfd0f2044f94bed294b90c4bc8e69e.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/processor.h |  2 --
 arch/powerpc/include/asm/reg.h       |  5 -----
 arch/powerpc/kernel/process.c        | 18 ------------------
 arch/powerpc/kernel/traps.c          |  9 ---------
 4 files changed, 34 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index c07c31b0e8..5c0a665af1 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -312,8 +312,6 @@ struct thread_struct {
 	unsigned long	mmcr2;
 	unsigned 	mmcr0;
 	unsigned 	used_ebb;
-	unsigned long	lmrr;
-	unsigned long	lmser;
 #endif
 };
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index cff79885c2..86ccd0ec43 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -292,8 +292,6 @@
 #define SPRN_HRMOR	0x139	/* Real mode offset register */
 #define SPRN_HSRR0	0x13A	/* Hypervisor Save/Restore 0 */
 #define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
-#define SPRN_LMRR	0x32D	/* Load Monitor Region Register */
-#define SPRN_LMSER	0x32E	/* Load Monitor Section Enable Register */
 #define SPRN_IC		0x350	/* Virtual Instruction Count */
 #define SPRN_VTB	0x351	/* Virtual Time Base */
 #define SPRN_LDBAR	0x352	/* LD Base Address Register */
@@ -304,7 +302,6 @@
 #define SPRN_PMCR	0x374	/* Power Management Control Register */
 
 /* HFSCR and FSCR bit numbers are the same */
-#define FSCR_LM_LG	11	/* Enable Load Monitor Registers */
 #define FSCR_TAR_LG	8	/* Enable Target Address Register */
 #define FSCR_EBB_LG	7	/* Enable Event Based Branching */
 #define FSCR_TM_LG	5	/* Enable Transactional Memory */
@@ -314,12 +311,10 @@
 #define FSCR_VECVSX_LG	1	/* Enable VMX/VSX  */
 #define FSCR_FP_LG	0	/* Enable Floating Point */
 #define SPRN_FSCR	0x099	/* Facility Status & Control Register */
-#define   FSCR_LM	__MASK(FSCR_LM_LG)
 #define   FSCR_TAR	__MASK(FSCR_TAR_LG)
 #define   FSCR_EBB	__MASK(FSCR_EBB_LG)
 #define   FSCR_DSCR	__MASK(FSCR_DSCR_LG)
 #define SPRN_HFSCR	0xbe	/* HV=1 Facility Status & Control Register */
-#define   HFSCR_LM	__MASK(FSCR_LM_LG)
 #define   HFSCR_TAR	__MASK(FSCR_TAR_LG)
 #define   HFSCR_EBB	__MASK(FSCR_EBB_LG)
 #define   HFSCR_TM	__MASK(FSCR_TM_LG)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9e7c10fe20..345d7b4687 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1051,14 +1051,6 @@ static inline void save_sprs(struct thread_struct *t)
 		 */
 		t->tar = mfspr(SPRN_TAR);
 	}
-
-	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		/* Conditionally save Load Monitor registers, if enabled */
-		if (t->fscr & FSCR_LM) {
-			t->lmrr = mfspr(SPRN_LMRR);
-			t->lmser = mfspr(SPRN_LMSER);
-		}
-	}
 #endif
 }
 
@@ -1094,16 +1086,6 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 		if (old_thread->tar != new_thread->tar)
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
-
-	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		/* Conditionally restore Load Monitor registers, if enabled */
-		if (new_thread->fscr & FSCR_LM) {
-			if (old_thread->lmrr != new_thread->lmrr)
-				mtspr(SPRN_LMRR, new_thread->lmrr);
-			if (old_thread->lmser != new_thread->lmser)
-				mtspr(SPRN_LMSER, new_thread->lmser);
-		}
-	}
 #endif
 }
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 023a462725..dbb4d23c37 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1430,7 +1430,6 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		[FSCR_TM_LG] = "TM",
 		[FSCR_EBB_LG] = "EBB",
 		[FSCR_TAR_LG] = "TAR",
-		[FSCR_LM_LG] = "LM",
 	};
 	char *facility = "unknown";
 	u64 value;
@@ -1488,14 +1487,6 @@ void facility_unavailable_exception(struct pt_regs *regs)
 			emulate_single_step(regs);
 		}
 		return;
-	} else if ((status == FSCR_LM_LG) && cpu_has_feature(CPU_FTR_ARCH_300)) {
-		/*
-		 * This process has touched LM, so turn it on forever
-		 * for this process
-		 */
-		current->thread.fscr |= FSCR_LM;
-		mtspr(SPRN_FSCR, current->thread.fscr);
-		return;
 	}
 
 	if (status == FSCR_TM_LG) {
-- 
2.9.3
