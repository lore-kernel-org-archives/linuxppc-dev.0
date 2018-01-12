Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHn6x082PzF0Sg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:40:56 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v4 1/6] powerpc/kvm/xive: Add more debugfs queues info
Date: Fri, 12 Jan 2018 13:37:11 +1100
Message-Id: <20180112023716.9963-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add details about enabled queues and escalation interrupts

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kvm/book3s_xive.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 0d750d274c4e..cd21c891be9e 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1795,6 +1795,7 @@ static int xive_debug_show(struct seq_file *m, void *private)
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+		unsigned int i;
 
 		if (!xc)
 			continue;
@@ -1804,6 +1805,33 @@ static int xive_debug_show(struct seq_file *m, void *private)
 			   xc->server_num, xc->cppr, xc->hw_cppr,
 			   xc->mfrr, xc->pending,
 			   xc->stat_rm_h_xirr, xc->stat_vm_h_xirr);
+		for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
+			struct xive_q *q = &xc->queues[i];
+			u32 i0, i1, idx;
+
+			if (!q->qpage && !xc->esc_virq[i])
+				continue;
+
+			seq_printf(m, " [q%d]: ", i);
+
+			if (q->qpage) {
+				idx = q->idx;
+				i0 = be32_to_cpup(q->qpage + idx);
+				idx = (idx + 1) & q->msk;
+				i1 = be32_to_cpup(q->qpage + idx);
+				seq_printf(m, "T=%d %08x %08x... \n", q->toggle, i0, i1);
+			}
+			if (xc->esc_virq[i]) {
+				struct irq_data *d = irq_get_irq_data(xc->esc_virq[i]);
+				struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
+				u64 pq = xive_vm_esb_load(xd, XIVE_ESB_GET);
+				seq_printf(m, "E:%c%c I(%d:%llx:%llx)",
+					   (pq & XIVE_ESB_VAL_P) ? 'P' : 'p',
+					   (pq & XIVE_ESB_VAL_Q) ? 'Q' : 'q',
+					   xc->esc_virq[i], pq, xd->eoi_page);
+				seq_printf(m, "\n");
+			}
+		}
 
 		t_rm_h_xirr += xc->stat_rm_h_xirr;
 		t_rm_h_ipoll += xc->stat_rm_h_ipoll;
-- 
2.14.3
