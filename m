Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B2A7B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 03:57:12 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: <kvm-ppc@vger.kernel.org> <kvm-ppc@vger.kernel.org>
Subject: [PATCH 23/30] KVM: PPC: booke: deliver program int on emulation
 failure
Date: Fri, 17 Feb 2012 17:56:51 +0100
Message-Id: <1329497818-9729-24-git-send-email-agraf@suse.de>
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

When we fail to emulate an instruction for the guest, we better go in and
tell it that we failed to emulate it, by throwing an illegal instruction
exception.

Please beware that we basically never get around to telling the guest that
we failed thanks to the debugging code right above it. If user space however
decides that it wants to ignore the debug, we would at least do "the right
thing" afterwards.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 4c1e2bc..bfb2092 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -549,13 +549,13 @@ static int emulation_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		return RESUME_HOST;
 
 	case EMULATE_FAIL:
-		/* XXX Deliver Program interrupt to guest. */
 		printk(KERN_CRIT "%s: emulation at %lx failed (%08x)\n",
 		       __func__, vcpu->arch.pc, vcpu->arch.last_inst);
 		/* For debugging, encode the failing instruction and
 		 * report it to userspace. */
 		run->hw.hardware_exit_reason = ~0ULL << 32;
 		run->hw.hardware_exit_reason |= vcpu->arch.last_inst;
+		kvmppc_core_queue_program(vcpu, ESR_PIL);
 		return RESUME_HOST;
 
 	default:
-- 
1.6.0.2
