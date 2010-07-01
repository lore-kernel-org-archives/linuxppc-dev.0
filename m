Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0BD72B7092
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:07 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 10/27] KVM: PPC: Tell guest about pending interrupts
Date: Thu,  1 Jul 2010 12:42:45 +0200
Message-Id: <1277980982-12433-11-git-send-email-agraf@suse.de>
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the guest turns on interrupts again, it needs to know if we have an
interrupt pending for it. Because if so, it should rather get out of guest
context and get the interrupt.

So we introduce a new field in the shared page that we use to tell the guest
that there's a pending interrupt lying around.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_para.h |    1 +
 arch/powerpc/kvm/book3s.c           |    7 +++++++
 arch/powerpc/kvm/booke.c            |    7 +++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index 1f7dccd..82131fc 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -36,6 +36,7 @@ struct kvm_vcpu_arch_shared {
 	__u64 dar;
 	__u64 msr;
 	__u32 dsisr;
+	__u32 int_pending;	/* Tells the guest if we have an interrupt */
 };
 
 #define KVM_PVR_PARA		0x4b564d3f /* "KVM?" */
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index ab43744..66313a2 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -337,6 +337,7 @@ int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 void kvmppc_core_deliver_interrupts(struct kvm_vcpu *vcpu)
 {
 	unsigned long *pending = &vcpu->arch.pending_exceptions;
+	unsigned long old_pending = vcpu->arch.pending_exceptions;
 	unsigned int priority;
 
 #ifdef EXIT_DEBUG
@@ -356,6 +357,12 @@ void kvmppc_core_deliver_interrupts(struct kvm_vcpu *vcpu)
 					 BITS_PER_BYTE * sizeof(*pending),
 					 priority + 1);
 	}
+
+	/* Tell the guest about our interrupt status */
+	if (*pending)
+		vcpu->arch.shared->int_pending = 1;
+	else if (old_pending)
+		vcpu->arch.shared->int_pending = 0;
 }
 
 void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index b9f8ecf..0f8ff9d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -224,6 +224,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 void kvmppc_core_deliver_interrupts(struct kvm_vcpu *vcpu)
 {
 	unsigned long *pending = &vcpu->arch.pending_exceptions;
+	unsigned long old_pending = vcpu->arch.pending_exceptions;
 	unsigned int priority;
 
 	priority = __ffs(*pending);
@@ -235,6 +236,12 @@ void kvmppc_core_deliver_interrupts(struct kvm_vcpu *vcpu)
 		                         BITS_PER_BYTE * sizeof(*pending),
 		                         priority + 1);
 	}
+
+	/* Tell the guest about our interrupt status */
+	if (*pending)
+		vcpu->arch.shared->int_pending = 1;
+	else if (old_pending)
+		vcpu->arch.shared->int_pending = 0;
 }
 
 /**
-- 
1.6.0.2
