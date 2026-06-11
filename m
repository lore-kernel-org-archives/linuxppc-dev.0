Return-Path: <linuxppc-dev+bounces-22451-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA43CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 03:53:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbTJR05cVz3bsY;
	Thu, 11 Jun 2026 13:53:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781149990;
	cv=none; b=O1PQuIw26leEoyueqUdN7ZsEFPRaRzZzo0GQ+6/DxcFXWO3A4mC6EXPubhMDPHu5E9EzgX+ECKxo4ctfOJvwgtX8pF5OrbCUimtcOxIbFw2tVkoVTduQ+IG9lJunuQ0hrdOyPrEupsMWJ/V4c9RkTOkVblXIvnKzkW8Px5pdCnY05eE1rLjX0/SlCwFUgzvPA3CbZkQkIx7FOS1fiM3qq9KT6JBLtK5uJBCFQs0Cmhdg07XvAB0Urn0JrYu50AjGt+lvEoU+A95zpuSpI6/SYVSRiljLoS0p4ivWp4EaWbHnUwIqDOSLaIbeF+FBW70LXYB9xmDyekppQohC/tIB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781149990; c=relaxed/relaxed;
	bh=/U4fRir7cY7WmN1QFR3JHwmFXZxM36Et4Gv4EjzBgmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orvm/fggV04D5qJuoGa+n6diyJX1yQLZkTpW8W5WBWzi9aTFhkE2BtdHc8W6VFjfUzU8QhWTsp/HA2+TuDiwk9SpdHRS5UEYpT/hXShIBkzTkSEW4UlNuHzfhN8YrKtBI5USgiidHPz7oELX/vij6HvmbWOIw+Pbxu5edNc+ENeEAnPTt8uroQ/orjDCYqrNnx5xkqF/jl8iSQPgwIT+tpzJ/nEEFYX9lEacrImDo7JmmFq89h/3nK1oBVYQdiO+5o41PBWq+hcpOnevUawpDStOs/EleYecUSyFwhpqtscPjXmkSokxNUk/ZKKwoyNRBMxsweWSWE7z/K+hXj6kRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FCOgr4+t; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FCOgr4+t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbTJQ2cgmz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 13:53:10 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so6314739a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 20:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149988; x=1781754788; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U4fRir7cY7WmN1QFR3JHwmFXZxM36Et4Gv4EjzBgmY=;
        b=FCOgr4+t1bLXqPaj8tiOmjvRj5TggISUbFeh2o8HpW+9P+o2IpGp0wPEcNEWTSSq1b
         qOeLA9l26RivUpa58Zrb3cOnXGM0SKcflwqQSNjvpe1hmHOsYTn95IQolAKrYZXamL7n
         n1XjbOUYCFr59rso5XgHoPZn7QADouqyFcdZKcKwnLxU14EeK9xsANaJsQL8+wqplEeq
         knONpWN3xx41SbhxPYIpXF2A2QkT/uDfDIW0hwCDLjIYeZjTxDF1dEXshixOifrMNRxb
         oycgFIH0xAeXggSuQ4jcjTXUKNJpEA3tgsg4pUfd9b3OuApM4zjQRglYUsSeQ+aTmTOc
         fIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149988; x=1781754788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/U4fRir7cY7WmN1QFR3JHwmFXZxM36Et4Gv4EjzBgmY=;
        b=NAHTJFt3KuTr9rn2iWqSTVPlOsszs5hymruW1ycGZfSv4TJJAN7RviLo4+SitckD/r
         ULvJ6JviWp+nqi72PthRYlFSxYsxtUBvkZOQBFGhNWkbSOBruRhTasixE+OzorryXfK0
         mh5jD8JseLtbHwbH1V9iodbSB1Hj7spc4jzkf3wgfdha+zMdlxgKMWRjox/Sn93ejOFD
         6yLcvCYBn02QbKI1ELoSPMnSgrl4oDgaBAJ+y1B2hxPNyuYAxarRvjD8s68p9YVzYzZ7
         Nh+kW3KPGxpyDy2hGIQiR6VI42xn6YaZMDuOVRLuZTcd5tw8x9GIxNYZAoL4a8o1boM3
         gj3g==
X-Forwarded-Encrypted: i=1; AFNElJ+jfWVXBkzP0Nnps2/WhjhK8ifL41EfNuACYJ8NQi25R12wMcyUl9IXNv6GrFCJQX1q3mVtu1cjMBHm+rI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyCPbYmy8C4hFsA4Jwugw4jyLNT+0FTXUTicqgp/BUVSDqw/SHK
	TnkQxOfRf2WGAKl35ibEMHvtAeOfEJ7Tg9kWo0hxQ472DbLcsfNa/CLY
X-Gm-Gg: Acq92OEkUESPwVOOnTnaD3mexGT8/ugGW8vZypomgU2mn5D7FUs/7JbnK+L/QzpSTJi
	bn2nZPioWo92NKit5kAN5J/ZBrjbD/Bm54a2l/SZJl8Kr7FvvM4bwH6bvua+6w+jqh0Ny8UGhNu
	gpXLPfd/U4XbSnEvAwPPewdRwQLqnrB2MgX8DAuZU/DNqtc/uvLYv+cF6P6DqNAl+IyNVvUvEk0
	HqpcwXDNzDLbh/SVdvIn3UwI117c0xZwggNDROkLp87dXIv7VygFd35BieOelBi9WLIl09SGOxu
	Gea7Kd5S7KYlTpZoBiIra+1/MbCiQPHRlUmKLFS+O9m91ekBFd3tTSdO+2R6hRggtHiOEbsHDq4
	phmZC6gbkOzOQuYP9+zGtJM7hS9iXU4wYoH/Tzouc1KWBFfS+1B+APXUuj8LcldTE4fIUMbBPW9
	G3oaCLQSVNyxClQWj+cXZTXptmIIG40D4Hu480MqzzXcMXAts+CR/aqAOrz53UDjmjx1W1XGLPP
	4UhExEUHajNMOsjr80I5bFAFxxbLkwvuELwnLUtU4TvAw==
X-Received: by 2002:a17:90b:3f50:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-377a870982emr1259378a91.22.1781149988448;
        Wed, 10 Jun 2026 20:53:08 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:07 -0700 (PDT)
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
Subject: [PATCHv4 03/15] dmaengine: fsldma: halt DMA engine before freeing resources
Date: Wed, 10 Jun 2026 20:52:33 -0700
Message-ID: <20260611035245.13439-4-rosenp@gmail.com>
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

When a channel is released (fsl_dma_free_chan_resources) or the driver is
unbound (fsl_dma_chan_remove), the descriptor pool and channel resources
are freed without stopping the DMA hardware first.  An active transfer
could continue executing in the background, fetching descriptors or
writing data to physical memory pages that have already been freed.

Fix by calling dma_halt() in both paths before cleaning up, matching
the pattern already used in fsl_dma_device_terminate_all().

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsldma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 455d21d738de..1ba10d065278 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -748,6 +748,7 @@ static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 
 	chan_dbg(chan, "free all channel resources\n");
 	spin_lock_bh(&chan->desc_lock);
+	dma_halt(chan);
 	fsldma_cleanup_descriptors(chan);
 	fsldma_free_desc_list(chan, &chan->ld_pending);
 	fsldma_free_desc_list(chan, &chan->ld_running);
@@ -1207,6 +1208,10 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	spin_lock_bh(&chan->desc_lock);
+	dma_halt(chan);
+	spin_unlock_bh(&chan->desc_lock);
+
 	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
-- 
2.54.0


