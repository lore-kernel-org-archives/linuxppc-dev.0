Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82D541007D6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:50 +1000 (EST)
Received: from mail106-db3 (localhost [127.0.0.1])	by
 mail106-db3-R.bigfish.com (Postfix) with ESMTP id DEBCD1402C9	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:06 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.253])	by
 mail106-db3.bigfish.com (Postfix) with ESMTP id E98E42A004C	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:04 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQdlx003885	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:40 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 02/17] KVM: PPC64: booke: Add EPCR support in mtspr/mfspr
 emulation
Date: Mon, 25 Jun 2012 15:26:20 +0300
Message-ID: <1340627195-11544-3-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add EPCR support in booke mtspr/mfspr emulation. EPCR register is defined
only for 64-bit and HV categories, so it shoud be available only on 64-bit
virtual processors. Undefine the support for 32-bit builds.
Define a reusable setter function for vcpu's EPCR.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c         |   12 +++++++++++-
 arch/powerpc/kvm/booke.h         |    6 ++++++
 arch/powerpc/kvm/booke_emulate.c |   13 ++++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 72f13f4..f9fa260 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -13,7 +13,7 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  *
  * Copyright IBM Corp. 2007
- * Copyright 2010-2011 Freescale Semiconductor, Inc.
+ * Copyright 2010-2012 Freescale Semiconductor, Inc.
  *
  * Authors: Hollis Blanchard <hollisb@us.ibm.com>
  *          Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
@@ -1243,6 +1243,16 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
 {
 }
 
+#ifdef CONFIG_64BIT
+void kvmppc_set_epcr(struct kvm_vcpu *vcpu, u32 new_epcr)
+{
+	vcpu->arch.epcr = new_epcr;
+	vcpu->arch.shadow_epcr &= ~SPRN_EPCR_GICM;
+	if (vcpu->arch.epcr  & SPRN_EPCR_ICM)
+		vcpu->arch.shadow_epcr |= SPRN_EPCR_GICM;
+}
+#endif
+
 void kvmppc_set_tcr(struct kvm_vcpu *vcpu, u32 new_tcr)
 {
 	vcpu->arch.tcr = new_tcr;
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index ba61974..e05b48f 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -69,6 +69,12 @@ extern unsigned long kvmppc_booke_handlers;
 void kvmppc_set_msr(struct kvm_vcpu *vcpu, u32 new_msr);
 void kvmppc_mmu_msr_notify(struct kvm_vcpu *vcpu, u32 old_msr);
 
+#ifdef CONFIG_64BIT
+void kvmppc_set_epcr(struct kvm_vcpu *vcpu, u32 new_epcr);
+#else
+static inline void kvmppc_set_epcr(struct kvm_vcpu *vcpu, u32 new_epcr) {}
+#endif
+
 void kvmppc_set_tcr(struct kvm_vcpu *vcpu, u32 new_tcr);
 void kvmppc_set_tsr_bits(struct kvm_vcpu *vcpu, u32 tsr_bits);
 void kvmppc_clr_tsr_bits(struct kvm_vcpu *vcpu, u32 tsr_bits);
diff --git a/arch/powerpc/kvm/booke_emulate.c b/arch/powerpc/kvm/booke_emulate.c
index 6c76397..9cf2b95f 100644
--- a/arch/powerpc/kvm/booke_emulate.c
+++ b/arch/powerpc/kvm/booke_emulate.c
@@ -13,7 +13,7 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  *
  * Copyright IBM Corp. 2008
- * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011-2012 Freescale Semiconductor, Inc.
  *
  * Authors: Hollis Blanchard <hollisb@us.ibm.com>
  */
@@ -207,6 +207,12 @@ int kvmppc_booke_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 	case SPRN_IVOR15:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_DEBUG] = spr_val;
 		break;
+#ifdef CONFIG_64BIT
+	case SPRN_EPCR:
+		kvmppc_set_epcr(vcpu, spr_val);
+		mtspr(SPRN_EPCR, vcpu->arch.shadow_epcr);
+		break;
+#endif
 
 	default:
 		emulated = EMULATE_FAIL;
@@ -293,6 +299,11 @@ int kvmppc_booke_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 	case SPRN_IVOR15:
 		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_DEBUG];
 		break;
+#ifdef CONFIG_64BIT
+	case SPRN_EPCR:
+		*spr_val = vcpu->arch.epcr;
+		break;
+#endif
 
 	default:
 		emulated = EMULATE_FAIL;
-- 
1.7.4.1
