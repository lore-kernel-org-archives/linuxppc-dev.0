Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7268FC00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:45:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9502087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="bCRRbwqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9502087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T9pS6dBmzF3BX
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:45:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="bCRRbwqi";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T8BB236FzF35x
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:32:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="bCRRbwqi"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T8B94qPsz9sj3; Mon,  8 Oct 2018 16:32:01 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T8B92C2xzB2xn;
 Mon,  8 Oct 2018 16:32:01 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976721; bh=WAZ8Kfy5HLLMi989Jekpswe7tKMthqqnarmzG84GVME=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bCRRbwqihwUQOjy3frRGJDeLA3diarZ/k90fMOSdyMFpGu0A6LbtU7n065XDng5b/
 DyiNtDsebz1Wo010MkZftWIEYQc61JCe6+i99B+LVDb64qbUwzRtfxWDakIxD20QKG
 1X4zW6lh6937IswmxrK2/XPMkFMz8FDbMkIOMrLLKN75DaTW7a/AZgPby0p1vxtIVD
 aq9t5LibIm9QCoE+T8YD2Eotvq6R4V+etyzwZz/S7LvP8HErFfw2J7MdNtGEbZGMjW
 CGaVrp5/cXgCj/mShpLCQeB9qDzibuR43Qsmdb6lSi2KMnskvic6xDX7aJEw+2Og8S
 UNTXc/pC4zq9w==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 29/33] KVM: PPC: Book3S HV: Handle differing endianness for
 H_ENTER_NESTED
Date: Mon,  8 Oct 2018 16:31:15 +1100
Message-Id: <1538976679-1363-30-git-send-email-paulus@ozlabs.org>
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
index e2305962..3f21f78 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -51,6 +51,48 @@ void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
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
@@ -175,6 +217,8 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 				  sizeof(struct hv_guest_state));
 	if (err)
 		return H_PARAMETER;
+	if (kvmppc_need_byteswap(vcpu))
+		byteswap_hv_regs(&l2_hv);
 	if (l2_hv.version != HV_GUEST_STATE_VERSION)
 		return H_P2;
 
@@ -183,7 +227,8 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 				  sizeof(struct pt_regs));
 	if (err)
 		return H_PARAMETER;
-
+	if (kvmppc_need_byteswap(vcpu))
+		byteswap_pt_regs(&l2_regs);
 	if (l2_hv.vcpu_token >= NR_CPUS)
 		return H_PARAMETER;
 
@@ -255,6 +300,10 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
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

