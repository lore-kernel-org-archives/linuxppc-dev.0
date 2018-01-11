Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMBb0wBgzF0Xq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:12:38 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id p1so1309226pfh.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:12:38 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 13/26] KVM: PPC: Book3S PR: adds new
 kvmppc_copyto_vcpu_tm/kvmppc_copyfrom_vcpu_tm API for PR KVM.
Date: Thu, 11 Jan 2018 18:11:26 +0800
Message-Id: <1515665499-31710-14-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch adds 2 new APIs: kvmppc_copyto_vcpu_tm() and
kvmppc_copyfrom_vcpu_tm().  These 2 APIs will be used to copy from/to TM
data between VCPU_TM/VCPU area.

PR KVM will use these APIs for treclaim. or trchkpt. emulation.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_emulate.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 2eb457b..e096d01 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -87,6 +87,45 @@ static bool spr_allowed(struct kvm_vcpu *vcpu, enum priv_level level)
 	return true;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+void kvmppc_copyto_vcpu_tm(struct kvm_vcpu *vcpu)
+{
+	memcpy(&vcpu->arch.gpr_tm[0], &vcpu->arch.gpr[0],
+			sizeof(vcpu->arch.gpr_tm));
+	memcpy(&vcpu->arch.fp_tm, &vcpu->arch.fp,
+			sizeof(struct thread_fp_state));
+	memcpy(&vcpu->arch.vr_tm, &vcpu->arch.vr,
+			sizeof(struct thread_vr_state));
+	vcpu->arch.ppr_tm = vcpu->arch.ppr;
+	vcpu->arch.dscr_tm = vcpu->arch.dscr;
+	vcpu->arch.amr_tm = vcpu->arch.amr;
+	vcpu->arch.ctr_tm = vcpu->arch.ctr;
+	vcpu->arch.tar_tm = vcpu->arch.tar;
+	vcpu->arch.lr_tm = vcpu->arch.lr;
+	vcpu->arch.cr_tm = vcpu->arch.cr;
+	vcpu->arch.vrsave_tm = vcpu->arch.vrsave;
+}
+
+void kvmppc_copyfrom_vcpu_tm(struct kvm_vcpu *vcpu)
+{
+	memcpy(&vcpu->arch.gpr[0], &vcpu->arch.gpr_tm[0],
+			sizeof(vcpu->arch.gpr));
+	memcpy(&vcpu->arch.fp, &vcpu->arch.fp_tm,
+			sizeof(struct thread_fp_state));
+	memcpy(&vcpu->arch.vr, &vcpu->arch.vr_tm,
+			sizeof(struct thread_vr_state));
+	vcpu->arch.ppr = vcpu->arch.ppr_tm;
+	vcpu->arch.dscr = vcpu->arch.dscr_tm;
+	vcpu->arch.amr = vcpu->arch.amr_tm;
+	vcpu->arch.ctr = vcpu->arch.ctr_tm;
+	vcpu->arch.tar = vcpu->arch.tar_tm;
+	vcpu->arch.lr = vcpu->arch.lr_tm;
+	vcpu->arch.cr = vcpu->arch.cr_tm;
+	vcpu->arch.vrsave = vcpu->arch.vrsave_tm;
+}
+
+#endif
+
 int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			      unsigned int inst, int *advance)
 {
-- 
1.8.3.1
