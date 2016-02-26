Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB3131A0B7D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:41:19 +1100 (AEDT)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29584140307
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:18 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:41:17 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2C1451FF002E
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:29:24 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIfEfA44302536
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:14 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIfDYQ017610
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:14 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 06/14] KVM: PPC: Book3S HV: Caching for passthrough IRQ map
Date: Fri, 26 Feb 2016 12:40:24 -0600
Message-Id: <1456512032-31286-7-git-send-email-warrier@linux.vnet.ibm.com>
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

Add the following functions to support caching of the
IRQ mapped entries:

kvmppc_cache_passthru_irq()
  Caches an existing mapping in the cached array.

_uncache_passthru_irq()
  Uncaches a cached entry. This is an internal function and
  is only invoked when unmapping a passthrough IRQ mapping.
  There is no support to just uncache an entry.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h |  1 +
 arch/powerpc/kvm/book3s_hv.c       | 97 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 75d4c64..4107f7f 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -291,6 +291,7 @@ struct kvmppc_ops {
 				       struct irq_bypass_producer *);
 	void (*irq_bypass_del_producer)(struct irq_bypass_consumer *,
 					struct irq_bypass_producer *);
+	int (*cache_passthru_irq)(struct kvm *kvm, int irq);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 4d802b8..97150f0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3297,6 +3297,95 @@ static struct kvmppc_passthru_irqmap *kvmppc_alloc_pimap(struct irq_desc *desc)
 	return pimap;
 }
 
+/*
+ * Cache a passthrough IRQ
+ * This is accomplished by copying the IRQ details from the
+ * mapped array to the cached array.
+ *
+ * Return:
+ *	0:  if this was accomplished successfully
+ *	1:  if the caching could not be done
+ */
+static int kvmppc_cache_passthru_irq_hv(struct kvm *kvm, int irq)
+{
+	struct kvmppc_passthru_irqmap *pimap;
+	int cidx, midx;
+
+	mutex_lock(&kvm->lock);
+
+	if (kvm->arch.pimap == NULL)
+		goto err_out;
+
+	pimap = kvm->arch.pimap;
+
+	/* Look for first empty slot */
+	for (cidx = 0; cidx < KVMPPC_PIRQ_CACHED; cidx++)
+		if (pimap->cached[cidx].r_hwirq == 0)
+			break;
+
+	/* Out of empty cache slots */
+	if (cidx == KVMPPC_PIRQ_CACHED)
+		goto err_out;
+
+	/* Find entry in the mapped array */
+	for (midx = 0; midx < pimap->n_mapped; midx++) {
+		if (irq == pimap->mapped[midx].v_hwirq)
+			break;
+	}
+
+	/* IRQ not found */
+	if (midx == pimap->n_mapped)
+		goto err_out;
+
+	if (pimap->mapped[midx].r_hwirq == 0)
+		/* Someone beat us to caching the IRQ */
+		goto err_out;
+
+	pimap->cached[cidx].v_hwirq = pimap->mapped[midx].v_hwirq;
+	pimap->cached[cidx].desc = pimap->mapped[midx].desc;
+	pimap->cached[cidx].r_hwirq = pimap->mapped[midx].r_hwirq;
+
+	if (cidx >= pimap->n_cached)
+		pimap->n_cached = cidx + 1;
+
+	/* r_hwirq == 0 in mapped array to indicate a cached IRQ */
+	pimap->mapped[midx].r_hwirq = 0;
+
+	mutex_unlock(&kvm->lock);
+	return 0;
+
+err_out:
+	mutex_unlock(&kvm->lock);
+	return 1;
+}
+
+/* Called with kvm->lock already acquired */
+static void _uncache_passthru_irq(struct kvmppc_passthru_irqmap *pimap, int irq)
+{
+	int i;
+
+	for (i = 0; i < pimap->n_cached; i++) {
+		if (irq == pimap->cached[i].v_hwirq) {
+
+			/*
+			 * Zero out the IRQ being uncached.
+			 */
+			pimap->cached[i].r_hwirq = 0;
+			pimap->cached[i].v_hwirq = 0;
+			pimap->cached[i].desc = NULL;
+
+			/*
+			 * Only need to decrement maximum cached count if
+			 * this is the highest entry being uncached.
+			 */
+			if (i + 1 == pimap->n_cached)
+				pimap->n_cached--;
+			return;
+		}
+	}
+
+}
+
 static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 {
 	struct irq_desc *desc;
@@ -3391,6 +3480,13 @@ static int kvmppc_clr_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	}
 
 	/*
+	 * If this is a cached IRQ, remove it from the cached array also
+	 * mapped.r_hwirq is set to zero when we cache an entry.
+	 */
+	if (!pimap->mapped[i].r_hwirq)
+		_uncache_passthru_irq(pimap, guest_gsi);
+
+	/*
 	 * Replace mapped entry to be cleared with highest entry (unless
 	 * this is already the highest) so as to not leave any holes in
 	 * the array of mapped.
@@ -3567,6 +3663,7 @@ static struct kvmppc_ops kvm_ops_hv = {
 #ifdef CONFIG_KVM_XICS
 	.irq_bypass_add_producer = kvmppc_irq_bypass_add_producer_hv,
 	.irq_bypass_del_producer = kvmppc_irq_bypass_del_producer_hv,
+	.cache_passthru_irq = kvmppc_cache_passthru_irq_hv,
 #endif
 };
 
-- 
1.8.3.4
