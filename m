Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 71DB9B6FDB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 03:57:12 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: <kvm-ppc@vger.kernel.org> <kvm-ppc@vger.kernel.org>
Subject: [PATCH 17/30] KVM: PPC: e500mc: implicitly set MSR_GS
Date: Fri, 17 Feb 2012 17:56:45 +0100
Message-Id: <1329497818-9729-18-git-send-email-agraf@suse.de>
In-Reply-To: <1329497818-9729-1-git-send-email-agraf@suse.de>
References: <1329497818-9729-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When setting MSR for an e500mc guest, we implicitly always set MSR_GS
to make sure the guest is in guest state. Since we have this implicit
rule there, we don't need to explicitly pass MSR_GS to set_msr().

Remove all explicit setters of MSR_GS.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ce1599d..ecfcf6d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -280,7 +280,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
                                         unsigned int priority)
 {
 	int allowed = 0;
-	ulong uninitialized_var(msr_mask);
+	ulong msr_mask = 0;
 	bool update_esr = false, update_dear = false;
 	ulong crit_raw = vcpu->arch.shared->critical;
 	ulong crit_r1 = kvmppc_get_gpr(vcpu, 1);
@@ -322,7 +322,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	case BOOKE_IRQPRIO_AP_UNAVAIL:
 	case BOOKE_IRQPRIO_ALIGNMENT:
 		allowed = 1;
-		msr_mask = MSR_GS | MSR_CE | MSR_ME | MSR_DE;
+		msr_mask = MSR_CE | MSR_ME | MSR_DE;
 		int_class = INT_CLASS_NONCRIT;
 		break;
 	case BOOKE_IRQPRIO_CRITICAL:
@@ -331,13 +331,12 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 #endif
 		allowed = vcpu->arch.shared->msr & MSR_CE;
 		allowed = allowed && !crit;
-		msr_mask = MSR_GS | MSR_ME;
+		msr_mask = MSR_ME;
 		int_class = INT_CLASS_CRIT;
 		break;
 	case BOOKE_IRQPRIO_MACHINE_CHECK:
 		allowed = vcpu->arch.shared->msr & MSR_ME;
 		allowed = allowed && !crit;
-		msr_mask = MSR_GS;
 		int_class = INT_CLASS_MC;
 		break;
 	case BOOKE_IRQPRIO_DECREMENTER:
@@ -350,13 +349,13 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 #endif
 		allowed = vcpu->arch.shared->msr & MSR_EE;
 		allowed = allowed && !crit;
-		msr_mask = MSR_GS | MSR_CE | MSR_ME | MSR_DE;
+		msr_mask = MSR_CE | MSR_ME | MSR_DE;
 		int_class = INT_CLASS_NONCRIT;
 		break;
 	case BOOKE_IRQPRIO_DEBUG:
 		allowed = vcpu->arch.shared->msr & MSR_DE;
 		allowed = allowed && !crit;
-		msr_mask = MSR_GS | MSR_ME;
+		msr_mask = MSR_ME;
 		int_class = INT_CLASS_CRIT;
 		break;
 	}
-- 
1.6.0.2
