Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DFC232C0354
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 22:43:30 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 5/6] KVM: PPC: Book3E: Add ONE_REG AltiVec support
Date: Wed, 3 Jul 2013 15:42:38 +0300
Message-ID: <1372855359-13452-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
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
 arch/powerpc/kvm/booke.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index c3c3af6..6ac1f68 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1585,6 +1585,22 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	case KVM_REG_PPC_DEBUG_INST:
 		val = get_reg_val(reg->id, KVMPPC_INST_EHPRIV);
 		break;
+#ifdef CONFIG_ALTIVEC
+	case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
+		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+			r = -ENXIO;
+			break;
+		}
+		val.vval = vcpu->arch.vr[reg->id - KVM_REG_PPC_VR0];
+		break;
+	case KVM_REG_PPC_VSCR:
+		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+			r = -ENXIO;
+			break;
+		}
+		val = get_reg_val(reg->id, vcpu->arch.vscr.u[3]);
+		break;
+#endif /* CONFIG_ALTIVEC */
 	default:
 		r = kvmppc_get_one_reg(vcpu, reg->id, &val);
 		break;
@@ -1658,6 +1674,22 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 		kvmppc_set_tcr(vcpu, tcr);
 		break;
 	}
+#ifdef CONFIG_ALTIVEC
+	case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
+		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+			r = -ENXIO;
+			break;
+		}
+		vcpu->arch.vr[reg->id - KVM_REG_PPC_VR0] = val.vval;
+		break;
+	case KVM_REG_PPC_VSCR:
+		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
+			r = -ENXIO;
+			break;
+		}
+		vcpu->arch.vscr.u[3] = set_reg_val(reg->id, val);
+		break;
+#endif /* CONFIG_ALTIVEC */
 	default:
 		r = kvmppc_set_one_reg(vcpu, reg->id, &val);
 		break;
-- 
1.7.3.4
