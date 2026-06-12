Return-Path: <linuxppc-dev+bounces-22566-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6A9CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:49:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMqZ3qrDz3c1D;
	Sat, 13 Jun 2026 00:49:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270852;
	cv=none; b=CB6GPDZVyxrQb1k8M3Hete+PAdoaMbGD6tHGsMDXhreI1pY/IWfg76L1H2BxlNd0ixTCmCsHFa3jsnKrpHAmnwqcNdncUL1IqxoWoHzm0gmC9L7tkBSTZTv7IUDN2WYkDKXLcanUF95dFe9OJfLQnlWGyYwhOSwPLasPab+fI6ZS+on2ts3ygT1r2z7qIrmXaqI+TOM5M0LrdMFiOL6Ooyb+CZEZNMrvSRlX53VLIpQ3ry10cemR25OXLQihWBvJGoRtGu/2aOWIawgy+7u/1WZ6trx84cn3TA+PAdqM+J9SjUA0whJCaJdsY+HVfdgmlygZZ4O2uu66k1XGJ7pVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270852; c=relaxed/relaxed;
	bh=wpnchv9pa/fMvI5rIt88B4RF1cetJyaCH3vcYXn44rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it/axFhdQLKIg0FqWd0qFHU0eFY7uLvNoY5MvhQKtaj5v92zc6odu+lSyoYOVsDL3hJmqJOfFKCoASQr79J0A4hV+jGRvwJ/qD2HsCaXNKqsYwTGWni2UsV6w+fEubXV+wEGBApJicwvPixHDYU5bdz1PFUIuKdWO3Ou6t04BU3+uCJy8wKoBnSC0Xw1C9vlapo19pkkkqCMHtHsuLzBmtaxHY7Z5XUjE9JC1AricnupUHkV8KSpzhwbbC6VMUbJFgh7rzK62r0pmi9WEkxpPPBrh/lYuwD8PcbRrkmZC7yPSw1rWRRP3DnLFQts6iRCrBMchypAhmmQnr2njMy6jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SV1gdwdI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SV1gdwdI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL0h3J9jz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:32 +1000 (AEST)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-304df7ff4c2so1249780eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270851; x=1781875651; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpnchv9pa/fMvI5rIt88B4RF1cetJyaCH3vcYXn44rs=;
        b=SV1gdwdIGApc8haHjABn2xTro5PHVZfDxKDkXVPZ2+4lZU6eCuy8j4qVLtNNG7E2i4
         1NNjJ2MX/RrTkpr8ufrSun7tRBwB/WRUPFBmWZRaf7ekL9UKULPpujiZ1Tg0KD4GhEPd
         QUFp9C6cO5WVswzGfPDOs1HwE025ScEBSa4Nfoik8PSsyV+Stv/tcCGeOdzmuJYPMzGd
         RS8N5OaDgjcozmWOAzxsTR09pTijyVdQX+g3hgSshaAjD7JlKSEIyQAqPiFxAA6G5RGF
         RZNHAEGx9p4x3S3gpwlM5DnwdJ8HBUlmgke5r5YeATBiI49HymwoQ/EyrCD8D5wLq72o
         hxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270851; x=1781875651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpnchv9pa/fMvI5rIt88B4RF1cetJyaCH3vcYXn44rs=;
        b=mDlavIWEgp7oovHiJeaTxsmFZVVzJhdcXYP+58bWaZzCvFL/d4PVLi0tQHw2ai50DM
         jvzf+m15X3kweUuznmzdHbgDzdfFO+Xh5DM19CET8J0QZH5FPX/aYDkyiDS69LxufkFM
         NkcAkKJ/deeeumvK81lufL1Sg2hFEzHovyIMjCOvA/JrULw3MCZAJzfDnJGtIE6RHMMN
         Zt2G2WZ1makSwd12vnMGHYsF/+mEBPNKOSw7Nv9UjZl1QZ+s1hTP+R9RwLR0Suqzr6qJ
         kMkkA0wW6fo0/F65D0lH7h4MMNvvHSDjbMSLYdjx+sXDJgJFR0m0dnXeozqxz6aBRZZ3
         mTFw==
X-Forwarded-Encrypted: i=1; AFNElJ/CAe02Cuyo4YEqTjYviwOUp2wT3SCPgVv1dJX33cVEvJ2NuVKY9upNP2aZdb3OFM+2flnoguKH+Lvu+Wo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQxDrct5r2hJgws5d0HDDIkJPTWAEaZZNSEqOB0d+6/wbmYkS3
	JVCY3C8j87ZLMsHzW0EIJ7jQXqSjkyPO2mdX2QTRV+5rHBSTVMdozYt3
X-Gm-Gg: Acq92OEGUWAKDxCfTaYFnWxoJ6NEtkFlJQSxtTcR4Xr5thXFW9YSUFsyi0w0XPmKCBY
	kn/8M/m9AZIPuRuVj4GQ1s19aB9f1b32AaUXzPM/Zh5gr9yXFXr+DYWX5gWI5EosbOcvHy9JQvI
	wFsfkwcxVCMNJVTONyQrynKxCRzeeZJleK2NZce1CjD53GT6EUCh/9HbWhrcxzZJ9jhNeFDlBxc
	xi55GH1bbmjs6dsqJjfK+h1tHgz9GcFNY2ZRCKS/S1JmRyy9pJn5bqNt523fsmnX+I/7c5Yc/O3
	ZjO4PpC+AKAf0ZZY8hLeVG9YNc3wk+urHUCANMdDKmvR6PQQ7HnBHMii5Nge5/41MRRgQPKzWhp
	sfUP4OBI8dQpslZlaON2lQaJxmEZtuy8SCZ5fzVJDnd4EQS2vDBNBiK8FkANaCNJs3r2gAKiHYf
	CJNmxn95+HwpB3zzk8m1uJIYKn5DvyL6vRTfnk83YnwzgzhGNJQMoKGOlZ3g==
X-Received: by 2002:a05:7301:9f09:b0:304:70d0:4f03 with SMTP id 5a478bee46e88-30820c2d782mr1373677eec.6.1781270850611;
        Fri, 12 Jun 2026 06:27:30 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:27:30 -0700 (PDT)
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
Subject: [PATCH 06/11] ASoC: fsl_ssi: Use guard() for mutex locks
Date: Fri, 12 Jun 2026 20:26:34 +0700
Message-ID: <20260612132639.78086-7-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612132639.78086-1-phucduc.bui@gmail.com>
References: <20260612132639.78086-1-phucduc.bui@gmail.com>
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


