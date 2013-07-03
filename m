Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 080602C0439
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 23:31:12 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 2/2] KVM: PPC: Book3E: Emulate MCSRR0/1 SPR and rfmci
 instruction
Date: Wed, 3 Jul 2013 16:30:55 +0300
Message-ID: <1372858255-19708-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372858255-19708-1-git-send-email-mihai.caraman@freescale.com>
References: <1372858255-19708-1-git-send-email-mihai.caraman@freescale.com>
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

Some guests are making use of return from machine check instruction
to do crazy things even though the 64-bit kernel doesn't handle yet
this interrupt. Emulate MCSRR0/1 SPR and rfmci instruction accordingly.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/kvm/booke_emulate.c    |   25 +++++++++++++++++++++++++
 arch/powerpc/kvm/timing.c           |    1 +
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index af326cd..0466789 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -148,6 +148,7 @@ enum kvm_exit_types {
 	EMULATED_TLBWE_EXITS,
 	EMULATED_RFI_EXITS,
 	EMULATED_RFCI_EXITS,
+	EMULATED_RFMCI_EXITS,
 	DEC_EXITS,
 	EXT_INTR_EXITS,
 	HALT_WAKEUP,
diff --git a/arch/powerpc/kvm/booke_emulate.c b/arch/powerpc/kvm/booke_emulate.c
index 27a4b28..aaff1b7 100644
--- a/arch/powerpc/kvm/booke_emulate.c
+++ b/arch/powerpc/kvm/booke_emulate.c
@@ -23,6 +23,7 @@
 
 #include "booke.h"
 
+#define OP_19_XOP_RFMCI   38
 #define OP_19_XOP_RFI     50
 #define OP_19_XOP_RFCI    51
 
@@ -43,6 +44,12 @@ static void kvmppc_emul_rfci(struct kvm_vcpu *vcpu)
 	kvmppc_set_msr(vcpu, vcpu->arch.csrr1);
 }
 
+static void kvmppc_emul_rfmci(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.pc = vcpu->arch.mcsrr0;
+	kvmppc_set_msr(vcpu, vcpu->arch.mcsrr1);
+}
+
 int kvmppc_booke_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
                             unsigned int inst, int *advance)
 {
@@ -65,6 +72,12 @@ int kvmppc_booke_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			*advance = 0;
 			break;
 
+		case OP_19_XOP_RFMCI:
+			kvmppc_emul_rfmci(vcpu);
+			kvmppc_set_exit_type(vcpu, EMULATED_RFMCI_EXITS);
+			*advance = 0;
+			break;
+
 		default:
 			emulated = EMULATE_FAIL;
 			break;
@@ -138,6 +151,12 @@ int kvmppc_booke_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 	case SPRN_DBCR1:
 		vcpu->arch.dbg_reg.dbcr1 = spr_val;
 		break;
+	case SPRN_MCSRR0:
+		vcpu->arch.mcsrr0 = spr_val;
+		break;
+	case SPRN_MCSRR1:
+		vcpu->arch.mcsrr1 = spr_val;
+		break;
 	case SPRN_DBSR:
 		vcpu->arch.dbsr &= ~spr_val;
 		break;
@@ -284,6 +303,12 @@ int kvmppc_booke_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 	case SPRN_DBCR1:
 		*spr_val = vcpu->arch.dbg_reg.dbcr1;
 		break;
+	case SPRN_MCSRR0:
+		*spr_val = vcpu->arch.mcsrr0;
+		break;
+	case SPRN_MCSRR1:
+		*spr_val = vcpu->arch.mcsrr1;
+		break;
 	case SPRN_DBSR:
 		*spr_val = vcpu->arch.dbsr;
 		break;
diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
index c392d26..670f63d 100644
--- a/arch/powerpc/kvm/timing.c
+++ b/arch/powerpc/kvm/timing.c
@@ -129,6 +129,7 @@ static const char *kvm_exit_names[__NUMBER_OF_KVM_EXIT_TYPES] = {
 	[EMULATED_TLBSX_EXITS] =    "EMUL_TLBSX",
 	[EMULATED_TLBWE_EXITS] =    "EMUL_TLBWE",
 	[EMULATED_RFI_EXITS] =      "EMUL_RFI",
+	[EMULATED_RFMCI_EXITS] =    "EMUL_RFMCI",
 	[DEC_EXITS] =               "DEC",
 	[EXT_INTR_EXITS] =          "EXTINT",
 	[HALT_WAKEUP] =             "HALT",
-- 
1.7.3.4
