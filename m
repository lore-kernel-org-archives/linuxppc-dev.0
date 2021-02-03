Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC781C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 06:21:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6B564F5D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 06:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6B564F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DVs525nVpzDxVJ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 17:21:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030;
 helo=mail-pj1-x1030.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=aQNjtIC1; dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DVs2H3llDzDwrc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 17:18:43 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id lw17so2910628pjb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Feb 2021 22:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+2i/OJyirUwUtJs7uwUG4VGok0iYXcQIUU48u+nuTSc=;
 b=aQNjtIC1YE387Eq4dSCL6c4T5EEdKdgPG4NSjgzx/j5OKTUhjkaSC4+Cefiy4xgLNm
 xZI5YiCNNqeRUv5LnyyndSvdhBum6ABsN4Z45IVhK9AA01FNo04Dy9xO4Bv8vPmHqhya
 e3PMW2jjK6f0qdOxImWocAxzxZIXZYsIbZrrPWcQxUszx0E2QeavinH2HfZoowOcDl6R
 jNMDobhoCPYkg5bLCTe7XzRqDzsc+uWawkTGW1Jqk643q2V6YjtClC2dZWktAa0IKDHT
 na9CvslcvEBgJu6tfmDZv5GG07yQ9+wXA8oNcyK0xqDjPt9DaCqR60ssPBPYJkPYodzj
 KrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+2i/OJyirUwUtJs7uwUG4VGok0iYXcQIUU48u+nuTSc=;
 b=jS3CF/tQWUxABYkyAZNBsRWIITGRLaXs2HcoybKUdPyHoNdV4MngRS1qYGaTYZOCNh
 hlQt7d44xwDXqDDK2C1e7+jxuLim82xUtLqEyvT6iTHIVnU9NAlfUO98CgTQOuIZPMcr
 0bzJPSLEcQCVwLITXH+8W6d85QX32xywFj9KEdSxRaVmMrBpnsHVaN4rj2QbzSx8EEIm
 rDIcP89z0I69uByZZExjSrPf+WRsh0ECpB7MysP+9cD0h/KoVonMH00cXjX/D6ZEHZdv
 hPAFm6P26E7MxzIanqowfgy2HTwS5IutZTuk82Qed5i8LqkWDqVrzAUcwxD4GFtlVhDX
 +2GQ==
X-Gm-Message-State: AOAM530JBR2JcS7I8JLfFwkv747yXV5+drNg19Dn083CLs2l6h57JVOd
 m/Dc9VT9Jgrkoa7HT7o6vkan58359MpdZg==
X-Google-Smtp-Source: ABdhPJyMsXFrhOdLnlG3gHvvUZVg/q45Un2Koi38rauwyGdfucXjnpgNRekiNWyd+pQ/4uh26d3mIQ==
X-Received: by 2002:a17:90a:f2cf:: with SMTP id
 gt15mr1619941pjb.166.1612333120951; 
 Tue, 02 Feb 2021 22:18:40 -0800 (PST)
Received: from tee480.ibm.com ([159.196.117.139])
 by smtp.gmail.com with ESMTPSA id bv21sm595734pjb.15.2021.02.02.22.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 22:18:40 -0800 (PST)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] Revert "powerpc/64s: Disable STRICT_KERNEL_RWX"
Date: Wed,  3 Feb 2021 17:18:29 +1100
Message-Id: <20210203061829.879868-2-jniethe5@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210203061829.879868-1-jniethe5@gmail.com>
References: <20210203061829.879868-1-jniethe5@gmail.com>
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
Cc: Jordan Niethe <jniethe5@gmail.com>, npiggin@gmail.com, cmr@codefail.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This reverts commit 8659a0e0efdd975c73355dbc033f79ba3b31e82c.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 294108e0e5c6..a7113ee85994 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -135,7 +135,7 @@ config PPC
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
-	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC32 && !HIBERNATION)
+	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_COPY_MC			if PPC64
-- 
2.25.1

