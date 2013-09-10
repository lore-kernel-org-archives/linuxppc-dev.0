Return-Path: <paulus@ozlabs.org>
Date: Tue, 10 Sep 2013 20:21:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/6] KVM: PPC: Use load_fp/vr_state rather than
 load_up_fpu/altivec
Message-ID: <20130910102133.GD28145@iris.ozlabs.ibm.com>
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

The load_up_fpu and load_up_altivec functions were never intended to
be called from C, and do things like modifying the MSR value in their
callers' stack frames, which are assumed to be interrupt frames.  In
addition, on 32-bit Book S they require the MMU to be off.

This makes KVM use the new load_fp_state() and load_vr_state() functions
instead of load_up_fpu/altivec.  This means we can remove the assembler
glue in book3s_rmhandlers.S, and potentially fixes a bug on Book E,
where load_up_fpu was called directly from C.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |  3 ---
 arch/powerpc/include/asm/switch_to.h  |  2 --
 arch/powerpc/kvm/book3s_exports.c     |  4 ---
 arch/powerpc/kvm/book3s_pr.c          | 18 +++++++++-----
 arch/powerpc/kvm/book3s_rmhandlers.S  | 47 -----------------------------------
 arch/powerpc/kvm/booke.h              |  3 ++-
 6 files changed, 14 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index fa19e2f..173cd31 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -175,9 +175,6 @@ extern long kvmppc_hv_get_dirty_log(struct kvm *kvm,
 
 extern void kvmppc_entry_trampoline(void);
 extern void kvmppc_hv_entry_trampoline(void);
-extern void kvmppc_load_up_fpu(void);
-extern void kvmppc_load_up_altivec(void);
-extern void kvmppc_load_up_vsx(void);
 extern u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst);
 extern ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst);
 extern int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd);
diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 2be5618..91a6b74 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -25,10 +25,8 @@ static inline void save_tar(struct thread_struct *prev)
 static inline void save_tar(struct thread_struct *prev) {}
 #endif
 
-extern void load_up_fpu(void);
 extern void enable_kernel_fp(void);
 extern void enable_kernel_altivec(void);
-extern void load_up_altivec(struct task_struct *);
 extern int emulate_altivec(struct pt_regs *);
 extern void __giveup_vsx(struct task_struct *);
 extern void giveup_vsx(struct task_struct *);
diff --git a/arch/powerpc/kvm/book3s_exports.c b/arch/powerpc/kvm/book3s_exports.c
index 7057a02..7ba5f78 100644
--- a/arch/powerpc/kvm/book3s_exports.c
+++ b/arch/powerpc/kvm/book3s_exports.c
@@ -24,9 +24,5 @@
 EXPORT_SYMBOL_GPL(kvmppc_hv_entry_trampoline);
 #else
 EXPORT_SYMBOL_GPL(kvmppc_entry_trampoline);
-EXPORT_SYMBOL_GPL(kvmppc_load_up_fpu);
-#ifdef CONFIG_ALTIVEC
-EXPORT_SYMBOL_GPL(kvmppc_load_up_altivec);
-#endif
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index c0b48f96..3c52b08 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -586,7 +586,8 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 #endif
 		t->fp_state.fpscr = vcpu->arch.fpscr;
 		t->fpexc_mode = 0;
-		kvmppc_load_up_fpu();
+		enable_kernel_fp();
+		load_fp_state(&t->fp_state);
 	}
 
 	if (msr & MSR_VEC) {
@@ -594,7 +595,8 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 		memcpy(t->vr_state.vr, vcpu->arch.vr, sizeof(vcpu->arch.vr));
 		t->vr_state.vscr = vcpu->arch.vscr;
 		t->vrsave = -1;
-		kvmppc_load_up_altivec();
+		enable_kernel_altivec();
+		load_vr_state(&t->vr_state);
 #endif
 	}
 
@@ -617,10 +619,14 @@ static void kvmppc_handle_lost_ext(struct kvm_vcpu *vcpu)
 	if (!lost_ext)
 		return;
 
-	if (lost_ext & MSR_FP)
-		kvmppc_load_up_fpu();
-	if (lost_ext & MSR_VEC)
-		kvmppc_load_up_altivec();
+	if (lost_ext & MSR_FP) {
+		enable_kernel_fp();
+		load_fp_state(&current->thread.fp_state);
+	}
+	if (lost_ext & MSR_VEC) {
+		enable_kernel_altivec();
+		load_vr_state(&current->thread.vr_state);
+	}
 	current->thread.regs->msr |= lost_ext;
 }
 
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 8f7633e..7e8bb58 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -188,51 +188,4 @@ _GLOBAL(kvmppc_entry_trampoline)
 	mtsrr1	r6
 	RFI
 
-#if defined(CONFIG_PPC_BOOK3S_32)
-#define STACK_LR	INT_FRAME_SIZE+4
-
-/* load_up_xxx have to run with MSR_DR=0 on Book3S_32 */
-#define MSR_EXT_START						\
-	PPC_STL	r20, _NIP(r1);					\
-	mfmsr	r20;						\
-	LOAD_REG_IMMEDIATE(r3, MSR_DR|MSR_EE);			\
-	andc	r3,r20,r3;		/* Disable DR,EE */	\
-	mtmsr	r3;						\
-	sync
-
-#define MSR_EXT_END						\
-	mtmsr	r20;			/* Enable DR,EE */	\
-	sync;							\
-	PPC_LL	r20, _NIP(r1)
-
-#elif defined(CONFIG_PPC_BOOK3S_64)
-#define STACK_LR	_LINK
-#define MSR_EXT_START
-#define MSR_EXT_END
-#endif
-
-/*
- * Activate current's external feature (FPU/Altivec/VSX)
- */
-#define define_load_up(what) 					\
-								\
-_GLOBAL(kvmppc_load_up_ ## what);				\
-	PPC_STLU r1, -INT_FRAME_SIZE(r1);			\
-	mflr	r3;						\
-	PPC_STL	r3, STACK_LR(r1);				\
-	MSR_EXT_START;						\
-								\
-	bl	FUNC(load_up_ ## what);				\
-								\
-	MSR_EXT_END;						\
-	PPC_LL	r3, STACK_LR(r1);				\
-	mtlr	r3;						\
-	addi	r1, r1, INT_FRAME_SIZE;				\
-	blr
-
-define_load_up(fpu)
-#ifdef CONFIG_ALTIVEC
-define_load_up(altivec)
-#endif
-
 #include "book3s_segment.S"
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 5fd1ba6..7ffb699 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -112,7 +112,8 @@ static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_PPC_FPU
 	if (vcpu->fpu_active && !(current->thread.regs->msr & MSR_FP)) {
-		load_up_fpu();
+		enable_kernel_fp();
+		load_fp_state(&current->thread.fp_state);
 		current->thread.regs->msr |= MSR_FP;
 	}
 #endif
-- 
1.8.4.rc3
