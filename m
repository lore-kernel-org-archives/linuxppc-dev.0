Return-Path: <SRS0=g7Ik=KX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1497DC47087
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 09:20:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C6B6128D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 09:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C6B6128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Frzg44K94z3fnX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 19:20:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=LedHizTr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d;
 helo=mail-pg1-x52d.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LedHizTr; dkim-atps=neutral
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FrzQC1QBZz307D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 May 2021 19:09:07 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id i5so2096687pgm.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 May 2021 02:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GSMIrgysRSkOkp4L4aVB8mc4VHaDXOZCGHsPewIvbA8=;
 b=LedHizTroFgRR5ywA8cOg3uA2Y0eDCVNHPpf17QPUlkvxRWVcF+cHJwz3q3Hu3D+rQ
 3OmCCa98eny05JCxZkvU+B+5TSe1XGrUrUpGqARS4YyzjTs0d0Rf4rwQs234DA2Xe0Jj
 /CpUfIM6jpzZXN/2J9jfioL9b95WlPkA6qFHrmOzFxP5POEtsm2nM56vfvjjMrSRTugP
 tSHar+YQ0vJbFBaufc68+YVSatZo/yEM9iNFcfLJWSRYLx0iiYNQAiwqYiKpoJ1/V0Ct
 E1pW43rX8UZD8qrC07dz4Kpj0uj0MT40Vn4y7pWU5sZVl89CueATS6n6/CbARflJu4WT
 fTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GSMIrgysRSkOkp4L4aVB8mc4VHaDXOZCGHsPewIvbA8=;
 b=CpAfYuaFC/DBHORVbd14888nxOYHeq49AmeUsyljvIqeLjasltroTvwet5rov1mg7H
 ZtnrylFFvPu2r/9FcEiHrZluGqHd8owJD3HtHLj17Xgd8PGx6xf7fGNlDnyM6qPlrtDi
 dw409MYlXZ8JoCjdCyLDvU1W9v3gkc7Fb7by3GlE8i24C7gAxSLutmg5HUItqnX3YUfN
 l6kmghnqjOhcpUacsZ7Kaf+wkuZb8Spi8Zq5u4QxhJrZ4jxDuVBxN0yCW96SSbflInge
 ZE6PgEbU0I0i7hd/yKKoGckji3WkBEaCqy29is7Tij+E0JGUN5PMO9UXLqqkko00DLlL
 9grw==
X-Gm-Message-State: AOAM5333RG+kVYVl8CGl/4bOQz7y7EMXPmOIofS8VisBYQLGxif/ceuN
 YNKVLdoTapk8oFzCyfxpccA=
X-Google-Smtp-Source: ABdhPJwSE4XnFc6bO85yhCiAtiHvPZnVJy2QSVEZNx5HtLjHrU6fXQRn1uB5xW7tuW9K8P1/mAiM0w==
X-Received: by 2002:a63:3dc5:: with SMTP id k188mr7894694pga.140.1622192945167; 
 Fri, 28 May 2021 02:09:05 -0700 (PDT)
Received: from bobo.ibm.com (124-169-110-219.tpgi.com.au. [124.169.110.219])
 by smtp.gmail.com with ESMTPSA id a2sm3624183pfv.156.2021.05.28.02.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 May 2021 02:09:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v7 26/32] KVM: PPC: Book3S HV P9: Allow all P9 processors to
 enable nested HV
Date: Fri, 28 May 2021 19:07:46 +1000
Message-Id: <20210528090752.3542186-27-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210528090752.3542186-1-npiggin@gmail.com>
References: <20210528090752.3542186-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

All radix guests go via the P9 path now, so there is no need to limit
nested HV to processors that support "mixed mode" MMU. Remove the
restriction.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index acb0c72ea900..cf403280b199 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5451,7 +5451,7 @@ static int kvmhv_enable_nested(struct kvm *kvm)
 {
 	if (!nested)
 		return -EPERM;
-	if (!cpu_has_feature(CPU_FTR_ARCH_300) || no_mixing_hpt_and_radix)
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
 		return -ENODEV;
 
 	/* kvm == NULL means the caller is testing if the capability exists */
-- 
2.23.0

