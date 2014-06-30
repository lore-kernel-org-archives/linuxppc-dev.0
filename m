Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C46F21A017C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 01:35:17 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 5/6 v2] KVM: PPC: Book3E: Add ONE_REG AltiVec support
Date: Mon, 30 Jun 2014 18:34:56 +0300
Message-ID: <1404142497-6430-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
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

Add ONE_REG support for AltiVec on Book3E.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v2:
 - add comment describing VCSR register representation in KVM vs kernel

 arch/powerpc/include/uapi/asm/kvm.h |  5 +++++
 arch/powerpc/kvm/booke.c            | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 2bc4a94..3adbce4 100644
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
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 4ba75f6..fe15a94 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1634,6 +1634,23 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	case KVM_REG_PPC_VRSAVE:
 		val = get_reg_val(reg->id, vcpu->arch.vrsave);
 		break;
+#ifdef CONFIG_ALTIVEC
+	case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
+		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+			r = -ENXIO;
+			break;
+		}
+		val.vval = vcpu->arch.vr.vr[reg->id - KVM_REG_PPC_VR0];
+		break;
+	case KVM_REG_PPC_VSCR:
+		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+			r = -ENXIO;
+			break;
+		}
+		val = get_reg_val(reg->id, vcpu->arch.vr.vscr.u[3]);
+		break;
+#endif /* CONFIG_ALTIVEC */
+
 	default:
 		r = vcpu->kvm->arch.kvm_ops->get_one_reg(vcpu, reg->id, &val);
 		break;
@@ -1717,6 +1734,23 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	case KVM_REG_PPC_VRSAVE:
 		vcpu->arch.vrsave = set_reg_val(reg->id, val);
 		break;
+#ifdef CONFIG_ALTIVEC
+	case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
+		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+			r = -ENXIO;
+			break;
+		}
+		vcpu->arch.vr.vr[reg->id - KVM_REG_PPC_VR0] = val.vval;
+		break;
+	case KVM_REG_PPC_VSCR:
+		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+			r = -ENXIO;
+			break;
+		}
+		vcpu->arch.vr.vscr.u[3] = set_reg_val(reg->id, val);
+		break;
+#endif /* CONFIG_ALTIVEC */
+
 	default:
 		r = vcpu->kvm->arch.kvm_ops->set_one_reg(vcpu, reg->id, &val);
 		break;
-- 
1.7.11.7
