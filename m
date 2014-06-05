Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E2BB1A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 22:08:44 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Jun 2014 22:08:33 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9CB752BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 22:08:29 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s55C8DSN33357828
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 22:08:14 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s55C8SDD010990
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 22:08:29 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 4/4] KVM: PPC: BOOK3S: PR: Emulate instruction counter
Date: Thu,  5 Jun 2014 17:38:05 +0530
Message-Id: <1401970085-14493-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Writing to IC is not allowed in the privileged mode.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h | 1 +
 arch/powerpc/kvm/book3s.c           | 6 ++++++
 arch/powerpc/kvm/book3s_emulate.c   | 3 +++
 arch/powerpc/kvm/book3s_hv.c        | 6 ------
 arch/powerpc/kvm/book3s_pr.c        | 4 ++++
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index bd3caeaeebe1..f9ae69682ce1 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -506,6 +506,7 @@ struct kvm_vcpu_arch {
 	/* Time base value when we entered the guest */
 	u64 entry_tb;
 	u64 entry_vtb;
+	u64 entry_ic;
 	u32 tcr;
 	ulong tsr; /* we need to perform set/clr_bits() which requires ulong */
 	u32 ivor[64];
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index ae43e4178ecd..52c4c43900cb 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -649,6 +649,9 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 		case KVM_REG_PPC_VTB:
 			val = get_reg_val(reg->id, vcpu->arch.vtb);
 			break;
+		case KVM_REG_PPC_IC:
+			val = get_reg_val(reg->id, vcpu->arch.ic);
+			break;
 		default:
 			r = -EINVAL;
 			break;
@@ -756,6 +759,9 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 		case KVM_REG_PPC_VTB:
 			vcpu->arch.vtb = set_reg_val(reg->id, val);
 			break;
+		case KVM_REG_PPC_IC:
+			vcpu->arch.ic = set_reg_val(reg->id, val);
+			break;
 		default:
 			r = -EINVAL;
 			break;
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 062b5da7786e..e6912c618160 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -598,6 +598,9 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
 	case SPRN_VTB:
 		*spr_val = vcpu->arch.vtb;
 		break;
+	case SPRN_IC:
+		*spr_val = vcpu->arch.ic;
+		break;
 	case SPRN_GQR0:
 	case SPRN_GQR1:
 	case SPRN_GQR2:
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index f6ac58336b3f..c38cf9f836c0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -894,9 +894,6 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_CIABR:
 		*val = get_reg_val(id, vcpu->arch.ciabr);
 		break;
-	case KVM_REG_PPC_IC:
-		*val = get_reg_val(id, vcpu->arch.ic);
-		break;
 	case KVM_REG_PPC_CSIGR:
 		*val = get_reg_val(id, vcpu->arch.csigr);
 		break;
@@ -1091,9 +1088,6 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 		if ((vcpu->arch.ciabr & CIABR_PRIV) == CIABR_PRIV_HYPER)
 			vcpu->arch.ciabr &= ~CIABR_PRIV;	/* disable */
 		break;
-	case KVM_REG_PPC_IC:
-		vcpu->arch.ic = set_reg_val(id, *val);
-		break;
 	case KVM_REG_PPC_CSIGR:
 		vcpu->arch.csigr = set_reg_val(id, *val);
 		break;
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 96cdf89a8c86..03fc8847cd67 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -126,6 +126,8 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 	 */
 	vcpu->arch.entry_tb = get_tb();
 	vcpu->arch.entry_vtb = get_vtb();
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		vcpu->arch.entry_ic = mfspr(SPRN_IC);
 	svcpu->in_use = true;
 }
 
@@ -178,6 +180,8 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
 	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;
 	vcpu->arch.vtb += get_vtb() - vcpu->arch.entry_vtb;
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		vcpu->arch.ic += mfspr(SPRN_IC) - vcpu->arch.entry_ic;
 	svcpu->in_use = false;
 
 out:
-- 
1.9.1
