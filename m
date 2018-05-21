Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5nM6WDfzF0dY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:45:43 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id c19-v6so8046156pls.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 21:45:43 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 07/29] KVM: PPC: Book3S PR: add C function wrapper for
 _kvmppc_save/restore_tm()
Date: Mon, 21 May 2018 12:09:24 +0800
Message-Id: <1526875786-10372-8-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
References: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
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
 arch/powerpc/include/asm/asm-prototypes.h |  6 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  8 +--
 arch/powerpc/kvm/tm.S                     | 94 ++++++++++++++++++++++++++++++-
 3 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index dfdcb23..5da683b 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -141,7 +141,13 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 void pnv_power9_force_smt4_catch(void);
 void pnv_power9_force_smt4_release(void);
 
+/* Transaction memory related */
 void tm_enable(void);
 void tm_disable(void);
 void tm_abort(uint8_t cause);
+
+struct kvm_vcpu;
+void _kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
+void _kvmppc_save_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 6445d29..980df5f 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -795,7 +795,7 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	 */
 	mr      r3, r4
 	ld      r4, VCPU_MSR(r3)
-	bl	kvmppc_restore_tm
+	bl	__kvmppc_restore_tm
 	ld	r4, HSTATE_KVM_VCPU(r13)
 91:
 END_FTR_SECTION_IFSET(CPU_FTR_TM)
@@ -1783,7 +1783,7 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	 */
 	mr      r3, r9
 	ld      r4, VCPU_MSR(r3)
-	bl	kvmppc_save_tm
+	bl	__kvmppc_save_tm
 	ld	r9, HSTATE_KVM_VCPU(r13)
 91:
 #endif
@@ -2689,7 +2689,7 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	 */
 	ld      r3, HSTATE_KVM_VCPU(r13)
 	ld      r4, VCPU_MSR(r3)
-	bl	kvmppc_save_tm
+	bl	__kvmppc_save_tm
 91:
 #endif
 
@@ -2809,7 +2809,7 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	 */
 	mr      r3, r4
 	ld      r4, VCPU_MSR(r3)
-	bl	kvmppc_restore_tm
+	bl	__kvmppc_restore_tm
 	ld	r4, HSTATE_KVM_VCPU(r13)
 91:
 #endif
diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
index b7057d5..42a7cd8 100644
--- a/arch/powerpc/kvm/tm.S
+++ b/arch/powerpc/kvm/tm.S
@@ -33,7 +33,7 @@
  * This can modify all checkpointed registers, but
  * restores r1, r2 before exit.
  */
-_GLOBAL(kvmppc_save_tm)
+_GLOBAL(__kvmppc_save_tm)
 	mflr	r0
 	std	r0, PPC_LR_STKOFF(r1)
 	stdu	r1, -PPC_MIN_STKFRM(r1)
@@ -210,6 +210,52 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 	blr
 
 /*
+ * _kvmppc_save_tm_pr() is a wrapper around __kvmppc_save_tm(), so that it can
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
+	bl	__kvmppc_save_tm
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
@@ -219,7 +265,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
  * This potentially modifies all checkpointed registers.
  * It restores r1, r2 from the PACA.
  */
-_GLOBAL(kvmppc_restore_tm)
+_GLOBAL(__kvmppc_restore_tm)
 	mflr	r0
 	std	r0, PPC_LR_STKOFF(r1)
 
@@ -362,4 +408,48 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
 	addi	r1, r1, PPC_MIN_STKFRM
 	b	9b
 #endif
+
+/*
+ * _kvmppc_restore_tm_pr() is a wrapper around __kvmppc_restore_tm(), so that it
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
+	bl	__kvmppc_restore_tm
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
