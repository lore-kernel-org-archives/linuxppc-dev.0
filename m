Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHM9r57HfzDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:12:00 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id p1so1308182pfh.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:12:00 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 02/26] KVM: PPC: Book3S PR: add new parameter (guest MSR) for
 kvmppc_save_tm()/kvmppc_restore_tm()
Date: Thu, 11 Jan 2018 18:11:15 +0800
Message-Id: <1515665499-31710-3-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
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

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 12 ++++++-
 arch/powerpc/kvm/tm.S                   | 61 ++++++++++++++++++---------------
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index a5c8ecd..613fd27 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -808,7 +808,10 @@ BEGIN_FTR_SECTION
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
+	mr      r3, r4
+	ld      r4, VCPU_MSR(r3)
 	bl	kvmppc_restore_tm
+	ld	r4, HSTATE_KVM_VCPU(r13)
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 
@@ -1680,7 +1683,10 @@ BEGIN_FTR_SECTION
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
+	mr      r3, r9
+	ld      r4, VCPU_MSR(r3)
 	bl	kvmppc_save_tm
+	ld	r9, HSTATE_KVM_VCPU(r13)
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 
@@ -2543,7 +2549,8 @@ BEGIN_FTR_SECTION
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
-	ld	r9, HSTATE_KVM_VCPU(r13)
+	ld      r3, HSTATE_KVM_VCPU(r13)
+	ld      r4, VCPU_MSR(r3)
 	bl	kvmppc_save_tm
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
@@ -2656,7 +2663,10 @@ BEGIN_FTR_SECTION
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
+	mr      r3, r4
+	ld      r4, VCPU_MSR(r3)
 	bl	kvmppc_restore_tm
+	ld	r4, HSTATE_KVM_VCPU(r13)
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 
diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
index 072d35e..e779b15 100644
--- a/arch/powerpc/kvm/tm.S
+++ b/arch/powerpc/kvm/tm.S
@@ -28,9 +28,12 @@
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
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
@@ -42,11 +45,11 @@ _GLOBAL(kvmppc_save_tm)
 	rldimi	r8, r0, MSR_TM_LG, 63-MSR_TM_LG
 	mtmsrd	r8
 
-	ld	r5, VCPU_MSR(r9)
-	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
+	rldicl. r4, r4, 64 - MSR_TS_S_LG, 62
 	beq	1f	/* TM not active in guest. */
 
-	std	r1, HSTATE_HOST_R1(r13)
+	std	r1, HSTATE_SCRATCH2(r13)
+	std	r3, HSTATE_SCRATCH1(r13)
 	li	r3, TM_CAUSE_KVM_RESCHED
 
 	/* Clear the MSR RI since r1, r13 are all going to be foobar. */
@@ -60,7 +63,7 @@ _GLOBAL(kvmppc_save_tm)
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	std	r9, PACATMSCRATCH(r13)
-	ld	r9, HSTATE_KVM_VCPU(r13)
+	ld	r9, HSTATE_SCRATCH1(r13)
 
 	/* Get a few more GPRs free. */
 	std	r29, VCPU_GPRS_TM(29)(r9)
@@ -92,7 +95,7 @@ _GLOBAL(kvmppc_save_tm)
 	std	r4, VCPU_GPRS_TM(9)(r9)
 
 	/* Reload stack pointer and TOC. */
-	ld	r1, HSTATE_HOST_R1(r13)
+	ld	r1, HSTATE_SCRATCH2(r13)
 	ld	r2, PACATOC(r13)
 
 	/* Set MSR RI now we have r1 and r13 back. */
@@ -145,9 +148,13 @@ _GLOBAL(kvmppc_save_tm)
 
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
@@ -166,17 +173,17 @@ _GLOBAL(kvmppc_restore_tm)
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
 
-	ld	r5, VCPU_MSR(r4)
+	mr	r5, r4
 	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
 	beqlr		/* TM not active in guest */
-	std	r1, HSTATE_HOST_R1(r13)
+	std	r1, HSTATE_SCRATCH2(r13)
 
 	/* Make sure the failure summary is set, otherwise we'll program check
 	 * when we trechkpt.  It's possible that this might have been not set
@@ -192,21 +199,21 @@ _GLOBAL(kvmppc_restore_tm)
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
@@ -219,8 +226,8 @@ _GLOBAL(kvmppc_restore_tm)
 	 * till the last moment to avoid running with userspace PPR and DSCR for
 	 * too long.
 	 */
-	ld	r29, VCPU_DSCR_TM(r4)
-	ld	r30, VCPU_PPR_TM(r4)
+	ld	r29, VCPU_DSCR_TM(r3)
+	ld	r30, VCPU_PPR_TM(r3)
 
 	std	r2, PACATMSCRATCH(r13) /* Save TOC */
 
@@ -253,8 +260,7 @@ _GLOBAL(kvmppc_restore_tm)
 	ld	r29, HSTATE_DSCR(r13)
 	mtspr	SPRN_DSCR, r29
 #endif
-	ld	r4, HSTATE_KVM_VCPU(r13)
-	ld	r1, HSTATE_HOST_R1(r13)
+	ld	r1, HSTATE_SCRATCH2(r13)
 	ld	r2, PACATMSCRATCH(r13)
 
 	/* Set the MSR RI since we have our registers back. */
@@ -264,4 +270,5 @@ _GLOBAL(kvmppc_restore_tm)
 	ld	r0, PPC_LR_STKOFF(r1)
 	mtlr	r0
 	blr
+
 #endif
-- 
1.8.3.1
