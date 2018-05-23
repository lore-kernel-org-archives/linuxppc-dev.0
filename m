Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPk90ZNgzDrnr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:47:29 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id az12-v6so12502561plb.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:47:28 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 05/29] KVM: PPC: Book3S PR: add new parameter (guest MSR)
 for kvmppc_save_tm()/kvmppc_restore_tm()
Date: Wed, 23 May 2018 15:01:48 +0800
Message-Id: <1527058932-7434-6-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

HV KVM and PR KVM need different MSR source to indicate whether
treclaim. or trecheckpoint. is necessary.

This patch add new parameter (guest MSR) for these kvmppc_save_tm/
kvmppc_restore_tm() APIs:
- For HV KVM, it is VCPU_MSR
- For PR KVM, it is current host MSR or VCPU_SHADOW_SRR1

This enhancement enables these 2 APIs to be reused by PR KVM later.
And the patch keeps HV KVM logic unchanged.

This patch also reworks kvmppc_save_tm()/kvmppc_restore_tm() to
have a clean ABI: r3 for vcpu and r4 for guest_msr.

During kvmppc_save_tm/kvmppc_restore_tm(), the R1 need to be saved
or restored. Currently the R1 is saved into HSTATE_HOST_R1. In PR
KVM, we are going to add a C function wrapper for
kvmppc_save_tm/kvmppc_restore_tm() where the R1 will be incremented
with added stackframe and save into HSTATE_HOST_R1. There are several
places in HV KVM to load HSTATE_HOST_R1 as R1, and we don't want to
bring risk or confusion by TM code.

This patch will use HSTATE_SCRATCH2 to save/restore R1 in
kvmppc_save_tm/kvmppc_restore_tm() to avoid future confusion, since
the r1 is actually a temporary/scratch value to be saved/stored.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 13 +++++-
 arch/powerpc/kvm/tm.S                   | 74 ++++++++++++++++-----------------
 2 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 4db2b10..6445d29 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -793,8 +793,12 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
+	mr      r3, r4
+	ld      r4, VCPU_MSR(r3)
 	bl	kvmppc_restore_tm
+	ld	r4, HSTATE_KVM_VCPU(r13)
 91:
+END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 
 	/* Load guest PMU registers */
@@ -1777,7 +1781,10 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
+	mr      r3, r9
+	ld      r4, VCPU_MSR(r3)
 	bl	kvmppc_save_tm
+	ld	r9, HSTATE_KVM_VCPU(r13)
 91:
 #endif
 
@@ -2680,7 +2687,8 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
-	ld	r9, HSTATE_KVM_VCPU(r13)
+	ld      r3, HSTATE_KVM_VCPU(r13)
+	ld      r4, VCPU_MSR(r3)
 	bl	kvmppc_save_tm
 91:
 #endif
@@ -2799,7 +2807,10 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
+	mr      r3, r4
+	ld      r4, VCPU_MSR(r3)
 	bl	kvmppc_restore_tm
+	ld	r4, HSTATE_KVM_VCPU(r13)
 91:
 #endif
 
diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
index e79b373..cbe608a 100644
--- a/arch/powerpc/kvm/tm.S
+++ b/arch/powerpc/kvm/tm.S
@@ -26,9 +26,12 @@
 
 /*
  * Save transactional state and TM-related registers.
- * Called with r9 pointing to the vcpu struct.
+ * Called with:
+ * - r3 pointing to the vcpu struct
+ * - r4 points to the MSR with current TS bits:
+ * 	(For HV KVM, it is VCPU_MSR ; For PR KVM, it is host MSR).
  * This can modify all checkpointed registers, but
- * restores r1, r2 and r9 (vcpu pointer) before exit.
+ * restores r1, r2 before exit.
  */
 _GLOBAL(kvmppc_save_tm)
 	mflr	r0
@@ -41,14 +44,11 @@ _GLOBAL(kvmppc_save_tm)
 	rldimi	r8, r0, MSR_TM_LG, 63-MSR_TM_LG
 	mtmsrd	r8
 
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	ld	r5, VCPU_MSR(r9)
-	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
+	rldicl. r4, r4, 64 - MSR_TS_S_LG, 62
 	beq	1f	/* TM not active in guest. */
-#endif
 
-	std	r1, HSTATE_HOST_R1(r13)
-	li	r3, TM_CAUSE_KVM_RESCHED
+	std	r1, HSTATE_SCRATCH2(r13)
+	std	r3, HSTATE_SCRATCH1(r13)
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 BEGIN_FTR_SECTION
@@ -65,7 +65,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_P9_TM_XER_SO_BUG, CPU_FTR_P9_TM_XER_SO_BUG, 96)
 3:
 	/* Emulation of the treclaim instruction needs TEXASR before treclaim */
 	mfspr	r6, SPRN_TEXASR
-	std	r6, VCPU_ORIG_TEXASR(r9)
+	std	r6, VCPU_ORIG_TEXASR(r3)
 6:
 END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 #endif
@@ -74,6 +74,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 	li	r5, 0
 	mtmsrd	r5, 1
 
+	li	r3, TM_CAUSE_KVM_RESCHED
+
 	/* All GPRs are volatile at this point. */
 	TRECLAIM(R3)
 
@@ -94,7 +96,7 @@ BEGIN_FTR_SECTION
 	 * we already have it), therefore we can now use any volatile GPR.
 	 */
 	/* Reload stack pointer and TOC. */
-	ld	r1, HSTATE_HOST_R1(r13)
+	ld	r1, HSTATE_SCRATCH2(r13)
 	ld	r2, PACATOC(r13)
 	/* Set MSR RI now we have r1 and r13 back. */
 	li	r5, MSR_RI
