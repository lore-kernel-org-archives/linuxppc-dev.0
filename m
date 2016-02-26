Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23BC31A0B82
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:42:00 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3655E14030F
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:59 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:41:57 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 840F13E40055
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:54 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIfsck36241552
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:54 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIfrVj020083
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:54 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 13/14] KVM: PPC: Book3S HV: Change affinity for passthrough IRQ
Date: Fri, 26 Feb 2016 12:40:31 -0600
Message-Id: <1456512032-31286-14-git-send-email-warrier@linux.vnet.ibm.com>
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

Change the affinity in the host for a passthrough interrupt
to the hardware thread running the VCPU which has affinity
to this interrupt in the guest. Since the cores run in single
threaded mode on a PowerKVM host, the affinity is actually
changed to the hardware thread's first sibling thread in its
core. This is only done for IRQs that have been mapped for
IRQ bypass since in this case if the interrupt occurs while
the core is in the guest, the real mode KVM will be able
to simply redirect the interrupt to the appropriate sibling
hardware thread.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_builtin.c | 14 +++++--
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 78 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_xics.c       |  7 ++++
 arch/powerpc/kvm/book3s_xics.h       |  3 +-
 4 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 62252da..f95aa63 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -288,8 +288,16 @@ void kvmhv_commence_exit(int trap)
 struct kvmppc_host_rm_ops *kvmppc_host_rm_ops_hv;
 EXPORT_SYMBOL_GPL(kvmppc_host_rm_ops_hv);
 
-static struct kvmppc_irq_map *get_irqmap(struct kvmppc_passthru_irqmap *pimap,
-					 u32 xisr)
+/*
+ * This returns the v_hwirq -> r_hwirq mapping, if any,
+ * when the r_hwirq is passed in as input
+ * There is also the similar get_irqmap_gsi() routine
+ * defined elsewhere, which returns the mapping when passed
+ * the v_hwirq as input.
+ */
+static struct kvmppc_irq_map *get_irqmap_xisr(
+					struct kvmppc_passthru_irqmap *pimap,
+					u32 xisr)
 {
 	int i;
 
@@ -425,7 +433,7 @@ long kvmppc_read_intr(struct kvm_vcpu *vcpu, int path)
 	 */
 	pimap = kvmppc_get_passthru_irqmap(vcpu);
 	if (pimap) {
-		irq_map = get_irqmap(pimap, xisr);
+		irq_map = get_irqmap_xisr(pimap, xisr);
 		if (irq_map) {
 			r = kvmppc_deliver_irq_passthru(vcpu, xirr,
 								irq_map, pimap);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index f33c7cc..e2bbfdf 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -661,6 +661,80 @@ int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr)
 	return check_too_hard(xics, icp);
 }
 
+/*
+ * This returns the v_hwirq -> r_hwirq mapping, if any,
+ * when the v_hwirq is passed in as input
+ * There is also the similar get_irqmap_xisr() routine
+ * defined elsewhere, which returns the mapping when passed
+ * the r_hwirq as input.
+ */
+
+static struct kvmppc_irq_map *get_irqmap_gsi(
+					struct kvmppc_passthru_irqmap *pimap,
+					u32 gsi)
+{
+	int i;
+
+	/*
+	 * We access this array unsafely.
+	 * Read comments in get_irqmap_xisr for details of this
+	 * as well as the need for the memory barrier used below.
+	 */
+	for (i = 0; i < pimap->n_cached; i++)  {
+		if (gsi == pimap->cached[i].v_hwirq) {
+			/*
+			 * Order subsequent reads in the caller to serialize
+			 * with the writer.
+			 */
+			smp_rmb();
+			return &pimap->cached[i];
+		}
+	}
+	return NULL;
+}
+
+unsigned long irq_map_err;
+
+/*
+ * Change affinity to CPU running the target VCPU.
+ */
+static void ics_set_affinity_passthru(struct ics_irq_state *state,
+				      struct kvm_vcpu *vcpu,
+				      u32 irq)
+{
+	struct kvmppc_passthru_irqmap *pimap;
+	struct kvmppc_irq_map *irq_map;
+	struct irq_data *d;
+	s16 intr_cpu;
+	u32 pcpu;
+
+	intr_cpu = state->intr_cpu;
+
+	if  (intr_cpu == -1)
+		return;
+
+	state->intr_cpu = -1;
+
+	pcpu = cpu_first_thread_sibling(raw_smp_processor_id());
+	if (intr_cpu == pcpu)
+		return;
+
+	pimap = kvmppc_get_passthru_irqmap(vcpu);
+	if (likely(pimap)) {
+		irq_map = get_irqmap_gsi(pimap, irq);
+		if (unlikely(!irq_map)) {
+			irq_map_err++;
+			return;
+		}
+		d = irq_desc_get_irq_data(irq_map->desc);
+		if (unlikely(!d->chip->irq_set_affinity))
+			return;
+		d->chip->irq_set_affinity(d, cpumask_of(pcpu), false);
+	} else
+		irq_map_err++;
+
+}
+
 int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 {
 	struct kvmppc_xics *xics = vcpu->kvm->arch.xics;
@@ -713,6 +787,10 @@ int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 		icp->rm_action |= XICS_RM_NOTIFY_EOI;
 		icp->rm_eoied_irq = irq;
 	}
+
+	if (state->pcached)
+		ics_set_affinity_passthru(state, vcpu, irq);
+
  bail:
 	return check_too_hard(xics, icp);
 }
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 855d669..ffaf977 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -93,11 +93,18 @@ static int ics_deliver_irq(struct kvmppc_xics *xics, u32 irq, u32 level)
 	 * will redirect this directly to the guest where possible.
 	 * Currently, we will cache a passthrough IRQ the first time
 	 * we  inject it into the guest.
+	 * Update ICS state only if we successfully mapped the IRQ.
+	 * We check and update ICS fields locklessly:
+	 *	- pcached and mapped fields (in kvmppc_cache_passthru_irq)
+	 *	  are only set once per IRQ.
+	 *	- intr_cpu is only used as a hint
 	 */
 	if (state->pmapped && !state->pcached) {
 		if (kvmppc_cache_passthru_irq(xics->kvm, irq) == 0)
 			state->pcached = 1;
 	}
+	if (state->pcached)
+		state->intr_cpu = raw_smp_processor_id();
 
 	/*
 	 * We set state->asserted locklessly. This should be fine as
diff --git a/arch/powerpc/kvm/book3s_xics.h b/arch/powerpc/kvm/book3s_xics.h
index de560f1..45fec7ac 100644
--- a/arch/powerpc/kvm/book3s_xics.h
+++ b/arch/powerpc/kvm/book3s_xics.h
@@ -41,8 +41,9 @@ struct ics_irq_state {
 	u8  masked_pending;
 	u8  asserted; /* Only for LSI */
 	u8  exists;
-	u8  pmapped;
+	u8  pmapped;  /* Next 3 only for MSI */
 	u8  pcached;
+	s16 intr_cpu;      /* interrupt received on CPU */
 };
 
 /* Atomic ICP state, updated with a single compare & swap */
-- 
1.8.3.4
