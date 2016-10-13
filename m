Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svbKD35Q2zDsy2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 14:08:32 +1100 (AEDT)
Received: by mail-pa0-x243.google.com with SMTP id os4so37446pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 20:08:32 -0700 (PDT)
Date: Thu, 13 Oct 2016 14:08:24 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>
Subject: [RFC][PATCH] kernel relocation for KVM exceptions
Message-ID: <20161013140824.0e3ef1e2@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

I wonder what you think about this approach for applying relocation to KVM
exceptions? It's not yet tested and I haven't attempted PR, but I'll keep
at it if you think it's the right direction.

The relocation branch requires ctr, but we can get away without more scratch
storage by putting trap and cr in one register.

On the other hand, that's going to make the calling convention diverge even
more for 32-bit, so perhaps it's being overly complex and you'd rather add
another scratch save for CONFIG_RELOCATABLE? Other ideas?

Thanks,
Nick


---
 arch/powerpc/include/asm/exception-64s.h | 63 ++++++++++++++++++++++++++------
 arch/powerpc/kernel/exceptions-64s.S     |  4 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 18 +++++----
 3 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 84d49b1..466870f 100644
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
@@ -218,12 +223,43 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtctr	reg;							\
 	bctr
 
+/*
+ * KVM requires a far (>64K) branch, and to set the exit number in r12
+ * when branching from an exception
+ */
+#define BRANCH_TO_KVM_EXIT(reg, label)					\
+	mfctr	reg;							\
+	std	reg,HSTATE_SCRATCH2(r13);				\
+	__LOAD_FAR_HANDLER(reg, label);					\
+	mtctr	reg;							\
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
+#define BRANCH_TO_KVM_EXIT(reg, label)					\
+	b	label
+
+#define BRANCH_LINK_TO_KVM(reg, label)					\
+	b	label
+
 #endif
 
+
 #define __KVM_HANDLER_PROLOG(area, n)					\
 	BEGIN_FTR_SECTION_NESTED(947)					\
 	ld	r10,area+EX_CFAR(r13);					\
@@ -234,30 +270,35 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	std	r10,HSTATE_PPR(r13);					\
 	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948);	\
 	ld	r10,area+EX_R10(r13);					\
-	stw	r9,HSTATE_SCRATCH1(r13);				\
-	ld	r9,area+EX_R9(r13);					\
 	std	r12,HSTATE_SCRATCH0(r13);				\
+	li	r12,(n);						\
+	sldi	r12,r12,32;						\
+	ori	r12,r12,r9;						\
+	ld	r9,area+EX_R9(r13);					\
+	std	r9,HSTATE_SCRATCH1(r13);				\
 
 #define __KVM_HANDLER(area, h, n)					\
 	__KVM_HANDLER_PROLOG(area, n)					\
-	li	r12,n;							\
-	b	kvmppc_interrupt
+	BRANCH_TO_KVM_EXIT(r9, kvmppc_interrupt)
 
 #define __KVM_HANDLER_SKIP(area, h, n)					\
 	cmpwi	r10,KVM_GUEST_MODE_SKIP;				\
-	ld	r10,area+EX_R10(r13);					\
 	beq	89f;							\
-	stw	r9,HSTATE_SCRATCH1(r13);				\
 	BEGIN_FTR_SECTION_NESTED(948)					\
-	ld	r9,area+EX_PPR(r13);					\
-	std	r9,HSTATE_PPR(r13);					\
+	ld	r10,area+EX_PPR(r13);					\
+	std	r0,HSTATE_PPR(r13);					\
 	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948);	\
-	ld	r9,area+EX_R9(r13);					\
+	ld	r10,area+EX_R10(r13);					\
 	std	r12,HSTATE_SCRATCH0(r13);				\
