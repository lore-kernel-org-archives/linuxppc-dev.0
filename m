Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCBFC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:26:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4CD2082A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="fbm8WV2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4CD2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qtvh4M08zF3Hd
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:26:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="fbm8WV2Y";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qrvp0HNszF3Jp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="fbm8WV2Y"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Qrvn4PVgz9s8T; Thu,  4 Oct 2018 21:56:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Qrvm72gCzB4N6;
 Thu,  4 Oct 2018 21:56:36 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654197; bh=Gv3Gxij/gYTxPAT+jCXgVeUY64zcRxcmaib1+nXNLZk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fbm8WV2YuZoXlhQz1ES0FhMfGEv5NUYTz0xJyd9P1gs9yUYLz+y3s9T0F3jTVswDz
 62Wu4g+2o6R4yfTemSUI56yaZ9R+Zl1mXOjEWBSyi9gDN3Ja8RmIWrB0NF9pWMtPpz
 nOdGf/LO4+IqIR+CLqP8pg9Yhf1uXiGR8HZlAzFkoyiTLz2+D0glyTptvym2FK0zws
 4KwjG0TDgikTLU8ZalJdTg1g9eHE5PuOms2hQrTSXr9cGsvN85nsNSvYTydjAvz1Ly
 Aph0UVWVRjBLsk7bKgYz6JzrUPraVq+E0UkVBu1fYPzw/q5gAnoREnykrvSpLZWj6m
 eebM0FFhK7soA==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 29/32] KVM: PPC: Book3S HV: Handle differing endianness for
 H_ENTER_NESTED
Date: Thu,  4 Oct 2018 21:56:06 +1000
Message-Id: <1538654169-15602-30-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
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

The hcall H_ENTER_NESTED takes two parameters: the address in L1 guest
memory of a hv_regs struct and the address of a pt_regs struct.  The
hcall requests the L0 hypervisor to use the register values in these
structs to run a L2 guest and to return the exit state of the L2 guest
in these structs.  These are in the endianness of the L1 guest, rather
than being always big-endian as is usually the case for PAPR
hypercalls.

This is convenient because it means that the L1 guest can pass the
address of the regs field in its kvm_vcpu_arch struct.  This also
improves performance slightly by avoiding the need for two copies of
the pt_regs struct.

When reading/writing these structures, this patch handles the case
where the endianness of the L1 guest differs from that of the L0
hypervisor, by byteswapping the structures after reading and before
writing them back.

Since all the fields of the pt_regs are of the same type, i.e.,
unsigned long, we treat it as an array of unsigned longs.  The fields
of struct hv_guest_state are not all the same, so its fields are
byteswapped individually.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 51 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index f54f779..8c0da00 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -50,6 +50,48 @@ void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 	hr->ppr = vcpu->arch.ppr;
 }
 
+static void byteswap_pt_regs(struct pt_regs *regs)
+{
+	unsigned long *addr = (unsigned long *) regs;
+
+	for (; addr < ((unsigned long *) (regs + 1)); addr++)
+		*addr = swab64(*addr);
+}
+
+static void byteswap_hv_regs(struct hv_guest_state *hr)
+{
+	hr->version = swab64(hr->version);
+	hr->lpid = swab32(hr->lpid);
+	hr->vcpu_token = swab32(hr->vcpu_token);
+	hr->lpcr = swab64(hr->lpcr);
+	hr->pcr = swab64(hr->pcr);
+	hr->amor = swab64(hr->amor);
+	hr->dpdes = swab64(hr->dpdes);
+	hr->hfscr = swab64(hr->hfscr);
+	hr->tb_offset = swab64(hr->tb_offset);
+	hr->dawr0 = swab64(hr->dawr0);
+	hr->dawrx0 = swab64(hr->dawrx0);
+	hr->ciabr = swab64(hr->ciabr);
+	hr->hdec_expiry = swab64(hr->hdec_expiry);
+	hr->purr = swab64(hr->purr);
+	hr->spurr = swab64(hr->spurr);
+	hr->ic = swab64(hr->ic);
+	hr->vtb = swab64(hr->vtb);
+	hr->hdar = swab64(hr->hdar);
+	hr->hdsisr = swab64(hr->hdsisr);
+	hr->heir = swab64(hr->heir);
+	hr->asdr = swab64(hr->asdr);
+	hr->srr0 = swab64(hr->srr0);
+	hr->srr1 = swab64(hr->srr1);
+	hr->sprg[0] = swab64(hr->sprg[0]);
+	hr->sprg[1] = swab64(hr->sprg[1]);
+	hr->sprg[2] = swab64(hr->sprg[2]);
+	hr->sprg[3] = swab64(hr->sprg[3]);
+	hr->pidr = swab64(hr->pidr);
+	hr->cfar = swab64(hr->cfar);
+	hr->ppr = swab64(hr->ppr);
+}
+
 static void save_hv_return_state(struct kvm_vcpu *vcpu, int trap,
 				 struct hv_guest_state *hr)
 {
@@ -174,6 +216,8 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 				  sizeof(struct hv_guest_state));
 	if (err)
 		return H_PARAMETER;
+	if (kvmppc_need_byteswap(vcpu))
+		byteswap_hv_regs(&l2_hv);
 	if (l2_hv.version != HV_GUEST_STATE_VERSION)
 		return H_P2;
 
@@ -182,7 +226,8 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 				  sizeof(struct pt_regs));
 	if (err)
 		return H_PARAMETER;
-
+	if (kvmppc_need_byteswap(vcpu))
+		byteswap_pt_regs(&l2_regs);
 	if (l2_hv.vcpu_token >= NR_CPUS)
 		return H_PARAMETER;
 
@@ -254,6 +299,10 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 	kvmhv_put_nested(l2);
 
 	/* copy l2_hv_state and regs back to guest */
+	if (kvmppc_need_byteswap(vcpu)) {
+		byteswap_hv_regs(&l2_hv);
+		byteswap_pt_regs(&l2_regs);
+	}
 	err = kvm_vcpu_write_guest(vcpu, hv_ptr, &l2_hv,
 				   sizeof(struct hv_guest_state));
 	if (err)
-- 
2.7.4

