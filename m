Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549B606A31F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+3KRIK8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFmW01N2z30WT;
	Fri, 30 Oct 2026 20:14:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793351690;
	cv=none; b=cs0AT1dkbHU1XpB6cjjK1yNM+zhWcuvVB9NQnhGhqa+IO0fWtvu6mfpdnT83EvOCxyQCROcVc5xARAm5lSSA1fYO4rOROmxwfV2nuzRh2WdhHMMtZirkP5o3mmSIAB0Ts1ddhPGsBlQUjSC5mpwDYDrvhSgA9OBfyhJ3NB3qmUjc2NCm3e0P/1oZVkRn+TBb3E3jQUrtlms6qAoZF/6dquSl0J28AVILEP3T1NWSBV25tPMojYpnhDBMpjt1IZ8lTGPmLk4W2fDERH330uSXaOrLvf7jl85EIq3SfYNrQjwXXgRw2p+3QswP6MPP6aOB+g6DJdex01tz/83J4fMawg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793351690; c=relaxed/relaxed;
	bh=wf7nEs/6d3ZIbLvKZhlKXZqIu3RM64be+7ASwgNMPP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/H2/JWpjTFyw+w3ikQRGDHPCu1+3yT7aplFJbWYVCvl61x1rWzghLE5SulSQRQdX1E9za+UqhzSKpTsc4ELT/FtLvyw55bqr9iRjlMKbGmLZ1wyoVQI+4SZI8sVYv78TAZRUXZwdl92ISNveZanG0sHJzydZdyPs6LvOGElEm/FD7SiJ0hO0ejD/D/1F4Cgdy1wJbrSIzoy3QEMId0W38IDmQT8aV4vF3/8wlPZNUDNfY0Zl5Udcd8xE/bu8eh3O80Y9iQPjYEfAas9SvkfymR/GzNgQtVF4UXzZtzjyfMjm/1mTYQ70nxzydEAHevd6EAaSOO7upQfwPH9OYYfEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+3KRIK8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+3KRIK8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGFmV1Tmwz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:14:50 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2e98798cbddso2195675ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793351688; x=1793956488; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wf7nEs/6d3ZIbLvKZhlKXZqIu3RM64be+7ASwgNMPP8=;
        b=u+3KRIK8QVExN6EZvGl1J6a7lvQcUiU43OFPvboVbOFGXQvJVm8qbptvpMdKj7D0dP
         oHatMKjkfEvZU7Qr5tJUV0EsxdrEuxizDMSTs6R+W5krZycLUKqbGFGLMVs4m/SexVzO
         ET+RVP3Yl2YvzpxJOsEC1eyCP0YwSCupff4F7GX4o8Qgzm9CzOCg1LmePlJkKu3Zxbhx
         tuU/WXSdWgrRNJok2D2iXAYs0gEQSd6i+TH1MKfoyT3SJzB9SFzvYog49mjAtpQJT/F0
         nZyugp+GlTV2OyzRsH1WRqVnTvD05hs88qrRqWuZYw8aQ2LTPBDMtGBxdpX5rjIpSTl0
         0tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351688; x=1793956488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wf7nEs/6d3ZIbLvKZhlKXZqIu3RM64be+7ASwgNMPP8=;
        b=zHnsfZfSb+ImAecgt/bTkAbn3OFV4h+iWmIyhOz73ivOoFfz4ZMiuNGn7/zCKsD+8I
         SCk1dlab8I2CX7R73IaGyPde3eU6Ibqlg0vlIvN6hdK+FiBY2Zow2UPyUvoKqtLbk6xi
         AoShAYOs2laoenMRDC+gxoOtlRGPREyMwqTIonXJY1cXh8hoKWvKVIWi7K/HiSO9q3tV
         1y6DB+uMtfWJCI2viuJt/+tDlDRBPe4aJ5dfceiZB+nj10ctWH2sMVsHLF31D8eZfSbw
         XP/4MKJWF7QZ6t9frdqtSer93hfyBppxbV7Gz36lT+SAUAPRGyhPhDzh+y1qTGNaaiX7
         osng==
