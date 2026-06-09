Return-Path: <linuxppc-dev+bounces-22354-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9290CD8CAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:19:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyK3lCfz2xl5;
	Wed, 10 Jun 2026 08:19:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043593;
	cv=none; b=AcMo+7ocin+t8ZwLjfWKrJ55CaNS8/0JXXRDGhCghDiasUp5xM4QRsXzAVjoeyIGqwTgxWfPMTRXh13UHvuAEn8528h6aYVHEodKG+zMERbEkZKEWlvWv1XPahev7ipfUiCj8mk8J2d7OGODtP6WpWkxGgDgavmMY/AsZJOoy41Z+V9KbYypQeOXUQ37SYOI8j2U87DGy36dx20j7/z3Tikn42618CtgntoqBZzjuqYD3vHObwa1yfypNIMYV44Yqq/cfgFe0JkIe7uXOX6rhbPcnNkESJ/cfNTCECNzQ/O0oaMB5L5zfAikdubsM7rWsv/q0n4Cw8aLAE1xNpel4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043593; c=relaxed/relaxed;
	bh=u+enzAQ5tSvqZYMQTM27Sa9xGue4NUeyFXwU532vPXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5PNKqfxMeQ+sOQfpJbJRdXHC6ANXxNbGNxwXqc8aZRBqvSaRdGzZY3DOd4NOiejVWvoB+vyzZFvpC1vhh4iBPuLwFaVgqQI+kAKyLefdoQa78PkHvg3CK8XeBfJmYn/Ntf8S11hSs4T6V9WFYSWEhWxPe+ZTNiqMDT//nKbSHQpMFKDJUL6ifr3GaN1EVT6kG8uV8uk1j1pvGL56BBYQtx+Hjve8ugkqMPIiQi1XcBs7Xjp//a3Endwn4xbXU+eS8E67SIfHiRW4CvvIY6BSEvoBbNkdqxFkSAr379L4VvZbVKx2y5ob77cEyx5up/7NkqMx+ZvYy3U3ZM+l3jjBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=emRNjRKj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=emRNjRKj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyH4z2Tz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:19:51 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c858d69bde9so2540297a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043584; x=1781648384; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+enzAQ5tSvqZYMQTM27Sa9xGue4NUeyFXwU532vPXo=;
        b=emRNjRKjMm9S8LpHn1KO5UPbskfqOzuuefpIxsI5YtsbFil/h1nPGkD/ufAHUI8qQa
         moqyacrLuW5ZvDPEgN297s5ZqvkSXCRm6tjeSBJ045QeJ3y2553IxzM8BSmVx/E5/sue
         lRnQzsmsT9TVtf9OT8F2CjRu2Ysgb/BSNWn+HwlLUyl79FmrZBe8v8Z4Lv9/57PVGw/C
         E2IK31xgybwr8bP51YJVzhIKgfxEHB90GPGMCvZpR/YLbl3WxQ2mJ6TwCIeyZVdjIp8B
         N9XALjLxF6zn3oyhJ/1tO+YntEvcfWlNGA54K1bFTE67wTZtQPlnRfw2O4P0V3vU5v0x
         w4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043584; x=1781648384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+enzAQ5tSvqZYMQTM27Sa9xGue4NUeyFXwU532vPXo=;
        b=MQF4lV3RYxarzxZC+QFqMY8cIW9hgYi6hPXlozRHqqjXp5MHrvkroZws8GCcmsBjHH
         3M+L0jbQvY4Acy/g8yW680e7MHq4NpE0UhE8nbc1Ia/CNxrvDe4z5Ihpn782szSntDgl
         PQp2Sb8PX+bgzNVezsuzQTcOQjw/ulcf2ZpP/qpE4IWK5+sjnwbqkSzfpZ09GolA5hHi
         rnWfVz1TJ8GKxYw5S0UWeyZgwRo4qWQgoSJHXgYHTg8oOm1aqxOiQJJ5AkQHhZ8PFhfH
         PaOKzUVIpw9uocj5HNLekBMUCE2eiKrqdNla0txAdq2IOH4Q7Z+8ja6s+vkWIk8FCqvZ
         7kEg==
X-Forwarded-Encrypted: i=1; AFNElJ+z701pSlm/H/wxsg7r8ZtH8OmdpjX6OZllM4uF5dxI3CMslNQHsr4VLr5UDpoX4o39AT79GLfRG+ybPhg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzC+YnUH74lR5lypBHwHbenCopH25pgOy03d4WnhrJ/n65jwFrZ
	nsANX2OU3azeqNon+s9ySgvnR6avOtM9tNLSnSDXZfF1jWLAe+r7cHlD
X-Gm-Gg: Acq92OHL8C3K9Zddz38dk1Ed7J56oVMLetUMLV5OmwQAyGGxwK6UKzt3t8E63SK328Z
	ss9b+hbGXLduuAtjyQ1BRUyLRSil0JC89+zLGF/1PYXkhA7VsIgXoFURuykkhSD82aZOc9EsSy+
	vQQmN8gxDX58Wk8/Dr+Q7r6uEcyxpvzjow8IyvHBmBd5o5hxpkDnt0fCEfpHQxsyobVfuyx/iMF
	gqIFf5MrcTvugZ4VFoo/vsMWqtnbgS3Djx/2M3yle/NA/nyXzL5Hmb0/iyz46wV2ehJR4rTJ1/s
	xDqNLU5jth1WhjZnIrj7dJOSRgzYHYd70EA6+FhRCvvBd2C880vhh0XjjYilrPCX5XQ+n4I5QZ+
	t5dKCfLERW3vN0cWMYn2FfUi8LBICLjng3Nkydj7JHq18pc127wb/D4KQVQ8PV02vmZs8hfCPak
	+f0eYhZcgI5uQ0eOMpBaWcs3NdcW1iYegmGDj5Xmgt/ZWdKh+wA8TWKgfwHRLty6eGoQeJfPFU7
	/j8BUtaRB/XYqwb97vwCpIXXJRaZyOuNViSlaRIOAncQg==
X-Received: by 2002:a05:6a20:158c:b0:3a2:d838:bfca with SMTP id adf61e73a8af0-3b4cccfdeb8mr26870997637.3.1781043584305;
        Tue, 09 Jun 2026 15:19:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:43 -0700 (PDT)
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
Subject: [PATCHv3 00/15] dmaengine: fsldma: devm conversion, fixups, and cleanups
Date: Tue,  9 Jun 2026 15:19:11 -0700
Message-ID: <20260609221926.35538-1-rosenp@gmail.com>
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
  dmaengine: fsldma: use devm for kzalloc()
  dmaengine: fsldma: use devm_platform_ioremap_resource()
  dmaengine: fsldma: convert channel allocation to devm_kzalloc()
  dmaengine: fsldma: use devm for of_iomap()
  dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
  dmaengine: fsldma: replace ppc-specific accessors with portable
    generic ones
  dmaengine: fsldma: fix kernel-doc param names to match function
    signatures

 drivers/dma/Kconfig  |   2 +-
 drivers/dma/fsldma.c | 253 +++++++++++++++++++++++--------------------
 drivers/dma/fsldma.h |  35 +++++-
 3 files changed, 167 insertions(+), 123 deletions(-)

--
2.54.0


