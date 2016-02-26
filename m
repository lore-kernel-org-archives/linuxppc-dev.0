Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 007051A0B75
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:42:08 +1100 (AEDT)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 022CF14076A
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:42:06 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:42:05 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B02573E40030
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:48 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIfmcG36241508
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:48 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIfl5m019898
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:47 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 11/14] KVM: PPC: Book3S HV: Tunable to disable KVM IRQ bypass
Date: Fri, 26 Feb 2016 12:40:29 -0600
Message-Id: <1456512032-31286-12-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a  module parameter kvm_irq_bypass for kvm_hv.ko to
disable IRQ bypass for passthrough interrupts. The default
value of this tunable is 1 - that is enable the feature.

Since the tunable is used by built-in kernel code, we use
the module_param_cb macro to achieve this.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  1 +
 arch/powerpc/include/asm/kvm_ppc.h    |  2 +-
 arch/powerpc/kvm/book3s_hv.c          | 13 +++++++++++++
 arch/powerpc/kvm/book3s_hv_rm_xics.c  |  2 ++
 4 files changed, 17 insertions(+), 1 deletion(-)

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
index 93531cc..a13fd2b 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -465,7 +465,7 @@ static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
 				struct kvm_vcpu *vcpu)
 {
-	if (vcpu)
+	if (vcpu && kvm_irq_bypass)
 		return vcpu->kvm->arch.pimap;
 	else
 		return NULL;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 487657f..2d82c4d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -91,6 +91,10 @@ static struct kernel_param_ops module_param_ops = {
 	.get = param_get_int,
 };
 
+module_param_cb(kvm_irq_bypass, &module_param_ops, &kvm_irq_bypass,
+							S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(kvm_irq_bypass, "Bypass passthrough interrupt optimization");
+
 module_param_cb(h_ipi_redirect, &module_param_ops, &h_ipi_redirect,
 							S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host core");
@@ -3317,6 +3321,9 @@ static int kvmppc_cache_passthru_irq_hv(struct kvm *kvm, int irq)
 	struct kvmppc_passthru_irqmap *pimap;
 	int cidx, midx;
 
+	if (!kvm_irq_bypass)
+		return 1;
+
 	mutex_lock(&kvm->lock);
 
 	if (kvm->arch.pimap == NULL)
@@ -3421,6 +3428,9 @@ static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	struct irq_chip *chip;
 	int i;
 
+	if (!kvm_irq_bypass)
+		return 0;
+
 	desc = irq_to_desc(host_irq);
 	if (!desc)
 		return -EIO;
@@ -3484,6 +3494,9 @@ static int kvmppc_clr_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	struct kvmppc_passthru_irqmap *pimap;
 	int i;
 
+	if (!kvm_irq_bypass)
+		return 0;
+
 	desc = irq_to_desc(host_irq);
 	if (!desc)
 		return -EIO;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 8390c50..97a09c2 100644
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
1.8.3.4
