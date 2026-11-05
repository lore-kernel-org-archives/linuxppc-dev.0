Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B2606EEA7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sDUpnADd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzS03GTqz2y1Y;
	Thu, 05 Nov 2026 21:43:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875408;
	cv=none; b=EPVyXmaU4U67Mzu5FSsUHdAwPCoDAeUT0UREJEBK2g5h2U0kJ5KLJziO5FnWDqXV6WaJ9WSpycSKDXeLfRqZCGWocjSrpPAmXYS+hAEF4Cm0+ZDrIfbuOy37ThSYj3W9PBGEvrbRVG0FLxVWfT7REfuOP7k9eBiCfXxjhbJjne+yhqtsHQEp7GkJwC8+6RXk/QaYEzC44PgHJfNSjNb4uHujmPQxrq+NBANFQvPk1IehHoEKSioq7K77sLNbhxPff71+k+Wx3hYOk9PK3d6uOC9hiBw6jsoUF4O12HiAlTEim5rh/jDxO89wZ6w4aBkGt3EjdFkgShFSmF0w9BCxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875408; c=relaxed/relaxed;
	bh=ggzT8mm/DyquJidfZW7gt7MxdM7xQZcIv/Px9dQuRS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WokUryb1K6Mvkr3f7rjbH/O8cVzze1Hd+4iL+N8tXfyZDOWn2NRYHJ3gtPelC9lbbLiJ3JfpsiKmUgs4q+PulH60+IMyGPzlnpYyf+aJrwORyvGDAKRquCWTE63V9M5XHAG36onDfzeXwZ9OFQPH8PvpN6gJz4pRMot1uE9/wh/8AMOl/kRNFtZ7dqD80ZA14TfJ8VfVIHSb7s46Z4dXAcZoWRkN531TaPYRffzZRVX9F8u/YhjKFgbA9fdi3Ku6DMIJo0oZx4IlAvwTKvl0JRTZSgEn6pdj1g7XG2NwXbAvJLn0Ac1XNAwBnBA8tWj50jWvrI06obZ/CABinxkQTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sDUpnADd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sDUpnADd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzRz5Rl3z2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:43:27 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1ae18eb9b69so1740458c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875406; x=1794480206; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ggzT8mm/DyquJidfZW7gt7MxdM7xQZcIv/Px9dQuRS4=;
        b=sDUpnADdlisvuFN94qGS2llT0JbdakIhNzduWarXapo1DQNaz3ChE/AkSY+J/pLcf9
         n9ZcuDKzJ0Oj54sm1Ss0ifZzPNgrGIJOItYjKDT9NuSOqAmoj9MKBFEAA3Za87KbjP1C
         DY5cNQQ+cx/2z7O2EyR0AcAb2VdLPfxvJgpph9bN9Qt3GFYllM2+0jQXfhq1UTr1vrLl
         zsF3hBBQI+hCI74PN06SlpssgAXOpv6g+HIpNMzGGPhD0awNMBiVQTJzuv/+Gi2GRULv
         8s22yNwFi2cIa4kXpmTfNNcg8C1YK3BxhAmWcduHcaNMCjzIcrP4qSDWdqapm0VjGCFb
         UtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875406; x=1794480206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ggzT8mm/DyquJidfZW7gt7MxdM7xQZcIv/Px9dQuRS4=;
        b=cQWFJTZlEdZqBjWti48PFx/k7K2L2W+0b3OxCucLeXw648UdpVOPKTgsVwHdU41tKy
         tpg3ICPnDAOu2RSw6yVK4xfjPiBQ4beHoFeciRapHjRphosa9J285NzMSO5xmhBq9606
         vKxlzTI1mh/chHPF1WTeLE/oWU502hKNfi3RREWlm5OZW/22emDuWsJfK6WuFjlit+s6
         /ZA3ewcyeE024AhHDgw2q5rUexxbGusjD48bY9wjlJbm6p472O6K44kGcb20QkB5bk23
         84FzPVH+R+yuhLPbovyxl/bKZHDrCN6wgyoZfiIoBHKPxTK595a+XzSWVq4/s61GNh2y
         LEVw==
