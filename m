Return-Path: <SRS0=S2bx=J6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C6AC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 May 2021 13:03:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98154611AC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 May 2021 13:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98154611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FYjpW0p5mz3bq2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 May 2021 23:03:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=r/TQBZvc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434;
 helo=mail-pf1-x434.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=r/TQBZvc; dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FYjnX0tBqz2xZS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 May 2021 23:02:54 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id v191so4031070pfc.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 May 2021 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7U/Bo9+3wof6VuFTXdCACGU/D8iEr1wLRCC9uuwzsF8=;
 b=r/TQBZvco86GOC7/tu4dHB9hmu6lXVjwQPo7cnRWg4h3reI6eTK7gr4KARp+L70uQ4
 DBsNG6yJlS1YktjfCVPOy7ntXQ6hzZfSvDpzlwMK4EkD7ccAeCRsMTaAqLdl2LLAYxkX
 VmJ0gk/D5fqJ32l6Hkz27Rc9olsj7FUmiMh0CWCrhTm3H6YUgqf3+kElQA1cGTUByrEg
 6TmyGHfMbpUY2fzp2wA3nG/Mlp1zVPHGuTOTf7OKo28FBh/P0pSrQ5+ZcosNvBQQ5RWE
 bzJXFtiuaGa0W7IxPV4gG6xiZgatb1I4tm2E2NuIAQ8U2CRwZ4c+NEp1HJg5P+0Axx2z
 aOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7U/Bo9+3wof6VuFTXdCACGU/D8iEr1wLRCC9uuwzsF8=;
 b=fifuvsmEJ3VL8mxd+uj57et7mnAg0M/5Lyr3KtHWMAMAKFTB/CH8SiNTVS7FEHKQjM
 SqohKvtwOuqEUseKFg2Dn2U6zIBm5AcUtILd4+djHxnlHV+akH+DAztzKhXyu2DJJA7U
 Msg4mnH7iR86aTriWjvJmFvVb31hrafEdItziCAMY0XbI8ao8jVUEqVGss17L+rSGR2k
 dj3yXzEDdfm/Muf4lQt8nqkcgQoNsiLB83OjmT43h0y+PXTq4Cfi3vxNgkjA+CuiT2mg
 pw8NI0i4R90/XYwZMdTrNXRP1CA7drohfb+uYSgqBiB+KVtrJuKcgNdW/LCDlQEH9MgS
 86wg==
X-Gm-Message-State: AOAM530XYFwh9UQkvCGHJ2OojnT6ng/vY68Ci7nSppTAtuUltbfQlJTi
 Td0+aMpkwAAZPkvsUeO3RnlKD0AWE+M=
X-Google-Smtp-Source: ABdhPJyHbmGNt5TO4d+GxikWsWl5BP2ZjIGunIYy/m97w/XYhFzIGNxZXK8t/1CIVVuwossQhUv57Q==
X-Received: by 2002:a62:3344:0:b029:28c:6f0f:cb90 with SMTP id
 z65-20020a6233440000b029028c6f0fcb90mr16697167pfz.58.1620046971668; 
 Mon, 03 May 2021 06:02:51 -0700 (PDT)
Received: from bobo.ibm.com ([61.68.127.20])
 by smtp.gmail.com with ESMTPSA id f1sm18069053pjt.50.2021.05.03.06.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 May 2021 06:02:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/pseries: Get entry and uaccess flush required
 bits from H_GET_CPU_CHARACTERISTICS
Date: Mon,  3 May 2021 23:02:40 +1000
Message-Id: <20210503130243.891868-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210503130243.891868-1-npiggin@gmail.com>
References: <20210503130243.891868-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This allows the hypervisor / firmware to describe these workarounds to
the guest.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hvcall.h      | 2 ++
 arch/powerpc/platforms/pseries/setup.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 443050906018..f962b339865c 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -393,6 +393,8 @@
 #define H_CPU_BEHAV_FAVOUR_SECURITY_H	(1ull << 60) // IBM bit 3
 #define H_CPU_BEHAV_FLUSH_COUNT_CACHE	(1ull << 58) // IBM bit 5
 #define H_CPU_BEHAV_FLUSH_LINK_STACK	(1ull << 57) // IBM bit 6
+#define H_CPU_BEHAV_NO_L1D_FLUSH_ENTRY	(1ull << 56) // IBM bit 7
+#define H_CPU_BEHAV_NO_L1D_FLUSH_UACCESS (1ull << 55) // IBM bit 8
 
 /* Flag values used in H_REGISTER_PROC_TBL hcall */
 #define PROC_TABLE_OP_MASK	0x18
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 754e493b7c05..287f33645419 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -549,6 +549,12 @@ static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
 	if (!(result->behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
 		security_ftr_clear(SEC_FTR_L1D_FLUSH_PR);
 
+	if (result->behaviour & H_CPU_BEHAV_NO_L1D_FLUSH_ENTRY)
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_ENTRY);
+
+	if (result->behaviour & H_CPU_BEHAV_NO_L1D_FLUSH_UACCESS)
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_UACCESS);
+
 	if (!(result->behaviour & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR))
 		security_ftr_clear(SEC_FTR_BNDS_CHK_SPEC_BAR);
 }
-- 
2.23.0

