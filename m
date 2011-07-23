Return-Path: <paulus@ozlabs.org>
Date: Sat, 23 Jul 2011 17:41:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
Subject: [PATCH 2/3] KVM: PPC: book3s_pr: Simplify transitions between
	virtual and real mode
Message-ID: <20110723074144.GB17927@bloggs.ozlabs.ibm.com>
References: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This simplifies the way that the book3s_pr makes the transition to
real mode when entering the guest.  We now call kvmppc_entry_trampoline
(renamed from kvmppc_rmcall) in the base kernel using a normal function
call instead of doing an indirect call through a pointer in the vcpu.
If kvm is a module, the module loader takes care of generating a
trampoline as it does for other calls to functions outside the module.

kvmppc_entry_trampoline then disables interrupts and jumps to
kvmppc_handler_trampoline_enter in real mode using an rfi[d].
That then uses the link register as the address to return to
(potentially in module space) when the guest exits.

This also simplifies the way that we call the Linux interrupt handler
when we exit the guest due to an external, decrementer or performance
monitor interrupt.  Instead of turning on the MMU, then deciding that
we need to call the Linux handler and turning the MMU back off again,
we now go straight to the handler at the point where we would turn the
MMU on.  The handler will then return to the virtual-mode code
(potentially in the module).

Along the way, this moves the setting and clearing of the HID5 DCBZ32
bit into real-mode interrupts-off code, and also makes sure that
we clear the MSR[RI] bit before loading values into SRR0/1.

The net result is that we no longer need any code addresses to be
stored in vcpu->arch.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h     |    4 +-
 arch/powerpc/include/asm/kvm_book3s_asm.h |    1 +
 arch/powerpc/include/asm/kvm_host.h       |    8 --
 arch/powerpc/kernel/asm-offsets.c         |    7 +--
 arch/powerpc/kvm/book3s_32_sr.S           |    2 +-
 arch/powerpc/kvm/book3s_64_slb.S          |    2 +-
 arch/powerpc/kvm/book3s_exports.c         |    4 +-
 arch/powerpc/kvm/book3s_interrupts.S      |  129 +---------------------------
 arch/powerpc/kvm/book3s_pr.c              |   12 ---
 arch/powerpc/kvm/book3s_rmhandlers.S      |   51 ++++--------
 arch/powerpc/kvm/book3s_segment.S         |  112 ++++++++++++++++++++-----
 11 files changed, 120 insertions(+), 212 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 98da010..a70c0e6 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -139,9 +139,7 @@ extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
 extern int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu);
 extern pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 
