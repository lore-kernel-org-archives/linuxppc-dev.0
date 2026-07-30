Return-Path: <linuxppc-dev+bounces-25106-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A63CC55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 12:40:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9pgx69tFz2yhb;
	Thu, 30 Jul 2026 22:40:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785391582;
	cv=none; b=ADwPDET+FjelfWdlmV1YYS8yYXCaOGkghniZi1YyAdamcwsxzGVnwyDJG0J+snh0oawjV4zvDovw/Zcm8B2o2Q05mUoXEPUzvHWPuUmR4tVVmVeMjLDV8JKYjoAh2yPRAcgpmQkC6uVkNVICKXxDThG+B57IMrFbZtY4zefIZ51v5Bcp2VwfJPqrctASCwUJ3BZIgk8O0xF7752UZhk3cZD3Evy7WK9grzKpnT0fgTPdEgErmcs3sjLXiDZZGNLA9PJ3lIQM9QiWVS13aq3gUyLsMl8lRM7lsnn/POblWBDUL+KSGLG49pOgBpTDnKl7E5m1LW69dVjl/RrdYakO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785391582; c=relaxed/relaxed;
	bh=N2BsO/SXniFlM6SCUrq26UllYv+rXm0p9PUXKwY1gig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jICnXrCL+6aKKGMbN/UQ/cdSgO5FmyEzZVlkzgel5XLHX2PacsVFOApvsfj6yFqLzLGKqbFEWWikdIw4E3nx15C6JX0VSyrh1wrCKOpcW3SjiUQLi8BS/eDmrJ5zbeFrYhXTZa6cQMyYVbO7lnouHwS/eaMZEzRKeyeHPtonBNla6493JYeKsx1mbyScLXrQIRnumIR+Mcl+uWChfHmP8xpYfSLFx1KI/nsBvGY2zQvvULGpXgBYUGToI4h3bnL47gKjWo3ZacJKxiqzLPq1pvV6Day/FoLv1Y9njyfI2iq6C3S0R0KpXBsro/u3R1EDj1LUqtWRQMVLaN4OTKZF1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q9VX24XE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=bbnpreetsingh@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q9VX24XE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=bbnpreetsingh@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dxS6zL2z2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:06:20 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2d032846c95so4843865ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 23:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391578; x=1785996378; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2BsO/SXniFlM6SCUrq26UllYv+rXm0p9PUXKwY1gig=;
        b=Q9VX24XE36RySHoIGqGsDgXoxxFLwLaXn3xjLUYoPpDv6tn37A8QwLnN+zTSysCsDj
         Agcefxi8XU9t7VrID23lREB4BiUQ9FZocC/y17RQijGFuTVXAGh7pgkZ965C1MNmc2ZM
         LDPxrAnVwL0SMtKQ5iROtiWak9diqpfD7y8RzwxpmOzHLAPAJP7SQO7GoPpPsgEV/2zE
         5jxhgm1bAliUZlBfLuh0vqI77cHV71ahaH6mo3NWF5Oq0BILfnfMH9TqBy8w4j/PSGpb
         HdxGWbSGI/l1IONeIlaVisn9h7abFHXjeMlDsr99EFTOBUk6cn0TN6UBzalFlFP0b0r7
         /8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391578; x=1785996378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2BsO/SXniFlM6SCUrq26UllYv+rXm0p9PUXKwY1gig=;
        b=Z0eelPKShIkpyIKVoH2Jxb/plh6++yqvFn/0aTBSxtEgPuEFKgrj5ggKIWWggRcNEC
         OSTySZeggSEc77bS0IatuTI4XAAq+3om17/yXPCNicyYMUHqJSIHUlpKCohn5pep32fI
         sBFcK0btOWmj8voiy/4zJchqV64gwtmNatUk+iU3BQ8CAgWbrg+676SfiIsfuPsmjZna
         NwPA879w6uUfHy4W2G/XjRkT0XNRS+lrbKBSZJlrZ5O19mufY59eBrfut9akipWBtFeH
         1rxx80VlzQwO2Fk94QKAy1vUbxs3TIu0I9XIJ3v0DDvvyy5ybnRdRpWXnLvyGD52JPGx
         TKcw==
X-Forwarded-Encrypted: i=1; AHgh+RrqJRjCsiC/tK1Mp08qIxEzRhjBYVJYBoze/yH0Sdt/0tGoa3bF5KAoj0oA3OZtt4QhiHM+MOkSuxXQ4Lw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwSxstHlkKCQAtMkq2cFLRveUydgvdFvCLUB75LQn4p+Ww1FGSE
	uLA+ExN6HpxOIrtKYiyfppS7BzSR+iJiFH02LzN9PP9gLAWW/ooxhNUX
X-Gm-Gg: AR+sD13Q/0vm7aZzxE2rhPf4E7Kg3K/9+QF8J6TGLBqgGRc39XSRojWhDxZKHCH4aEE
	74CBkZKlRBEUL7qXYXhiaZjrYkNlGSTDnropDMDPDqAkFZy3+zgKddHWRJM2f0w9WJYMx88k5aI
	nfFYyzErqBA8C9CoDPWKUlwTvga946+mjYINHXzBmZzldLqV/N3GGKEgb+HOnb7dAoOOgD7F4hI
	F4IfTFUPIi7vhKmpAHVqM028FQihbUUeDPMIMo6HbwNd9PCRPayvJQfjggTcGP8b5HgpgDnnSsR
	TsVAiarbm+84EHqF2JHt58MumliathHWZrvwdb1BwwHdlwwfmHHWFVTPVs4t9wgm7JNAKinPNnd
	NnNC4Wv69OOKSI/zPF1FOeHCPtrgJMN6SegHDA6/SuD/rvqHX85efdeMrOV9WwCHbYvAzd53dMu
	lHA7zrJkojqlSixAsNrBvIFHK//LoGWHrAkbS4I/r9/6qzGMCyIpuPxYRgzJta
X-Received: by 2002:a17:902:e847:b0:2ca:ed41:d33d with SMTP id d9443c01a7336-2d035e4b84bmr13293455ad.45.1785391578502;
        Wed, 29 Jul 2026 23:06:18 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46774sm20780785ad.27.2026.07.29.23.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:06:17 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH 0/2] watchdog: Fix two kernel-doc parameter warnings
Date: Thu, 30 Jul 2026 06:06:15 +0000
Message-ID: <20260730060617.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent kernel-doc parameter fixes in drivers/watchdog, found by
scripts/kernel-doc -none. Both warnings are in .c files, so they appear in
a W=1 build, and both files are clean afterwards.

Patch 1 fixes a name mismatch: wdrtas_reboot() names its notifier block
argument 'this' while the doc block says '@nb'. Patch 2 adds the missing
description for the argument __booke_wdt_disable() receives from
on_each_cpu() and ignores.

They touch different drivers and are not a logical unit, so they are split
rather than squashed; either can be dropped without affecting the other.

One thing I would rather state than have assumed: both drivers are
PowerPC-only and I have no PowerPC toolchain here, so neither file was
compiled. The whole series is three lines and every one of them is inside
a /** */ block, so there is no code change to compile. Checked with
scripts/kernel-doc -none (3 warnings across these two files before, 0
after) and checkpatch --strict.

Babanpreet Singh (2):
  watchdog: wdrtas: Fix kernel-doc parameter name for wdrtas_reboot()
  watchdog: booke_wdt: Document unused parameter of
    __booke_wdt_disable()

 drivers/watchdog/booke_wdt.c | 1 +
 drivers/watchdog/wdrtas.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0


