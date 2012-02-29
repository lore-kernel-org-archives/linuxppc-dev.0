Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 01179B6FCB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 11:10:21 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 31/38] KVM: PPC: booke: Readd debug abort code for machine
 check
Date: Wed, 29 Feb 2012 01:09:59 +0100
Message-Id: <1330474206-14794-32-git-send-email-agraf@suse.de>
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

When during guest execution we get a machine check interrupt, we don't
know how to handle it yet. So let's add the error printing code back
again that we dropped accidently earlier and tell user space that something
went really wrong.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 11b0625..af02d9d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -634,7 +634,12 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	switch (exit_nr) {
 	case BOOKE_INTERRUPT_MACHINE_CHECK:
-		r = RESUME_GUEST;
+		printk("MACHINE CHECK: %lx\n", mfspr(SPRN_MCSR));
+		kvmppc_dump_vcpu(vcpu);
+		/* For debugging, send invalid exit reason to user space */
+		run->hw.hardware_exit_reason = ~1ULL << 32;
+		run->hw.hardware_exit_reason |= mfspr(SPRN_MCSR);
+		r = RESUME_HOST;
 		break;
 
 	case BOOKE_INTERRUPT_EXTERNAL:
-- 
1.6.0.2
