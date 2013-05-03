Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4ACD02C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 09:45:35 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH] kvm/ppc/booke64: Hard disable interrupts when entering the
 guest
Date: Fri, 3 May 2013 18:45:23 -0500
Message-ID: <1367624723-22456-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kvmppc_lazy_ee_enable() was causing interrupts to be soft-enabled
(albeit hard-disabled) in kvmppc_restart_interrupt().  This led to
warnings, and possibly breakage if the interrupt state was later saved
and then restored (leading to interrupts being hard-and-soft enabled
when they should be at least soft-disabled).

Simply removing kvmppc_lazy_ee_enable() leaves interrupts only
soft-disabled when we enter the guest, but they will be hard-disabled
when we exit the guest -- without PACA_IRQ_HARD_DIS ever being set, so
the local_irq_enable() fails to hard-enable.

While we could just set PACA_IRQ_HARD_DIS after an exit to compensate,
instead hard-disable interrupts before entering the guest.  This way,
we won't have to worry about interactions if we take an interrupt
during the guest entry code.  While I don't see any obvious
interactions, it could change in the future (e.g. it would be bad if
the non-hv code were used on 64-bit or if 32-bit guest lazy interrupt
disabling, since the non-hv code changes IVPR among other things).

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ecbe908..b216821 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -666,14 +666,14 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	}
 
-	local_irq_disable();
+	hard_irq_disable();
+	trace_hardirqs_off();
 	s = kvmppc_prepare_to_enter(vcpu);
 	if (s <= 0) {
 		local_irq_enable();
 		ret = s;
 		goto out;
 	}
-	kvmppc_lazy_ee_enable();
 
 	kvm_guest_enter();
 
@@ -1150,13 +1150,12 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 * aren't already exiting to userspace for some other reason.
 	 */
 	if (!(r & RESUME_HOST)) {
-		local_irq_disable();
+		hard_irq_disable();
+		trace_hardirqs_off();
 		s = kvmppc_prepare_to_enter(vcpu);
 		if (s <= 0) {
 			local_irq_enable();
 			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
-		} else {
-			kvmppc_lazy_ee_enable();
 		}
 	}
 
-- 
1.7.10.4
