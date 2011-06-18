Return-Path: <paulus@ozlabs.org>
Date: Sat, 18 Jun 2011 18:35:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 08/15] KVM: PPC: Split host-state fields out of
	kvmppc_book3s_shadow_vcpu
Message-ID: <20110618083524.GI28413@bloggs.ozlabs.ibm.com>
References: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are several fields in struct kvmppc_book3s_shadow_vcpu that
temporarily store bits of host state while a guest is running,
rather than anything relating to the particular guest or vcpu.
This splits them out into a new kvmppc_host_state structure and
modifies the definitions in asm-offsets.c to suit.

On 32-bit, we have a kvmppc_host_state structure inside the
kvmppc_book3s_shadow_vcpu since the assembly code needs to be able
to get to them both with one pointer.  On 64-bit they are separate
fields in the PACA.  This means that on 64-bit we don't need to
copy the kvmppc_host_state in and out on vcpu load/unload, and
in future will mean that the book3s_hv code doesn't need a
shadow_vcpu struct in the PACA at all.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/exception-64s.h  |   10 ++--
 arch/powerpc/include/asm/kvm_book3s_asm.h |   27 ++++++---
 arch/powerpc/include/asm/paca.h           |    1 +
 arch/powerpc/kernel/asm-offsets.c         |   94 ++++++++++++++--------------
 arch/powerpc/kvm/book3s_interrupts.S      |   17 +++---
 arch/powerpc/kvm/book3s_rmhandlers.S      |   18 +++---
 arch/powerpc/kvm/book3s_segment.S         |   72 +++++++++++-----------
 7 files changed, 124 insertions(+), 115 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index b6a3a44..296c9b6 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -96,16 +96,16 @@
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
 #define __KVMTEST(n)							\
-	lbz	r10,PACA_KVM_SVCPU+SVCPU_IN_GUEST(r13);			\
+	lbz	r10,HSTATE_IN_GUEST(r13);			\
 	cmpwi	r10,0;							\
 	bne	do_kvm_##n
 
 #define __KVM_HANDLER(area, h, n)					\
 do_kvm_##n:								\
 	ld	r10,area+EX_R10(r13);					\
-	stw	r9,PACA_KVM_SVCPU+SVCPU_SCRATCH1(r13);			\
+	stw	r9,HSTATE_SCRATCH1(r13);			\
 	ld	r9,area+EX_R9(r13);					\
-	std	r12,PACA_KVM_SVCPU+SVCPU_SCRATCH0(r13);			\
+	std	r12,HSTATE_SCRATCH0(r13);			\
 	li	r12,n;							\
 	b	kvmppc_interrupt
 
@@ -114,9 +114,9 @@ do_kvm_##n:								\
 	cmpwi	r10,KVM_GUEST_MODE_SKIP;				\
 	ld	r10,area+EX_R10(r13);					\
 	beq	89f;							\
-	stw	r9,PACA_KVM_SVCPU+SVCPU_SCRATCH1(r13);			\
+	stw	r9,HSTATE_SCRATCH1(r13);			\
 	ld	r9,area+EX_R9(r13);					\
-	std	r12,PACA_KVM_SVCPU+SVCPU_SCRATCH0(r13);			\
+	std	r12,HSTATE_SCRATCH0(r13);			\
 	li	r12,n;							\
 	b	kvmppc_interrupt;					\
 89:	mtocrf	0x80,r9;						\
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index d5a8a38..3126175 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -60,6 +60,22 @@ kvmppc_resume_\intno:
 
 #else  /*__ASSEMBLY__ */
 
