Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0AB91A0AB1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 18:08:18 +1100 (AEDT)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0CA8614090A
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Jan 2016 18:08:17 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 13 Jan 2016 00:08:16 -0700
Subject: [PATCH v3 2/2] KVM: PPC: Exit guest upon MCE when FWNMI capability is
 enabled
To: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org, paulus@ozlabs.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: mahesh@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 kvm@vger.kernel.org, mpe@ellerman.id.au
Date: Wed, 13 Jan 2016 12:38:09 +0530
Message-ID: <20160113070809.20248.80811.stgit@aravindap>
In-Reply-To: <20160113070759.20248.86252.stgit@aravindap>
References: <20160113070759.20248.86252.stgit@aravindap>
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

Enhance KVM to cause a guest exit with KVM_EXIT_NMI
exit reasons upon a machine check exception (MCE) in
the guest address space if the KVM_CAP_PPC_FWNMI
capability is enabled (instead of delivering 0x200
interrupt to guest). This enables QEMU to build error
log and deliver machine check exception to guest via
guest registered machine check handler.

This approach simplifies the delivering of machine
check exception to guest OS compared to the earlier
approach of KVM directly invoking 0x200 guest interrupt
vector. In the earlier approach QEMU was enhanced to
patch the 0x200 interrupt vector during boot. The
patched code at 0x200 issued a private hcall to pass
the control to QEMU to build the error log.

This design/approach is based on the feedback for the
QEMU patches to handle machine check exception. Details
of earlier approach of handling machine check exception
in QEMU and related discussions can be found at:

https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c            |   12 ++------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   48 +++++++++++++++----------------
 2 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index a7352b5..4fa03d0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -858,15 +858,9 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
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
index 3c6badc..84e32a3 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -133,21 +133,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	stb	r0, HSTATE_HWTHREAD_REQ(r13)
 
 	/*
-	 * For external and machine check interrupts, we need
-	 * to call the Linux handler to process the interrupt.
-	 * We do that by jumping to absolute address 0x500 for
-	 * external interrupts, or the machine_check_fwnmi label
-	 * for machine checks (since firmware might have patched
-	 * the vector area at 0x200).  The [h]rfid at the end of the
-	 * handler will return to the book3s_hv_interrupts.S code.
-	 * For other interrupts we do the rfid to get back
-	 * to the book3s_hv_interrupts.S code here.
+	 * For external interrupts we need to call the Linux
+	 * handler to process the interrupt. We do that by jumping
+	 * to absolute address 0x500 for external interrupts.
+	 * The [h]rfid at the end of the handler will return to
+	 * the book3s_hv_interrupts.S code. For other interrupts
+	 * we do the rfid to get back to the book3s_hv_interrupts.S
+	 * code here.
 	 */
 	ld	r8, 112+PPC_LR_STKOFF(r1)
 	addi	r1, r1, 112
 	ld	r7, HSTATE_HOST_MSR(r13)
 
-	cmpwi	cr1, r12, BOOK3S_INTERRUPT_MACHINE_CHECK
 	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
 	beq	11f
 	cmpwi	r12, BOOK3S_INTERRUPT_H_DOORBELL
@@ -162,7 +159,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtmsrd	r6, 1			/* Clear RI in MSR */
 	mtsrr0	r8
 	mtsrr1	r7
-	beq	cr1, 13f		/* machine check */
 	RFI
 
 	/* On POWER7, we have external interrupts set to use HSRR0/1 */
@@ -170,8 +166,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_HSRR1, r7
 	ba	0x500
 
-13:	b	machine_check_fwnmi
-
 14:	mtspr	SPRN_HSRR0, r8
 	mtspr	SPRN_HSRR1, r7
 	b	hmi_exception_after_realmode
@@ -2390,15 +2384,13 @@ machine_check_realmode:
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
+	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest either
+	 * through machine check interrupt (set HSRR0 to 0x200) or by
+	 * exiting the guest with KVM_EXIT_NMI exit reason if guest is
+	 * FWNMI capable. For handled errors (no-fatal), just go back
+	 * to guest execution with current HSRR0. This new approach
+	 * injects machine check errors in guest address space to guest
+	 * enabling guest kernel to suitably handle such errors.
 	 *
 	 * if we receive machine check with MSR(RI=0) then deliver it to
 	 * guest as machine check causing guest to crash.
@@ -2408,11 +2400,17 @@ machine_check_realmode:
 	beq	1f			/* Deliver a machine check to guest */
 	ld	r10, VCPU_PC(r9)
 	cmpdi	r3, 0		/* Did we handle MCE ? */
-	bne	2f	/* Continue guest execution. */
+	bne	3f	/* Continue guest execution. */
 	/* If not, deliver a machine check.  SRR0/1 are already set */
-1:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
+1:  /* Check if guest is capable of handling NMI exit */
+	ld  r3, VCPU_KVM(r9)
+	lbz  r3, KVM_FWNMI(r3)
+	cmpdi   r3, 1       /* FWNMI capable? */
+	bne 2f
+	b   mc_cont
+2:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
 	bl	kvmppc_msr_interrupt
-2:	b	fast_interrupt_c_return
+3:	b	fast_interrupt_c_return
 
 /*
  * Check the reason we woke from nap, and take appropriate action.
