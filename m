Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5D0F2C03AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:26 +1100 (EST)
Received: from mail216-va3 (localhost [127.0.0.1])	by
 mail216-va3-R.bigfish.com (Postfix) with ESMTP id D27168401AA	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:21 +0000 (UTC)
Received: from VA3EHSMHS010.bigfish.com (unknown [10.7.14.237])	by
 mail216-va3.bigfish.com (Postfix) with ESMTP id 08EC618004E	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:19 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEB9P003743	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:12 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 10/12] KVM: PPC: bookehv: Add EPCR support in mtspr/mfspr
 emulation
Date: Thu, 11 Oct 2012 19:13:27 +0300
Message-ID: <1349972009-23027-11-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
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

Add EPCR support in booke mtspr/mfspr emulation. EPCR register is defined only
for 64-bit and HV categories, we will expose it at this point only to 64-bit
virtual processors running on 64-bit HV hosts.
Define a reusable setter function for vcpu's EPCR.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v1: extended guard defines with CONFIG_KVM_BOOKE_HV required by arch's epcr and
shadow_epcr fields.

 arch/powerpc/kvm/booke.c         |   10 ++++++++++
 arch/powerpc/kvm/booke.h         |    1 +
 arch/powerpc/kvm/booke_emulate.c |   12 +++++++++++-
 3 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 86f0d0d..e6159f5 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1473,6 +1473,16 @@ void kvmppc_core_flush_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot)
 {
 }
 
+void kvmppc_set_epcr(struct kvm_vcpu *vcpu, u32 new_epcr)
+{
+#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)
+	vcpu->arch.epcr = new_epcr;
+	vcpu->arch.shadow_epcr &= ~SPRN_EPCR_GICM;
+	if (vcpu->arch.epcr  & SPRN_EPCR_ICM)
+		vcpu->arch.shadow_epcr |= SPRN_EPCR_GICM;
+#endif
+}
+
 void kvmppc_set_tcr(struct kvm_vcpu *vcpu, u32 new_tcr)
 {
 	vcpu->arch.tcr = new_tcr;
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index ba61974..e9b88e4 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -69,6 +69,7 @@ extern unsigned long kvmppc_booke_handlers;
 void kvmppc_set_msr(struct kvm_vcpu *vcpu, u32 new_msr);
 void kvmppc_mmu_msr_notify(struct kvm_vcpu *vcpu, u32 old_msr);
 
+void kvmppc_set_epcr(struct kvm_vcpu *vcpu, u32 new_epcr);
 void kvmppc_set_tcr(struct kvm_vcpu *vcpu, u32 new_tcr);
 void kvmppc_set_tsr_bits(struct kvm_vcpu *vcpu, u32 tsr_bits);
 void kvmppc_clr_tsr_bits(struct kvm_vcpu *vcpu, u32 tsr_bits);
diff --git a/arch/powerpc/kvm/booke_emulate.c b/arch/powerpc/kvm/booke_emulate.c
index 514790f..8d9d8f9 100644
--- a/arch/powerpc/kvm/booke_emulate.c
+++ b/arch/powerpc/kvm/booke_emulate.c
@@ -240,7 +240,12 @@ int kvmppc_booke_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 	case SPRN_MCSR:
 		vcpu->arch.mcsr &= ~spr_val;
 		break;
-
+#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)
+	case SPRN_EPCR:
+		kvmppc_set_epcr(vcpu, spr_val);
+		mtspr(SPRN_EPCR, vcpu->arch.shadow_epcr);
+		break;
+#endif
 	default:
 		emulated = EMULATE_FAIL;
 	}
@@ -335,6 +340,11 @@ int kvmppc_booke_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 	case SPRN_MCSR:
 		*spr_val = vcpu->arch.mcsr;
 		break;
+#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)
+	case SPRN_EPCR:
+		*spr_val = vcpu->arch.epcr;
+		break;
+#endif
 
 	default:
 		emulated = EMULATE_FAIL;
-- 
1.7.4.1