+/*
+ * This struct goes in the PACA on 64-bit processors.  It is used
+ * to store host state that needs to be saved when we enter a guest
+ * and restored when we exit, but isn't specific to any particular
+ * guest or vcpu.  It also has some scratch fields used by the guest
+ * exit code.
+ */
+struct kvmppc_host_state {
+	ulong host_r1;
+	ulong host_r2;
+	ulong vmhandler;
+	ulong scratch0;
+	ulong scratch1;
+	u8 in_guest;
+};
+
 struct kvmppc_book3s_shadow_vcpu {
 	ulong gpr[14];
 	u32 cr;
@@ -73,17 +89,12 @@ struct kvmppc_book3s_shadow_vcpu {
 	ulong shadow_srr1;
 	ulong fault_dar;
 
-	ulong host_r1;
-	ulong host_r2;
-	ulong handler;
-	ulong scratch0;
-	ulong scratch1;
-	ulong vmhandler;
-	u8 in_guest;
-
 #ifdef CONFIG_PPC_BOOK3S_32
 	u32     sr[16];			/* Guest SRs */
+
+	struct kvmppc_host_state hstate;
 #endif
+
 #ifdef CONFIG_PPC_BOOK3S_64
 	u8 slb_max;			/* highest used guest slb entry */
 	struct  {
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 7412676..58f4a18 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -149,6 +149,7 @@ struct paca_struct {
 #ifdef CONFIG_KVM_BOOK3S_HANDLER
 	/* We use this to store guest state in */
 	struct kvmppc_book3s_shadow_vcpu shadow_vcpu;
+	struct kvmppc_host_state kvm_hstate;
 #endif
 };
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index faf8461..dabfb73 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -198,11 +198,6 @@ int main(void)
 	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-	DEFINE(PACA_KVM_SVCPU, offsetof(struct paca_struct, shadow_vcpu));
-	DEFINE(SVCPU_SLB, offsetof(struct kvmppc_book3s_shadow_vcpu, slb));
-	DEFINE(SVCPU_SLB_MAX, offsetof(struct kvmppc_book3s_shadow_vcpu, slb_max));
-#endif
 #endif /* CONFIG_PPC64 */
 
 	/* RTAS */
@@ -416,49 +411,54 @@ int main(void)
 	DEFINE(VCPU_HIGHMEM_HANDLER, offsetof(struct kvm_vcpu, arch.highmem_handler));
 	DEFINE(VCPU_RMCALL, offsetof(struct kvm_vcpu, arch.rmcall));
 	DEFINE(VCPU_HFLAGS, offsetof(struct kvm_vcpu, arch.hflags));
-	DEFINE(VCPU_SVCPU, offsetof(struct kvmppc_vcpu_book3s, shadow_vcpu) -
-			   offsetof(struct kvmppc_vcpu_book3s, vcpu));
-	DEFINE(SVCPU_CR, offsetof(struct kvmppc_book3s_shadow_vcpu, cr));
-	DEFINE(SVCPU_XER, offsetof(struct kvmppc_book3s_shadow_vcpu, xer));
-	DEFINE(SVCPU_CTR, offsetof(struct kvmppc_book3s_shadow_vcpu, ctr));
-	DEFINE(SVCPU_LR, offsetof(struct kvmppc_book3s_shadow_vcpu, lr));
-	DEFINE(SVCPU_PC, offsetof(struct kvmppc_book3s_shadow_vcpu, pc));
-	DEFINE(SVCPU_R0, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[0]));
-	DEFINE(SVCPU_R1, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[1]));
-	DEFINE(SVCPU_R2, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[2]));
-	DEFINE(SVCPU_R3, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[3]));
-	DEFINE(SVCPU_R4, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[4]));
-	DEFINE(SVCPU_R5, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[5]));
-	DEFINE(SVCPU_R6, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[6]));
-	DEFINE(SVCPU_R7, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[7]));
-	DEFINE(SVCPU_R8, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[8]));
-	DEFINE(SVCPU_R9, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[9]));
-	DEFINE(SVCPU_R10, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[10]));
-	DEFINE(SVCPU_R11, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[11]));
-	DEFINE(SVCPU_R12, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[12]));
-	DEFINE(SVCPU_R13, offsetof(struct kvmppc_book3s_shadow_vcpu, gpr[13]));
-	DEFINE(SVCPU_HOST_R1, offsetof(struct kvmppc_book3s_shadow_vcpu, host_r1));
-	DEFINE(SVCPU_HOST_R2, offsetof(struct kvmppc_book3s_shadow_vcpu, host_r2));
-	DEFINE(SVCPU_VMHANDLER, offsetof(struct kvmppc_book3s_shadow_vcpu,
-					 vmhandler));
-	DEFINE(SVCPU_SCRATCH0, offsetof(struct kvmppc_book3s_shadow_vcpu,
-					scratch0));
-	DEFINE(SVCPU_SCRATCH1, offsetof(struct kvmppc_book3s_shadow_vcpu,
-					scratch1));
-	DEFINE(SVCPU_IN_GUEST, offsetof(struct kvmppc_book3s_shadow_vcpu,
-					in_guest));
-	DEFINE(SVCPU_FAULT_DSISR, offsetof(struct kvmppc_book3s_shadow_vcpu,
-					   fault_dsisr));
-	DEFINE(SVCPU_FAULT_DAR, offsetof(struct kvmppc_book3s_shadow_vcpu,
-					 fault_dar));
-	DEFINE(SVCPU_LAST_INST, offsetof(struct kvmppc_book3s_shadow_vcpu,
-					 last_inst));
-	DEFINE(SVCPU_SHADOW_SRR1, offsetof(struct kvmppc_book3s_shadow_vcpu,
-					   shadow_srr1));
+
+#ifdef CONFIG_PPC_BOOK3S_64
+# define SVCPU_FIELD(x, f)	DEFINE(x, offsetof(struct paca_struct, shadow_vcpu.f))
+# define HSTATE_FIELD(x, f)	DEFINE(x, offsetof(struct paca_struct, kvm_hstate.f))
+#else	/* 32-bit */
+# define SVCPU_FIELD(x, f)	DEFINE(x, offsetof(struct kvmppc_book3s_shadow_vcpu, f))
+# define HSTATE_FIELD(x, f)	DEFINE(x, offsetof(struct kvmppc_book3s_shadow_vcpu, hstate.f))
+#endif
+
+	SVCPU_FIELD(SVCPU_CR, cr);
+	SVCPU_FIELD(SVCPU_XER, xer);
+	SVCPU_FIELD(SVCPU_CTR, ctr);
+	SVCPU_FIELD(SVCPU_LR, lr);
+	SVCPU_FIELD(SVCPU_PC, pc);
+	SVCPU_FIELD(SVCPU_R0, gpr[0]);
+	SVCPU_FIELD(SVCPU_R1, gpr[1]);
+	SVCPU_FIELD(SVCPU_R2, gpr[2]);
+	SVCPU_FIELD(SVCPU_R3, gpr[3]);
+	SVCPU_FIELD(SVCPU_R4, gpr[4]);
+	SVCPU_FIELD(SVCPU_R5, gpr[5]);
+	SVCPU_FIELD(SVCPU_R6, gpr[6]);
+	SVCPU_FIELD(SVCPU_R7, gpr[7]);
+	SVCPU_FIELD(SVCPU_R8, gpr[8]);
+	SVCPU_FIELD(SVCPU_R9, gpr[9]);
+	SVCPU_FIELD(SVCPU_R10, gpr[10]);
+	SVCPU_FIELD(SVCPU_R11, gpr[11]);
+	SVCPU_FIELD(SVCPU_R12, gpr[12]);
+	SVCPU_FIELD(SVCPU_R13, gpr[13]);
+	SVCPU_FIELD(SVCPU_FAULT_DSISR, fault_dsisr);
+	SVCPU_FIELD(SVCPU_FAULT_DAR, fault_dar);
+	SVCPU_FIELD(SVCPU_LAST_INST, last_inst);
+	SVCPU_FIELD(SVCPU_SHADOW_SRR1, shadow_srr1);
 #ifdef CONFIG_PPC_BOOK3S_32
