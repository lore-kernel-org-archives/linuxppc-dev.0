Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C3DC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:09:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B026E2082E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B026E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fVxh5D6lzDqMl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:09:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.111.247; helo=4.mo5.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 4.mo5.mail-out.ovh.net (4.mo5.mail-out.ovh.net [178.33.111.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fVsQ1X9BzDqMb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:05:29 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.109.159.20])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id F3AB1229877
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 19:05:23 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 3DA86492A335;
 Wed, 10 Apr 2019 17:05:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 03/16] KVM: PPC: Book3S HV: XIVE: introduce a new
 capability KVM_CAP_PPC_IRQ_XIVE
Date: Wed, 10 Apr 2019 19:04:35 +0200
Message-Id: <20190410170448.3923-4-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410170448.3923-1-clg@kaod.org>
References: <20190410170448.3923-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2473320621105515479
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The user interface exposes a new capability KVM_CAP_PPC_IRQ_XIVE to
let QEMU connect the vCPU presenters to the XIVE KVM device if
required. The capability is not advertised for now as the full support
for the XIVE native exploitation mode is not yet available. When this
is case, the capability will be advertised on PowerNV Hypervisors
only. Nested guests (pseries KVM Hypervisor) are not supported.

Internally, the interface to the new KVM device is protected with a
new interrupt mode: KVMPPC_IRQ_XIVE.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_host.h   |   1 +
 arch/powerpc/include/asm/kvm_ppc.h    |  13 +++
 arch/powerpc/kvm/book3s_xive.h        |  11 ++
 include/uapi/linux/kvm.h              |   1 +
 arch/powerpc/kvm/book3s_xive.c        |  88 ++++++++-------
 arch/powerpc/kvm/book3s_xive_native.c | 150 ++++++++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c            |  36 +++++++
 Documentation/virtual/kvm/api.txt     |   9 ++
 8 files changed, 268 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 008523224e7a..9cc6abdce1b9 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -450,6 +450,7 @@ struct kvmppc_passthru_irqmap {
 #define KVMPPC_IRQ_DEFAULT	0
 #define KVMPPC_IRQ_MPIC		1
 #define KVMPPC_IRQ_XICS		2 /* Includes a XIVE option */
+#define KVMPPC_IRQ_XIVE		3 /* XIVE native exploitation mode */
 
 #define MMIO_HPTE_CACHE_SIZE	4
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index f3383e76017a..6928a35ac3c7 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -595,6 +595,14 @@ extern int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 irq,
 			       int level, bool line_status);
 extern void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu);
 
+static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
+}
+
+extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
+					   struct kvm_vcpu *vcpu, u32 cpu);
+extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
 extern void kvmppc_xive_native_init_module(void);
 extern void kvmppc_xive_native_exit_module(void);
 
@@ -622,6 +630,11 @@ static inline int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 ir
 				      int level, bool line_status) { return -ENODEV; }
 static inline void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu) { }
 
+static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
+	{ return 0; }
+static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
+			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
+static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
 static inline void kvmppc_xive_native_init_module(void) { }
 static inline void kvmppc_xive_native_exit_module(void) { }
 
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index a08ae6fd4c51..d366df69b9cb 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -198,6 +198,11 @@ static inline struct kvmppc_xive_src_block *kvmppc_xive_find_source(struct kvmpp
 	return xive->src_blocks[bid];
 }
 
+static inline u32 kvmppc_xive_vp(struct kvmppc_xive *xive, u32 server)
+{
+	return xive->vp_base + kvmppc_pack_vcpu_id(xive->kvm, server);
+}
+
 /*
  * Mapping between guest priorities and host priorities
  * is as follow.
@@ -248,5 +253,11 @@ extern int (*__xive_vm_h_ipi)(struct kvm_vcpu *vcpu, unsigned long server,
 extern int (*__xive_vm_h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr);
 extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
 
+/*
+ * Common Xive routines for XICS-over-XIVE and XIVE native
+ */
+void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
+int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu);
+
 #endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e6368163d3a0..52bf74a1616e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -988,6 +988,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
 #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
 #define KVM_CAP_HYPERV_CPUID 167
+#define KVM_CAP_PPC_IRQ_XIVE 168
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index f78d002f0fe0..e7f1ada1c3de 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -380,11 +380,6 @@ static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
 	return -EBUSY;
 }
 
-static u32 xive_vp(struct kvmppc_xive *xive, u32 server)
-{
-	return xive->vp_base + kvmppc_pack_vcpu_id(xive->kvm, server);
-}
-
 static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
 			     struct kvmppc_xive_src_block *sb,
 			     struct kvmppc_xive_irq_state *state)
