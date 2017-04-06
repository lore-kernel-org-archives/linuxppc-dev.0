Return-Path: <srs0=+vpc=3o=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzVZn4161zDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 03:49:21 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzVZn1LZnz8syC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 03:49:21 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzVZm2m4Pz9s9c
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 03:49:20 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v36HmUsU092961
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 13:49:16 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29nsr9sreh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Apr 2017 13:49:16 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 03:49:13 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v36Hn33j26607784
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 03:49:11 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v36HmcNb007399
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 03:48:38 +1000
Subject: [PATCH v8 3/3] KVM: PPC: Exit guest upon MCE when FWNMI capability
 is enabled
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: gleb@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, agraf@suse.de,
 KVM-PPC <kvm-ppc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>,
 david@gibson.dropbear.id.au
Date: Thu, 06 Apr 2017 23:18:17 +0530
In-Reply-To: <149150078227.9475.13869552319691573937.stgit@jupiter.in.ibm.com>
References: <149150078227.9475.13869552319691573937.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149150089740.9475.12393014638651179403.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Enhance KVM to cause a guest exit with KVM_EXIT_NMI
exit reason upon a machine check exception (MCE) in
the guest address space if the KVM_CAP_PPC_FWNMI
capability is enabled (instead of delivering a 0x200
interrupt to guest). This enables QEMU to build error
log and deliver machine check exception to guest via
guest registered machine check handler.

This approach simplifies the delivery of machine
check exception to guest OS compared to the earlier
approach of KVM directly invoking 0x200 guest interrupt
vector.

This design/approach is based on the feedback for the
QEMU patches to handle machine check exception. Details
of earlier approach of handling machine check exception
in QEMU and related discussions can be found at:

https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html

Note:

This patch now directly invokes machine_check_print_event_info()
from kvmppc_handle_exit_hv() to print the event to host console
at the time of guest exit before the exception is passed on to the
guest. Hence, the host-side handling which was performed earlier
via machine_check_fwnmi is removed.

