Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DB8C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 11:40:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880E2206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 11:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="OdwITkdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880E2206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pcdl3Y75zF3DV
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 21:40:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="OdwITkdt";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSB4lPSzF36D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="OdwITkdt"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSB3s8dz9t0G; Tue,  2 Oct 2018 21:31:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSB1NmZz9sjD;
 Tue,  2 Oct 2018 21:31:54 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479914; bh=W5NaERR153Qkljai7wq3ZLexn7ROKJeTWWGWUW+jr8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OdwITkdtHRXjq4lCqhPQ9pn06qd5AKTAb5Eb9Mckkc8iXW+Af6WN0om95FP+BmOYJ
 L2ElMeuQpEpfBxjAb/EHPWHXe6fOM/8lAj9rsg84ruqNn4qqJ9cJ+ZaEBEQDXz61Qr
 vD+TNvC9hhSl+hozpYEbcERy447BckUOb+PArTQDqShQaRvvJajUj7tWWkSUzieaNh
 3xkav0Otps2Ekz/nxml2GiATQVaXzDgg35lEbyTEdZtTNgmER4xo4V29FIqRFtC6z6
 SRyhEeEIzD0aHurntAa1bAU1+n+cP39iGDcswatz/tvFQuuvcaymvqsGgypErH+TCa
 f2gdnoktFh4Ag==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 02/33] KVM: PPC: Book3S: Simplify external interrupt
 handling
Date: Tue,  2 Oct 2018 21:31:01 +1000
Message-Id: <1538479892-14835-3-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently we use two bits in the vcpu pending_exceptions bitmap to
indicate that an external interrupt is pending for the guest, one
for "one-shot" interrupts that are cleared when delivered, and one
for interrupts that persist until cleared by an explicit action of
the OS (e.g. an acknowledge to an interrupt controller).  The
BOOK3S_IRQPRIO_EXTERNAL bit is used for one-shot interrupt requests
and BOOK3S_IRQPRIO_EXTERNAL_LEVEL is used for persisting interrupts.

In practice BOOK3S_IRQPRIO_EXTERNAL never gets used, because our
Book3S platforms generally, and pseries in particular, expect
external interrupt requests to persist until they are acknowledged
at the interrupt controller.  That combined with the confusion
introduced by having two bits for what is essentially the same thing
makes it attractive to simplify things by only using one bit.  This
patch does that.

With this patch there is only BOOK3S_IRQPRIO_EXTERNAL, and by default
it has the semantics of a persisting interrupt.  In order to avoid
breaking the ABI, we introduce a new "external_oneshot" flag which
preserves the behaviour of the KVM_INTERRUPT ioctl with the
KVM_INTERRUPT_SET argument.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_asm.h             |  4 +--
 arch/powerpc/include/asm/kvm_host.h            |  1 +
 arch/powerpc/kvm/book3s.c                      | 43 ++++++++++++++++++++------
 arch/powerpc/kvm/book3s_hv_rm_xics.c           |  5 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |  4 +--
 arch/powerpc/kvm/book3s_pr.c                   |  1 -
 arch/powerpc/kvm/book3s_xics.c                 | 11 +++----
 arch/powerpc/kvm/book3s_xive_template.c        |  2 +-
 arch/powerpc/kvm/trace_book3s.h                |  1 -
 tools/perf/arch/powerpc/util/book3s_hv_exits.h |  1 -
 10 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index a790d5c..1f32191 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -84,7 +84,6 @@
 #define BOOK3S_INTERRUPT_INST_STORAGE	0x400
 #define BOOK3S_INTERRUPT_INST_SEGMENT	0x480
 #define BOOK3S_INTERRUPT_EXTERNAL	0x500
-#define BOOK3S_INTERRUPT_EXTERNAL_LEVEL	0x501
 #define BOOK3S_INTERRUPT_EXTERNAL_HV	0x502
 #define BOOK3S_INTERRUPT_ALIGNMENT	0x600
 #define BOOK3S_INTERRUPT_PROGRAM	0x700
