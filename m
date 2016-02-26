Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E51811A0B60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:41:30 +1100 (AEDT)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DC10A140327
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:29 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:41:27 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7610019D8058
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:28:59 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIf25L26083390
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:02 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIf1iU016934
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:02 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 03/14] KVM: PPC: select IRQ_BYPASS_MANAGER
Date: Fri, 26 Feb 2016 12:40:21 -0600
Message-Id: <1456512032-31286-4-git-send-email-warrier@linux.vnet.ibm.com>
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

Select IRQ_BYPASS_MANAGER for PPC when CONFIG_KVM is set.
Add the PPC producer functions for add and del producer.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h |  4 ++++
 arch/powerpc/kvm/Kconfig           |  2 ++
 arch/powerpc/kvm/book3s.c          | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 197a8ac..780a017 100644
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
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index b34220d..2492b7e 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -35,6 +35,8 @@
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
+#include <linux/irqbypass.h>
+#include <linux/kvm_irqfd.h>
 
 #include "book3s.h"
 #include "trace.h"
@@ -921,6 +923,36 @@ int kvmppc_book3s_hcall_implemented(struct kvm *kvm, unsigned long hcall)
 	return kvm->arch.kvm_ops->hcall_implemented(hcall);
 }
 
+/*
+ * irq_bypass_add_producer and irq_bypass_del_producer are only
+ * useful if the architecture supports PCI passthrough.
+ * irq_bypass_stop and irq_bypass_start are not needed and so
+ * kvm_ops are not defined for them.
+ */
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
 static int kvmppc_book3s_init(void)
 {
 	int r;
-- 
1.8.3.4
