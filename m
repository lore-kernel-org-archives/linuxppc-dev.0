Return-Path: <linuxppc-dev+bounces-29645-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D15CCF2C9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:16:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6tMm3pqVz2xnS;
	Sun, 18 Oct 2026 20:16:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792296878;
	cv=none; b=JO+gL/NqBydLz6bcX929CgHByGp4PzjZCrB5jVxyIc6ASkQDiLehLOEWbcOFxN4gAudXsbbpzx0AVhhTdrMUJ9lXgecVjGwvER3kBWOrK9Aodi8u3hYAmGwB8HOJlgwIpqwGL7tsEkMeCR9/15u3n72X1Fo3YwHCICoubo1sgQ3knQZpATJQn9KZnng6rvHB3NgtAYMIsJIOeKfn75SqSdZHK3hrbbKn2RxGcyoj4TyR4VmcNCj5FAUgQsb+nvp0rt/1j6+KhwcS748+XDwSxDIHEBtmxlg6phuWjJpc+MjazDCtx6wZzTBRUSC5JqM3BYGtIW+c3wIqJomwhBYzag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792296878; c=relaxed/relaxed;
	bh=SXugwLdUOyNBCr4mpnAsSBw9bY2S7YZs8qkchEaRL6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6ro7Tbj2tVJpL9j51b3yBSkbrI294CQfK1TMX++OfBCzDBa5hRrd28NBaSAhZlQ4CYuul360iy7zZjDhUhBlmk2ftiu2vZ2Ulh1NlDsuAvyHBJTVdyDH3PrgW1PjU31Kq/bPg0pgEv2yABm501imnJgriy4ZuEwK1j4QK439AZGR54BPm7i3pOqvpWbCvNNwvOMyQuMlXklTir5I4CqUs68aQ+gNXUfks9EhThH65pWQdLw91WZDBvcOARu0REH8q6OyO1K/dPuK80BC4qrOFsKkg6onPHTPLbi1s9sOXaozfX/R3W+gnR1UjoBICMg2SYZ42F1xkNeMAKLAUgGdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=j5t9eGMW; dkim-atps=neutral; spf=pass (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=yaojiale02@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=j5t9eGMW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=yaojiale02@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 286 seconds by postgrey-1.37 at boromir; Sun, 18 Oct 2026 15:14:35 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6lgb4y9lz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 15:14:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SX
	ugwLdUOyNBCr4mpnAsSBw9bY2S7YZs8qkchEaRL6o=; b=j5t9eGMWH1jEU6vcmH
	hJ0BG0o+xoJB80HfRxMDs2+x4Qq9zVweFxIEgWil8IrJNRupqs3935+LnJB+aLuc
	Xd8IZhB7TkDjCWThydVOXpzkuavJEx90aPyVEfIgRN9Rf7ENzqe0lho3P07kCGFw
	DipcWlKdUtE8p7PuR61jOIX+Y=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3n6n9RdRqdUaGAw--.28247S2;
	Sun, 18 Oct 2026 12:07:27 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	Mika Westerberg <mika.westerberg@iki.fi>,
	Ebony Zhu <ebony.zhu@freescale.com>,
	Kumar Gala <galak@gate.crashing.org>,
	Dan Williams <djbw@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhangfei Gao <zhangfei.gao@marvell.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Qiao Zhou <zhouqiao@marvell.com>,
	Leo Yan <leoy@marvell.com>,
	Lennert Buytenhek <buytenh@marvell.com>,
	Nicolas Pitre <nico@marvell.com>,
	Saeed Bishara <saeed@marvell.com>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Srinidh Kasagar <srinidhi.kasagar@stericsson.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/7] dmaengine: drain completion tasklets during teardown
Date: Sun, 18 Oct 2026 12:07:16 +0800
Message-Id: <20261018040724.534641-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3n6n9RdRqdUaGAw--.28247S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWDJF18Xw4rGry3XF4kXrb_yoW8GFykpF
	WfG3yY9rW8tF4Yk3WkJa12vFyrX393J3yYkwsxtw15ua15ZF9Yqr1rK3WYgF4jyr4xZF4j
	qa1DtF1rur1kAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_l1vfUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzR9gmmrURf+2FwAA3N

Several DMAengine drivers defer interrupt completion processing to
tasklets, but release channel resources without draining tasklets that
were already queued. Stopping or releasing an IRQ prevents new hard IRQ
handlers, but does not synchronize the deferred tasklet.

Depending on the driver, a late tasklet can access freed descriptor
storage or invoke a completion callback after its client data has been
released. Ensure each producer is stopped before killing the tasklet and
freeing the resources it can access.

Each patch is independent and keeps the synchronization local to one
driver's channel or device teardown path.

Jiale Yao (7):
  dmaengine: ep93xx: drain tasklet before freeing channel resources
  dmaengine: fsldma: drain channel tasklet during removal
  dmaengine: mmp_pdma: drain channel tasklets during removal
  dmaengine: mmp_tdma: synchronize tasklet when freeing a channel
  dmaengine: mv_xor: drain IRQ tasklet before freeing channel memory
  dmaengine: mxs-dma: synchronize tasklet when freeing a channel
  dmaengine: ste_dma40: synchronize tasklet when releasing a channel

 drivers/dma/ep93xx_dma.c | 4 +++-
 drivers/dma/fsldma.c     | 1 +
 drivers/dma/mmp_pdma.c   | 4 ++++
 drivers/dma/mmp_tdma.c   | 2 ++
 drivers/dma/mv_xor.c     | 6 ++++--
 drivers/dma/mxs-dma.c    | 1 +
 drivers/dma/ste_dma40.c  | 2 ++
 7 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.34.1


