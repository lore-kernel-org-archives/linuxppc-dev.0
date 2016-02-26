Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B2041A0B5E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:41:52 +1100 (AEDT)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A09A0140307
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:50 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:41:48 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 122A11FF0025
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:29:53 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIfhhA29950010
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:43 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIffgB019538
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:42 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 10/14] KVM: PPC: Book3S HV: Dump irqmap in debugfs
Date: Fri, 26 Feb 2016 12:40:28 -0600
Message-Id: <1456512032-31286-11-git-send-email-warrier@linux.vnet.ibm.com>
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

Dump the passthrough irqmap structure associated with a
guest as part of /sys/kernel/debug/powerpc/kvm-xics-*.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_xics.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index b90570c..855d669 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -905,6 +905,21 @@ EXPORT_SYMBOL_GPL(kvmppc_xics_hcall);
 
 /* -- Initialisation code etc. -- */
 
+static void xics_debugfs_irqmap(struct seq_file *m,
+				struct kvmppc_passthru_irqmap *pimap)
+{
+	int i;
+
+	if (!pimap)
+		return;
+	seq_printf(m, "========\nPIRQMAP Cache: %d maps\n===========\n",
+				pimap->n_cached);
+	for (i = 0; i < pimap->n_cached; i++)  {
+		seq_printf(m, "r_hwirq=%x, v_hwirq=%x\n",
+			pimap->cached[i].r_hwirq, pimap->cached[i].v_hwirq);
+	}
+}
+
 static int xics_debug_show(struct seq_file *m, void *private)
 {
 	struct kvmppc_xics *xics = m->private;
@@ -926,6 +941,8 @@ static int xics_debug_show(struct seq_file *m, void *private)
 	t_check_resend = 0;
 	t_reject = 0;
 
+	xics_debugfs_irqmap(m, kvm->arch.pimap);
+
 	seq_printf(m, "=========\nICP state\n=========\n");
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-- 
1.8.3.4
