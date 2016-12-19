Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8c91db1zDwPh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:33 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id w68so3190870pgw.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:33 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 03/10] powerpc/64s: fix system reset vs general interrupt
 reentrancy
Date: Tue, 20 Dec 2016 04:30:04 +1000
Message-Id: <20161219183011.28310-4-npiggin@gmail.com>
In-Reply-To: <20161219183011.28310-1-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The system reset interrupt can occur when MSR_EE=0, and it currently
uses the PACA_EXGEN save area.

Some PACA_EXGEN interrupts have a window where MSR_RI=1 and MSR_EE=0
when the save area is still in use. A system reset interrupt in this
window can lead to undetected corruption when the save area gets
overwritten.

This patch introduces PACA_EXNMI save area for system reset exceptions,
which closes this corruption window. It's also helpful to retain the
EXGEN state for debugging situations, even if not considering the
recoverability aspect.

This patch also moves the PACA_EXMC area down to a less frequently used
part of the paca with the new save area.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 14 +++++++-------
 arch/powerpc/include/asm/paca.h          |  6 +++++-
 arch/powerpc/kernel/asm-offsets.c        |  3 ++-
 arch/powerpc/kernel/exceptions-64s.S     | 11 +++++++----
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 1e985382a73a..18eceba135cb 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -523,8 +523,8 @@ BEGIN_FTR_SECTION				\
 	beql	ppc64_runlatch_on_trampoline;	\
 END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 
-#define EXCEPTION_COMMON(trap, label, hdlr, ret, additions)	\
-	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);		\
+#define EXCEPTION_COMMON(area, trap, label, hdlr, ret, additions) \
+	EXCEPTION_PROLOG_COMMON(trap, area);			\
 	/* Volatile regs are potentially clobbered here */	\
 	additions;						\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
@@ -532,17 +532,17 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	b	ret
 
 #define STD_EXCEPTION_COMMON(trap, label, hdlr)			\
-	EXCEPTION_COMMON(trap, label, hdlr, ret_from_except,	\
-			 ADD_NVGPRS;ADD_RECONCILE)
+	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr,		\
+		ret_from_except, ADD_NVGPRS;ADD_RECONCILE)
 
 /*
  * Like STD_EXCEPTION_COMMON, but for exceptions that can occur
  * in the idle task and therefore need the special idle handling
  * (finish nap and runlatch)
  */
-#define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)		  \
-	EXCEPTION_COMMON(trap, label, hdlr, ret_from_except_lite, \
-			 FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON)
+#define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)		\
+	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr,		\
+		ret_from_except_lite, FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON)
 
 /*
  * When the idle code in power4_idle puts the CPU into NAP mode,
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 6a6792bb39fb..06e96648c1cb 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -99,7 +99,6 @@ struct paca_struct {
 	 */
 	/* used for most interrupts/exceptions */
 	u64 exgen[13] __attribute__((aligned(0x80)));
-	u64 exmc[13];		/* used for machine checks */
 	u64 exslb[13];		/* used for SLB/segment table misses
  				 * on the linear mapping */
 	/* SLB related definitions */
@@ -174,6 +173,11 @@ struct paca_struct {
 	u8 subcore_sibling_mask;
 #endif
 
+#ifdef CONFIG_PPC_STD_MMU_64
+	/* Non-maskable exceptions that are not performance critical */
+	u64 exnmi[13];		/* used for system reset (nmi) */
+	u64 exmc[13];		/* used for machine checks */
+#endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* Exclusive emergency stack pointer for machine check exception. */
 	void *mc_emergency_sp;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 0601e6a7297c..fa7087a2d825 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -225,8 +225,9 @@ int main(void)
 	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct, mm_ctx_sllp));
 #endif /* CONFIG_PPC_MM_SLICES */
 	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
-	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
 	DEFINE(PACA_EXSLB, offsetof(struct paca_struct, exslb));
+	DEFINE(PACA_EXNMI, offsetof(struct paca_struct, exnmi));
+	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
 	DEFINE(PACALPPACAPTR, offsetof(struct paca_struct, lppaca_ptr));
 	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
 	DEFINE(SLBSHADOW_STACKVSID,
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4573853dfff7..dd2bb0d785c6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -118,8 +118,8 @@ EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	clrrdi	r13,r13,1 /* Last bit of HSPRG0 is set if waking from winkle */
-	EXCEPTION_PROLOG_PSERIES_PACA(PACA_EXGEN, system_reset_common, EXC_STD,
-				 IDLETEST, 0x100)
+	EXCEPTION_PROLOG_PSERIES_PACA(PACA_EXNMI, system_reset_common,
+						EXC_STD, IDLETEST, 0x100)
 
 EXC_REAL_END(system_reset, 0x100, 0x200)
 EXC_VIRT_NONE(0x4100, 0x4200)
@@ -153,7 +153,10 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 2:	b	pnv_wakeup_noloss
 #endif
 
-EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
+EXC_COMMON_BEGIN(system_reset_common)
+	EXCEPTION_COMMON(PACA_EXNMI, 0x100,
+			system_reset, system_reset_exception,
+			ret_from_except, ADD_NVGPRS;ADD_RECONCILE)
 
 #ifdef CONFIG_PPC_PSERIES
 /*
@@ -161,7 +164,7 @@ EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
  */
 TRAMP_REAL_BEGIN(system_reset_fwnmi)
 	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
+	EXCEPTION_PROLOG_PSERIES(PACA_EXNMI, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
 #endif /* CONFIG_PPC_PSERIES */
 
-- 
2.11.0
