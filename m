Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6806FC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 01:10:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63FC2086D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 01:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="hhZLvWfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63FC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443zzt5BT3zDqLF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 12:10:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443zvh4DswzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 12:06:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="hhZLvWfM"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 443zvh36NMz9sDb; Wed, 20 Feb 2019 12:06:40 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 443zvh2KSwz9s3l; Wed, 20 Feb 2019 12:06:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1550624800; bh=85Hfb2o4HLbQCeKyC41PCoqJ5Wb+Jk56C8mT94/iXyM=;
 h=Date:From:To:Subject:From;
 b=hhZLvWfMoZEVfSItNeifJt+SWUZu7yOSfbrawY1RJLhETiAR17utNbWloMBeHZNOl
 fwOytoB3ll2wBNPAzZvKKFqip/TYJWS1nIx0O3KqqchuP5amjA7Ozl7Nm5FF626fIe
 CJIpSttzLWHf4jKgtB7hO0douX7gsQaDIfi4xudRbadC2T7MM9zg/gM6E08OQ3Y5fd
 NHKYGgeJep4zGGdw7ZbS+PGrRc9/jPx3b1dHnIEI3B36sqAZn/K+Nh3GxUBHlA6hHj
 RFKY5xpzaWzje/B+b04E1ehaDF+VrplljSn0UfFH5CWp5RdOlhScOWwJ0zwTsIQtTL
 zILYDCRL9CFgw==
Date: Wed, 20 Feb 2019 12:05:50 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 1/2] KVM: PPC: Book3S HV: Simplify machine check handling
Message-ID: <20190220010550.GD5353@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This makes the handling of machine check interrupts that occur inside
a guest simpler and more robust, with less done in assembler code and
in real mode.

Now, when a machine check occurs inside a guest, we always get the
machine check event struct and put a copy in the vcpu struct for the
vcpu where the machine check occurred.  We no longer call
machine_check_queue_event() from kvmppc_realmode_mc_power7(), because
on POWER8, when a vcpu is running on an offline secondary thread and
we call machine_check_queue_event(), that calls irq_work_queue(),
which doesn't work because the CPU is offline, but instead triggers
the WARN_ON(lazy_irq_pending()) in pnv_smp_cpu_kill_self() (which
fires again and again because nothing clears the condition).

All that machine_check_queue_event() actually does is to cause the
event to be printed to the console.  For a machine check occurring in
the guest, we now print the event in kvmppc_handle_exit_hv()
instead.

The assembly code at label machine_check_realmode now just calls C
code and then continues exiting the guest.  We no longer either
synthesize a machine check for the guest in assembly code or return
to the guest without a machine check.

The code in kvmppc_handle_exit_hv() is extended to handle the case
where the guest is not FWNMI-capable.  In that case we now always
synthesize a machine check interrupt for the guest.  Previously, if
the host thinks it has recovered the machine check fully, it would
return to the guest without any notification that the machine check
had occurred.  If the machine check was caused by some action of the
guest (such as creating duplicate SLB entries), it is much better to
tell the guest that it has caused a problem.  Therefore we now always
generate a machine check interrupt for guests that are not
FWNMI-capable.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_ppc.h      |  3 +-
 arch/powerpc/kvm/book3s.c               |  7 +++++
 arch/powerpc/kvm/book3s_hv.c            | 18 +++++++++--
 arch/powerpc/kvm/book3s_hv_ras.c        | 56 +++++++++------------------------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 40 ++---------------------
 5 files changed, 42 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index b3bf4f6..d283d31 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -143,6 +143,7 @@ extern void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu);
 
 extern int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu);
 extern int kvmppc_core_pending_dec(struct kvm_vcpu *vcpu);
+extern void kvmppc_core_queue_machine_check(struct kvm_vcpu *vcpu, ulong flags);
 extern void kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong flags);
 extern void kvmppc_core_queue_fpunavail(struct kvm_vcpu *vcpu);
 extern void kvmppc_core_queue_vec_unavail(struct kvm_vcpu *vcpu);
