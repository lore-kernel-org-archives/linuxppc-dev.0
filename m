Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 163A6B7250
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:32:00 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 09/10] KVM: PPC: Support SC1 hypercalls for PAPR in PR mode
Date: Tue,  9 Aug 2011 18:31:47 +0200
Message-Id: <1312907508-14599-10-git-send-email-agraf@suse.de>
In-Reply-To: <1312907508-14599-1-git-send-email-agraf@suse.de>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PAPR defines hypercalls as SC1 instructions. Using these, the guest modifies
page tables and does other privileged operations that it wouldn't be allowed
to do in supervisor mode.

This patch adds support for PR KVM to trap these instructions and route them
through the same PAPR hypercall interface that we already use for HV style
KVM.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_pr.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 78dcf65..48558f6 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -648,7 +648,27 @@ program_interrupt:
 		break;
 	}
 	case BOOK3S_INTERRUPT_SYSCALL:
-		if (vcpu->arch.osi_enabled &&
+		if (vcpu->arch.papr_enabled &&
+		    (kvmppc_get_last_inst(vcpu) == 0x44000022) &&
+		    !(vcpu->arch.shared->msr & MSR_PR)) {
+			/* SC 1 papr hypercalls */
+			ulong cmd = kvmppc_get_gpr(vcpu, 3);
+			int i;
+
+			if (kvmppc_h_pr(vcpu, cmd) == EMULATE_DONE) {
+				r = RESUME_GUEST;
+				break;
+			}
+
+			run->papr_hcall.nr = cmd;
+			for (i = 0; i < 9; ++i) {
+				ulong gpr = kvmppc_get_gpr(vcpu, 4 + i);
+				run->papr_hcall.args[i] = gpr;
+			}
+			run->exit_reason = KVM_EXIT_PAPR_HCALL;
+			vcpu->arch.hcall_needed = 1;
+			r = RESUME_HOST;
+		} else if (vcpu->arch.osi_enabled &&
 		    (((u32)kvmppc_get_gpr(vcpu, 3)) == OSI_SC_MAGIC_R3) &&
 		    (((u32)kvmppc_get_gpr(vcpu, 4)) == OSI_SC_MAGIC_R4)) {
 			/* MOL hypercalls */
-- 
1.6.0.2
