Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B0E4B7012
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 04:14:10 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 24/30] KVM: PPC: booke: call resched after every exit
Date: Fri, 17 Feb 2012 18:13:51 +0100
Message-Id: <1329498837-11717-25-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-1-git-send-email-agraf@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of checking whether we should reschedule only when we exited
due to an interrupt, let's always check before entering the guest back
again. This gets the target more in line with the other archs.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index bfb2092..de30b6d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -572,6 +572,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
                        unsigned int exit_nr)
 {
 	int r = RESUME_HOST;
+	int resched_needed = 1;
 
 	/* update before a new last_exit_type is rewritten */
 	kvmppc_update_timing_stats(vcpu);
@@ -602,25 +603,21 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	switch (exit_nr) {
 	case BOOKE_INTERRUPT_MACHINE_CHECK:
-		kvm_resched(vcpu);
 		r = RESUME_GUEST;
 		break;
 
 	case BOOKE_INTERRUPT_EXTERNAL:
 		kvmppc_account_exit(vcpu, EXT_INTR_EXITS);
-		kvm_resched(vcpu);
 		r = RESUME_GUEST;
 		break;
 
 	case BOOKE_INTERRUPT_DECREMENTER:
 		kvmppc_account_exit(vcpu, DEC_EXITS);
-		kvm_resched(vcpu);
 		r = RESUME_GUEST;
 		break;
 
 	case BOOKE_INTERRUPT_DOORBELL:
 		kvmppc_account_exit(vcpu, DBELL_EXITS);
-		kvm_resched(vcpu);
 		r = RESUME_GUEST;
 		break;
 
@@ -869,8 +866,16 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		BUG();
 	}
 
-	local_irq_disable();
+	/* make sure we reschedule if we need to */
+	while (resched_needed) {
+		local_irq_disable();
 
+		resched_needed = need_resched();
+		if (resched_needed) {
+			local_irq_enable();
+			cond_resched();
+		}
+	}
 	kvmppc_core_prepare_to_enter(vcpu);
 
 	if (!(r & RESUME_HOST)) {
-- 
1.6.0.2
