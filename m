Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYRQQ2H6vzDrLd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 12:11:09 +1000 (AEST)
Message-ID: <1503022258.4493.133.camel@kernel.crashing.org>
Subject: [PATCH 2/2] kvm/xive: Add missing barriers and document them
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kvm-ppc@vger.kernel.org
Cc: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, paulus@samba.org
Date: Fri, 18 Aug 2017 12:10:58 +1000
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

This adds missing memory barriers to order updates/tests of
the virtual CPPR and MFRR, thus fixing a lost IPI problem.

While at it also document all barriers in this file

This fixes a bug causing guest IPIs to occasionally get lost.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kvm/book3s_xive_template.c | 57 +++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
index 150be86b1018..d1ed2c41b5d2 100644
--- a/arch/powerpc/kvm/book3s_xive_template.c
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -17,6 +17,12 @@ static void GLUE(X_PFX,ack_pending)(struct kvmppc_xive_vcpu *xc)
 	u16 ack;
 
 	/*
+	 * Ensure any previous store to CPPR is ordered vs.
+	 * the subsequent loads from PIPR or ACK.
+	 */
+	eieio();
+
+	/*
 	 * DD1 bug workaround: If PIPR is less favored than CPPR
 	 * ignore the interrupt or we might incorrectly lose an IPB
 	 * bit.
@@ -244,6 +250,11 @@ static u32 GLUE(X_PFX,scan_interrupts)(struct kvmppc_xive_vcpu *xc,
 	/*
 	 * If we found an interrupt, adjust what the guest CPPR should
 	 * be as if we had just fetched that interrupt from HW.
+	 *
+	 * Note: This can only make xc->cppr smaller as the previous
+	 * loop will only exit with hirq != 0 if prio is lower than
+	 * the current xc->cppr. Thus we don't need to re-check xc->mfrr
+	 * for pending IPIs.
 	 */
 	if (hirq)
 		xc->cppr = prio;
@@ -390,6 +401,12 @@ X_STATIC int GLUE(X_PFX,h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr)
 	xc->cppr = cppr;
 
 	/*
+	 * Order the above update of xc->cppr with the subsequent
+	 * read of xc->mfrr inside push_pending_to_hw()
+	 */
+	smp_mb();
+
+	/*
 	 * We are masking less, we need to look for pending things
 	 * to deliver and set VP pending bits accordingly to trigger
 	 * a new interrupt otherwise we might miss MFRR changes for
@@ -429,21 +446,37 @@ X_STATIC int GLUE(X_PFX,h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr)
 	 * used to signal MFRR changes is EOId when fetched from
 	 * the queue.
 	 */
-	if (irq == XICS_IPI || irq == 0)
+	if (irq == XICS_IPI || irq == 0) {
+		/*
+		 * This barrier orders the setting of xc->cppr vs.
+		 * subsquent test of xc->mfrr done inside
+		 * scan_interrupts and push_pending_to_hw
+		 */
+		smp_mb();
 		goto bail;
+	}
 
 	/* Find interrupt source */
 	sb = kvmppc_xive_find_source(xive, irq, &src);
 	if (!sb) {
 		pr_devel(" source not found !\n");
 		rc = H_PARAMETER;
+		/* Same as above */
+		smp_mb();
 		goto bail;
 	}
 	state = &sb->irq_state[src];
 	kvmppc_xive_select_irq(state, &hw_num, &xd);
 
 	state->in_eoi = true;
-	mb();
+
+	/*
+	 * This barrier orders both setting of in_eoi above vs,
+	 * subsequent test of guest_priority, and the setting
+	 * of xc->cppr vs. subsquent test of xc->mfrr done inside
+	 * scan_interrupts and push_pending_to_hw
+	 */
+	smp_mb();
 
 again:
 	if (state->guest_priority == MASKED) {
@@ -470,6 +503,14 @@ X_STATIC int GLUE(X_PFX,h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr)
 
 	}
 
+	/*
+	 * This barrier orders the above guest_priority check
+	 * and spin_lock/unlock with clearing in_eoi below.
+	 *
+	 * It also has to be a full mb() as it must ensure
+	 * the MMIOs done in source_eoi() are completed before
+	 * state->in_eoi is visible.
+	 */
 	mb();
 	state->in_eoi = false;
 bail:
@@ -504,6 +545,18 @@ X_STATIC int GLUE(X_PFX,h_ipi)(struct kvm_vcpu *vcpu, unsigned long server,
 	/* Locklessly write over MFRR */
 	xc->mfrr = mfrr;
 
+	/*
+	 * The load of xc->cppr below and the subsequent MMIO store
+	 * to the IPI must happen after the above mfrr update is
+	 * globally visible so that:
+	 *
+	 * - Synchronize with another CPU doing an H_EOI or a H_CPPR
+	 *   updating xc->cppr then reading xc->mfrr.
+	 *
+	 * - The target of the IPI sees the xc->mfrr update
+	 */
+	mb();
+
 	/* Shoot the IPI if most favored than target cppr */
 	if (mfrr < xc->cppr)
 		__x_writeq(0, __x_trig_page(&xc->vp_ipi_data));
