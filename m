Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202A6082BEF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqNKRkyJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzSf0f88z2yQl;
	Thu, 05 Nov 2026 21:44:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875442;
	cv=none; b=YLn2J+ZE61b2CeGLwWb7H3PquFjYkqt+EgIa46WLctJWwPjfHjsssmj8kVmovwAbr34h2K3PEZ4ySiCkN1+N2zWT/cidh+RDi9/2F1LmfxbdXXKnH7XBSJYz7bTgKMtdEoHRLG6Q/x9GoNOhodwaqForgAzHfThXh7ICs6KxeKXUPrBNJFTWy0SP9j8tp/gbTX8l6lteJvJ5Bb0QiqsPFOQPECIaT2jO1jm5VjSODOGJjP9fh4Ppe7xtL/HsE7lrN/aE15ivDPXWFIaTPa4t1SMfp2pDw7ZcwsFwnV4tFKHWfTmMU2LJAHDms9lA+Sufz14R5sl8wJVC7vWcTOLc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875442; c=relaxed/relaxed;
	bh=7a61XdNC711TnCfpf1e3aFAgR5XmE4l8ifMaRZC1SQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmpsdcGXNSWovRTgnKq2ltfvMqPTVluQ56gt1jEWmxYYG5SrTiex1qzsNwz587aY2wmW88qUaax8qgHGQ8Xf5xjWBm8waSG5KevyvBBYb0wc+jeopsJwYBwbSsdfrSdM2Bsco3YSr2l4yIN72RbQX9N3YY6BLpuw+wqd06Wje0vlVVEVljZ3j1fjusWkn8+7z8sBeGRdXzZ2yRrdFgFqrG7Sd7tN6pbTB+Nv/vYrxH2xbUzY7g8dEU8Vko61vO+BvySjOjL9dI7GRdj/YDcDGSoZkVy+/RFnZC37eAFu62Hn/dx5XQpUzs5uJAzM14eqAfrTpa12opeY22P2dO6imQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqNKRkyJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqNKRkyJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com [IPv6:2607:f8b0:4864:20::122e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzSd3hPLz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:44:01 +1100 (AEDT)
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-18818daa3e7so78192c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875439; x=1794480239; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7a61XdNC711TnCfpf1e3aFAgR5XmE4l8ifMaRZC1SQM=;
        b=eqNKRkyJ4jKsztFxzVK8HvR7vQYPjSGZRL7kN3qLtSdIpsI6HH3j+xx0UgfOnnW9Fl
         i20A796gzwvfl+hXp5sqcHh+ghPs2T/2+6WJOx9DWDmiQ+Csw19NK/mM9Iq3lxX31Sxv
         Epxh5ou7H7Od1V/aOswk2Cym7ZmqK2b/VGyr7+V9Saemy02Vo0iEa20wL3xvStMObyb2
         5anHh6GeIo9o1sLpO+kkF4hsP+5TiLlcIym6WIy2Wew0Z5ZUDA1HER0swhNTOocs9iR0
         JXLREaz1Gi7geEAUq+92DGqeFRsjXpchd30v9iNT/zCR+mcLPNiH/w5mAgQdMj5KChKe
         r5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875439; x=1794480239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7a61XdNC711TnCfpf1e3aFAgR5XmE4l8ifMaRZC1SQM=;
        b=xf3SA1TLBoHntzH+QLG/UOACzwYGCg1Z4JYYe0rLNZVj53Wf3wmtZBJOpABUxA5d8T
         9JU+Yc8cdUE0KoXe3SgdlK/hesCTMdEN+ZyuyaEOwgQygj+e8xLS9l5+tVqdfF16D3Ev
         suC2/KFD1+3JovzG0jdYafM0XQbstSIsHsyV45Fk3gzDWL9VQti0jKz8cZErILs/d1Lv
         HURLVR+l76JcITZyf5T/08uNPcB0soIy7ChFMtsbpSC7h/wOosnsbAGcz81IV0jVOhpg
         vM1ioB5rC/Q+ZkEicS+vMUruE30p9orpdCvfL91wVkvESG0Vd73bKQp4hUQSfhuW4hSu
         Z0QQ==
X-Forwarded-Encrypted: i=1; AKwUvBzg2K5VkesWL96lM9yLr1b6Tltz8IUP6yhCL7hOt1DD1QQpZcdo9EEwnAiQY+aJDCwoXqIep3/OfTDQPX0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8DtMF7bGqhrWwqfQlfozpQYJkio5m2VV28vNshNiT5AMXFcXnu
	FBcw3ibWUS/RqjflvDAeSdH/fK16UFdukON2jI2GT4I86R7qBjizUgLZ
X-Gm-Gg: AYBFou1+X0/86T8VxvIqPENGIHbRzrDF+SQDAcHjYgmzi5XX5/pyBiInvj97a9ZyPBV
	1eUVsJfs5G0y13gGvzJ+qFZZfrSBkTTTUqzKalVycEta7P9RLiVzKarC78nTo8J6DysOGuIGY0G
	k3HRK8HaySnUYbpQcK+EKt9+mVCDWNNAs0H4Rd+ZMvHjimhQZZweVi5MhDMs4AhtOtP7XrK42ga
	bv5qxY34FeQxB+QAmFQrOorUkCxhcQZCAK+cAg6C9z27U3BpjHOIXfNwKx6cwcLtpfIMNrZKEas
	/9ktmmCocdCi3W8BXUbiEyfSv5GljFL72d3cOGwC1DZqOpb1O+AB+xFttZH1koXVSuTR2bI/LLb
	eoqlww/VcABidn9j8icvsD7xSN0d7sKLmUrG1SBIUwTAOAc3uHWsz4qGaSt6kmqIfaF7VVvkqNS
	il9/ipBinuvNkwXws9hkjJCnPQP1x/+2OsZbnOdOVsBQ5ktyHr5+7O5gjgFJMyHHSkx5Uvdh8ce
	OYlUpGPzs0K+SdWUoQYS455wbDzmdszf2f2Oqm2ZnzfKtZF/cZhGW66AyCaqXvMPkOHbs6Mmsgz
	g42VeiluCPr8Ey/Jyfb3Ukgd5NpjuHjNjfd1LZfCMGx7poPuJ8iaJ1zlud/YODT1HNErPSZsdVr
	vTrt+VHi1cIVporjc+nRaQ02TZV2lUFa2uqocp81DkvnEQM71m0Ykq3bQeTZFeKOHUg==
X-Received: by 2002:a05:701b:4591:20b0:1a7:77ae:11f6 with SMTP id a92af1059eb24-1b24f45f23dmr2950238c88.17.1793875438944;
        Thu, 05 Nov 2026 02:43:58 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:43:58 -0800 (PST)
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
Subject: [PATCH v2 09/10] ASoC: fsl_sai: Reject bclk ratio smaller than slot width
Date: Thu,  5 Nov 2026 17:42:36 +0700
Message-ID: <20261105104237.38542-10-phucduc.bui@gmail.com>
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

In hw_params(), when a bclk ratio is set, the number of slots is
computed as bclk_ratio / slot_width. If the ratio is smaller than
the slot width, slots becomes zero and the following
DIV_ROUND_UP(channels, slots) divides by zero.

Return -EINVAL in this case.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5c50ed7c2258..c61703ddb6f8 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -632,8 +632,14 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	if (sai->slots[tx])
 		slots = sai->slots[tx];
-	else if (sai->bclk_ratio)
+	else if (sai->bclk_ratio) {
+		if (sai->bclk_ratio < slot_width) {
+			dev_err(cpu_dai->dev, "bclk ratio %u < slot width %u\n",
+				sai->bclk_ratio, slot_width);
+			return -EINVAL;
+		}
 		slots = sai->bclk_ratio / slot_width;
+	}
 
 	pins = DIV_ROUND_UP(channels, slots);
 
-- 
2.43.0


