Return-Path: <linuxppc-dev+bounces-24285-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0685CC44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:06:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfM2K1Nz3c3l;
	Wed, 15 Jul 2026 10:05:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073947;
	cv=none; b=N7pdiAd3v7x+AlYtR/H6J9UBxLXlzTJPO7C6BWf41Xny4vghhl4O5LTiH8OELMbiZFEYEwmQlHGnQ0ouL3HJn+Nytb4jBjyRZkCW2ZTjc05UGZB2GqzFYa/J/U6iecKDNKrcPdZAwCRqZ4GNT1Z14f2y1nsaHphwIMdIIaEq88pljTJ3+BWgrikk792gFN4VKUVNSeCx7rl7QffJKcgDMEE2g/Swo6BWj5qdnG3Zi+msP7XiAyeTiAjbaIdgTPsc2qCiN75rDDqHo+KKBLYy2B/fjHtFp7v/rUTQQF6xYkIvY5RoFwh4ETdW88oGnfEFq7TkwvSSu7n+BYf8vYOeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073947; c=relaxed/relaxed;
	bh=KehD+od9M3/491YsSC+zOVYJlf8gVJUUtBT8uZjzCCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QS0EmNR/6Pkm4gyzZGkq4z7XlfC+Cn2kCHbtgg1+Si2keKIdM07EhN/0KLtVhGcoaQa/1xwgU0RHsmMYcIMVll4Dz3OuOjoREaRXf8SWepYmNE/WY63bgxv2TAyQus4LX4GtHyc9eVaD0rX8GlSIDKrNqHfCupTqjdVepscRIbasAJMekpZRptff1nHh6Mxg/MMS+T1GFyUxgHeVC0o3tej0i+rxu1swmupZGmEIH2aPpE6NPPCXefOsCSf+h3W4sY/gh2YrQfRGxKMnUa8EyeopWjh5pSf2y0W04i1kuMDqglmln8UJRAHr/CewFKpkaed/PRwlE3u1W3QBt2DfTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bYNBBQs5; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bYNBBQs5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfG0mstz30DY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KehD+od9M3/491YsSC+zOVYJlf8gVJUUtBT8uZjzCCM=; b=bYNBBQs5+Yha0dEBm+IY8p4fRq
	E8cdh9931nDjqCxW1b8rOR6M9x++iayLmRvwIYm2LhSk4gQmbvUZjn/lTo4g7NfW6Hn2xJ6cEKtPs
	jsZUxhxDetbW7Qz0AqoKMiG8auE5kzOCbbt5c4MYCKH3uwc2CzGB+K/LRSCBCBKMxnL6cF0wbLYcx
	yI+WHfT2t9Jf/yZCZr5CZSs9bUR/2XZGRctX+TIsEoE0XqEBAZHTGsmrcz3OcM+cLnNj5bo1EMV1C
	vAWcyOfzB1B4kLZ4yQy8lbwcvWPkeKZO0pf+VAxW7NVXBYtn4+ph9Sv64cfYv9NeEy2TATK52MmdT
	4Ups8mEg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn83-0000000DTcu-2vNk;
	Wed, 15 Jul 2026 00:05:35 +0000
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
	linux-arm-msm@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 13/14 v2] ASoC: qcom: audioreach: use C-style "/*" comment
Date: Tue, 14 Jul 2026 17:05:24 -0700
Message-ID: <20260715000525.739874-14-rdunlap@infradead.org>
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

Modify the "/**" to use "/*" instead since this is not a kernel-doc
comment. This avoids all kernel-doc warnings in this header file:

Warning: include/uapi/sound/snd_ar_tokens.h:61 Cannot find identifier on line:
 * %AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:           Sub Graph Instance Id
Warning: ../include/uapi/sound/snd_ar_tokens.h:62 Cannot find identifier on line: *
Warning: ../include/uapi/sound/snd_ar_tokens.h:63 Cannot find identifier on line:
 * %AR_TKN_U32_SUB_GRAPH_PERF_MODE:             Performance mode of subgraph
Warning: include/uapi/sound/snd_ar_tokens.h:64 This comment starts with '/**', but isn't a kernel-doc comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
v2: add Rev-by: Srinivas

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org

 include/uapi/sound/snd_ar_tokens.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linext-2026-0710.orig/include/uapi/sound/snd_ar_tokens.h
+++ linext-2026-0710/include/uapi/sound/snd_ar_tokens.h
@@ -58,7 +58,7 @@ enum ar_event_types {
 #define SND_SOC_AR_TPLG_FE_BE_GRAPH_CTL_MIX	256
 #define SND_SOC_AR_TPLG_VOL_CTL			257
 
-/**
+/*
  * %AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:		Sub Graph Instance Id
  *
  * %AR_TKN_U32_SUB_GRAPH_PERF_MODE:		Performance mode of subgraph

