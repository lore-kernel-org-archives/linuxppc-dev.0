Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15839C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:55:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857EE20684
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="h6R3JpJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857EE20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PfK362SQzF3HK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:55:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="h6R3JpJW";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSb6sCMzF3BG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="h6R3JpJW"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSb3zlrz9t0G; Tue,  2 Oct 2018 21:32:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSb1YHqz9t1X;
 Tue,  2 Oct 2018 21:32:15 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479935; bh=pHRX8DnR9VwlXfBs5tP7micblLgWZHaSn9f9L2kbSXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h6R3JpJWqXRe2EBuu7XQsTG1IhrUaDj0DHOQrd8g6rkeUuv50Gnavnu2VvrR5I190
 PnhXCpzxhSEg6Imx4SEGt+RkwTt/lBi2ZAthX7J1DuSwQ3IumFQBpycevsdtq5AeC8
 quq/5aeEdx2Ibh8xEUuAm7nHFAKX6xq4ceQggNxynAtDkKF11qAl51oFr/3aThhjTP
 gfnAnSOLq4ZQ9HIiemwhSVEWerVRsZjXKiS8Cmrp6PMq7ZqyOmvva5ss9C1wgPjJJH
 lltPA6QLDAfhupNGInn1NUCgtVxubGi4YnY5qGQ76zScgnpWJKLCI3lyWGLUTTKnXw
 e47NEw8l6vk8w==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 29/33] KVM: PPC: Book3S HV: Handle differing endianness for
 H_ENTER_NESTED
Date: Tue,  2 Oct 2018 21:31:28 +1000
Message-Id: <1538479892-14835-30-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
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

The hcall H_ENTER_NESTED takes as the two parameters the address in
L1 guest memory of a hv_regs struct and a pt_regs struct which the
L1 guest would like to use to run a L2 guest and in which are returned
the exit state of the L2 guest.  For efficiency, these are in the
endianness of the L1 guest, rather than being always big-endian as is
usually the case for PAPR hypercalls.

When reading/writing these structures, this patch handles the case
where the endianness of the L1 guest differs from that of the L0
hypervisor, by byteswapping the structures after reading and before
writing them back.

Since all the fields of the pt_regs are of the same type, i.e.,
unsigned long, we treat it as an array of unsigned longs.  The fields
of struct hv_guest_state are not all the same, so its fields are
byteswapped individually.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 51 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 7b1088a..228dc11 100644
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