X-Forwarded-Encrypted: i=1; AKwUvBwV4CGaBFZP5xVvMHzqulW5KaUPmHjgrUegegVq6/fPbJ4t2LHlZPBE2utfk1yFtH+/MKvcgXBLLTuBRIs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z839nN8q3rVB1b47PjRsrT1P9+GHidyjhL4l4qugHmOp3yTDz9R
	aj1q+XP26HDaAioZ8evLxo29ICoEp0TEZzMfzyc+fL8paJFQBu0GmB3i
X-Gm-Gg: AYBFou2BZ1nAisM8LisSf7x8v0XFXcukFT4S3nG3UNFAXwpApVSOidMC+YAP203NGhb
	m0U2HnMNG/tfku79fmNapIKprQ/fj/HMw6l0FWQHppQyr+5pYa3SBm31B9np1BJT/UH9wSwzAxZ
	SGr+dQdeSeyJUe2NzwQuOGlsKhe8e8Q2SBwIVgMIkjuSkNnAoOzGG8mWJSRpomi59tIDybTLq9E
	KgtIY14+D9yFI1zrRmgPrsIid8QuDqo17KNK0axK07DaYsOYVXLth1N0H6kVqb9ksSod3/TzzA+
	n6+nlTo2y4pWep65yCU5WznVDrCmEP1sfMHt8EEDZgcaATEpRxUBKetm6jWKc+H4eWX3Yrdnny5
	aB8xj10WAvlJCya78Qbx9odGXKH9x0rFdSzwzaq29pEzMeACehakqI/TyKD+yTzPlMuYr2DkewV
	7l9Cu5Q4OjzXRSdDOkpw9/ZLma+0gHK7Ff6er+pldWLG71Vc7ZO+tceUTeWtJaNiivjyG78H8Xt
	np3X0ubDZ8yaJZa5Dg0uyb56DGVD8u+XPA7CeuEaNmK3QA+mnFb8WubiZAS8+whl7FdMtv9u1Fr
	y/50OaXo+ZM4OdCWhate7jIEOSbu/q7hWFjsiOBirKzmVoL+3mfjTICAZllSaxeGc/fFZrFESYf
	btz2eYNGqqXsUlUkol8yN/nurTm5qgdxrHIOAFEhbU4Mu
X-Received: by 2002:a05:701b:2310:b0:1b2:4e79:bfb0 with SMTP id a92af1059eb24-1b24e79cc85mr3514890c88.23.1793875405837;
        Thu, 05 Nov 2026 02:43:25 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:43:25 -0800 (PST)
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
Subject: [PATCH v2 03/10] ASoC: fsl_sai: Remove redundant error messages
Date: Thu,  5 Nov 2026 17:42:30 +0700
Message-ID: <20261105104237.38542-4-phucduc.bui@gmail.com>
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

The errors are either reported directly by these functions
or already reported deeper in the call chain, so additional
dev_err() and dev_warn() calls are unnecessary.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 44a34f48a0cf..5532fab80be0 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1615,10 +1615,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	/* read dataline mask for rx and tx*/
 	ret = fsl_sai_read_dlcfg(sai);
-	if (ret < 0) {
-		dev_err(dev, "failed to read dlcfg %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -1698,9 +1696,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(dev, "Error reading SAI version: %d\n", ret);
 
-	ret = fsl_sai_reset_hw(dev);
-	if (ret < 0)
-		dev_warn(dev, "Failed to reset hardware: %d\n", ret);
+	fsl_sai_reset_hw(dev);
 
 	/* Select MCLK direction */
 	if (sai->mclk_direction_output &&
@@ -1715,10 +1711,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq, fsl_sai_isr, IRQF_SHARED,
 			       np->name, sai);
-	if (ret) {
-		dev_err(dev, "failed to claim irq %u\n", irq);
+	if (ret)
 		goto err_pm_get_sync;
-	}
 
 	if (of_device_is_compatible(np, "fsl,imx952-sai") &&
 	    !of_property_read_string(np, "fsl,sai-amix-mode", &str)) {
-- 
2.43.0


