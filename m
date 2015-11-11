Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 615FA1A01DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 03:59:06 +1100 (AEDT)
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4B103140D97
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2015 03:59:04 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 11 Nov 2015 11:59:01 -0500
Subject: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
To: paulus@ozlabs.org, linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: mahesh@linux.vnet.ibm.com, michaele@au1.ibm.com, agraf@suse.de,
 kvm@vger.kernel.org, david@gibson.dropbear.id.au
Date: Wed, 11 Nov 2015 22:28:46 +0530
Message-ID: <20151111165845.3721.98296.stgit@aravindap>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch modifies KVM to cause a guest exit with
KVM_EXIT_NMI instead of immediately delivering a 0x200
interrupt to guest upon machine check exception in
guest address. Exiting the guest enables QEMU to build
error log and deliver machine check exception to guest
OS (either via guest OS registered machine check
handler or via 0x200 guest OS interrupt vector).

This approach simplifies the delivering of machine
check exception to guest OS compared to the earlier approach
of KVM directly invoking 0x200 guest interrupt vector.
In the earlier approach QEMU patched the 0x200 interrupt
vector during boot. The patched code at 0x200 issued a
private hcall to pass the control to QEMU to build the
error log.

This design/approach is based on the feedback for the
QEMU patches to handle machine check exception. Details
of earlier approach of handling machine check exception
in QEMU and related discussions can be found at:

https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c            |   12 +++---------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   31 +++++++++++--------------------
 2 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2280497..1b1dff0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -859,15 +859,9 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
-		/*
-		 * Deliver a machine check interrupt to the guest.
-		 * We have to do this, even if the host has handled the
-		 * machine check, because machine checks use SRR0/1 and
-		 * the interrupt might have trashed guest state in them.
-		 */
-		kvmppc_book3s_queue_irqprio(vcpu,
-					    BOOK3S_INTERRUPT_MACHINE_CHECK);
-		r = RESUME_GUEST;
+		/* Exit to guest with KVM_EXIT_NMI as exit reason */
+		run->exit_reason = KVM_EXIT_NMI;
+		r = RESUME_HOST;
 		break;
 	case BOOK3S_INTERRUPT_PROGRAM:
 	{
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index b98889e..672b4f6 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -147,7 +147,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	addi	r1, r1, 112
 	ld	r7, HSTATE_HOST_MSR(r13)
 
-	cmpwi	cr1, r12, BOOK3S_INTERRUPT_MACHINE_CHECK
 	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
 	beq	11f
 	cmpwi	cr2, r12, BOOK3S_INTERRUPT_HMI
@@ -160,7 +159,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtmsrd	r6, 1			/* Clear RI in MSR */
 	mtsrr0	r8
 	mtsrr1	r7
-	beq	cr1, 13f		/* machine check */
 	RFI
 
 	/* On POWER7, we have external interrupts set to use HSRR0/1 */
@@ -168,8 +166,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_HSRR1, r7
 	ba	0x500
 
-13:	b	machine_check_fwnmi
-
 14:	mtspr	SPRN_HSRR0, r8
 	mtspr	SPRN_HSRR1, r7
 	b	hmi_exception_after_realmode
@@ -2381,24 +2377,19 @@ machine_check_realmode:
 	ld	r9, HSTATE_KVM_VCPU(r13)
 	li	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
 	/*
-	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest through
-	 * machine check interrupt (set HSRR0 to 0x200). And for handled
-	 * errors (no-fatal), just go back to guest execution with current
-	 * HSRR0 instead of exiting guest. This new approach will inject
-	 * machine check to guest for fatal error causing guest to crash.
-	 *
-	 * The old code used to return to host for unhandled errors which
-	 * was causing guest to hang with soft lockups inside guest and
-	 * makes it difficult to recover guest instance.
+	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest
+	 * by exiting the guest with KVM_EXIT_NMI exit reason (exit
+	 * reason set later based on trap). For handled errors
+	 * (no-fatal), go back to guest execution with current HSRR0
+	 * instead of exiting the guest. This approach will cause
+	 * the guest to exit in case of fatal machine check error.
 	 */
-	ld	r10, VCPU_PC(r9)
+	bne	2f	/* Continue guest execution? */
+	/* If not, exit the guest. SRR0/1 are already set */
+	b	mc_cont
+2:	ld	r10, VCPU_PC(r9)
 	ld	r11, VCPU_MSR(r9)
-	bne	2f	/* Continue guest execution. */
-	/* If not, deliver a machine check.  SRR0/1 are already set */
-	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
-	ld	r11, VCPU_MSR(r9)
-	bl	kvmppc_msr_interrupt
-2:	b	fast_interrupt_c_return
+	b	fast_interrupt_c_return
 
 /*
  * Check the reason we woke from nap, and take appropriate action.
