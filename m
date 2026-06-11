Return-Path: <linuxppc-dev+bounces-22455-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A7CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:53:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJX5FNsz3bxM;
	Thu, 11 Jun 2026 13:53:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781149996;
	cv=none; b=ZcQoH8eO1AMNCRXUUvjC/EWfozYY3EXd+lX5HV/VunsBW1f/WUs3adlkTjWL8bn4xnernI+0SybtVfkjCqwcFlYOm78Gom+dnaovj82dl7Ys2pig89+WsGaEqcpjAWMvON38U7wryNCN3NKi/Fy3RMg1A+hNNM14WkxjxtXOLmoorsvdJu7dLhUA3jnAW6F0v6Ntv8/rZDng542B/qheHNle4YZW8fUA33Ql4dO7uvatUq7S88dt5Eyz5r0gawHQdPP2d71+nIcRC2Lf7Ss06UYDUUBL9spyldGv/ktnUkpNY3fcl4K+cF9bjnhajpcIURhRne4yP8pNInsrtMeipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781149996; c=relaxed/relaxed;
	bh=1tT9xKJ0Z4ILZqTxJ8ZpiwY1jbcqBK/pYbLAZ3NF4IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyWBT9NYwozmGee0nUB0KaBJkIrTFjXTayc8PbzuTUE/yMwQ+eOb1MTZ2hVcM1OyElOYEkm8NO9D56cjCq8CHXGP9XQcmRNfrbzNRm8gFRi3JQZnmOuglsEJm+A75A7kMNTVK2EjDbQYOi2im+n5L9U5k6iEHo2kfTdvjZV+pRxmcxFNd32Sd75CrpZbXZKANEwRio3yC6cagEg0BMlFPesEOKPQ2PEmyswHX9AG6ibmRNkGTcYi4p/XyrsjYJzSh32mC755ol5Nw9d4l0uhhGViJY8mN1m7JxfEt32mpXAwQ/46FvEQQvufqwtE1/itndMke2FnJgyQfR2lDdubWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SH+NCKV4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SH+NCKV4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJX0LQrz3c1B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:15 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso4881079a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149994; x=1781754794; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tT9xKJ0Z4ILZqTxJ8ZpiwY1jbcqBK/pYbLAZ3NF4IQ=;
        b=SH+NCKV4B/6J3pUi7YQxjF1komCwoY/JInk6nHFzf78Henm6n1GHbneetHWthZhzKS
         LWsoD9wi1b70ZEXyjSoxo5GnBglK1oiVPR09VhEGc0x02ajAI1xtU343WJR6FufuPwiV
         jKgiuoLk77PyirPqsI+8qkD3YP0Ml19joNy670cLXhp6hmMuv0K4RBO1FJodULra2YsR
         y1EoouIfpywTbYBl6s5KftNr87+cR+sCwRrT4BF8KMIqnxou1v5f/kQxF/u53H6u/Am0
         rnqGFexlzwHCkzsxwyKwM67DxJWDDOFQQf9jDQUvBSjuYiqgc0wYfFKJObLCmFSVnKFx
         8DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149994; x=1781754794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1tT9xKJ0Z4ILZqTxJ8ZpiwY1jbcqBK/pYbLAZ3NF4IQ=;
        b=rdTCO72I4pb6J+zbsfRYYBjnKGHXJRqOgAdG7zY/gswVjav1NnIvB5IRhBk3pXN5df
         x0/QAKVsIbjkE6HGmagoE886VksWJ/birU/dIL5BYN09Rx9BuUgdEc3hxi9riCLovc0H
         WYUN2osUkZQTatb2Tr2djH1aeDZUEnKIrtbVBnw2joDeCIaZZwRsKLkI4RMFrHrDNhWl
         php4dFEQSXw9/jbfMWxLxCO2i1fVsSilByfH/OzaR5p/FmQV6CNnrS4xlipXIXXryetM
         j18mvJRPd9kMejuC5qcSBRjdxCRW7gJzdNWsl38Cx5djY5psloDuVWALTrgrJMkNHOXy
         xseA==
X-Forwarded-Encrypted: i=1; AFNElJ/lVKkOsBKJNXfXKfRXoL5tKFHTwpPME2L8oLog9GxxvwhihoAlkDa3QFISn/5LEllPr3I/MNlCtvvNNOY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8FNosqeUuPkI7B2mK3q+2WVkLqsu9YABASmuBZLsKb8gMLcPd
	f3qXsu2cGPnM2Mn/KJ9PLYjyuIh0Rgv0ljwNC4vEM7/mGDdW+f59zIlA
X-Gm-Gg: Acq92OFn5gajxEJLtv3goODGJWOpQYSgCxP8gHMxx1D4KFwHSCIbFgLunHJwOjHTFDi
	HMxF3rWC6GU0Tqp4Dugnsjlgzjl236IR9aiE9hQ0FZBgfU0Pv3d0RXr9bFpNK3H79NvblOOJgu4
	fWPqabw+EJVyHEpRhsloyORPBIetm6A+ySMHAtkRYCH7dHar6VoAtXqDjgudSqG14X6Sk6cABF0
	aCZEQrfr/oWGLIT093avzAFTTxZWxzQwXcapKUutT83CufZODbn8FdeBGnZfa4Qh7AwhsGu3X5y
	aCXbIGXY1BmFSGDB7CIRqv+alzT+wLZrgybvOGFsiuWxhtqLYYkWnDhoz7ig5H73PxNbvy9DBPx
	uiApGO0fcWLICvtkdxtIzyODZs2xqsoMKoCA26VLK6nKoNMZNn4qr6oAhV8D79I8OZf8WVTx0d/
	fJHrkGSg6hkMUaKTJXbSylveuxRk6/bG7xoyC0MqiwZ27yC69ECW2YHuN9+OmhlsQ0B5sidcYKE
	zigxZ7AKwCdelWUfq+8+Au7c3Mge+V7n3leJizzcUvOCw==
X-Received: by 2002:a17:90b:4d84:b0:367:b819:2214 with SMTP id 98e67ed59e1d1-377a4ab6f54mr1274422a91.13.1781149993882;
        Wed, 10 Jun 2026 20:53:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:13 -0700 (PDT)
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
Subject: [PATCHv4 07/15] dmaengine: fsldma: fix request_irqs unwind freeing unregistered IRQ
Date: Wed, 10 Jun 2026 20:52:37 -0700
Message-ID: <20260611035245.13439-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611035245.13439-1-rosenp@gmail.com>
References: <20260611035245.13439-1-rosenp@gmail.com>
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

When fsldma_request_irqs() fails on a per-channel IRQ, the unwind
loop starts at the current index i, which calls free_irq() on the
IRQ that request_irq() just failed to register.  Decrement i before
the loop to skip the failed channel.

Bug introduced by commit 586f54672b33 ("dmaengine: fsldma: convert
to platform_get_irq_optional()").

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 4475d50a94f5..c04a7fbd2ed0 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1088,7 +1088,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 	return 0;
 
 out_unwind:
-	for (/* none */; i >= 0; i--) {
+	for (i--; i >= 0; i--) {
 		chan = fdev->chan[i];
 		if (!chan)
 			continue;
-- 
2.54.0


