Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9175B141302
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 00:17:33 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 00:17:30 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3E45A2CE8047
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 00:17:27 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3SEHBdQ6422784
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 00:17:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3SEHQ2G023574
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 00:17:26 +1000
Subject: [PATCH] powerpc/book3s: Improve machine check delivery to guest.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 28 Apr 2014 19:47:23 +0530
Message-ID: <20140428141723.5582.64153.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Currently we forward MCEs to guest which have been recovered by guest.
And for unhandled errors we do not deliver the MCE to guest. It looks like
with no support of FWNMI in qemu, guest just panics whenever we deliver the
recovered MCEs to guest. Also, the existig code used to return to host for
unhandled errors which was casuing guest to hang with soft lockups inside
guest and makes it difficult to recover guest instance.

This patch now forwards all fatal MCEs to guest causing guest to crash/panic.
And, for recovered errors we just go back to normal functioning of guest
instead of returning to host. This fixes soft lockup issues in guest.
This patch also fixes an issue where guest MCE events were not logged to
host console.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_ras.c        |   15 +++++++--------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   19 ++++++++++++++++---
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index 768a9f9..3a5c568 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -113,10 +113,8 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 	 * We assume that if the condition is recovered then linux host
 	 * will have generated an error log event that we will pick
 	 * up and log later.
-	 * Don't release mce event now. In case if condition is not
-	 * recovered we do guest exit and go back to linux host machine
-	 * check handler. Hence we need make sure that current mce event
-	 * is available for linux host to consume.
+	 * Don't release mce event now. We will queue up the event so that
+	 * we can log the MCE event info on host console.
 	 */
 	if (!get_mce_event(&mce_evt, MCE_EVENT_DONTRELEASE))
 		goto out;
@@ -128,11 +126,12 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 
 out:
 	/*
-	 * If we have handled the error, then release the mce event because
-	 * we will be delivering machine check to guest.
+	 * We are now going enter guest either through machine check
+	 * interrupt (for unhandled errors) or will continue from
+	 * current HSRR0 (for handled errors) in guest. Hence
+	 * queue up the event so that we can log it from host console later.
 	 */
-	if (handled)
-		release_mce_event();
+	machine_check_queue_event();
 
 	return handled;
 }
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index ffbb871..781205f 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2101,14 +2101,27 @@ machine_check_realmode:
 	mr	r3, r9		/* get vcpu pointer */
 	bl	.kvmppc_realmode_machine_check
 	nop
-	cmpdi	r3, 0		/* continue exiting from guest? */
+	cmpdi	r3, 0		/* Did we handle MCE ? */
 	ld	r9, HSTATE_KVM_VCPU(r13)
 	li	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
-	beq	mc_cont
+	/*
+	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest through
+	 * machine check interrupt (set HSRR0 to 0x200). And for handled
+	 * errors (no-fatal), just go back to guest execution with current
+	 * HSRR0 instead of exiting guest. This new approach will inject
+	 * machine check to guest for fatal error causing guest to crash.
+	 *
+	 * The old code used to return to host for unhandled errors which
+	 * was causing guest to hang with soft lockups inside guest and
+	 * makes it difficult to recover guest instance.
+	 */
+	ld	r10, VCPU_PC(r9)
+	ld	r11, VCPU_MSR(r9)
+	bne	2f	/* Continue guest execution. */
 	/* If not, deliver a machine check.  SRR0/1 are already set */
 	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
 	bl	kvmppc_msr_interrupt
-	b	fast_interrupt_c_return
+2:	b	fast_interrupt_c_return
 
 /*
  * Check the reason we woke from nap, and take appropriate action.
