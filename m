Return-Path: <linuxppc-dev+bounces-24281-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DE4C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:06:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfJ3vpWz3bxR;
	Wed, 15 Jul 2026 10:05:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073944;
	cv=none; b=mNHplVdPZ4nMQhugfE1hFI6oLce49P7B79KuFN/AM8PV5EYIi4lAX/U8jDqV9xfc8Vzfah0eE3Xm2H/PHJq6/wch2e5N3lxAJq2xxj1kXuYOHsHkMByL46RyB6Rwq8VTfN0V/nN4olj8G1VbP7E20yrp38lVBjKVwn8012nf0C1EOVChzl8Fn7m1uXHrhXteLqmkDraECPCbZ+Xiz68ZH79zF/fM0AgkM+GSXBi166O1nZouKeE4aLyj/2BIJia3WtL6rMLjQGm3S2b0xBg5L+NCaY0sJALJ/R7Z7DJdrD9h7BJSnose4sZPnGVINtqRFdolwFipV9F/U3RJ5oyMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073944; c=relaxed/relaxed;
	bh=13+kOO9irn/A7mQQp6b2R+oh3w+6rv8EFxuB7M47cVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDAxsa8QEc/cehrKVzGiOZ9lAYCQNdmGK6O6qTVFhw4Ldpj6x59gprDhmOuGVNwV07gEUDw1DX1OZgbHXQOjWpCzOwqsrw76bgw2eKsL2YXeJem3aLLdAPIyoI2ue/Su/GMcRe7TiUQ7k6OFpvjtFPMryZFIAijByGz0RukMLuxDpi3ACggvYBrp9CkEYY64ALKMr3nQM3IMKgEPMBrbCi2uYMYXW/yNX/CTtRkMkEFw1MrA6x8H/K63xEeOemEQKZa5SK1tvUbZxB1V8plhhX0vJM7f5V+9hLMJb1p2BdSM9Usw65aN0UFoQXpj7fkLrsho2JGwpbDUa+HfgxQ0dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=borUDlxS; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=borUDlxS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfB5Pjvz2yl0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=13+kOO9irn/A7mQQp6b2R+oh3w+6rv8EFxuB7M47cVI=; b=borUDlxSSHeiJQzdvEyjL09ewq
	JjVhpWQhGcmpl4kw0HwhRSUyJw1CoRaeAeSxQYbvkliytuSCGFIpUYuU4UJVAtCdROoK7QYZFzjBu
	BKOp4vBO5wLHIxwaUZy8XRNPtl1mBMyQLN1VWzIgDZmXyGP0cKMPD+t7F70p3fGYvYSVE6bLOUjl0
	i7+8TSLk0SGYNov9c5qgpEPwktMPMbmLIaj9pjUFhkwuIVi3lcu9Tf4j2nrfeZLz7RTSxQ58cLZJW
	+ymlYcMjyC5659o9tjfrmrnS4hF4F6YChsUlv8ZKdq83L1bzVEpICTDe4pG3keTy/PLqxysFH82V1
	jHFoPnQw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn7z-0000000DTcu-2NMf;
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
Subject: [PATCH 06/14 v2] ASoC: fsl: mpc5200_dma: use the struct keyword for kernel-doc comments
Date: Tue, 14 Jul 2026 17:05:17 -0700
Message-ID: <20260715000525.739874-7-rdunlap@infradead.org>
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

Use the documented format for kernel-doc of structs and the correct
struct name to prevent kernel-doc warnings:

Warning: ../sound/soc/fsl/mpc5200_dma.h:21 cannot understand function prototype: 'struct psc_dma_stream'
Warning: ../sound/soc/fsl/mpc5200_dma.h:50 cannot understand function prototype: 'struct psc_dma'
Warning: sound/soc/fsl/mpc5200_dma.h:35 expecting prototype for struct psc_ac97_stream. Prototype was for struct psc_dma_stream instead

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

