Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C901A1A0BBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:37:12 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v4 3/6] KVM: PPC: Make ONE_REG powerpc generic
Date: Wed, 20 Aug 2014 16:36:24 +0300
Message-ID: <1408541787-24625-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
References: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make ONE_REG generic for server and embedded architectures by moving
kvm_vcpu_ioctl_get_one_reg() and kvm_vcpu_ioctl_set_one_reg() functions
to powerpc layer.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v4:
 - split ONE_REG powerpc generic and ONE_REG AltiVec

v3:
 - make ONE_REG AltiVec support powerpc generic

v2:
 - add comment describing VCSR register representation in KVM vs kernel

 arch/powerpc/kvm/book3s.c  | 121 +++++++++++++++++++--------------------------
 arch/powerpc/kvm/booke.c   |  91 +++++++++++++---------------------
 arch/powerpc/kvm/powerpc.c |  55 +++++++++++++++++++++
 3 files changed, 138 insertions(+), 129 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index dd03f6b..26868e2 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -535,33 +535,28 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	return -ENOTSUPP;
 }
 
-int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
+			union kvmppc_one_reg *val)
 {
-	int r;
-	union kvmppc_one_reg val;
-	int size;
+	int r = 0;
 	long int i;
 
-	size = one_reg_size(reg->id);
-	if (size > sizeof(val))
-		return -EINVAL;
-
-	r = vcpu->kvm->arch.kvm_ops->get_one_reg(vcpu, reg->id, &val);
+	r = vcpu->kvm->arch.kvm_ops->get_one_reg(vcpu, id, val);
 	if (r == -EINVAL) {
 		r = 0;
-		switch (reg->id) {
+		switch (id) {
 		case KVM_REG_PPC_DAR:
-			val = get_reg_val(reg->id, kvmppc_get_dar(vcpu));
+			*val = get_reg_val(id, kvmppc_get_dar(vcpu));
 			break;
 		case KVM_REG_PPC_DSISR:
-			val = get_reg_val(reg->id, kvmppc_get_dsisr(vcpu));
+			*val = get_reg_val(id, kvmppc_get_dsisr(vcpu));
 			break;
 		case KVM_REG_PPC_FPR0 ... KVM_REG_PPC_FPR31:
-			i = reg->id - KVM_REG_PPC_FPR0;
-			val = get_reg_val(reg->id, VCPU_FPR(vcpu, i));
+			i = id - KVM_REG_PPC_FPR0;
+			*val = get_reg_val(id, VCPU_FPR(vcpu, i));
 			break;
 		case KVM_REG_PPC_FPSCR:
-			val = get_reg_val(reg->id, vcpu->arch.fp.fpscr);
+			*val = get_reg_val(id, vcpu->arch.fp.fpscr);
 			break;
 #ifdef CONFIG_ALTIVEC
 		case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
@@ -569,110 +564,94 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 				r = -ENXIO;
 				break;
 			}
-			val.vval = vcpu->arch.vr.vr[reg->id - KVM_REG_PPC_VR0];
+			val->vval = vcpu->arch.vr.vr[id - KVM_REG_PPC_VR0];
 			break;
 		case KVM_REG_PPC_VSCR:
 			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
 				r = -ENXIO;
 				break;
 			}
-			val = get_reg_val(reg->id, vcpu->arch.vr.vscr.u[3]);
+			*val = get_reg_val(id, vcpu->arch.vr.vscr.u[3]);
 			break;
 		case KVM_REG_PPC_VRSAVE:
-			val = get_reg_val(reg->id, vcpu->arch.vrsave);
+			*val = get_reg_val(id, vcpu->arch.vrsave);
 			break;
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 		case KVM_REG_PPC_VSR0 ... KVM_REG_PPC_VSR31:
 			if (cpu_has_feature(CPU_FTR_VSX)) {
-				long int i = reg->id - KVM_REG_PPC_VSR0;
-				val.vsxval[0] = vcpu->arch.fp.fpr[i][0];
-				val.vsxval[1] = vcpu->arch.fp.fpr[i][1];
+				i = id - KVM_REG_PPC_VSR0;
+				val->vsxval[0] = vcpu->arch.fp.fpr[i][0];
+				val->vsxval[1] = vcpu->arch.fp.fpr[i][1];
 			} else {
 				r = -ENXIO;
 			}
 			break;
 #endif /* CONFIG_VSX */
-		case KVM_REG_PPC_DEBUG_INST: {
-			u32 opcode = INS_TW;
-			r = copy_to_user((u32 __user *)(long)reg->addr,
-					 &opcode, sizeof(u32));
+		case KVM_REG_PPC_DEBUG_INST:
+			*val = get_reg_val(id, INS_TW);
 			break;
-		}
 #ifdef CONFIG_KVM_XICS
 		case KVM_REG_PPC_ICP_STATE:
 			if (!vcpu->arch.icp) {
 				r = -ENXIO;
 				break;
 			}
-			val = get_reg_val(reg->id, kvmppc_xics_get_icp(vcpu));
+			*val = get_reg_val(id, kvmppc_xics_get_icp(vcpu));
 			break;
 #endif /* CONFIG_KVM_XICS */
 		case KVM_REG_PPC_FSCR:
-			val = get_reg_val(reg->id, vcpu->arch.fscr);
+			*val = get_reg_val(id, vcpu->arch.fscr);
 			break;
 		case KVM_REG_PPC_TAR:
-			val = get_reg_val(reg->id, vcpu->arch.tar);
+			*val = get_reg_val(id, vcpu->arch.tar);
 			break;
 		case KVM_REG_PPC_EBBHR:
-			val = get_reg_val(reg->id, vcpu->arch.ebbhr);
+			*val = get_reg_val(id, vcpu->arch.ebbhr);
 			break;
 		case KVM_REG_PPC_EBBRR:
-			val = get_reg_val(reg->id, vcpu->arch.ebbrr);
+			*val = get_reg_val(id, vcpu->arch.ebbrr);
 			break;
 		case KVM_REG_PPC_BESCR:
-			val = get_reg_val(reg->id, vcpu->arch.bescr);
+			*val = get_reg_val(id, vcpu->arch.bescr);
 			break;
 		case KVM_REG_PPC_VTB:
-			val = get_reg_val(reg->id, vcpu->arch.vtb);
+			*val = get_reg_val(id, vcpu->arch.vtb);
 			break;
 		case KVM_REG_PPC_IC:
-			val = get_reg_val(reg->id, vcpu->arch.ic);
+			*val = get_reg_val(id, vcpu->arch.ic);
 			break;
 		default:
 			r = -EINVAL;
 			break;
 		}
 	}
