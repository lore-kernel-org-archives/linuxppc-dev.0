Return-Path: <linuxppc-dev+bounces-25443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EDDC55ABA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 12:42:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFVRd5W4gz2y1Y;
	Wed, 05 Aug 2026 22:42:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785916554;
	cv=none; b=L0iBG9utykEDAWUOeJ6JZiSklx9C0HewWEgbOy/4PSxgC7dp2JOiirNVjMXPprUl3c75FtRPk3DTz2wuhOQoBSVGN8VcxtmgGiq89RUgKaZLTjjetx9g/3RduybD0re190azR5o3NENJHc/DLPLii5/V8zThbPHpzB3wzrKMk2LJ3JqDsbboTqsxhQSLN7bSZB453bTSY4DhQ55+IW87QGovjbHgps53qLn0Agj3wKk2z/dAsbA2+pvWq7NN5Cz4/unQwpRZHaLgXvqRZjZqQ4iZ3OHFJtAog7SxjLMEnCFWaukplpeCFUVeQYZUlMg38HkDl2EJh5baO0VqFkXyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785916554; c=relaxed/relaxed;
	bh=buENsts9eXYr+cMpEnOHpWKy852zqVxsMr2A9kbxY60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YiN5viR6hHd/e2KxLJdKMRnHmPYZjnZEB4MljhiUpXrYFOlc7FrzBWbh/4VmFJV+FNF6KJYm0OL2a1VbQYORe9kDkiZkE4JHzF14g7y1XJoy62dZp0Zpp/xAy5IlJeAd0egFl+AuUu0C0FLBoUJ1CJ+etnXwkkMHBw7IP4fe7a0rEJ77//99Jk0h1LtGJB1YAf7QW4GYujffjm0kpBe2/xGirlv0QT2Xwt0vSTGDuKQYWOXbaxNJn8BcurSmT8PaCi/nJTH/TW922KxlAyxpfcQUDvbnT6z5XuhipHpUb1Zogzpvx+yUKokzTnuP0ItOzkxkJIJaLfMqZT400h0liQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FH0CZJo/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=zaq14760@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FH0CZJo/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=zaq14760@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFN551Wslz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 17:55:52 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2cf50c6f235so8795535ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 00:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785916550; x=1786521350; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=buENsts9eXYr+cMpEnOHpWKy852zqVxsMr2A9kbxY60=;
        b=FH0CZJo/ot5ap9Jj2fjJxQtsvlKuEaYQ4I2yE45KJmhjqFDVOm9eJpUYe6kCQI3Pxr
         7rK1Wh+NQ/HmXGGYj5u4QjTjR/DU11Oo+dtk8wDs8Rj70BY6s0TT9PHPnbO58W8LEdxZ
         hR5O4FEoKmXn4t4SkqqSIEFUpo2glRw86NGLzsYyg1v3V4tuakvg7B739F9tMAcnriZ8
         ainuTkWYEijZ67kZIAQZ7xnTcQ7i93xNJ6w+gp2Ebenj4qYRYU1E62JGc061fYAhxNTM
         hWKsU3cqPNLGa7zI0HbRV8g1oyqo35a5WjE9a3o2skLRod4Y9IUcVuxw1k1XbsLg7qT/
         vW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785916550; x=1786521350;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=buENsts9eXYr+cMpEnOHpWKy852zqVxsMr2A9kbxY60=;
        b=iT1VZUY5YKct3bJW2ItX1595B4YN0Cmrb/fiqjC2+sK7ojVKKT3jH/34ACoSSeUYv3
         j4+EFdzXK6TSuiJIG+8vxctYZaD83a8C1RtPXWLNHvJ1TqBzSB7JH0clwbL4p3FjJFZb
         jj3LWCD/QIlEEoGkulRSE7ujsc/z2gFrkiG0U0Atyv2n9R35R7oUuPKgLnbGU22qFGgr
         wbqO8VPUriuAqe7GfkvNlUmCRwG+Lr0v0iQTNPF9oi50U3gPyv20RVsxaaxlTVQ9RV56
         VCgc+0bdwBoKO2hIaaTCaGzPd0sFprwMWSjfGvexuu0I1/9I8C+NV1kbTEwVJypvfN6k
         wikQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXowTKM636m6BnP3BxTErNN6yf1ugtzDA6zjX5GvCkyqBdmFe33PvzPk2b1kv14DEv6YI19cnDRNtPecY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwAtdHhvSSjqq1Kw9uT+Tr7C7f45wCNhbmfUBEGTzGtQrX9mlzD
	WvKdYREJyLUSH+TQv7DYwMY1fbZUeZQsfALUxwGXgnmCgHXr5KA567mS