@@ -430,8 +425,8 @@ static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
 	 */
 	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
 		xive_native_configure_irq(hw_num,
-					  xive_vp(xive, state->act_server),
-					  MASKED, state->number);
+				kvmppc_xive_vp(xive, state->act_server),
+				MASKED, state->number);
 		/* set old_p so we can track if an H_EOI was done */
 		state->old_p = true;
 		state->old_q = false;
@@ -486,8 +481,8 @@ static void xive_finish_unmask(struct kvmppc_xive *xive,
 	 */
 	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
 		xive_native_configure_irq(hw_num,
-					  xive_vp(xive, state->act_server),
-					  state->act_priority, state->number);
+				kvmppc_xive_vp(xive, state->act_server),
+				state->act_priority, state->number);
 		/* If an EOI is needed, do it here */
 		if (!state->old_p)
 			xive_vm_source_eoi(hw_num, xd);
@@ -563,7 +558,7 @@ static int xive_target_interrupt(struct kvm *kvm,
 	kvmppc_xive_select_irq(state, &hw_num, NULL);
 
 	return xive_native_configure_irq(hw_num,
-					 xive_vp(xive, server),
+					 kvmppc_xive_vp(xive, server),
 					 prio, state->number);
 }
 
@@ -951,7 +946,7 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
 	 * which is fine for a never started interrupt.
 	 */
 	xive_native_configure_irq(hw_irq,
-				  xive_vp(xive, state->act_server),
+				  kvmppc_xive_vp(xive, state->act_server),
 				  state->act_priority, state->number);
 
 	/*
@@ -1027,7 +1022,7 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
 
 	/* Reconfigure the IPI */
 	xive_native_configure_irq(state->ipi_number,
-				  xive_vp(xive, state->act_server),
+				  kvmppc_xive_vp(xive, state->act_server),
 				  state->act_priority, state->number);
 
 	/*
@@ -1049,7 +1044,7 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
 }
 EXPORT_SYMBOL_GPL(kvmppc_xive_clr_mapped);
 
-static void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
+void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
 	struct kvm *kvm = vcpu->kvm;
@@ -1166,7 +1161,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 	xc->xive = xive;
 	xc->vcpu = vcpu;
 	xc->server_num = cpu;
-	xc->vp_id = xive_vp(xive, cpu);
+	xc->vp_id = kvmppc_xive_vp(xive, cpu);
 	xc->mfrr = 0xff;
 	xc->valid = true;
 
@@ -1883,6 +1878,43 @@ static int kvmppc_xive_create(struct kvm_device *dev, u32 type)
 	return 0;
 }
 
+int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	unsigned int i;
+
+	for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
+		struct xive_q *q = &xc->queues[i];
+		u32 i0, i1, idx;
+
+		if (!q->qpage && !xc->esc_virq[i])
+			continue;
+
+		seq_printf(m, " [q%d]: ", i);
+
+		if (q->qpage) {
+			idx = q->idx;
+			i0 = be32_to_cpup(q->qpage + idx);
+			idx = (idx + 1) & q->msk;
+			i1 = be32_to_cpup(q->qpage + idx);
+			seq_printf(m, "T=%d %08x %08x...\n", q->toggle,
+				   i0, i1);
+		}
+		if (xc->esc_virq[i]) {
+			struct irq_data *d = irq_get_irq_data(xc->esc_virq[i]);
+			struct xive_irq_data *xd =
+				irq_data_get_irq_handler_data(d);
+			u64 pq = xive_vm_esb_load(xd, XIVE_ESB_GET);
+
+			seq_printf(m, "E:%c%c I(%d:%llx:%llx)",
+				   (pq & XIVE_ESB_VAL_P) ? 'P' : 'p',
+				   (pq & XIVE_ESB_VAL_Q) ? 'Q' : 'q',
+				   xc->esc_virq[i], pq, xd->eoi_page);
+			seq_puts(m, "\n");
+		}
+	}
+	return 0;
+}
 
 static int xive_debug_show(struct seq_file *m, void *private)
 {
@@ -1908,7 +1940,6 @@ static int xive_debug_show(struct seq_file *m, void *private)
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
-		unsigned int i;
 
 		if (!xc)
 			continue;
@@ -1918,33 +1949,8 @@ static int xive_debug_show(struct seq_file *m, void *private)
 			   xc->server_num, xc->cppr, xc->hw_cppr,
 			   xc->mfrr, xc->pending,
 			   xc->stat_rm_h_xirr, xc->stat_vm_h_xirr);
-		for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
-			struct xive_q *q = &xc->queues[i];
-			u32 i0, i1, idx;
 
-			if (!q->qpage && !xc->esc_virq[i])
-				continue;
-
-			seq_printf(m, " [q%d]: ", i);
-
-			if (q->qpage) {
-				idx = q->idx;
-				i0 = be32_to_cpup(q->qpage + idx);
-				idx = (idx + 1) & q->msk;
-				i1 = be32_to_cpup(q->qpage + idx);
-				seq_printf(m, "T=%d %08x %08x... \n", q->toggle, i0, i1);
-			}
-			if (xc->esc_virq[i]) {
-				struct irq_data *d = irq_get_irq_data(xc->esc_virq[i]);
-				struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
-				u64 pq = xive_vm_esb_load(xd, XIVE_ESB_GET);
-				seq_printf(m, "E:%c%c I(%d:%llx:%llx)",
-					   (pq & XIVE_ESB_VAL_P) ? 'P' : 'p',
-					   (pq & XIVE_ESB_VAL_Q) ? 'Q' : 'q',
-					   xc->esc_virq[i], pq, xd->eoi_page);
-				seq_printf(m, "\n");
-			}
-		}
+		kvmppc_xive_debug_show_queues(m, vcpu);
 
 		t_rm_h_xirr += xc->stat_rm_h_xirr;
 		t_rm_h_ipoll += xc->stat_rm_h_ipoll;
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 751259394150..6fa73cfd9d9c 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -26,6 +26,134 @@
 
 #include "book3s_xive.h"
 
+static void kvmppc_xive_native_cleanup_queue(struct kvm_vcpu *vcpu, int prio)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct xive_q *q = &xc->queues[prio];
+
+	xive_native_disable_queue(xc->vp_id, q, prio);
+	if (q->qpage) {
+		put_page(virt_to_page(q->qpage));
+		q->qpage = NULL;
+	}
+}
+
+void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	int i;
+
+	if (!kvmppc_xive_enabled(vcpu))
+		return;
+
+	if (!xc)
+		return;
+
+	pr_devel("native_cleanup_vcpu(cpu=%d)\n", xc->server_num);
+
+	/* Ensure no interrupt is still routed to that VP */
+	xc->valid = false;
+	kvmppc_xive_disable_vcpu_interrupts(vcpu);
+
+	/* Disable the VP */
+	xive_native_disable_vp(xc->vp_id);
+
+	/* Free the queues & associated interrupts */
+	for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
+		/* Free the escalation irq */
+		if (xc->esc_virq[i]) {
+			free_irq(xc->esc_virq[i], vcpu);
+			irq_dispose_mapping(xc->esc_virq[i]);
+			kfree(xc->esc_virq_names[i]);
+			xc->esc_virq[i] = 0;
+		}
+
+		/* Free the queue */
+		kvmppc_xive_native_cleanup_queue(vcpu, i);
+	}
+
+	/* Free the VP */
+	kfree(xc);
+
+	/* Cleanup the vcpu */
+	vcpu->arch.irq_type = KVMPPC_IRQ_DEFAULT;
+	vcpu->arch.xive_vcpu = NULL;
+}
+
+int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
+				    struct kvm_vcpu *vcpu, u32 server_num)
+{
+	struct kvmppc_xive *xive = dev->private;
+	struct kvmppc_xive_vcpu *xc = NULL;
+	int rc;
+
+	pr_devel("native_connect_vcpu(server=%d)\n", server_num);
+
+	if (dev->ops != &kvm_xive_native_ops) {
+		pr_devel("Wrong ops !\n");
+		return -EPERM;
+	}
+	if (xive->kvm != vcpu->kvm)
+		return -EPERM;
+	if (vcpu->arch.irq_type != KVMPPC_IRQ_DEFAULT)
+		return -EBUSY;
+	if (server_num >= KVM_MAX_VCPUS) {
+		pr_devel("Out of bounds !\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&vcpu->kvm->lock);
+
+	if (kvmppc_xive_find_server(vcpu->kvm, server_num)) {
+		pr_devel("Duplicate !\n");
+		rc = -EEXIST;
+		goto bail;
+	}
+
+	xc = kzalloc(sizeof(*xc), GFP_KERNEL);
+	if (!xc) {
+		rc = -ENOMEM;
+		goto bail;
+	}
+
+	vcpu->arch.xive_vcpu = xc;
+	xc->xive = xive;
+	xc->vcpu = vcpu;
+	xc->server_num = server_num;
+
+	xc->vp_id = kvmppc_xive_vp(xive, server_num);
+	xc->valid = true;
+	vcpu->arch.irq_type = KVMPPC_IRQ_XIVE;
+
+	rc = xive_native_get_vp_info(xc->vp_id, &xc->vp_cam, &xc->vp_chip_id);
+	if (rc) {
+		pr_err("Failed to get VP info from OPAL: %d\n", rc);
+		goto bail;
+	}
+
+	/*
+	 * Enable the VP first as the single escalation mode will
+	 * affect escalation interrupts numbering
+	 */
+	rc = xive_native_enable_vp(xc->vp_id, xive->single_escalation);
+	if (rc) {
+		pr_err("Failed to enable VP in OPAL: %d\n", rc);
+		goto bail;
+	}
+
+	/* Configure VCPU fields for use by assembly push/pull */
+	vcpu->arch.xive_saved_state.w01 = cpu_to_be64(0xff000000);
+	vcpu->arch.xive_cam_word = cpu_to_be32(xc->vp_cam | TM_QW1W2_VO);
+
+	/* TODO: reset all queues to a clean state ? */
+bail:
+	mutex_unlock(&vcpu->kvm->lock);
+	if (rc)
+		kvmppc_xive_native_cleanup_vcpu(vcpu);
+
+	return rc;
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
@@ -114,10 +242,32 @@ static int xive_native_debug_show(struct seq_file *m, void *private)
 {
 	struct kvmppc_xive *xive = m->private;
 	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
+	unsigned int i;
 
 	if (!kvm)
 		return 0;
 
+	seq_puts(m, "=========\nVCPU state\n=========\n");
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+
+		if (!xc)
+			continue;
+
+		seq_printf(m, "cpu server %#x NSR=%02x CPPR=%02x IBP=%02x PIPR=%02x w01=%016llx w2=%08x\n",
+			   xc->server_num,
+			   vcpu->arch.xive_saved_state.nsr,
+			   vcpu->arch.xive_saved_state.cppr,
+			   vcpu->arch.xive_saved_state.ipb,
+			   vcpu->arch.xive_saved_state.pipr,
+			   vcpu->arch.xive_saved_state.w01,
+			   (u32) vcpu->arch.xive_cam_word);
+
+		kvmppc_xive_debug_show_queues(m, vcpu);
+	}
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 8885377ec3e0..b0858ee61460 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -570,6 +570,15 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PPC_GET_CPU_CHAR:
 		r = 1;
 		break;
+#ifdef CONFIG_KVM_XIVE
+	case KVM_CAP_PPC_IRQ_XIVE:
+		/*
+		 * Return false until all the XIVE infrastructure is
+		 * in place including support for migration.
+		 */
+		r = 0;
+		break;
+#endif
 
 	case KVM_CAP_PPC_ALLOC_HTAB:
 		r = hv_enabled;
@@ -753,6 +762,9 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 		else
 			kvmppc_xics_free_icp(vcpu);
 		break;
+	case KVMPPC_IRQ_XIVE:
+		kvmppc_xive_native_cleanup_vcpu(vcpu);
+		break;
 	}
 
 	kvmppc_core_vcpu_free(vcpu);
@@ -1941,6 +1953,30 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		break;
 	}
 #endif /* CONFIG_KVM_XICS */
+#ifdef CONFIG_KVM_XIVE
+	case KVM_CAP_PPC_IRQ_XIVE: {
+		struct fd f;
+		struct kvm_device *dev;
+
+		r = -EBADF;
+		f = fdget(cap->args[0]);
+		if (!f.file)
+			break;
+
+		r = -ENXIO;
+		if (!xive_enabled())
+			break;
+
+		r = -EPERM;
+		dev = kvm_device_from_filp(f.file);
+		if (dev)
+			r = kvmppc_xive_native_connect_vcpu(dev, vcpu,
+							    cap->args[1]);
+
+		fdput(f);
+		break;
+	}
+#endif /* CONFIG_KVM_XIVE */
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	case KVM_CAP_PPC_FWNMI:
 		r = -EINVAL;
diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 67068c47c591..e38eb17b7be6 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4504,6 +4504,15 @@ struct kvm_sync_regs {
         struct kvm_vcpu_events events;
 };
 
+6.75 KVM_CAP_PPC_IRQ_XIVE
+
+Architectures: ppc
+Target: vcpu
+Parameters: args[0] is the XIVE device fd
+            args[1] is the XIVE CPU number (server ID) for this vcpu
+
+This capability connects the vcpu to an in-kernel XIVE device.
+
 7. Capabilities that can be enabled on VMs
 ------------------------------------------
 
-- 
2.20.1

