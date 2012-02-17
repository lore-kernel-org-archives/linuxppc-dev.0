Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BC22B6FD8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 03:57:12 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: <kvm-ppc@vger.kernel.org> <kvm-ppc@vger.kernel.org>
Subject: [PATCH 22/30] KVM: PPC: booke: remove leftover debugging
Date: Fri, 17 Feb 2012 17:56:50 +0100
Message-Id: <1329497818-9729-23-git-send-email-agraf@suse.de>
In-Reply-To: <1329497818-9729-1-git-send-email-agraf@suse.de>
References: <1329497818-9729-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The e500mc patches left some debug code in that we don't need. Remove it.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 12a2b0b..4c1e2bc 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -473,11 +473,6 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	}
 
-	if (!current->thread.kvm_vcpu) {
-		WARN(1, "no vcpu\n");
-		return -EPERM;
-	}
-
 	local_irq_disable();
 
 	kvmppc_core_prepare_to_enter(vcpu);
-- 
1.6.0.2
