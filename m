Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA2C10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:38:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266452084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFRoasOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266452084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fmvk0PwtzDqP4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:38:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GFRoasOJ"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fmqx6d3yzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:35:09 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id c207so2714928pfc.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OZv6hPSdAHA1swD7FEOslfLZwpmxkzvHikN4MHT7irA=;
 b=GFRoasOJpQPhb1awaLCimBo3kHfJqM/1lwpjAHrqrbcV2K+UypQ9VoQ4tqQFmPBjXG
 8cFfeFW2+OteM9nQdV1xiJGEH0T2q77N39kDTdDvrAdSFHmP71mkI6SvQo6M8rP5WP/S
 hwAF3woe91WxKgGqQzX0eAeqwt7XapDdM+GNHU245hYv72pf0iH/2zVyggIe8s3x/oC5
 2y7pblvESq1nEX0tlN0U0nZSHhGN4kenlzLA7eqyV8j2WV8RuXaA4iPhbDsWgsYWtg9R
 j7kPVDVZBztHEo/NXUdDULwsHooEdlqV2RnDFg0Ym2QyHpikiwo8oKB3NXqM+IBZB40/
 l+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OZv6hPSdAHA1swD7FEOslfLZwpmxkzvHikN4MHT7irA=;
 b=icmz+TeYQaj+5BNvxbGewEnV43buabcCutUCQqPLkylOuHzSlBkzhaMW/axzRWpnzI
 VPxOQMbL3Xl1WgqGCONNRwAyThb4RGyVgCEE+xW/cK1KdC0vccUt6Co3Yv13WzYMrLDa
 px1oJMPSmX3iL+5cD5SjY0L4f3On8EQmVNR+Aq8E58zGQrvFphaLP3SEMpDv6uzoaaQm
 MKznkZbsdmYTKo71qR75814tmcv+VJqi/yK+TRVUcAsq5f0F4AlpgZrwuyyHp9JyOXPL
 8SEJeeyKXyrN9OF4UfnZ0ymMj9i8hI68o8RXS+TF/KqTcfXYtHEh8rdUsdtx8WMWhMdX
 Galg==
X-Gm-Message-State: APjAAAWGi6/N1JWpkTHfWN5U/8fMU3vCrBPkakRIocoFXqvWC2e6n99u
 Y9nBiELVVcd0XJXNS1fI9j9S6msAXdM=
X-Google-Smtp-Source: APXvYqwsc0FdRw26an9Arfnk9WRkzB4Ut2g6Vqasz3X3ajdkvlglSDeRCCpSAsQLD70uhmqFVpdwhw==
X-Received: by 2002:a65:64c9:: with SMTP id t9mr44251725pgv.221.1554953707587; 
 Wed, 10 Apr 2019 20:35:07 -0700 (PDT)
Received: from bobo.local0.net ([203.63.188.231])
 by smtp.gmail.com with ESMTPSA id b9sm37231416pfd.32.2019.04.10.20.35.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Apr 2019 20:35:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH v2 1/5] sched/core: allow the remote scheduler tick to be
 started on CPU0
Date: Thu, 11 Apr 2019 13:34:44 +1000
Message-Id: <20190411033448.20842-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
References: <20190411033448.20842-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This has no effect yet because CPU0 will always be a housekeeping CPU
until a later change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..10e05ec049b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5918,7 +5918,7 @@ void __init sched_init_smp(void)
 
 static int __init migration_init(void)
 {
-	sched_rq_cpu_starting(smp_processor_id());
+	sched_cpu_starting(smp_processor_id());
 	return 0;
 }
 early_initcall(migration_init);
-- 
2.20.1

