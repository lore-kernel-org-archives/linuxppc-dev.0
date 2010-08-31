Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47E25B719B
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:25 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 24/35] KVM: PPC: initialize IVORs in addition to IVPR
Date: Tue, 31 Aug 2010 04:32:05 +0200
Message-Id: <1283221937-21006-25-git-send-email-agraf@suse.de>
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

From: Hollis Blanchard <hollis_blanchard@mentor.com>

Developers can now tell at a glace the exact type of the premature interrupt,
instead of just knowing that there was some premature interrupt.

Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index c604277..835f6d0 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -497,15 +497,19 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 /* Initial guest state: 16MB mapping 0 -> 0, PC = 0, MSR = 0, R1 = 16MB */
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
+	int i;
+
 	vcpu->arch.pc = 0;
 	vcpu->arch.shared->msr = 0;
 	kvmppc_set_gpr(vcpu, 1, (16<<20) - 8); /* -8 for the callee-save LR slot */
 
 	vcpu->arch.shadow_pid = 1;
 
-	/* Eye-catching number so we know if the guest takes an interrupt
-	 * before it's programmed its own IVPR. */
+	/* Eye-catching numbers so we know if the guest takes an interrupt
+	 * before it's programmed its own IVPR/IVORs. */
 	vcpu->arch.ivpr = 0x55550000;
+	for (i = 0; i < BOOKE_IRQPRIO_MAX; i++)
+		vcpu->arch.ivor[i] = 0x7700 | i * 4;
 
 	kvmppc_init_timing_stats(vcpu);
 
-- 
1.6.0.2
