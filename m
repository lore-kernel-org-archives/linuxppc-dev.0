Return-Path: <paulus@ozlabs.org>
Date: Tue, 10 Sep 2013 20:22:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 6/6] KVM: PPC: Book3S HV: Use load/store_fp_state functions
 in HV guest entry/exit
Message-ID: <20130910102259.GG28145@iris.ozlabs.ibm.com>
References: <20130910102000.GA28145@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130910102000.GA28145@iris.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This modifies kvmppc_load_fp and kvmppc_save_fp to use the generic
FP/VSX and VMX load/store functions instead of open-coding the
FP/VSX/VMX load/store instructions.  Since kvmppc_load/save_fp don't
follow C calling conventions, we make them private symbols within
book3s_hv_rmhandlers.S.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/asm-offsets.c       |  2 -
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 82 ++++++++-------------------------
 2 files changed, 18 insertions(+), 66 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4c1609f..7982870 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -425,10 +425,8 @@ int main(void)
 	DEFINE(VCPU_GPRS, offsetof(struct kvm_vcpu, arch.gpr));
 	DEFINE(VCPU_VRSAVE, offsetof(struct kvm_vcpu, arch.vrsave));
 	DEFINE(VCPU_FPRS, offsetof(struct kvm_vcpu, arch.fp.fpr));
-	DEFINE(VCPU_FPSCR, offsetof(struct kvm_vcpu, arch.fp.fpscr));
 #ifdef CONFIG_ALTIVEC
 	DEFINE(VCPU_VRS, offsetof(struct kvm_vcpu, arch.vr.vr));
-	DEFINE(VCPU_VSCR, offsetof(struct kvm_vcpu, arch.vr.vscr));
 #endif
 	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.xer));
 	DEFINE(VCPU_CTR, offsetof(struct kvm_vcpu, arch.ctr));
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f5f2396..b5183ed 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1102,7 +1102,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
 	/* save FP state */
 	mr	r3, r9
-	bl	.kvmppc_save_fp
+	bl	kvmppc_save_fp
 
 	/* Increment yield count if they have a VPA */
 	ld	r8, VCPU_VPA(r9)	/* do they have a VPA? */
@@ -1591,7 +1591,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_206)
 	std	r31, VCPU_GPR(R31)(r3)
 
 	/* save FP state */
-	bl	.kvmppc_save_fp
+	bl	kvmppc_save_fp
 
 	/*
 	 * Take a nap until a decrementer or external interrupt occurs,
@@ -1767,7 +1767,9 @@ kvm_no_guest:
  * Save away FP, VMX and VSX registers.
  * r3 = vcpu pointer
  */
-_GLOBAL(kvmppc_save_fp)
+kvmppc_save_fp:
+	mflr	r30
+	mr	r31,r3
 	mfmsr	r5
 	ori	r8,r5,MSR_FP
 #ifdef CONFIG_ALTIVEC
@@ -1782,42 +1784,17 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
 	mtmsrd	r8
 	isync
-#ifdef CONFIG_VSX
-BEGIN_FTR_SECTION
-	reg = 0
-	.rept	32
-	li	r6,reg*16+VCPU_FPRS
-	STXVD2X(reg,R6,R3)
-	reg = reg + 1
-	.endr
-FTR_SECTION_ELSE
-#endif
-	reg = 0
-	.rept	32
-	stfd	reg,reg*8+VCPU_FPRS(r3)
-	reg = reg + 1
-	.endr
-#ifdef CONFIG_VSX
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_VSX)
-#endif
-	mffs	fr0
-	stfd	fr0,VCPU_FPSCR(r3)
-
+	addi	r3,r3,VCPU_FPRS
+	bl	.store_fp_state
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
-	reg = 0
-	.rept	32
-	li	r6,reg*16+VCPU_VRS
-	stvx	reg,r6,r3
-	reg = reg + 1
-	.endr
-	mfvscr	vr0
-	li	r6,VCPU_VSCR
-	stvx	vr0,r6,r3
+	addi	r3,r31,VCPU_VRS
+	bl	.store_vr_state
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	mfspr	r6,SPRN_VRSAVE
 	stw	r6,VCPU_VRSAVE(r3)
+	mtlr	r30
 	mtmsrd	r5
 	isync
 	blr
@@ -1826,8 +1803,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
  * Load up FP, VMX and VSX registers
  * r4 = vcpu pointer
  */
-	.globl	kvmppc_load_fp
 kvmppc_load_fp:
+	mflr	r30
+	mr	r31,r4
 	mfmsr	r9
 	ori	r8,r9,MSR_FP
 #ifdef CONFIG_ALTIVEC
@@ -1842,40 +1820,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
 	mtmsrd	r8
 	isync
-	lfd	fr0,VCPU_FPSCR(r4)
-	MTFSF_L(fr0)
-#ifdef CONFIG_VSX
-BEGIN_FTR_SECTION
-	reg = 0
-	.rept	32
-	li	r7,reg*16+VCPU_FPRS
-	LXVD2X(reg,R7,R4)
-	reg = reg + 1
-	.endr
-FTR_SECTION_ELSE
-#endif
-	reg = 0
-	.rept	32
-	lfd	reg,reg*8+VCPU_FPRS(r4)
-	reg = reg + 1
-	.endr
-#ifdef CONFIG_VSX
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_VSX)
-#endif
-
+	addi	r3,r4,VCPU_FPRS
+	bl	.load_fp_state
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
-	li	r7,VCPU_VSCR
-	lvx	vr0,r7,r4
-	mtvscr	vr0
-	reg = 0
-	.rept	32
-	li	r7,reg*16+VCPU_VRS
-	lvx	reg,r7,r4
-	reg = reg + 1
-	.endr
+	addi	r3,r31,VCPU_VRS
+	bl	.load_vr_state
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	lwz	r7,VCPU_VRSAVE(r4)
 	mtspr	SPRN_VRSAVE,r7
+	mtlr	r30
+	mr	r4,r31
 	blr
-- 
1.8.4.rc3
