Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBx35DxzDrB4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:09 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 09/13] KVM: PPC: Book3S HV: Dump irqmap in debugfs
Date: Fri, 19 Aug 2016 15:35:53 +1000
Message-Id: <1471584957-21484-10-git-send-email-paulus@ozlabs.org>
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

Dump the passthrough irqmap structure associated with a
guest as part of /sys/kernel/debug/powerpc/kvm-xics-*.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_xics.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index d528d22..b41f1d3 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -893,6 +893,21 @@ EXPORT_SYMBOL_GPL(kvmppc_xics_hcall);
 
 /* -- Initialisation code etc. -- */
 
+static void xics_debugfs_irqmap(struct seq_file *m,
+				struct kvmppc_passthru_irqmap *pimap)
+{
+	int i;
+
+	if (!pimap)
+		return;
+	seq_printf(m, "========\nPIRQ mappings: %d maps\n===========\n",
+				pimap->n_mapped);
+	for (i = 0; i < pimap->n_mapped; i++)  {
+		seq_printf(m, "r_hwirq=%x, v_hwirq=%x\n",
+			pimap->mapped[i].r_hwirq, pimap->mapped[i].v_hwirq);
+	}
+}
+
 static int xics_debug_show(struct seq_file *m, void *private)
 {
 	struct kvmppc_xics *xics = m->private;
@@ -914,6 +929,8 @@ static int xics_debug_show(struct seq_file *m, void *private)
 	t_check_resend = 0;
 	t_reject = 0;
 
+	xics_debugfs_irqmap(m, kvm->arch.pimap);
+
 	seq_printf(m, "=========\nICP state\n=========\n");
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-- 
2.8.1
