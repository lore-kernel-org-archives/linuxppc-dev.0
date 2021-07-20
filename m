Return-Path: <SRS0=3PPi=MM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E036CC636C8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jul 2021 14:15:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E20660D07
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jul 2021 14:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E20660D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GTgjX5M65z3bNs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jul 2021 00:15:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=kp1D6UnM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036;
 helo=mail-pj1-x1036.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kp1D6UnM; dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GTgj21hKMz30D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jul 2021 00:15:16 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id
 g4-20020a17090ace84b029017554809f35so1980156pju.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jul 2021 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9W5kr9cxG7EzUCazAbzAw+mUR76nZ5zxmtbgj+8doKI=;
 b=kp1D6UnM5/7/BKvwTv+BFiKt3bnHMr9i1P+Jk0GGMFDKTK7Zx1as+C01ym1muYbaIN
 9xnOXNITw0R+2SpWsuljez7/hPg/t5e/bAhYKM9zcLnqfUVaU19bPj3VQMHHXk32Re8d
 4uUMXuUVlT7QEaJU8rKIshmWGWvr8w3r9XtpBOckZ4CU2uXcioinL3dlXn3iSuQVZ1tk
 2/lXFHbRkYgAptRNWQH85/G8T+PlCd4o2fnuA1p3acfXYKRtfVVXWPI/UxtJy/hIKsY9
 qKKotYxGwHfqEkFuERARhVk3AD23j9Hhlsp6HVjHKtU2eDRMI019lnXwRRPjTMQEeyDE
 hkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9W5kr9cxG7EzUCazAbzAw+mUR76nZ5zxmtbgj+8doKI=;
 b=XS77rDSD8cwNcVm8VfuHHRqVpZq74HqonVlCQjKfj3e6wIDREbXq+ui0bvrTmoYPaz
 V6PSQ2pvNvpYReYX7EJoXOJAQ8m3kB6KkfNzpGcHcQxR5iV6H/Iw+/sJ/sbtw4/NwX1b
 ZGJnTC295PjhvZqKqTi/6bZyd7VQNnT6w27emrwMfzVyFVlYpg7JSSXJAf9HJVboDD6A
 iKLS7gBibO4f22L9CEVhCm4acQ30A1Qnj9NzbsOvBiAK0cCMzLByq1VmiQEk9K4+9rGf
 +wXcG+RVTQMTTZgRvYwL3xeB63NPF2eegwJr2HN53dyvErvCwqCFXxeHcZCvMHxn72lN
 Htew==
X-Gm-Message-State: AOAM5314UeX1A1nOYUBAhB0RyoOJghyDp/vPg7RLtJiwep8X76ozjHfM
 II56iHRxKnn+kpZW2Bk2nrrtEEBz9w8=
X-Google-Smtp-Source: ABdhPJxaAzFEM75Pxw1oGS78CnbNeHfvbLagrnXMmJyNsvep5ApQpAf5bbkXA2HgkZ0wKFfCWrdwVg==
X-Received: by 2002:a17:90a:3f87:: with SMTP id
 m7mr35881824pjc.128.1626790511504; 
 Tue, 20 Jul 2021 07:15:11 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (27-33-83-114.tpgi.com.au. [27.33.83.114])
 by smtp.gmail.com with ESMTPSA id
 u8sm3125357pjf.20.2021.07.20.07.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jul 2021 07:15:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s/perf: Always use SIAR for kernel interrupts
Date: Wed, 21 Jul 2021 00:15:04 +1000
Message-Id: <20210720141504.420110-1-npiggin@gmail.com>
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
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If an interrupt is taken in kernel mode, always use SIAR for it rather than
looking at regs_sipr. This prevents samples piling up around interrupt
enable (hard enable or interrupt replay via soft enable) in PMUs / modes
where the PR sample indication is not in synch with SIAR.

This results in better sampling of interrupt entry and exit in particular.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/perf/core-book3s.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index bb0ee716de91..91203ed9d0ff 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -340,6 +340,13 @@ static inline void perf_read_regs(struct pt_regs *regs)
 	 * If the PMU doesn't update the SIAR for non marked events use
 	 * pt_regs.
 	 *
+	 * If regs is a kernel interrupt, always use SIAR. Some PMUs have an
+	 * issue with regs_sipr not being in synch with SIAR in interrupt entry
+	 * and return sequences, which can result in regs_sipr being true for
+	 * kernel interrupts and SIAR, which has the effect of causing samples
+	 * to pile up at mtmsrd MSR[EE] 0->1 or pending irq replay around
+	 * interrupt entry/exit.
+	 *
 	 * If the PMU has HV/PR flags then check to see if they
 	 * place the exception in userspace. If so, use pt_regs. In
 	 * continuous sampling mode the SIAR and the PMU exception are
@@ -356,6 +363,8 @@ static inline void perf_read_regs(struct pt_regs *regs)
 		use_siar = 1;
 	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING))
 		use_siar = 0;
+	else if (!user_mode(regs))
+		use_siar = 1;
 	else if (!(ppmu->flags & PPMU_NO_SIPR) && regs_sipr(regs))
 		use_siar = 0;
 	else
-- 
2.23.0

