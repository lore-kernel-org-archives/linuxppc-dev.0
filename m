Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTpYC5wjRzDw02
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 18:18:39 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id p66so3771701pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 23:18:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Alexander Graf <agraf@suse.com>,
 kvm-ppc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE support for
 interrupts
Date: Thu,  1 Dec 2016 18:18:12 +1100
Message-Id: <20161201071812.23258-4-npiggin@gmail.com>
In-Reply-To: <20161201071812.23258-1-npiggin@gmail.com>
References: <20161201071812.23258-1-npiggin@gmail.com>
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
interrupt handlers. The guest CTR saved in HSTATE_SCRATCH2 and
restored after the branch.

Without this, the host kernel hangs and crashes randomly when it is
running at a non-0 address and a KVM guest is started.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 39 ++++++++++++++++++++++++++++++--
 arch/powerpc/include/asm/head-64.h       |  2 +-
 arch/powerpc/kernel/exceptions-64s.S     |  4 ++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  6 +++++
 arch/powerpc/kvm/book3s_segment.S        |  5 ++++
 5 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index bc8fc45..000b317 100644
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
@@ -227,12 +232,42 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtctr	reg;							\
 	bctr
 
+/*
+ * KVM requires >64K branches when branching from unrelocated code.
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
+	bl	label
+
 #endif
 
+
 #define __KVM_HANDLER(area, h, n)					\
 	BEGIN_FTR_SECTION_NESTED(947)					\
 	ld	r10,area+EX_CFAR(r13);					\
@@ -249,7 +284,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	or	r12,r12,r9;						\
 	ld	r9,area+EX_R9(r13);					\
 	std	r9,HSTATE_SCRATCH1(r13);				\
-	b	kvmppc_interrupt
+	BRANCH_TO_KVM_EXIT(r9, kvmppc_interrupt)
 
 #define __KVM_HANDLER_SKIP(area, h, n)					\
 	cmpwi	r10,KVM_GUEST_MODE_SKIP;				\
@@ -265,7 +300,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	or	r12,r12,r9;						\
 	ld	r9,area+EX_R9(r13);					\
 	std	r9,HSTATE_SCRATCH1(r13);				\
-	b	kvmppc_interrupt;					\
+	BRANCH_TO_KVM_EXIT(r9, kvmppc_interrupt);			\
 89:	mtocrf	0x80,r9;						\
 	ld	r9,area+EX_R9(r13);					\
 	ld	r10,area+EX_R10(r13);					\
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index f7131cf..a5cbc1c 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -228,7 +228,7 @@ end_##sname:
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 #define TRAMP_KVM_BEGIN(name)						\
-	TRAMP_REAL_BEGIN(name)
+	TRAMP_VIRT_BEGIN(name)
 #else
 #define TRAMP_KVM_BEGIN(name)
 #endif
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5faff1c..955fc76 100644
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
index 0536c73..1d07cea 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1047,8 +1047,14 @@ kvmppc_interrupt_hv:
 	 * R13		= PACA
 	 * R9		= unused
 	 * guest R12, R9 saved in shadow VCPU SCRATCH0/1 respectively
+	 * guest CTR saved in shadow VCPU SCRATCH2 if RELOCATABLE
 	 * guest R13 saved in SPRN_SCRATCH0
 	 */
+#ifdef CONFIG_RELOCATABLE
+	ld	r9, HSTATE_SCRATCH2(r13)
+	mtctr	r9
+#endif
+
 	lbz	r9, HSTATE_IN_GUEST(r13)
 	cmpwi	r9, KVM_GUEST_MODE_HOST_HV
 	beq	kvmppc_bad_host_intr
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 3b29f0f..4d25b7b 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -177,9 +177,14 @@ kvmppc_interrupt_pr:
 	 * R13             = PACA
 	 * HSTATE.SCRATCH0 = guest R12
 	 * HSTATE.SCRATCH1 = guest R9
+	 * HSTATE.SCRATCH2 = guest CTR if RELOCATABLE
 	 */
 #ifdef CONFIG_PPC64
 	/* Match 32-bit entry */
+#ifdef CONFIG_RELOCATABLE
+	ld	r9,HSTATE_SCRATCH2(r13)
+	mtctr	r9
+#endif
 	ld	r9,HSTATE_SCRATCH1(r13)
 	stw	r12,HSTATE_SCRATCH1(r13) /* CR is in the low half of r12 */
 	srdi	r12, r12, 32		 /* trap is in the high half of r12 */
-- 
2.10.2
