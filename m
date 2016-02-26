Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A09D71A0B6A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:41:40 +1100 (AEDT)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CBEFA14032B
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:38 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:41:36 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B51CE19D8061
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:29:30 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIfXi033947766
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:33 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIfWbD018863
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:33 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 09/14] KVM: PPC: Book3S HV: Enable KVM real mode handling of
 passthrough IRQs
Date: Fri, 26 Feb 2016 12:40:27 -0600
Message-Id: <1456512032-31286-10-git-send-email-warrier@linux.vnet.ibm.com>
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

The KVM real mode passthrough handling code only searches for
"cached" IRQ maps in the passthrough IRQ map when checking for
passthrough IRQs that can be redirected to the guest.
This patch enables KVM real mode handling of passthrough IRQs
by turning on caching of selected passthrough IRQs. Currently,
we follow a simple method and cache any passthrough IRQ when its
virtual IRQ is first injected into the guest.

Since we have a limit of 16 cache entries per guest, this will
limit passthrough IRQs that are handled in KVM real mode to 16.
This should work well for the general case for VMs with small
number of passthrough adapters or SRIOV VFs. In the future, we
can increase the number of cached entries, but we would then need
to come up with faster search/filtering mechanisms for an IRQ in
the map of cached passthrough IRQs.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/include/asm/kvm_ppc.h  |  2 ++
 arch/powerpc/kvm/book3s.c           | 10 +++++++++
 arch/powerpc/kvm/book3s_hv.c        |  4 ++++
 arch/powerpc/kvm/book3s_xics.c      | 41 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_xics.h      |  2 ++
 6 files changed, 60 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fc10248..558d195 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -63,6 +63,7 @@ extern int kvm_unmap_hva_range(struct kvm *kvm,
 extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 extern int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 extern void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+extern int kvmppc_cache_passthru_irq(struct kvm *kvm, int guest_gsi);
 
 static inline void kvm_arch_mmu_notifier_invalidate_page(struct kvm *kvm,
 							 unsigned long address)
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index b19bb30..93531cc 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -484,6 +484,8 @@ extern int kvmppc_xics_set_icp(struct kvm_vcpu *vcpu, u64 icpval);
 extern int kvmppc_xics_connect_vcpu(struct kvm_device *dev,
 			struct kvm_vcpu *vcpu, u32 cpu);
 extern void kvmppc_xics_ipi_action(void);
+extern void kvmppc_xics_set_mapped(struct kvm *kvm, unsigned long irq);
+extern void kvmppc_xics_clr_mapped(struct kvm *kvm, unsigned long irq);
 extern int h_ipi_redirect;
 #else
 static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 2492b7e..1b4f5bd 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -953,6 +953,16 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 		kvm->arch.kvm_ops->irq_bypass_del_producer(cons, prod);
 }
 
+int kvmppc_cache_passthru_irq(struct kvm *kvm, int irq)
+{
+	int r = 0;
+
+	if (kvm->arch.kvm_ops->cache_passthru_irq)
+		r = kvm->arch.kvm_ops->cache_passthru_irq(kvm, irq);
+
+	return r;
+}
+
 static int kvmppc_book3s_init(void)
 {
 	int r;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index cc5aea96..487657f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3468,6 +3468,8 @@ static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 
 	pimap->n_mapped++;
 
+	kvmppc_xics_set_mapped(kvm, guest_gsi);
+
 	if (!kvm->arch.pimap)
 		kvm->arch.pimap = pimap;
 
@@ -3522,6 +3524,8 @@ static int kvmppc_clr_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	if (i != pimap->n_mapped)
 		pimap->mapped[i] = pimap->mapped[pimap->n_mapped];
 
+	kvmppc_xics_clr_mapped(kvm, guest_gsi);
+
 	/*
 	 * We don't free this structure even when the count goes to
 	 * zero. The structure is freed when we destroy the VM.
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index be23f88..b90570c 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -88,6 +88,18 @@ static int ics_deliver_irq(struct kvmppc_xics *xics, u32 irq, u32 level)
 		return -EINVAL;
 
 	/*
+	 * If this is a mapped passthrough IRQ that is not cached,
+	 * add this to the IRQ cached map so that real mode KVM
+	 * will redirect this directly to the guest where possible.
+	 * Currently, we will cache a passthrough IRQ the first time
+	 * we  inject it into the guest.
+	 */
+	if (state->pmapped && !state->pcached) {
+		if (kvmppc_cache_passthru_irq(xics->kvm, irq) == 0)
+			state->pcached = 1;
+	}
+
+	/*
 	 * We set state->asserted locklessly. This should be fine as
 	 * we are the only setter, thus concurrent access is undefined
 	 * to begin with.
@@ -1410,3 +1422,32 @@ int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
 {
 	return pin;
 }
+
+void kvmppc_xics_set_mapped(struct kvm *kvm, unsigned long irq)
+{
+	struct kvmppc_xics *xics = kvm->arch.xics;
+	struct kvmppc_ics *ics;
+	u16 idx;
+
+	ics = kvmppc_xics_find_ics(xics, irq, &idx);
+	if (!ics)
+		return;
+
+	ics->irq_state[idx].pmapped = 1;
+}
+EXPORT_SYMBOL_GPL(kvmppc_xics_set_mapped);
+
+void kvmppc_xics_clr_mapped(struct kvm *kvm, unsigned long irq)
+{
+	struct kvmppc_xics *xics = kvm->arch.xics;
+	struct kvmppc_ics *ics;
+	u16 idx;
+
+	ics = kvmppc_xics_find_ics(xics, irq, &idx);
+	if (!ics)
+		return;
+
+	ics->irq_state[idx].pmapped = 0;
+	ics->irq_state[idx].pcached = 0;
+}
+EXPORT_SYMBOL_GPL(kvmppc_xics_clr_mapped);
diff --git a/arch/powerpc/kvm/book3s_xics.h b/arch/powerpc/kvm/book3s_xics.h
index 56ea44f..de560f1 100644
--- a/arch/powerpc/kvm/book3s_xics.h
+++ b/arch/powerpc/kvm/book3s_xics.h
@@ -41,6 +41,8 @@ struct ics_irq_state {
 	u8  masked_pending;
 	u8  asserted; /* Only for LSI */
 	u8  exists;
+	u8  pmapped;
+	u8  pcached;
 };
 
 /* Atomic ICP state, updated with a single compare & swap */
-- 
1.8.3.4