@@ -646,7 +647,7 @@ long int kvmppc_rm_h_confer(struct kvm_vcpu *vcpu, int target,
                             unsigned int yield_count);
 long kvmppc_h_random(struct kvm_vcpu *vcpu);
 void kvmhv_commence_exit(int trap);
-long kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu);
+void kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu);
 void kvmppc_subcore_enter_guest(void);
 void kvmppc_subcore_exit_guest(void);
 long kvmppc_realmode_hmi_handler(void);
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 22a46c6..10c5579 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -195,6 +195,13 @@ void kvmppc_book3s_queue_irqprio(struct kvm_vcpu *vcpu, unsigned int vec)
 }
 EXPORT_SYMBOL_GPL(kvmppc_book3s_queue_irqprio);
 
+void kvmppc_core_queue_machine_check(struct kvm_vcpu *vcpu, ulong flags)
+{
+	/* might as well deliver this straight away */
+	kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_MACHINE_CHECK, flags);
+}
+EXPORT_SYMBOL_GPL(kvmppc_core_queue_machine_check);
+
 void kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong flags)
 {
 	/* might as well deliver this straight away */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 1860c0b..d8bf05a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1215,6 +1215,22 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
+		/* Print the MCE event to host console. */
+		machine_check_print_event_info(&vcpu->arch.mce_evt, false);
+
+		/*
+		 * If the guest can do FWNMI, exit to userspace so it can
+		 * deliver a FWNMI to the guest.
+		 * Otherwise we synthesize a machine check for the guest
+		 * so that it knows that the machine check occurred.
+		 */
+		if (!vcpu->kvm->arch.fwnmi_enabled) {
+			ulong flags = vcpu->arch.shregs.msr & 0x083c0000;
+			kvmppc_core_queue_machine_check(vcpu, flags);
+			r = RESUME_GUEST;
+			break;
+		}
+
 		/* Exit to guest with KVM_EXIT_NMI as exit reason */
 		run->exit_reason = KVM_EXIT_NMI;
 		run->hw.hardware_exit_reason = vcpu->arch.trap;
@@ -1227,8 +1243,6 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			run->flags |= KVM_RUN_PPC_NMI_DISP_NOT_RECOV;
 
 		r = RESUME_HOST;
-		/* Print the MCE event to host console. */
-		machine_check_print_event_info(&vcpu->arch.mce_evt, false);
 		break;
 	case BOOK3S_INTERRUPT_PROGRAM:
 	{
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index 0787f12..9aa10b1 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -69,7 +69,7 @@ static void reload_slb(struct kvm_vcpu *vcpu)
  *
  * Returns: 0 => exit guest, 1 => deliver machine check to guest
  */
-static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
+static void kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 {
 	unsigned long srr1 = vcpu->arch.shregs.msr;
 	struct machine_check_event mce_evt;
@@ -111,52 +111,24 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 	}
 
 	/*
-	 * See if we have already handled the condition in the linux host.
-	 * We assume that if the condition is recovered then linux host
-	 * will have generated an error log event that we will pick
-	 * up and log later.
-	 * Don't release mce event now. We will queue up the event so that
-	 * we can log the MCE event info on host console.
+	 * Now get the event and stash it in the vcpu struct so it can
+	 * be handled by the primary thread in virtual mode.  We can't
+	 * call machine_check_queue_event() here if we are running on
+	 * an offline secondary thread.
 	 */
-	if (!get_mce_event(&mce_evt, MCE_EVENT_DONTRELEASE))
-		goto out;
-
-	if (mce_evt.version == MCE_V1 &&
-	    (mce_evt.severity == MCE_SEV_NO_ERROR ||
-	     mce_evt.disposition == MCE_DISPOSITION_RECOVERED))
-		handled = 1;
-
-out:
-	/*
-	 * For guest that supports FWNMI capability, hook the MCE event into
-	 * vcpu structure. We are going to exit the guest with KVM_EXIT_NMI
-	 * exit reason. On our way to exit we will pull this event from vcpu
-	 * structure and print it from thread 0 of the core/subcore.
-	 *
-	 * For guest that does not support FWNMI capability (old QEMU):
-	 * We are now going enter guest either through machine check
-	 * interrupt (for unhandled errors) or will continue from
-	 * current HSRR0 (for handled errors) in guest. Hence
-	 * queue up the event so that we can log it from host console later.
-	 */
-	if (vcpu->kvm->arch.fwnmi_enabled) {
-		/*
-		 * Hook up the mce event on to vcpu structure.
-		 * First clear the old event.
-		 */
-		memset(&vcpu->arch.mce_evt, 0, sizeof(vcpu->arch.mce_evt));
-		if (get_mce_event(&mce_evt, MCE_EVENT_RELEASE)) {
-			vcpu->arch.mce_evt = mce_evt;
-		}
-	} else
-		machine_check_queue_event();
+	if (get_mce_event(&mce_evt, MCE_EVENT_RELEASE)) {
+		if (handled && mce_evt.version == MCE_V1)
+			mce_evt.disposition = MCE_DISPOSITION_RECOVERED;
+	} else {
+		memset(&mce_evt, 0, sizeof(mce_evt));
+	}
 
-	return handled;
+	vcpu->arch.mce_evt = mce_evt;
 }
 
-long kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu)
+void kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu)
 {
-	return kvmppc_realmode_mc_power7(vcpu);
+	kvmppc_realmode_mc_power7(vcpu);
 }
 
 /* Check if dynamic split is in force and return subcore size accordingly. */
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 9b8d50a..f24f6a2 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2826,49 +2826,15 @@ kvm_cede_exit:
 #endif /* CONFIG_KVM_XICS */
 3:	b	guest_exit_cont
 
