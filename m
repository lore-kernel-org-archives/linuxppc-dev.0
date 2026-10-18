Return-Path: <linuxppc-dev+bounces-29644-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C67CCF2C9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:15:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6tMK4yP2z2xnS;
	Sun, 18 Oct 2026 20:15:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792296755;
	cv=none; b=I39uhsOGPsZW2KAXWcOYMpnKEZgn0I7V8gnN8ln0Fincj5egBdBZQu3ht7YLLv8pK8R/7pnXUb97A04LyhBOrjKgbJGseFyUcXVrJldxshw168flYG83AhtdU3KnYksqDz0yDjZlRL/89KeuiAcSXXzsCRkMc+UBHH830CBga9HJccBnkbDm1HVK8GJBPql25wHyhRxblW62JafHYQg1EitdT7c/NdyCZz7hJ/34b887yNtaV+LehtPYg3XgiBmtOrXvBLWXYdvx9t3Pg7fJNemN1WZWK7vehzvGG+8Y9ILz5xYXYVgUozU/9fiEg4ihMDCaDDaT86yETb3Y9P08jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792296755; c=relaxed/relaxed;
	bh=4c9VdAwtQeTjjI8oj1y01rWgBACkk+geaRj0woQWaeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzTJADIjwFOP/9Yjbkg7GgK53oVjD17BSzC+s1dKJBW2Hy8Vxsa52R/fdfzxxF/QczJz+Qb2R5EZ6gJAP1//8QbqAwDdtwkgW9kTD5Q7+ENmI/yYz5cKqSxEmO2uYLUrYGPe38fja1+VBZ8Veu6RzU8ipz2/+2uRDv5+M+cR9LL39iYOiQ01iSe2l2B7ccpiVhDlSqXG9R+AbrG7PYf+tX5C4ejfO21zf9gK5a6l7J07c/roDIVckFa3UpMPeBTCM8sDRL6+8bxM1nYx2noGa5EFksz3Ek5AA64uOGtJX79bQhqDXMwNIYxe3wDFTya3uQ8Umtgyq7FUCO2NY0kLog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=V9Wi/Lwp; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=yaojiale02@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=V9Wi/Lwp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=yaojiale02@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 201 seconds by postgrey-1.37 at boromir; Sun, 18 Oct 2026 15:12:32 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6ldD0rbFz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 15:12:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4c
	9VdAwtQeTjjI8oj1y01rWgBACkk+geaRj0woQWaeM=; b=V9Wi/LwpVLvm1gXc9G
	CsN0TYwd2Uah9Gqt0XUkna1GKVL6tPgXgKUHa2rgmQrin1lxbHMTuYqP0KVT3yB3
	YNFiOltAnuwiAjZSK7XIEViz55ohdISD97BWtfluWlIpCl11Kh2mf8zPov1/tMkb
	sdSM5a1474o2gw7UC+7J5Koik=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3n6n9RdRqdUaGAw--.28247S4;
	Sun, 18 Oct 2026 12:07:29 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Zhang Wei <zw@zh-kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Ebony Zhu <ebony.zhu@freescale.com>,
	Dan Williams <djbw@kernel.org>,
	Kumar Gala <galak@gate.crashing.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 2/7] dmaengine: fsldma: drain channel tasklet during removal
Date: Sun, 18 Oct 2026 12:07:18 +0800
Message-Id: <20261018040724.534641-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261018040724.534641-1-yaojiale02@163.com>
References: <20261018040724.534641-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3n6n9RdRqdUaGAw--.28247S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr45GrW5tFyftF4DZF47urg_yoWDuwc_u3
	W0934xWr1kCFZ0yr4UtFs8ZFWYyayjgF9Igw1vqF1fX343JFnxtrWIywn5Zw1DWFWUCF9r
	u34qqrWfC3yUJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRyHq-7UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wJhm2rURgLHwAAA3q

The channel IRQ schedules a tasklet that accesses the channel descriptor
lists. Device removal frees the IRQs and then releases each channel
without draining tasklets that were already queued.

Kill each channel tasklet before unmapping and freeing the channel. The
removal path has already freed all controller or channel IRQs, so no
interrupt handler can queue the tasklet again.

Fixes: 173acc7ce853 ("dmaengine: add driver for Freescale MPC85xx DMA controller")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
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
2.34.1


