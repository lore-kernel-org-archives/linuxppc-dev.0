Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41BCDB6FC5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 11:10:24 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 38/38] KVM: PPC: Booke: only prepare to enter when we enter
Date: Wed, 29 Feb 2012 01:10:06 +0100
Message-Id: <1330474206-14794-39-git-send-email-agraf@suse.de>
In-Reply-To: <1330474206-14794-1-git-send-email-agraf@suse.de>
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
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

So far, we've always called prepare_to_enter even when all we did was return
to the host. This patch changes that semantic to only call prepare_to_enter
when we actually want to get back into the guest.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 8e8aa4c..9f27258 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -464,7 +464,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
  *
  * returns !0 if a signal is pending and check_signal is true
  */
-static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu, bool check_signal)
+static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 {
 	int r = 0;
 
@@ -477,7 +477,7 @@ static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu, bool check_signal)
 			continue;
 		}
 
-		if (check_signal && signal_pending(current)) {
+		if (signal_pending(current)) {
 			r = 1;
 			break;
 		}
@@ -509,7 +509,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	}
 
 	local_irq_disable();
-	if (kvmppc_prepare_to_enter(vcpu, true)) {
+	if (kvmppc_prepare_to_enter(vcpu)) {
 		kvm_run->exit_reason = KVM_EXIT_INTR;
 		ret = -EINTR;
 		goto out;
@@ -946,11 +946,13 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 * To avoid clobbering exit_reason, only check for signals if we
 	 * aren't already exiting to userspace for some other reason.
 	 */
-	local_irq_disable();
-	if (kvmppc_prepare_to_enter(vcpu, !(r & RESUME_HOST))) {
-		run->exit_reason = KVM_EXIT_INTR;
-		r = (-EINTR << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
-		kvmppc_account_exit(vcpu, SIGNAL_EXITS);
+	if (!(r & RESUME_HOST)) {
+		local_irq_disable();
+		if (kvmppc_prepare_to_enter(vcpu)) {
+			run->exit_reason = KVM_EXIT_INTR;
+			r = (-EINTR << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
+			kvmppc_account_exit(vcpu, SIGNAL_EXITS);
+		}
 	}
 
 	return r;
-- 
1.6.0.2
