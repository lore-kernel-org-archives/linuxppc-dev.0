Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMBN16HfzF0W9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:12:28 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 23so1305981pfp.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:12:28 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 10/26] KVM: PPC: Book3S PR: set MSR HV bit accordingly for
 PPC970 and others.
Date: Thu, 11 Jan 2018 18:11:23 +0800
Message-Id: <1515665499-31710-11-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Apple G5 machines(PPC970/FX/GX/MP) have supervisor mode disabled and
MSR HV bit is forced into 1. We should follow this in PR KVM guest.

This patch set MSR HV=1 for G5 machines and HV=0 for others on PR
KVM guest.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Suggested-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_pr.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 7ec866a..b2f7566 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -320,6 +320,7 @@ static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 {
 	ulong guest_msr = kvmppc_get_msr(vcpu);
 	ulong smsr = guest_msr;
+	u32 guest_pvr = vcpu->arch.pvr;
 
 	/* Guest MSR values */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
@@ -334,7 +335,16 @@ static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 	smsr |= (guest_msr & vcpu->arch.guest_owned_ext);
 	/* 64-bit Process MSR values */
 #ifdef CONFIG_PPC_BOOK3S_64
-	smsr |= MSR_ISF | MSR_HV;
+	smsr |= MSR_ISF;
+
+	/* for PPC970 chip, its HV bit is hard-wired to 1. For others,
+	 * we should clear HV bit.
+	 */
+	if ((PVR_VER(guest_pvr) == PVR_970) ||
+	    (PVR_VER(guest_pvr) == PVR_970FX) ||
+	    (PVR_VER(guest_pvr) == PVR_970MP) ||
+	    (PVR_VER(guest_pvr) == PVR_970GX))
+		smsr |= MSR_HV;
 #endif
 	vcpu->arch.shadow_msr = smsr;
 }
-- 
1.8.3.1
