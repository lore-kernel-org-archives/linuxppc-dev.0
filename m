Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A084B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 11:10:24 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 35/38] KVM: PPC: booke: Support perfmon interrupts
Date: Wed, 29 Feb 2012 01:10:03 +0100
Message-Id: <1330474206-14794-36-git-send-email-agraf@suse.de>
In-Reply-To: <1330474206-14794-1-git-send-email-agraf@suse.de>
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
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

When during guest context we get a performance monitor interrupt, we
currently bail out and oops. Let's route it to its correct handler
instead.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 7df3f3a..ee39c8a 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -679,6 +679,10 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 
+	case BOOKE_INTERRUPT_PERFORMANCE_MONITOR:
+		r = RESUME_GUEST;
+		break;
+
 	case BOOKE_INTERRUPT_HV_PRIV:
 		r = emulation_exit(run, vcpu);
 		break;
-- 
1.6.0.2
