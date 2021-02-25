Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27591C433E6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 03:11:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE46E64EBA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 03:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE46E64EBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmHqc72m0z3dB5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 14:11:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=ovCLvFtH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=ovCLvFtH; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmHpf0pB9z30Nj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 14:10:18 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id t9so2634550pjl.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2021 19:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PTxNlo+m5ZmgkK9pyNgC4wq//rbl5nxKXVnIv+SfOKc=;
 b=ovCLvFtHB69T2PeHByKpcTrAi1cTUmyt1AxWo/cZ9PrcNfPY6M1NBFBTMv4eNPMMmV
 KUXsaGa/6UgbGZSiv8R5aFevhUsaC2TKIn53trSsDR2ey/5mlzRHoE1hUA372DgtzShK
 DkmNxyAO+gm7v/GV4FFHe/+UCelfOxS0ONi20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PTxNlo+m5ZmgkK9pyNgC4wq//rbl5nxKXVnIv+SfOKc=;
 b=RLYrzwDYGT6YsdCy/92LKLol2XGWVBqKtgZLT3JvgjJwP0z4+mY3kh8CPqjqQuX1ud
 +CQMBBOZHo3ZpLYnySD/vc9KbsTZIfYNA8AvJ7Yb7j2fpSEgEhEL3yvR6GY7aKSy42Tr
 exjcp3Q19EB8exDJO9o077jpHH2RspxT0wSRSYUShd9FkuR6gL7pb3sFyqx7BP7Ix5aV
 sBKpA7sJd9jChGR7AVROkzFmm6vXD9sLne7fJm81Y1VFOfN9CXGnm6JquoC2WtsfhXZk
 EfaqvXdein22u6X7QoKNKG49528XvnGstK5q7XS9NL6MgbXHJu3QAugc7xF/S92Vg+WN
 vivw==
X-Gm-Message-State: AOAM532S0qmhoIC8CM5tvs6Q1J63l82+0eYO4zBuvdZ8hFoiw4C1v/nG
 zu7yx2U0Y+okJCGHR0nnAJxFTW1oeS60+XfL
X-Google-Smtp-Source: ABdhPJzpanU0C/8sq+nARiDgeCvXt4mABbFG37EgfGVdT2NrgsqgOUMTRbo4TI+LI0qs/YtT5gH4gg==
X-Received: by 2002:a17:90a:8b02:: with SMTP id
 y2mr1053154pjn.111.1614222615719; 
 Wed, 24 Feb 2021 19:10:15 -0800 (PST)
Received: from localhost
 (2001-44b8-1113-6700-6e65-7e50-8dac-f7ef.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:6e65:7e50:8dac:f7ef])
 by smtp.gmail.com with ESMTPSA id ch14sm4043943pjb.22.2021.02.24.19.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 19:10:15 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: llvmlinux@lists.linuxfoundation.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] powerpc/64s/exception: Clean up a missed SRR specifier
Date: Thu, 25 Feb 2021 14:09:59 +1100
Message-Id: <20210225031006.1204774-2-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210225031006.1204774-1-dja@axtens.net>
References: <20210225031006.1204774-1-dja@axtens.net>
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
Cc: Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nick's patch cleaning up the SRR specifiers in exception-64s.S
missed a single instance of EXC_HV_OR_STD. Clean that up.

Caught by clang's integrated assembler.

Fixes: 3f7fbd97d07d ("powerpc/64s/exception: Clean up SRR specifiers")
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a4bd3c114a0a..720fb9892745 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -466,7 +466,7 @@ DEFINE_FIXED_SYMBOL(\name\()_common_real)
 
 	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
 	/* MSR[RI] is clear iff using SRR regs */
-	.if IHSRR == EXC_HV_OR_STD
+	.if IHSRR_IF_HVMODE
 	BEGIN_FTR_SECTION
 	xori	r10,r10,MSR_RI
 	END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
-- 
2.27.0

