Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8AF82C03E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:34 +1100 (EST)
Received: from mail216-va3 (localhost [127.0.0.1])	by
 mail216-va3-R.bigfish.com (Postfix) with ESMTP id DB6A784027E	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:21 +0000 (UTC)
Received: from VA3EHSMHS010.bigfish.com (unknown [10.7.14.237])	by
 mail216-va3.bigfish.com (Postfix) with ESMTP id 2A570180075	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:19 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEBO1003747	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:12 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 09/12] KVM: PPC: bookehv: Add guest computation mode for irq
 delivery
Date: Thu, 11 Oct 2012 19:13:26 +0300
Message-ID: <1349972009-23027-10-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When delivering guest IRQs, update MSR computation mode according to guest
interrupt computation mode found in EPCR.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v1: added intermediate msr variable.

 arch/powerpc/kvm/booke.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 7c9c389..86f0d0d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -312,6 +312,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	bool crit;
 	bool keep_irq = false;
 	enum int_class int_class;
+	ulong new_msr = vcpu->arch.shared->msr;
 
 	/* Truncate crit indicators in 32 bit mode */
 	if (!(vcpu->arch.shared->msr & MSR_SF)) {
@@ -407,7 +408,13 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 			set_guest_esr(vcpu, vcpu->arch.queued_esr);
 		if (update_dear == true)
 			set_guest_dear(vcpu, vcpu->arch.queued_dear);
-		kvmppc_set_msr(vcpu, vcpu->arch.shared->msr & msr_mask);
+
+		new_msr &= msr_mask;
+#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)
+		if (vcpu->arch.epcr & SPRN_EPCR_ICM)
+			new_msr |= MSR_CM;
+#endif
+		kvmppc_set_msr(vcpu, new_msr);
 
 		if (!keep_irq)
 			clear_bit(priority, &vcpu->arch.pending_exceptions);
-- 
1.7.4.1
