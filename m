Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7WpX1bwyzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 17:11:15 +1000 (AEST)
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 16 May 2016 08:11:12 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 321C231300B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 08:03:19 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4G72JtA7012782
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 07:02:19 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4G72JGG012964
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 03:02:19 -0400
Message-ID: <1463382133.19947.10.camel@TP420>
Subject: [RFC PATCH 2/2] KVM: PPC: Don't take lock when check irq's resend flag
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org, PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Cc: agraf@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul
 Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Boqun
 Feng <boqun.feng@linux.vnet.ibm.com>
Date: Mon, 16 May 2016 15:02:13 +0800
In-Reply-To: <1463381898.19947.6.camel@TP420>
References: <1463381898.19947.6.camel@TP420>
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

It seems that we don't need to take the lock before evaluating irq's
resend flag. What needed is to make sure when we clear the ics's bit
in the icp's resend_map, we don't miss the resend flag of the irqs
that set the bit.

And seems this could be ordered through the barrier in test_and_clear_bit(),
and an newly added wmb when setting irq's resend flag, and icp's resend_map.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 14 +++++++-------
 arch/powerpc/kvm/book3s_xics.c       | 22 +++++++---------------
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index c3f604e..c3fa386 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -39,14 +39,9 @@ static void ics_rm_check_resend(struct kvmppc_xics *xics,
 	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
 		struct ics_irq_state *state = &ics->irq_state[i];
 
-		arch_spin_lock(&state->lock);
-
-		if (!state->resend) {
-			arch_spin_unlock(&state->lock);
+		if (!state->resend)
 			continue;
-		}
 
-		arch_spin_unlock(&state->lock);
 		icp_rm_deliver_irq(xics, icp, state->number);
 	}
 }
@@ -374,8 +369,13 @@ static void icp_rm_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 		 * We failed to deliver the interrupt we need to set the
 		 * resend map bit and mark the ICS state as needing a resend
 		 */
-		set_bit(ics->icsid, icp->resend_map);
 		state->resend = 1;
+		/*
+		 * Make sure when checking resend, we don't miss the resend if
+		 * resend_map bit is seen and cleared.
+		 */
+		smp_wmb();
+		set_bit(ics->icsid, icp->resend_map);
 
 		/*
 		 * If the need_resend flag got cleared in the ICP some time
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index b9dbf75..420c4fc 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -110,30 +110,17 @@ static void ics_check_resend(struct kvmppc_xics *xics, struct kvmppc_ics *ics,
 {
 	int i;
 
-	unsigned long flags;
-
-	local_irq_save(flags);
-
 	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
 		struct ics_irq_state *state = &ics->irq_state[i];
 
-		arch_spin_lock(&state->lock);
-
-		if (!state->resend) {
-			arch_spin_unlock(&state->lock);
+		if (!state->resend)
 			continue;
-		}
 
 		XICS_DBG("resend %#x prio %#x\n", state->number,
 			      state->priority);
 
-		arch_spin_unlock(&state->lock);
-		local_irq_restore(flags);
 		icp_deliver_irq(xics, icp, state->number);
-		local_irq_save(flags);
 	}
-
-	local_irq_restore(flags);
 }
 
 static bool write_xive(struct kvmppc_xics *xics, struct kvmppc_ics *ics,
@@ -474,8 +461,13 @@ static void icp_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 		 * We failed to deliver the interrupt we need to set the
 		 * resend map bit and mark the ICS state as needing a resend
 		 */
-		set_bit(ics->icsid, icp->resend_map);
 		state->resend = 1;
+		/*
+		 * Make sure when checking resend, we don't miss the resend if
+		 * resend_map bit is seen and cleared.
+		 */
+		smp_wmb();
+		set_bit(ics->icsid, icp->resend_map);
 
 		/*
 		 * If the need_resend flag got cleared in the ICP some time
-- 
1.8.3.1