-	DEFINE(SVCPU_SR, offsetof(struct kvmppc_book3s_shadow_vcpu, sr));
+	SVCPU_FIELD(SVCPU_SR, sr);
 #endif
-#else
+#ifdef CONFIG_PPC64
+	SVCPU_FIELD(SVCPU_SLB, slb);
+	SVCPU_FIELD(SVCPU_SLB_MAX, slb_max);
+#endif
+
+	HSTATE_FIELD(HSTATE_HOST_R1, host_r1);
+	HSTATE_FIELD(HSTATE_HOST_R2, host_r2);
+	HSTATE_FIELD(HSTATE_VMHANDLER, vmhandler);
+	HSTATE_FIELD(HSTATE_SCRATCH0, scratch0);
+	HSTATE_FIELD(HSTATE_SCRATCH1, scratch1);
+	HSTATE_FIELD(HSTATE_IN_GUEST, in_guest);
+
+#else /* CONFIG_PPC_BOOK3S */
 	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.cr));
 	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.xer));
 	DEFINE(VCPU_LR, offsetof(struct kvm_vcpu, arch.lr));
@@ -468,7 +468,7 @@ int main(void)
 	DEFINE(VCPU_FAULT_DEAR, offsetof(struct kvm_vcpu, arch.fault_dear));
 	DEFINE(VCPU_FAULT_ESR, offsetof(struct kvm_vcpu, arch.fault_esr));
 #endif /* CONFIG_PPC_BOOK3S */
