Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09608C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:10:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856A6206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856A6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YQ2F3vHvzDqSS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 06:10:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.172.75; helo=4.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 4.mo2.mail-out.ovh.net (4.mo2.mail-out.ovh.net [87.98.172.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YPsS3LlxzDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 06:02:36 +1100 (AEDT)
Received: from player737.ha.ovh.net (unknown [10.109.143.220])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id E6B93179140
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 19:44:35 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id E73291866383;
 Mon,  7 Jan 2019 18:44:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 04/19] KVM: PPC: Book3S HV: export services for the XIVE
 native exploitation device
Date: Mon,  7 Jan 2019 19:43:16 +0100
Message-Id: <20190107184331.8429-5-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11390447883591388119
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

The KVM device for the XIVE native exploitation mode will reuse the
structures of the XICS-over-XIVE glue implementation. Some code will
also be shared : source block creation and destruction, target
selection and escalation attachment.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/kvm/book3s_xive.h | 11 +++++
 arch/powerpc/kvm/book3s_xive.c | 89 +++++++++++++++++++---------------
 2 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index a08ae6fd4c51..10c4aa5cd010 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -248,5 +248,16 @@ extern int (*__xive_vm_h_ipi)(struct kvm_vcpu *vcpu, unsigned long server,
 extern int (*__xive_vm_h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr);
 extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
 
+/*
+ * Common Xive routines for XICS-over-XIVE and XIVE native
+ */
+struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
+	struct kvmppc_xive *xive, int irq);
+void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
+int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
+void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
+int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio);
+int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu);
+
 #endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 8a4fa45f07f8..bb5d32f7e4e6 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -166,7 +166,7 @@ static irqreturn_t xive_esc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
+int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
 	struct xive_q *q = &xc->queues[prio];
@@ -291,7 +291,7 @@ static int xive_check_provisioning(struct kvm *kvm, u8 prio)
 			continue;
 		rc = xive_provision_queue(vcpu, prio);
 		if (rc == 0 && !xive->single_escalation)
-			xive_attach_escalation(vcpu, prio);
+			kvmppc_xive_attach_escalation(vcpu, prio);
 		if (rc)
 			return rc;
 	}
@@ -342,7 +342,7 @@ static int xive_try_pick_queue(struct kvm_vcpu *vcpu, u8 prio)
 	return atomic_add_unless(&q->count, 1, max) ? 0 : -EBUSY;
 }
 
-static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
+int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
 {
 	struct kvm_vcpu *vcpu;
 	int i, rc;
@@ -535,7 +535,7 @@ static int xive_target_interrupt(struct kvm *kvm,
 	 * priority. The count for that new target will have
 	 * already been incremented.
 	 */
-	rc = xive_select_target(kvm, &server, prio);
+	rc = kvmppc_xive_select_target(kvm, &server, prio);
 
 	/*
 	 * We failed to find a target ? Not much we can do
@@ -1055,7 +1055,7 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
 }
 EXPORT_SYMBOL_GPL(kvmppc_xive_clr_mapped);
 
-static void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
+void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
 	struct kvm *kvm = vcpu->kvm;
@@ -1225,7 +1225,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 		if (xive->qmap & (1 << i)) {
 			r = xive_provision_queue(vcpu, i);
 			if (r == 0 && !xive->single_escalation)
-				xive_attach_escalation(vcpu, i);
+				kvmppc_xive_attach_escalation(vcpu, i);
 			if (r)
 				goto bail;
 		} else {
@@ -1240,7 +1240,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 	}
 
 	/* If not done above, attach priority 0 escalation */
-	r = xive_attach_escalation(vcpu, 0);
+	r = kvmppc_xive_attach_escalation(vcpu, 0);
 	if (r)
 		goto bail;
 
@@ -1491,8 +1491,8 @@ static int xive_get_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	return 0;
 }
 
-static struct kvmppc_xive_src_block *xive_create_src_block(struct kvmppc_xive *xive,
-							   int irq)
+struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
+	struct kvmppc_xive *xive, int irq)
 {
 	struct kvm *kvm = xive->kvm;
 	struct kvmppc_xive_src_block *sb;
@@ -1571,7 +1571,7 @@ static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	sb = kvmppc_xive_find_source(xive, irq, &idx);
 	if (!sb) {
 		pr_devel("No source, creating source block...\n");
-		sb = xive_create_src_block(xive, irq);
+		sb = kvmppc_xive_create_src_block(xive, irq);
 		if (!sb) {
 			pr_devel("Failed to create block...\n");
 			return -ENOMEM;
@@ -1795,7 +1795,7 @@ static void kvmppc_xive_cleanup_irq(u32 hw_num, struct xive_irq_data *xd)
 	xive_cleanup_irq_data(xd);
 }
 
-static void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
+void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
 {
 	int i;
 
@@ -1824,6 +1824,8 @@ static void kvmppc_xive_free(struct kvm_device *dev)
 
 	debugfs_remove(xive->dentry);
 
+	pr_devel("Destroying xive for partition\n");
+
 	if (kvm)
 		kvm->arch.xive = NULL;
 
@@ -1889,6 +1891,43 @@ static int kvmppc_xive_create(struct kvm_device *dev, u32 type)
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
@@ -1914,7 +1953,6 @@ static int xive_debug_show(struct seq_file *m, void *private)
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
-		unsigned int i;
 
 		if (!xc)
 			continue;
@@ -1924,33 +1962,8 @@ static int xive_debug_show(struct seq_file *m, void *private)
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
-- 
2.20.1

