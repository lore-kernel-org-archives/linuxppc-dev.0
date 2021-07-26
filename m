Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E680C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 03:53:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DFE60E0C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 03:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07DFE60E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY5cJ524Wz30FK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 13:53:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ZZgsfapa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ZZgsfapa; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY5Yr3pp8z308V
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2021 13:50:56 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id j1so11097610pjv.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jul 2021 20:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8UBTM45PptEgGbJ6eGLIibMu8Q6Rsmel7GFQgZufaPE=;
 b=ZZgsfapa4LOcRIARu+vtQhK/XfomCmdBHNAdRZ7FFxh1y0vUuyc4F54Pt0xv3aXqcG
 +9OLJea0LQQttph5g54UKKcYZLlu/ZJTrheWz1tqJ3aCfSoLFDMM39ShhmDdDRS1HeU5
 3YkNpynzrSlqs/nmc5jwqGywnJCJbrwzBI+nzMMUaWznKlbxyvceap2yGOQgJuNx5R2y
 Mfdu34B8nR5X5+gtPJ8WYKSwXxwmjs4IlhwVQC0QkMxPDAU80vbo2yWHZQnFdBE1UeKu
 H1YwKzEBx6G6UmltaQsLz8dpP8DD//tE9f0xYlWx64q7ws0uihyhAv+xfjEUMT/6MpG4
 kbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8UBTM45PptEgGbJ6eGLIibMu8Q6Rsmel7GFQgZufaPE=;
 b=dRTwiVM6j4eTkYSBmEdir1/ELyMbq0hSwtQ7OvbHgPAkr5IDeRUyXKEZCVVz29rbNl
 DNz2DLpzUOWz18EytxP8QkHn6tVAQkZFmwAFQo37I3nEO9NLeQy5w8TfuoyJcuKJ9tLR
 EECKo/C+w4zN1/yPQnWI2DyiDvxMsdYgLdCl7YJzVDfmQFCf09e4ychA1VqlKFjmEOFA
 lzHkxcR2sIgkbWSC4028oizdRRHuXyYv/8CUZ+9UOeJyZZMO+recQaEUUlGHmOelpygn
 VOzKkn0ACY1u3PutdSsib+60oHItQNTjUS22+ucgVMvZMVlItmcXkBsToPvsB45IOMvw
 P2Uw==
X-Gm-Message-State: AOAM531yl//+kUaMPqkjt3Cww0krsmCHs8N0xRaTQBNYKvo90a7Al78t
 yI/jq/CyjdFWRIqXTkuevRM=
X-Google-Smtp-Source: ABdhPJwrtE0BBzK/PPlVzKAFYKj6zEVYkcJdteKsLPBHCq8pIQR9UR7baOjBCzAtyc1nI7BeVgstzA==
X-Received: by 2002:a17:90b:4b08:: with SMTP id
 lx8mr15404083pjb.66.1627271454050; 
 Sun, 25 Jul 2021 20:50:54 -0700 (PDT)
Received: from bobo.ibm.com (220-244-190-123.tpgi.com.au. [220.244.190.123])
 by smtp.gmail.com with ESMTPSA id p33sm41140341pfw.40.2021.07.25.20.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 20:50:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 04/55] KVM: PPC: Book3S HV: Stop forwarding all HFUs to L1
Date: Mon, 26 Jul 2021 13:49:45 +1000
Message-Id: <20210726035036.739609-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210726035036.739609-1-npiggin@gmail.com>
References: <20210726035036.739609-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Fabiano Rosas <farosas@linux.ibm.com>

If the nested hypervisor has no access to a facility because it has
been disabled by the host, it should also not be able to see the
Hypervisor Facility Unavailable that arises from one of its guests
trying to access the facility.

This patch turns a HFU that happened in L2 into a Hypervisor Emulation
Assistance interrupt and forwards it to L1 for handling. The ones that
happened because L1 explicitly disabled the facility for L2 are still
let through, along with the corresponding Cause bits in the HFSCR.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 9bb0788d312c..983628ed4376 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -99,7 +99,7 @@ static void byteswap_hv_regs(struct hv_guest_state *hr)
 	hr->dawrx1 = swab64(hr->dawrx1);
 }
 
-static void save_hv_return_state(struct kvm_vcpu *vcpu, int trap,
+static void save_hv_return_state(struct kvm_vcpu *vcpu,
 				 struct hv_guest_state *hr)
 {
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
@@ -128,7 +128,7 @@ static void save_hv_return_state(struct kvm_vcpu *vcpu, int trap,
 	hr->pidr = vcpu->arch.pid;
 	hr->cfar = vcpu->arch.cfar;
 	hr->ppr = vcpu->arch.ppr;
-	switch (trap) {
+	switch (vcpu->arch.trap) {
 	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
 		hr->hdar = vcpu->arch.fault_dar;
 		hr->hdsisr = vcpu->arch.fault_dsisr;
@@ -137,6 +137,27 @@ static void save_hv_return_state(struct kvm_vcpu *vcpu, int trap,
 	case BOOK3S_INTERRUPT_H_INST_STORAGE:
 		hr->asdr = vcpu->arch.fault_gpa;
 		break;
+	case BOOK3S_INTERRUPT_H_FAC_UNAVAIL:
+	{
+		u8 cause = vcpu->arch.hfscr >> 56;
+
+		WARN_ON_ONCE(cause >= BITS_PER_LONG);
+
+		if (!(hr->hfscr & (1UL << cause)))
+			break;
+
+		/*
+		 * We have disabled this facility, so it does not
+		 * exist from L1's perspective. Turn it into a HEAI.
+		 */
+		vcpu->arch.trap = BOOK3S_INTERRUPT_H_EMUL_ASSIST;
+		kvmppc_load_last_inst(vcpu, INST_GENERIC, &vcpu->arch.emul_inst);
+
+		/* Don't leak the cause field */
+		hr->hfscr &= ~HFSCR_INTR_CAUSE;
+
+		fallthrough;
+	}
 	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
 		hr->heir = vcpu->arch.emul_inst;
 		break;
@@ -394,7 +415,7 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 	delta_spurr = vcpu->arch.spurr - l2_hv.spurr;
 	delta_ic = vcpu->arch.ic - l2_hv.ic;
 	delta_vtb = vc->vtb - l2_hv.vtb;
-	save_hv_return_state(vcpu, vcpu->arch.trap, &l2_hv);
+	save_hv_return_state(vcpu, &l2_hv);
 
 	/* restore L1 state */
 	vcpu->arch.nested = NULL;
-- 
2.23.0

