Return-Path: <SRS0=Fnpn=NH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E986DC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 08:33:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC1861B21
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 08:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DC1861B21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gp6qt1ngBz3cX6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 18:33:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=N6f7Yswk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029;
 helo=mail-pj1-x1029.google.com; envelope-from=joel.stan@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=N6f7Yswk; dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gp6p60jyjz3bWS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Aug 2021 18:31:41 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id
 w13-20020a17090aea0db029017897a5f7bcso26208980pjy.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Aug 2021 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d9JrVAkdSMVbC/HBVkCccWsydVJtIdh5qQXcFgOlh3w=;
 b=N6f7YswkZGpCAhBNOwkK64InCQDDfF6doJzXolvb8bXLENEhSi7uTzAKEMn8J0lY41
 t5UgL0E8Zfm/BppdirhuauuC1ZK19dr0cKPrG8g0dtTC28+eHi7NiyCMkJYhSs1WyeY/
 DE44FvO8AxRQNYoCMcs7QaXDbLB6v/Zr+AbsD7tze9TQoWYM8kSKsSMQ8hYS+FQA9LQB
 txZMFstzrTV94IzNeYcdl2P8zVJ76zH91vD5YVDoNCBjJbOf0Dxs7l3sa3VLY3u5/Pp8
 5uV+JYWtvbKsw/NDExkYX/4HOMUpQcuzpSWiorVChgG3ZkB8zfSvHKcdoq7hTZj/siY5
 Fw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=d9JrVAkdSMVbC/HBVkCccWsydVJtIdh5qQXcFgOlh3w=;
 b=htYKubuO4vVEaXkchcysu9M0NA10mDMF8wTKZ97R52Oh/pbZvlc0xNIGR1W6bexfwr
 uTaSZthtA6kCYpuf1qGSc9R2k3JLtPhu7fkbQHuQRxx7mQg4erpL7DrRpSRReR0za7ZN
 bxVHNn395T1p4UqFfRvaNOaPj9mSxP8tBhT/GtlC/VdFP1vKCpEBmaZAs+4rP2zPP5ys
 D1/0FbIYLhIZrrDbTeNABwD96l4OfNCf/OiPlf8xTc60jRUZpWWJx5qTArzjhKnGpULb
 bEW8x+1xl+vOfdekinsh46lHi6x+VElN0QOg+5xVUxtTtbVNB0jXL54QzlbREDCRkGgu
 CQcA==
X-Gm-Message-State: AOAM530NJGNy1p55Bv5T2NxHoJTFghimVm/ZI71UHJu7MQYxMmf22gkj
 pqTgXJmRC0S0UcCOpIoWMAk=
X-Google-Smtp-Source: ABdhPJwhnwLlp1aSnb7ZsVXLQ4rCJ82TaKllySc91qxiiJzAnUqr7NKndVykBKdBCQfVFITnp8Q/ng==
X-Received: by 2002:a65:5186:: with SMTP id h6mr14910936pgq.62.1629102698902; 
 Mon, 16 Aug 2021 01:31:38 -0700 (PDT)
Received: from voyager.lan ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id mr18sm8715684pjb.39.2021.08.16.01.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 01:31:38 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/config: Fix IPV6 warning in mpc855_ads
Date: Mon, 16 Aug 2021 18:01:25 +0930
Message-Id: <20210816083126.2294522-2-joel@jms.id.au>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816083126.2294522-1-joel@jms.id.au>
References: <20210816083126.2294522-1-joel@jms.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When building this config there's a warning:

  79:warning: override: reassigning to symbol IPV6

Commit 9a1762a4a4ff ("powerpc/8xx: Update mpc885_ads_defconfig to
improve CI") added CONFIG_IPV6=y, but left '# CONFIG_IPV6 is not set'
in.

IPV6 is default y, so remove both to clean up the build.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/configs/mpc885_ads_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index d21f266cea9a..5cd17adf903f 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -21,7 +21,6 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_IPV6 is not set
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
@@ -76,7 +75,6 @@ CONFIG_PERF_EVENTS=y
 CONFIG_MATH_EMULATION=y
 CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
 CONFIG_STRICT_KERNEL_RWX=y
-CONFIG_IPV6=y
 CONFIG_BPF_JIT=y
 CONFIG_DEBUG_VM_PGTABLE=y
 CONFIG_BDI_SWITCH=y
-- 
2.32.0

