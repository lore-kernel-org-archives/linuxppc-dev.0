Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DAD4BB6FD8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:48 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 23/37] KVM: PPC: booke: deliver program int on emulation
 failure
Date: Fri, 24 Feb 2012 15:26:17 +0100
Message-Id: <1330093591-19523-24-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-1-git-send-email-agraf@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
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
index 17d5318..9979be1 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -545,13 +545,13 @@ static int emulation_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
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