X-Gm-Gg: AR+sD10wuqwnZ0+NK4m0g77SWa9CH/HHXRt+HRNBSKTQiK/VkTk5q6O5O7bY/rkAJMO
	43SxeQb9yZBSl7YP4/OATrT0PAgXmCh5uiQH/8AoK6PzhLq5+gs9PXYYj6TnubY20O8A4SRWTLz
	h9wEQjvsmLqvpmOSLWP6gpiwU72IPaSxd4cuwMMSjxG+uR0I1SWVLzuwYv1xGd7lcjWHIeqeBJ7
	PXDdxd9SKGdaa+Dw1Fy73MNA/ot4Jmjy3BA6zeNm4NSp2Pj5c3IDQnCQTU7o13W70HUxgp2BDf/
	Z1QwXhNzhEn2lXKXGt2vtZEjIZdkVSeXPkd7qmlrYCm3d8tpjUQyPrNnLvUuC1XoR6rrQmeFgjg
	auDINiIuHo614txcGifVpPAIaWYL3qQ9zI1M999RUvb36bEzA0A4VAgc42qifu446yEVSRieHax
	bSvQksHoCspMrWEiFh8HWcFe7XRk8uI1bTKvvJGBkU+vdgWckQiQ5XpQmnAXJAEPIYwkvzGKd6H
	1YouVt68fo94cBrbwSdK5qEg4POCNmP+97unVJTbMcDhdh5
X-Received: by 2002:a17:903:2d1:b0:2cc:90aa:8787 with SMTP id d9443c01a7336-2d0ca7b54e0mr60337695ad.6.1785916549922;
        Wed, 05 Aug 2026 00:55:49 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f8fc8csm15721095ad.15.2026.08.05.00.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:55:49 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Wed, 05 Aug 2026 15:55:43 +0800
Subject: [PATCH] ASoC: fsl-asoc-card: defer probe when the CPU DAI device
 is not ready
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-fsl-asoc-defer-cpu-dai-v1-1-43f7f538e384@gmail.com>
X-B4-Tracking: v=1; b=H4sIAH7scmoC/x3MSQqAMAxA0atI1gbqUKeriIvaphoQlQZFkN7d4
 vIt/n9BKDAJDNkLgW4WPvaEIs/ArmZfCNklQ6nKRnVKo5cNjRwWHXkKaM8LnWHsZ11T13rtVAU
 pPgN5fv7xOMX4AcLdSt1oAAAA
X-Change-ID: 20260805-fsl-asoc-defer-cpu-dai-9b54e87f5d03
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Mark Brown <broonie@linaro.org>, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Wig Cheng <onlywig@gmail.com>, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785916546; l=1593;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=m1v76Ag+Fp0S33OQgA4ftyBRk7je3Dir+slUcySG738=;
 b=MsFHsJDqkEdPoHI6b3SB9AdaBRM1iziM7cEjo6ZAz/pZg6LSeBVgxuR9qdTF4W1PUTZX61fIg
 nLAnfBL/cC9B8OweVgjJiqWzLAO9HbmVJbj2KAUV1m8dM98x8K5/g64
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=

fsl_asoc_card_probe() hard-fails with -EINVAL when the CPU DAI (SAI)
platform device is not found. Like the codec, the CPU DAI may just be
probed later than the machine driver; the order is not guaranteed and
varies across kernel versions, so a permanent -EINVAL leaves the card
unregistered with no analog playback or capture.

Defer probe instead, mirroring commit e396dec46c56 ("ASoC:
fsl-asoc-card: Defer probe when fail to find codec device").

Tested on i.MX8MP with an ALC5672 on SAI3: the card that failed to
register on v6.18 now comes up during boot.

Fixes: 708b4351f08c ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support")
Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 709543308fe9e9dc508a791b7125e5f467182cee..eff46666c8add604d0edbf9537ee2d275813c1b7 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -728,8 +728,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 	cpu_pdev = of_find_device_by_node(cpu_np);
 	if (!cpu_pdev) {
-		dev_err(&pdev->dev, "failed to find CPU DAI device\n");
-		ret = -EINVAL;
+		ret = dev_err_probe(&pdev->dev, -EPROBE_DEFER,
+				    "failed to find CPU DAI device\n");
 		goto fail;
 	}
 

---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260805-fsl-asoc-defer-cpu-dai-9b54e87f5d03

Best regards,
-- 
LiangCheng Wang <zaq14760@gmail.com>


