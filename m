Return-Path: <laurentiu.tudor@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WxXQ1LWbzF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 22:41:56 +1000 (AEST)
From: laurentiu.tudor@nxp.com
To: kvm-ppc@vger.kernel.org
Cc: agraf@suse.de, linuxppc-dev@lists.ozlabs.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] powerpc/kvm/booke: fix altivec related build break
Date: Thu, 26 Apr 2018 15:33:19 +0300
Message-Id: <20180426123319.10843-1-laurentiu.tudor@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add missing "altivec unavailable" interrupt injection helper
thus fixing the linker error below:

arch/powerpc/kvm/emulate_loadstore.o: In function `kvmppc_check_altivec_disabled':
arch/powerpc/kvm/emulate_loadstore.c: undefined reference to `.kvmppc_core_queue_vec_unavail'

Fixes: 09f984961c137c4b ("KVM: PPC: Book3S: Add MMIO emulation for VMX instructions")
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/powerpc/kvm/booke.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 6038e2e7aee0..876d4f294fdd 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -305,6 +305,13 @@ void kvmppc_core_queue_fpunavail(struct kvm_vcpu *vcpu)
 	kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_FP_UNAVAIL);
 }
 
+#ifdef CONFIG_ALTIVEC
+void kvmppc_core_queue_vec_unavail(struct kvm_vcpu *vcpu)
+{
+	kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_ALTIVEC_UNAVAIL);
+}
+#endif
+
 void kvmppc_core_queue_dec(struct kvm_vcpu *vcpu)
 {
 	kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_DECREMENTER);
-- 
2.17.0
