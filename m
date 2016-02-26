Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BB411A0B73
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:41:19 +1100 (AEDT)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2EE7F140317
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:17 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:41:16 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AF0701FF003F
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:29:20 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIfBWh26673242
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:11 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIf9ZJ017354
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:10 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 05/14] KVM: PPC: Book3S HV: Enable IRQ bypass
Date: Fri, 26 Feb 2016 12:40:23 -0600
Message-Id: <1456512032-31286-6-git-send-email-warrier@linux.vnet.ibm.com>
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

Add the irq_bypass_add_producer and irq_bypass_del_producer
functions. These functions get called whenever a GSI is being
defined for a guest. They create/remove the mapping between
host real IRQ numbers and the guest GSI.

Add the following helper functions to manage the
passthrough IRQ map.

kvmppc_set_passthru_irq()
  Creates a mapping in the passthrough IRQ map that maps a host
  IRQ to a guest GSI. It allocates the structure (one per guest VM)
  the first time it is called.

kvmppc_clr_passthru_irq()
  Removes the passthrough IRQ map entry given a guest GSI.
  The passthrough IRQ map structure is not freed even when the
  number of mapped entries goes to zero. It is only freed when
  the VM is destroyed.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 158 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22d3054..4d802b8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -55,6 +55,8 @@
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
 #include <linux/hugetlb.h>
+#include <linux/kvm_irqfd.h>
+#include <linux/irqbypass.h>
 #include <linux/module.h>
 
 #include "book3s.h"
@@ -3246,6 +3248,8 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 	kvmppc_free_vcores(kvm);
 
 	kvmppc_free_hpt(kvm);
+
+	kvmppc_free_pimap(kvm);
 }
 
 /* We don't need to emulate any privileged instructions or dcbz */
@@ -3282,7 +3286,7 @@ void kvmppc_free_pimap(struct kvm *kvm)
 	kfree(kvm->arch.pimap);
 }
 
-struct kvmppc_passthru_irqmap *kvmppc_alloc_pimap(struct irq_desc *desc)
+static struct kvmppc_passthru_irqmap *kvmppc_alloc_pimap(struct irq_desc *desc)
 {
 	struct kvmppc_passthru_irqmap *pimap;
 
@@ -3292,6 +3296,154 @@ struct kvmppc_passthru_irqmap *kvmppc_alloc_pimap(struct irq_desc *desc)
 
 	return pimap;
 }
+
+static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
+{
+	struct irq_desc *desc;
+	struct kvmppc_irq_map *irq_map;
+	struct kvmppc_passthru_irqmap *pimap;
+	struct irq_chip *chip;
+	int i;
+
+	desc = irq_to_desc(host_irq);
+	if (!desc)
+		return -EIO;
+
+	mutex_lock(&kvm->lock);
+
+	if (kvm->arch.pimap == NULL) {
+		/* First call, allocate structure to hold IRQ map */
+		pimap = kvmppc_alloc_pimap(desc);
+		if (pimap == NULL) {
+			mutex_unlock(&kvm->lock);
+			return -ENOMEM;
+		}
+	} else
+		pimap = kvm->arch.pimap;
+
+	/*
+	 * For now, we support only a single IRQ chip
+	 */
+	chip = irq_data_get_irq_chip(&desc->irq_data);
+	if (!chip || (strcmp(chip->name, pimap->irq_chip->name) != 0)) {
+		pr_warn("kvmppc_set_passthru_irq_hv: Could not assign IRQ map for (%d,%d)\n",
+			host_irq, guest_gsi);
+		mutex_unlock(&kvm->lock);
+		return -ENOENT;
+	}
+
+	if (pimap->n_mapped == KVMPPC_PIRQ_MAPPED) {
+		mutex_unlock(&kvm->lock);
+		return -EAGAIN;
+	}
+
+	for (i = 0; i < pimap->n_mapped; i++) {
+		if (guest_gsi == pimap->mapped[i].v_hwirq) {
+			mutex_unlock(&kvm->lock);
+			return -EINVAL;
+		}
+	}
+
+	irq_map = &pimap->mapped[pimap->n_mapped];
+
+	irq_map->v_hwirq = guest_gsi;
+	irq_map->r_hwirq = desc->irq_data.hwirq;
+	irq_map->desc = desc;
+
+	pimap->n_mapped++;
+
+	if (!kvm->arch.pimap)
+		kvm->arch.pimap = pimap;
+
+	mutex_unlock(&kvm->lock);
+
+	return 0;
+}
+
+static int kvmppc_clr_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
+{
+	struct irq_desc *desc;
+	struct kvmppc_passthru_irqmap *pimap;
+	int i;
+
+	desc = irq_to_desc(host_irq);
+	if (!desc)
+		return -EIO;
+
+	mutex_lock(&kvm->lock);
+
+	if (kvm->arch.pimap == NULL) {
+		mutex_unlock(&kvm->lock);
+		return 0;
+	}
+	pimap = kvm->arch.pimap;
+
+	WARN_ON(pimap->n_mapped < 1);
+
+	for (i = 0; i < pimap->n_mapped; i++) {
+		if (guest_gsi == pimap->mapped[i].v_hwirq)
+			break;
+	}
+
+	if (i == pimap->n_mapped) {
+		mutex_unlock(&kvm->lock);
+		return -ENODEV;
+	}
+
+	/*
+	 * Replace mapped entry to be cleared with highest entry (unless
+	 * this is already the highest) so as to not leave any holes in
+	 * the array of mapped.
+	 */
+	pimap->n_mapped--;
+	if (i != pimap->n_mapped)
+		pimap->mapped[i] = pimap->mapped[pimap->n_mapped];
+
+	/*
+	 * We don't free this structure even when the count goes to
+	 * zero. The structure is freed when we destroy the VM.
+	 */
+
+	mutex_unlock(&kvm->lock);
+	return 0;
+}
+
+static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
+					     struct irq_bypass_producer *prod)
+{
+	int ret = 0;
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+
+	irqfd->producer = prod;
+
+	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
+	if (ret)
+		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
+			prod->irq, irqfd->gsi, ret);
+
+	return ret;
+}
+
+static void kvmppc_irq_bypass_del_producer_hv(struct irq_bypass_consumer *cons,
+					      struct irq_bypass_producer *prod)
+{
+	int ret;
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+
+	irqfd->producer = NULL;
+
+	/*
+	 * When producer of consumer is unregistered, we change back to
+	 * default external interrupt handling mode - KVM real mode
+	 * will switch back to host.
+	 */
+	ret = kvmppc_clr_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
+	if (ret)
+		pr_warn("kvmppc_clr_passthru_irq (irq %d, gsi %d) fails: %d\n",
+			prod->irq, irqfd->gsi, ret);
+}
 #endif
 
 static long kvm_arch_vm_ioctl_hv(struct file *filp,
@@ -3412,6 +3564,10 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.fast_vcpu_kick = kvmppc_fast_vcpu_kick_hv,
 	.arch_vm_ioctl  = kvm_arch_vm_ioctl_hv,
 	.hcall_implemented = kvmppc_hcall_impl_hv,
+#ifdef CONFIG_KVM_XICS
+	.irq_bypass_add_producer = kvmppc_irq_bypass_add_producer_hv,
+	.irq_bypass_del_producer = kvmppc_irq_bypass_del_producer_hv,
+#endif
 };
 
 static int kvmppc_book3s_init_hv(void)
-- 
1.8.3.4
