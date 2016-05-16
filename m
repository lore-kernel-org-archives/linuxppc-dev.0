Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7WWt1RvxzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 16:58:33 +1000 (AEST)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 16 May 2016 07:58:27 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 492352190056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 07:58:00 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4G6wPZO61341748
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 06:58:25 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4G6wOL5021428
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 00:58:25 -0600
Message-ID: <1463381898.19947.6.camel@TP420>
Subject: [RFC PATCH 1/2] KVM: PPC: divide the ics lock into smaller ones for
 each irq
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org, PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Cc: agraf@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul
 Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 16 May 2016 14:58:18 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch tries to use smaller locks for each irq in the ics, instead
of a lock at the ics level, to provide better scalability.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 24 ++++++++++-----------
 arch/powerpc/kvm/book3s_xics.c       | 41 +++++++++++++++++++-----------------
 arch/powerpc/kvm/book3s_xics.h       |  2 +-
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 980d8a6..c3f604e 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -36,20 +36,19 @@ static void ics_rm_check_resend(struct kvmppc_xics *xics,
 {
 	int i;
 
-	arch_spin_lock(&ics->lock);
-
 	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
 		struct ics_irq_state *state = &ics->irq_state[i];
 
-		if (!state->resend)
+		arch_spin_lock(&state->lock);
+
+		if (!state->resend) {
+			arch_spin_unlock(&state->lock);
 			continue;
+		}
 
-		arch_spin_unlock(&ics->lock);
+		arch_spin_unlock(&state->lock);
 		icp_rm_deliver_irq(xics, icp, state->number);
-		arch_spin_lock(&ics->lock);
 	}
-
-	arch_spin_unlock(&ics->lock);
 }
 
 /* -- ICP routines -- */
@@ -310,8 +309,7 @@ static void icp_rm_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 	}
 	state = &ics->irq_state[src];
 
-	/* Get a lock on the ICS */
-	arch_spin_lock(&ics->lock);
+	arch_spin_lock(&state->lock);
 
 	/* Get our server */
 	if (!icp || state->server != icp->server_num) {
@@ -367,7 +365,7 @@ static void icp_rm_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 		 * Delivery was successful, did we reject somebody else ?
 		 */
 		if (reject && reject != XICS_IPI) {
-			arch_spin_unlock(&ics->lock);
+			arch_spin_unlock(&state->lock);
 			new_irq = reject;
 			goto again;
 		}
@@ -387,12 +385,12 @@ static void icp_rm_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 		 */
 		smp_mb();
 		if (!icp->state.need_resend) {
-			arch_spin_unlock(&ics->lock);
+			arch_spin_unlock(&state->lock);
 			goto again;
 		}
 	}
- out:
-	arch_spin_unlock(&ics->lock);
+out:
+	arch_spin_unlock(&state->lock);
 }
 
 static void icp_rm_down_cppr(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 46871d5..b9dbf75 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -113,25 +113,26 @@ static void ics_check_resend(struct kvmppc_xics *xics, struct kvmppc_ics *ics,
 	unsigned long flags;
 
 	local_irq_save(flags);
-	arch_spin_lock(&ics->lock);
 
 	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
 		struct ics_irq_state *state = &ics->irq_state[i];
 
-		if (!state->resend)
+		arch_spin_lock(&state->lock);
+
+		if (!state->resend) {
+			arch_spin_unlock(&state->lock);
 			continue;
+		}
 
 		XICS_DBG("resend %#x prio %#x\n", state->number,
 			      state->priority);
 
-		arch_spin_unlock(&ics->lock);
+		arch_spin_unlock(&state->lock);
 		local_irq_restore(flags);
 		icp_deliver_irq(xics, icp, state->number);
 		local_irq_save(flags);
-		arch_spin_lock(&ics->lock);
 	}
 
-	arch_spin_unlock(&ics->lock);
 	local_irq_restore(flags);
 }
 
