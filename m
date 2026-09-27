Return-Path: <linuxppc-dev+bounces-28291-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD3CC9832A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 00:14:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hslKl2fqgz2yvy;
	Sun, 27 Sep 2026 10:14:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790468043;
	cv=none; b=LpW0KxjYZbvOrdKyod4phySNGausNwMmVLbXukQPDHSihR9EkyWqUhDSzubGhvkd3jisKfd1mvjl5JP07kgHgqDbarqDuoYNLT0oySqjIKkA/A7g2ik6IVaiYAKZA4a1owT4ytjOno/Te1iaFgQ/nPoVcFUEB3hCW2v1z8DIlA6htzC6MfKXV4vpSIyiWU2X3P1GSxK3xJRxkXLO9JfJ7l+KpcC8Yxe5Q0E/Cqc6Z7QFSpN8xspWEStBu5Xp3mLNo0woCfmwuXd7qhQ+c11kDJbHEbRiPX1P5UtUikkQWvtHHWyxL2BLqW3GEJMvJHWXdMNtc8odOto9fFiItUmChA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790468043; c=relaxed/relaxed;
	bh=5wX2zHmVieIbX9IZliot43YE98VxjQn+jLn3httBBt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cq4O+TrnHt0L3MvTSjlYMWinLpDR5zwpmZv6uChYrpEfjGlp/gnrNYyGOd0K5b4oSZy6NL0/fgOsWwpfIihLCY9dUgdfsq5XV1Srw4CIb65hq++97FH0avPwnEw8KWPv8tz8FOEyxv/44snOAgRe2BJhFze7aYf++DWqaU4dZoa6y+RrCIkC4XJEyMkh6euWYeTBiVwNvOK2AsoYNRwZL0YjIBqenQr55tp2aQOyWzUlI3E7OjoRd5p7oD3zgMFD/UmtBIEW9jMcxgTzrQvqcQ+3ek+xff8Lxo4RjqXCA53fyuJA9T5cx+3mvF8sX8M1TowapNVEe6X0GuCiN2OeIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=gxq8amE9; dkim-atps=neutral; spf=pass (client-ip=45.254.49.197; helo=mail-m49197.qiye.163.com; envelope-from=bolin.liu@seu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=seu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=gxq8amE9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=seu.edu.cn (client-ip=45.254.49.197; helo=mail-m49197.qiye.163.com; envelope-from=bolin.liu@seu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 311 seconds by postgrey-1.37 at boromir; Sun, 27 Sep 2026 10:14:01 AEST
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hslKj2g3Wz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 10:13:56 +1000 (AEST)
Received: from seu.edu.cn (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f363ff9d;
	Sun, 27 Sep 2026 08:08:38 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: error27@gmail.com
Cc: andriy.shevchenko@linux.intel.com,
	shengjiu.wang@gmail.com,
	xiubo.lee@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: Re: [PATCH] ASoC: fsl_asrc: check the second front-end DMA channel
Date: Sun, 27 Sep 2026 08:08:37 +0800
Message-Id: <20260927000837.10151-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <arfYxD95RJRcKCbZ@stanley.mountain>
References: <20260913125147.109920-1-bolin.liu@seu.edu.cn> <arfGajXmMUeew0fr@stanley.mountain> <20260926141011.451552-1-bolin.liu@seu.edu.cn> <arfYxD95RJRcKCbZ@stanley.mountain>
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
X-HM-Tid: 0aa0e0313ded03a1kunm718d2f09198cf1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUNKVkwfH0gfSh4dQk0fQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=gxq8amE9UZiE8tCY4kpg++XrI/9ASn3V/B6Xp81XWMamSv/9Xrzig0YH4qPWkO3s1WooOBS2nVu9aXv2Dzp6nVv+RNMtn8w0+FhTEUqEsYnlkBXu8A1T0F7H4aQ+w+NOTjaUbHbbaRb2Du8fK/ShoT0BIILFyzknCeaKkr2wPZg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=5wX2zHmVieIbX9IZliot43YE98VxjQn+jLn3httBBt4=;
	h=date:mime-version:subject:message-id:from;

Hi Dan,

You're right, sorry for the noise.  My v1 was written against mainline,
where dma_request_slave_channel() still exists, but Mark applied Andy's
conversion (b045248399d0) to for-7.4 three days before applying my
patch (b4136c0d69ea), so there ->get_dma_channel() propagates error
pointers and the !NULL check is ineffective.

I've just sent an incremental patch converting the check to IS_ERR()
("ASoC: fsl_asrc: fix second front-end channel check").

Best regards,
Slavin Liu

