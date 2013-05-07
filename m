Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D6D4D2C015E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 21:06:39 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <agraf@suse.de>, <scottwood@freescale.com>
Subject: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
Date: Tue, 7 May 2013 19:06:30 +0800
Message-ID: <1367924791-24394-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We also can direct ISI exception to Guest like DSI.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kvm/booke_emulate.c |    3 +++
 arch/powerpc/kvm/e500mc.c        |    3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/booke_emulate.c b/arch/powerpc/kvm/booke_emulate.c
index 27a4b28..33b14e9 100644
--- a/arch/powerpc/kvm/booke_emulate.c
+++ b/arch/powerpc/kvm/booke_emulate.c
@@ -197,6 +197,9 @@ int kvmppc_booke_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 		break;
 	case SPRN_IVOR3:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_INST_STORAGE] = spr_val;
+#ifdef CONFIG_KVM_BOOKE_HV
+		mtspr(SPRN_GIVOR3, spr_val);
+#endif
 		break;
 	case SPRN_IVOR4:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_EXTERNAL] = spr_val;
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index c3bdc0a..acf546a 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -123,6 +123,7 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	mtspr(SPRN_GIVPR, vcpu->arch.ivpr);
 	mtspr(SPRN_GIVOR2, vcpu->arch.ivor[BOOKE_IRQPRIO_DATA_STORAGE]);
+	mtspr(SPRN_GIVOR3, vcpu->arch.ivor[BOOKE_IRQPRIO_INST_STORAGE]);
 	mtspr(SPRN_GIVOR8, vcpu->arch.ivor[BOOKE_IRQPRIO_SYSCALL]);
 	mtspr(SPRN_GSPRG0, (unsigned long)vcpu->arch.shared->sprg0);
 	mtspr(SPRN_GSPRG1, (unsigned long)vcpu->arch.shared->sprg1);
@@ -185,7 +186,7 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 
 	vcpu->arch.shadow_epcr = SPRN_EPCR_DSIGS | SPRN_EPCR_DGTMI | \
-				 SPRN_EPCR_DUVD;
+				 SPRN_EPCR_DUVD | SPRN_EPCR_ISIGS;
 #ifdef CONFIG_64BIT
 	vcpu->arch.shadow_epcr |= SPRN_EPCR_ICM;
 #endif
-- 
1.7.9.5
