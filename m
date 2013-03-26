Return-Path: <B02008@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 582E52C0154
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 09:06:18 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 1/7 v2] KVM: PPC: e500: Expose MMU registers via ONE_REG
Date: Wed, 27 Mar 2013 00:05:06 +0200
Message-ID: <1364335512-28426-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1364335512-28426-1-git-send-email-mihai.caraman@freescale.com>
References: <1364335512-28426-1-git-send-email-mihai.caraman@freescale.com>
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

MMU registers were exposed to user-space using sregs interface. Add them
to ONE_REG interface and use kvmppc_get_one_reg/kvmppc_set_one_reg delegation
interface introduced by book3s.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v2:
 - Restrict set_one_reg operation for MMU registers to HW values

 Documentation/virtual/kvm/api.txt   |   11 +++++
 arch/powerpc/include/uapi/asm/kvm.h |   17 +++++++
 arch/powerpc/kvm/44x.c              |   12 +++++
 arch/powerpc/kvm/booke.c            |   83 ++++++++++++++++++++--------------
 arch/powerpc/kvm/e500.c             |   14 ++++++
 arch/powerpc/kvm/e500.h             |    4 ++
 arch/powerpc/kvm/e500_mmu.c         |   84 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/e500mc.c           |   14 ++++++
 8 files changed, 205 insertions(+), 34 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 976eb65..1a76663 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1792,6 +1792,17 @@ registers, find a list below:
   PPC   | KVM_REG_PPC_TSR	| 32
   PPC   | KVM_REG_PPC_OR_TSR	| 32
   PPC   | KVM_REG_PPC_CLEAR_TSR	| 32
+  PPC   | KVM_REG_PPC_MAS0	| 32
+  PPC   | KVM_REG_PPC_MAS1	| 32
+  PPC   | KVM_REG_PPC_MAS2	| 64
+  PPC   | KVM_REG_PPC_MAS7_3	| 64
+  PPC   | KVM_REG_PPC_MAS4	| 32
+  PPC   | KVM_REG_PPC_MAS6	| 32
+  PPC   | KVM_REG_PPC_MMUCFG	| 32
+  PPC   | KVM_REG_PPC_TLB0CFG	| 32
+  PPC   | KVM_REG_PPC_TLB1CFG	| 32
+  PPC   | KVM_REG_PPC_TLB2CFG	| 32
+  PPC   | KVM_REG_PPC_TLB3CFG	| 32
 
 ARM registers are mapped using the lower 32 bits.  The upper 16 of that
 is the register group type, or coprocessor number:
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index ef072b1..777dc81 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -422,4 +422,21 @@ struct kvm_get_htab_header {
 #define KVM_REG_PPC_CLEAR_TSR	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x88)
 #define KVM_REG_PPC_TCR		(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x89)
 #define KVM_REG_PPC_TSR		(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x8a)
+
+/* MMU registers */
+#define KVM_REG_PPC_MAS0	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x8b)
+#define KVM_REG_PPC_MAS1	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x8c)
+#define KVM_REG_PPC_MAS2	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8d)
+#define KVM_REG_PPC_MAS7_3	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8e)
+#define KVM_REG_PPC_MAS4	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x8f)
+#define KVM_REG_PPC_MAS6	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x90)
+#define KVM_REG_PPC_MMUCFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x91)
+/*
+ * TLBnCFG fields TLBnCFG_N_ENTRY and TLBnCFG_ASSOC can be changed only using
+ * KVM_CAP_SW_TLB ioctl
+ */
+#define KVM_REG_PPC_TLB0CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x92)
+#define KVM_REG_PPC_TLB1CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x93)
+#define KVM_REG_PPC_TLB2CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x94)
+#define KVM_REG_PPC_TLB3CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x95)
 #endif /* __LINUX_KVM_POWERPC_H */
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
index 58057d6..c67e99f 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1412,111 +1412,126 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
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
 	case KVM_REG_PPC_IAC4: {
-		int iac = reg->id - KVM_REG_PPC_IAC1;
-		r = copy_to_user((u64 __user *)(long)reg->addr,
-				 &vcpu->arch.dbg_reg.iac[iac], sizeof(u64));
+		i = reg->id - KVM_REG_PPC_IAC1;
+		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac[i]);
 		break;
 	}
 	case KVM_REG_PPC_DAC1:
 	case KVM_REG_PPC_DAC2: {
-		int dac = reg->id - KVM_REG_PPC_DAC1;
-		r = copy_to_user((u64 __user *)(long)reg->addr,
-				 &vcpu->arch.dbg_reg.dac[dac], sizeof(u64));
+		i = reg->id - KVM_REG_PPC_DAC1;
+		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.dac[i]);
 		break;
 	}
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
 	case KVM_REG_PPC_IAC4: {
-		int iac = reg->id - KVM_REG_PPC_IAC1;
-		r = copy_from_user(&vcpu->arch.dbg_reg.iac[iac],
-			     (u64 __user *)(long)reg->addr, sizeof(u64));
+		i = reg->id - KVM_REG_PPC_IAC1;
+		vcpu->arch.dbg_reg.iac[i] = set_reg_val(reg->id, val);
 		break;
 	}
 	case KVM_REG_PPC_DAC1:
 	case KVM_REG_PPC_DAC2: {
-		int dac = reg->id - KVM_REG_PPC_DAC1;
-		r = copy_from_user(&vcpu->arch.dbg_reg.dac[dac],
-			     (u64 __user *)(long)reg->addr, sizeof(u64));
+		i = reg->id - KVM_REG_PPC_DAC1;
+		vcpu->arch.dbg_reg.dac[i] = set_reg_val(reg->id, val);
 		break;
 	}
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
index 6dd4de7..ce6b73c 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -425,6 +425,20 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return kvmppc_set_sregs_ivor(vcpu, sregs);
 }
 
