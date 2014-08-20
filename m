Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 678861A0162
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:36:48 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v4 4/6] KVM: PPC: Move ONE_REG AltiVec support to powerpc
Date: Wed, 20 Aug 2014 16:36:25 +0300
Message-ID: <1408541787-24625-5-git-send-email-mihai.caraman@freescale.com>
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

Move ONE_REG AltiVec support to powerpc generic layer.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v4:
 - split ONE_REG powerpc generic and ONE_REG AltiVec

v3:
 - make ONE_REG AltiVec support powerpc generic

v2:
 - add comment describing VCSR register representation in KVM vs kernel

 arch/powerpc/include/uapi/asm/kvm.h |  5 +++++
 arch/powerpc/kvm/book3s.c           | 42 -------------------------------------
 arch/powerpc/kvm/powerpc.c          | 42 +++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 3ca357a..ab4d473 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -476,6 +476,11 @@ struct kvm_get_htab_header {
 
 /* FP and vector status/control registers */
 #define KVM_REG_PPC_FPSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x80)
+/*
+ * VSCR register is documented as a 32-bit register in the ISA, but it can
+ * only be accesses via a vector register. Expose VSCR as a 32-bit register
+ * even though the kernel represents it as a 128-bit vector.
+ */
 #define KVM_REG_PPC_VSCR	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x81)
 
 /* Virtual processor areas */
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 26868e2..1b5adda 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -558,25 +558,6 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
 		case KVM_REG_PPC_FPSCR:
 			*val = get_reg_val(id, vcpu->arch.fp.fpscr);
 			break;
-#ifdef CONFIG_ALTIVEC
-		case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
-			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
-				r = -ENXIO;
-				break;
-			}
-			val->vval = vcpu->arch.vr.vr[id - KVM_REG_PPC_VR0];
-			break;
-		case KVM_REG_PPC_VSCR:
-			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
-				r = -ENXIO;
-				break;
-			}
-			*val = get_reg_val(id, vcpu->arch.vr.vscr.u[3]);
-			break;
-		case KVM_REG_PPC_VRSAVE:
-			*val = get_reg_val(id, vcpu->arch.vrsave);
-			break;
-#endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 		case KVM_REG_PPC_VSR0 ... KVM_REG_PPC_VSR31:
 			if (cpu_has_feature(CPU_FTR_VSX)) {
@@ -653,29 +634,6 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
 		case KVM_REG_PPC_FPSCR:
 			vcpu->arch.fp.fpscr = set_reg_val(id, *val);
 			break;
-#ifdef CONFIG_ALTIVEC
-		case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
-			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
-				r = -ENXIO;
-				break;
-			}
-			vcpu->arch.vr.vr[id - KVM_REG_PPC_VR0] = val->vval;
-			break;
-		case KVM_REG_PPC_VSCR:
-			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
-				r = -ENXIO;
-				break;
-			}
-			vcpu->arch.vr.vscr.u[3] = set_reg_val(id, *val);
-			break;
-		case KVM_REG_PPC_VRSAVE:
-			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
-				r = -ENXIO;
-				break;
-			}
-			vcpu->arch.vrsave = set_reg_val(id, *val);
-			break;
-#endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 		case KVM_REG_PPC_VSR0 ... KVM_REG_PPC_VSR31:
 			if (cpu_has_feature(CPU_FTR_VSX)) {
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1326116..19d4755 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -941,6 +941,25 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	if (r == -EINVAL) {
 		r = 0;
 		switch (reg->id) {
+#ifdef CONFIG_ALTIVEC
+		case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
+			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+				r = -ENXIO;
+				break;
+			}
+			val.vval = vcpu->arch.vr.vr[reg->id - KVM_REG_PPC_VR0];
+			break;
+		case KVM_REG_PPC_VSCR:
+			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+				r = -ENXIO;
+				break;
+			}
+			val = get_reg_val(reg->id, vcpu->arch.vr.vscr.u[3]);
+			break;
+		case KVM_REG_PPC_VRSAVE:
+			val = get_reg_val(reg->id, vcpu->arch.vrsave);
+			break;
+#endif /* CONFIG_ALTIVEC */
 		default:
 			r = -EINVAL;
 			break;
@@ -973,6 +992,29 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	if (r == -EINVAL) {
 		r = 0;
 		switch (reg->id) {
+#ifdef CONFIG_ALTIVEC
+		case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
+			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+				r = -ENXIO;
+				break;
+			}
+			vcpu->arch.vr.vr[reg->id - KVM_REG_PPC_VR0] = val.vval;
+			break;
+		case KVM_REG_PPC_VSCR:
+			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+				r = -ENXIO;
+				break;
+			}
+			vcpu->arch.vr.vscr.u[3] = set_reg_val(reg->id, val);
+			break;
+		case KVM_REG_PPC_VRSAVE:
+			if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+				r = -ENXIO;
+				break;
+			}
+			vcpu->arch.vrsave = set_reg_val(reg->id, val);
+			break;
+#endif /* CONFIG_ALTIVEC */
 		default:
 			r = -EINVAL;
 			break;
-- 
1.7.11.7
