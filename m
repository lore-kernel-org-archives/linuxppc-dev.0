Return-Path: <linuxppc-dev+bounces-28027-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9A7C9830E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 14:17:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqfF41JCJz2yqq;
	Thu, 24 Sep 2026 00:17:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790171595;
	cv=none; b=cuv9FIQCsTI8d5Z3JOsIhEMCjNZjp7UQztgsZcRUpfbMfdjkouQ3MreOtsrlSExQjL6CR3Q9CXsk53WPCExlSuCFu2pRteyNrmTKcbYc6v9YcvSNdHvwmSiiOQyRb17seQWozgVyyNVMcytSMfDO8W+5JoZ7oPa4UBY/ypnIwAYztnoZxP4CGqcteOzqOU7Z7tm84C4PvaA5F9QmDY5O56oNSX3BN4eJZZp5oCemfyLo39UaY6qn3HMjsApAp8o5KTP08x1BXOuAuIKL/T8+6H/TZ7tU1gImn0VIOUj7FDd7NUt5FO18W4zIZcUpKI2Xuwf+OR59NiB2KE+D9TBI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790171595; c=relaxed/relaxed;
	bh=2SglU6SsyzFxHFyMmhSwCTOipsWKClut0lOm4koa3sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6KBpScBsspy3clt5V9Zpfd+WRVxOpD7rF66jU1pWMvBvbbdCJ43AfG5wIHh1iq2QNkfMc459yZ+igzC567IBKC/QdRwPZa9NrVjpNe72b8SsNQfVg/WUpFq9fa9E4GBn+5d2atyl2I8yH1PgE8daTYPjUq5t3EK2t65F4iKhIKLYMD6FbRU+8WiDldjZf3/utn/l6wts+ZfAZKf6ePmZV80unD3bq3jMZ5IPehRcSEl6XOtN+YnNaxHe9j5//WBzB2lL9KOicnPYLTKsBwa2+fohrYHX4ZqrszuYHZKjlrcD5Y6DKjIHsRKeV8YmrlDkl0ON8E2oQW/2FDqF+ERJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=efzRc0Tb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:39::10; helo=mail-ua2-x10.google.com; envelope-from=qwe.aldo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=efzRc0Tb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:39::10; helo=mail-ua2-x10.google.com; envelope-from=qwe.aldo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua2-x10.google.com (mail-ua2-x10.google.com [IPv6:2a00:1450:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqdhp20BDz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 23:53:14 +1000 (AEST)
Received: by mail-ua2-x10.google.com with SMTP id a1e0cc1a2514c-97e7c72bfebso321234241.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171591; x=1790776391; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2SglU6SsyzFxHFyMmhSwCTOipsWKClut0lOm4koa3sM=;
        b=efzRc0Tb61/VGwpZRQT/eP68ulQ7h5oQ60aUGJhHf1nx9nXS9GPY8nIf9rfPwXrT3k
         6VbCy3wG+M9vAspyaP0HSOJHqYzreEXSTExF/dijeiUCvnGxN6tAfrQ59kr/vG+l8SS6
         lUQroP+VBuYmdIZ1bOCZ62Je6fk5E9PpqjVdPHMe7ruvc2Gai3o7MRIn9kCMAr10geZX
         PRuNbCLvu73UepRqUYtS1B4BDH92uP1Jsyf6Y+EO7ousSJTp5AkSKUT2HHbLTdhElrDK
         6AT2vjopboRgTR9SlAYRpXl9avviGtvk/TG5r77itEFshDftm4ciL6fhs/g8tZnhf5ia
         8nBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171591; x=1790776391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SglU6SsyzFxHFyMmhSwCTOipsWKClut0lOm4koa3sM=;
        b=rnJUW/K6KXLVYhaI1dM13N7cidQ7KGzY6kpDnRKzbcY7cw95kN0YWn49Gn5bbpw28Y
         ZSYjftgjXuCv3KDLwivAPX/rF6rSiHX7mvy6W+rbPqvF4uQJEVYVLQoIyyP4FeLkxLlI
         vPgs/X2T1MokiBcD8lmztH/wtwZlyTM/I+SxqWfeAqBUkKHvGW9vBDe6csclPWx+VAZW
         TuHW3xuZUIXUwuXcJZN3aUlxa1c/37B4UOam0KGBxgytTAhsysXV5DLT3PnCh4Z7fCDp
         wD9NWiUPape9mD+7UN5PQRE1o9bVtxs0y6Iw8hbUKFmwr+tW1cECJ15ymKSnDH4TESmc
         LXWQ==
X-Gm-Message-State: AFuF++mYW5ml5xSUZa0BCziwfRbqK5w0pTa/K0Rp3V33vn8y8E/Dh07p
	QtKRV/9ppJOCX+qxYNmXgMuaJTtRoqDW7dtj+mPLwx03QAhZYMt7iVs+
X-Gm-Gg: AYBFou0K12n4R/pJ0Hn7f0stQqQN80Cb9GQcR8rKYi6Pi+TynxCGh8d8Kedd/YsUnn6
	y3BHLwTPUnAQ68zJ3WP0CWEegXdvLfWup3jmMcImOpJ1CCucThx8JRqbolYvsljz/ITSzN1o1Na
	ZMfOpX2/hpLeTFLlpMc9V+BDBOIex7V1S5TUD1g/hu+d+fYUtr8qOWuFT5Qo2crhOszSXsrI0YS
	7PlDJVGqoD6TCOfWyY8HYTmOyt6cQWU32bZR0lWiOIvPgjo5noCBF8zjhGQ4qnJlBdXidkZAZ4V
	77LLdeeWWQ/GrmZGrtWIp4ttude9XJSjebb9uFyM5fAMSc1uxaog2uUvBnJXC1uajjw+DfKo45J
	1waNnBKREOTkGmG5ejIA7xyn0rPeFKAb1Du0XKcpVZy/wQb5Ch31aPjajenDwKBsWSB3jpmkG8e
	lgkO0v5RQQlhDpChkoe010pceOD0B+weG/DnfXrkA0MR+QYw90HVRgddAxn1qpQcI=
X-Received: by 2002:a05:6102:3f8f:b0:7a5:1d50:ac35 with SMTP id ada2fe7eead31-7ac1db3268fmr2130763137.21.1790171591494;
        Wed, 23 Sep 2026 06:53:11 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf35bdfbcsm3911189137.1.2026.09.23.06.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:53:11 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: vkoul@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] dmaengine: fsldma: kill the channel tasklet on remove
Date: Wed, 23 Sep 2026 10:53:01 -0300
Message-ID: <20260923135301.2448228-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

fsl_dma_chan_remove() frees the fsldma_chan structure without first
quiescing the channel's tasklet. If an IRQ fires just before the
remove and schedules the tasklet, dma_do_tasklet() runs against the
freed channel struct, causing a use-after-free.

Add tasklet_kill() before tearing the channel down.

Fixes: d3f620b2c4fe ("fsldma: simplify IRQ probing and handling")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d9..0e2f848 100644
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
2.43.0

