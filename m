Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMB02WgszF0YD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:12:08 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id z17so1866639pgc.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:12:08 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 04/26] KVM: PPC: Book3S PR: add C function wrapper for
 _kvmppc_save/restore_tm()
Date: Thu, 11 Jan 2018 18:11:17 +0800
Message-Id: <1515665499-31710-5-git-send-email-wei.guo.simon@gmail.com>
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

Currently _kvmppc_save/restore_tm() APIs can only be invoked from
assembly function. This patch adds C function wrappers for them so
that they can be safely called from C function.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/asm-prototypes.h |   7 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |   8 +--
 arch/powerpc/kvm/tm.S                     | 107 +++++++++++++++++++++++++++++-
 3 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 7330150..9c3b290 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -126,4 +126,11 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 void _mcount(void);
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip);
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+/* Transaction memory related */
+struct kvm_vcpu;
+void _kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
+void _kvmppc_save_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
+#endif
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 613fd27..4c8d5b1 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -810,7 +810,7 @@ BEGIN_FTR_SECTION
 	 */
 	mr      r3, r4
 	ld      r4, VCPU_MSR(r3)
-	bl	kvmppc_restore_tm
+	bl	__kvmppc_restore_tm
 	ld	r4, HSTATE_KVM_VCPU(r13)
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
@@ -1685,7 +1685,7 @@ BEGIN_FTR_SECTION
 	 */
 	mr      r3, r9
 	ld      r4, VCPU_MSR(r3)
-	bl	kvmppc_save_tm
+	bl	__kvmppc_save_tm
 	ld	r9, HSTATE_KVM_VCPU(r13)
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
@@ -2551,7 +2551,7 @@ BEGIN_FTR_SECTION
 	 */
 	ld      r3, HSTATE_KVM_VCPU(r13)
 	ld      r4, VCPU_MSR(r3)
-	bl	kvmppc_save_tm
+	bl	__kvmppc_save_tm
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 
@@ -2665,7 +2665,7 @@ BEGIN_FTR_SECTION
 	 */
 	mr      r3, r4
 	ld      r4, VCPU_MSR(r3)
-	bl	kvmppc_restore_tm
+	bl	__kvmppc_restore_tm
 	ld	r4, HSTATE_KVM_VCPU(r13)
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
index 2d6fe5b..5752bae 100644
--- a/arch/powerpc/kvm/tm.S
+++ b/arch/powerpc/kvm/tm.S
@@ -35,7 +35,7 @@
  * This can modify all checkpointed registers, but
  * restores r1, r2 before exit.
  */
-_GLOBAL(kvmppc_save_tm)
+_GLOBAL(__kvmppc_save_tm)
 	mflr	r0
 	std	r0, PPC_LR_STKOFF(r1)
 
@@ -149,6 +149,58 @@ _GLOBAL(kvmppc_save_tm)
 	blr
 
 /*
+ * _kvmppc_save_tm() is a wrapper around __kvmppc_save_tm(), so that it can
+ * be invoked from C function by PR KVM only.
+ */
+_GLOBAL(_kvmppc_save_tm_pr)
+	mflr	r5
+	std	r5, PPC_LR_STKOFF(r1)
+	stdu    r1, -SWITCH_FRAME_SIZE(r1)
+	SAVE_NVGPRS(r1)
+
+	/* save MSR since TM/math bits might be impacted
+	 * by __kvmppc_save_tm().
+	 */
+	mfmsr	r5
+	SAVE_GPR(5, r1)
+
+	/* also save DSCR/CR so that it can be recovered later */
+	mfspr   r6, SPRN_DSCR
+	SAVE_GPR(6, r1)
+
+	mfcr    r7
+	stw     r7, _CCR(r1)
+
+	/* allocate stack frame for __kvmppc_save_tm since
+	 * it will save LR into its stackframe and we don't
+	 * want to corrupt _kvmppc_save_tm_pr's.
+	 */
+	stdu    r1, -PPC_MIN_STKFRM(r1)
+	bl	__kvmppc_save_tm
+	addi    r1, r1, PPC_MIN_STKFRM
+
+	ld      r7, _CCR(r1)
+	mtcr	r7
+
+	REST_GPR(6, r1)
+	mtspr   SPRN_DSCR, r6
+
+	/* need preserve current MSR's MSR_TS bits */
+	REST_GPR(5, r1)
+	mfmsr   r6
+	rldicl  r6, r6, 64 - MSR_TS_S_LG, 62
+	rldimi  r5, r6, MSR_TS_S_LG, 63 - MSR_TS_T_LG
+	mtmsrd  r5
+
+	REST_NVGPRS(r1)
+	addi    r1, r1, SWITCH_FRAME_SIZE
+	ld	r5, PPC_LR_STKOFF(r1)
+	mtlr	r5
+	blr
+
+EXPORT_SYMBOL_GPL(_kvmppc_save_tm_pr);
+
+/*
  * Restore transactional state and TM-related registers.
  * Called with:
  *  - r3 pointing to the vcpu struct.
@@ -158,7 +210,7 @@ _GLOBAL(kvmppc_save_tm)
  * This potentially modifies all checkpointed registers.
  * It restores r1, r2 from the PACA.
  */
