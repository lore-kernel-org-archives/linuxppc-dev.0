Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0Kw73lZJzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 22:21:59 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3v0Kw66vZ2z9vKd
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 22:21:58 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0DBFYnK020988
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 06:21:56 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27xwuk06qh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 06:21:56 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 13 Jan 2017 04:21:55 -0700
Subject: [PATCH v5 2/2] KVM: PPC: Exit guest upon MCE when FWNMI capability
 is enabled
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org, paulus@ozlabs.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com
Cc: mahesh@linux.vnet.ibm.com, mpe@ellerman.id.au, bsingharora@gmail.com,
 kvm@vger.kernel.org, david@gibson.dropbear.id.au
Date: Fri, 13 Jan 2017 16:51:45 +0530
In-Reply-To: <148430634902.22799.7589829837646104546.stgit@aravinda>
References: <148430634902.22799.7589829837646104546.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148430650591.22799.7426036865298338317.stgit@aravinda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

This patch introduces a hook which is invoked at the time
of guest exit to facilitate the host-side handling of
machine check exception before the exception is passed
on to the guest. Hence, the host-side handling which was
performed earlier via machine_check_fwnmi is removed.

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
---
 arch/powerpc/kvm/book3s_hv.c            |   27 +++++++++++++-----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   47 ++++++++++++++++---------------
 arch/powerpc/platforms/powernv/opal.c   |   10 +++++++
 3 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3686471..cae4921 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -123,6 +123,7 @@ MODULE_PARM_DESC(halt_poll_ns_shrink, "Factor halt poll time is shrunk by");
 
 static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
+static void kvmppc_machine_check_hook(void);
 
 static inline struct kvm_vcpu *next_runnable_thread(struct kvmppc_vcore *vc,
 		int *ip)
@@ -954,15 +955,14 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
+		/* Exit to guest with KVM_EXIT_NMI as exit reason */
+		run->exit_reason = KVM_EXIT_NMI;
+		r = RESUME_HOST;
 		/*
-		 * Deliver a machine check interrupt to the guest.
-		 * We have to do this, even if the host has handled the
-		 * machine check, because machine checks use SRR0/1 and
-		 * the interrupt might have trashed guest state in them.
+		 * Invoke host-kernel handler to perform any host-side
+		 * handling before exiting the guest.
 		 */
-		kvmppc_book3s_queue_irqprio(vcpu,
-					    BOOK3S_INTERRUPT_MACHINE_CHECK);
-		r = RESUME_GUEST;
+		kvmppc_machine_check_hook();
 		break;
 	case BOOK3S_INTERRUPT_PROGRAM:
 	{
@@ -3491,6 +3491,19 @@ static void kvmppc_irq_bypass_del_producer_hv(struct irq_bypass_consumer *cons,
 }
 #endif
 
+/*
+ * Hook to handle machine check exceptions occurred inside a guest.
+ * This hook is invoked from host virtual mode from KVM before exiting
+ * the guest with KVM_EXIT_NMI exit reason. This gives an opportunity
+ * for the host to take action (if any) before passing on the machine
+ * check exception to the guest kernel.
+ */
+static void kvmppc_machine_check_hook(void)
+{
+	if (ppc_md.machine_check_exception)
+		ppc_md.machine_check_exception(NULL);
+}
+
 static long kvm_arch_vm_ioctl_hv(struct file *filp,
 				 unsigned int ioctl, unsigned long arg)
 {
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c3c1d1b..9b41390 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -134,21 +134,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
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
@@ -163,7 +160,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
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
@@ -171,8 +171,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_HSRR1, r7
 	ba	0x500
 
-13:	b	machine_check_fwnmi
-
 14:	mtspr	SPRN_HSRR0, r8
 	mtspr	SPRN_HSRR1, r7
 	b	hmi_exception_after_realmode
@@ -2338,15 +2336,13 @@ machine_check_realmode:
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
@@ -2360,7 +2356,12 @@ machine_check_realmode:
 	cmpdi	r3, 0		/* Did we handle MCE ? */
 	bne	2f	/* Continue guest execution. */
 	/* If not, deliver a machine check.  SRR0/1 are already set */
-1:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
+	/* Check if guest is capable of handling NMI exit */
+1:	ld	r3, VCPU_KVM(r9)
+	lbz	r3, KVM_FWNMI(r3)
+	cmpdi	r3, 1       /* FWNMI capable? */
+	beq	mc_cont
+	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
 	bl	kvmppc_msr_interrupt
 2:	b	fast_interrupt_c_return
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 6c9a65b..25749c6 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -446,6 +446,16 @@ int opal_machine_check(struct pt_regs *regs)
 	}
 	machine_check_print_event_info(&evt);
 
+	/*
+	 * If regs is NULL, then the machine check exception occurred
+	 * in the guest. Currently no action is performed in the host
+	 * other than printing the event information. The machine check
+	 * exception is passed on to the guest kernel and the guest
+	 * kernel will attempt for recovery.
+	 */
+	if (!regs)
+		return 0;
+
 	if (opal_recover_mce(regs, &evt))
 		return 1;
 
