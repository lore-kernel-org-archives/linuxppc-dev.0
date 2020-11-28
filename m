Return-Path: <SRS0=bT9L=FC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D9CC63777
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 16:16:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC542224D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 16:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssXbLd8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC542224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjxTC2S6bzF0fL
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Nov 2020 03:16:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ssXbLd8Y; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cjx8d5h39zDrQh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Nov 2020 03:02:25 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id x24so7086208pfn.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2020 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qp8PGJSLWU/dwswnH2/0kSDHsb+wln5XeqPaVW1B5Z8=;
 b=ssXbLd8YUR2ZIFy9Jd8hXHpF+Y+ZgoHlIRFX9zhsrsp+ZLU7bKlg7EuG2lSdedrjvR
 wE/qE7l+MWwYSzP1wi8Op9LZacYNj0TFM33blDINJeQw3k661TnuMoVq1P9kWsUpYm2L
 GU+Rh70ojG5i/bX6AWDs/ACxCKMtupmq6KLpdZta42wvOGpj65dxqcLBcKS1XebjeT2g
 HWp9e3wV/L0EXL2Ys40bmy1FkuapWC6KRItPGmNgSBbEo8WylcMXRQEawZThlVjdjrJU
 +e772jc+1LXeLO7pSn+jmxQ4ISH3MsydjpyvNtpmhbzBrVbHsQbAlOUzcGpBsv2LoBoI
 u0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qp8PGJSLWU/dwswnH2/0kSDHsb+wln5XeqPaVW1B5Z8=;
 b=OZAwcLp27PeALU3M+0jDXRgCnfhK4eEiY3Bpx5ydy9T7SC/CmHxQVIPJr3uYp7+KoT
 8tQyM0JSlGSJwOoDQQYYu/6lgJGtQ+eV5wqXP2Xx/3uTTcxXZCihAPzGUQZqGQG6lHiu
 hZCb8yYs0sT0h3eCKpkz/7hEuyvrZTRV+Mk2qBKOWlYYBUvQ+N1HyZ6+VG7G401ueZh4
 MUyUMd0twj9AByyAVWY/liuPcCLAj/6/zl0r3KDVBp4F8qysRjNReaptIV362nL4rZ3K
 P9elkSoj5ankr7lPUPPNkKxHnOI2PTrSPX2B1f8zHjMEiO0uSCTKbkS7BkCdgrbZCQ7y
 Y3Hg==
X-Gm-Message-State: AOAM532j+7I3ElkJq05sq7C5OOnAoRGEOOo8PEZEcJMXDucTbiq3sROU
 uhbagqykhhtpujPOuyxSPd3S+0pe48M=
X-Google-Smtp-Source: ABdhPJw9UtKcgVJk5VujOdxJVrz6MfFXjvC+/8I9Mi89OeiWtMkzRMjtujCg4EGW63Zc1A5/CzokHQ==
X-Received: by 2002:a63:4956:: with SMTP id y22mr11011753pgk.266.1606579343363; 
 Sat, 28 Nov 2020 08:02:23 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
 by smtp.gmail.com with ESMTPSA id d4sm9762607pjz.28.2020.11.28.08.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2020 08:02:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] powerpc: use lazy mm refcount helper functions
Date: Sun, 29 Nov 2020 02:01:40 +1000
Message-Id: <20201128160141.1003903-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128160141.1003903-1-npiggin@gmail.com>
References: <20201128160141.1003903-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use _lazy_tlb functions for lazy mm refcounting in powerpc, to prepare
to move to MMU_LAZY_TLB_SHOOTDOWN.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8c2857cbd960..93c0eaa6f4bf 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1395,7 +1395,7 @@ void start_secondary(void *unused)
 {
 	unsigned int cpu = raw_smp_processor_id();
 
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm = &init_mm;
 
 	smp_store_cpu_info(cpu);
-- 
2.23.0

