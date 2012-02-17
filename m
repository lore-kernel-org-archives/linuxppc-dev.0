Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6851510081B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 04:14:12 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 25/30] KVM: PPC: booke: BOOKE_IRQPRIO_MAX is n+1
Date: Fri, 17 Feb 2012 18:13:52 +0100
Message-Id: <1329498837-11717-26-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-1-git-send-email-agraf@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The semantics of BOOKE_IRQPRIO_MAX changed to denote the highest available
irqprio + 1, so let's reflect that in the code too.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index de30b6d..c7aa6d6 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -429,7 +429,7 @@ static void kvmppc_core_check_exceptions(struct kvm_vcpu *vcpu)
 	}
 
 	priority = __ffs(*pending);
-	while (priority <= BOOKE_IRQPRIO_MAX) {
+	while (priority < BOOKE_IRQPRIO_MAX) {
 		if (kvmppc_booke_irqprio_deliver(vcpu, priority))
 			break;
 
-- 
1.6.0.2