-extern void kvmppc_handler_lowmem_trampoline(void);
-extern void kvmppc_handler_trampoline_enter(void);
-extern void kvmppc_rmcall(ulong srr0, ulong srr1);
+extern void kvmppc_entry_trampoline(void);
 extern void kvmppc_hv_entry_trampoline(void);
 extern void kvmppc_load_up_fpu(void);
 extern void kvmppc_load_up_altivec(void);
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index ef7b368..af73469 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -75,6 +75,7 @@ struct kvmppc_host_state {
 	ulong scratch0;
 	ulong scratch1;
 	u8 in_guest;
+	u8 restore_hid5;
 
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	struct kvm_vcpu *kvm_vcpu;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index cc22b28..db15384 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -258,14 +258,6 @@ struct kvm_vcpu_arch {
 	ulong host_stack;
 	u32 host_pid;
 #ifdef CONFIG_PPC_BOOK3S
-	ulong host_msr;
-	ulong host_r2;
-	void *host_retip;
-	ulong trampoline_lowmem;
-	ulong trampoline_enter;
-	ulong highmem_handler;
-	ulong rmcall;
-	ulong host_paca_phys;
 	struct kvmppc_slb slb[64];
 	int slb_max;		/* 1 + index of last valid entry in slb[] */
 	int slb_nr;		/* total number of entries in SLB */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 54b935f..d34cd32 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -446,8 +446,6 @@ int main(void)
 #ifdef CONFIG_PPC_BOOK3S
 	DEFINE(VCPU_KVM, offsetof(struct kvm_vcpu, kvm));
 	DEFINE(VCPU_VCPUID, offsetof(struct kvm_vcpu, vcpu_id));
-	DEFINE(VCPU_HOST_RETIP, offsetof(struct kvm_vcpu, arch.host_retip));
-	DEFINE(VCPU_HOST_MSR, offsetof(struct kvm_vcpu, arch.host_msr));
 	DEFINE(VCPU_PURR, offsetof(struct kvm_vcpu, arch.purr));
 	DEFINE(VCPU_SPURR, offsetof(struct kvm_vcpu, arch.spurr));
 	DEFINE(VCPU_DSCR, offsetof(struct kvm_vcpu, arch.dscr));
@@ -455,10 +453,6 @@ int main(void)
 	DEFINE(VCPU_UAMOR, offsetof(struct kvm_vcpu, arch.uamor));
 	DEFINE(VCPU_CTRL, offsetof(struct kvm_vcpu, arch.ctrl));
 	DEFINE(VCPU_DABR, offsetof(struct kvm_vcpu, arch.dabr));
-	DEFINE(VCPU_TRAMPOLINE_LOWMEM, offsetof(struct kvm_vcpu, arch.trampoline_lowmem));
-	DEFINE(VCPU_TRAMPOLINE_ENTER, offsetof(struct kvm_vcpu, arch.trampoline_enter));
-	DEFINE(VCPU_HIGHMEM_HANDLER, offsetof(struct kvm_vcpu, arch.highmem_handler));
-	DEFINE(VCPU_RMCALL, offsetof(struct kvm_vcpu, arch.rmcall));
 	DEFINE(VCPU_HFLAGS, offsetof(struct kvm_vcpu, arch.hflags));
 	DEFINE(VCPU_DEC, offsetof(struct kvm_vcpu, arch.dec));
 	DEFINE(VCPU_DEC_EXPIRES, offsetof(struct kvm_vcpu, arch.dec_expires));
@@ -534,6 +528,7 @@ int main(void)
 	HSTATE_FIELD(HSTATE_SCRATCH0, scratch0);
 	HSTATE_FIELD(HSTATE_SCRATCH1, scratch1);
 	HSTATE_FIELD(HSTATE_IN_GUEST, in_guest);
+	HSTATE_FIELD(HSTATE_RESTORE_HID5, restore_hid5);
 
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	HSTATE_FIELD(HSTATE_KVM_VCPU, kvm_vcpu);
diff --git a/arch/powerpc/kvm/book3s_32_sr.S b/arch/powerpc/kvm/book3s_32_sr.S
index 3608471..7e06a6f 100644
--- a/arch/powerpc/kvm/book3s_32_sr.S
+++ b/arch/powerpc/kvm/book3s_32_sr.S
@@ -31,7 +31,7 @@
 	 * R1 = host R1
 	 * R2 = host R2
 	 * R3 = shadow vcpu
-	 * all other volatile GPRS = free
+	 * all other volatile GPRS = free except R4, R6
 	 * SVCPU[CR]  = guest CR
 	 * SVCPU[XER] = guest XER
 	 * SVCPU[CTR] = guest CTR
diff --git a/arch/powerpc/kvm/book3s_64_slb.S b/arch/powerpc/kvm/book3s_64_slb.S
index 04e7d3b..f2e6e48 100644
--- a/arch/powerpc/kvm/book3s_64_slb.S
+++ b/arch/powerpc/kvm/book3s_64_slb.S
@@ -53,7 +53,7 @@ slb_exit_skip_ ## num:
 	 * R1 = host R1
 	 * R2 = host R2
 	 * R3 = shadow vcpu
-	 * all other volatile GPRS = free
+	 * all other volatile GPRS = free except R4, R6
 	 * SVCPU[CR]  = guest CR
 	 * SVCPU[XER] = guest XER
 	 * SVCPU[CTR] = guest CTR
diff --git a/arch/powerpc/kvm/book3s_exports.c b/arch/powerpc/kvm/book3s_exports.c
index 88c8f26..f7f63a0 100644
--- a/arch/powerpc/kvm/book3s_exports.c
+++ b/arch/powerpc/kvm/book3s_exports.c
@@ -23,9 +23,7 @@
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 EXPORT_SYMBOL_GPL(kvmppc_hv_entry_trampoline);
 #else
-EXPORT_SYMBOL_GPL(kvmppc_handler_trampoline_enter);
-EXPORT_SYMBOL_GPL(kvmppc_handler_lowmem_trampoline);
-EXPORT_SYMBOL_GPL(kvmppc_rmcall);
+EXPORT_SYMBOL_GPL(kvmppc_entry_trampoline);
 EXPORT_SYMBOL_GPL(kvmppc_load_up_fpu);
 #ifdef CONFIG_ALTIVEC
 EXPORT_SYMBOL_GPL(kvmppc_load_up_altivec);
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s_interrupts.S
index c54b0e3..0a8515a 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -29,27 +29,11 @@
 #define ULONG_SIZE 		8
 #define FUNC(name) 		GLUE(.,name)
 
-#define GET_SHADOW_VCPU_R13
-
-#define DISABLE_INTERRUPTS	\
-	mfmsr   r0;		\
-	rldicl  r0,r0,48,1;	\
-	rotldi  r0,r0,16;	\
-	mtmsrd  r0,1;		\
-
 #elif defined(CONFIG_PPC_BOOK3S_32)
 
 #define ULONG_SIZE              4
 #define FUNC(name)		name
 
-#define GET_SHADOW_VCPU_R13	\
-	lwz	r13, (THREAD + THREAD_KVM_SVCPU)(r2)
-
-#define DISABLE_INTERRUPTS	\
-	mfmsr   r0;		\
-	rlwinm  r0,r0,0,17,15;	\
-	mtmsr   r0;		\
-
 #endif /* CONFIG_PPC_BOOK3S_XX */
 
 
@@ -108,44 +92,17 @@ kvm_start_entry:
 
 kvm_start_lightweight:
 
-	GET_SHADOW_VCPU_R13
-	PPC_LL	r3, VCPU_HIGHMEM_HANDLER(r4)
-	PPC_STL	r3, HSTATE_VMHANDLER(r13)
-
-	PPC_LL	r10, VCPU_SHADOW_MSR(r4)	/* r10 = vcpu->arch.shadow_msr */
-
-	DISABLE_INTERRUPTS
-
 #ifdef CONFIG_PPC_BOOK3S_64
-	/* Some guests may need to have dcbz set to 32 byte length.
-	 *
-	 * Usually we ensure that by patching the guest's instructions
-	 * to trap on dcbz and emulate it in the hypervisor.
-	 *
-	 * If we can, we should tell the CPU to use 32 byte dcbz though,
-	 * because that's a lot faster.
-	 */
-
 	PPC_LL	r3, VCPU_HFLAGS(r4)
-	rldicl.	r3, r3, 0, 63		/* CR = ((r3 & 1) == 0) */
-	beq	no_dcbz32_on
-
-	mfspr   r3,SPRN_HID5
-	ori     r3, r3, 0x80		/* XXX HID5_dcbz32 = 0x80 */
-	mtspr   SPRN_HID5,r3
-
-no_dcbz32_on:
-
+	rldicl	r3, r3, 0, 63		/* r3 &= 1 */
+	stb	r3, HSTATE_RESTORE_HID5(r13)
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-	PPC_LL	r6, VCPU_RMCALL(r4)
-	mtctr	r6
-
-	PPC_LL	r3, VCPU_TRAMPOLINE_ENTER(r4)
-	LOAD_REG_IMMEDIATE(r4, MSR_KERNEL & ~(MSR_IR | MSR_DR))
+	PPC_LL	r4, VCPU_SHADOW_MSR(r4)	/* get shadow_msr */
 
 	/* Jump to segment patching handler and into our guest */
-	bctr
+	bl	FUNC(kvmppc_entry_trampoline)
+	nop
 
 /*
  * This is the handler in module memory. It gets jumped at from the
@@ -170,21 +127,6 @@ kvmppc_handler_highmem:
 	/* R7 = vcpu */
 	PPC_LL	r7, GPR4(r1)
 
-#ifdef CONFIG_PPC_BOOK3S_64
-
-	PPC_LL	r5, VCPU_HFLAGS(r7)
-	rldicl.	r5, r5, 0, 63		/* CR = ((r5 & 1) == 0) */
-	beq	no_dcbz32_off
-
-	li	r4, 0
-	mfspr   r5,SPRN_HID5
-	rldimi  r5,r4,6,56
-	mtspr   SPRN_HID5,r5
-
-no_dcbz32_off:
-
-#endif /* CONFIG_PPC_BOOK3S_64 */
-
 	PPC_STL	r14, VCPU_GPR(r14)(r7)
 	PPC_STL	r15, VCPU_GPR(r15)(r7)
 	PPC_STL	r16, VCPU_GPR(r16)(r7)
@@ -204,67 +146,6 @@ no_dcbz32_off:
 	PPC_STL	r30, VCPU_GPR(r30)(r7)
 	PPC_STL	r31, VCPU_GPR(r31)(r7)
 
-	/* Restore host msr -> SRR1 */
-	PPC_LL	r6, VCPU_HOST_MSR(r7)
-
-	/*
-	 * For some interrupts, we need to call the real Linux
-	 * handler, so it can do work for us. This has to happen
-	 * as if the interrupt arrived from the kernel though,
-	 * so let's fake it here where most state is restored.
-	 *
-	 * Call Linux for hardware interrupts/decrementer
-	 * r3 = address of interrupt handler (exit reason)
-	 */
-
-	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
-	beq	call_linux_handler
-	cmpwi	r12, BOOK3S_INTERRUPT_DECREMENTER
-	beq	call_linux_handler
-	cmpwi	r12, BOOK3S_INTERRUPT_PERFMON
-	beq	call_linux_handler
-
-	/* Back to EE=1 */
-	mtmsr	r6
-	sync
-	b	kvm_return_point
-
-call_linux_handler:
-
-	/*
-	 * If we land here we need to jump back to the handler we
-	 * came from.
-	 *
-	 * We have a page that we can access from real mode, so let's
-	 * jump back to that and use it as a trampoline to get back into the
-	 * interrupt handler!
-	 *
-	 * R3 still contains the exit code,
-	 * R5 VCPU_HOST_RETIP and
-	 * R6 VCPU_HOST_MSR
-	 */
-
-	/* Restore host IP -> SRR0 */
-	PPC_LL	r5, VCPU_HOST_RETIP(r7)
-
-	/* XXX Better move to a safe function?
-	 *     What if we get an HTAB flush in between mtsrr0 and mtsrr1? */
-
-	mtlr	r12
-
-	PPC_LL	r4, VCPU_TRAMPOLINE_LOWMEM(r7)
-	mtsrr0	r4
-	LOAD_REG_IMMEDIATE(r3, MSR_KERNEL & ~(MSR_IR | MSR_DR))
-	mtsrr1	r3
-
-	RFI
-
-.global kvm_return_point
-kvm_return_point:
-
-	/* Jump back to lightweight entry if we're supposed to */
-	/* go back into the guest */
-
 	/* Pass the exit number as 3rd argument to kvmppc_handle_exit */
 	mr	r5, r12
 
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 0c0d3f2..d7ab552 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -841,8 +841,6 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (!p)
 		goto uninit_vcpu;
 
-	vcpu->arch.host_retip = kvm_return_point;
-	vcpu->arch.host_msr = mfmsr();
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* default to book3s_64 (970fx) */
 	vcpu->arch.pvr = 0x3C0301;
@@ -853,16 +851,6 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	kvmppc_set_pvr(vcpu, vcpu->arch.pvr);
 	vcpu->arch.slb_nr = 64;
 
-	/* remember where some real-mode handlers are */
-	vcpu->arch.trampoline_lowmem = __pa(kvmppc_handler_lowmem_trampoline);
-	vcpu->arch.trampoline_enter = __pa(kvmppc_handler_trampoline_enter);
-	vcpu->arch.highmem_handler = (ulong)kvmppc_handler_highmem;
-#ifdef CONFIG_PPC_BOOK3S_64
-	vcpu->arch.rmcall = *(ulong*)kvmppc_rmcall;
-#else
-	vcpu->arch.rmcall = (ulong)kvmppc_rmcall;
-#endif
-
 	vcpu->arch.shadow_msr = MSR_USER64;
 
 	err = kvmppc_mmu_init(vcpu);
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 5ee66ed..3418758 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -36,9 +36,8 @@
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 
-#define LOAD_SHADOW_VCPU(reg)	GET_PACA(reg)					
-#define MSR_NOIRQ		MSR_KERNEL & ~(MSR_IR | MSR_DR)
 #define FUNC(name) 		GLUE(.,name)
+#define MTMSR_EERI(reg)		mtmsrd	(reg),1
 
 	.globl	kvmppc_skip_interrupt
 kvmppc_skip_interrupt:
@@ -68,8 +67,8 @@ kvmppc_skip_Hinterrupt:
 
 #elif defined(CONFIG_PPC_BOOK3S_32)
 
-#define MSR_NOIRQ		MSR_KERNEL
 #define FUNC(name)		name
+#define MTMSR_EERI(reg)		mtmsr	(reg)
 
 .macro INTERRUPT_TRAMPOLINE intno
 
@@ -170,40 +169,24 @@ kvmppc_handler_skip_ins:
 #endif
 
 /*
- * This trampoline brings us back to a real mode handler
- *
- * Input Registers:
- *
- * R5 = SRR0
- * R6 = SRR1
- * LR = real-mode IP
+ * Call kvmppc_handler_trampoline_enter in real mode
  *
+ * On entry, r4 contains the guest shadow MSR
  */
-.global kvmppc_handler_lowmem_trampoline
-kvmppc_handler_lowmem_trampoline:
-
-	mtsrr0	r5
+_GLOBAL(kvmppc_entry_trampoline)
+	mfmsr	r5
+	LOAD_REG_ADDR(r7, kvmppc_handler_trampoline_enter)
+	toreal(r7)
+
+	li	r9, MSR_RI
+	ori	r9, r9, MSR_EE
+	andc	r9, r5, r9	/* Clear EE and RI in MSR value */
+	li	r6, MSR_IR | MSR_DR
+	ori	r6, r6, MSR_EE
+	andc	r6, r5, r6	/* Clear EE, DR and IR in MSR value */
+	MTMSR_EERI(r9)		/* Clear EE and RI in MSR */
+	mtsrr0	r7		/* before we set srr0/1 */
 	mtsrr1	r6
-	blr
-kvmppc_handler_lowmem_trampoline_end:
-
-/*
- * Call a function in real mode
- *
- * Input Registers:
- *
- * R3 = function
- * R4 = MSR
- * R5 = scratch register
- *
- */
-_GLOBAL(kvmppc_rmcall)
-	LOAD_REG_IMMEDIATE(r5, MSR_NOIRQ)
-	mtmsr	r5		/* Disable relocation and interrupts, so mtsrr
-				   doesn't get interrupted */
-	sync
-	mtsrr0	r3
-	mtsrr1	r4
 	RFI
 
 #if defined(CONFIG_PPC_BOOK3S_32)
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index aed32e5..3663564 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -23,6 +23,7 @@
 
 #define GET_SHADOW_VCPU(reg)    \
 	mr	reg, r13
+#define MTMSR_EERI(reg)		mtmsrd	(reg),1
 
 #elif defined(CONFIG_PPC_BOOK3S_32)
 
@@ -30,6 +31,7 @@
 	tophys(reg, r2);       			\
 	lwz     reg, (THREAD + THREAD_KVM_SVCPU)(reg);	\
 	tophys(reg, reg)
+#define MTMSR_EERI(reg)		mtmsr	(reg)
 
 #endif
 
@@ -57,10 +59,12 @@ kvmppc_handler_trampoline_enter:
 	/* Required state:
 	 *
 	 * MSR = ~IR|DR
-	 * R13 = PACA
 	 * R1 = host R1
 	 * R2 = host R2
-	 * R10 = guest MSR
+	 * R4 = guest shadow MSR
+	 * R5 = normal host MSR
+	 * R6 = current host MSR (EE, IR, DR off)
+	 * LR = highmem guest exit code
 	 * all other volatile GPRS = free
 	 * SVCPU[CR] = guest CR
 	 * SVCPU[XER] = guest XER
@@ -71,15 +75,15 @@ kvmppc_handler_trampoline_enter:
 	/* r3 = shadow vcpu */
 	GET_SHADOW_VCPU(r3)
 
+	/* Save guest exit handler address and MSR */
+	mflr	r0
+	PPC_STL	r0, HSTATE_VMHANDLER(r3)
+	PPC_STL	r5, HSTATE_HOST_MSR(r3)
+
 	/* Save R1/R2 in the PACA (64-bit) or shadow_vcpu (32-bit) */
 	PPC_STL	r1, HSTATE_HOST_R1(r3)
 	PPC_STL	r2, HSTATE_HOST_R2(r3)
 
-	/* Move SRR0 and SRR1 into the respective regs */
-	PPC_LL  r9, SVCPU_PC(r3)
-	mtsrr0	r9
-	mtsrr1	r10
-
 	/* Activate guest mode, so faults get handled by KVM */
 	li	r11, KVM_GUEST_MODE_GUEST
 	stb	r11, HSTATE_IN_GUEST(r3)
@@ -87,17 +91,46 @@ kvmppc_handler_trampoline_enter:
 	/* Switch to guest segment. This is subarch specific. */
 	LOAD_GUEST_SEGMENTS
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* Some guests may need to have dcbz set to 32 byte length.
+	 *
+	 * Usually we ensure that by patching the guest's instructions
+	 * to trap on dcbz and emulate it in the hypervisor.
+	 *
+	 * If we can, we should tell the CPU to use 32 byte dcbz though,
+	 * because that's a lot faster.
+	 */
+	lbz	r0, HSTATE_RESTORE_HID5(r3)
+	cmpwi	r0, 0
+	beq	no_dcbz32_on
+
+	mfspr   r0,SPRN_HID5
+	ori     r0, r0, 0x80		/* XXX HID5_dcbz32 = 0x80 */
+	mtspr   SPRN_HID5,r0
+no_dcbz32_on:
+
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
 	/* Enter guest */
 
-	PPC_LL	r4, SVCPU_CTR(r3)
-	PPC_LL	r5, SVCPU_LR(r3)
-	lwz	r6, SVCPU_CR(r3)
-	lwz	r7, SVCPU_XER(r3)
+	PPC_LL	r8, SVCPU_CTR(r3)
+	PPC_LL	r9, SVCPU_LR(r3)
+	lwz	r10, SVCPU_CR(r3)
+	lwz	r11, SVCPU_XER(r3)
+
+	mtctr	r8
+	mtlr	r9
+	mtcr	r10
+	mtxer	r11
 
-	mtctr	r4
-	mtlr	r5
-	mtcr	r6
-	mtxer	r7
+	/* Move SRR0 and SRR1 into the respective regs */
+	PPC_LL  r9, SVCPU_PC(r3)
+	/* First clear RI in our current MSR value */
+	li	r0, MSR_RI
+	andc	r6, r6, r0
+	MTMSR_EERI(r6)
+	mtsrr0	r9
+	mtsrr1	r4
 
 	PPC_LL	r0, SVCPU_R0(r3)
 	PPC_LL	r1, SVCPU_R1(r3)
@@ -254,6 +287,43 @@ no_ld_last_inst:
 	/* Switch back to host MMU */
 	LOAD_HOST_SEGMENTS
 
+#ifdef CONFIG_PPC_BOOK3S_64
+
+	lbz	r5, HSTATE_RESTORE_HID5(r13)
+	cmpwi	r5, 0
+	beq	no_dcbz32_off
+
+	li	r4, 0
+	mfspr   r5,SPRN_HID5
+	rldimi  r5,r4,6,56
+	mtspr   SPRN_HID5,r5
+
+no_dcbz32_off:
+
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
+	/*
+	 * For some interrupts, we need to call the real Linux
+	 * handler, so it can do work for us. This has to happen
+	 * as if the interrupt arrived from the kernel though,
+	 * so let's fake it here where most state is restored.
+	 *
+	 * Having set up SRR0/1 with the address where we want
+	 * to continue with relocation on (potentially in module
+	 * space), we either just go straight there with rfi[d],
+	 * or we jump to an interrupt handler with bctr if there
+	 * is an interrupt to be handled first.  In the latter
+	 * case, the rfi[d] at the end of the interrupt handler
+	 * will get us back to where we want to continue.
+	 */
+
+	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
+	beq	1f
+	cmpwi	r12, BOOK3S_INTERRUPT_DECREMENTER
+	beq	1f
+	cmpwi	r12, BOOK3S_INTERRUPT_PERFMON
+1:	mtctr	r12
+
 	/* Register usage at this point:
 	 *
 	 * R1       = host R1
@@ -264,13 +334,15 @@ no_ld_last_inst:
 	 *
 	 */
 
-	/* RFI into the highmem handler */
-	mfmsr	r7
-	ori	r7, r7, MSR_IR|MSR_DR|MSR_RI|MSR_ME	/* Enable paging */
-	mtsrr1	r7
-	/* Load highmem handler address */
+	PPC_LL	r6, HSTATE_HOST_MSR(r13)
 	PPC_LL	r8, HSTATE_VMHANDLER(r13)
+
+	/* Restore host msr -> SRR1 */
+	mtsrr1	r6
+	/* Load highmem handler address */
 	mtsrr0	r8
 
+	/* RFI into the highmem handler, or jump to interrupt handler */
+	beqctr
 	RFI
 kvmppc_handler_trampoline_exit_end:
-- 
1.7.5.4
