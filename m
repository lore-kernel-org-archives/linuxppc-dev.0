Return-Path: <linuxppc-dev+bounces-24279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C622C44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:06:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfH1ZHtz3br5;
	Wed, 15 Jul 2026 10:05:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073943;
	cv=none; b=iiYRGt/nY9js6waXkX06lUmBa1hWxeRuejAud0j2J9zaJahfVPbmbzgg2sR0uzqQq9YLe1UlAJVxZyzAR/BPvxT56XjIrbX3yZaymbNsDtsPRe/qLfE1LGV99LS97+6hFvu8E+sGE0yIsgQ/vXF5VRLAq03WOzDGOMx5gkP1XsOjOO+esh2K1hTucidk3BcEQFPMut9ba7KwMkEW08IYWsxpPbbOBRBPpk5UNINwJI0+BuJ0jO1f+R6fTzXsRgABvzIs+ta+IySLVyzxjhYIvx2G4afCOdwLsZ9qe6WVrfXvcLcFiLZUh/LKmEzl3tKgbXkCYXdEZ050gs6PXckFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073943; c=relaxed/relaxed;
	bh=QfGvfC9/hXJmNDdXlodJG/Zikxj+nGFIjS0nGqw5KLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy3h6/NRVqY9hq2jVAlOu5sSMq2wlxAAazRHNPIG5HpIOe2smsOaDaCCJTd84EWsrSIAJ3KZVhe/Qt6r/gfHcXt5k3HprjQhybnpI6LZhiKZfXnataqC5H/uBFvDPYNYivPUfoHRCgCrUk7NIpgBhpsyXy6OytTDiLJBSofzqCLPAr8tpkq76zM6gON1WktJBdRReuZdglg05GwPuUCgLRf3MuN+DCwMtEdKoXKaLqXe805L+idp1BNGCO/6Kd138vtQlareMq5HyPdNAnB2ZwjAfVNgOwv89I0Kc72EAXhPbrNrW7XbM56fb5prS249WQsLuSVQFZtYmXTeD1lJpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3/Skb14K; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3/Skb14K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfB4vvMz2ygX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QfGvfC9/hXJmNDdXlodJG/Zikxj+nGFIjS0nGqw5KLc=; b=3/Skb14KpqKl8XgD2qSmCo5Omf
	kUwlHnGIkgJyvOZEx7MA+s2OXp6Px+wU8qKdoE9DSGSIX0JVf+fdPt/MNtQp7BY2/ZFs9PjW5+E1A
	Du7qQYNmqY6dsQ7mmh0mDWlXqBMNqMyHFVxm2cKwQa3YQYiPUfVPhEGtNGPKVVSJFcQFlDO6e18fP
	qG2B/hGW4XyUUoxHdRLXXlYDmr0jQ+r4bdESGIIMmC+A6F+ZLbdKYo53wVtIC2GiS3JSWmmBeuIO+
	iw9YZ+bcFAwNx5CPgvH8TeJWK0LhPN4aQRmOQCbPrgymVUNHap7lRae/3m5V3LiaITJKY1iXspsJ3
	ZI0V7i2g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn7x-0000000DTcu-3IAY;
	Wed, 15 Jul 2026 00:05:29 +0000
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
Subject: [PATCH 03/14 v2] ASoC: fsl_asrc: avoid kernel-doc warnings
Date: Tue, 14 Jul 2026 17:05:14 -0700
Message-ID: <20260715000525.739874-4-rdunlap@infradead.org>
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

Use the struct keyword to describe structs in kernel-doc format. This
prevents kernel-doc warnings:

Warning: ../sound/soc/fsl/fsl_asrc.h:452 cannot understand function prototype: 'struct fsl_asrc_soc_data'
Warning: ../sound/soc/fsl/fsl_asrc.h:463 cannot understand function prototype: 'struct fsl_asrc_pair_priv'
Warning: ../sound/soc/fsl/fsl_asrc.h:475 cannot understand function prototype: 'struct fsl_asrc_priv'

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

 sound/soc/fsl/fsl_asrc.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linext-2026-0710.orig/sound/soc/fsl/fsl_asrc.h
+++ linext-2026-0710/sound/soc/fsl/fsl_asrc.h
@@ -444,7 +444,7 @@ struct dma_block {
 };
 
 /**
- * fsl_asrc_soc_data: soc specific data
+ * struct fsl_asrc_soc_data - soc specific data
  *
  * @use_edma: using edma as dma device or not
  * @channel_bits: width of ASRCNCR register for each pair
@@ -457,7 +457,7 @@ struct fsl_asrc_soc_data {
 };
 
 /**
- * fsl_asrc_pair_priv: ASRC Pair private data
+ * struct fsl_asrc_pair_priv - ASRC Pair private data
  *
  * @config: configuration profile
  */
@@ -466,7 +466,7 @@ struct fsl_asrc_pair_priv {
 };
 
 /**
- * fsl_asrc_priv: ASRC private data
+ * struct fsl_asrc_priv - ASRC private data
  *
  * @asrck_clk: clock sources to driver ASRC internal logic
  * @soc: soc specific data