@@ -134,8 +133,7 @@
 #define BOOK3S_IRQPRIO_EXTERNAL			14
 #define BOOK3S_IRQPRIO_DECREMENTER		15
 #define BOOK3S_IRQPRIO_PERFORMANCE_MONITOR	16
-#define BOOK3S_IRQPRIO_EXTERNAL_LEVEL		17
-#define BOOK3S_IRQPRIO_MAX			18
+#define BOOK3S_IRQPRIO_MAX			17
 
 #define BOOK3S_HFLAG_DCBZ32			0x1
 #define BOOK3S_HFLAG_SLB			0x2
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 906bcbdf..3cd0b9f 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -707,6 +707,7 @@ struct kvm_vcpu_arch {
 	u8 hcall_needed;
 	u8 epr_flags; /* KVMPPC_EPR_xxx */
 	u8 epr_needed;
+	u8 external_oneshot;	/* clear external irq after delivery */
 
 	u32 cpr0_cfgaddr; /* holds the last set cpr0_cfgaddr */
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 87348e4..66a5521 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -150,7 +150,6 @@ static int kvmppc_book3s_vec2irqprio(unsigned int vec)
 	case 0x400: prio = BOOK3S_IRQPRIO_INST_STORAGE;		break;
 	case 0x480: prio = BOOK3S_IRQPRIO_INST_SEGMENT;		break;
 	case 0x500: prio = BOOK3S_IRQPRIO_EXTERNAL;		break;
-	case 0x501: prio = BOOK3S_IRQPRIO_EXTERNAL_LEVEL;	break;
 	case 0x600: prio = BOOK3S_IRQPRIO_ALIGNMENT;		break;
 	case 0x700: prio = BOOK3S_IRQPRIO_PROGRAM;		break;
 	case 0x800: prio = BOOK3S_IRQPRIO_FP_UNAVAIL;		break;
@@ -236,18 +235,35 @@ EXPORT_SYMBOL_GPL(kvmppc_core_dequeue_dec);
 void kvmppc_core_queue_external(struct kvm_vcpu *vcpu,
                                 struct kvm_interrupt *irq)
 {
-	unsigned int vec = BOOK3S_INTERRUPT_EXTERNAL;
-
-	if (irq->irq == KVM_INTERRUPT_SET_LEVEL)
-		vec = BOOK3S_INTERRUPT_EXTERNAL_LEVEL;
+	/*
+	 * This case (KVM_INTERRUPT_SET) should never actually arise for
+	 * a pseries guest (because pseries guests expect their interrupt
+	 * controllers to continue asserting an external interrupt request
+	 * until it is acknowledged at the interrupt controller), but is
+	 * included to avoid ABI breakage and potentially for other
+	 * sorts of guest.
+	 *
+	 * There is a subtlety here: HV KVM does not test the
+	 * external_oneshot flag in the code that synthesizes
+	 * external interrupts for the guest just before entering
+	 * the guest.  That is OK even if userspace did do a
+	 * KVM_INTERRUPT_SET on a pseries guest vcpu, because the
+	 * caller (kvm_vcpu_ioctl_interrupt) does a kvm_vcpu_kick()
+	 * which ends up doing a smp_send_reschedule(), which will
+	 * pull the guest all the way out to the host, meaning that
+	 * we will call kvmppc_core_prepare_to_enter() before entering
+	 * the guest again, and that will handle the external_oneshot
+	 * flag correctly.
+	 */
+	if (irq->irq == KVM_INTERRUPT_SET)
+		vcpu->arch.external_oneshot = 1;
 
-	kvmppc_book3s_queue_irqprio(vcpu, vec);
+	kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_EXTERNAL);
 }
 
 void kvmppc_core_dequeue_external(struct kvm_vcpu *vcpu)
 {
 	kvmppc_book3s_dequeue_irqprio(vcpu, BOOK3S_INTERRUPT_EXTERNAL);
-	kvmppc_book3s_dequeue_irqprio(vcpu, BOOK3S_INTERRUPT_EXTERNAL_LEVEL);
 }
 
 void kvmppc_core_queue_data_storage(struct kvm_vcpu *vcpu, ulong dar,
@@ -278,7 +294,6 @@ static int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu,
 		vec = BOOK3S_INTERRUPT_DECREMENTER;
 		break;
 	case BOOK3S_IRQPRIO_EXTERNAL:
-	case BOOK3S_IRQPRIO_EXTERNAL_LEVEL:
 		deliver = (kvmppc_get_msr(vcpu) & MSR_EE) && !crit;
 		vec = BOOK3S_INTERRUPT_EXTERNAL;
 		break;
@@ -352,8 +367,16 @@ static bool clear_irqprio(struct kvm_vcpu *vcpu, unsigned int priority)
 		case BOOK3S_IRQPRIO_DECREMENTER:
 			/* DEC interrupts get cleared by mtdec */
 			return false;
-		case BOOK3S_IRQPRIO_EXTERNAL_LEVEL:
-			/* External interrupts get cleared by userspace */
+		case BOOK3S_IRQPRIO_EXTERNAL:
+			/*
+			 * External interrupts get cleared by userspace
+			 * except when set by the KVM_INTERRUPT ioctl with
+			 * KVM_INTERRUPT_SET (not KVM_INTERRUPT_SET_LEVEL).
+			 */
+			if (vcpu->arch.external_oneshot) {
+				vcpu->arch.external_oneshot = 0;
+				return true;
+			}
 			return false;
 	}
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 758d1d2..8b9f356 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -136,7 +136,7 @@ static void icp_rm_set_vcpu_irq(struct kvm_vcpu *vcpu,
 
 	/* Mark the target VCPU as having an interrupt pending */
 	vcpu->stat.queue_intr++;
-	set_bit(BOOK3S_IRQPRIO_EXTERNAL_LEVEL, &vcpu->arch.pending_exceptions);
+	set_bit(BOOK3S_IRQPRIO_EXTERNAL, &vcpu->arch.pending_exceptions);
 
 	/* Kick self ? Just set MER and return */
 	if (vcpu == this_vcpu) {
@@ -170,8 +170,7 @@ static void icp_rm_set_vcpu_irq(struct kvm_vcpu *vcpu,
 static void icp_rm_clr_vcpu_irq(struct kvm_vcpu *vcpu)
 {
 	/* Note: Only called on self ! */
-	clear_bit(BOOK3S_IRQPRIO_EXTERNAL_LEVEL,
-		  &vcpu->arch.pending_exceptions);
+	clear_bit(BOOK3S_IRQPRIO_EXTERNAL, &vcpu->arch.pending_exceptions);
 	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~LPCR_MER);
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 1d14046..77960e6 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1122,11 +1122,11 @@ kvmppc_cede_reentry:		/* r4 = vcpu, r13 = paca */
 
 	/* Check if we can deliver an external or decrementer interrupt now */
 	ld	r0, VCPU_PENDING_EXC(r4)
-	rldicl	r0, r0, 64 - BOOK3S_IRQPRIO_EXTERNAL_LEVEL, 63
+	rldicl	r0, r0, 64 - BOOK3S_IRQPRIO_EXTERNAL, 63
 	cmpdi	cr1, r0, 0
 	andi.	r8, r11, MSR_EE
 	mfspr	r8, SPRN_LPCR
-	/* Insert EXTERNAL_LEVEL bit into LPCR at the MER bit position */
+	/* Insert EXTERNAL bit into LPCR at the MER bit position */
 	rldimi	r8, r0, LPCR_MER_SH, 63 - LPCR_MER_SH
 	mtspr	SPRN_LPCR, r8
 	isync
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 614ebb4..059683e4 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1246,7 +1246,6 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 	case BOOK3S_INTERRUPT_EXTERNAL:
-	case BOOK3S_INTERRUPT_EXTERNAL_LEVEL:
 	case BOOK3S_INTERRUPT_EXTERNAL_HV:
 	case BOOK3S_INTERRUPT_H_VIRT:
 		vcpu->stat.ext_intr_exits++;
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index b8356cd..d9ba1b0 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -310,7 +310,7 @@ static inline bool icp_try_update(struct kvmppc_icp *icp,
 	 */
 	if (new.out_ee) {
 		kvmppc_book3s_queue_irqprio(icp->vcpu,
-					    BOOK3S_INTERRUPT_EXTERNAL_LEVEL);
+					    BOOK3S_INTERRUPT_EXTERNAL);
 		if (!change_self)
 			kvmppc_fast_vcpu_kick(icp->vcpu);
 	}
@@ -593,8 +593,7 @@ static noinline unsigned long kvmppc_h_xirr(struct kvm_vcpu *vcpu)
 	u32 xirr;
 
 	/* First, remove EE from the processor */
-	kvmppc_book3s_dequeue_irqprio(icp->vcpu,
-				      BOOK3S_INTERRUPT_EXTERNAL_LEVEL);
+	kvmppc_book3s_dequeue_irqprio(icp->vcpu, BOOK3S_INTERRUPT_EXTERNAL);
 
 	/*
 	 * ICP State: Accept_Interrupt
@@ -754,8 +753,7 @@ static noinline void kvmppc_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr)
 	 * We can remove EE from the current processor, the update
 	 * transaction will set it again if needed
 	 */
-	kvmppc_book3s_dequeue_irqprio(icp->vcpu,
-				      BOOK3S_INTERRUPT_EXTERNAL_LEVEL);
+	kvmppc_book3s_dequeue_irqprio(icp->vcpu, BOOK3S_INTERRUPT_EXTERNAL);
 
 	do {
 		old_state = new_state = READ_ONCE(icp->state);
@@ -1167,8 +1165,7 @@ int kvmppc_xics_set_icp(struct kvm_vcpu *vcpu, u64 icpval)
 	 * Deassert the CPU interrupt request.
 	 * icp_try_update will reassert it if necessary.
 	 */
-	kvmppc_book3s_dequeue_irqprio(icp->vcpu,
-				      BOOK3S_INTERRUPT_EXTERNAL_LEVEL);
+	kvmppc_book3s_dequeue_irqprio(icp->vcpu, BOOK3S_INTERRUPT_EXTERNAL);
 
 	/*
 	 * Note that if we displace an interrupt from old_state.xisr,
diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
index 4171ede..203ea65 100644
--- a/arch/powerpc/kvm/book3s_xive_template.c
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -285,7 +285,7 @@ X_STATIC unsigned long GLUE(X_PFX,h_xirr)(struct kvm_vcpu *vcpu)
 	 * set by pull or an escalation interrupts).
 	 */
 	if (test_bit(BOOK3S_IRQPRIO_EXTERNAL, &vcpu->arch.pending_exceptions))
-		clear_bit(BOOK3S_IRQPRIO_EXTERNAL_LEVEL,
+		clear_bit(BOOK3S_IRQPRIO_EXTERNAL,
 			  &vcpu->arch.pending_exceptions);
 
 	pr_devel(" new pending=0x%02x hw_cppr=%d cppr=%d\n",
diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
index f3b2375..372a82f 100644
--- a/arch/powerpc/kvm/trace_book3s.h
+++ b/arch/powerpc/kvm/trace_book3s.h
@@ -14,7 +14,6 @@
 	{0x400, "INST_STORAGE"}, \
 	{0x480, "INST_SEGMENT"}, \
 	{0x500, "EXTERNAL"}, \
-	{0x501, "EXTERNAL_LEVEL"}, \
 	{0x502, "EXTERNAL_HV"}, \
 	{0x600, "ALIGNMENT"}, \
 	{0x700, "PROGRAM"}, \
diff --git a/tools/perf/arch/powerpc/util/book3s_hv_exits.h b/tools/perf/arch/powerpc/util/book3s_hv_exits.h
index 853b95d1..2011376 100644
--- a/tools/perf/arch/powerpc/util/book3s_hv_exits.h
+++ b/tools/perf/arch/powerpc/util/book3s_hv_exits.h
@@ -15,7 +15,6 @@
 	{0x400, "INST_STORAGE"}, \
 	{0x480, "INST_SEGMENT"}, \
 	{0x500, "EXTERNAL"}, \
-	{0x501, "EXTERNAL_LEVEL"}, \
 	{0x502, "EXTERNAL_HV"}, \
 	{0x600, "ALIGNMENT"}, \
 	{0x700, "PROGRAM"}, \
-- 
2.7.4

