Return-Path: <linuxppc-dev+bounces-22627-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A9FCD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:40:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4qV4rp0z3bsd;
	Mon, 15 Jun 2026 19:40:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516438;
	cv=none; b=kyR6rYyDzSd88SfoQkZ+1bAl9C3YLJPx82wL5w/iQ0BXI8FuHUpy3IMfgnLaT+0M1Znqnpyrhg3E2O7bw2yzq6m5L7yfYHJOJac8j0pupYB8xLn4Xc/NjMvoB3IWxSe7CG/cNNzBbs6Us3Avl6XsTGjmAGAM/oSd/EtglwtmYKijmlgyxt+MRdw0JREoqQlG0gpiqPU4cXNea0ypgCBk/Ztv7pQ30DWItKBFha7FBjBe/+/TOuf8OMZtgeMLx9fQf4L/wsjNw0DPvi3UDJEtYk/v+BzqoSSpaNZRWH6lO6wT8ouKxY/zQOpiq0hS2t+gptgd3Xt2YbxFeZg/EPU2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516438; c=relaxed/relaxed;
	bh=wpnchv9pa/fMvI5rIt88B4RF1cetJyaCH3vcYXn44rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcNVmTBL1MhT+i0CRt5u58RtR8blwel7rD84q8NxI9FdTbZneIsnNEjfUZmnM6LenUC2XeurKp2VGBdhPFqzJGDeiXNF4gmE/noYOWp/JhivLJ8yJlun+2jEIBdtO2+k2V7wFz4Xs1jXldjMYUiavKfNwBghPyGrmZp4BZrAgwkVPRUPBlo+6jmC5Uiu682HGNwHpR237YFrh0j2/jd4yHudwDb9sE9UX6b36/mvV49i/2uVaYXJFG+2Wblw1X1zF72dGxXq4SGPnznv2f+7l22vuzcGbdwtbQ/phP/ikqqxOzgR7hwbJVAEPIlln29yB6D44/4wtDwuDnMbNLJKTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TPTt1XV8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TPTt1XV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4qT4qclz3c2K
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:40:37 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-372b4330deeso1960196a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516436; x=1782121236; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpnchv9pa/fMvI5rIt88B4RF1cetJyaCH3vcYXn44rs=;
        b=TPTt1XV8YHS1qsu7yYnoHoeZdwgizQkSK1RWbp+gx+2Aex2gdWjM0zKzqDeQFTcjii
         Al/SP1vJnVD/Tg/9dduURK+LmngzWmCYG2/KgBm+joja9FdiC39Q8VB6iNqKzfMQjzZs
         kVyJhd/91BdOnfPWImWSbu0wdLcASoT7P9/oMngseUvocyvebnC5GZqEbSq+bEeOp97K
         svpM4EQZE/7MZYFzlwSy1x8Rxag1Zi6fRUFuGJMcfjEbxvzH6xKIbI76qxJIY/hc16Vo
         8uL3YbFVm7AV8eDzA6XO6d2WzW3z/S1PDrV+zfEcPKIlO/OsjqEVCD8NPdtcUzIN8z+K
         VMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516436; x=1782121236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpnchv9pa/fMvI5rIt88B4RF1cetJyaCH3vcYXn44rs=;
        b=T5Vj4VpP+fEnUPwgWOVNjw4oHuP5P5fQS+IUe3hKsKXy2o9VTorkVTDRN7X+wFj7aS
         G2cv4QVh2rNzV1rECicU9gp0FfwLGguD5LOrhJ34zDkv0/j5qNJWoz0ugPZX0OZtwSrl
         oT6XG6dvKBMLMvsVwYA6VDHAHLdDG26jdmE8pba/RVu06RHeAsQgHYHswCo5fcZEeyit
         diN/q88/vZ2ofA1jW7guJfnHbWqHFHC4ZHBL628NvVby+JDeG+3qh5KEwSBPtl7I2kQL
         tw0sA9vQyC5ullo9Bf05jagywuVLNjCYnJqZQcavsrFC/UPOp2G9WEOvjJFgqHuHNfBo
         +XKg==
