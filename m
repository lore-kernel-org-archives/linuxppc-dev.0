Return-Path: <linuxppc-dev+bounces-24172-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94077C44507
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:45:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvR4n45z3c1L;
	Tue, 14 Jul 2026 11:45:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993507;
	cv=none; b=JSUcuxdsBOzFyfazREvupuGxE1FPrEARCNYMsaaSXYnZhHBujTdZbBP0uKjIxiYb7wsgtaFoMZ2z03LFCbL1sa06hUAHz7J8ZxUcw4Iq5mSvB76tRqwxHXg7vf6UtpAFlXhUBT9BXsC+cNRAoBxcTLjznoRD3AgFy76zHgEco6V6WLHCQRPncaitGLypaE5YRnYdWPO8cpHdfZxGVUmXzGVz84RoOgKkNfVldXGHPLm4GaOEDG3rs9j2s/7Mi1mqsU0q3zAUjC4xNcVWtUaPDyUbwOH/ALdn4yhjNAvuujCz6prMyimL0OcOIUDKSfSACi7mATBODiUtZLPwgImiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993507; c=relaxed/relaxed;
	bh=Wzo+p7kjYg1zo7BvQPSNimvM1GKqs370chQONJWgl9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6EDGx0kTn1BI25Cqi3dmIHDySVNXConyxhHMHa7BZMJ8MWAKNAuhOSYBPlAYgb+KLqkVaKwojg1IiPep6rSsbdz4gyhcJWO/PqthMrVIB/6r6Gwc90jd0zgKtNpv/w0y/cDivMgg1bN5G2bhk5GcPKnICvRhMyqfXOuRIcY+aaECNDvo1ZOOcVTYFMLnxk4B7A21umPn1XrBL65w6+CtOmuv2sc4d6ja8dYW1PESmzM0G7JeVr7wfH3A2Z5YFwecPXNZ51prxZWD9CPDipkJadWMyRzv6WLxfdvzLSTBaSmT39txj3rlU4jTLYQqXhXG6S0Rr9MxMzYKPqAoUNc3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vM0exWra; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vM0exWra;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvH0DgHz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Wzo+p7kjYg1zo7BvQPSNimvM1GKqs370chQONJWgl9E=; b=vM0exWraEZ+kdHXAEppLxIFTfI
	OmYMJ/qGZ+LrbRrEhYU3k+gOEMto5M9WhQrXiM0/P5vXLhB3olLHmvhW85Re79hPTpvJHSjIkidOx
	MtUzephqKDGpelmORpwQtfC7D2wBVvYG/o6dulk5Lk66bXvw1UeAgsaz9A2364arzbrk8z776VKi7
	qwKrqtQQaMiJ5efVBWz73dKgknQjCt3KVl57K6fQfTwOG60eTeCPeyZ3AauIx5sZIdFMf7Ue1NwpM
	vjC/YZBg08hf8ZVJ0hsZeGOUoScyL8xuE0i1fEhcJdBMQZ3PVeIHs4Aej2L9KEk1EeOyxCd9xm8Ih
	8FoW6qEw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCd-0000000AgsR-1Kwy;
	Tue, 14 Jul 2026 01:44:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	patches@opensource.cirrus.com,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 14/14] ASoC: wm8904: don't use "/**" for non-kernel-doc comments
Date: Mon, 13 Jul 2026 18:44:45 -0700
Message-ID: <20260714014445.569992-15-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714014445.569992-1-rdunlap@infradead.org>
References: <20260714014445.569992-1-rdunlap@infradead.org>
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

Modify these errant comments to use "/*" since they are not kernel-doc
comments.

Warning: include/sound/wm8904.h:119 This comment starts with '/**', but isn't a kernel-doc comment.
 * DRC configurations are specified with a label and a set of register
Warning: ../include/sound/wm8904.h:134 This comment starts with '/**', but isn't a kernel-doc comment.
 * ReTune Mobile configurations are specified with a label, sample

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>

 include/sound/wm8904.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linext-2026-0710.orig/include/sound/wm8904.h
+++ linext-2026-0710/include/sound/wm8904.h
@@ -116,7 +116,7 @@
 #define WM8904_DRC_REGS  4
 #define WM8904_EQ_REGS   24
 
-/**
+/*
  * DRC configurations are specified with a label and a set of register
  * values to write (the enable bits will be ignored).  At runtime an
  * enumerated control will be presented for each DRC block allowing
@@ -131,7 +131,7 @@ struct wm8904_drc_cfg {
 	u16 regs[WM8904_DRC_REGS];
 };
 
-/**
+/*
  * ReTune Mobile configurations are specified with a label, sample
  * rate and set of values to write (the enable bits will be ignored).
  *

