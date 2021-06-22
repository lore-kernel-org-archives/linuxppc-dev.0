Return-Path: <SRS0=MtJN=LQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F8C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 06:04:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A78B60E0C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 06:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A78B60E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8G8738NTz307k
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 16:04:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=VdZ9ob2k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434;
 helo=mail-pf1-x434.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VdZ9ob2k; dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8G7d6QZ8z302y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 16:04:27 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id c8so1725220pfp.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jun 2021 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZgFUyElxbObTCf0884mJ4gJvFix3L87ni5NbC+6yT7k=;
 b=VdZ9ob2kbF4TdQU9UZPENg9vo10l5mZS3YU1CZm3J1lw8zdsM5N9Z2fWzy4UvK+lIA
 a6IKHeutiSITdt+vOGbpssUEQFoVbQeZUQx6AXiIEunzib+hMF2/hSZiOFjXReuAuv/c
 RKdzXB1D0yRIXMEWMVG2lvb9sL8micaDGKsb84rC51uAZ57LELLZ70Xi/zZUGqtEhZJh
 AFyt9GMxTSO4eN1M373NHMlCQQH/uR4/gvmCNNjlZmWakWADq0N2GNGjLcd0LZGIIxej
 5oYxJzkrwW5h2dnqMmNEnyqBaayuKa54AZUcKZDVvxbAot3vl0udHTtF9qPpmf29WAzF
 g8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZgFUyElxbObTCf0884mJ4gJvFix3L87ni5NbC+6yT7k=;
 b=Y0T39KEUtmMeV8T5z+q+Zzyd0ALLHbt/zwT1PZiPtTVKXPnRhR65nK6vauLEtnVKCY
 +yy5PTletWJdmCeEfJ7pyn89ZElTisiVVtr/ZviRVg2g293O+L3UEpWx9XK+VSpPba4l
 TNtOQJUP6giLqA2+9PJGvs6H43Vmk8n/Nnq4LaUb0d7vE6FlRwvCXIwMmG/FPYzoP68/
 XKdHJ2U7UM779eaJElbtbqPkPMqmG9/zUYhc585gSqRwwLC6LhgOZv3AhWDte7P9KeEu
 WIJO4NUDx37PqCaq9lX0FxhGFl2aQzSTIgeKy8pVnCySJnubdvE1LigLH9PdZHm/uLos
 2TEg==
X-Gm-Message-State: AOAM53084vmMcX3rFt/1YzD6CJDmHorkY618I3sHVtt9YDj5JTvGyfOU
 0FVDGS86GeY6xMLB3frpMZ8US11zqEc=
X-Google-Smtp-Source: ABdhPJyTwPwZwaLixHQlFPUj+42tgARuxppZAJmrACGc+a4yb2y5+cOAJpxFvTYUAG3rSUtQE2Dutg==
X-Received: by 2002:a63:d84b:: with SMTP id k11mr2212143pgj.372.1624341863748; 
 Mon, 21 Jun 2021 23:04:23 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id n33sm11394751pgm.55.2021.06.21.23.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 23:04:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] fast interrupts fixes
Date: Tue, 22 Jun 2021 16:04:14 +1000
Message-Id: <20210622060416.548187-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These are a couple of improvements to the fast interrupt exits series
that fit after patch 4. The first patch is incremental to patch 4 and
should be folded in, the second could go anywhere in the series but I
based it on top.

I can rebase it or resend the series if needed.

Thanks,
Nick

Nicholas Piggin (2):
  powerpc/64s: Fix "avoid reloading (H)SRR registers if they are still
    valid"
  powerpc/64s/interrupt: Check and fix srr_valid without crashing

 arch/powerpc/include/asm/interrupt.h          |  2 +-
 arch/powerpc/include/asm/livepatch.h          |  2 +-
 arch/powerpc/include/asm/probes.h             |  4 +-
 arch/powerpc/include/asm/ptrace.h             |  2 +-
 arch/powerpc/kernel/hw_breakpoint.c           |  4 +-
 arch/powerpc/kernel/interrupt.c               | 58 +++++++++++++++++++
 arch/powerpc/kernel/kgdb.c                    |  8 +--
 arch/powerpc/kernel/kprobes-ftrace.c          |  2 +-
 arch/powerpc/kernel/kprobes.c                 | 13 +++--
 arch/powerpc/kernel/mce.c                     |  2 +-
 arch/powerpc/kernel/optprobes.c               |  2 +-
 arch/powerpc/kernel/process.c                 | 24 ++++----
 arch/powerpc/kernel/ptrace/ptrace-adv.c       | 20 ++++---
 arch/powerpc/kernel/ptrace/ptrace-noadv.c     | 14 ++---
 arch/powerpc/kernel/ptrace/ptrace-view.c      |  5 +-
 arch/powerpc/kernel/signal.c                  | 10 ++--
 arch/powerpc/kernel/signal_32.c               | 42 +++++++-------
 arch/powerpc/kernel/signal_64.c               | 35 +++++------
 arch/powerpc/kernel/traps.c                   | 24 ++++----
 arch/powerpc/kernel/uprobes.c                 |  4 +-
 arch/powerpc/lib/error-inject.c               |  2 +-
 arch/powerpc/lib/sstep.c                      | 17 +++---
 arch/powerpc/lib/test_emulate_step.c          |  1 +
 arch/powerpc/math-emu/math_efp.c              |  2 +-
 arch/powerpc/platforms/embedded6xx/holly.c    |  4 +-
 .../platforms/embedded6xx/mpc7448_hpc2.c      |  4 +-
 arch/powerpc/platforms/pasemi/idle.c          |  4 +-
 arch/powerpc/platforms/powernv/opal.c         |  2 +-
 arch/powerpc/platforms/pseries/ras.c          |  4 +-
 arch/powerpc/sysdev/fsl_rio.c                 |  4 +-
 arch/powerpc/xmon/xmon.c                      | 14 ++---
 31 files changed, 193 insertions(+), 142 deletions(-)

-- 
2.23.0

