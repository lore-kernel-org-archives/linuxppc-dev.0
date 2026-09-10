Return-Path: <linuxppc-dev+bounces-27043-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF92CC88E41
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 20:28:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgq5J2gjNz2yrF;
	Fri, 11 Sep 2026 06:28:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789072132;
	cv=none; b=oz30hVLHu/yZiPuhKAKzrDWdKvo4h/yz4Ml4nNuHDdx7/mZUk2JA47k6CulP0K16J4zxEsN4pjNsGZGbn8GRW+juXT3bGf+my3WFDVOF40iIFgYuODMTFbzVCrrQyt78C0hZU5Hxd7ShX0BAgScMni+MOgdn2WEkEJW744PVeaVNadNL/6Hj4hlnt2STp7jxcYiSwrujwKdWKtQ7xigK7XPpMUvHOkigwuS8CcqJb/WgTN6xqnQZ0ScpXbiY+uN5zsBoXI/z68YLrery/LCMgXO+3pJ1g4nSutxCQcf7D8+gQE8GUM0ILIU/zcs4IeKZW2TaWnsPbtkGF04HGcr4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789072132; c=relaxed/relaxed;
	bh=Aa3oYV4B3MU/10qO4ouQXqPc/oc+sYQCXCIbQhucJYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d69ks36DzOwP9VgsbOsM7TTIdW1PM8Ccb8GqFZtNrnsZVPScVo2dRQ6eh/Fgv7PqSCvFjyGRYXpYUIPvx32yaTrl9O3iUWIg6GMv2O7FLLkYHxvW6lzD6iYDhFrzZtd038CSwSHfqaVL8ErRs0tzoxQII9u6ymUYa0n4DzPRn/RxzQkUxL6BZabHUIWghH2GIFTKusC7ZY/Z+f7eycLhLRxOs5dd8Fqk2t72w1sI9EhyNWslx7bzZvgbBmDRQmRT+nC6UtSlMusyQnWF6RbsJ+/WnKwkVBhUcr0FgsvMvBdqMgbREaCun4vU+QiG49wub5p6TabPVQX3AK6BYIf4ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=brTjGj9C; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=brTjGj9C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgq5H46vnz2yrD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 06:28:51 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so1061845ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789072129; x=1789676929; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aa3oYV4B3MU/10qO4ouQXqPc/oc+sYQCXCIbQhucJYo=;
        b=brTjGj9CXYEm9uYldSBms/2DHPoWQ7gjXIuIMDGivseIcvS5a1SPCM3AERRmCcmtcf
         a8blDeQoq4YnOV4AgWyNSDaFY3LLD3NYAK29aBMpJTfGnkGy16mfacrbv5y04xVebloX
         XVdLI3aeXjjWmCbd//5iI5Nv/nPKZXy2pkUe7nI/5XGdN0srByNnFKwn17oeh7eQSIDI
         e3kC8vRpqkDNkLjwCQlLUzE0jgVMbXyEUo9bakuZU5Ho9dUzPpTfWCRjvHmGlEH3DCnV
         zM24dgOukODNm0gB6FyqF360fuegrsZ2wSnWCFCX63oaZblrwxwJ/1L2MyUU+rmXTn3C
         3D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072129; x=1789676929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aa3oYV4B3MU/10qO4ouQXqPc/oc+sYQCXCIbQhucJYo=;
        b=WRV9i5mAglGNo7GEFf+voPXiKtw5OmtY76bBhGUQmiLkhVBL5Hgh5V+edGLkddQkIi
         /g7lhS+4taNRUyX5+W5TNK+qXl/uxj5S1PAR4+qlduY67SrGez3IbpRRqECR+GCRIKBv
         5smRf6/4gP9p6R7xOABbiKBEVkhypnD2saq1neUF8nSl+WO7u7Igpy25KkBmggduAWp1
         zjxAJvw8H1RgEvktiEqLm1tde/wgzrZW4aEwgWg5jYM4XVdchRER2Hl5K8o/S+E23AFD
         NqXRbiiMNQtjkoaDU1Vnlk9BgO8MmMjdzoQcWTo+pFleB/GkppshcWPHXm6Ocv/rxe5t
         vckQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4v3UqAiNyTfO3/se0ZOSvl+r9MtJ377YRNmMsYeU+vEOWuHe8zeIdW/yKEbPtjF/Nh+tP641m15uHr3s=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n9N8C/VyC7XjDoDliqBxutdRwZeFjmUedpeYQcJvq+2L8kpM26
	UeBO75R8xacVCu9aP3iz9Hn/Mwru8XAQT7uwm+wEU3+NWa+41Ib8Pz7fI+62Kg==
X-Gm-Gg: AYBFou3MZHFYx5dxDhowhPsRVX/9tb/aLXhq2U+oGZRPt8r2mQzG+yPINoB+JP1wk78
	N0E5WohEpYVHI25gnjSogUjtOyKZEwZ2lEvk3/6XUUTNMdXwop7PL27zPtft9GkXdPo0MjgMRMe
	pCUIwm7If/4ktvstFehyZTyVpndrrWp3tR9felfxNOsoYqUYUo3J/p4AqpMA5XQ/QJ6m/iVeVZr
	z9wb2WxLYQm+bli+oqC0xVrKn6k80QFqt5SxCCt0UfuN/VqzAv3/oAXTXgt0bNxxVxAdfkhj5pD
	FGF8t1C/8Tv2SSw4WvLy+o6H85iDHA+v6XifxCBdDeyQcbsPmImvcg86riQofYMr+P0UOKDxYRP
	Uwd9aVqSFjx3mtkLE6yKH4MKE/uSlxWEfddUM9p44Eep1pN+T3nuSJ8UsaKgAxx0JXuzs61NUlw
	1b1CNzWfGK5FwMIgIPl8ENQcxlDLsGzL8AFrgFak0UssaA/3uk1Uhsh2Ucut+2zhczgi5hrL4pE
	I0iFkv4rGuv9FDTGFAkakwA+jAkxkqBryHKrxWAM4yI4s0dNS+oVEviUAXy+VCK0bvWoPvs5K7E
	a/tu7aexAPsuzSpyx46H3s9jlIEZwgS/ezEe9XyEwVXohB4n
X-Received: by 2002:a17:903:1a4d:b0:2d9:2149:57c0 with SMTP id d9443c01a7336-2dd2a56f3e4mr20652425ad.22.1789072128998;
        Thu, 10 Sep 2026 13:28:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ceb4024sm1430895ad.33.2026.09.10.13.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:28:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Zhang Wei <zw@zh-kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] dmaengine: fsldma: kill tasklet before removing channel
Date: Thu, 10 Sep 2026 13:28:46 -0700
Message-ID: <20260910202846.48941-1-rosenp@gmail.com>
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

Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race where the
tasklet is scheduled by the IRQ handler and runs after the channel has been
freed.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 v2: split from series and wrap at 75 characters
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 6ce0e5668dc2..5eca8ab23564 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1207,6 +1207,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
-- 
2.55.0


