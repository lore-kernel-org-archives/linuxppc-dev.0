Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E32C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 08:57:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3002147A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 08:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3002147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444BLP2nzGzDqBM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 19:57:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444BJK2Fz7zDq9k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 19:55:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 444BJK1B79z9s70; Wed, 20 Feb 2019 19:55:13 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 444BJK0lghz9s7h; Wed, 20 Feb 2019 19:55:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] KVM: PPC: Book3S HV: Context switch IAMR on Power9
Date: Wed, 20 Feb 2019 19:55:00 +1100
Message-Id: <20190220085500.29837-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: paulus@samba.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

kvmhv_p9_guest_entry() implements a fast-path guest entry for Power9
when guest and host are both running with the Radix MMU.

Currently in that path we don't save the host AMR (Authority Mask
Register) value, and we always restore 0 on return to the host. That
is OK at the moment because the AMR is not used for storage keys with
the Radix MMU.

However we plan to start using the AMR on Radix to prevent the kernel
from reading/writing to userspace outside of copy_to/from_user(). In
order to make that work we need to save/restore the AMR value.

We only restore the value if it is different from the guest value,
which is already in the register when we exit to the host. This should
mean we rarely need to actually restore the value when running a
modern Linux as a guest, because it will be using the same value as
us.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kvm/book3s_hv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5a066fc299e1..105a3f78a760 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3455,6 +3455,7 @@ int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	unsigned long host_dscr = mfspr(SPRN_DSCR);
 	unsigned long host_tidr = mfspr(SPRN_TIDR);
 	unsigned long host_iamr = mfspr(SPRN_IAMR);
+	unsigned long host_amr = mfspr(SPRN_AMR);
 	s64 dec;
 	u64 tb;
 	int trap, save_pmu;
@@ -3571,13 +3572,15 @@ int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	mtspr(SPRN_PSPB, 0);
 	mtspr(SPRN_WORT, 0);
-	mtspr(SPRN_AMR, 0);
 	mtspr(SPRN_UAMOR, 0);
 	mtspr(SPRN_DSCR, host_dscr);
 	mtspr(SPRN_TIDR, host_tidr);
 	mtspr(SPRN_IAMR, host_iamr);
 	mtspr(SPRN_PSPB, 0);
 
+	if (host_amr != vcpu->arch.amr)
+		mtspr(SPRN_AMR, host_amr);
+
 	msr_check_and_set(MSR_FP | MSR_VEC | MSR_VSX);
 	store_fp_state(&vcpu->arch.fp);
 #ifdef CONFIG_ALTIVEC
-- 
2.20.1

