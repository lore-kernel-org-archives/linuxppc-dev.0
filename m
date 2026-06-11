Return-Path: <linuxppc-dev+bounces-22449-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A837CCD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:53:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJN207Sz3bqD;
	Thu, 11 Jun 2026 13:53:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781149988;
	cv=none; b=NfLcXPxvwbFaYleoIqiY5MCCOTY7T6bL1wkevrxSm0eC6+dMeWFs5IJfmM2zMSh/CPKVUgdBtsfYkKPjnI4JRS10/RwrmhCvHNDr3xK+eaYGsm2BXBlSpKrWmTPkjpJTasHqmEty5NOpOojp0kntailon055AATfU2C6v/pL/RhmXzlEPLpc35WfwxPm3+nQ0ruexTn+pHCuuiLLDOnEOFbW+r9cFLCjn3Xwh50jks4sXfACudxCMr/Sa6GV9VZX5R+0SaUHdlWE8pFoosmrWtWAeHtksKH1l80EIt9/jhSmqvdUi1Z08sQlXNJONkds2bfMKwenmclbrkoKB/oDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781149988; c=relaxed/relaxed;
	bh=Sw1Cja1RhTfP4kS/GYb7UquNtVaGdBSxdFT1BKiN0hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmyVnd9UBAVrvfRrdf1duKSWThbwPTgpmf9w/2ckwUjx9o5sTTxswEfCA5iH6VJhmQ3jpV+kq4tpk9TaIVTk1TIw47ED6bvl5xG9FwLK1Zmm8z3XLdmNzip8KbYcpCvKloN0LPnFu+1tEopsqRj9avEADP0GXjPdRgFJgo39IL4IDMgF1C1gadBi5gkrjwD/bx3V4b1TjaGzllTum2uF8SlGOcWS+nn5jG3oPN9RsOSoAibq7ffCEmNI8DGriiWqZZp2q40R6VGWeKZdItZiqQHLjH3O7gZ7ALhJZ6JCrypi/BqitjPe4vqFYMdvu/Uy2SPdDRpbymWjmiojpCJYZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VFSTDeML; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VFSTDeML;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJM1DlBz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:06 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so5138681a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149984; x=1781754784; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw1Cja1RhTfP4kS/GYb7UquNtVaGdBSxdFT1BKiN0hY=;
        b=VFSTDeMLlgRdATJqZSOJQosd117oa9zuIQ9VYvAjhDcyvDbcNg74QY9CwcyeRRskfn
         ZIKl6U70qX96VSCv1D88mVJt4MZ+nyJ5r/dGqu0VJgBdykIdvRWW/OnpIEvTnl2UbI/i
         utasDLTUlaCbEa/9spUAKMuy8uUsgjrIZt2AClxBK0qiZp+s95xMzrv/fbbBjy48tab8
         Oe3SOH8PiUbFz8E17OIEPpo5qrUwyXMfWkOW4pM/HuYdrlDjNpF447NHCj11JTZlxP5W
         MsYIZ2L1PMjDw8f66o+FK6YTTmvmEejy2tzpjwG3m74g1E5cP/4TTjg0iAiHNWMf4Dje
         421A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149984; x=1781754784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw1Cja1RhTfP4kS/GYb7UquNtVaGdBSxdFT1BKiN0hY=;
        b=Ze9n9PlMUZJtKQrYC1rO7O650u9d16zyNcGDfofeVjeePueWT+kBFG/ImvDicY174t
         AqGmA5y5SJD/hLPWMDxu4E141ckUVwXrvsArAM9D2TIOb9xuCvg/xVOredCdKQQYLlFX
         rZzBbapTcj4HiNOApjzFG0Y+b9gxlijQinLvmI6RahUbJN2X17K+V0omIJyYk135qthO
         S2c/Pke94fkFqVNQZ6kUAZceNqSOrx7KsjkaWlpwLsRYV5lHg8AsCVOokEBupYnK36/3
         jnZqCfUP9LYU6y0F5brWFUOfzeaSzyuacSP8wfFtUCePzeluEFcUgK/tYrLHumIRUHab
         J9UQ==
