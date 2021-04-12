Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACF0C433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 01:53:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E446610CB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 01:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E446610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJWwJ0Ncjz3dPv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 11:53:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=qTMiMu74;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036;
 helo=mail-pj1-x1036.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=qTMiMu74; dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJWqy5gvTz304V
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 11:49:18 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id t23so5789891pjy.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 18:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qHa7loSaCaOe2yFractxh5MmgHLG7n6qdLPHRqtdv+o=;
 b=qTMiMu74C3cU7uIFkilT1+fdbkAhrt4ePW3vZD7pt2vGMQR63kuv9Y/ZyPOQh5i+Cp
 H6RJhtD9uB/idaD6j7WsiQYletAT4pRHb6pAt3DZX6uwAFPBlFV4rMPrR+TxojRhlhC2
 TF6PjjjCn81qqvIPxiTyi7GBlKY785mX6tmjSurLBA0PYE7OtxKuB6cn5QOfOW9MmzEp
 Dva4Z93i3Xyp/F/O4T7MsKcwMDLEdm323+FcteSrXO0W0aHZTp49XKGYejdXUgBWFD5x
 3wmZ47JVlKE5a2BCirGvQiCZfQBjgSByslE3923G24MNzVSRCaFPZOC0VnD9pi97EEhF
 bhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qHa7loSaCaOe2yFractxh5MmgHLG7n6qdLPHRqtdv+o=;
 b=jozoC46tzzT+8pzhAQtV1zIs6C4FXPEn8kE8/Ni/xeYPvkUNhrVplrYrAq6Fp8KSBT
 fFJ3lQ4u7adJcG/R9ap29wP0zcPbFT1BWrBygHyizOAG3J/X6lDwEfuMWwWmTC6duJAV
 k4TeCQHrm3cmsIkFjvNFm7FmLvetvY2lG/Fsba1lXIWfc6E3h5o7cVVXbzH+5WvxiUEC
 bez4YWlirkixRj1sHoOmngYzv4WXpMq/a0DXcK0KFoxlJpBN6dIjm30pyOHIM00PivMY
 LJUu2w0T0P2FarvxRSH2r/fMmjhjIRpAF0OlOmniyhUBwMPCP1WJzr3ihFE4i+zsCLXK
 abMA==
X-Gm-Message-State: AOAM530JaezaWeqegXHQ1vNSlMakOqw6MPEg2JSxOCBRmo/Mxj5vZZd5
 FXB6p+BvtpuRXvAmcyHjvaU=
X-Google-Smtp-Source: ABdhPJxsRw68Kuw9UM06lABNNgAc4DSU7v570Xv3VuVAxUNmDP4QdjaKk9VHiw+fQkRyT7bibRSJlg==
X-Received: by 2002:a17:902:b483:b029:e9:eef4:4f16 with SMTP id
 y3-20020a170902b483b02900e9eef44f16mr14075893plr.38.1618192156440; 
 Sun, 11 Apr 2021 18:49:16 -0700 (PDT)
Received: from bobo.ibm.com (193-116-90-211.tpgi.com.au. [193.116.90.211])
 by smtp.gmail.com with ESMTPSA id m9sm9502345pgt.65.2021.04.11.18.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Apr 2021 18:49:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 08/12] KVM: PPC: Book3S HV: Fix CONFIG_SPAPR_TCE_IOMMU=n
 default hcalls
Date: Mon, 12 Apr 2021 11:48:41 +1000
Message-Id: <20210412014845.1517916-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210412014845.1517916-1-npiggin@gmail.com>
References: <20210412014845.1517916-1-npiggin@gmail.com>
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
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This config option causes the warning in init_default_hcalls to fire
because the TCE handlers are in the default hcall list but not
implemented.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index b88df175aa76..4a532410e128 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5412,8 +5412,10 @@ static unsigned int default_hcall_list[] = {
 	H_READ,
 	H_PROTECT,
 	H_BULK_REMOVE,
+#ifdef CONFIG_SPAPR_TCE_IOMMU
 	H_GET_TCE,
 	H_PUT_TCE,
+#endif
 	H_SET_DABR,
 	H_SET_XDABR,
 	H_CEDE,
-- 
2.23.0

