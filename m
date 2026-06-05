Return-Path: <linuxppc-dev+bounces-22132-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB82FCD6E7E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:02:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFlV4hx9z2xnK;
	Sat, 06 Jun 2026 08:01:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696918;
	cv=none; b=GBcgWOUCyTzTkYpO0KGJN/RvFYJb4GBEghoHyzcJPZbngi158zQnrdwxonvo+lJ96z7yNyH/b63SompPmfbL0UEGj1J/QnPDKtnOTIM0zUhCRULz32xF4BLZtlRuyMRSL68lwGhII//Cl7dUzrEnzAa5rj/SC/hOaR8Lf+IAO5aCLuMe11/2TDWUdE4wfMhhuJoJ9MHdLJy7UWtdtwrf1IqTO49mIEDdzewNaiGtHmo5RlojRDzzlWWwK25/Q7oLwLpl1H3n9LY2vFlf9rCat8sSQgPPAD6IgNXrnQ0MWDN7U/NM0mdsCXZPuqnWEka4h3lAqYdhph+NgCx85JkQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696918; c=relaxed/relaxed;
	bh=jPyXiBEaDClQK0uMOGkx+P1/d3TAmzFQ5qeaXXNxnLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bXRawLLLudBOB4jX/tSczPp8+FAA8yayXs7TqM5EPebEFQ/MHAIYwWQD8w/7/gZTcqmRrXeKgjX7AbbiHDTPBfehB8AsU4KQFVWTRRtp4kJXGV+XZ7zInppggcelnlyaT3LfcuX/BhckSjvxnoYO8KXUDiUCtxRRA5U54NH6uf9i6z5sjMqQc2DV8F9d2ml5lrUojOsuny6f6Klhy7BwaxxzCbA+9s3l5en7QTv1vlE/Zf+g/c+akTaWLpWdxZcbTxWpL957DjWVp8g4G6dgFq23BhEEnHkzeKwrMcnwIwx63Om7XjKVu/UZAjHDjQJpIR1LUyyEj0BxSDGefbpIeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ANeHXRhf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ANeHXRhf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlT0JdLz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:01:56 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8423b08b293so1122347b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696913; x=1781301713; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPyXiBEaDClQK0uMOGkx+P1/d3TAmzFQ5qeaXXNxnLk=;
        b=ANeHXRhf0xWfpKr9M/mN8hODahRBQGFg+UHFkf8KtiQNQqIk5tSlDuR1WuIIT4fMMP
         GzS1mRL3XDDtdhrMJwIynbgPlyqhtMNw+mYIaDqJUKiS0psOrLLArFRDJC46446KnvtB
         bFeNbTrH92g/m/vIeN3BR5OBGNUJkuRNCFkFkp5FgbiOBxAKYhDiFGo3sMqd6KafQdu5
         QHLWxsI3qMOdaoUwhGd9BxIHaRrdWldMQiGQISi68o26zm47t70OKdvRhNrPkhlVWMu3
         79c7OpirfhTqACbERLUdZP6NgHBiov666JiyahSb54E5UsTTAeXmMjDdhBF4YBopfufu
         KIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696913; x=1781301713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPyXiBEaDClQK0uMOGkx+P1/d3TAmzFQ5qeaXXNxnLk=;
        b=Q3PZ3xLJoDE/t65GOS6NMU0cD3BSYXuqDG8lZV3gWDXfaW4bD+Xs5JYLr3b5rRhBYg
         s5SbCSzSZoTHPvZT0Xf7qMMbJaOz6OLqGK9Y+oqLJvpZhIEliyIDTARqXzibHvpWxUsK
         UZ9hYNW7iY9JgfrFzgfwwkzPP1O9nNkHmmMQivZy62FLDZ8FFbbNcWYQHf7xYq7GU1Ol
         UFJ2cKHWi0dwd+qUTII8VrgQGw1AaU/2pKkeF8Z61TUoVUMzfLTbitoT4oTzeSFvrfDd
         QXos1iY+wFOpMSuf1BD9761HT5a9Nfq/4YmmyZvpQy7spFsrduh9rTQxEFGADh0BoJRg
         JoPg==