-	/* Try to handle a machine check in real mode */
+	/* Try to do machine check recovery in real mode */
 machine_check_realmode:
 	mr	r3, r9		/* get vcpu pointer */
 	bl	kvmppc_realmode_machine_check
 	nop
+	/* all machine checks go to virtual mode for further handling */
 	ld	r9, HSTATE_KVM_VCPU(r13)
 	li	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
-	/*
-	 * For the guest that is FWNMI capable, deliver all the MCE errors
-	 * (handled/unhandled) by exiting the guest with KVM_EXIT_NMI exit
-	 * reason. This new approach injects machine check errors in guest
-	 * address space to guest with additional information in the form
-	 * of RTAS event, thus enabling guest kernel to suitably handle
-	 * such errors.
-	 *
-	 * For the guest that is not FWNMI capable (old QEMU) fallback
-	 * to old behaviour for backward compatibility:
-	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest either
-	 * through machine check interrupt (set HSRR0 to 0x200).
-	 * For handled errors (no-fatal), just go back to guest execution
-	 * with current HSRR0.
-	 * if we receive machine check with MSR(RI=0) then deliver it to
-	 * guest as machine check causing guest to crash.
-	 */
-	ld	r11, VCPU_MSR(r9)
-	rldicl.	r0, r11, 64-MSR_HV_LG, 63 /* check if it happened in HV mode */
-	bne	guest_exit_cont		/* if so, exit to host */
-	/* Check if guest is capable of handling NMI exit */
-	ld	r10, VCPU_KVM(r9)
-	lbz	r10, KVM_FWNMI(r10)
-	cmpdi	r10, 1			/* FWNMI capable? */
-	beq	guest_exit_cont		/* if so, exit with KVM_EXIT_NMI. */
-
-	/* if not, fall through for backward compatibility. */
-	andi.	r10, r11, MSR_RI	/* check for unrecoverable exception */
-	beq	1f			/* Deliver a machine check to guest */
-	ld	r10, VCPU_PC(r9)
-	cmpdi	r3, 0		/* Did we handle MCE ? */
-	bne	2f	/* Continue guest execution. */
-	/* If not, deliver a machine check.  SRR0/1 are already set */
-1:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
-	bl	kvmppc_msr_interrupt
-2:	b	fast_interrupt_c_return
+	b	guest_exit_cont
 
 /*
  * Call C code to handle a HMI in real mode.
-- 
2.7.4

