Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 0502FB715B
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 28/35] KVM: PPC: Implement Level interrupts on Book3S
Date: Tue, 31 Aug 2010 04:32:09 +0200
Message-Id: <1283221937-21006-29-git-send-email-agraf@suse.de>
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

The current interrupt logic is just completely broken. We get a notification
from user space, telling us that an interrupt is there. But then user space
expects us that we just acknowledge an interrupt once we deliver it to the
guest.

This is not how real hardware works though. On real hardware, the interrupt
controller pulls the external interrupt line until it gets notified that the
interrupt was received.

So in reality we have two events: pulling and letting go of the interrupt line.

To maintain backwards compatibility, I added a new request for the pulling
part. The letting go part was implemented earlier already.

With this in place, we can now finally start guests that do not randomly stall
and stop to work at random times.

This patch implements above logic for Book3S.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm.h     |    1 +
 arch/powerpc/include/asm/kvm_asm.h |    4 +++-
 arch/powerpc/kvm/book3s.c          |   30 +++++++++++++++++++++++++++---
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index 6c5547d..18ea696 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -86,5 +86,6 @@ struct kvm_guest_debug_arch {
 
 #define KVM_INTERRUPT_SET	-1U
 #define KVM_INTERRUPT_UNSET	-2U
+#define KVM_INTERRUPT_SET_LEVEL	-3U
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index c5ea4cd..5b75046 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -58,6 +58,7 @@
 #define BOOK3S_INTERRUPT_INST_STORAGE	0x400
 #define BOOK3S_INTERRUPT_INST_SEGMENT	0x480
 #define BOOK3S_INTERRUPT_EXTERNAL	0x500
+#define BOOK3S_INTERRUPT_EXTERNAL_LEVEL	0x501
 #define BOOK3S_INTERRUPT_ALIGNMENT	0x600
 #define BOOK3S_INTERRUPT_PROGRAM	0x700
 #define BOOK3S_INTERRUPT_FP_UNAVAIL	0x800
@@ -84,7 +85,8 @@
 #define BOOK3S_IRQPRIO_EXTERNAL			13
 #define BOOK3S_IRQPRIO_DECREMENTER		14
 #define BOOK3S_IRQPRIO_PERFORMANCE_MONITOR	15
-#define BOOK3S_IRQPRIO_MAX			16
+#define BOOK3S_IRQPRIO_EXTERNAL_LEVEL		16
+#define BOOK3S_IRQPRIO_MAX			17
 
 #define BOOK3S_HFLAG_DCBZ32			0x1
 #define BOOK3S_HFLAG_SLB			0x2
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 5833df7..e316847 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -186,6 +186,7 @@ static int kvmppc_book3s_vec2irqprio(unsigned int vec)
 	case 0x400: prio = BOOK3S_IRQPRIO_INST_STORAGE;		break;
 	case 0x480: prio = BOOK3S_IRQPRIO_INST_SEGMENT;		break;
 	case 0x500: prio = BOOK3S_IRQPRIO_EXTERNAL;		break;
+	case 0x501: prio = BOOK3S_IRQPRIO_EXTERNAL_LEVEL;	break;
 	case 0x600: prio = BOOK3S_IRQPRIO_ALIGNMENT;		break;
 	case 0x700: prio = BOOK3S_IRQPRIO_PROGRAM;		break;
 	case 0x800: prio = BOOK3S_IRQPRIO_FP_UNAVAIL;		break;
@@ -246,13 +247,19 @@ void kvmppc_core_dequeue_dec(struct kvm_vcpu *vcpu)
 void kvmppc_core_queue_external(struct kvm_vcpu *vcpu,
                                 struct kvm_interrupt *irq)
 {
-	kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_EXTERNAL);
+	unsigned int vec = BOOK3S_INTERRUPT_EXTERNAL;
+
+	if (irq->irq == KVM_INTERRUPT_SET_LEVEL)
+		vec = BOOK3S_INTERRUPT_EXTERNAL_LEVEL;
+
+	kvmppc_book3s_queue_irqprio(vcpu, vec);
 }
 
 void kvmppc_core_dequeue_external(struct kvm_vcpu *vcpu,
                                   struct kvm_interrupt *irq)
 {
 	kvmppc_book3s_dequeue_irqprio(vcpu, BOOK3S_INTERRUPT_EXTERNAL);
+	kvmppc_book3s_dequeue_irqprio(vcpu, BOOK3S_INTERRUPT_EXTERNAL_LEVEL);
 }
 
 int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
@@ -281,6 +288,7 @@ int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 		vec = BOOK3S_INTERRUPT_DECREMENTER;
 		break;
 	case BOOK3S_IRQPRIO_EXTERNAL:
+	case BOOK3S_IRQPRIO_EXTERNAL_LEVEL:
 		deliver = (vcpu->arch.shared->msr & MSR_EE) && !crit;
 		vec = BOOK3S_INTERRUPT_EXTERNAL;
 		break;
@@ -343,6 +351,23 @@ int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 	return deliver;
 }
 
+/*
+ * This function determines if an irqprio should be cleared once issued.
+ */
+static bool clear_irqprio(struct kvm_vcpu *vcpu, unsigned int priority)
+{
+	switch (priority) {
+		case BOOK3S_IRQPRIO_DECREMENTER:
+			/* DEC interrupts get cleared by mtdec */
+			return false;
+		case BOOK3S_IRQPRIO_EXTERNAL_LEVEL:
+			/* External interrupts get cleared by userspace */
+			return false;
+	}
+
+	return true;
+}
+
 void kvmppc_core_deliver_interrupts(struct kvm_vcpu *vcpu)
 {
 	unsigned long *pending = &vcpu->arch.pending_exceptions;
@@ -356,8 +381,7 @@ void kvmppc_core_deliver_interrupts(struct kvm_vcpu *vcpu)
 	priority = __ffs(*pending);
 	while (priority < BOOK3S_IRQPRIO_MAX) {
 		if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
-		    (priority != BOOK3S_IRQPRIO_DECREMENTER)) {
-			/* DEC interrupts get cleared by mtdec */
+		    clear_irqprio(vcpu, priority)) {
 			clear_bit(priority, &vcpu->arch.pending_exceptions);
 			break;
 		}
-- 
1.6.0.2
