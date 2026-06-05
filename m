Return-Path: <linuxppc-dev+bounces-22131-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D82CD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:02:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXFlV3y3kz2xjd;
	Sat, 06 Jun 2026 08:01:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780696918;
	cv=none; b=FNFEzBzNjBe+om0An8aqwg2uSizGXitxJq+Ow4MAFK30PLvLQIqv/rftQp7VR7jwg6oli7eLsxhAu19vQ60hLuCyAgebFO4OiKMHnS258ESEP0NZiBijS8snO/uhNT66Q3xVsEbAcI/idrbsn6SuuioTUmzAgJIf/HKbNzPoy8IYm52LY+kfuBN6JSG2QqJqLOhOAjL3ft78cGs95iGBqDvw4wbRIgtIGncoVhmTOw0q6vipRnlgIhkqoCMkq1Gbnz07U1jXypuy9i++iTz9G8YubkCv+xqTNwko7n06uWR3JK/ZAgc1K/emOj6xpxn0ciPc7ALR0ASj7Ptn0kzzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780696918; c=relaxed/relaxed;
	bh=W3mpU00CFRN4T3ZBRPTrtzwzlNmgP77kODqdYKCW0Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwM9B0rx3ergS1o7RXI1P9In8aa5Ca0rnzOLl16J7Oo6XmAEOm3LwCuJLlOM/meGLbswPGV4St8SA008CntGMA4XLqRhq1RVEsjvKO9JDvoSNXDx+pKhAG8KgyAzGsS6iqXrTDCvzKJGgwNt33f5CZydxCsKMEBFtMJtSEf5ywpaO7uLaNFb/fn8H8hfO6D9cRnQiW4xYqnuz3+bYDBH/i9RC2a67riTha4HNkXCwxevS9mRkwrQxehergEpJm6asCMTFI0XiE3+pxO7x9K649Ph5KPHXzDqXXn11Ems/6oxCdtcSMGh+cvwOkRkoztDleGubCQILbPuCrbL/1+FTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qK1O1aG+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qK1O1aG+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXFlT0Jvfz2xVK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:01:56 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8422524cb38so827273b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696915; x=1781301715; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3mpU00CFRN4T3ZBRPTrtzwzlNmgP77kODqdYKCW0Ak=;
        b=qK1O1aG+bMQI+Qo4gjpCcfOsPQNMBJPWiKxNqO/sfLaY5OK86m+bPc81Z9Xbx3itu3
         OoevGQPFXPPe8vx63kT53ZT/DuNf+u0DBz64rvxxOHAst1mBE8Crcg6SuvBGtMLKPUQz
         nvXT9sK3nuHeF3IWOj/qPVd+7mheGnyOq5JkuwMxK4NrGnhV+CGtz1CrR1A23FI5T6HZ
         1+scP4VIiy9D5DnPYfRTce6h5OHqHpjszhG2whw8Fwtwca39iBP3ChNEtZiUgIiG3K+2
         5ACXc6B5bs2zi1iX4MbIn6Wilw3llj5qaGLstxuVrA5yowaB60XeyQBSV2Gz3rZD4PdC
         DUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696915; x=1781301715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3mpU00CFRN4T3ZBRPTrtzwzlNmgP77kODqdYKCW0Ak=;
        b=J1SWkA2OG9ylzBj7AJyjmrKM1eIxaDGu8Ob3A+8Jb5STQRpHfHs8OVEfs30XLCWyVh
         2z/StTBSx46p61ldCWxKOw3XJcTnpYgCFn30SWmYD5KoswT4sCqg9+xRFumXSa7snD6B
         rsZEwE/aMPogAHbEQ0JDth7/akTYyQXQ/Mwbf99b0an/9vI9m+541t8Og/QJR9srdY9e
         UCs4SEeEFYipUpInv/KBk/JJXB3ulhdXIdL+Vyx67ozNE9nOFxSRaw5egCCho4uCg/21
         aDTunOASsdNIYzSQHF6nSz02prD6MRQpP2pKSjcoGuA3CocjSqzNKh/2m07aU6Bp7f6h
         zR6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8EHP4wM5pVmiCvXOp3JKtpTFLUhvopx6L3LaCDM6FjGz8FB0NqCE+k+vik/cvKicvxsSjyp8moBaFny88=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwkRk0t2qLCrProA+6RZk57djbVBlXSs/GqOgmgnaVz1b4yz3bv
	ccOt4B4RZSG6eDdgVPUfE8Zklf1BHZkKCJ+hHI9LwVsGVkMeiK14NIZs
X-Gm-Gg: Acq92OHgLY1U83qxsG8/N+WvGswjHXDv+uWtGX8RRsPqWkMC8ztOHFAEdRY5VyhzbKl
	/itrKjSvqb4TLx38KlZ8Hfcq1L1D+aSChrS61KsWYI/uHA732XaKZ67fLw9eRfKeb9KHk2MONX/
	y7VyOvPl1cqooGRhngrgsgIr2WerqpU3u1RX1NSbWgdezOAcDKblKPb74mgrO/TwjV1aAQlZc5e
	g0UXSwbyG+HKM3gcd7RmWqIJUCKSxjEt2A1dfUZCXxJ1PPIBt0mKCvlKSpHZ6I+0rFum3sRORdi
	uDbpC948LpkiqygaxgWcC1ZX+hqpgq63JEY6mqJMDftuf4caaUa75RMNeLW3/97cJBIfEe2r6Xl
	psRMG5DWGGq0Rf9Nn0j36f+0bOKac6LZj8++kwwfqmfG7AviC252So6CgYZ42cOIz35z98myCHF
	9NzbkVMyuPFWVgnMqE9+NivB2+81a1AsqpBGw3Oq7mVDEEII8B7yKMomNtN4AST6syeORTIQHnH
	fgq4X/epYxgqHPqVQBqTCv026S5ZZGWUllX4kMrj2XE1Q==
X-Received: by 2002:a05:6a00:32c7:b0:842:422b:259f with SMTP id d2e1a72fcca58-842b0e30c6dmr5022742b3a.10.1780696914650;
        Fri, 05 Jun 2026 15:01:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:01:53 -0700 (PDT)
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
Subject: [PATCH 01/10] dmaengine: fsldma: kill tasklet before removing channel
Date: Fri,  5 Jun 2026 15:01:25 -0700
Message-ID: <20260605220134.43295-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605220134.43295-1-rosenp@gmail.com>
References: <20260605220134.43295-1-rosenp@gmail.com>
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

Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race
where the tasklet, scheduled by the IRQ handler, runs after
the channel has been torn down. With the recent devm conversions
the channel struct is no longer freed in the remove path, so
this is not a use-after-free crash fix, but rather correct
shutdown sequencing to avoid the tasklet operating on a
logically-removed channel.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d958abd..0e2f84862261 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
-- 
2.54.0


