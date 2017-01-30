Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBpxw5vSMzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:44:52 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vBpxw2R65z9sCX
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2017 23:44:50 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0UCiTEX135047
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2017 07:44:49 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 289td6xpsk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2017 07:44:48 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 30 Jan 2017 18:14:44 +0530
Date: Mon, 30 Jan 2017 15:43:05 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm@vger.kernel.org, gleb@kernel.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>, david@gibson.dropbear.id.au
Subject: Re: [PATCH v5 2/2] KVM: PPC: Exit guest upon MCE when FWNMI
 capability is enabled
Reply-To: mahesh@linux.vnet.ibm.com
References: <148430634902.22799.7589829837646104546.stgit@aravinda>
 <148430650591.22799.7426036865298338317.stgit@aravinda>
 <20170116043527.GA4577@fergus.ozlabs.ibm.com>
 <fc415f1b-fdb0-a763-0eba-5fb10176844f@linux.vnet.ibm.com>
 <20170127031449.kecknhpwjzmnpvbo@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170127031449.kecknhpwjzmnpvbo@oak.ozlabs.ibm.com>
Message-Id: <20170130101305.GA10890@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017-01-27 14:14:49 Fri, Paul Mackerras wrote:
> On Wed, Jan 18, 2017 at 11:19:26AM +0530, Mahesh Jagannath Salgaonkar wrote:
> > On 01/16/2017 10:05 AM, Paul Mackerras wrote:
> > > On Fri, Jan 13, 2017 at 04:51:45PM +0530, Aravinda Prasad wrote:
> 
> [snip]
> 
> > >>  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
> > >> +		/* Exit to guest with KVM_EXIT_NMI as exit reason */
> > >> +		run->exit_reason = KVM_EXIT_NMI;
> > >> +		r = RESUME_HOST;
> > >>  		/*
> > >> -		 * Deliver a machine check interrupt to the guest.
> > >> -		 * We have to do this, even if the host has handled the
> > >> -		 * machine check, because machine checks use SRR0/1 and
> > >> -		 * the interrupt might have trashed guest state in them.
> > >> +		 * Invoke host-kernel handler to perform any host-side
> > >> +		 * handling before exiting the guest.
> > >>  		 */
> > >> -		kvmppc_book3s_queue_irqprio(vcpu,
> > >> -					    BOOK3S_INTERRUPT_MACHINE_CHECK);
> > >> -		r = RESUME_GUEST;
> > >> +		kvmppc_machine_check_hook();
> > > 
> > > Note that this won't necessarily be called on the same CPU that
> > > received the machine check.  This will be called on thread 0 of the
> > > core (or subcore), whereas the machine check could have occurred on
> > > some other thread.  Are you sure that the machine check handling code
> > > will be OK with that?
> > 
> > That will have only one problem. get_mce_event() from
> > opal_machine_check() may not be able to pull mce event for error on
> > non-zero thread. We should hook the mce event into vcpu structure during
> > kvmppc_realmode_machine_check() and then pass it to
> > ppc_md.machine_check_exception() as an additional argument.
> 
> To move things along...
> 
> Mahesh, how would we get hold of the mce event from real-mode assembly
> code?  What function would we need to call to get the event?  Could
> you write some code (or at least some pseudo-code) to illustrate how
> it would be done?

I am thinking of passing all the handled/unhandled mce errors to guest
if fwnmi capability is supported by QEMU. Otherwise fall back to the old
behaviour. I have done modifications to this patch which is almost
ready. Planning to pass additional info to QEMU about whether MCE
error was recovered or not, so that QEMU can correctly set the RTAS
DISPOSITION.

Below is the modified patch. It uses one bit from kvm_run->flags to pass
disposition information (0 = unrecovred, 1 = recovred). But RTAS
disposition can have 3 values as per PAPR. The 3rd value indicates
limited recovery. For PAPR compliance, I am thiniking of using
two bits from kvm_run->flags (b00 = Fully recovered, b01 = Limited
recovery, b10= Not recovered.).

Let me know what you think about this approach.

------------------------------------------

Enhance KVM to cause a guest exit with KVM_EXIT_NMI

