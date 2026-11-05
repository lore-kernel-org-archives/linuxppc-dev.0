Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F9606D81D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+2GyKhE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzRn6yvfz2xSV;
	Thu, 05 Nov 2026 21:43:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1231"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875397;
	cv=none; b=jxr3O+hFJ5h8EeXcmOHvv1XgJztrqvuxrCjGmiUNifydYkFLKZjL6V2Io0Xn3sKuecW9QQF8lAp1pEGjLZ8KiUufHxTo1r4EWUQm9F5E/60zYr9boZW98znNPvuliqzwcXmyAfRnVyiMVABon1JYuSeifvEHuMiUVt2fHfTscPgVH+XHoIM/SHBLmuiLdb1+3xRHbdgZ7UVMrBCLjzgAB6Ytfi4Ufpt3aaojogLC1j3BJIBnVYVp0PX7ifqgvRVxNXDURh+AHqOiAm9BkXjrWG+qn+KQdsAXlB/97TOZwKhUP7Ct6DgkkovW/9XUudwO/i0Nq4rnmPIKignmU8NrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875397; c=relaxed/relaxed;
	bh=wf7nEs/6d3ZIbLvKZhlKXZqIu3RM64be+7ASwgNMPP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ga4HaJu8b5D4scLqfccpZUuxiifGWZIOQgyR5DuMnvOG+DQprs+OrXxo1k8TjGh4Z9sNoo9XnaLuHzcesjo5wxYnO+yK5gqHF0Bfx3ETtbBis/D30/vYRL3J4OfcDqkZaXmgfTs3m3TGF40UuXD0NhByiZnjh0kmuLAtTkvnZNKH+8UfDT6qv44gyTeVgeFwfhh1HXtKEgw3LR4y4GbWljOjBZZc0fz2s5zXmsCV+MlLHGSm27MhImMZZvZkC7TrWjkpMU52AslTWncQ9Bt2p+N8g1/FdTMw5TrQQuBN97nsus3TOO+WBrsAfZI/JdRKpNBTK/nzTjXa5fE0GmFirw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+2GyKhE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+2GyKhE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com [IPv6:2607:f8b0:4864:20::1231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzRn2hTTz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:43:17 +1100 (AEDT)
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1ae18eb9b69so1740323c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875395; x=1794480195; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wf7nEs/6d3ZIbLvKZhlKXZqIu3RM64be+7ASwgNMPP8=;
        b=T+2GyKhE1SeajERieEmm3VoFTcIPMtzj7ZfyHdHYAEIEKhaDhpoTkejDFKa0ENpwOn
         MLOpvy65SDFQLuW3Ba58YwKczUh2VHPha/V0D5vpW70513NGybKkBZOQZsV2UXu8bD4v
         Dp6Lw3JCkUB74BALyGAya2QUcKZPQdNcE+P/yUMjFday5fMo8OFFIiWdFWO5n9z+WS75
         nKfMnLvzdPdxJaMZksvtLWk8+A2KYvn+hoT4Xa1y3x1xbXdwUx9Pr0+QkcXRtUVYply2
         F2cR1CI2/gN+yxW4nPg1T5c8U5smM3c+2NSe/qCgBg3vov0Bm2qAA5wDyzTsveRInvQL
         5Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875395; x=1794480195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wf7nEs/6d3ZIbLvKZhlKXZqIu3RM64be+7ASwgNMPP8=;
        b=PVXtOj9EOBmkRW1NXKecidZ1usc+YdPPC3vFAbbjK88tBTgYwNB66hE/cDgU/gTCxH
         UhY7De6LXkVYVccAI1nqfUaeClhu4h+fOTkGFt9ksP17JalWlVep6+Kgca2OVxtiXKVT
         XazvLx0ul+qltR0p78AA+P0Ng0ZfoMuWLLkioraebIaIG9N11TAWNKtsdhy1r15R2r/R
         O1Kuw5NjlIpZRksYueW+vUaW5uORL4PJe0jExGzQLoQefUdSOnlqX+x3U2vtXwu8e4Ua
         1zkvqqKbwDpn82g3eZN8Le+NmawysqcHzSeJLsoIdoTeq8gP2dHayvRFe3k2pQg1fTsR
         fnTw==
X-Forwarded-Encrypted: i=1; AKwUvBxFSEi+/BtEoMhVdt3Nac5SUot8mzwQY7+n7UN7kRQOonCFlY5OezdgPF4bTEBW9gUvz1u6Y5x6EhtFpjk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9xcZYL092WOyTK/VlgRiOnHOb2D2xtM4Ioq7EpEZAKLMcDwc4b
	nFOR4Z4K8i9azMlS3fYb6LyzbKCvHX7calkuU5clpHIeBn1GDvi8TSr8
X-Gm-Gg: AYBFou0uSFnSYryzp6Hs3a2e/pMwKEIY1hmYeVApoecN49vxm9j+ZHXMHXV3ekNHgUi
	Xk1Mb72qfAToXQBg9EOYn2N81XdG29a4Ig/fAm47wPMGHOmXMuUymZn85sHs6Zg4wDMT+TSi+WQ
	/M6DQS3Dj3six1nX2d1BsPlPpj7WP2UiW3KkBrfeHN6ZbwB4xJGZ/7Hy+MFI4uM9DF36CKzxhVY
	DSflDLKE7G84xSj8eaAUDs3NGJ3xjwljMz9i9IgIihUyba/LtIIu9LzeN5n/daguqfEcprvDMqj
	mzaOP6K2rMH/ywOnJlIGPZTTYCjuPbL9iAGLqbxFLmZHVUTCHdziM8CvAE+E8x4wBreG5iZsqnd
	vlAqgWf78DsuMo0ijcVsjdzTrwgTGR50iGV2F90eBZTuiWqZ81nouDrpyIIvPGU6xE8hF0OHLW+
	Rv/Au5/w+1pdNzC7jWDFns1egiV5y2FNhruWcKtuOlltmtEZEBkgKHbuJH8So3ivDso4fZvKO1d
	1DG+elXuVmDATQVjmPvzf9+qWEmmWcX+j4oDjzA9yJcqE1z6TmkbjPDwkXqM6xDvi3Q5yt5HGen
	mcuGwDQ3trxg51FC1g06Od8wpvJEwc3K8NDgbt6dLbNb0ZG200Q79Kcrc/HtcFWJbtCl4xD3xaR
	pIK4qFtQOHWfVuvIatblXtiCTryZOuZmJAaDu+mPV+GKuw1ZI1wjbMWnMneM5mC5WNA==
X-Received: by 2002:a05:701b:2806:b0:19a:ace1:793b with SMTP id a92af1059eb24-1ac5d888f2cmr30014440c88.18.1793875395166;
        Thu, 05 Nov 2026 02:43:15 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:43:14 -0800 (PST)
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
Subject: [PATCH v2 01/10] ASoC: fsl_sai: Fix PM QoS cleanup on resume failure
Date: Thu,  5 Nov 2026 17:42:28 +0700
Message-ID: <20261105104237.38542-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105104237.38542-1-phucduc.bui@gmail.com>
References: <20261105104237.38542-1-phucduc.bui@gmail.com>
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


