Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83A9C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:42:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197F22087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="LmNFKPA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197F22087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T9lY6sGYzDrDD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:42:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="LmNFKPA8";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T8B91BWrzF35x
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:32:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="LmNFKPA8"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T8B84vKbz9sj6; Mon,  8 Oct 2018 16:32:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T8B76k52zB4PK;
 Mon,  8 Oct 2018 16:31:59 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976720; bh=W9V0WVohEhVONTHNxDtUPrFsEOgNouaqG4E00cnMIqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LmNFKPA8tPp6X7Kc30F3C8RS07Ei+WCEBmG6K5a0l9RKH2ccjiCt8HjOAqibp3Jky
 v8jvSHAU+tpU+OEm4ZTFBai/6v1ih3fN5dB2Wt26ISrkkJiUGpPwJGHPSh0v4Lr0pu
 QXu/etETQhMypST4OHxrwEai1ZrhxiDA2i7TIStE2xH+Y4H88YdJ7LYp7t8AfClkhP
 dXP5Sdr9T5tZt1OTfji6FDphMSNB+hlKpWFxPa4lF8ipaIpqybmllGigtIT9vXjiOU
 jHA0IR48tqFw1s4HffO0bJJvTE5efm9tniSLpYiZQkcPeHvSgZhEPkuKmW3xP/JEfW
 sPiFJJeNCeKUg==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 28/33] KVM: PPC: Book3S HV: Sanitise hv_regs on nested
 guest entry
Date: Mon,  8 Oct 2018 16:31:14 +1100
Message-Id: <1538976679-1363-29-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

restore_hv_regs() is used to copy the hv_regs L1 wants to set to run the
nested (L2) guest into the vcpu structure. We need to sanitise these
values to ensure we don't let the L1 guest hypervisor do things we don't
want it to.

We don't let data address watchpoints or completed instruction address
breakpoints be set to match in hypervisor state.

We also don't let L1 enable features in the hypervisor facility status
and control register (HFSCR) for L2 which we have disabled for L1. That
is L2 will get the subset of features which the L0 hypervisor has
enabled for L1 and the features L1 wants to enable for L2. This could
mean we give L1 a hypervisor facility unavailable interrupt for a
facility it thinks it has enabled, however it shouldn't have enabled a
facility it itself doesn't have for the L2 guest.

We sanitise the registers when copying in the L2 hv_regs. We don't need
to sanitise when copying back the L1 hv_regs since these shouldn't be
able to contain invalid values as they're just what was copied out.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/reg.h      |  1 +
 arch/powerpc/kvm/book3s_hv_nested.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 6fda746..c9069897 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -415,6 +415,7 @@
 #define   HFSCR_DSCR	__MASK(FSCR_DSCR_LG)
 #define   HFSCR_VECVSX	__MASK(FSCR_VECVSX_LG)
 #define   HFSCR_FP	__MASK(FSCR_FP_LG)
+#define   HFSCR_INTR_CAUSE (ASM_CONST(0xFF) << 56)	/* interrupt cause */
 #define SPRN_TAR	0x32f	/* Target Address Register */
 #define SPRN_LPCR	0x13E	/* LPAR Control Register */
 #define   LPCR_VPM0		ASM_CONST(0x8000000000000000)
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index a876dc3..e2305962 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -86,6 +86,22 @@ static void save_hv_return_state(struct kvm_vcpu *vcpu, int trap,
 	}
 }
 
+static void sanitise_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
+{
+	/*
+	 * Don't let L1 enable features for L2 which we've disabled for L1,
+	 * but preserve the interrupt cause field.
+	 */
+	hr->hfscr &= (HFSCR_INTR_CAUSE | vcpu->arch.hfscr);
+
+	/* Don't let data address watchpoint match in hypervisor state */
+	hr->dawrx0 &= ~DAWRX_HYP;
+
+	/* Don't let completed instruction address breakpt match in HV state */
+	if ((hr->ciabr & CIABR_PRIV) == CIABR_PRIV_HYPER)
+		hr->ciabr &= ~CIABR_PRIV;
+}
+
 static void restore_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 {
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
@@ -198,6 +214,7 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 	mask = LPCR_DPFD | LPCR_ILE | LPCR_TC | LPCR_AIL | LPCR_LD |
 		LPCR_LPES | LPCR_MER;
 	lpcr = (vc->lpcr & ~mask) | (l2_hv.lpcr & mask);
+	sanitise_hv_regs(vcpu, &l2_hv);
 	restore_hv_regs(vcpu, &l2_hv);
 
 	vcpu->arch.ret = RESUME_GUEST;
-- 
2.7.4

