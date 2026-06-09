Return-Path: <linuxppc-dev+bounces-22355-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ECACD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:19:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyK4zL6z2xll;
	Wed, 10 Jun 2026 08:19:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043593;
	cv=none; b=D1RKHdpJjvKTb/Nfokt4Rx0QDiIuQHQDeeb0IebQ9LspKniyNv3dGDnIdD0DPPR1U9NI4ASytlQQ2jgo842rU3zkC6mzwxnfQnHv54+7WYGb2wbZlqUzpMArZ7qnz0cMtuWT+cUl1DURRdVZ9ZP804+O0TZl4A3H2uueqHZflU++vO3u2lJKNge2S0l+1Zanc90MP3BpPjoqPnjZOCaeIvKND8TyLKVRxz2EZQYGXtbio0WtUrqdbvba/iU2+AlpIX3gNAkhZFYxmWR69H74WgL8nbNjTQ4JsGwcYIR9ZzLF+t9JKBOviY9Pn+HdaqLYYKB+AUuSGx0Zpa/CnhyX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043593; c=relaxed/relaxed;
	bh=VabrJGQKyMUS5+LwCSzuBvRxZba7atk/VeVHPvy/VCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJq/Ta2CQ6jWJb9t+mtj6rhcmACMLa55tWkhgOHbDrY7+TcbDXjxZUFsJk0xoPvyWLinj90kw4R3XqejMSm9xEuzvN2Qpx3vANhbP+3D6sCmHh8RBeDGYWkgxt+q8uchEkxNY8W9xLCcMILULyQ5G/oGhySqiZQStg6KjnHtjcX5WHL8/jx2BzBcZ0wc9G1bPrEK7sGnXE9wS+R6hMo5wa1VQJbnUiEpQzsG7oWwu8t/Ix6SV8DV1IhvlSJ/AaENVsAo3JXXi2Nuwczg/PQFD2pqKKvSQi6CXdVGEROEuXdSRCyeuWjWU7z3WByUGnZV+xPNrS2tZmch5mSpG/wVfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KkNX93ww; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KkNX93ww;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjyG6pBLz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:19:50 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso3969601a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043588; x=1781648388; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VabrJGQKyMUS5+LwCSzuBvRxZba7atk/VeVHPvy/VCE=;
        b=KkNX93wwcEnA0VpBa/V7qtbJO/ILIme19glrLU2h+sylxemiIE8lFrNWRup+XQd3gk
         8mdVRgwFjhgPqNJzMRiQlAe5p05gycn3h2sCKR1Y5F5OAc/ab9BBS7zyBHKP6uSNxINE
         Uf6p4OqpXKq2yFDaV8SqxoIGR8vJ7qs+fU5QGf+QCEtQN8SYmZrbIX330zJDkWu9H516
         np1QFgmqag/oLe9/85BA42zm7BwgzOhPx/oAEJTaUm6M7ZYIG4rTuBQaLkaB44uTq/TC
         ptqFppTyN8/r5NiP9fvF7xRsuWxjjp3uRFgL6YtY4WkBmwlqUUHC4fmK4LQkj0XagWDT
         oLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043588; x=1781648388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VabrJGQKyMUS5+LwCSzuBvRxZba7atk/VeVHPvy/VCE=;
        b=qqzPOG768Kf5f0bJuA7tvuptghZeoz3bYsvc20qpoSQ9AJnHzSUe61kphmEDHYu2dO
         vOX8UX0NY2yw/iG9gNVe4iAKH5fTf+AqT4vWA6rup2jKwnbkAJq6q44kZFsQqjsoY8tw
         uuVTVNZoMZ1yHzYtfTozKvcDZRbJVagwdAe2UkcP1bZ24C/P8bZKjOLk8o630kQ2roSr
         Wb1HwTiESWQjA5k5tyak20eu3HMctjgdPR+Li0YvZxT/31K1ywwSr4qeABPPYvmRWoIw
         uFUNUF/iCJKbUXkW3j4Ci82+i6TJYHdIPL8CkPUdJmU8TEUYfspCwtpmh3i6MDMSdq8b
         J1tA==
X-Forwarded-Encrypted: i=1; AFNElJ+pdJJobQpjQl0IvwuVWk3bnDVWRk8Tl+qWJwwpeFHPawNwrZrPWKPAhmXncCD+AMxhSbXyMd1l29zapLA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTCauOIUQyw+HXcCaoUB8ZowQnskIT5irwvbMAgDoFRrjykT8r
	YNF0z1/IYKw7U3/ooTed6U7sIbcH8BKZn8jZX2I8c6KhTQz5uUz2XegG
X-Gm-Gg: Acq92OF3gk07RgygEVuQ24IA4EjF/br1nnPGB9BWNy5mmaURTu67lyiZVp1Pxox1tNn
	cTgmeRttRctS9DTy32FM3c76WxICZ08elPdzGEguCeCWJkMYrr/j+4oxIwWHDkw7Fe9TNn/Q2Gd
	/ZebSLUaAxGZg5hdYl+rdC3mVeBLOyAOepQhlbtgowPPMaB8V5+zlEG4O0o1+cMj/n2zHkxYlrr
	RfAyFAGpo0xdpBlEuBFdAWNf+t1tSdN2mNUQ8PyX55enjh662NegGV0GIPBkdXowAd0kW4fdoCS
	yOAsitt3Hr8Jz77EGE3sz8ZwbtQimUpqoSvvSSb0xf/aeGPu9NucLwHDF8rvkEQ6/lqZm1d9bmS
	gLSRlEjWGLyJuWUHSdsqKOySedN6DucMhQf42NA28Gcr303iKP6d3LZz+2Fue94z1cRHf4gmZP/
	XSW5IrA0fWi5LnHw2BwUVumyRZrtkzCsBoECNrpRFRxOzUoyqiXdfwCVQ7AMFPhlcaME2+ar2Ws
	zJtuvkQngALdiz8jesbE3tTTTvLWZJ5hlXDZANWmfIh2Q==
X-Received: by 2002:a05:6a21:a07:b0:3b4:85db:1bdb with SMTP id adf61e73a8af0-3b4cd0801bfmr27114883637.44.1781043587709;
        Tue, 09 Jun 2026 15:19:47 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:46 -0700 (PDT)
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
Subject: [PATCHv3 01/15] dmaengine: fsldma: kill tasklet before removing channel
Date: Tue,  9 Jun 2026 15:19:12 -0700
Message-ID: <20260609221926.35538-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609221926.35538-1-rosenp@gmail.com>
References: <20260609221926.35538-1-rosenp@gmail.com>
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
the channel has been freed.

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


