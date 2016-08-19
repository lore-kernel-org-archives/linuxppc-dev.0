Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBw2nBczDr8M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:08 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 03/13] KVM: PPC: select IRQ_BYPASS_MANAGER
Date: Fri, 19 Aug 2016 15:35:47 +1000
Message-Id: <1471584957-21484-4-git-send-email-paulus@ozlabs.org>
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

Select IRQ_BYPASS_MANAGER for PPC when CONFIG_KVM is set.
Add the PPC producer functions for add and del producer.

[paulus@ozlabs.org - Moved new functions from book3s.c to powerpc.c
 so booke compiles; added kvm_arch_has_irq_bypass implementation.]

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_ppc.h |  4 ++++
 arch/powerpc/kvm/Kconfig           |  2 ++
 arch/powerpc/kvm/powerpc.c         | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 2544eda..94715e2 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -287,6 +287,10 @@ struct kvmppc_ops {
 	long (*arch_vm_ioctl)(struct file *filp, unsigned int ioctl,
 			      unsigned long arg);
 	int (*hcall_implemented)(unsigned long hcall);
+	int (*irq_bypass_add_producer)(struct irq_bypass_consumer *,
+				       struct irq_bypass_producer *);
+	void (*irq_bypass_del_producer)(struct irq_bypass_consumer *,
+					struct irq_bypass_producer *);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index c2024ac..7ac0569 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -22,6 +22,8 @@ config KVM
 	select ANON_INODES
 	select HAVE_KVM_EVENTFD
 	select SRCU
+	select IRQ_BYPASS_MANAGER
+	select HAVE_KVM_IRQ_BYPASS
 
 config KVM_BOOK3S_HANDLER
 	bool
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 6ce40dd..6d51e0f 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -27,6 +27,8 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/module.h>
+#include <linux/irqbypass.h>
+#include <linux/kvm_irqfd.h>
 #include <asm/cputable.h>
 #include <asm/uaccess.h>
 #include <asm/kvm_ppc.h>
@@ -739,6 +741,42 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 #endif
 }
 
+/*
+ * irq_bypass_add_producer and irq_bypass_del_producer are only
+ * useful if the architecture supports PCI passthrough.
+ * irq_bypass_stop and irq_bypass_start are not needed and so
+ * kvm_ops are not defined for them.
+ */
+bool kvm_arch_has_irq_bypass(void)
+{
+	return ((kvmppc_hv_ops && kvmppc_hv_ops->irq_bypass_add_producer) ||
+		(kvmppc_pr_ops && kvmppc_pr_ops->irq_bypass_add_producer));
+}
+
+int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
+				     struct irq_bypass_producer *prod)
+{
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
+
+	if (kvm->arch.kvm_ops->irq_bypass_add_producer)
+		return kvm->arch.kvm_ops->irq_bypass_add_producer(cons, prod);
+
+	return 0;
+}
+
+void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
+				      struct irq_bypass_producer *prod)
+{
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
+
+	if (kvm->arch.kvm_ops->irq_bypass_del_producer)
+		kvm->arch.kvm_ops->irq_bypass_del_producer(cons, prod);
+}
+
 static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
                                       struct kvm_run *run)
 {
-- 
2.8.1
