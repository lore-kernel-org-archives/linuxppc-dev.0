Return-Path: <linuxppc-dev+bounces-24275-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1C0C44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:05:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfD3xzSz303D;
	Wed, 15 Jul 2026 10:05:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073940;
	cv=none; b=nQZemSCAfrevTX5TzgmQwW7P7S7dlYHCU29dszvfIGdFHaBtVANF25d4zp9k+ZkSqsh6mr7NZZVgCgMhmSVBDazuRJBM3WBlqW3ON7Mn1GSj/4ZeLc/puJfnKhW/gaw5wxE6Md+VwZ6ymRglz/9xqF2B2jgNE9CFZcSQ5VYwh5nFLBKpiv6vRRZfftilPq2KFfKo8ypleu4qZ0uQfyzHWWtV7QEnxFTyAxiNf8EJzFLlpQKt/0ABD08V3pBSJkw46czFvX1YV9MmqZFgZFE7tWVh89zSSrZnkTi6RCA8EhoLdv2mh0WjfpJIAZVhIj2aHGoclzL4afQRPbu7kp+5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073940; c=relaxed/relaxed;
	bh=IR3qjoddWhjrLMEmYv+RhozuipdTVtOmJ2AYAVnZkBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vy52zvr1x/OYI5cwmJkpTqELvL4t3chd8ExC3eoths3WkprvrZpDfvVuc52RotmNfbTvrMoVIbj+gZZDwEKlwkKqXwkfLIxfYMhrxHLBYBtvo+riiaW91TNkBS+e2Tp027eU+n9T6J+Umyih7zJtx9cIsA+A3ePPVBMmxzyyPzU5XEQFO9OrA4H7LNTSAxWOGN+wOII6DG0C2NEemj5eykkEIZJHWyRA0+QKPjC64nAIC3VFR2TYHtOXsGJuSBUR0CCRDHnKy7seuTBg3BKm6w+sK4SAppsZkVFhI0uSLaA78EGBK34tsJZqOJltrlmbWwGGf0yxxJCwElfs/EDBBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0Ud7qJDY; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0Ud7qJDY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfB3QFXz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IR3qjoddWhjrLMEmYv+RhozuipdTVtOmJ2AYAVnZkBc=; b=0Ud7qJDY4gle6F10k+EC8mwaWX
	frHbP+h0NUsSuye5BAnnlKbMvIrd6KPAP5VQuQJUlEIVskHKOl+0qmflQpA6QJ1hL2W+Dwpf7qimQ
	wpe+GmOpcy1XM6ABd4NxpATKeQ5HANYuekDkhBDoPRQOPIodZU+0o+vp9V1ToOiz1nApWJ009bEtF
	ps5snFZdmX6Hh6AoYtao447Q7xJzTHygXx7RknJwGE03/m2lTryhvSi3V70GLdiXyoQEQ2gas5TeQ
	YP0TibbgzfiHa9qqajxQWuBU9777MCo2dk9kic2K+Ltfg0l7D4H6yTWQfNFz0voIJUy6TUrCz/I5n
	XmLfR6MQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn7y-0000000DTcu-46sc;
	Wed, 15 Jul 2026 00:05:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
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
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 05/14 v2] ASoC: fsl_easrc: use struct keyword on structs
Date: Tue, 14 Jul 2026 17:05:16 -0700
Message-ID: <20260715000525.739874-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715000525.739874-1-rdunlap@infradead.org>
References: <20260715000525.739874-1-rdunlap@infradead.org>
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

Use the documented format for kernel-doc of structs to prevent
kernel-doc warnings:

Warning: ../sound/soc/fsl/fsl_easrc.h:606 cannot understand function prototype: 'struct fsl_easrc_ctx_priv'
Warning: ../sound/soc/fsl/fsl_easrc.h:641 cannot understand function prototype: 'struct fsl_easrc_priv'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: no change

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org

 sound/soc/fsl/fsl_easrc.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linext-2026-0710.orig/sound/soc/fsl/fsl_easrc.h
+++ linext-2026-0710/sound/soc/fsl/fsl_easrc.h
@@ -584,7 +584,7 @@ struct fsl_easrc_slot {
 };
 
 /**
- * fsl_easrc_ctx_priv: EASRC context private data
+ * struct fsl_easrc_ctx_priv - EASRC context private data
  *
  * @in_params: input parameter
  * @out_params:  output parameter
@@ -625,7 +625,7 @@ struct fsl_easrc_ctx_priv {
 };
 
 /**
- * fsl_easrc_priv: EASRC private data
+ * struct fsl_easrc_priv - EASRC private data
  *
  * @slot: slot setting
  * @firmware_hdr:  the header of firmware

