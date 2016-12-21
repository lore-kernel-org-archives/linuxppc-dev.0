Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tkNVc1Y1YzDwKv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 05:30:00 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id w68so11149279pgw.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 10:30:00 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Alexander Graf <agraf@suse.com>,
 kvm-ppc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE support for
 interrupts
Date: Thu, 22 Dec 2016 04:29:27 +1000
Message-Id: <20161221182927.24562-4-npiggin@gmail.com>
In-Reply-To: <20161221182927.24562-1-npiggin@gmail.com>
References: <20161221182927.24562-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

64-bit Book3S exception handlers must find the dynamic kernel base
to add to the target address when branching beyond __end_interrupts,
in order to support kernel running at non-0 physical address.

Support this in KVM by branching with CTR, similarly to regular
interrupt handlers. The guest CTR saved in HSTATE_SCRATCH1 and
restored after the branch.

Without this, the host kernel hangs and crashes randomly when it is
running at a non-0 address and a KVM guest is started.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 43 +++++++++++++++++++++++++++++---
 arch/powerpc/kernel/exceptions-64s.S     |  4 +--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 11 +++++---
 arch/powerpc/kvm/book3s_segment.S        |  7 ++++++
 4 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index a02a268bde6b..e36c741e22d5 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -97,6 +97,11 @@
 	ld	reg,PACAKBASE(r13);					\
 	ori	reg,reg,(ABS_ADDR(label))@l;
 
+#define __LOAD_FAR_HANDLER(reg, label)					\
+	ld	reg,PACAKBASE(r13);					\
+	ori	reg,reg,(ABS_ADDR(label))@l;				\
+	addis	reg,reg,(ABS_ADDR(label))@h;
+
 /* Exception register prefixes */
 #define EXC_HV	H
 #define EXC_STD
@@ -227,12 +232,44 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtctr	reg;							\
 	bctr
 
+/*
+ * KVM requires >64K branches when branching from unrelocated code.
+ */
+#define __BRANCH_TO_KVM_EXIT(area, label)				\
+	mfctr	r9;							\
+	std	r9,HSTATE_SCRATCH1(r13);				\
+	__LOAD_FAR_HANDLER(r9, label);					\
+	mtctr	r9;							\
+	ld	r9,area+EX_R9(r13);					\
+	bctr
+
+#define BRANCH_TO_KVM(reg, label)					\
+	__LOAD_FAR_HANDLER(reg, label);					\
+	mtctr	reg;							\
+	bctr
+
+#define BRANCH_LINK_TO_KVM(reg, label)					\
+	__LOAD_FAR_HANDLER(reg, label);					\
+	mtctr	reg;							\
+	bctrl
+
 #else
 #define BRANCH_TO_COMMON(reg, label)					\
 	b	label
 
+#define BRANCH_TO_KVM(reg, label)					\
+	b	label
+
+#define __BRANCH_TO_KVM_EXIT(area, label)				\
+	ld	r9,area+EX_R9(r13);					\
+	b	label
+
+#define BRANCH_LINK_TO_KVM(reg, label)					\
+	bl	label
+
 #endif
 
+
 #define __KVM_HANDLER(area, h, n)					\
 	BEGIN_FTR_SECTION_NESTED(947)					\
 	ld	r10,area+EX_CFAR(r13);					\
@@ -246,8 +283,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	std	r12,HSTATE_SCRATCH0(r13);				\
 	sldi	r12,r9,32;						\
 	ori	r12,r12,(n);						\
-	ld	r9,area+EX_R9(r13);					\
-	b	kvmppc_interrupt
+	__BRANCH_TO_KVM_EXIT(area, kvmppc_interrupt)
 
 #define __KVM_HANDLER_SKIP(area, h, n)					\
 	cmpwi	r10,KVM_GUEST_MODE_SKIP;				\
@@ -260,8 +296,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	std	r12,HSTATE_SCRATCH0(r13);				\
 	sldi	r12,r9,32;						\
 	ori	r12,r12,(n);						\