-	if (r)
-		return r;
-
-	if (copy_to_user((char __user *)(unsigned long)reg->addr, &val, size))
-		r = -EFAULT;
 
 	return r;
 }
 
-int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
+			union kvmppc_one_reg *val)
 {
-	int r;
-	union kvmppc_one_reg val;
-	int size;
+	int r = 0;
 	long int i;
 
-	size = one_reg_size(reg->id);
-	if (size > sizeof(val))
-		return -EINVAL;
-
-	if (copy_from_user(&val, (char __user *)(unsigned long)reg->addr, size))
-		return -EFAULT;
-
-	r = vcpu->kvm->arch.kvm_ops->set_one_reg(vcpu, reg->id, &val);
+	r = vcpu->kvm->arch.kvm_ops->set_one_reg(vcpu, id, val);
 	if (r == -EINVAL) {
 		r = 0;
-		switch (reg->id) {
+		switch (id) {
 		case KVM_REG_PPC_DAR:
-			kvmppc_set_dar(vcpu, set_reg_val(reg->id, val));
+			kvmppc_set_dar(vcpu, set_reg_val(id, *val));
 			break;
 		case KVM_REG_PPC_DSISR:
-			kvmppc_set_dsisr(vcpu, set_reg_val(reg->id, val));
+			kvmppc_set_dsisr(vcpu, set_reg_val(id, *val));
 			break;
 		case KVM_REG_PPC_FPR0 ... KVM_REG_PPC_FPR31:
-			i = reg->id - KVM_REG_PPC_FPR0;
-			VCPU_FPR(vcpu, i) = set_reg_val(reg->id, val);
+			i = id - KVM_REG_PPC_FPR0;
+			VCPU_FPR(vcpu, i) = set_reg_val(id, *val);
 			break;
 		case KVM_REG_PPC_FPSCR:
-			vcpu->arch.fp.fpscr = set_reg_val(reg->id, val);
+			vcpu->arch.fp.fpscr = set_reg_val(id, *val);
 			break;
 #ifdef CONFIG_ALTIVEC
 		case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
@@ -680,29 +659,29 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 				r = -ENXIO;
 				break;
 			}
-			vcpu->arch.vr.vr[reg->id - KVM_REG_PPC_VR0] = val.vval;
+			vcpu->arch.vr.vr[id - KVM_REG_PPC_VR0] = val->vval;
 			break;
 		case KVM_REG_PPC_VSCR:
 			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
 				r = -ENXIO;
 				break;
 			}
-			vcpu->arch.vr.vscr.u[3] = set_reg_val(reg->id, val);
+			vcpu->arch.vr.vscr.u[3] = set_reg_val(id, *val);
 			break;
 		case KVM_REG_PPC_VRSAVE:
 			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
 				r = -ENXIO;
 				break;
 			}
-			vcpu->arch.vrsave = set_reg_val(reg->id, val);
+			vcpu->arch.vrsave = set_reg_val(id, *val);
 			break;
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 		case KVM_REG_PPC_VSR0 ... KVM_REG_PPC_VSR31:
 			if (cpu_has_feature(CPU_FTR_VSX)) {
-				long int i = reg->id - KVM_REG_PPC_VSR0;
-				vcpu->arch.fp.fpr[i][0] = val.vsxval[0];
-				vcpu->arch.fp.fpr[i][1] = val.vsxval[1];
+				i = id - KVM_REG_PPC_VSR0;
+				vcpu->arch.fp.fpr[i][0] = val->vsxval[0];
+				vcpu->arch.fp.fpr[i][1] = val->vsxval[1];
 			} else {
 				r = -ENXIO;
 			}
@@ -715,29 +694,29 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 				break;
 			}
 			r = kvmppc_xics_set_icp(vcpu,
-						set_reg_val(reg->id, val));
+						set_reg_val(id, *val));
 			break;
 #endif /* CONFIG_KVM_XICS */
 		case KVM_REG_PPC_FSCR:
-			vcpu->arch.fscr = set_reg_val(reg->id, val);
+			vcpu->arch.fscr = set_reg_val(id, *val);
 			break;
 		case KVM_REG_PPC_TAR:
-			vcpu->arch.tar = set_reg_val(reg->id, val);
+			vcpu->arch.tar = set_reg_val(id, *val);
 			break;
 		case KVM_REG_PPC_EBBHR:
-			vcpu->arch.ebbhr = set_reg_val(reg->id, val);
+			vcpu->arch.ebbhr = set_reg_val(id, *val);
 			break;
 		case KVM_REG_PPC_EBBRR:
-			vcpu->arch.ebbrr = set_reg_val(reg->id, val);
+			vcpu->arch.ebbrr = set_reg_val(id, *val);
 			break;
 		case KVM_REG_PPC_BESCR:
-			vcpu->arch.bescr = set_reg_val(reg->id, val);
+			vcpu->arch.bescr = set_reg_val(id, *val);
 			break;
 		case KVM_REG_PPC_VTB:
-			vcpu->arch.vtb = set_reg_val(reg->id, val);
+			vcpu->arch.vtb = set_reg_val(id, *val);
 			break;
 		case KVM_REG_PPC_IC:
-			vcpu->arch.ic = set_reg_val(reg->id, val);
+			vcpu->arch.ic = set_reg_val(id, *val);
 			break;
 		default:
 			r = -EINVAL;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 8ace612..831c1b4 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1564,150 +1564,125 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
 }
 
-int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
+			union kvmppc_one_reg *val)
 {
 	int r = 0;
-	union kvmppc_one_reg val;
-	int size;
 
-	size = one_reg_size(reg->id);
-	if (size > sizeof(val))
-		return -EINVAL;
-
-	switch (reg->id) {
+	switch (id) {
 	case KVM_REG_PPC_IAC1:
-		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac1);
+		*val = get_reg_val(id, vcpu->arch.dbg_reg.iac1);
 		break;
 	case KVM_REG_PPC_IAC2:
-		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac2);
+		*val = get_reg_val(id, vcpu->arch.dbg_reg.iac2);
 		break;
 #if CONFIG_PPC_ADV_DEBUG_IACS > 2
 	case KVM_REG_PPC_IAC3:
-		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac3);
+		*val = get_reg_val(id, vcpu->arch.dbg_reg.iac3);
 		break;
 	case KVM_REG_PPC_IAC4:
-		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac4);
+		*val = get_reg_val(id, vcpu->arch.dbg_reg.iac4);
 		break;
 #endif
 	case KVM_REG_PPC_DAC1:
-		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.dac1);
+		*val = get_reg_val(id, vcpu->arch.dbg_reg.dac1);
 		break;
 	case KVM_REG_PPC_DAC2:
-		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.dac2);
-		break;
-	case KVM_REG_PPC_DBSR:
-		val = get_reg_val(reg->id, vcpu->arch.dbsr);
+		*val = get_reg_val(id, vcpu->arch.dbg_reg.dac2);
 		break;
 	case KVM_REG_PPC_EPR: {
 		u32 epr = kvmppc_get_epr(vcpu);
-		val = get_reg_val(reg->id, epr);
+		*val = get_reg_val(id, epr);
 		break;
 	}
 #if defined(CONFIG_64BIT)
 	case KVM_REG_PPC_EPCR:
-		val = get_reg_val(reg->id, vcpu->arch.epcr);
+		*val = get_reg_val(id, vcpu->arch.epcr);
 		break;
 #endif
 	case KVM_REG_PPC_TCR:
-		val = get_reg_val(reg->id, vcpu->arch.tcr);
+		*val = get_reg_val(id, vcpu->arch.tcr);
 		break;
 	case KVM_REG_PPC_TSR:
-		val = get_reg_val(reg->id, vcpu->arch.tsr);
+		*val = get_reg_val(id, vcpu->arch.tsr);
 		break;
 	case KVM_REG_PPC_DEBUG_INST:
-		val = get_reg_val(reg->id, KVMPPC_INST_EHPRIV_DEBUG);
+		*val = get_reg_val(id, KVMPPC_INST_EHPRIV_DEBUG);
 		break;
 	case KVM_REG_PPC_VRSAVE:
-		val = get_reg_val(reg->id, vcpu->arch.vrsave);
+		*val = get_reg_val(id, vcpu->arch.vrsave);
 		break;
 	default:
-		r = vcpu->kvm->arch.kvm_ops->get_one_reg(vcpu, reg->id, &val);
+		r = vcpu->kvm->arch.kvm_ops->get_one_reg(vcpu, id, val);
 		break;
 	}
 
-	if (r)
-		return r;
-
-	if (copy_to_user((char __user *)(unsigned long)reg->addr, &val, size))
-		r = -EFAULT;
-
 	return r;
 }
 