From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

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
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h     |    2 +
 arch/powerpc/include/asm/machdep.h      |    7 +++++
 arch/powerpc/include/asm/opal.h         |    4 +++
 arch/powerpc/include/uapi/asm/kvm.h     |    3 ++
 arch/powerpc/kvm/book3s_hv.c            |   21 +++++++++-----
 arch/powerpc/kvm/book3s_hv_ras.c        |   14 +++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   47 ++++++++++++++++---------------
 arch/powerpc/platforms/powernv/opal.c   |   26 +++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c  |    3 ++
 9 files changed, 96 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 018c684..cf79a98 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -35,6 +35,7 @@
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 #include <asm/hvcall.h>
+#include <asm/mce.h>
 
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
@@ -637,6 +638,7 @@ struct kvm_vcpu_arch {
 	int thread_cpu;
 	bool timer_running;
 	wait_queue_head_t cpu_run;
+	struct machine_check_event mce_evt; /* Valid if trap == 0x200 */
 
 	struct kvm_vcpu_arch_shared *shared;
 #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_KVM_BOOK3S_PR_POSSIBLE)
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index e02cbc6..663a3af 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -15,6 +15,7 @@
 #include <linux/export.h>
 
 #include <asm/setup.h>
+#include <asm/mce.h>
 
 /* We export this macro for external modules like Alsa to know if
  * ppc_md.feature_call is implemented or not
@@ -112,6 +113,12 @@ struct machdep_calls {
 	/* Called during machine check exception to retrive fixup address. */
 	bool		(*mce_check_early_recovery)(struct pt_regs *regs);
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	/* Called after KVM interrupt handler finishes handling MCE for guest */
+	int		(*machine_check_exception_guest)
+					(struct machine_check_event *evt);
+#endif
+
 	/* Motherboard/chipset features. This is a kind of general purpose
 	 * hook used to control some machine specific features (like reset
 	 * lines, chip power control, etc...).
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index e958b70..c04418b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -17,6 +17,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/notifier.h>
+#include <asm/mce.h>
 
 /* We calculate number of sg entries based on PAGE_SIZE */
 #define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
@@ -276,6 +277,9 @@ extern int opal_hmi_handler_init(void);
 extern int opal_event_init(void);
 
 extern int opal_machine_check(struct pt_regs *regs);
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+extern int opal_machine_check_guest(struct machine_check_event *evt);
+#endif
 extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
 extern int opal_hmi_exception_early(struct pt_regs *regs);
 extern int opal_handle_hmi_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index c93cf35..d3538260 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -57,6 +57,9 @@ struct kvm_regs {
 
 #define KVM_SREGS_E_FSL_PIDn	(1 << 0) /* PID1/PID2 */
 
+/* flags for kvm_run.flags */
+#define KVM_RUN_PPC_NMI_RECOVERED	(1 << 0)
+
 /*
  * Feature bits indicate which sections of the sregs struct are valid,
  * both in KVM_GET_SREGS and KVM_SET_SREGS.  On KVM_SET_SREGS, registers
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3686471..94b9f8b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -954,15 +954,22 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
+		/* Exit to guest with KVM_EXIT_NMI as exit reason */
+		run->exit_reason = KVM_EXIT_NMI;
+		run->hw.hardware_exit_reason = vcpu->arch.trap;
+		if (vcpu->arch.mce_evt.disposition == MCE_DISPOSITION_RECOVERED)
+			run->flags |= KVM_RUN_PPC_NMI_RECOVERED;
+		else
+			run->flags &= ~KVM_RUN_PPC_NMI_RECOVERED;
+
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
+		if (ppc_md.machine_check_exception_guest)
+			ppc_md.machine_check_exception_guest(
+							&vcpu->arch.mce_evt);
 		break;
 	case BOOK3S_INTERRUPT_PROGRAM:
 	{
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index 0fa70a9..fa5718f 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -133,8 +133,20 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 	 * interrupt (for unhandled errors) or will continue from
 	 * current HSRR0 (for handled errors) in guest. Hence
 	 * queue up the event so that we can log it from host console later.
+	 * If QEMU support FWNMI capability then hook the MCE event into
+	 * vcpu structure.
 	 */
-	machine_check_queue_event();
+	if (vcpu->arch.fwnmi_enabled) {
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
index c3c1d1b..76f4e1f 100644
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
@@ -2354,13 +2350,18 @@ machine_check_realmode:
 	ld	r11, VCPU_MSR(r9)
 	rldicl.	r0, r11, 64-MSR_HV_LG, 63 /* check if it happened in HV mode */
 	bne	mc_cont			/* if so, exit to host */
+	/* Check if guest is capable of handling NMI exit */
+	ld	r0, VCPU_KVM(r9)
+	lbz	r0, KVM_FWNMI(r0)
+	cmpdi	r0, 1			/* FWNMI capable? */
+	beq	mc_cont
 	andi.	r10, r11, MSR_RI	/* check for unrecoverable exception */
 	beq	1f			/* Deliver a machine check to guest */
 	ld	r10, VCPU_PC(r9)
 	cmpdi	r3, 0		/* Did we handle MCE ? */
 	bne	2f	/* Continue guest execution. */
 	/* If not, deliver a machine check.  SRR0/1 are already set */
-1:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
+	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
 	bl	kvmppc_msr_interrupt
 2:	b	fast_interrupt_c_return
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 6c9a65b..972e418 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -488,6 +488,32 @@ int opal_machine_check(struct pt_regs *regs)
 	return 0;
 }
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+/*
+ * opal_machine_check_guest() is a hook which is invoked at the time
+ * of guest exit to facilitate the host-side handling of machine check
+ * exception before the exception is passed on to the guest. This hook
+ * is invoked from host virtual mode from KVM (before exiting the guest
+ * with KVM_EXIT_NMI reason) for machine check exception that occurs in
+ * the guest.
+ *
+ * Currently no action is performed in the host other than printing the
+ * event information. The machine check exception is passed on to the
+ * guest kernel and the guest kernel will attempt for recovery.
+ */
+int opal_machine_check_guest(struct machine_check_event *evt)
+{
+	/* Print things out */
+	if (evt->version != MCE_V1) {
+		pr_err("Machine Check Exception, Unknown event version %d !\n",
+		       evt->version);
+		return 0;
+	}
+	machine_check_print_event_info(evt);
+	return 0;
+}
+#endif
+
 /* Early hmi handler called in real mode. */
 int opal_hmi_exception_early(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index efe8b6b..d12b479 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -264,6 +264,9 @@ static void __init pnv_setup_machdep_opal(void)
 	ppc_md.mce_check_early_recovery = opal_mce_check_early_recovery;
 	ppc_md.hmi_exception_early = opal_hmi_exception_early;
 	ppc_md.handle_hmi_exception = opal_handle_hmi_exception;
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	ppc_md.machine_check_exception_guest = opal_machine_check_guest;
+#endif
 }
 
 static int __init pnv_probe(void)
