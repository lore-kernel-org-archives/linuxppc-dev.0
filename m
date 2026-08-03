Return-Path: <linuxppc-dev+bounces-25296-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99609C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 22:35:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDWjH1b4Jz2xyj;
	Tue, 04 Aug 2026 08:35:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785796547;
	cv=none; b=S3tkTRrPC8oUe6qvxxGttZxqvuLVds1iC1RcIPgzozmVgugVEdwNZFRXuiPVCPvDguXNRumi0usvofQkaMqOVx35JkJk76tvlANXii+b4Jzy/Qakr+TZCGEF4ZM1A2WjOTs1F4H/Z8sUQ4sFjP3eh+nfa7iTV0g317SQnVOPLUyLjnhx8unCxOV2NxXuHcppnkIBhwfYC5wiC6JWqhzRuQrUPri/36DRMzdmorgy7/E6k/peoD078F5UnW4RJMQgGReAxuwW9r7Plj3FVJOddUisil+6xflS9YlIjvfhP5uzGf49BULhCDYlqEWVGrKrDp4pOqgfjlfUCSeo0sOvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785796547; c=relaxed/relaxed;
	bh=d3dHIF0QQLyouCUGWyUt+N8YORs2xkeKRM7Upu6EJ8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTLOPamOQgDXhbUsrFsAog0IkuZ8rCSAx9xtl0kDvPl5raPB6v2Xausf33goeOQwPFiLWb59SfjbiRFGQbUUR77PIvpeI4FwlLl6FxjHeTShiJUxaTzf6A1QFUQZEtcuMpL+XZCCxmLj5ru0zNh6s8Q1p0R+YxdLJ0Yceu15Jx9piXAQBEWTTP2Hh1N9hHBE8onEIrbJaQlkwper4lCv4ZLPGo8BCftJQ1trHdCr82/a+4v4UpnfyLoNTvEa1UxdM30b1BWvDveP5szsdz0apof6zrTU6IS18tCtrtD6mR18+MejmUKq8OwLeDPIhM9kd+TioJnvigq1Tl4RjFpNoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i9PERnGb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i9PERnGb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDWjF57kvz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 08:35:44 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-8453427d3f4so4305022b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796542; x=1786401342; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d3dHIF0QQLyouCUGWyUt+N8YORs2xkeKRM7Upu6EJ8Y=;
        b=i9PERnGbYvjyL2RGpkOrMNgN3zjxqoyJk/AtrqP1xCW6KTFbmLjfCQW6M0QTy+6IX+
         oDT3OQ29dP1kBadA/Uw+NmA059Dpu2KCBYJouSuMnIzxjzuMdYNLvQpczNvLU85c3x1Z
         TNSBMOpmbEBUAl26QwxXo0pfAWnssRpwsdFX4SsAF7RhMLuVIpj8YsnimyWouJhnC4gy
         iIFGT1BTA9/BWi1uUjOVNOiLerfdNUnVYM/6pIKb/xPLuKnGGmM4Og4Q8t+bN+FZbYzV
         vD/ID8LbhoFeddyAE80XEHUqYlNsGNHXrhmn+Lv5JlLtgvTKhG9Yz2P3ZMsvDyXFejZi
         00HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796542; x=1786401342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d3dHIF0QQLyouCUGWyUt+N8YORs2xkeKRM7Upu6EJ8Y=;
        b=M/dvRx7FucXRliYSXr9OItiE+Bv02r8s3KaS4wuwFIcSJoAL9Fs5/FhvqAgg7O74d+
         WCzRpWrSF2XG+tDreAwVxU+arvB633XJ61TXjLTw2/JYpv98TO8vmRYV7suhO5bIVF1D
         +Iv/eqMm7RYVD18wtYka6wHiN8n/rMosfvsESh+fY6mrbK3ByW3LWmN3lo84A1Nf4fSm
         KYes3wPrgqEBH/HqmjIEiBKczlVAcx5mORDMXnRSdh3Z9cnDi6MQlr2MOcNxHLZBtv0Z
         j32WADc4iXyr4KDEpdPSr3INAjCP/ScwitUm8XDKxptwrYU4/hylpQDt70GWnGFIqGlV
         e4tg==