+int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
+			union kvmppc_one_reg *val)
+{
+	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
+	return r;
+}
+
+int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
+		       union kvmppc_one_reg *val)
+{
+	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
+	return r;
+}
+
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500;
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 33db48a..b73ca7a 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -131,6 +131,10 @@ void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *vcpu_e500);
 void kvmppc_get_sregs_e500_tlb(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 int kvmppc_set_sregs_e500_tlb(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 
+int kvmppc_get_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
+				union kvmppc_one_reg *val);
+int kvmppc_set_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
+			       union kvmppc_one_reg *val);
 
 #ifdef CONFIG_KVM_E500V2
 unsigned int kvmppc_e500_get_sid(struct kvmppc_vcpu_e500 *vcpu_e500,
diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 5c44759..68c2b00 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -596,6 +596,90 @@ int kvmppc_set_sregs_e500_tlb(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return 0;
 }
 
+int kvmppc_get_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
+				union kvmppc_one_reg *val)
+{
+	int r = 0;
+	long int i;
+
+	switch (id) {
+	case KVM_REG_PPC_MAS0:
+		*val = get_reg_val(id, vcpu->arch.shared->mas0);
+	case KVM_REG_PPC_MAS1:
+		*val = get_reg_val(id, vcpu->arch.shared->mas1);
+	case KVM_REG_PPC_MAS2:
+		*val = get_reg_val(id, vcpu->arch.shared->mas2);
+	case KVM_REG_PPC_MAS7_3:
+		*val = get_reg_val(id, vcpu->arch.shared->mas7_3);
+	case KVM_REG_PPC_MAS4:
+		*val = get_reg_val(id, vcpu->arch.shared->mas4);
+	case KVM_REG_PPC_MAS6:
+		*val = get_reg_val(id, vcpu->arch.shared->mas6);
+	case KVM_REG_PPC_MMUCFG:
+		*val = get_reg_val(id, vcpu->arch.mmucfg);
+	case KVM_REG_PPC_TLB0CFG:
+	case KVM_REG_PPC_TLB1CFG:
+	case KVM_REG_PPC_TLB2CFG:
+	case KVM_REG_PPC_TLB3CFG:
+		i = id - KVM_REG_PPC_TLB0CFG;
+		*val = get_reg_val(id, vcpu->arch.tlbcfg[i]);
+	default:
+		r = -EINVAL;
+		break;
+	}
+
+	return r;
+}
+
+int kvmppc_set_one_reg_e500_tlb(struct kvm_vcpu *vcpu, u64 id,
+			       union kvmppc_one_reg *val)
+{
+	int r = 0;
+	long int i;
+
+	switch (id) {
+	case KVM_REG_PPC_MAS0:
+		vcpu->arch.shared->mas0 = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_MAS1:
+		vcpu->arch.shared->mas1 = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_MAS2:
+		vcpu->arch.shared->mas2 = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_MAS7_3:
+		vcpu->arch.shared->mas7_3 = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_MAS4:
+		vcpu->arch.shared->mas4 = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_MAS6:
+		vcpu->arch.shared->mas6 = set_reg_val(id, *val);
+		break;
+	/* Only allow MMU registers to be set to the config supported by KVM */
+	case KVM_REG_PPC_MMUCFG: {
+		if (set_reg_val(id, *val) != vcpu->arch.mmucfg)
+			r = -EINVAL;
+		break;
+	}
+	case KVM_REG_PPC_TLB0CFG:
+	case KVM_REG_PPC_TLB1CFG:
+	case KVM_REG_PPC_TLB2CFG:
+	case KVM_REG_PPC_TLB3CFG: {
+		/* MMU geometry (N_ENTRY/ASSOC) can be set only using SW_TLB */
+		i = id - KVM_REG_PPC_TLB0CFG;
+		if (set_reg_val(id, *val) != vcpu->arch.tlbcfg[i])
+			r = -EINVAL;
+		break;
+	}
+	default:
+		r = -EINVAL;
+		break;
+	}
+
+	return r;
+}
+
 int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
 			      struct kvm_config_tlb *cfg)
 {
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 1f89d26..ab073a8 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -255,6 +255,20 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return kvmppc_set_sregs_ivor(vcpu, sregs);
 }
 
+int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
+			union kvmppc_one_reg *val)
+{
+	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
+	return r;
+}
+
+int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
+		       union kvmppc_one_reg *val)
+{
+	int r = kvmppc_set_one_reg_e500_tlb(vcpu, id, val);
+	return r;
+}
+
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500;
-- 
1.7.4.1
