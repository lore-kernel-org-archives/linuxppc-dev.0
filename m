Return-Path: <linuxppc-dev+bounces-24282-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2392C44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:06:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfL2jCxz3c2F;
	Wed, 15 Jul 2026 10:05:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073946;
	cv=none; b=Zl/GxXpbZ5j+0D0jKShCk7R/ok1AmW67Re9v8by5+pmMCMHanTiFYjEq+StUCTcISSjdButfQkFH53HZ4irdemq0oqwEO6quKdxefpVnK0Bu02lAnLM+mlCbOiO4cVMqgiN4nly8qtWlUZmVUpgcEshQgBW3sNYEOTO+7O7tFl5/0anmlb7MIHnC8qmFgZVnIImjb25XVeDRiDUG0KScmTk+xWMypTY/mWmcugVZs9wzxzg4EfazAlfR9gzroIjj2a863reoQyClAPmBxOmFBahtpz2ozpacgV1bBWwGfsV86KbdQh8fkMIZtLnjQOEBDhVAilK8o5v3CSHoLlTukg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073946; c=relaxed/relaxed;
	bh=Cja07B7b6DLmEF/XlIxcOw/U7wRYtezoqU3BZOcxKts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRiZu+cIsblBtW5gt4Px7xF+2o874J+x5xeBbmH6o0POxD5kfvn94l5dyMjU2QxNFZbHgaKV4Ch0lnoAm/iNX7QN48z7AIe4jyPz0cI3TEBU6ZJY/Cz13j6GL0xhb3mY/tPIWiEkW+KZejE2dcH0H4kDuTbfll26KuRSa3O5pcyu13tIRMs1Pnd3jIsF6wAx/hO5iL3BnB2MvSJDIjNvF2PnKaXrgDCaSf8FbJraHih7R7SPMe+S/jW1SfEV/FVRMSJqWFBt5yigPnEBNQuleZM0JwD0GiLW9VO2rMpdLp0Y35xK5ajD+pXsyq3R7K1rzNxvEJviCZV67nbKXt54/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LtPyVRC7; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LtPyVRC7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfF4wMbz30BJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Cja07B7b6DLmEF/XlIxcOw/U7wRYtezoqU3BZOcxKts=; b=LtPyVRC7z5Fv1G5lhVKLjqm4e8
	MVr4ZI54qkkNx5HdipAEdhwX2uZfcQXpkFyRNWDJRSM0e0hufIbxD+rLA3isL3EYb22rUxyWngj6v
	AlVc/vz1b4bKWmLJ3e+h6xOinoCFzIWW7tqzc+w2k3u4jeHRzuEdBTo4MtMN5UjVSktSOqTGw5uuD
	Fg27N7ZottEv3SS0cbb51/Q2VrrLeU71Z9cT4femzmZyM74o8QTxhkF08i0DcoMJuCaKqVhKaSJAA
	j8SfLBRG3HvscvqwHpH2oM16+Y/ZRjbZsyUhQ0qwvHpaq+z2qSCDyO693Ys2P18cX3DYz5IcLuPTA
	qE5TW4HA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn80-0000000DTcu-365Y;
	Wed, 15 Jul 2026 00:05:32 +0000
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
Subject: [PATCH 08/14 v2] ASoC: fsl: p1022_ds: repair kernel-doc short descriptions
Date: Tue, 14 Jul 2026 17:05:19 -0700
Message-ID: <20260715000525.739874-9-rdunlap@infradead.org>
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

The kernel-doc short description is assumed to be a function unless
indicated by a keyword. Add the missing keyword (struct, var) to avoid
kernel-doc warnings:

Warning: sound/soc/fsl/p1022_ds.c:62 cannot understand function prototype: 'struct machine_data'
Warning: sound/soc/fsl/p1022_ds.c:182 cannot understand function prototype: 'const struct snd_soc_ops p1022_ds_ops ='

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

 sound/soc/fsl/p1022_ds.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linext-2026-0710.orig/sound/soc/fsl/p1022_ds.c
+++ linext-2026-0710/sound/soc/fsl/p1022_ds.c
@@ -55,7 +55,7 @@ static inline void guts_set_dmuxcr(struc
 static phys_addr_t guts_phys;
 
 /**
- * machine_data: machine-specific ASoC device data
+ * struct machine_data - machine-specific ASoC device data
  *
  * This structure contains data for a single sound platform device on an
  * P1022 DS.  Some of the data is taken from the device tree.
@@ -178,7 +178,7 @@ static int p1022_ds_machine_remove(struc
 }
 
 /**
- * p1022_ds_ops: ASoC machine driver operations
+ * var p1022_ds_ops - ASoC machine driver operations
  */
 static const struct snd_soc_ops p1022_ds_ops = {
 	.startup = p1022_ds_startup,

