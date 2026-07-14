Return-Path: <linuxppc-dev+bounces-24166-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98306C44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:45:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvL6kpMz30Qv;
	Tue, 14 Jul 2026 11:45:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993502;
	cv=none; b=BjS8fajGNADIY0rNzB5Q5PKWhkoaZbPmYqke2Yy9jGGbxr0n5Ru7hIbSnXXpf+NmYojfNODGDWn+l2nbLcM08kA7TxrHCC4m8m801tHpq1Q6Hw96ecBoaS13p2wsda1KdfJgRVY5YsMOx6i1Ugybxa5pGpKwaFDHjyUUUe57lmXWAdmsglq0FCS+99/D9nMfvl8e2QvP6l41OHOoxNLk8//Nj7lONK86LPFfitbg5WXlErdMXHqCgZv+GtwE4k516TsTqs4ZK3Kt66P4+PRBg5NtYd1UZj1hW6tp8g6ngiZU86WJyegYhnDjelfWtkDjrAKL4CfyM2csKqQU2P7szg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993502; c=relaxed/relaxed;
	bh=+PwZcettfGvI8Lm1XoNHMC02UlU18VC13AXj5oPS12E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXVMRT7PpePAvv/Hz1Z7YS7uTuuutZQdPBz72nJnPn6cISoZdjqvs8/sHd8W2wOZzLtOmZaPuCJoSiPJEhvXMtJrd0YzYrFW6RsV/+oj0TeW5b6q91nSBwGYCqpBWJ5Rb73jWUzhsFjDmYU8Tfmol1I2gFm2+XigjBO3WfX+sdv2t13Aw5Kkbk4UE6mKl2aIlt4F4oFsiFkHQttZvLTFSwHFp3HhVnBaCyPwyLfadk424RFJxU/AxHp1MPz/FQvLeSiS519XmGwceGDBy0pfVJD9Ll9412550ilppppEyEZPt58XjEozt2D3yNHn30E2KrK26f80Nfxd5o3JonduUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UTNrwKVR; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UTNrwKVR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvB2Y0Dz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+PwZcettfGvI8Lm1XoNHMC02UlU18VC13AXj5oPS12E=; b=UTNrwKVRFbWWxYCulCRzRwkfIw
	0peg4L4N1QTxWpk3AeIEnyBytYiYN88/soUvG/oLw1i1SXzB0LtFpjU+Akt0QXPly9ZX0mN976kpT
	vi+QQ9HgioKWOnOvoDgCEYJzZnqX8KFtCjo7cNDRGnIuPQ589DRe8JunhuXC1diOQt+s37I9DM9Ld
	Bat4Ygnhtj/Z+8ALUJxnP7DCvEvt8nebzzbmKvIjE2HPdWyHDx1Hhht/M7PdhhGhvA0Nh5JpHs5AJ
	B9vRf3TZtf/2NvEYa3Ujvbv5DRI3RjIarsabsk6sx/wKW7BPkTjM+QjXCgyeIYbpNFVRXsSx+gLPU
	u+Y10Xmg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCW-0000000AgsR-46ef;
	Tue, 14 Jul 2026 01:44:49 +0000
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
Subject: [PATCH 03/14] ASoC: fsl_asrc: avoid kernel-doc warnings
Date: Mon, 13 Jul 2026 18:44:34 -0700
Message-ID: <20260714014445.569992-4-rdunlap@infradead.org>
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

Use the struct keyword to describe structs in kernel-doc format. This
prevents kernel-doc warnings:

Warning: ../sound/soc/fsl/fsl_asrc.h:452 cannot understand function prototype: 'struct fsl_asrc_soc_data'
Warning: ../sound/soc/fsl/fsl_asrc.h:463 cannot understand function prototype: 'struct fsl_asrc_pair_priv'
Warning: ../sound/soc/fsl/fsl_asrc.h:475 cannot understand function prototype: 'struct fsl_asrc_priv'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
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

