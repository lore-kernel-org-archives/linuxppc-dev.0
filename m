Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E72CB70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 07:14:07 +1100 (EST)
From: Peter Tyser <ptyser@xes-inc.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Fix SPRG get/set for Book3S and BookE
Date: Wed, 29 Dec 2010 13:51:25 -0600
Message-Id: <1293652285-13313-1-git-send-email-ptyser@xes-inc.com>
Cc: Peter Tyser <ptyser@xes-inc.com>, linuxppc-dev@lists.ozlabs.org,
	agraf@suse.de, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously SPRGs 4-7 were improperly read and written in
kvm_arch_vcpu_ioctl_get_regs() and kvm_arch_vcpu_ioctl_set_regs();

Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
---
I noticed this while grepping for somthing unrelated and assume its
a typo.  Feel free to add to the patch description; I don't use KVM
so don't know what the high-level consequences of this change are.

 arch/powerpc/kvm/book3s.c |   14 ++++++++------
 arch/powerpc/kvm/booke.c  |   14 ++++++++------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index e316847..5eb86c9 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -1141,9 +1141,10 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->sprg1 = vcpu->arch.shared->sprg1;
 	regs->sprg2 = vcpu->arch.shared->sprg2;
 	regs->sprg3 = vcpu->arch.shared->sprg3;
-	regs->sprg5 = vcpu->arch.sprg4;
-	regs->sprg6 = vcpu->arch.sprg5;
-	regs->sprg7 = vcpu->arch.sprg6;
+	regs->sprg4 = vcpu->arch.sprg4;
+	regs->sprg5 = vcpu->arch.sprg5;
+	regs->sprg6 = vcpu->arch.sprg6;
+	regs->sprg7 = vcpu->arch.sprg7;
 
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
@@ -1167,9 +1168,10 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu->arch.shared->sprg1 = regs->sprg1;
 	vcpu->arch.shared->sprg2 = regs->sprg2;
 	vcpu->arch.shared->sprg3 = regs->sprg3;
-	vcpu->arch.sprg5 = regs->sprg4;
-	vcpu->arch.sprg6 = regs->sprg5;
-	vcpu->arch.sprg7 = regs->sprg6;
+	vcpu->arch.sprg4 = regs->sprg4;
+	vcpu->arch.sprg5 = regs->sprg5;
+	vcpu->arch.sprg6 = regs->sprg6;
+	vcpu->arch.sprg7 = regs->sprg7;
 
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 77575d0..ef76acb 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -546,9 +546,10 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->sprg1 = vcpu->arch.shared->sprg1;
 	regs->sprg2 = vcpu->arch.shared->sprg2;
 	regs->sprg3 = vcpu->arch.shared->sprg3;
-	regs->sprg5 = vcpu->arch.sprg4;
-	regs->sprg6 = vcpu->arch.sprg5;
-	regs->sprg7 = vcpu->arch.sprg6;
+	regs->sprg4 = vcpu->arch.sprg4;
+	regs->sprg5 = vcpu->arch.sprg5;
+	regs->sprg6 = vcpu->arch.sprg6;
+	regs->sprg7 = vcpu->arch.sprg7;
 
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
@@ -572,9 +573,10 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu->arch.shared->sprg1 = regs->sprg1;
 	vcpu->arch.shared->sprg2 = regs->sprg2;
 	vcpu->arch.shared->sprg3 = regs->sprg3;
-	vcpu->arch.sprg5 = regs->sprg4;
-	vcpu->arch.sprg6 = regs->sprg5;
-	vcpu->arch.sprg7 = regs->sprg6;
+	vcpu->arch.sprg4 = regs->sprg4;
+	vcpu->arch.sprg5 = regs->sprg5;
+	vcpu->arch.sprg6 = regs->sprg6;
+	vcpu->arch.sprg7 = regs->sprg7;
 
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
-- 
1.7.0.4
