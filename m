Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDADC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 19:41:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F332074B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 19:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="cIXAUZoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F332074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B74PW1C0KzDr84
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 05:41:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=dabbelt.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=palmer@dabbelt.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=dabbelt-com.20150623.gappssmtp.com
 header.i=@dabbelt-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=cIXAUZoE; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B74ML1f3PzDr5T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2020 05:39:24 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id q17so4159876pfu.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=jFw/ClOpq5T+sEE+HkoHP8FUQXO2g2TMYTCx3LN9u+U=;
 b=cIXAUZoEl+VbWqI+bWZ6UNd/b6CjlQlebzn7F51ygg732VKsNUyl7DvsnIq/q8CnRD
 MWyO5PEAVK+AkyuS5IIP160Qpqg2RwaJbiuHaOqIGaOUrKwLZjyuK6YPwi3I3c9OqjPX
 uxs4LYz/vya0GQfg8gs6V7ZoR51P/Vj9BNpDc7Q/ocU7sDI+m+K1wqHn6n/tbTWPr2kl
 CJXmyuKlnDiQDAXaXdlljeJaPSGAfOvtQS3iU3y20mg5hEoBJ0exCxREj9zx5TbYnuhl
 21YpvR8/8GOndAJMOSKUAdZD2btafq3qF0kFteV1b9ieb06F9FRiy+fJiW/DOY6PNdcv
 fjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=jFw/ClOpq5T+sEE+HkoHP8FUQXO2g2TMYTCx3LN9u+U=;
 b=p1luWFJG5PVHeoEehfiM3mr0s2zHG6iJyazRyTwv7ukIL8USTljzwPENymnVMepvIM
 4eXl21Y8exsKosP/PCgD+qA5UbkeU35MKCksILeT/zP4r6BgAXhYrUiGPwSIYdKqWFRI
 4v/2eq9+3weTSowz9vDyv2GrnchYKu0akGpRJNJFGm9YxBWOKuTtYIGC00F40CaLjkaw
 NduX1wfmw4BY5bou/t0Aq6MUAZ3rC4i7kFf+CYaOHYmuuSi+HzUuJQDygIFuUm5JaP6I
 SGYYdnu4oxCKOozJV3gqZ2SXIFTAiBP7oRLTL2AQFCsYkVqU8kxic1M+tOgzDkch5yHj
 kDJQ==
X-Gm-Message-State: AOAM532ixXoU479Rh9Yk1S4T3AuKFpNrSVlrYWcQoKyB674ICZhq3X3j
 y1Eu5JwFx3wzcGi/Adl7Sxu8rQ==
X-Google-Smtp-Source: ABdhPJzVTejMe5736mG+GTa4x+WLCBZjws2DJXmE8I5MCTTJ/dLjlEKKrmiobrsE6CR38PDoJ0gZig==
X-Received: by 2002:a63:7e55:: with SMTP id o21mr5702707pgn.263.1594928359698; 
 Thu, 16 Jul 2020 12:39:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id 129sm5351398pfv.161.2020.07.16.12.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 12:39:19 -0700 (PDT)
Subject: [PATCH] powerpc/64: Fix an out of date comment about MMIO ordering
Date: Thu, 16 Jul 2020 12:38:20 -0700
Message-Id: <20200716193820.1141936-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Will Deacon <willdeacon@google.com>
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
Cc: kernel-team@android.com, bigeasy@linutronix.de,
 Palmer Dabbelt <palmerdabbelt@google.com>, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 tglx@linutronix.de, msuchanek@suse.de, jniethe5@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Palmer Dabbelt <palmerdabbelt@google.com>

This primitive has been renamed, but because it was spelled incorrectly in the
first place it must have escaped the fixup patch.  As far as I can tell this
logic is still correct: smp_mb__after_spinlock() uses the default smp_mb()
implementation, which is "sync" rather than "hwsync" but those are the same
(though I'm not that familiar with PowerPC).

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/powerpc/kernel/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b3c9f15089b6..7b38b4daca93 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -357,7 +357,7 @@ _GLOBAL(_switch)
 	 * kernel/sched/core.c).
 	 *
 	 * Uncacheable stores in the case of involuntary preemption must
-	 * be taken care of. The smp_mb__before_spin_lock() in __schedule()
+	 * be taken care of. The smp_mb__after_spinlock() in __schedule()
 	 * is implemented as hwsync on powerpc, which orders MMIO too. So
 	 * long as there is an hwsync in the context switch path, it will
 	 * be executed on the source CPU after the task has performed
-- 
2.28.0.rc0.105.gf9edc3c819-goog

