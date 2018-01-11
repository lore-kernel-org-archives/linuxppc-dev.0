Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMB61jXnzF0Tk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:12:14 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id d23so1310704pfe.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:12:14 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 06/26] KVM: PPC: Book3S PR: PR KVM pass through MSR TM/TS bits
 to shadow_msr.
Date: Thu, 11 Jan 2018 18:11:19 +0800
Message-Id: <1515665499-31710-7-git-send-email-wei.guo.simon@gmail.com>
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

PowerPC TM functionality needs MSR TM/TS bits support in hardware level.
Guest TM functionality can not be emulated with "fake" MSR (msr in magic
page) TS bits.

This patch syncs TM/TS bits in shadow_msr with the MSR value in magic
page, so that the MSR TS value which guest sees is consistent with actual
MSR bits running in guest.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_pr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index d0dc862..4e9acdd 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -322,7 +322,12 @@ static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 	ulong smsr = guest_msr;
 
 	/* Guest MSR values */
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE |
+		MSR_TM | MSR_TS_MASK;
+#else
 	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE;
+#endif
 	/* Process MSR values */
 	smsr |= MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_PR | MSR_EE;
 	/* External providers the guest reserved */
-- 
1.8.3.1
