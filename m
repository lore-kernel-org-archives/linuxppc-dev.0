Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8lSc184nzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 15:00:48 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id f144so17708717pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 20:00:48 -0800 (PST)
Date: Fri, 27 Jan 2017 14:00:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Michael
 Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE support
 for interrupts
Message-ID: <20170127140034.7ccc3776@roar.ozlabs.ibm.com>
In-Reply-To: <20170127025019.6ixxkr4my3scnkar@oak.ozlabs.ibm.com>
References: <20161221182927.24562-1-npiggin@gmail.com>
 <20161221182927.24562-4-npiggin@gmail.com>
 <20170127025019.6ixxkr4my3scnkar@oak.ozlabs.ibm.com>
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

On Fri, 27 Jan 2017 13:50:19 +1100
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Thu, Dec 22, 2016 at 04:29:27AM +1000, Nicholas Piggin wrote:
> > 64-bit Book3S exception handlers must find the dynamic kernel base
> > to add to the target address when branching beyond __end_interrupts,
> > in order to support kernel running at non-0 physical address.
> > 
> > Support this in KVM by branching with CTR, similarly to regular
> > interrupt handlers. The guest CTR saved in HSTATE_SCRATCH1 and
> > restored after the branch.
> > 
> > Without this, the host kernel hangs and crashes randomly when it is
> > running at a non-0 address and a KVM guest is started.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> 
> Looks OK to me.
> 
> I have a slight quibble about the naming of the "BRANCH_LINK_TO_KVM"
> macro because neither its definition nor the place where it's used
> have anything to do with KVM as far as I can see.  That needn't stop
> the patch going in, though.
> 
> Acked-by: Paul Mackerras <paulus@ozlabs.org>

No that makes sense, good point. Here's an updated patch 3 with the
hmi handler removed and some comments slightly updated (no code
changes otherwise).

I'll send the hmi relocation fix as another patch.

Thanks,
Nick

--

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
 arch/powerpc/include/asm/exception-64s.h | 45 +++++++++++++++++++++++++++++---
 arch/powerpc/kernel/exceptions-64s.S     |  2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 11 +++++---
 arch/powerpc/kvm/book3s_segment.S        |  7 +++++
 4 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index a02a268bde6b..9a5dbfb2d9f2 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -97,6 +97,15 @@
 	ld	reg,PACAKBASE(r13);					\
 	ori	reg,reg,(ABS_ADDR(label))@l;
 
+/*
+ * Branches from unrelocated code (e.g., interrupts) to labels outside
+ * head-y require >64K offsets.
+ */
+#define __LOAD_FAR_HANDLER(reg, label)					\
+	ld	reg,PACAKBASE(r13);					\
+	ori	reg,reg,(ABS_ADDR(label))@l;				\
+	addis	reg,reg,(ABS_ADDR(label))@h;
+
 /* Exception register prefixes */
 #define EXC_HV	H
 #define EXC_STD
@@ -227,12 +236,40 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtctr	reg;							\
 	bctr
 
+/*
+ * KVM requires __LOAD_FAR_HANDLER.
+ *
+ * __BRANCH_TO_KVM_EXIT branches are also a special case because they
+ * explicitly use r9 then reload it from PACA before branching. Hence
+ * the double-underscore.
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
 #endif
 
+
 #define __KVM_HANDLER(area, h, n)					\
 	BEGIN_FTR_SECTION_NESTED(947)					\
 	ld	r10,area+EX_CFAR(r13);					\
@@ -246,8 +283,8 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	std	r12,HSTATE_SCRATCH0(r13);				\
 	sldi	r12,r9,32;						\
 	ori	r12,r12,(n);						\
-	ld	r9,area+EX_R9(r13);					\
-	b	kvmppc_interrupt
+	/* This reloads r9 before branching to kvmppc_interrupt */	\
+	__BRANCH_TO_KVM_EXIT(area, kvmppc_interrupt)
 
 #define __KVM_HANDLER_SKIP(area, h, n)					\
 	cmpwi	r10,KVM_GUEST_MODE_SKIP;				\
@@ -260,8 +297,8 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	std	r12,HSTATE_SCRATCH0(r13);				\
 	sldi	r12,r9,32;						\
 	ori	r12,r12,(n);						\
-	ld	r9,area+EX_R9(r13);					\
-	b	kvmppc_interrupt;					\
+	/* This reloads r9 before branching to kvmppc_interrupt */	\
+	__BRANCH_TO_KVM_EXIT(area, kvmppc_interrupt);			\
 89:	mtocrf	0x80,r9;						\
 	ld	r9,area+EX_R9(r13);					\
 	ld	r10,area+EX_R10(r13);					\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 89b4f122aec6..65a2559eeb7f 100644
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