-int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
+			union kvmppc_one_reg *val)
 {
 	int r = 0;
-	union kvmppc_one_reg val;
-	int size;
 
-	size = one_reg_size(reg->id);
-	if (size > sizeof(val))
-		return -EINVAL;
-
-	if (copy_from_user(&val, (char __user *)(unsigned long)reg->addr, size))
-		return -EFAULT;
-
-	switch (reg->id) {
+	switch (id) {
 	case KVM_REG_PPC_IAC1:
-		vcpu->arch.dbg_reg.iac1 = set_reg_val(reg->id, val);
+		vcpu->arch.dbg_reg.iac1 = set_reg_val(id, *val);
 		break;
 	case KVM_REG_PPC_IAC2:
-		vcpu->arch.dbg_reg.iac2 = set_reg_val(reg->id, val);
+		vcpu->arch.dbg_reg.iac2 = set_reg_val(id, *val);
 		break;
 #if CONFIG_PPC_ADV_DEBUG_IACS > 2
 	case KVM_REG_PPC_IAC3:
-		vcpu->arch.dbg_reg.iac3 = set_reg_val(reg->id, val);
+		vcpu->arch.dbg_reg.iac3 = set_reg_val(id, *val);
 		break;
 	case KVM_REG_PPC_IAC4:
-		vcpu->arch.dbg_reg.iac4 = set_reg_val(reg->id, val);
+		vcpu->arch.dbg_reg.iac4 = set_reg_val(id, *val);
 		break;
 #endif
 	case KVM_REG_PPC_DAC1:
-		vcpu->arch.dbg_reg.dac1 = set_reg_val(reg->id, val);
+		vcpu->arch.dbg_reg.dac1 = set_reg_val(id, *val);
 		break;
 	case KVM_REG_PPC_DAC2:
-		vcpu->arch.dbg_reg.dac2 = set_reg_val(reg->id, val);
-		break;
-	case KVM_REG_PPC_DBSR:
-		vcpu->arch.dbsr = set_reg_val(reg->id, val);
+		vcpu->arch.dbg_reg.dac2 = set_reg_val(id, *val);
 		break;
 	case KVM_REG_PPC_EPR: {
-		u32 new_epr = set_reg_val(reg->id, val);
+		u32 new_epr = set_reg_val(id, *val);
 		kvmppc_set_epr(vcpu, new_epr);
 		break;
 	}
 #if defined(CONFIG_64BIT)
 	case KVM_REG_PPC_EPCR: {
-		u32 new_epcr = set_reg_val(reg->id, val);
+		u32 new_epcr = set_reg_val(id, *val);
 		kvmppc_set_epcr(vcpu, new_epcr);
 		break;
 	}
 #endif
 	case KVM_REG_PPC_OR_TSR: {
-		u32 tsr_bits = set_reg_val(reg->id, val);
+		u32 tsr_bits = set_reg_val(id, *val);
 		kvmppc_set_tsr_bits(vcpu, tsr_bits);
 		break;
 	}
 	case KVM_REG_PPC_CLEAR_TSR: {
-		u32 tsr_bits = set_reg_val(reg->id, val);
+		u32 tsr_bits = set_reg_val(id, *val);
 		kvmppc_clr_tsr_bits(vcpu, tsr_bits);
 		break;
 	}
 	case KVM_REG_PPC_TSR: {
-		u32 tsr = set_reg_val(reg->id, val);
+		u32 tsr = set_reg_val(id, *val);
 		kvmppc_set_tsr(vcpu, tsr);
 		break;
 	}
 	case KVM_REG_PPC_TCR: {
-		u32 tcr = set_reg_val(reg->id, val);
+		u32 tcr = set_reg_val(id, *val);
 		kvmppc_set_tcr(vcpu, tcr);
 		break;
 	}
 	case KVM_REG_PPC_VRSAVE:
-		vcpu->arch.vrsave = set_reg_val(reg->id, val);
+		vcpu->arch.vrsave = set_reg_val(id, *val);
 		break;
 	default:
-		r = vcpu->kvm->arch.kvm_ops->set_one_reg(vcpu, reg->id, &val);
+		r = vcpu->kvm->arch.kvm_ops->set_one_reg(vcpu, id, val);
 		break;
 	}
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 4c79284..1326116 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -927,6 +927,61 @@ int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 }
 EXPORT_SYMBOL_GPL(kvmppc_handle_store);
 
+int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+{
+	int r = 0;
+	union kvmppc_one_reg val;
+	int size;
+
+	size = one_reg_size(reg->id);
+	if (size > sizeof(val))
+		return -EINVAL;
+
+	r = kvmppc_get_one_reg(vcpu, reg->id, &val);
+	if (r == -EINVAL) {
+		r = 0;
+		switch (reg->id) {
+		default:
+			r = -EINVAL;
+			break;
+		}
+	}
+
+	if (r)
+		return r;
+
+	if (copy_to_user((char __user *)(unsigned long)reg->addr, &val, size))
+		r = -EFAULT;
+
+	return r;
+}
+
+int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
+{
+	int r;
+	union kvmppc_one_reg val;
+	int size;
+
+	size = one_reg_size(reg->id);
+	if (size > sizeof(val))
+		return -EINVAL;
+
+	if (copy_from_user(&val, (char __user *)(unsigned long)reg->addr, size))
+		return -EFAULT;
+
+	r = kvmppc_set_one_reg(vcpu, reg->id, &val);
+	if (r == -EINVAL) {
+		r = 0;
+		switch (reg->id) {
+		default:
+			r = -EINVAL;
+			break;
+		}
+	}
+
+	return r;
+}
+
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	int r;
-- 
1.7.11.7