X-Forwarded-Encrypted: i=1; AFNElJ+9VsVNZjSmBzcFg81ax8SojvmHAtQW59qooVo5wdFhf9MjBfktrzLj1B0BQf9qJQ2dz7aIJKwmnRNgedE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxAeNaKf9LaeagSVYyx/eoXswgmBGA+mIxB064FvI1CN7Xcel05
	X9hozQuP/7gx5ut6vKM8SdN4MbbwZd1MvoBh6+p0w8J3JxMRRIJ4bg9p
X-Gm-Gg: Acq92OFX7CSvbknTu9Bg54a54jdWVYhOr4onPEzzjQE/MW4EjRyrArzymIX0xKohDad
	ZJIwLmxvHedhjRRIW4mluoox3Ui/7LJN8WA5kFx/0iF39IlRJnMre720QA67iuOoR1SEbobs5Yn
	n1jLAtek4Kh8Lptp+UsKOzihPaLwWdkx38GO3ujsZKGGC7ILomXMf2EFJDKMm5tx2HeEL3Q/vgp
	L6GGsX61H/FVKbNh0pxBzOfFqsm3S8LLb9Xzj4+3687drfxPfEyHdaEux+dLo3FQEnPgtLefk4l
	O2e5mmyfPefwVOXtu6+a4MANoeZrpnFy5EIsaaLf2+xFuSj8itFVPpV3NZAR8CXxiKxl5w00vwl
	Z9a08u5HxOWrDJg/t9GvNzDtdUUpWqdJ2jIGUcSj544SlAywrXiDcqtwoIaenR/EY7hUf471J0k
	j4W1tWrVtTmPfbP6v5jDSKWFWXZfQq4To72Pqsb57BwtEIf0UN6h+sc4wFFw==
X-Received: by 2002:a17:90b:5623:b0:373:c536:6fc2 with SMTP id 98e67ed59e1d1-37c2bd5a9b0mr10221623a91.22.1781516435860;
        Mon, 15 Jun 2026 02:40:35 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:40:34 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 06/11] ASoC: fsl_ssi: Use guard() for mutex locks
Date: Mon, 15 Jun 2026 16:38:19 +0700
Message-ID: <20260615093824.115751-7-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615093824.115751-1-phucduc.bui@gmail.com>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
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

From: bui duc phuc <phucduc.bui@gmail.com>

Clean up the code using guard() for mutex locks.
Merely code refactoring, and no behavior change.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b2e1da1781ae..dc022976c982 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1218,13 +1218,13 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	if (reg > 0x7f)
 		return;
 
-	mutex_lock(&fsl_ac97_data->ac97_reg_lock);
+	guard(mutex)(&fsl_ac97_data->ac97_reg_lock);
 
 	ret = clk_prepare_enable(fsl_ac97_data->clk);
 	if (ret) {
 		pr_err("ac97 write clk_prepare_enable failed: %d\n",
 			ret);
-		goto ret_unlock;
+		return;
 	}
 
 	lreg = reg <<  12;
@@ -1238,9 +1238,6 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	udelay(100);
 
 	clk_disable_unprepare(fsl_ac97_data->clk);
-
-ret_unlock:
-	mutex_unlock(&fsl_ac97_data->ac97_reg_lock);
 }
 
 static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
@@ -1252,12 +1249,12 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 	unsigned int lreg;
 	int ret;
 
-	mutex_lock(&fsl_ac97_data->ac97_reg_lock);
+	guard(mutex)(&fsl_ac97_data->ac97_reg_lock);
 
 	ret = clk_prepare_enable(fsl_ac97_data->clk);
 	if (ret) {
 		pr_err("ac97 read clk_prepare_enable failed: %d\n", ret);
-		goto ret_unlock;
+		return val;
 	}
 
 	lreg = (reg & 0x7f) <<  12;
@@ -1272,8 +1269,6 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 
 	clk_disable_unprepare(fsl_ac97_data->clk);
 
-ret_unlock:
-	mutex_unlock(&fsl_ac97_data->ac97_reg_lock);
 	return val;
 }
 
-- 
2.43.0