-	li	r12,n;							\
-	b	kvmppc_interrupt;					\
+	li	r12,(n);						\
+	sldi	r12,r12,32;						\
+	ori	r12,r12,r9;						\
+	ld	r9,area+EX_R9(r13);					\
+	std	r9,HSTATE_SCRATCH1(r13);				\
+	BRANCH_TO_KVM_EXIT(r9, kvmppc_interrupt);			\
 89:	mtocrf	0x80,r9;						\
 	ld	r9,area+EX_R9(r13);					\
+	ld	r10,area+EX_R10(r13);					\
 	b	kvmppc_skip_##h##interrupt
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e680e84..81c3a63 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -137,7 +137,7 @@ EXC_COMMON_BEGIN(system_reset_idle_common)
 	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
 	cmpwi	r0,0
 	beq	1f
-	b	kvm_start_guest
+	BRANCH_TO_KVM(r10, kvm_start_guest)
 1:
 #endif
 
@@ -974,7 +974,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	hmi_exception_realmode
+	BRANCH_LINK_TO_KVM(r4, hmi_exception_realmode)
 	/* Windup the stack. */
 	/* Move original HSRR0 and HSRR1 into the respective regs */
 	ld	r9,_MSR(r1)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c3c1d1b..824e87a 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1043,19 +1043,23 @@ hdec_soon:
 kvmppc_interrupt_hv:
 	/*
 	 * Register contents:
-	 * R12		= interrupt vector
+	 * R12		= (interrupt vector << 32) | guest CR
 	 * R13		= PACA
-	 * guest CR, R12 saved in shadow VCPU SCRATCH1/0
+	 * guest R12, R9 saved in shadow VCPU SCRATCH0/1 respectively
+	 * guest CTR saved in shadow VCPU SCRATCH2 if RELOCATABLE
 	 * guest R13 saved in SPRN_SCRATCH0
 	 */
-	std	r9, HSTATE_SCRATCH2(r13)
+#ifdef CONFIG_RELOCATABLE
+	ld	r9, HSTATE_SCRATCH2(r13)
+	mfctr	r9
+#endif
 
 	lbz	r9, HSTATE_IN_GUEST(r13)
 	cmpwi	r9, KVM_GUEST_MODE_HOST_HV
 	beq	kvmppc_bad_host_intr
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	cmpwi	r9, KVM_GUEST_MODE_GUEST
-	ld	r9, HSTATE_SCRATCH2(r13)
+	ld	r9, HSTATE_SCRATCH1(r13)
 	beq	kvmppc_interrupt_pr
 #endif
 	/* We're now back in the host but in guest MMU context */
@@ -1075,14 +1079,13 @@ kvmppc_interrupt_hv:
 	std	r6, VCPU_GPR(R6)(r9)
 	std	r7, VCPU_GPR(R7)(r9)
 	std	r8, VCPU_GPR(R8)(r9)
-	ld	r0, HSTATE_SCRATCH2(r13)
+	ld	r0, HSTATE_SCRATCH1(r13)
 	std	r0, VCPU_GPR(R9)(r9)
 	std	r10, VCPU_GPR(R10)(r9)
 	std	r11, VCPU_GPR(R11)(r9)
 	ld	r3, HSTATE_SCRATCH0(r13)
-	lwz	r4, HSTATE_SCRATCH1(r13)
 	std	r3, VCPU_GPR(R12)(r9)
-	stw	r4, VCPU_CR(r9)
+	stw	r12, VCPU_CR(r9)	/* CR is in the low half of r12 */
 BEGIN_FTR_SECTION
 	ld	r3, HSTATE_CFAR(r13)
 	std	r3, VCPU_CFAR(r9)
@@ -1100,6 +1103,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	mfspr	r11, SPRN_SRR1
 	std	r10, VCPU_SRR0(r9)
 	std	r11, VCPU_SRR1(r9)
+	srdi	r12, r12, 32		/* trap is in the high half of r12 */
 	andi.	r0, r12, 2		/* need to read HSRR0/1? */
 	beq	1f
 	mfspr	r10, SPRN_HSRR0
-- 
2.9.3
