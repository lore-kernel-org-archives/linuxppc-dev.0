Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LN6Q4rZ4zF323
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 15:05:18 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc/tm: Reformat comments
Date: Thu, 27 Sep 2018 15:05:15 +1000
Message-Id: <20180927050515.25644-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The comments in this file don't conform to the coding style so take
them to "Comment Formatting Re-Education Camp"

Suggested-by: Michael "Camp Drill Sargent" Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/tm.S | 49 +++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 50e5cff10d..c954aecd9b 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -92,7 +92,8 @@ _GLOBAL(tm_abort)
 	blr
 EXPORT_SYMBOL_GPL(tm_abort);
 
-/* void tm_reclaim(struct thread_struct *thread,
+/*
+ * void tm_reclaim(struct thread_struct *thread,
  *		   uint8_t cause)
  *
  *	- Performs a full reclaim.  This destroys outstanding
@@ -163,14 +164,16 @@ _GLOBAL(tm_reclaim)
 	 */
 	TRECLAIM(R4)				/* Cause in r4 */
 
-	/* ******************** GPRs ******************** */
-	/* Stash the checkpointed r13 away in the scratch SPR and get the real
+	/*
+	 * ******************** GPRs ********************
+	 * Stash the checkpointed r13 away in the scratch SPR and get the real
 	 *  paca
 	 */
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 
-	/* Stash the checkpointed r1 away in paca tm_scratch and get the real
+	/*
+	 * Stash the checkpointed r1 away in paca tm_scratch and get the real
 	 * stack pointer back
 	 */
 	std	r1, PACATMSCRATCH(r13)
@@ -195,7 +198,8 @@ _GLOBAL(tm_reclaim)
 
 	addi	r7, r12, PT_CKPT_REGS		/* Thread's ckpt_regs */
 
-	/* Make r7 look like an exception frame so that we
+	/*
+	 * Make r7 look like an exception frame so that we
 	 * can use the neat GPRx(n) macros.  r7 is NOT a pt_regs ptr!
 	 */
 	subi	r7, r7, STACK_FRAME_OVERHEAD
@@ -223,7 +227,8 @@ _GLOBAL(tm_reclaim)
 	/* ******************** NIP ******************** */
 	mfspr	r3, SPRN_TFHAR
 	std	r3, _NIP(r7)			/* Returns to failhandler */
-	/* The checkpointed NIP is ignored when rescheduling/rechkpting,
+	/*
+	 * The checkpointed NIP is ignored when rescheduling/rechkpting,
 	 * but is used in signal return to 'wind back' to the abort handler.
 	 */
 
@@ -246,12 +251,14 @@ _GLOBAL(tm_reclaim)
 	std	r3, THREAD_TM_TAR(r12)
 	std	r4, THREAD_TM_DSCR(r12)
 
-	/* MSR and flags:  We don't change CRs, and we don't need to alter
+	/*
+	 * MSR and flags:  We don't change CRs, and we don't need to alter
 	 * MSR.
 	 */
 
 
-	/* ******************** FPR/VR/VSRs ************
+	/*
+	 * ******************** FPR/VR/VSRs ************
 	 * After reclaiming, capture the checkpointed FPRs/VRs.
 	 *
 	 * We enabled VEC/FP/VSX in the msr above, so we can execute these
@@ -277,7 +284,8 @@ _GLOBAL(tm_reclaim)
 	stfd    fr0,FPSTATE_FPSCR(r7)
 
 
-	/* TM regs, incl TEXASR -- these live in thread_struct.  Note they've
+	/*
+	 * TM regs, incl TEXASR -- these live in thread_struct.  Note they've
 	 * been updated by the treclaim, to explain to userland the failure
 	 * cause (aborted).
 	 */
@@ -313,7 +321,7 @@ _GLOBAL(tm_reclaim)
 	blr
 
 
-       /*
+	/*
 	 * void __tm_recheckpoint(struct thread_struct *thread)
 	 *	- Restore the checkpointed register state saved by tm_reclaim
 	 *	  when we switch_to a process.
@@ -329,7 +337,8 @@ _GLOBAL(__tm_recheckpoint)
 	std	r2, STK_GOT(r1)
 	stdu	r1, -TM_FRAME_SIZE(r1)
 
-	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD].
+	/*
+	 * We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD].
 	 * This is used for backing up the NVGPRs:
 	 */
 	SAVE_NVGPRS(r1)
@@ -338,7 +347,8 @@ _GLOBAL(__tm_recheckpoint)
 
 	addi	r7, r3, PT_CKPT_REGS		/* Thread's ckpt_regs */
 
-	/* Make r7 look like an exception frame so that we
+	/*
+	 * Make r7 look like an exception frame so that we
 	 * can use the neat GPRx(n) macros.  r7 is now NOT a pt_regs ptr!
 	 */
 	subi	r7, r7, STACK_FRAME_OVERHEAD
@@ -407,14 +417,15 @@ restore_gprs:
 
 	REST_NVGPRS(r7)				/* GPR14-31 */
 
-	/* Load up PPR and DSCR here so we don't run with user values for long
-	 */
+	/* Load up PPR and DSCR here so we don't run with user values for long */
 	mtspr	SPRN_DSCR, r5
 	mtspr	SPRN_PPR, r6
 
-	/* Do final sanity check on TEXASR to make sure FS is set.  Do this
+	/*
+	 * Do final sanity check on TEXASR to make sure FS is set.  Do this
 	 * here before we load up the userspace r1 so any bugs we hit will get
-	 * a call chain */
+	 * a call chain
+	 */
 	mfspr	r5, SPRN_TEXASR
 	srdi	r5, r5, 16
 	li	r6, (TEXASR_FS)@h
@@ -422,7 +433,8 @@ restore_gprs:
 1:	tdeqi	r6, 0
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0
 
-	/* Do final sanity check on MSR to make sure we are not transactional
+	/*
+	 * Do final sanity check on MSR to make sure we are not transactional
 	 * or suspended
 	 */
 	mfmsr   r6
@@ -470,7 +482,8 @@ restore_gprs:
 
 	HMT_MEDIUM
 
-	/* Our transactional state has now changed.
+	/*
+	 * Our transactional state has now changed.
 	 *
 	 * Now just get out of here.  Transactional (current) state will be
 	 * updated once restore is called on the return path in the _switch-ed
-- 
2.17.1
