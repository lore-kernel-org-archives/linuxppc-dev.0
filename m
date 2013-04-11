Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79F482C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 20:08:16 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 2/8 v3] KVM: PPC: e500: Expose MMU registers via ONE_REG
Date: Thu, 11 Apr 2013 13:03:08 +0300
Message-ID: <1365674594-17410-3-git-send-email-mihai.caraman@freescale.com>
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

MMU registers were exposed to user-space using sregs interface. Add them
to ONE_REG interface using kvmppc_get_one_reg/kvmppc_set_one_reg delegation
mechanism.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v3:
 - Fix case breaks
 
v2:
 - Restrict set_one_reg operation for MMU registers to HW values

 Documentation/virtual/kvm/api.txt   |   11 ++++
 arch/powerpc/include/uapi/asm/kvm.h |   17 ++++++
 arch/powerpc/kvm/e500.c             |    6 ++-
 arch/powerpc/kvm/e500.h             |    4 ++
 arch/powerpc/kvm/e500_mmu.c         |   94 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/e500mc.c           |    6 ++-
 6 files changed, 134 insertions(+), 4 deletions(-)

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
index c2ff99c..93d063f 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -426,4 +426,21 @@ struct kvm_get_htab_header {
 /* Debugging: Special instruction for software breakpoint */
 #define KVM_REG_PPC_DEBUG_INST	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x8b)
 
+/* MMU registers */
+#define KVM_REG_PPC_MAS0	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x8c)
+#define KVM_REG_PPC_MAS1	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x8d)
+#define KVM_REG_PPC_MAS2	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8e)
+#define KVM_REG_PPC_MAS7_3	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8f)
+#define KVM_REG_PPC_MAS4	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x90)
+#define KVM_REG_PPC_MAS6	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x91)
+#define KVM_REG_PPC_MMUCFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x92)
+/*
+ * TLBnCFG fields TLBnCFG_N_ENTRY and TLBnCFG_ASSOC can be changed only using
+ * KVM_CAP_SW_TLB ioctl
+ */
+#define KVM_REG_PPC_TLB0CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x93)
+#define KVM_REG_PPC_TLB1CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x94)
+#define KVM_REG_PPC_TLB2CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x95)
+#define KVM_REG_PPC_TLB3CFG	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x96)
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 576010f..ce6b73c 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -428,13 +428,15 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
 			union kvmppc_one_reg *val)
 {
-	return -EINVAL;
+	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
+	return r;
 }
 
 int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
 		       union kvmppc_one_reg *val)
 {
-	return -EINVAL;
+	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
+	return r;
 }
 
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
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
index 5c44759..44f7762 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -596,6 +596,100 @@ int kvmppc_set_sregs_e500_tlb(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
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
+		break;
+	case KVM_REG_PPC_MAS1:
+		*val = get_reg_val(id, vcpu->arch.shared->mas1);
+		break;
+	case KVM_REG_PPC_MAS2:
+		*val = get_reg_val(id, vcpu->arch.shared->mas2);
+		break;
+	case KVM_REG_PPC_MAS7_3:
+		*val = get_reg_val(id, vcpu->arch.shared->mas7_3);
+		break;
+	case KVM_REG_PPC_MAS4:
+		*val = get_reg_val(id, vcpu->arch.shared->mas4);
+		break;
+	case KVM_REG_PPC_MAS6:
+		*val = get_reg_val(id, vcpu->arch.shared->mas6);
+		break;
+	case KVM_REG_PPC_MMUCFG:
+		*val = get_reg_val(id, vcpu->arch.mmucfg);
+		break;
+	case KVM_REG_PPC_TLB0CFG:
+	case KVM_REG_PPC_TLB1CFG:
+	case KVM_REG_PPC_TLB2CFG:
+	case KVM_REG_PPC_TLB3CFG:
+		i = id - KVM_REG_PPC_TLB0CFG;
+		*val = get_reg_val(id, vcpu->arch.tlbcfg[i]);
+		break;
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
+		u32 reg = set_reg_val(id, *val);
+		if (reg != vcpu->arch.mmucfg)
+			r = -EINVAL;
+		break;
+	}
+	case KVM_REG_PPC_TLB0CFG:
+	case KVM_REG_PPC_TLB1CFG:
+	case KVM_REG_PPC_TLB2CFG:
+	case KVM_REG_PPC_TLB3CFG: {
+		/* MMU geometry (N_ENTRY/ASSOC) can be set only using SW_TLB */
+		u32 reg = set_reg_val(id, *val);
+		i = id - KVM_REG_PPC_TLB0CFG;
+		if (reg != vcpu->arch.tlbcfg[i])
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
index b071bdc..ab073a8 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -258,13 +258,15 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
 			union kvmppc_one_reg *val)
 {
-	return -EINVAL;
+	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
+	return r;
 }
 
 int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
 		       union kvmppc_one_reg *val)
 {
-	return -EINVAL;
+	int r = kvmppc_set_one_reg_e500_tlb(vcpu, id, val);
+	return r;
 }
 
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
-- 
1.7.4.1
