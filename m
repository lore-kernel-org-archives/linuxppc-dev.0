Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBx5YZTzDrBG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:09 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 10/13] KVM: PPC: Book3S HV: Tunable to disable KVM IRQ bypass
Date: Fri, 19 Aug 2016 15:35:54 +1000
Message-Id: <1471584957-21484-11-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
References: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suresh Warrier <warrier@linux.vnet.ibm.com>

Add a  module parameter kvm_irq_bypass for kvm_hv.ko to
disable IRQ bypass for passthrough interrupts. The default
value of this tunable is 1 - that is enable the feature.

Since the tunable is used by built-in kernel code, we use
the module_param_cb macro to achieve this.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |  1 +
 arch/powerpc/include/asm/kvm_ppc.h    |  2 +-
 arch/powerpc/kvm/book3s_hv.c          | 10 ++++++++++
 arch/powerpc/kvm/book3s_hv_rm_xics.c  |  2 ++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 8f39796..8e5fac6 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -191,6 +191,7 @@ extern void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 				 struct kvm_vcpu *vcpu);
 extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 				   struct kvmppc_book3s_shadow_vcpu *svcpu);
+extern int kvm_irq_bypass;
 
 static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index e0ada31..97b9bad 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -461,7 +461,7 @@ static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
 				struct kvm *kvm)
 {
-	if (kvm)
+	if (kvm && kvm_irq_bypass)
 		return kvm->arch.pimap;
 	return NULL;
 }
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index cfddafa..2e71518 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -94,6 +94,10 @@ static struct kernel_param_ops module_param_ops = {
 	.get = param_get_int,
 };
 
+module_param_cb(kvm_irq_bypass, &module_param_ops, &kvm_irq_bypass,
+							S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(kvm_irq_bypass, "Bypass passthrough interrupt optimization");
+
 module_param_cb(h_ipi_redirect, &module_param_ops, &h_ipi_redirect,
 							S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host core");
@@ -3313,6 +3317,9 @@ static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	struct irq_chip *chip;
 	int i;
 
+	if (!kvm_irq_bypass)
+		return 1;
+
 	desc = irq_to_desc(host_irq);
 	if (!desc)
 		return -EIO;
@@ -3389,6 +3396,9 @@ static int kvmppc_clr_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	struct kvmppc_passthru_irqmap *pimap;
 	int i;
 
+	if (!kvm_irq_bypass)
+		return 0;
+
 	desc = irq_to_desc(host_irq);
 	if (!desc)
 		return -EIO;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 3b8d7ac..00b9dfde 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -27,6 +27,8 @@
 
 int h_ipi_redirect = 1;
 EXPORT_SYMBOL(h_ipi_redirect);
+int kvm_irq_bypass = 1;
+EXPORT_SYMBOL(kvm_irq_bypass);
 
 static void icp_rm_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 			    u32 new_irq);
-- 
2.8.1