X-Forwarded-Encrypted: i=1; AHgh+RpO9IvHaU8+fMbcQIy/7nIjoU9i8TlKU0cJl5Of6yI+VT3tYriDPrOeKuo3yuU1pcxeOLSfYnOhxd9ZU1A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyc5Tou2FHqWS7hqVjqrDTnP9mSZJgA2fTAEkzdKXjhoc/gcJRE
	nxeFnLE9mADFJGuHIcJlCUgy+n73KHvn5aSVAnPd+7voPIku1hbyFXpg
X-Gm-Gg: AR+sD10MAbLpRsmHvD0bI39kNplGSZRRUf+roeOxYtUgWWxUjvnIC1xUj4bptWtBM4g
	y3AiDWTGa3mmLX/bDDmAJce3fQPBNuhnsmCBszJGwij6lzpYg7il9NotSmZpwL0QzhtYmlHmKOD
	6YQm8N96EHCg9PRiJ2/23ZKXbgNutFXM4XdQNPizUyoZDyAvx3VJeTx2ULCBpgXJMGQ7uFNGwJe
	JxBK+VMwAYwmwxiSmybZYcugXiOGJtiliVd/HtPZkQbukjuA58WY8CVC+/LRAnIV3CWQqRktoEr
	fLZyQh4z/YTHSeAewgLmEPnVVAi/Q/x/tQsKtfra7qpIwnhtR9V7lVJA2/Zcc14Ujg/0n6Mthpu
	hzLSbrSxefu0mo66aCM0iFjug+pIVYeTJmT+/mzrPWC0HvBsAuqrrWacgBt69WV16YdivqOCTIR
	BEQpFbx6Fjgy+3iq78AsCw2GuS6oTiKExViA4CyvNqMdHtEOlGj469TqiwvCgs5z3JcQiucCDCc
	9cMUKJiP9MJ4jxhrSChBXiZut6XuVAY52tKnM7j4bbq2Vhp7Kd0oMN2sgEYOokJsIvzEtVCyK/L
	RVjzNU5CNLhQ3KTaSMUwCbCL2WxsoPefuJkgIw==
X-Received: by 2002:a05:6a00:410f:b0:847:8971:87de with SMTP id d2e1a72fcca58-84ee483fecemr10593375b3a.28.1785796542058;
        Mon, 03 Aug 2026 15:35:42 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm4186790b3a.40.2026.08.03.15.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:35:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 0/8] gpio: move ppc4xx driver to drivers/gpio and modernize
Date: Mon,  3 Aug 2026 15:35:31 -0700
Message-ID: <20260803223539.86303-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This series moves the ppc4xx GPIO driver from arch/powerpc to
drivers/gpio, converts it to be a proper platform driver using
generic MMIO helpers, drops architecture-specific accessors, and
prepares it for module build and COMPILE_TEST.

v2: use guard(), reorganize a bit for clarity.

Rosen Penev (8):
  gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
  gpio: ppc44x: update all 4xx to 44x
  gpio: ppc44x: Use module platform driver helper for GPIO
  gpio: ppc44x: Use platform resource helper for GPIO MMIO
  gpio: ppc44x: Convert GPIO to generic MMIO
  gpio: ppc44x: drop PPC-specific IO helpers
  gpio: ppc44x: fix undefined behavior in GPIO_MASK2 macro
  gpio: ppc44x: use dev_name() for chip label

 arch/powerpc/configs/44x/warp_defconfig |   2 +-
 arch/powerpc/configs/ppc44x_defconfig   |   2 +-
 arch/powerpc/platforms/44x/Kconfig      |   7 -
 arch/powerpc/platforms/44x/Makefile     |   2 +-
 arch/powerpc/platforms/44x/gpio.c       | 211 ------------------------
 drivers/gpio/Kconfig                    |   7 +
 drivers/gpio/Makefile                   |   1 +
 drivers/gpio/gpio-ppc44x.c              | 208 +++++++++++++++++++++++
 8 files changed, 219 insertions(+), 221 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/gpio.c
 create mode 100644 drivers/gpio/gpio-ppc44x.c

-- 
2.55.0


