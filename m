Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBy0z2bzDrB9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:10 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 12/13] KVM: PPC: Book3S HV: Set server for passed-through
 interrupts
Date: Fri, 19 Aug 2016 15:35:56 +1000
Message-Id: <1471584957-21484-13-git-send-email-paulus@ozlabs.org>
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

When a guest has a PCI pass-through device with an interrupt, it
will direct the interrupt to a particular guest VCPU.  In fact the
physical interrupt might arrive on any CPU, and then get
delivered to the target VCPU in the emulated XICS (guest interrupt
controller), and eventually delivered to the target VCPU.

Now that we have code to handle device interrupts in real mode
without exiting to the host kernel, there is an advantage to having
the device interrupt arrive on the same sub(core) as the target
VCPU is running on.  In this situation, the interrupt can be
delivered to the target VCPU without any exit to the host kernel
(using a hypervisor doorbell interrupt between threads if
necessary).

This patch aims to get passed-through device interrupts arriving
on the correct core by setting the interrupt server in the real
hardware XICS for the interrupt to the first thread in the (sub)core
where its target VCPU is running.  We do this in the real-mode H_EOI
code because the H_EOI handler already needs to look at the
emulated ICS state for the interrupt (whereas the H_XIRR handler
doesn't), and we know we are running in the target VCPU context
at that point.

We set the server CPU in hardware using an OPAL call, regardless of
what the IRQ affinity mask for the interrupt says, and without
updating the affinity mask.  This amounts to saying that when an
interrupt is passed through to a guest, as a matter of policy we
allow the guest's affinity for the interrupt to override the host's.

This is inspired by an earlier patch from Suresh Warrier, although
none of this code came from that earlier patch.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_ppc.h             |  4 +++
 arch/powerpc/include/asm/opal.h                |  1 +
 arch/powerpc/kvm/book3s_hv.c                   |  4 +++
 arch/powerpc/kvm/book3s_hv_rm_xics.c           | 16 ++++++++++++
 arch/powerpc/kvm/book3s_xics.c                 | 35 ++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_xics.h                 |  2 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 7 files changed, 63 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 97b9bad..f6e4964 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -479,6 +479,10 @@ extern int kvmppc_xics_set_icp(struct kvm_vcpu *vcpu, u64 icpval);
 extern int kvmppc_xics_connect_vcpu(struct kvm_device *dev,
 			struct kvm_vcpu *vcpu, u32 cpu);
 extern void kvmppc_xics_ipi_action(void);
+extern void kvmppc_xics_set_mapped(struct kvm *kvm, unsigned long guest_irq,
+				   unsigned long host_irq);
+extern void kvmppc_xics_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
+				   unsigned long host_irq);
 extern long kvmppc_deliver_irq_passthru(struct kvm_vcpu *vcpu, u32 xirr,
 				 struct kvmppc_irq_map *irq_map,
 				 struct kvmppc_passthru_irqmap *pimap);
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ee05bd2..e958b70 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -67,6 +67,7 @@ int64_t opal_pci_config_write_half_word(uint64_t phb_id, uint64_t bus_dev_func,
 int64_t opal_pci_config_write_word(uint64_t phb_id, uint64_t bus_dev_func,
 				   uint64_t offset, uint32_t data);
 int64_t opal_set_xive(uint32_t isn, uint16_t server, uint8_t priority);
+int64_t opal_rm_set_xive(uint32_t isn, uint16_t server, uint8_t priority);
 int64_t opal_get_xive(uint32_t isn, __be16 *server, uint8_t *priority);
 int64_t opal_register_exception_handler(uint64_t opal_exception,
 					uint64_t handler_address,
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2e71518..b969abc 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3385,6 +3385,8 @@ static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	if (i == pimap->n_mapped)
 		pimap->n_mapped++;
 
+	kvmppc_xics_set_mapped(kvm, guest_gsi, desc->irq_data.hwirq);
+
 	mutex_unlock(&kvm->lock);
 
 	return 0;
@@ -3421,6 +3423,8 @@ static int kvmppc_clr_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 		return -ENODEV;
 	}
 
+	kvmppc_xics_clr_mapped(kvm, guest_gsi, pimap->mapped[i].r_hwirq);
+
 	/* invalidate the entry */
 	pimap->mapped[i].r_hwirq = 0;
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 554cdfa..5f7527e 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -22,6 +22,7 @@
 #include <asm/pgtable.h>
 #include <asm/ppc-opcode.h>
 #include <asm/pnv-pci.h>
+#include <asm/opal.h>
 
 #include "book3s_xics.h"
 
@@ -34,6 +35,7 @@ EXPORT_SYMBOL(kvm_irq_bypass);
 
 static void icp_rm_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 			    u32 new_irq);
