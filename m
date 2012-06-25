Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C8748B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:49 +1000 (EST)
Received: from mail114-ch1 (localhost [127.0.0.1])	by
 mail114-ch1-R.bigfish.com (Postfix) with ESMTP id 955831A0317	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:05 +0000 (UTC)
Received: from CH1EHSMHS007.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.233])	by mail114-ch1.bigfish.com (Postfix) with ESMTP id
 3509C3A005B	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:04
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQd46019299	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:39 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 04/17] KVM: PPC64: booke: Add guest computation mode for
 irq delivery
Date: Mon, 25 Jun 2012 15:26:22 +0300
Message-ID: <1340627195-11544-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When delivering guest IRQs, update MSR computaion mode according to guest
interrupt computation mode found in EPCR.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index d15c4b5..93b48e0 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -287,6 +287,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	bool crit;
 	bool keep_irq = false;
 	enum int_class int_class;
+	ulong msr_cm = 0;
 
 	/* Truncate crit indicators in 32 bit mode */
 	if (!(vcpu->arch.shared->msr & MSR_SF)) {
@@ -299,6 +300,10 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	/* ... and we're in supervisor mode */
 	crit = crit && !(vcpu->arch.shared->msr & MSR_PR);
 
+#ifdef CONFIG_64BIT
+	msr_cm = vcpu->arch.epcr & SPRN_EPCR_ICM ? MSR_CM : 0;
+#endif
+
 	if (priority == BOOKE_IRQPRIO_EXTERNAL_LEVEL) {
 		priority = BOOKE_IRQPRIO_EXTERNAL;
 		keep_irq = true;
@@ -381,7 +386,8 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 			set_guest_esr(vcpu, vcpu->arch.queued_esr);
 		if (update_dear == true)
 			set_guest_dear(vcpu, vcpu->arch.queued_dear);
-		kvmppc_set_msr(vcpu, vcpu->arch.shared->msr & msr_mask);
+		kvmppc_set_msr(vcpu, (vcpu->arch.shared->msr & msr_mask)
+				| msr_cm);
 
 		if (!keep_irq)
 			clear_bit(priority, &vcpu->arch.pending_exceptions);
-- 
1.7.4.1
