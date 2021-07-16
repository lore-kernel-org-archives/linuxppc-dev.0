Return-Path: <SRS0=FVZa=MI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F0AC636C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Jul 2021 02:43:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EF9610C7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Jul 2021 02:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EF9610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GQwY45Lybz3bW4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Jul 2021 12:43:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=hOuzqHqF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d;
 helo=mail-pf1-x42d.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hOuzqHqF; dkim-atps=neutral
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GQwXX0wjLz2yND
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jul 2021 12:43:21 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id b12so7622830pfv.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jul 2021 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dSEHJbd1hey9lHxWnAlObrqe288gDj7m/QSLgChPhgE=;
 b=hOuzqHqFtvdC9hxpQPp5U1GyFTrRbpAW0C/rjfm0F3Ln0k63EjNK032ae3P4kZBLME
 lClk9UUT+g20AEA3B4m67QlEex6ty+DJLLPHB70lQrHM6QezcPkh33Uf2GN8+ji3Hzul
 hN2EyXlfm5i4D8T5vUd76/jD0cPfn114VQE1GcqA3+7OzUMnmXpRBlch+nUtX799CJFU
 qoTf92TemfjtYkXgCdmuI0Dh0v993jxbUim+hxRPMFN0IREk9bcZoX3WlrVZ4DzFMWLi
 FSBo1pCSaLIRINQxEHw+Z9LhH0u0jHnNQ+sT5s8zillbngJjWd72wxvCIQRlhJIkziFt
 1sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dSEHJbd1hey9lHxWnAlObrqe288gDj7m/QSLgChPhgE=;
 b=rEWVE1I6dZ+iE3t3qHjtfbOT4ycSK4mfyWBUQ0I1mDW8jzQOnXbzjur0k0a/+bzkJa
 1OobbfogCLeUQvR/lRwDNidoKXmjoN3U8aRJs/2mtSyVkmJScF5Q7gvRDvrzpyvjj5wV
 HWuXSmI0VDVvvK4YxSvZUzPxyL5cb9tX2uEiuvSkWa4eUhTPMQAch60JELhxRwSdQXFq
 O8PXKTcfeIL18/8a7ft+QmddFV6IV49vjxBiPeQ3CcvS6Q+YiE1L1Mrzulnggyxwk1MT
 wd/O7ZbJLflCwpn2kaFrhvPAblHrCTSVXC8JwuapUE41MG5OS05de/Z+qd8Nc9kDeaVF
 FWlQ==
X-Gm-Message-State: AOAM533PkG+tarUpo0oYO72rcLVvj5PfLlxW3jORqxDz9M5z+mJjK+wU
 RChrF5sl+115ZTN2/nhhABo=
X-Google-Smtp-Source: ABdhPJxcWKuA3kESqcvAKzDHcBRLi5yIGY0dr8pXIg8lx6f0l3oTrMKHYzhwjcqXrbzseApkyub3yg==
X-Received: by 2002:a63:f91a:: with SMTP id h26mr7585259pgi.234.1626403397395; 
 Thu, 15 Jul 2021 19:43:17 -0700 (PDT)
Received: from bobo.ibm.com (27-33-83-114.tpgi.com.au. [27.33.83.114])
 by smtp.gmail.com with ESMTPSA id f3sm8298406pfk.206.2021.07.15.19.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jul 2021 19:43:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 1/2] KVM: PPC: Book3S: Fix CONFIG_TRANSACTIONAL_MEM=n crash
Date: Fri, 16 Jul 2021 12:43:09 +1000
Message-Id: <20210716024310.164448-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When running CPU_FTR_P9_TM_HV_ASSIST, HFSCR[TM] is set for the guest
even if the host has CONFIG_TRANSACTIONAL_MEM=n, which causes it to be
unprepared to handle guest exits while transactional.

Normal guests don't have a problem because the HTM capability will not
be advertised, but a rogue or buggy one could crash the host.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Fixes: 4bb3c7a0208f ("KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 1d1fcc290fca..085fb8ecbf68 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2697,8 +2697,10 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 		HFSCR_DSCR | HFSCR_VECVSX | HFSCR_FP | HFSCR_PREFIX;
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
 		vcpu->arch.hfscr &= mfspr(SPRN_HFSCR);
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 		if (cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
 			vcpu->arch.hfscr |= HFSCR_TM;
+#endif
 	}
 	if (cpu_has_feature(CPU_FTR_TM_COMP))
 		vcpu->arch.hfscr |= HFSCR_TM;
-- 
2.23.0

