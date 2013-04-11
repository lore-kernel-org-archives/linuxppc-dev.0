Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 84B322C0105
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 20:08:19 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 1/8 v3] KVM: PPC: Book3E: Refactor ONE_REG ioctl implementation
Date: Thu, 11 Apr 2013 13:03:07 +0300
Message-ID: <1365674594-17410-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
References: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
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

Refactor Book3E ONE_REG ioctl implementation to use kvmppc_get_one_reg/
kvmppc_set_one_reg delegation interface introduced by Book3S. This is
necessary for MMU SPRs which are platform specifics.

Get rid of useless case braces in the process.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v3:
 - Split ONE_REG ioctl refactoring in its own patch

 arch/powerpc/kvm/44x.c    |   12 +++++
 arch/powerpc/kvm/booke.c  |  102 ++++++++++++++++++++++++---------------------
 arch/powerpc/kvm/e500.c   |   12 +++++
 arch/powerpc/kvm/e500mc.c |   12 +++++
 4 files changed, 91 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index 3d7fd21..2f5c6b6 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -124,6 +124,18 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return kvmppc_set_sregs_ivor(vcpu, sregs);
 }
 
+int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
+			union kvmppc_one_reg *val)
+{
+	return -EINVAL;
+}
+
+int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
+		       union kvmppc_one_reg *val)
+{
+	return -EINVAL;
+}
+
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct kvmppc_vcpu_44x *vcpu_44x;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index a49a68a..08f6540 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1412,117 +1412,125 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
 int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 {
-	int r = -EINVAL;
+	int r = 0;
+	union kvmppc_one_reg val;
+	int size;
+	long int i;
+
+	size = one_reg_size(reg->id);
+	if (size > sizeof(val))
+		return -EINVAL;
 
 	switch (reg->id) {
 	case KVM_REG_PPC_IAC1:
 	case KVM_REG_PPC_IAC2:
 	case KVM_REG_PPC_IAC3:
-	case KVM_REG_PPC_IAC4: {
-		int iac = reg->id - KVM_REG_PPC_IAC1;
-		r = copy_to_user((u64 __user *)(long)reg->addr,
-				 &vcpu->arch.dbg_reg.iac[iac], sizeof(u64));
+	case KVM_REG_PPC_IAC4:
+		i = reg->id - KVM_REG_PPC_IAC1;
+		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac[i]);
 		break;
-	}
 	case KVM_REG_PPC_DAC1:
-	case KVM_REG_PPC_DAC2: {
-		int dac = reg->id - KVM_REG_PPC_DAC1;
-		r = copy_to_user((u64 __user *)(long)reg->addr,
-				 &vcpu->arch.dbg_reg.dac[dac], sizeof(u64));
+	case KVM_REG_PPC_DAC2:
+		i = reg->id - KVM_REG_PPC_DAC1;
+		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.dac[i]);
 		break;
-	}
 	case KVM_REG_PPC_EPR: {
 		u32 epr = get_guest_epr(vcpu);
-		r = put_user(epr, (u32 __user *)(long)reg->addr);
+		val = get_reg_val(reg->id, epr);
 		break;
 	}
 #if defined(CONFIG_64BIT)
 	case KVM_REG_PPC_EPCR:
-		r = put_user(vcpu->arch.epcr, (u32 __user *)(long)reg->addr);
+		val = get_reg_val(reg->id, vcpu->arch.epcr);
 		break;
 #endif
 	case KVM_REG_PPC_TCR:
-		r = put_user(vcpu->arch.tcr, (u32 __user *)(long)reg->addr);
+		val = get_reg_val(reg->id, vcpu->arch.tcr);
 		break;
 	case KVM_REG_PPC_TSR:
-		r = put_user(vcpu->arch.tsr, (u32 __user *)(long)reg->addr);
+		val = get_reg_val(reg->id, vcpu->arch.tsr);
 		break;
-	case KVM_REG_PPC_DEBUG_INST: {
-		u32 opcode = KVMPPC_INST_EHPRIV;
-		r = copy_to_user((u32 __user *)(long)reg->addr,
-				 &opcode, sizeof(u32));
+	case KVM_REG_PPC_DEBUG_INST:
+		val = get_reg_val(reg->id, KVMPPC_INST_EHPRIV);
 		break;
-	}
 	default:
+		r = kvmppc_get_one_reg(vcpu, reg->id, &val);
 		break;
 	}
