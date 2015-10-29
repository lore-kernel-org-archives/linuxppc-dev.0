Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8A3C1A0CB1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 12:06:16 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/19] powerpc: Remove fp_enable() and vec_enable(),
 use msr_check_and_{set, clear}()
Date: Thu, 29 Oct 2015 11:44:07 +1100
Message-Id: <1446079451-8774-16-git-send-email-anton@samba.org>
In-Reply-To: <1446079451-8774-1-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

More consolidation of our MSR available bit handling.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/processor.h |  2 --
 arch/powerpc/kernel/fpu.S            | 16 ----------------
 arch/powerpc/kernel/process.c        |  6 ++++--
 arch/powerpc/kernel/vector.S         | 10 ----------
 4 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index a2e8918..ac23308 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -380,8 +380,6 @@ extern int set_endian(struct task_struct *tsk, unsigned int val);
 extern int get_unalign_ctl(struct task_struct *tsk, unsigned long adr);
 extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 
-extern void fp_enable(void);
-extern void vec_enable(void);
 extern void load_fp_state(struct thread_fp_state *fp);
 extern void store_fp_state(struct thread_fp_state *fp);
 extern void load_vr_state(struct thread_vr_state *vr);
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 431ab57..2117eac 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -77,22 +77,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 /*
- * Enable use of the FPU, and VSX if possible, for the caller.
- */
-_GLOBAL(fp_enable)
-	mfmsr	r3
-	ori	r3,r3,MSR_FP
-#ifdef CONFIG_VSX
-BEGIN_FTR_SECTION
-	oris	r3,r3,MSR_VSX@h
-END_FTR_SECTION_IFSET(CPU_FTR_VSX)
-#endif
-	SYNC
-	MTMSRD(r3)
-	isync			/* (not necessary for arch 2.02 and later) */
-	blr
-
-/*
  * Load state from memory into FP registers including FPSCR.
  * Assumes the caller has enabled FP in the MSR.
  */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1eafcee..9f8444b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -732,13 +732,15 @@ void restore_tm_state(struct pt_regs *regs)
 	msr_diff = current->thread.ckpt_regs.msr & ~regs->msr;
 	msr_diff &= MSR_FP | MSR_VEC | MSR_VSX;
 	if (msr_diff & MSR_FP) {
-		fp_enable();
+		msr_check_and_set(MSR_FP);
 		load_fp_state(&current->thread.fp_state);
+		msr_check_and_clear(MSR_FP);
 		regs->msr |= current->thread.fpexc_mode;
 	}
 	if (msr_diff & MSR_VEC) {
-		vec_enable();
+		msr_check_and_set(MSR_VEC);
 		load_vr_state(&current->thread.vr_state);
+		msr_check_and_clear(MSR_VEC);
 	}
 	regs->msr |= msr_diff;
 }
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 98675b0..162d0f7 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -33,16 +33,6 @@ _GLOBAL(do_load_up_transact_altivec)
 #endif
 
 /*
- * Enable use of VMX/Altivec for the caller.
- */
-_GLOBAL(vec_enable)
-	mfmsr	r3
-	oris	r3,r3,MSR_VEC@h
-	MTMSRD(r3)
-	isync
-	blr
-
-/*
  * Load state from memory into VMX registers including VSCR.
  * Assumes the caller has enabled VMX in the MSR.
  */
-- 
2.5.0
