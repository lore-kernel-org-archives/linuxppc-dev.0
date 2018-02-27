Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRMZ0791zF1X5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:13 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id i133so589108pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:13 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 13/30] KVM: PPC: Book3S PR: adds new
 kvmppc_copyto_vcpu_tm/kvmppc_copyfrom_vcpu_tm API for PR KVM.
Date: Wed, 28 Feb 2018 01:52:21 +0800
Message-Id: <1519753958-11756-3-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
References: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
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
---
 arch/powerpc/kvm/book3s_emulate.c | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 2eb457b..63af17f 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -87,6 +87,47 @@ static bool spr_allowed(struct kvm_vcpu *vcpu, enum priv_level level)
 	return true;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static inline void kvmppc_copyto_vcpu_tm(struct kvm_vcpu *vcpu)
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
+	vcpu->arch.xer_tm = vcpu->arch.xer;
+	vcpu->arch.vrsave_tm = vcpu->arch.vrsave;
+}
+
+static inline void kvmppc_copyfrom_vcpu_tm(struct kvm_vcpu *vcpu)
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
+	vcpu->arch.xer = vcpu->arch.xer_tm;
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
