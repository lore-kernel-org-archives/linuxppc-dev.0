Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBw4SxQzDrBG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:08 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 06/13] KVM: PPC: Book3S HV: Enable IRQ bypass
Date: Fri, 19 Aug 2016 15:35:50 +1000
Message-Id: <1471584957-21484-7-git-send-email-paulus@ozlabs.org>
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

[paulus@ozlabs.org - modified to use is_pnv_opal_msi() rather than
 requiring all passed-through interrupts to use the same irq_chip;
 changed deletion so it zeroes out the r_hwirq field rather than
 copying the last entry down and decrementing the number of entries.]

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 160 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 413b5c2f..aa11647 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -53,10 +53,13 @@
 #include <asm/smp.h>
 #include <asm/dbell.h>
 #include <asm/hmi.h>
+#include <asm/pnv-pci.h>
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
 #include <linux/hugetlb.h>
+#include <linux/kvm_irqfd.h>
+#include <linux/irqbypass.h>
 #include <linux/module.h>
 
 #include "book3s.h"
@@ -3247,6 +3250,8 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 	kvmppc_free_vcores(kvm);
 
 	kvmppc_free_hpt(kvm);
+
+	kvmppc_free_pimap(kvm);
 }
 
 /* We don't need to emulate any privileged instructions or dcbz */
@@ -3289,10 +3294,159 @@ void kvmppc_free_pimap(struct kvm *kvm)
 	kfree(kvm->arch.pimap);
 }
 
-struct kvmppc_passthru_irqmap *kvmppc_alloc_pimap(void)
+static struct kvmppc_passthru_irqmap *kvmppc_alloc_pimap(void)
 {
 	return kzalloc(sizeof(struct kvmppc_passthru_irqmap), GFP_KERNEL);
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
+	pimap = kvm->arch.pimap;
+	if (pimap == NULL) {
+		/* First call, allocate structure to hold IRQ map */
+		pimap = kvmppc_alloc_pimap();
+		if (pimap == NULL) {
+			mutex_unlock(&kvm->lock);
+			return -ENOMEM;
+		}
+		kvm->arch.pimap = pimap;
+	}
+
+	/*
+	 * For now, we only support interrupts for which the EOI operation
+	 * is an OPAL call followed by a write to XIRR, since that's
+	 * what our real-mode EOI code does.
+	 */
+	chip = irq_data_get_irq_chip(&desc->irq_data);
+	if (!chip || !is_pnv_opal_msi(chip)) {
+		pr_warn("kvmppc_set_passthru_irq_hv: Could not assign IRQ map for (%d,%d)\n",
+			host_irq, guest_gsi);
+		mutex_unlock(&kvm->lock);
+		return -ENOENT;
+	}
+
+	/*
+	 * See if we already have an entry for this guest IRQ number.
+	 * If it's mapped to a hardware IRQ number, that's an error,
+	 * otherwise re-use this entry.
+	 */
+	for (i = 0; i < pimap->n_mapped; i++) {
+		if (guest_gsi == pimap->mapped[i].v_hwirq) {
+			if (pimap->mapped[i].r_hwirq) {
+				mutex_unlock(&kvm->lock);
+				return -EINVAL;
+			}
+			break;
+		}
+	}
+
+	if (i == KVMPPC_PIRQ_MAPPED) {
+		mutex_unlock(&kvm->lock);
+		return -EAGAIN;		/* table is full */
+	}
+
+	irq_map = &pimap->mapped[i];
+
+	irq_map->v_hwirq = guest_gsi;
+	irq_map->r_hwirq = desc->irq_data.hwirq;
+	irq_map->desc = desc;
+
+	if (i == pimap->n_mapped)
+		pimap->n_mapped++;
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
+	/* invalidate the entry */
+	pimap->mapped[i].r_hwirq = 0;
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
@@ -3413,6 +3567,10 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.fast_vcpu_kick = kvmppc_fast_vcpu_kick_hv,
 	.arch_vm_ioctl  = kvm_arch_vm_ioctl_hv,
 	.hcall_implemented = kvmppc_hcall_impl_hv,
+#ifdef CONFIG_KVM_XICS
+	.irq_bypass_add_producer = kvmppc_irq_bypass_add_producer_hv,
+	.irq_bypass_del_producer = kvmppc_irq_bypass_del_producer_hv,
+#endif
 };
 
 static int kvm_init_subcore_bitmap(void)
-- 
2.8.1
