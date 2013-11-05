Return-Path: <kernelfans@gmail.com>
Received: from mail-ob0-x229.google.com (mail-ob0-x229.google.com
 [IPv6:2607:f8b0:4003:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FE982C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 18:42:15 +1100 (EST)
Received: by mail-ob0-f169.google.com with SMTP id uz6so8290246obc.28
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Nov 2013 23:42:12 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 1/3] powerpc/kvm: simplify the entering logic for secondary
 thread
Date: Tue,  5 Nov 2013 15:42:42 +0800
Message-Id: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After the primary vcpu changes vcore_state to VCORE_RUNNING, there is
very little chance to schedule to secondary vcpu. So if we change the
code sequence around set vcore_state to VCORE_RUNNING and disable
preemption, we lost little. But we simplify the entering logi, based on
the fact that if primary vcpu runs, the secondary vcpu can not be scheduled.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 62a2b5a..38b1fc0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1222,8 +1222,8 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
 		kvmppc_create_dtl_entry(vcpu, vc);
 	}
 
-	vc->vcore_state = VCORE_RUNNING;
 	preempt_disable();
+	vc->vcore_state = VCORE_RUNNING;
 	spin_unlock(&vc->lock);
 
 	kvm_guest_enter();
@@ -1351,12 +1351,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	 * this thread straight away and have it join in.
 	 */
 	if (!signal_pending(current)) {
-		if (vc->vcore_state == VCORE_RUNNING &&
-		    VCORE_EXIT_COUNT(vc) == 0) {
-			vcpu->arch.ptid = vc->n_runnable - 1;
-			kvmppc_create_dtl_entry(vcpu, vc);
-			kvmppc_start_thread(vcpu);
-		} else if (vc->vcore_state == VCORE_SLEEPING) {
+		if (vc->vcore_state == VCORE_SLEEPING) {
 			wake_up(&vc->wq);
 		}
 
-- 
1.8.1.4
