Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71B38B7245
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 23/26] KVM: PPC: Don't put MSR_POW in MSR
Date: Tue, 17 Aug 2010 15:57:58 +0200
Message-Id: <1282053481-18787-24-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
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

On Book3S a mtmsr with the MSR_POW bit set indicates that the OS is in
idle and only needs to be waked up on the next interrupt.

Now, unfortunately we let that bit slip into the stored MSR value which
is not what the real CPU does, so that we ended up executing code like
this:

	r = mfmsr();
	/* r containts MSR_POW */
	mtmsr(r | MSR_EE);

This obviously breaks, as we're going into idle mode in code sections that
don't expect to be idling.

This patch masks MSR_POW out of the stored MSR value on wakeup, making
guests happy again.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 8138d31..35f9199 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -134,10 +134,14 @@ void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
 	vcpu->arch.shared->msr = msr;
 	kvmppc_recalc_shadow_msr(vcpu);
 
-	if (msr & (MSR_WE|MSR_POW)) {
+	if (msr & MSR_POW) {
 		if (!vcpu->arch.pending_exceptions) {
 			kvm_vcpu_block(vcpu);
 			vcpu->stat.halt_wakeup++;
+
+			/* Unset POW bit after we woke up */
+			msr &= ~MSR_POW;
+			vcpu->arch.shared->msr = msr;
 		}
 	}
 
-- 
1.6.0.2