X-Forwarded-Encrypted: i=1; AFNElJ8czZqszya0/l/JcEYtDWLPV603Mc6F9FbBa9KCuQQ+biJ9ZJx5GEEvsRokZD9JW+6dgQOULlFkgmz6g5s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwXtoX/yz1E4zrAgRy+MjwF3PFbwcebI1YbXv7Emlxz9NifXTCU
	G9G3YqcUJK1JxYT/YPonlzZIgK5gXKE9WrInlIMt9nt7wS4P9WLfAzCD
X-Gm-Gg: Acq92OGmjDvReLUWQJsK2N7OqIHg+3e9TpegkZAwm4RksaAConUHaz/K2XTwTZkiO8i
	MfaEx4DxHNl2v3C+grlWLjryV0mj+gRQ0ngxnFaoo06MxVhL/19kQgF95mebkuvFZE3uCwIkK5T
	UhexbWOuWnDOKlm3Nd0hhfCaXpgU3LkzpQX50dRI46KAz7M8MKGvULEZ9kvtFCo+a4iFUJJu83W
	X7M6BkTI5egpwjKguPjVSr6+PaS9sGAv6yTxnqSoAZ28w8LSnFGbTfy28M4kWewqzvhrSWEK/2/
	6CpimG5ucoEn62Y2dN7oJTj/tFe+GK6PdCBvtYCQnChcvtV+FQ+tOc2huVyD7PZ+zQTgCb5Bnav
	IQDC0Wm9vdNHmgn/cI/TUAoeUpJ9sXJlkPH93PZilYXUcnllX+Y6bkzVB3ZfsBlrtu64yxS9jo+
	1x7iSJPxj8sBFayt6Mud/mmby+rYyLgov5dCHTkRoXrYxdLl+YRw3JvpvQJGS/nqle94DDMe345
	p9z1l3ZxDbR46sndnPKdiGjm86YI21P1ARPWmuG4b0J7A==
X-Received: by 2002:a17:90b:3808:b0:36b:b06c:30a1 with SMTP id 98e67ed59e1d1-3779bdbe7e8mr1273257a91.1.1781149983868;
        Wed, 10 Jun 2026 20:53:03 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv4 00/15] dmaengine: fsldma: devm conversion, fixups, and cleanups
Date: Wed, 10 Jun 2026 20:52:30 -0700
Message-ID: <20260611035245.13439-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

- Kill the channel tasklet before removal to prevent a race with
  the IRQ handler.
- Check the return value of dma_async_device_register() instead
  of silently returning success.
- Replace the powerpc-specific I/O accessors with portable
  generic ones so the driver can be built on non-powerpc
  architectures.

Build-tested with LLVM=1 ARCH=powerpc allmodconfig

v4: address review comments
v3: even more sashiko fixes
v2: add extra fixes to satisfy sashiko

Rosen Penev (15):
  dmaengine: fsldma: kill tasklet before removing channel
  dmaengine: fsldma: drop desc_lock before invoking client callback
  dmaengine: fsldma: halt DMA engine before freeing resources
  dmaengine: fsldma: provide device_release callback
  dmaengine: fsldma: check dma_async_device_register() return value
  dmaengine: fsldma: fix probe error path not freeing IRQs
  dmaengine: fsldma: fix request_irqs unwind freeing unregistered IRQ
  dmaengine: fsldma: convert to platform_get_irq_optional()
  dmaengine: fsldma: use devm_kzalloc() to simplify code
  dmaengine: fsldma: use devm_platform_ioremap_resource()
  dmaengine: fsldma: convert channel allocation to devm_kzalloc()
  dmaengine: fsldma: use devm_of_iomap() to simplify code
  dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
  dmaengine: fsldma: replace ppc-specific accessors with portable
    generic ones
  dmaengine: fsldma: fix kernel-doc param names to match function
    signatures

 drivers/dma/Kconfig  |   2 +-
 drivers/dma/fsldma.c | 258 ++++++++++++++++++++++---------------------
 drivers/dma/fsldma.h |  35 +++++-
 3 files changed, 168 insertions(+), 127 deletions(-)

--
2.54.0


