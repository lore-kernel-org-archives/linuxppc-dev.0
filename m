Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 65F5AB71D7
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:25 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 31/35] KVM: PPC: Implement level interrupts for BookE
Date: Tue, 31 Aug 2010 04:32:12 +0200
Message-Id: <1283221937-21006-32-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BookE also wants to support level based interrupts, so let's implement
all the necessary logic there. We need to trick a bit here because the
irqprios are 1:1 assigned to architecture defined values. But since there
is some space left there, we can just pick a random one and move it later
on - it's internal anyways.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |   17 +++++++++++++++--
 arch/powerpc/kvm/booke.h |    4 +++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 835f6d0..77575d0 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -131,13 +131,19 @@ void kvmppc_core_dequeue_dec(struct kvm_vcpu *vcpu)
 void kvmppc_core_queue_external(struct kvm_vcpu *vcpu,
                                 struct kvm_interrupt *irq)
 {
-	kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_EXTERNAL);
+	unsigned int prio = BOOKE_IRQPRIO_EXTERNAL;
+
+	if (irq->irq == KVM_INTERRUPT_SET_LEVEL)
+		prio = BOOKE_IRQPRIO_EXTERNAL_LEVEL;
+
+	kvmppc_booke_queue_irqprio(vcpu, prio);
 }
 
 void kvmppc_core_dequeue_external(struct kvm_vcpu *vcpu,
                                   struct kvm_interrupt *irq)
 {
 	clear_bit(BOOKE_IRQPRIO_EXTERNAL, &vcpu->arch.pending_exceptions);
+	clear_bit(BOOKE_IRQPRIO_EXTERNAL_LEVEL, &vcpu->arch.pending_exceptions);
 }
 
 /* Deliver the interrupt of the corresponding priority, if possible. */
@@ -150,6 +156,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	ulong crit_raw = vcpu->arch.shared->critical;
 	ulong crit_r1 = kvmppc_get_gpr(vcpu, 1);
 	bool crit;
+	bool keep_irq = false;
 
 	/* Truncate crit indicators in 32 bit mode */
 	if (!(vcpu->arch.shared->msr & MSR_SF)) {
@@ -162,6 +169,11 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	/* ... and we're in supervisor mode */
 	crit = crit && !(vcpu->arch.shared->msr & MSR_PR);
 
+	if (priority == BOOKE_IRQPRIO_EXTERNAL_LEVEL) {
+		priority = BOOKE_IRQPRIO_EXTERNAL;
+		keep_irq = true;
+	}
+
 	switch (priority) {
 	case BOOKE_IRQPRIO_DTLB_MISS:
 	case BOOKE_IRQPRIO_DATA_STORAGE:
@@ -214,7 +226,8 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 			vcpu->arch.shared->dar = vcpu->arch.queued_dear;
 		kvmppc_set_msr(vcpu, vcpu->arch.shared->msr & msr_mask);
 
-		clear_bit(priority, &vcpu->arch.pending_exceptions);
+		if (!keep_irq)
+			clear_bit(priority, &vcpu->arch.pending_exceptions);
 	}
 
 	return allowed;
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 88258ac..492bb70 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -46,7 +46,9 @@
 #define BOOKE_IRQPRIO_FIT 17
 #define BOOKE_IRQPRIO_DECREMENTER 18
 #define BOOKE_IRQPRIO_PERFORMANCE_MONITOR 19
-#define BOOKE_IRQPRIO_MAX 19
+/* Internal pseudo-irqprio for level triggered externals */
+#define BOOKE_IRQPRIO_EXTERNAL_LEVEL 20
+#define BOOKE_IRQPRIO_MAX 20
 
 extern unsigned long kvmppc_booke_handlers;
 
-- 
1.6.0.2