+static int xics_opal_rm_set_server(unsigned int hw_irq, int server_cpu);
 
 /* -- ICS routines -- */
 static void ics_rm_check_resend(struct kvmppc_xics *xics,
@@ -713,6 +715,13 @@ int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 		icp->rm_action |= XICS_RM_NOTIFY_EOI;
 		icp->rm_eoied_irq = irq;
 	}
+
+	if (state->host_irq && state->intr_cpu != -1) {
+		int pcpu = cpu_first_thread_sibling(raw_smp_processor_id());
+		if (state->intr_cpu != pcpu)
+			xics_opal_rm_set_server(state->host_irq, pcpu);
+		state->intr_cpu = -1;
+	}
  bail:
 	return check_too_hard(xics, icp);
 }
@@ -736,6 +745,13 @@ static void icp_eoi(struct irq_chip *c, u32 hwirq, u32 xirr)
 	_stwcix(xics_phys + XICS_XIRR, xirr);
 }
 
+static int xics_opal_rm_set_server(unsigned int hw_irq, int server_cpu)
+{
+	unsigned int mangle_cpu = get_hard_smp_processor_id(server_cpu) << 2;
+
+	return opal_rm_set_xive(hw_irq, mangle_cpu, DEFAULT_PRIORITY);
+}
+
 /*
  * Increment a per-CPU 32-bit unsigned integer variable.
  * Safe to call in real-mode. Handles vmalloc'ed addresses
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index b41f1d3..222eaf9 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -99,6 +99,10 @@ static int ics_deliver_irq(struct kvmppc_xics *xics, u32 irq, u32 level)
 		return 0;
 	}
 
+	/* Record which CPU this arrived on for passed-through interrupts */
+	if (state->host_irq)
+		state->intr_cpu = raw_smp_processor_id();
+
 	/* Attempt delivery */
 	icp_deliver_irq(xics, NULL, irq);
 
@@ -1436,3 +1440,34 @@ int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
 {
 	return pin;
 }
+
+void kvmppc_xics_set_mapped(struct kvm *kvm, unsigned long irq,
+			    unsigned long host_irq)
+{
+	struct kvmppc_xics *xics = kvm->arch.xics;
+	struct kvmppc_ics *ics;
+	u16 idx;
+
+	ics = kvmppc_xics_find_ics(xics, irq, &idx);
+	if (!ics)
+		return;
+
+	ics->irq_state[idx].host_irq = host_irq;
+	ics->irq_state[idx].intr_cpu = -1;
+}
+EXPORT_SYMBOL_GPL(kvmppc_xics_set_mapped);
+
+void kvmppc_xics_clr_mapped(struct kvm *kvm, unsigned long irq,
+			    unsigned long host_irq)
+{
+	struct kvmppc_xics *xics = kvm->arch.xics;
+	struct kvmppc_ics *ics;
+	u16 idx;
+
+	ics = kvmppc_xics_find_ics(xics, irq, &idx);
+	if (!ics)
+		return;
+
+	ics->irq_state[idx].host_irq = 0;
+}
+EXPORT_SYMBOL_GPL(kvmppc_xics_clr_mapped);
diff --git a/arch/powerpc/kvm/book3s_xics.h b/arch/powerpc/kvm/book3s_xics.h
index a46b954..2a50320 100644
--- a/arch/powerpc/kvm/book3s_xics.h
+++ b/arch/powerpc/kvm/book3s_xics.h
@@ -42,6 +42,8 @@ struct ics_irq_state {
 	u8  lsi;		/* level-sensitive interrupt */
 	u8  asserted; /* Only for LSI */
 	u8  exists;
+	int intr_cpu;
+	u32 host_irq;
 };
 
 /* Atomic ICP state, updated with a single compare & swap */
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3d29d40..44d2d84 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -208,6 +208,7 @@ OPAL_CALL(opal_pci_config_write_byte,		OPAL_PCI_CONFIG_WRITE_BYTE);
 OPAL_CALL(opal_pci_config_write_half_word,	OPAL_PCI_CONFIG_WRITE_HALF_WORD);
 OPAL_CALL(opal_pci_config_write_word,		OPAL_PCI_CONFIG_WRITE_WORD);
 OPAL_CALL(opal_set_xive,			OPAL_SET_XIVE);
+OPAL_CALL_REAL(opal_rm_set_xive,		OPAL_SET_XIVE);
 OPAL_CALL(opal_get_xive,			OPAL_GET_XIVE);
 OPAL_CALL(opal_register_exception_handler,	OPAL_REGISTER_OPAL_EXCEPTION_HANDLER);
 OPAL_CALL(opal_pci_eeh_freeze_status,		OPAL_PCI_EEH_FREEZE_STATUS);
-- 
2.8.1
