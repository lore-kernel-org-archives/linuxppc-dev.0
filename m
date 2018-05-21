Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5pS3nQ0zF0dS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:46:40 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id t12-v6so8040986plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 21:46:40 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 29/29] KVM: PPC: Book3S PR: enable
 kvmppc_get/set_one_reg_pr() for HTM registers
Date: Mon, 21 May 2018 12:09:46 +0800
Message-Id: <1526875786-10372-30-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
References: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

We need to migrate PR KVM during transaction and qemu will use
kvmppc_get_one_reg_pr()/kvmppc_set_one_reg_pr() APIs to get/set
transaction checkpoint state. This patch adds support for that.

So far PPC PR qemu doesn't fully function for migration but the
savevm/loadvm can be done against a RHEL72 guest. During savevm/
loadvm procedure, the kvm ioctls will be invoked as well.

Test has been performed to savevm/loadvm for a guest running
a HTM test program:
https://github.com/justdoitqd/publicFiles/blob/master/test-tm-mig.c

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/book3s_pr.c | 133 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 8efc87b..7e76c4a 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1537,6 +1537,73 @@ static int kvmppc_get_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
 		else
 			*val = get_reg_val(id, 0);
 		break;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	case KVM_REG_PPC_TFHAR:
+		*val = get_reg_val(id, vcpu->arch.tfhar);
+		break;
+	case KVM_REG_PPC_TFIAR:
+		*val = get_reg_val(id, vcpu->arch.tfiar);
+		break;
+	case KVM_REG_PPC_TEXASR:
+		*val = get_reg_val(id, vcpu->arch.texasr);
+		break;
+	case KVM_REG_PPC_TM_GPR0 ... KVM_REG_PPC_TM_GPR31:
+		*val = get_reg_val(id,
+				vcpu->arch.gpr_tm[id-KVM_REG_PPC_TM_GPR0]);
+		break;
+	case KVM_REG_PPC_TM_VSR0 ... KVM_REG_PPC_TM_VSR63:
+	{
+		int i, j;
+
+		i = id - KVM_REG_PPC_TM_VSR0;
+		if (i < 32)
+			for (j = 0; j < TS_FPRWIDTH; j++)
+				val->vsxval[j] = vcpu->arch.fp_tm.fpr[i][j];
+		else {
+			if (cpu_has_feature(CPU_FTR_ALTIVEC))
+				val->vval = vcpu->arch.vr_tm.vr[i-32];
+			else
+				r = -ENXIO;
+		}
+		break;
+	}
+	case KVM_REG_PPC_TM_CR:
+		*val = get_reg_val(id, vcpu->arch.cr_tm);
+		break;
+	case KVM_REG_PPC_TM_XER:
+		*val = get_reg_val(id, vcpu->arch.xer_tm);
+		break;
+	case KVM_REG_PPC_TM_LR:
+		*val = get_reg_val(id, vcpu->arch.lr_tm);
+		break;
+	case KVM_REG_PPC_TM_CTR:
+		*val = get_reg_val(id, vcpu->arch.ctr_tm);
+		break;
+	case KVM_REG_PPC_TM_FPSCR:
+		*val = get_reg_val(id, vcpu->arch.fp_tm.fpscr);
+		break;
+	case KVM_REG_PPC_TM_AMR:
+		*val = get_reg_val(id, vcpu->arch.amr_tm);
+		break;
+	case KVM_REG_PPC_TM_PPR:
+		*val = get_reg_val(id, vcpu->arch.ppr_tm);
+		break;
+	case KVM_REG_PPC_TM_VRSAVE:
+		*val = get_reg_val(id, vcpu->arch.vrsave_tm);
+		break;
+	case KVM_REG_PPC_TM_VSCR:
+		if (cpu_has_feature(CPU_FTR_ALTIVEC))
+			*val = get_reg_val(id, vcpu->arch.vr_tm.vscr.u[3]);
+		else
+			r = -ENXIO;
+		break;
+	case KVM_REG_PPC_TM_DSCR:
+		*val = get_reg_val(id, vcpu->arch.dscr_tm);
+		break;
+	case KVM_REG_PPC_TM_TAR:
+		*val = get_reg_val(id, vcpu->arch.tar_tm);
+		break;
+#endif
 	default:
 		r = -EINVAL;
 		break;
@@ -1570,6 +1637,72 @@ static int kvmppc_set_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_LPCR_64:
 		kvmppc_set_lpcr_pr(vcpu, set_reg_val(id, *val));
 		break;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	case KVM_REG_PPC_TFHAR:
+		vcpu->arch.tfhar = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TFIAR:
+		vcpu->arch.tfiar = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TEXASR:
+		vcpu->arch.texasr = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_GPR0 ... KVM_REG_PPC_TM_GPR31:
+		vcpu->arch.gpr_tm[id - KVM_REG_PPC_TM_GPR0] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_VSR0 ... KVM_REG_PPC_TM_VSR63:
+	{
+		int i, j;
+
+		i = id - KVM_REG_PPC_TM_VSR0;
+		if (i < 32)
+			for (j = 0; j < TS_FPRWIDTH; j++)
+				vcpu->arch.fp_tm.fpr[i][j] = val->vsxval[j];
+		else
+			if (cpu_has_feature(CPU_FTR_ALTIVEC))
+				vcpu->arch.vr_tm.vr[i-32] = val->vval;
+			else
+				r = -ENXIO;
+		break;
+	}
+	case KVM_REG_PPC_TM_CR:
+		vcpu->arch.cr_tm = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_XER:
+		vcpu->arch.xer_tm = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_LR:
+		vcpu->arch.lr_tm = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_CTR:
+		vcpu->arch.ctr_tm = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_FPSCR:
+		vcpu->arch.fp_tm.fpscr = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_AMR:
+		vcpu->arch.amr_tm = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_PPR:
+		vcpu->arch.ppr_tm = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_VRSAVE:
+		vcpu->arch.vrsave_tm = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_VSCR:
+		if (cpu_has_feature(CPU_FTR_ALTIVEC))
+			vcpu->arch.vr.vscr.u[3] = set_reg_val(id, *val);
+		else
+			r = -ENXIO;
+		break;
+	case KVM_REG_PPC_TM_DSCR:
+		vcpu->arch.dscr_tm = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_TM_TAR:
+		vcpu->arch.tar_tm = set_reg_val(id, *val);
+		break;
+#endif
 	default:
 		r = -EINVAL;
 		break;
-- 
1.8.3.1