-	ld	r9,area+EX_R9(r13);					\
-	b	kvmppc_interrupt;					\
+	__BRANCH_TO_KVM_EXIT(area, kvmppc_interrupt);			\
 89:	mtocrf	0x80,r9;						\
 	ld	r9,area+EX_R9(r13);					\
 	ld	r10,area+EX_R10(r13);					\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 89b4f122aec6..d40307cfeb39 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -142,7 +142,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
 	cmpwi	r0,0
 	beq	1f
-	b	kvm_start_guest
+	BRANCH_TO_KVM(r10, kvm_start_guest)
 1:
 #endif
 
@@ -977,7 +977,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	hmi_exception_realmode
+	BRANCH_LINK_TO_KVM(r4, hmi_exception_realmode)
 	/* Windup the stack. */
 	/* Move original HSRR0 and HSRR1 into the respective regs */
 	ld	r9,_MSR(r1)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 11882aac8216..c18ce740452b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1060,15 +1060,16 @@ kvmppc_interrupt_hv:
 	 * R12		= (guest CR << 32) | interrupt vector
 	 * R13		= PACA
 	 * guest R12 saved in shadow VCPU SCRATCH0
+	 * guest CTR saved in shadow VCPU SCRATCH1 if RELOCATABLE
 	 * guest R13 saved in SPRN_SCRATCH0
 	 */
-	std	r9, HSTATE_SCRATCH1(r13)
+	std	r9, HSTATE_SCRATCH2(r13)
 	lbz	r9, HSTATE_IN_GUEST(r13)
 	cmpwi	r9, KVM_GUEST_MODE_HOST_HV
 	beq	kvmppc_bad_host_intr
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	cmpwi	r9, KVM_GUEST_MODE_GUEST
-	ld	r9, HSTATE_SCRATCH1(r13)
+	ld	r9, HSTATE_SCRATCH2(r13)
 	beq	kvmppc_interrupt_pr
 #endif
 	/* We're now back in the host but in guest MMU context */
@@ -1088,7 +1089,7 @@ kvmppc_interrupt_hv:
 	std	r6, VCPU_GPR(R6)(r9)
 	std	r7, VCPU_GPR(R7)(r9)
 	std	r8, VCPU_GPR(R8)(r9)
-	ld	r0, HSTATE_SCRATCH1(r13)
+	ld	r0, HSTATE_SCRATCH2(r13)
 	std	r0, VCPU_GPR(R9)(r9)
 	std	r10, VCPU_GPR(R10)(r9)
 	std	r11, VCPU_GPR(R11)(r9)
@@ -1151,7 +1152,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 11:	stw	r3,VCPU_HEIR(r9)
 
 	/* these are volatile across C function calls */
+#ifdef CONFIG_RELOCATABLE
+	ld	r3, HSTATE_SCRATCH1(r13)
+#else
 	mfctr	r3
+#endif
 	mfxer	r4
 	std	r3, VCPU_CTR(r9)
 	std	r4, VCPU_XER(r9)
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 68e45080cf93..2a2b96d53999 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -175,9 +175,16 @@ kvmppc_interrupt_pr:
 	 * R12             = (guest CR << 32) | exit handler id
 	 * R13             = PACA
 	 * HSTATE.SCRATCH0 = guest R12
+	 * HSTATE.SCRATCH1 = guest CTR if RELOCATABLE
 	 */
 #ifdef CONFIG_PPC64
 	/* Match 32-bit entry */
+#ifdef CONFIG_RELOCATABLE
+	std	r9, HSTATE_SCRATCH2(r13)
+	ld	r9, HSTATE_SCRATCH1(r13)
+	mtctr	r9
+	ld	r9, HSTATE_SCRATCH2(r13)
+#endif
 	rotldi	r12, r12, 32		  /* Flip R12 halves for stw */
 	stw	r12, HSTATE_SCRATCH1(r13) /* CR is now in the low half */
 	srdi	r12, r12, 32		  /* shift trap into low half */
-- 
2.11.0