X-Forwarded-Encrypted: i=1; AFNElJ89wtoAeTtqdNTgLTzX1FID1GswtT5o7OFDFeqWGiBIiRZzYr6RxkJZKOAD7lHKac6OQw1hWy7qewPZeaM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxD+jSBmEs9OWThSv+EXA0oQRgbov4u5qGVkN/8RmqlbncKlZ8e
	TsusCGVL2XTMlktEsDTmMqmW/oHChvDxMBft1rLZJap0XiXXmXQ1qUqS
X-Gm-Gg: Acq92OFOWHnKSiFrkSq766Cn3jngJq9KeheOL0xMDoMjms4pDJkhaS6DLvUfAOfPt4H
	rJoP0zARZo5quyaytRxipYsVmO/rd2AoWT9Km80+z5H2xhOd9hLxpmz9mKWBfpS/si7ZLJBZHip
	VIgWhmjutsuwNkhmNHUKImIuST2TaWkhld3H+7VfBPxSigarV3WGh3F/DVecjes5XsIE0H5bvQo
	6pUiKCdxaAj98AdiOHvSMj20697n+Vyy3Nn+ha4c9gDxW2cpRznZ4KtZMZz02ufU+aN59NONXmr
	G9crak2xTl7butYr1+NtoOEISQB/jM6V+NQOnzcLjhDXOfH1Fm2hqpR25B7qqxbUM43B9Ru16Be
	qUgKbWi8lJA9mNG8CEgJaVEmwV/RC2X31oq/LJyJ/+vKGeSW/ilVqEw/tUYvDcXLD/krXpVneIZ
	Nuec0A3KHymvek88e5d9KdNyDgaqphX++0Md/N5eeApe14VBqPH2pLW/L3Ap8oYl+gKaYlhXwtl
	zIZ3Jb7a067VXJvjpMmVC7MWlPDQvLbGT+q70Vh8N+uzCdQjUkDuVMn
X-Received: by 2002:a05:6a00:6c9c:b0:842:5b63:6118 with SMTP id d2e1a72fcca58-842b0f1f43emr5730143b3a.3.1780696912990;
        Fri, 05 Jun 2026 15:01:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:01:50 -0700 (PDT)
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
Subject: [PATCH 00/10] dmaengine: fsldma: devm conversion, fixups, and cleanups
Date: Fri,  5 Jun 2026 15:01:24 -0700
Message-ID: <20260605220134.43295-1-rosenp@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Freescale Elo DMA driver to use managed device resources
(devm), simplifying probe error handling and the remove path by
dropping explicit iounmap, kfree, and free_irq calls.

While doing so, fix a few issues uncovered along the way:

  - Kill the channel tasklet before removal to prevent a race with
    the IRQ handler.
  - Check the return value of dma_async_device_register() instead
    of silently returning success.
  - Replace the powerpc-specific I/O accessors with portable
    generic ones so the driver can be built on non-powerpc
    architectures.

Build-tested with LLVM=1 ARCH=powerpc allmodconfig.

Rosen Penev (10):
  dmaengine: fsldma: kill tasklet before removing channel
  dmaengine: fsldma: check dma_async_device_register() return value
  dmaengine: fsldma: convert to platform_get_irq_optional()
  dmaengine: fsldma: convert to devm_kzalloc and fix error path
  dmaengine: fsldma: convert ioremap to devm_platform_ioremap_resource
  dmaengine: fsldma: convert channel allocation to devm_kzalloc
  dmaengine: fsldma: convert channel ioremap to devm_of_iomap
  dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
  dmaengine: fsldma: convert to devm_request_irq
  dmaengine: fsldma: replace ppc-specific accessors with portable
    generic ones

 drivers/dma/Kconfig  |   2 +-
 drivers/dma/fsldma.c | 139 +++++++++++++------------------------------
 drivers/dma/fsldma.h |  35 ++++++++++-
 3 files changed, 76 insertions(+), 100 deletions(-)

-- 
2.54.0