@@ -118,10 +120,9 @@ END_FTR_SECTION_NESTED(CPU_FTR_P9_TM_XER_SO_BUG, CPU_FTR_P9_TM_XER_SO_BUG, 96)
 	b	11f
 2:
 END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
-
-	ld	r9, HSTATE_KVM_VCPU(r13)
 #endif
 
+	ld	r9, HSTATE_SCRATCH1(r13)
 
 	/* Get a few more GPRs free. */
 	std	r29, VCPU_GPRS_TM(29)(r9)
@@ -153,7 +154,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 	std	r4, VCPU_GPRS_TM(9)(r9)
 
 	/* Reload stack pointer and TOC. */
-	ld	r1, HSTATE_HOST_R1(r13)
+	ld	r1, HSTATE_SCRATCH2(r13)
 	ld	r2, PACATOC(r13)
 
 	/* Set MSR RI now we have r1 and r13 back. */
@@ -208,9 +209,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 
 /*
  * Restore transactional state and TM-related registers.
- * Called with r4 pointing to the vcpu struct.
+ * Called with:
+ *  - r3 pointing to the vcpu struct.
+ *  - r4 is the guest MSR with desired TS bits:
+ * 	For HV KVM, it is VCPU_MSR
+ * 	For PR KVM, it is provided by caller
  * This potentially modifies all checkpointed registers.
- * It restores r1, r2, r4 from the PACA.
+ * It restores r1, r2 from the PACA.
  */
 _GLOBAL(kvmppc_restore_tm)
 	mflr	r0
@@ -229,9 +234,9 @@ _GLOBAL(kvmppc_restore_tm)
 	 * The user may change these outside of a transaction, so they must
 	 * always be context switched.
 	 */
-	ld	r5, VCPU_TFHAR(r4)
-	ld	r6, VCPU_TFIAR(r4)
-	ld	r7, VCPU_TEXASR(r4)
+	ld	r5, VCPU_TFHAR(r3)
+	ld	r6, VCPU_TFIAR(r3)
+	ld	r7, VCPU_TEXASR(r3)
 	mtspr	SPRN_TFHAR, r5
 	mtspr	SPRN_TFIAR, r6
 	mtspr	SPRN_TEXASR, r7
@@ -240,12 +245,10 @@ _GLOBAL(kvmppc_restore_tm)
 	li	r0, 0
 	stb	r0, HSTATE_FAKE_SUSPEND(r13)
 #endif
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	ld	r5, VCPU_MSR(r4)
+	mr	r5, r4
 	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
 	beqlr		/* TM not active in guest */
-#endif
-	std	r1, HSTATE_HOST_R1(r13)
+	std	r1, HSTATE_SCRATCH2(r13)
 
 	/* Make sure the failure summary is set, otherwise we'll program check
 	 * when we trechkpt.  It's possible that this might have been not set
@@ -272,21 +275,21 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 	 * some SPRs.
 	 */
 
-	mr	r31, r4
+	mr	r31, r3
 	addi	r3, r31, VCPU_FPRS_TM
 	bl	load_fp_state
 	addi	r3, r31, VCPU_VRS_TM
 	bl	load_vr_state
-	mr	r4, r31
-	lwz	r7, VCPU_VRSAVE_TM(r4)
+	mr	r3, r31
+	lwz	r7, VCPU_VRSAVE_TM(r3)
 	mtspr	SPRN_VRSAVE, r7
 
-	ld	r5, VCPU_LR_TM(r4)
-	lwz	r6, VCPU_CR_TM(r4)
-	ld	r7, VCPU_CTR_TM(r4)
-	ld	r8, VCPU_AMR_TM(r4)
-	ld	r9, VCPU_TAR_TM(r4)
-	ld	r10, VCPU_XER_TM(r4)
+	ld	r5, VCPU_LR_TM(r3)
+	lwz	r6, VCPU_CR_TM(r3)
+	ld	r7, VCPU_CTR_TM(r3)
+	ld	r8, VCPU_AMR_TM(r3)
+	ld	r9, VCPU_TAR_TM(r3)
+	ld	r10, VCPU_XER_TM(r3)
 	mtlr	r5
 	mtcr	r6
 	mtctr	r7
@@ -299,8 +302,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 	 * till the last moment to avoid running with userspace PPR and DSCR for
 	 * too long.
 	 */
-	ld	r29, VCPU_DSCR_TM(r4)
-	ld	r30, VCPU_PPR_TM(r4)
+	ld	r29, VCPU_DSCR_TM(r3)
+	ld	r30, VCPU_PPR_TM(r3)
 
 	std	r2, PACATMSCRATCH(r13) /* Save TOC */
 
@@ -332,9 +335,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	ld	r29, HSTATE_DSCR(r13)
 	mtspr	SPRN_DSCR, r29
-	ld	r4, HSTATE_KVM_VCPU(r13)
 #endif
-	ld	r1, HSTATE_HOST_R1(r13)
+	ld	r1, HSTATE_SCRATCH2(r13)
 	ld	r2, PACATMSCRATCH(r13)
 
 	/* Set the MSR RI since we have our registers back. */
@@ -353,10 +355,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 	b	9b		/* and return */
 10:	stdu	r1, -PPC_MIN_STKFRM(r1)
 	/* guest is in transactional state, so simulate rollback */
-	mr	r3, r4
 	bl	kvmhv_emulate_tm_rollback
 	nop
-	ld      r4, HSTATE_KVM_VCPU(r13) /* our vcpu pointer has been trashed */
 	addi	r1, r1, PPC_MIN_STKFRM
 	b	9b
 #endif
-- 
1.8.3.1