-#endif
+#endif /* CONFIG_KVM */
 
 #ifdef CONFIG_KVM_GUEST
 	DEFINE(KVM_MAGIC_SCRATCH1, offsetof(struct kvm_vcpu_arch_shared,
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s_interrupts.S
index 8c5e0e1..91c6de6 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -29,8 +29,7 @@
 #define ULONG_SIZE 		8
 #define FUNC(name) 		GLUE(.,name)
 
-#define GET_SHADOW_VCPU(reg)    \
-        addi    reg, r13, PACA_KVM_SVCPU
+#define GET_SHADOW_VCPU_R13
 
 #define DISABLE_INTERRUPTS	\
 	mfmsr   r0;		\
@@ -43,8 +42,8 @@
 #define ULONG_SIZE              4
 #define FUNC(name)		name
 
-#define GET_SHADOW_VCPU(reg)    \
-        lwz     reg, (THREAD + THREAD_KVM_SVCPU)(r2)
+#define GET_SHADOW_VCPU_R13	\
+	lwz	r13, (THREAD + THREAD_KVM_SVCPU)(r2)
 
 #define DISABLE_INTERRUPTS	\
 	mfmsr   r0;		\
@@ -107,15 +106,15 @@ kvm_start_entry:
 	/* Load non-volatile guest state from the vcpu */
 	VCPU_LOAD_NVGPRS(r4)
 
-	GET_SHADOW_VCPU(r5)
+	GET_SHADOW_VCPU_R13
 
-	/* Save R1/R2 in the PACA */
-	PPC_STL	r1, SVCPU_HOST_R1(r5)
-	PPC_STL	r2, SVCPU_HOST_R2(r5)
+	/* Save R1/R2 in the PACA (64-bit) or shadow_vcpu (32-bit) */
+	PPC_STL	r1, HSTATE_HOST_R1(r13)
+	PPC_STL	r2, HSTATE_HOST_R2(r13)
 
 	/* XXX swap in/out on load? */
 	PPC_LL	r3, VCPU_HIGHMEM_HANDLER(r4)
-	PPC_STL	r3, SVCPU_VMHANDLER(r5)
+	PPC_STL	r3, HSTATE_VMHANDLER(r13)
 
 kvm_start_lightweight:
 
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index dd03689..c1f877c 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -36,7 +36,6 @@
 #if defined(CONFIG_PPC_BOOK3S_64)
 
 #define LOAD_SHADOW_VCPU(reg)	GET_PACA(reg)					
-#define SHADOW_VCPU_OFF		PACA_KVM_SVCPU
 #define MSR_NOIRQ		MSR_KERNEL & ~(MSR_IR | MSR_DR)
 #define FUNC(name) 		GLUE(.,name)
 
@@ -66,7 +65,6 @@ kvmppc_skip_Hinterrupt:
 
 #elif defined(CONFIG_PPC_BOOK3S_32)
 
-#define SHADOW_VCPU_OFF		0
 #define MSR_NOIRQ		MSR_KERNEL
 #define FUNC(name)		name
 
@@ -96,14 +94,14 @@ kvmppc_trampoline_\intno:
 	b	kvmppc_resume_\intno		/* Get back original handler */
 
 1:	tophys(r13, r13)
-	stw	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH1)(r13)
+	stw	r12, HSTATE_SCRATCH1(r13)
 	mfspr	r12, SPRN_SPRG_SCRATCH1
-	stw	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH0)(r13)
-	lbz	r12, (SHADOW_VCPU_OFF + SVCPU_IN_GUEST)(r13)
+	stw	r12, HSTATE_SCRATCH0(r13)
+	lbz	r12, HSTATE_IN_GUEST(r13)
 	cmpwi	r12, KVM_GUEST_MODE_NONE
 	bne	..kvmppc_handler_hasmagic_\intno
 	/* No KVM guest? Then jump back to the Linux handler! */
-	lwz	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH1)(r13)
+	lwz	r12, HSTATE_SCRATCH1(r13)
 	b	2b
 
 	/* Now we know we're handling a KVM guest */
@@ -146,8 +144,8 @@ INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_ALTIVEC
  *
  * R12            = free
  * R13            = Shadow VCPU (PACA)
- * SVCPU.SCRATCH0 = guest R12
- * SVCPU.SCRATCH1 = guest CR
+ * HSTATE.SCRATCH0 = guest R12
+ * HSTATE.SCRATCH1 = guest CR
  * SPRG_SCRATCH0  = guest R13
  *
  */
@@ -159,9 +157,9 @@ kvmppc_handler_skip_ins:
 	mtsrr0	r12
 
 	/* Clean up all state */