-_GLOBAL(kvmppc_restore_tm)
+_GLOBAL(__kvmppc_restore_tm)
 	mflr	r0
 	std	r0, PPC_LR_STKOFF(r1)
 
@@ -186,6 +238,7 @@ _GLOBAL(kvmppc_restore_tm)
 	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
 	beqlr		/* TM not active in guest */
 	std	r1, HSTATE_SCRATCH2(r13)
+	std	r3, HSTATE_SCRATCH1(r13)
 
 	/* Make sure the failure summary is set, otherwise we'll program check
 	 * when we trechkpt.  It's possible that this might have been not set
@@ -262,6 +315,7 @@ _GLOBAL(kvmppc_restore_tm)
 	ld	r29, HSTATE_DSCR(r13)
 	mtspr	SPRN_DSCR, r29
 #endif
+	ld	r3, HSTATE_SCRATCH1(r13)
 	ld	r1, HSTATE_SCRATCH2(r13)
 	ld	r2, PACATMSCRATCH(r13)
 
@@ -273,4 +327,53 @@ _GLOBAL(kvmppc_restore_tm)
 	mtlr	r0
 	blr
 
+/*
+ * _kvmppc_restore_tm() is a wrapper around __kvmppc_restore_tm(), so that it
+ * can be invoked from C function by PR KVM only.
+ */
+_GLOBAL(_kvmppc_restore_tm_pr)
+	mflr	r5
+	std	r5, PPC_LR_STKOFF(r1)
+	stdu    r1, -SWITCH_FRAME_SIZE(r1)
+	SAVE_NVGPRS(r1)
+
+	/* save MSR to avoid TM/math bits change */
+	mfmsr	r5
+	SAVE_GPR(5, r1)
+
+	/* also save DSCR/CR so that it can be recovered later */
+	mfspr   r6, SPRN_DSCR
+	SAVE_GPR(6, r1)
+
+	mfcr    r7
+	stw     r7, _CCR(r1)
+
+	/* allocate stack frame for __kvmppc_restore_tm since
+	 * it will save LR into its own stackframe.
+	 */
+	stdu    r1, -PPC_MIN_STKFRM(r1)
+
+	bl	__kvmppc_restore_tm
+	addi    r1, r1, PPC_MIN_STKFRM
+
+	ld      r7, _CCR(r1)
+	mtcr	r7
+
+	REST_GPR(6, r1)
+	mtspr   SPRN_DSCR, r6
+
+	/* need preserve current MSR's MSR_TS bits */
+	REST_GPR(5, r1)
+	mfmsr   r6
+	rldicl  r6, r6, 64 - MSR_TS_S_LG, 62
+	rldimi  r5, r6, MSR_TS_S_LG, 63 - MSR_TS_T_LG
+	mtmsrd  r5
+
+	REST_NVGPRS(r1)
+	addi    r1, r1, SWITCH_FRAME_SIZE
+	ld	r5, PPC_LR_STKOFF(r1)
+	mtlr	r5
+	blr
+
+EXPORT_SYMBOL_GPL(_kvmppc_restore_tm_pr);
 #endif
-- 
1.8.3.1
