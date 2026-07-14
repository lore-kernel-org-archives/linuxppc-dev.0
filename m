Return-Path: <linuxppc-dev+bounces-24173-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0429C44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:45:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvR6Sl4z3c1g;
	Tue, 14 Jul 2026 11:45:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993507;
	cv=none; b=eh6RsBj6DAvleC+wmoXCbC18PFSJt1UBTR3VxHhpKginPrB2j80AdR9ndHzrlu62aXDJxN7D8lEMf22j0oKrA2bOOXEe0SYRe5w00jYzZ6Z+ABCICnz8FtZyX1Y9ASHMGBx3rFib0TwPDThkgXc42u1ulpT2W/5xq5vNs7P7IpwG+tYGcKABOh8Ezce5cB+2WmeHpsMxuH0n0rwEvaCGtWLQ2dPI/VfIFZFQlEET1Er20hefjZZwrASobGX9M1vcMqAvo0+6CIiXF82tH3MCKyfZpp/lWRKR7MI4BChkdx2U7Q7EmHOFnMitYEffFSPk8KiB7Pa4ArSN8n0NiokndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993507; c=relaxed/relaxed;
	bh=4u3ACvzL8pxpd9iG+vgo00VNHiGf5hs+Js+oX4NbtWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lrl21tmGyuab16wURFz4inKunKh5l/nL/yvD6dCUVw2KpWzE3NCrtsSMGxxTrbnU+SWblMeeH/rbXWGBhUS6XF8f335wUUBXGeNdvXZo9Ezlx4ZKP81j6yw3Ayqc1fSv44AQL/tURiTi7VAoB/lTCa/jLltuo9t2YsK752Z8d871kS0IXcozvIIGONUx5f4SXJ7W08Bu2IfuTNkag8QzZVkUbFOcvt9qObChCk7rOdiChyXa3I16JcL9RNFVknkKDh6Mna6pWxVjYF0hyZk0ePRkds3v2EdXiLCMo++Ok6dY4Yx/JzIm/7WDvmnwU77+7lkiO6sJl1n/fR2mH+9CwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PgWO2t0h; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PgWO2t0h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvB3CfZz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4u3ACvzL8pxpd9iG+vgo00VNHiGf5hs+Js+oX4NbtWM=; b=PgWO2t0hR2dql3T2xki7G4X/Lt
	C4dyyJMqBu+oXIDsb2o0qxNCO++iNfS3lNcCh3fA2qGLuuSnSU5svpchYzAmRu3DzivDFOtIxO0jK
	LjlPX8MIsmwKS/Vc+ciRKKHizCMAV1Fadl5I1LHEdQ8912kms1kfx+8iUBic5V6OgyUo0aYG/sJ1D
	3e100Iy4FAUk7TAV7CnmCX0qqfZfkBRlgnBreoAfxFRask4LlwQqpom730NagwTDQubRLn+gfBVGG
	Oaf/jPs7hXAFwWr4O8S2NX+4eduCQ4YRuNjW9cnW4nkCud8wvJc36t3ZaSrrXEpg5oGW/4TiypjcT
	Opu0tKdg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCU-0000000AgsR-1i5n;
	Tue, 14 Jul 2026 01:44:47 +0000
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
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 00/14] ASoC: clean up kernel-doc warnings
Date: Mon, 13 Jul 2026 18:44:31 -0700
Message-ID: <20260714014445.569992-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
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

Clean up a bunch of kernel-doc warnings in the ASoC code.

[PATCH 01/14] ASoC: codecs: NeoFidelity: repair the kernel-doc format
[PATCH 02/14] ASoC: fsl_asrc_common: fix all kernel-doc warnings
[PATCH 03/14] ASoC: fsl_asrc: avoid kernel-doc warnings
[PATCH 04/14] ASoC: fsl-dma: fix all kernel-doc warnings
[PATCH 05/14] ASoC: fsl_easrc: use struct keyword on structs
[PATCH 06/14] ASoC: fsl: mpc5200_dma: use the struct keyword for kernel-doc comments
[PATCH 07/14] ASoC: fsl: mpc5200_psc_i2s: avoid kernel-doc warnings
[PATCH 08/14] ASoC: fsl: p1022_ds: repair kernel-doc short descriptions
[PATCH 09/14] ASoC: uniphier: don't use "/**" for non-kernel-doc comment
[PATCH 10/14] ASoC: SDCA: correct enum names and add a missing struct field
[PATCH 11/14] ASoC: soc-acpi: fix all kernel-doc warnings
[PATCH 12/14] ASoC: Intel: Skylake: convert SKL_TKNS to kernel-doc format
[PATCH 13/14] ASoC: qcom: audioreach: use C-style "/*" comment
[PATCH 14/14] ASoC: wm8904: don't use "/**" for non-kernel-doc comments

 include/sound/sdca_function.h       |    6 
 include/sound/soc-acpi.h            |   23 +--
 include/sound/wm8904.h              |    4 
 include/uapi/sound/snd_ar_tokens.h  |    2 
 include/uapi/sound/snd_sst_tokens.h |  165 +++++++++++++-------------
 sound/soc/codecs/ntpfw.h            |   11 -
 sound/soc/fsl/fsl_asrc.h            |    6 
 sound/soc/fsl/fsl_asrc_common.h     |    8 -
 sound/soc/fsl/fsl_dma.h             |    4 
 sound/soc/fsl/fsl_easrc.h           |    4 
 sound/soc/fsl/mpc5200_dma.h         |    4 
 sound/soc/fsl/mpc5200_psc_i2s.c     |    8 +
 sound/soc/fsl/p1022_ds.c            |    4 
 sound/soc/uniphier/aio.h            |    2 
 14 files changed, 136 insertions(+), 115 deletions(-)

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: patches@opensource.cirrus.com
Cc: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org