+
+	if (r)
+		return r;
+
+	if (copy_to_user((char __user *)(unsigned long)reg->addr, &val, size))
+		r = -EFAULT;
+
 	return r;
 }
 
 int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 {
-	int r = -EINVAL;
+	int r = 0;
+	union kvmppc_one_reg val;
+	int size;
+	long int i;
+
+	size = one_reg_size(reg->id);
+	if (size > sizeof(val))
+		return -EINVAL;
+
+	if (copy_from_user(&val, (char __user *)(unsigned long)reg->addr, size))
+		return -EFAULT;
 
 	switch (reg->id) {
 	case KVM_REG_PPC_IAC1:
 	case KVM_REG_PPC_IAC2:
 	case KVM_REG_PPC_IAC3:
-	case KVM_REG_PPC_IAC4: {
-		int iac = reg->id - KVM_REG_PPC_IAC1;
-		r = copy_from_user(&vcpu->arch.dbg_reg.iac[iac],
-			     (u64 __user *)(long)reg->addr, sizeof(u64));
+	case KVM_REG_PPC_IAC4:
+		i = reg->id - KVM_REG_PPC_IAC1;
+		vcpu->arch.dbg_reg.iac[i] = set_reg_val(reg->id, val);
 		break;
-	}
 	case KVM_REG_PPC_DAC1:
-	case KVM_REG_PPC_DAC2: {
-		int dac = reg->id - KVM_REG_PPC_DAC1;
-		r = copy_from_user(&vcpu->arch.dbg_reg.dac[dac],
-			     (u64 __user *)(long)reg->addr, sizeof(u64));
+	case KVM_REG_PPC_DAC2:
+		i = reg->id - KVM_REG_PPC_DAC1;
+		vcpu->arch.dbg_reg.dac[i] = set_reg_val(reg->id, val);
 		break;
-	}
 	case KVM_REG_PPC_EPR: {
-		u32 new_epr;
-		r = get_user(new_epr, (u32 __user *)(long)reg->addr);
-		if (!r)
-			kvmppc_set_epr(vcpu, new_epr);
+		u32 new_epr = set_reg_val(reg->id, val);
+		kvmppc_set_epr(vcpu, new_epr);
 		break;
 	}
 #if defined(CONFIG_64BIT)
 	case KVM_REG_PPC_EPCR: {
-		u32 new_epcr;
-		r = get_user(new_epcr, (u32 __user *)(long)reg->addr);
-		if (r == 0)
-			kvmppc_set_epcr(vcpu, new_epcr);
+		u32 new_epcr = set_reg_val(reg->id, val);
+		kvmppc_set_epcr(vcpu, new_epcr);
 		break;
 	}
 #endif
 	case KVM_REG_PPC_OR_TSR: {
-		u32 tsr_bits;
-		r = get_user(tsr_bits, (u32 __user *)(long)reg->addr);
+		u32 tsr_bits = set_reg_val(reg->id, val);
 		kvmppc_set_tsr_bits(vcpu, tsr_bits);
 		break;
 	}
 	case KVM_REG_PPC_CLEAR_TSR: {
-		u32 tsr_bits;
-		r = get_user(tsr_bits, (u32 __user *)(long)reg->addr);
+		u32 tsr_bits = set_reg_val(reg->id, val);
 		kvmppc_clr_tsr_bits(vcpu, tsr_bits);
 		break;
 	}
 	case KVM_REG_PPC_TSR: {
-		u32 tsr;
-		r = get_user(tsr, (u32 __user *)(long)reg->addr);
+		u32 tsr = set_reg_val(reg->id, val);
 		kvmppc_set_tsr(vcpu, tsr);
 		break;
 	}
 	case KVM_REG_PPC_TCR: {
-		u32 tcr;
-		r = get_user(tcr, (u32 __user *)(long)reg->addr);
+		u32 tcr = set_reg_val(reg->id, val);
 		kvmppc_set_tcr(vcpu, tcr);
 		break;
 	}
 	default:
+		r = kvmppc_set_one_reg(vcpu, reg->id, &val);
 		break;
 	}
+
 	return r;
 }
 
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 6dd4de7..576010f 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -425,6 +425,18 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return kvmppc_set_sregs_ivor(vcpu, sregs);
 }
 
+int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
+			union kvmppc_one_reg *val)
+{
+	return -EINVAL;
+}
+
+int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
+		       union kvmppc_one_reg *val)
+{
+	return -EINVAL;
+}
+
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500;
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 1f89d26..b071bdc 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -255,6 +255,18 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return kvmppc_set_sregs_ivor(vcpu, sregs);
 }
 
+int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
+			union kvmppc_one_reg *val)
+{
+	return -EINVAL;
+}
+
+int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
+		       union kvmppc_one_reg *val)
+{
+	return -EINVAL;
+}
+
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500;
-- 
1.7.4.1