@@ -143,7 +144,7 @@ static bool write_xive(struct kvmppc_xics *xics, struct kvmppc_ics *ics,
 	unsigned long flags;
 
 	local_irq_save(flags);
-	arch_spin_lock(&ics->lock);
+	arch_spin_lock(&state->lock);
 
 	state->server = server;
 	state->priority = priority;
@@ -154,7 +155,7 @@ static bool write_xive(struct kvmppc_xics *xics, struct kvmppc_ics *ics,
 		deliver = true;
 	}
 
-	arch_spin_unlock(&ics->lock);
+	arch_spin_unlock(&state->lock);
 	local_irq_restore(flags);
 
 	return deliver;
@@ -207,10 +208,10 @@ int kvmppc_xics_get_xive(struct kvm *kvm, u32 irq, u32 *server, u32 *priority)
 	state = &ics->irq_state[src];
 
 	local_irq_save(flags);
-	arch_spin_lock(&ics->lock);
+	arch_spin_lock(&state->lock);
 	*server = state->server;
 	*priority = state->priority;
-	arch_spin_unlock(&ics->lock);
+	arch_spin_unlock(&state->lock);
 	local_irq_restore(flags);
 
 	return 0;
@@ -406,7 +407,7 @@ static void icp_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 
 	/* Get a lock on the ICS */
 	local_irq_save(flags);
-	arch_spin_lock(&ics->lock);
+	arch_spin_lock(&state->lock);
 
 	/* Get our server */
 	if (!icp || state->server != icp->server_num) {
@@ -463,7 +464,7 @@ static void icp_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 		 * Delivery was successful, did we reject somebody else ?
 		 */
 		if (reject && reject != XICS_IPI) {
-			arch_spin_unlock(&ics->lock);
+			arch_spin_unlock(&state->lock);
 			local_irq_restore(flags);
 			new_irq = reject;
 			goto again;
@@ -484,13 +485,13 @@ static void icp_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 		 */
 		smp_mb();
 		if (!icp->state.need_resend) {
-			arch_spin_unlock(&ics->lock);
+			arch_spin_unlock(&state->lock);
 			local_irq_restore(flags);
 			goto again;
 		}
 	}
  out:
-	arch_spin_unlock(&ics->lock);
+	arch_spin_unlock(&state->lock);
 	local_irq_restore(flags);
 }
 
@@ -950,18 +951,18 @@ static int xics_debug_show(struct seq_file *m, void *private)
 			   icsid);
 
 		local_irq_save(flags);
-		arch_spin_lock(&ics->lock);
 
 		for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
 			struct ics_irq_state *irq = &ics->irq_state[i];
+			arch_spin_lock(&irq->lock);
 
 			seq_printf(m, "irq 0x%06x: server %#x prio %#x save prio %#x asserted %d resend %d masked pending %d\n",
 				   irq->number, irq->server, irq->priority,
 				   irq->saved_priority, irq->asserted,
 				   irq->resend, irq->masked_pending);
+			arch_spin_unlock(&irq->lock);
 
 		}
-		arch_spin_unlock(&ics->lock);
 		local_irq_restore(flags);
 	}
 	return 0;
@@ -1021,6 +1022,8 @@ static struct kvmppc_ics *kvmppc_xics_create_ics(struct kvm *kvm,
 		ics->irq_state[i].number = (icsid << KVMPPC_XICS_ICS_SHIFT) | i;
 		ics->irq_state[i].priority = MASKED;
 		ics->irq_state[i].saved_priority = MASKED;
+		ics->irq_state[i].lock =
+			(arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 	}
 	smp_wmb();
 	xics->ics[icsid] = ics;
@@ -1164,7 +1167,7 @@ static int xics_get_source(struct kvmppc_xics *xics, long irq, u64 addr)
 
 	irqp = &ics->irq_state[idx];
 	local_irq_save(flags);
-	arch_spin_lock(&ics->lock);
+	arch_spin_lock(&irqp->lock);
 	ret = -ENOENT;
 	if (irqp->exists) {
 		val = irqp->server;
@@ -1180,7 +1183,7 @@ static int xics_get_source(struct kvmppc_xics *xics, long irq, u64 addr)
 			val |= KVM_XICS_PENDING;
 		ret = 0;
 	}
-	arch_spin_unlock(&ics->lock);
+	arch_spin_unlock(&irqp->lock);
 	local_irq_restore(flags);
 
 	if (!ret && put_user(val, ubufp))
@@ -1220,7 +1223,7 @@ static int xics_set_source(struct kvmppc_xics *xics, long irq, u64 addr)
 		return -EINVAL;
 
 	local_irq_save(flags);
-	arch_spin_lock(&ics->lock);
+	arch_spin_lock(&irqp->lock);
 	irqp->server = server;
 	irqp->saved_priority = prio;
 	if (val & KVM_XICS_MASKED)
@@ -1232,7 +1235,7 @@ static int xics_set_source(struct kvmppc_xics *xics, long irq, u64 addr)
 	if ((val & KVM_XICS_PENDING) && (val & KVM_XICS_LEVEL_SENSITIVE))
 		irqp->asserted = 1;
 	irqp->exists = 1;
-	arch_spin_unlock(&ics->lock);
+	arch_spin_unlock(&irqp->lock);
 	local_irq_restore(flags);
 
 	if (val & KVM_XICS_PENDING)
diff --git a/arch/powerpc/kvm/book3s_xics.h b/arch/powerpc/kvm/book3s_xics.h
index 56ea44f..d30564b 100644
--- a/arch/powerpc/kvm/book3s_xics.h
+++ b/arch/powerpc/kvm/book3s_xics.h
@@ -33,6 +33,7 @@
 
 /* State for one irq source */
 struct ics_irq_state {
+	arch_spinlock_t lock;
 	u32 number;
 	u32 server;
 	u8  priority;
@@ -93,7 +94,6 @@ struct kvmppc_icp {
 };
 
 struct kvmppc_ics {
-	arch_spinlock_t lock;
 	u16 icsid;
 	struct ics_irq_state irq_state[KVMPPC_XICS_IRQ_PER_ICS];
 };
-- 
1.8.3.1
