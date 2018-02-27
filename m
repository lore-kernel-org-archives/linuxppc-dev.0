Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRMq4SP3zF1Xb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:27 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id m5so8264051pff.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:27 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 19/30] KVM: PPC: Book3S PR: enable NV reg restore for
 reading TM SPR at guest privilege state
Date: Wed, 28 Feb 2018 01:52:27 +0800
Message-Id: <1519753958-11756-9-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
References: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Currently kvmppc_handle_fac() will not update NV GPRs and thus it can
return with GUEST_RESUME.

However PR KVM guest always disables MSR_TM bit at privilege state. If PR
privilege guest are trying to read TM SPRs, it will trigger TM facility
unavailable exception and fall into kvmppc_handle_fac(). Then the emulation
will be done by kvmppc_core_emulate_mfspr_pr(). The mfspr instruction can
include a RT with NV reg. So it is necessary to restore NV GPRs at this
case, to reflect the update to NV RT.

This patch make kvmppc_handle_fac() return GUEST_RESUME_NV at TM fac
exception and with guest privilege state.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_pr.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 82e1a74..f31f9de 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -998,6 +998,18 @@ static int kvmppc_handle_fac(struct kvm_vcpu *vcpu, ulong fac)
 		break;
 	}
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* Since we disabled MSR_TM at privilege state, the mfspr instruction
+	 * for TM spr can trigger TM fac unavailable. In this case, the
+	 * emulation is handled by kvmppc_emulate_fac(), which invokes
+	 * kvmppc_emulate_mfspr() finally. But note the mfspr can include
+	 * RT for NV registers. So it need to restore those NV reg to reflect
+	 * the update.
+	 */
+	if ((fac == FSCR_TM_LG) && !(kvmppc_get_msr(vcpu) & MSR_PR))
+		return RESUME_GUEST_NV;
+#endif
+
 	return RESUME_GUEST;
 }
 
@@ -1359,8 +1371,7 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	}
 #ifdef CONFIG_PPC_BOOK3S_64
 	case BOOK3S_INTERRUPT_FAC_UNAVAIL:
-		kvmppc_handle_fac(vcpu, vcpu->arch.shadow_fscr >> 56);
-		r = RESUME_GUEST;
+		r = kvmppc_handle_fac(vcpu, vcpu->arch.shadow_fscr >> 56);
 		break;
 #endif
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
-- 
1.8.3.1
