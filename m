Return-Path: <linuxppc-dev+bounces-24168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D7AC44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:45:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvN1pD3z3br2;
	Tue, 14 Jul 2026 11:45:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993503;
	cv=none; b=fZwDAkS7robjePb4CjGeoED17wXjv2q17/61uT6oih0g4DgJ2xcQ2pZlXdI1r2iJWf1KHp36qvQwllQn72otTbK0KGS82SP3d1nzlNnzMjneSV9KwPXq+iGa4UCtkJnuyaxgQIrB3G6NPQqmlM9AAnU9/MfTBpsxmlEtZhEf1Huqwo+F+BNcWs422O0dLCNooJ8VIzJKxMbj4LV74QAiiFSbdC34fwgMwBmk3ydLRb49/pxT8S4ke80gGKPYHJdFZwEaNr+YG1DPC6SJ3+HzMdULmofwD07FzBhKhkab3OC0/cDKvBei44At/wFuv8SRsSsS2BTEoRqXd7ow7ahyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993503; c=relaxed/relaxed;
	bh=xIMbHNXRgWN96mgMSOPjT3h6eA/9+RO5/tFljxfnX7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXvkE8U7aEaK8HZeioBNSklZT4fo5QYNKzGuHaBQsczY4jS8vkYNHpItob+omx+w9oTNIo804afXBOUKJssDD5VnGbFUhn88gyvijgYiluCUJ9GkHUB431pFEVlGUJLzS8NI0DE0PF7O3PyubC+tvSdeH60BCE6/OeneMJqc3a1QY2ZBC/VLuUgpKbHClGbUWIUb4ObmWk8JG3CAbiICfTLWMNxOoISp+lKSU7suXeBkK/lJqJVR8IFtZRjVtxvszEDkU0g2WUQ06Y+0qeQ2C1M58BwrPj311yyjQja3jEHAYPr8pGq6zdQtR8IQlx/9fMC/5K5xbw7m5SRMbb5I7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZNfgIo8G; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZNfgIo8G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvB4KnXz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xIMbHNXRgWN96mgMSOPjT3h6eA/9+RO5/tFljxfnX7c=; b=ZNfgIo8GsJf8VocUUwG9WSnhLx
	fSZc5Ld9BVIXG0BI0oBNhITGbE7hr0TqQGjT0fQD0JBQp2lvp6v6ZbMOZUWvz7XjLtnJ62WacfUKF
	VS6mxPWqKO3mHRJhS4VFc76hw2vT8dMpwOdaKjrbQkHMw77zoJYlB9CWVFhAl/7KV4uLcNC/EjNSM
	MgH5+E6eT78HTzfZpZNFeK9/T8k0RKG7yDew90U7icwA7lXzOywFejvGcOCXaa5lD8dVlnqChEH0i
	xcBi2yE/0z4zkEVKxEYMPTfcKKBjjf99s20Q0YzcAoMw6cLVpVKTktn3bhFCOFqMarBUCvC/tk7uU
	SZhUT0aQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCY-0000000AgsR-2w2E;
	Tue, 14 Jul 2026 01:44:50 +0000
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
Subject: [PATCH 06/14] ASoC: fsl: mpc5200_dma: use the struct keyword for kernel-doc comments
Date: Mon, 13 Jul 2026 18:44:37 -0700
Message-ID: <20260714014445.569992-7-rdunlap@infradead.org>
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

Use the documented format for kernel-doc of structs and the correct
struct name to prevent kernel-doc warnings:

Warning: ../sound/soc/fsl/mpc5200_dma.h:21 cannot understand function prototype: 'struct psc_dma_stream'
Warning: ../sound/soc/fsl/mpc5200_dma.h:50 cannot understand function prototype: 'struct psc_dma'
Warning: sound/soc/fsl/mpc5200_dma.h:35 expecting prototype for struct psc_ac97_stream. Prototype was for struct psc_dma_stream instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org

 sound/soc/fsl/mpc5200_dma.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linext-2026-0710.orig/sound/soc/fsl/mpc5200_dma.h
+++ linext-2026-0710/sound/soc/fsl/mpc5200_dma.h
@@ -9,7 +9,7 @@
 #define PSC_STREAM_NAME_LEN 32
 
 /**
- * psc_ac97_stream - Data specific to a single stream (playback or capture)
+ * struct psc_dma_stream - Data specific to a single stream (playback or capture)
  * @active:		flag indicating if the stream is active
  * @psc_dma:		pointer back to parent psc_dma data structure
  * @bcom_task:		bestcomm task structure
@@ -36,7 +36,7 @@ struct psc_dma_stream {
 };
 
 /**
- * psc_dma - Private driver data
+ * struct psc_dma - Private driver data
  * @name: short name for this device ("PSC0", "PSC1", etc)
  * @psc_regs: pointer to the PSC's registers
  * @fifo_regs: pointer to the PSC's FIFO registers