X-Forwarded-Encrypted: i=1; AKwUvBxNTO8XKZy5GE4omLiBC0tESjQ8G3wTN6tfLBgvXsWDLQ/fZgb7T8ziBcjuHlDGc/l40vbF9MNIeT9ENls=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKsNK/t2qI5Q+XtacBJB0tdkCh78QDatpsP8ZPyZLf6U25jYFGn
	Z1ggVmhBBp056meq7rIyp7U3AGGZqI6eaLKuqU7+u0OpRoQKdsBRu0p2
X-Gm-Gg: AYBFou2fSpiwmw65iKwT028e6TAd6ja0MS/Ph8PB1xEQPIQ19F3dx//GjFFxknjeE5k
	PSsOr7CeoEFKoQ+eUP0FmTGVEzyABZZQxRMMhueYpJEQCnnsdMfkqrgWjxhQtrF/Xv6+rBvfdbE
	VUjkto0O1y6b2RfsVMTDEhF3q3oBvYNTrTL3/yTff1oAsjHZYdK3s4wBHWgUYMyIH/X6dqx15ap
	R2AgHKVjzqJTtl9mjNRLbkJgTOm+TvXuCgE9hsgkcdqwVgKK8TZUyxspjxKqqd1vYER+e28cy2K
	2padq3sWPzjb7fuIpls/HtsSEtsGCiXs45T9nVyrylHkQwkYfLaqadOhviYnfkkq57VUFpBEIjB
	h4fqG/JI7N4Xxtp0jehNuu0b/HGOxabECdoC+/ZBfKEDDihjSMp2+jx6GOzT5AtWobpLNY6vg2a
	fk8Yrnopd17yL4EyXdp0+TZMir1Mw6dmqsI9SymLfhpZBzhAXZp0hGVRGcK00scetTYyxlvKv0i
	RGbtdHyJMp00IQ61JqmraNhqLgfA3RdjhkzjR4+nrRVfbUa8TzztmfkdqtDJts/f4HBq8e/boaO
	j7Vj/xZ3GXjioWEtzv2APmdLvSiC5feN5C35kdFeRP9KkN9dAIoL5OeSrODcsrT+pqIy9A82gDd
	OrPB1GKJDI8YGhUldeC3MzWPlTsoTQSsL46s4QdrYoO5s
X-Received: by 2002:a17:903:32d0:b0:2ea:778e:8647 with SMTP id d9443c01a7336-2eb364f8e54mr17088025ad.59.1793351688153;
        Fri, 30 Oct 2026 02:14:48 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ec9sm4734685ad.6.2026.10.30.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:14:47 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/5] ASoC: fsl_sai: Fix PM QoS cleanup on resume failure
Date: Fri, 30 Oct 2026 16:14:00 +0700
Message-ID: <20261030091404.18757-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030091404.18757-1-phucduc.bui@gmail.com>
References: <20261030091404.18757-1-phucduc.bui@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

If regcache_sync() fails during runtime resume, the CPU latency
QoS request remains active even though the resume operation
failed.

Switch the regmap back to cache-only mode and remove the PM QoS
request before disabling the clocks, ensuring that the resources
enabled earlier in the resume path are properly cleaned up.

Fixes: 907e0cdebc1f ("ASoC: fsl_sai: Add pm qos cpu latency support")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d232c8f53061..042885ba415e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1981,7 +1981,7 @@ static int fsl_sai_runtime_resume(struct device *dev)
 
 	ret = regcache_sync(sai->regmap);
 	if (ret)
-		goto disable_rx_clk;
+		goto remove_qos;
 
 	if (sai->soc_data->mclk_with_tere && sai->mclk_direction_output)
 		regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs),
@@ -1989,7 +1989,12 @@ static int fsl_sai_runtime_resume(struct device *dev)
 
 	return 0;
 
-disable_rx_clk:
+remove_qos:
+	regcache_cache_only(sai->regmap, true);
+
+	if (sai->soc_data->flags & PMQOS_CPU_LATENCY)
+		cpu_latency_qos_remove_request(&sai->pm_qos_req);
+
 	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE))
 		clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[0]]);
 disable_tx_clk:
-- 
2.43.0


