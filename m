Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPkb0nqMzDrbj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:47:50 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id c11-v6so12518412plr.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:47:50 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 13/29] KVM: PPC: Book3S PR: adds new
 kvmppc_copyto_vcpu_tm/kvmppc_copyfrom_vcpu_tm API for PR KVM.
Date: Wed, 23 May 2018 15:01:56 +0800
Message-Id: <1527058932-7434-14-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
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
index 2eb457b..f81a921 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -87,6 +87,47 @@ static bool spr_allowed(struct kvm_vcpu *vcpu, enum priv_level level)
 	return true;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static inline void kvmppc_copyto_vcpu_tm(struct kvm_vcpu *vcpu)
+{
+	memcpy(&vcpu->arch.gpr_tm[0], &vcpu->arch.regs.gpr[0],
+			sizeof(vcpu->arch.gpr_tm));
+	memcpy(&vcpu->arch.fp_tm, &vcpu->arch.fp,
+			sizeof(struct thread_fp_state));
+	memcpy(&vcpu->arch.vr_tm, &vcpu->arch.vr,
+			sizeof(struct thread_vr_state));
+	vcpu->arch.ppr_tm = vcpu->arch.ppr;
+	vcpu->arch.dscr_tm = vcpu->arch.dscr;
+	vcpu->arch.amr_tm = vcpu->arch.amr;
+	vcpu->arch.ctr_tm = vcpu->arch.regs.ctr;
+	vcpu->arch.tar_tm = vcpu->arch.tar;
+	vcpu->arch.lr_tm = vcpu->arch.regs.link;
+	vcpu->arch.cr_tm = vcpu->arch.cr;
+	vcpu->arch.xer_tm = vcpu->arch.regs.xer;
+	vcpu->arch.vrsave_tm = vcpu->arch.vrsave;
+}
+
+static inline void kvmppc_copyfrom_vcpu_tm(struct kvm_vcpu *vcpu)
+{
+	memcpy(&vcpu->arch.regs.gpr[0], &vcpu->arch.gpr_tm[0],
+			sizeof(vcpu->arch.regs.gpr));
+	memcpy(&vcpu->arch.fp, &vcpu->arch.fp_tm,
+			sizeof(struct thread_fp_state));
+	memcpy(&vcpu->arch.vr, &vcpu->arch.vr_tm,
+			sizeof(struct thread_vr_state));
+	vcpu->arch.ppr = vcpu->arch.ppr_tm;
+	vcpu->arch.dscr = vcpu->arch.dscr_tm;
+	vcpu->arch.amr = vcpu->arch.amr_tm;
+	vcpu->arch.regs.ctr = vcpu->arch.ctr_tm;
+	vcpu->arch.tar = vcpu->arch.tar_tm;
+	vcpu->arch.regs.link = vcpu->arch.lr_tm;
+	vcpu->arch.cr = vcpu->arch.cr_tm;
+	vcpu->arch.regs.xer = vcpu->arch.xer_tm;
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