-	lwz	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH1)(r13)
+	lwz	r12, HSTATE_SCRATCH1(r13)
 	mtcr	r12
-	PPC_LL	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH0)(r13)
+	PPC_LL	r12, HSTATE_SCRATCH0(r13)
 	GET_SCRATCH0(r13)
 
 	/* And get back into the code */
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 4a623eb..b0ae527 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -22,7 +22,7 @@
 #if defined(CONFIG_PPC_BOOK3S_64)
 
 #define GET_SHADOW_VCPU(reg)    \
-	addi    reg, r13, PACA_KVM_SVCPU
+	mr	reg, r13
 
 #elif defined(CONFIG_PPC_BOOK3S_32)
 
@@ -78,7 +78,7 @@ kvmppc_handler_trampoline_enter:
 
 	/* Activate guest mode, so faults get handled by KVM */
 	li	r11, KVM_GUEST_MODE_GUEST
-	stb	r11, SVCPU_IN_GUEST(r3)
+	stb	r11, HSTATE_IN_GUEST(r3)
 
 	/* Switch to guest segment. This is subarch specific. */
 	LOAD_GUEST_SEGMENTS
@@ -132,30 +132,30 @@ kvmppc_interrupt:
 	 *
 	 * SPRG_SCRATCH0  = guest R13
 	 * R12            = exit handler id
-	 * R13            = shadow vcpu - SHADOW_VCPU_OFF [=PACA on PPC64]
-	 * SVCPU.SCRATCH0 = guest R12
-	 * SVCPU.SCRATCH1 = guest CR
+	 * R13            = shadow vcpu (32-bit) or PACA (64-bit)
+	 * HSTATE.SCRATCH0 = guest R12
+	 * HSTATE.SCRATCH1 = guest CR
 	 *
 	 */
 
 	/* Save registers */
 
-	PPC_STL	r0, (SHADOW_VCPU_OFF + SVCPU_R0)(r13)
-	PPC_STL	r1, (SHADOW_VCPU_OFF + SVCPU_R1)(r13)
-	PPC_STL	r2, (SHADOW_VCPU_OFF + SVCPU_R2)(r13)
-	PPC_STL	r3, (SHADOW_VCPU_OFF + SVCPU_R3)(r13)
-	PPC_STL	r4, (SHADOW_VCPU_OFF + SVCPU_R4)(r13)
-	PPC_STL	r5, (SHADOW_VCPU_OFF + SVCPU_R5)(r13)
-	PPC_STL	r6, (SHADOW_VCPU_OFF + SVCPU_R6)(r13)
-	PPC_STL	r7, (SHADOW_VCPU_OFF + SVCPU_R7)(r13)
-	PPC_STL	r8, (SHADOW_VCPU_OFF + SVCPU_R8)(r13)
-	PPC_STL	r9, (SHADOW_VCPU_OFF + SVCPU_R9)(r13)
-	PPC_STL	r10, (SHADOW_VCPU_OFF + SVCPU_R10)(r13)
-	PPC_STL	r11, (SHADOW_VCPU_OFF + SVCPU_R11)(r13)
+	PPC_STL	r0, SVCPU_R0(r13)
+	PPC_STL	r1, SVCPU_R1(r13)
+	PPC_STL	r2, SVCPU_R2(r13)
+	PPC_STL	r3, SVCPU_R3(r13)
+	PPC_STL	r4, SVCPU_R4(r13)
+	PPC_STL	r5, SVCPU_R5(r13)
+	PPC_STL	r6, SVCPU_R6(r13)
+	PPC_STL	r7, SVCPU_R7(r13)
+	PPC_STL	r8, SVCPU_R8(r13)
+	PPC_STL	r9, SVCPU_R9(r13)
+	PPC_STL	r10, SVCPU_R10(r13)
+	PPC_STL	r11, SVCPU_R11(r13)
 
 	/* Restore R1/R2 so we can handle faults */
-	PPC_LL	r1, (SHADOW_VCPU_OFF + SVCPU_HOST_R1)(r13)
-	PPC_LL	r2, (SHADOW_VCPU_OFF + SVCPU_HOST_R2)(r13)
+	PPC_LL	r1, HSTATE_HOST_R1(r13)
+	PPC_LL	r2, HSTATE_HOST_R2(r13)
 
 	/* Save guest PC and MSR */
 #ifdef CONFIG_PPC64
@@ -171,17 +171,17 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE_206)
 1:	mfsrr0	r3
 	mfsrr1	r4
 2:
-	PPC_STL	r3, (SHADOW_VCPU_OFF + SVCPU_PC)(r13)
-	PPC_STL	r4, (SHADOW_VCPU_OFF + SVCPU_SHADOW_SRR1)(r13)
+	PPC_STL	r3, SVCPU_PC(r13)
+	PPC_STL	r4, SVCPU_SHADOW_SRR1(r13)
 
 	/* Get scratch'ed off registers */
 	GET_SCRATCH0(r9)
-	PPC_LL	r8, (SHADOW_VCPU_OFF + SVCPU_SCRATCH0)(r13)
-	lwz	r7, (SHADOW_VCPU_OFF + SVCPU_SCRATCH1)(r13)
+	PPC_LL	r8, HSTATE_SCRATCH0(r13)
+	lwz	r7, HSTATE_SCRATCH1(r13)
 
-	PPC_STL	r9, (SHADOW_VCPU_OFF + SVCPU_R13)(r13)
-	PPC_STL	r8, (SHADOW_VCPU_OFF + SVCPU_R12)(r13)
-	stw	r7, (SHADOW_VCPU_OFF + SVCPU_CR)(r13)
+	PPC_STL	r9, SVCPU_R13(r13)
+	PPC_STL	r8, SVCPU_R12(r13)
+	stw	r7, SVCPU_CR(r13)
 
 	/* Save more register state  */
 
@@ -191,11 +191,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE_206)
 	mfctr	r8
 	mflr	r9
 
-	stw	r5, (SHADOW_VCPU_OFF + SVCPU_XER)(r13)
-	PPC_STL	r6, (SHADOW_VCPU_OFF + SVCPU_FAULT_DAR)(r13)
-	stw	r7, (SHADOW_VCPU_OFF + SVCPU_FAULT_DSISR)(r13)
-	PPC_STL	r8, (SHADOW_VCPU_OFF + SVCPU_CTR)(r13)
-	PPC_STL	r9, (SHADOW_VCPU_OFF + SVCPU_LR)(r13)
+	stw	r5, SVCPU_XER(r13)
+	PPC_STL	r6, SVCPU_FAULT_DAR(r13)
+	stw	r7, SVCPU_FAULT_DSISR(r13)
+	PPC_STL	r8, SVCPU_CTR(r13)
+	PPC_STL	r9, SVCPU_LR(r13)
 
 	/*
 	 * In order for us to easily get the last instruction,
@@ -225,7 +225,7 @@ ld_last_inst:
 	/* Set guest mode to 'jump over instruction' so if lwz faults
 	 * we'll just continue at the next IP. */
 	li	r9, KVM_GUEST_MODE_SKIP
-	stb	r9, (SHADOW_VCPU_OFF + SVCPU_IN_GUEST)(r13)
+	stb	r9, HSTATE_IN_GUEST(r13)
 
 	/*    1) enable paging for data */
 	mfmsr	r9
@@ -239,13 +239,13 @@ ld_last_inst:
 	sync
 
 #endif
-	stw	r0, (SHADOW_VCPU_OFF + SVCPU_LAST_INST)(r13)
+	stw	r0, SVCPU_LAST_INST(r13)
 
 no_ld_last_inst:
 
 	/* Unset guest mode */
 	li	r9, KVM_GUEST_MODE_NONE
-	stb	r9, (SHADOW_VCPU_OFF + SVCPU_IN_GUEST)(r13)
+	stb	r9, HSTATE_IN_GUEST(r13)
 
 	/* Switch back to host MMU */
 	LOAD_HOST_SEGMENTS
@@ -255,7 +255,7 @@ no_ld_last_inst:
 	 * R1       = host R1
 	 * R2       = host R2
 	 * R12      = exit handler id
-	 * R13      = shadow vcpu - SHADOW_VCPU_OFF [=PACA on PPC64]
+	 * R13      = shadow vcpu (32-bit) or PACA (64-bit)
 	 * SVCPU.*  = guest *
 	 *
 	 */
@@ -265,7 +265,7 @@ no_ld_last_inst:
 	ori	r7, r7, MSR_IR|MSR_DR|MSR_RI|MSR_ME	/* Enable paging */
 	mtsrr1	r7
 	/* Load highmem handler address */
-	PPC_LL	r8, (SHADOW_VCPU_OFF + SVCPU_VMHANDLER)(r13)
+	PPC_LL	r8, HSTATE_VMHANDLER(r13)
 	mtsrr0	r8
 
 	RFI
-- 
1.7.5.4