The reasons for this approach is (i) it is not possible
to distinguish whether the exception occurred in the
guest or the host from the pt_regs passed on the
machine_check_exception(). Hence machine_check_exception()
calls panic, instead of passing on the exception to
the guest, if the machine check exception is not
recoverable. (ii) the approach introduced in this
patch gives opportunity to the host kernel to perform
actions in virtual mode before passing on the exception
to the guest. This approach does not require complex
tweaks to machine_check_fwnmi and friends.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h     |    2 +
 arch/powerpc/include/uapi/asm/kvm.h     |    6 ++++
 arch/powerpc/kvm/book3s_hv.c            |   23 ++++++++------
 arch/powerpc/kvm/book3s_hv_ras.c        |   18 ++++++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   52 ++++++++++++++++++-------------
 5 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 4d02cbc..0627a5a 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -35,6 +35,7 @@
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 #include <asm/hvcall.h>
+#include <asm/mce.h>
 
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
@@ -675,6 +676,7 @@ struct kvm_vcpu_arch {
 	int prev_cpu;
 	bool timer_running;
 	wait_queue_head_t cpu_run;
+	struct machine_check_event mce_evt; /* Valid if trap == 0x200 */
 
 	struct kvm_vcpu_arch_shared *shared;
 #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_KVM_BOOK3S_PR_POSSIBLE)
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 4edbe4b..1fdf64c 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -57,6 +57,12 @@ struct kvm_regs {
 
 #define KVM_SREGS_E_FSL_PIDn	(1 << 0) /* PID1/PID2 */
 
+/* flags for kvm_run.flags */
+#define KVM_RUN_PPC_NMI_DISP_MASK		(3 << 0)
+#define   KVM_RUN_PPC_NMI_DISP_FULLY_RECOV	(1 << 0)
+#define   KVM_RUN_PPC_NMI_DISP_LIMITED_RECOV	(2 << 0)
+#define   KVM_RUN_PPC_NMI_DISP_NOT_RECOV	(3 << 0)
+
 /*
  * Feature bits indicate which sections of the sregs struct are valid,
  * both in KVM_GET_SREGS and KVM_SET_SREGS.  On KVM_SET_SREGS, registers
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 1ec86d9..9a33689 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -966,15 +966,20 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
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
+		run->hw.hardware_exit_reason = vcpu->arch.trap;
+		/* Clear out the old NMI status from run->flags */
+		run->flags &= ~KVM_RUN_PPC_NMI_DISP_MASK;
+		/* Now set the NMI status */
+		if (vcpu->arch.mce_evt.disposition == MCE_DISPOSITION_RECOVERED)
+			run->flags |= KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
+		else
+			run->flags |= KVM_RUN_PPC_NMI_DISP_NOT_RECOV;
+
+		r = RESUME_HOST;
+		/* Print the MCE event to host console. */
+		machine_check_print_event_info(&vcpu->arch.mce_evt);
 		break;
 	case BOOK3S_INTERRUPT_PROGRAM:
 	{
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index 7ef0993..c356f9a 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -130,12 +130,28 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 
 out:
 	/*
+	 * For guest that supports FWNMI capability, hook the MCE event into
+	 * vcpu structure. We are going to exit the guest with KVM_EXIT_NMI
+	 * exit reason. On our way to exit we will pull this event from vcpu
+	 * structure and print it from thread 0 of the core/subcore.
+	 *
+	 * For guest that does not support FWNMI capability (old QEMU):
 	 * We are now going enter guest either through machine check
 	 * interrupt (for unhandled errors) or will continue from
 	 * current HSRR0 (for handled errors) in guest. Hence
 	 * queue up the event so that we can log it from host console later.
 	 */
-	machine_check_queue_event();
+	if (vcpu->kvm->arch.fwnmi_enabled) {
+		/*
+		 * Hook up the mce event on to vcpu structure.
+		 * First clear the old event.
+		 */
+		memset(&vcpu->arch.mce_evt, 0, sizeof(vcpu->arch.mce_evt));
+		if (get_mce_event(&mce_evt, MCE_EVENT_RELEASE)) {
+			vcpu->arch.mce_evt = mce_evt;
+		}
+	} else
+		machine_check_queue_event();
 
 	return handled;
 }
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 7c6477d..b6fe741 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -134,15 +134,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
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
@@ -157,7 +155,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	andi.	r0, r0, MSR_IR		/* in real mode? */
 	bne	.Lvirt_return
 
-	cmpwi	cr1, r12, BOOK3S_INTERRUPT_MACHINE_CHECK
 	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
 	beq	11f
 	cmpwi	r12, BOOK3S_INTERRUPT_H_DOORBELL
@@ -172,7 +169,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtmsrd	r6, 1			/* Clear RI in MSR */
 	mtsrr0	r8
 	mtsrr1	r7
-	beq	cr1, 13f		/* machine check */
+	/*
+	 * BOOK3S_INTERRUPT_MACHINE_CHECK is handled at the
+	 * time of guest exit
+	 */
 	RFI
 
 	/* On POWER7, we have external interrupts set to use HSRR0/1 */
@@ -180,8 +180,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_HSRR1, r7
 	ba	0x500
 
-13:	b	machine_check_fwnmi
-
 14:	mtspr	SPRN_HSRR0, r8
 	mtspr	SPRN_HSRR1, r7
 	b	hmi_exception_after_realmode
@@ -2494,22 +2492,32 @@ machine_check_realmode:
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
+	 * For the guest that is FWNMI capable, deliver all the MCE errors
+	 * (handled/unhandled) by exiting the guest with KVM_EXIT_NMI exit
+	 * reason. This new approach injects machine check errors in guest
+	 * address space to guest with additional information in the form
+	 * of RTAS event, thus enabling guest kernel to suitably handle
+	 * such errors.
 	 *
+	 * For the guest that is not FWNMI capable (old QEMU) fallback
+	 * to old behaviour for backward compatibility:
+	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest either
+	 * through machine check interrupt (set HSRR0 to 0x200).
+	 * For handled errors (no-fatal), just go back to guest execution
+	 * with current HSRR0.
 	 * if we receive machine check with MSR(RI=0) then deliver it to
 	 * guest as machine check causing guest to crash.
 	 */
 	ld	r11, VCPU_MSR(r9)
 	rldicl.	r0, r11, 64-MSR_HV_LG, 63 /* check if it happened in HV mode */
 	bne	mc_cont			/* if so, exit to host */
+	/* Check if guest is capable of handling NMI exit */
+	ld	r10, VCPU_KVM(r9)
+	lbz	r10, KVM_FWNMI(r10)
+	cmpdi	r10, 1			/* FWNMI capable? */
+	beq	mc_cont			/* if so, exit with KVM_EXIT_NMI. */
+
+	/* if not, fall through for backward compatibility. */
 	andi.	r10, r11, MSR_RI	/* check for unrecoverable exception */
 	beq	1f			/* Deliver a machine check to guest */
 	ld	r10, VCPU_PC(r9)
