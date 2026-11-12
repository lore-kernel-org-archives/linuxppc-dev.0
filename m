Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024960A2616
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YSx+3x3m
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQHJM492xz2ylm;
	Thu, 12 Nov 2026 21:51:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794480707;
	cv=none; b=Q/nTB8cfyPARywqrWzPtXrUuLLo4E39uZeRS0LtGm2xskDO69NTrgJuMe92dPzecSsDrAIl1QjzbMYrxVeDU91Pa/YuJXN+S78B2YLeBmNUSbV7N9NeLRNzBWcH5uaO08fL0xcc0YOAzzOgd6eXKJwS+XzN2krz+VXe32gP6oY+p6auUl/SnA/haA+sUSS62rKjLty95IwbsV2xrvzuX2V7x5WDMPbC93Cl9zODCqdy61C4UIQUkZUD7VyQ258a8ubCvStQ/BHAY5aXiLMHmJuJxlZN+FtLzA/pCH0wJw204JOURZX5SZD19WlMI1ElFMwTWQXY40uueIVj+sXaK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794480707; c=relaxed/relaxed;
	bh=IFm8ieWHHt9ZUMBFOECdKzOj7Y+GHKcLVGVXGiF6fko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYLoQLIVU6xPEjHDbItEK2dgq0tlmzaQYGhy8Uy2GghKgWhA61BwVJbGiVkiZtALzDgfm9cdK0GvjB9tXZd1A4TNPuC2OwWAK+aEeVYsA8oULGdxLFDXjXvcM8CP1q+GiGSyep7JisaTqfUp5mnN+1p2a6QoQptvWpnjLtxYf4lIy8fGGi2MwgKn+ZlOcy5fb2bKRVrJlcxay7mqROmeUf77nGnVUWwRxKGGC1OqNhELw/k5+01EVnLORWIM6bOHZyB/6EoO5EfcUoMPmarnVGI+jJDBT1dtNojcNJjvj8QPoFwgqNExp3MILkX0nPV8ugKCtfeCYhMJH98er/ghyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YSx+3x3m; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YSx+3x3m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQHJL6jzMz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:51:46 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-3720addb068so7345676eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 02:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480705; x=1795085505; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFm8ieWHHt9ZUMBFOECdKzOj7Y+GHKcLVGVXGiF6fko=;
        b=YSx+3x3mRQdZjrSzHFIx9MfGnCkynHczEGgIpf6JYX3WHXKFIYYxs3dM48eS7L+2T6
         KSsdRRFGu4iefHjZY1vatyjzU/X2UG75+rTBfEyAnJxmLNib5zZwV0os7uxTB7sn0Sqn
         fg/cm3l2QyKxrwSuWSY45ZE5FdSFbS2UbRQs5scotwjZlW9FxpgHhfUi8v5EcVoIEX3m
         EZAp07SjTpgL5eImD84m+xlVQIrxVXYFADCj8VqjhWtWdbZoVmoPuCZQTnJkFRx/7kJs
         kHRCM1lFjgHBJYAsVlM8InHk0+1RRa4Z3ZiFwTkbyZ7pn+IGbc0XfdjzC/6Jq3/SHLrh
         9PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480705; x=1795085505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IFm8ieWHHt9ZUMBFOECdKzOj7Y+GHKcLVGVXGiF6fko=;
        b=VOGC6OrDId9RmU5OdZkdANz/inlEr5s5BF5e3GO+FFwHDFvIuL6gTy1huytX6avXZh
         prn0MUwRUMkjYIIbY3lGIjrD+3r+bQya4HUDNCajl0ve8Er6/ig/THkwPHblxPiRex2r
         M/wu4rr7jaDbSDIwhcZ6GI9LoGAqpqKT/MUBHSIR7JMqDLktgNlPN8wKC7XMy17sBoZ2
         GHyJfHKrPOsQ8oppDbegtWjyZrNEsj7GdFwv30k4GW0Fk/KHBmtAGasBRaGAXX0x+Wxs
         61sQg+7DFpqmwNscFoK3FZMaA0Y2cvPyPNEm3HGIyYj65BIJTiKYaOjs+k8AVayqxMrE
         XLkQ==
X-Forwarded-Encrypted: i=1; AL+hErGYJZww2QjMdNp5SUuBCeqImZyCBsFev7wxeWsivVGDhVTzTUbz/b3FcRxbbV6N/zCmJqMv+8PaI6GUJVc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+bB5pnrkJpRPajAUZ6LRCwd5Za+404kF/ynjf9D/ZZE3PFCnkG
	joCFFqEWpVfAVHqnN01h+gOe8gMLafihcgIE7PcfOEaFQqHMmj8T2oqa
X-Gm-Gg: AYBFou2gVenGgMiDOZvBhAblEzZ06eBS+qCwbsDq2cpqMu3tUrK/ZVDumcSH0UXoO5U
	nxHSx89g6C/CvRMG/XNkvZvllAHxs2zVAZ6AAKOxUIWnuc4o4ZV0u/MPxzY3rl5hJQ430jPs+hQ
	gSGw3mSQISIAmb07fQc3TfmG4mmkbrZW6Ie7RbxebnfejTY73qpIydcKaIRZEBar7eB0tsCWlAM
	CJlpC7OfICsxq12miivIFrGckTVK1zgEGAYcZDZRdR7lDN4/VCdJkequziAiqpS30xc5TezydSe
	2kpJwRdtxFxmKxPA10JtWBVzU2JvaMuq8sAarhzdjF2gecZ72i04PHT+fuZphXpMfvvawx+gPBp
	F0NUXCBrzefcBKmXBaUrfizc1tU3kfhCIBU5ZzZz4E+8G5aQ7x5Vb74y7s0+oJi1h4ug67Hosnr
	RU1WFO+iqACzCLmGsZeFlMJ4aOVK6ZLz/NvZDcsGhe1d+jVKW2jbctvl3agqSCH7o4hQZUqFnF4
	IES8ufk1+hNc4pBH/x0SCsAnJPTUoI3iriJkfsCDYBM7701tnDWAJI4cpRurnEe1R+x3IFLGNS6
	kp1H8ACmciKiaCukpd7oknsA88TaG9OCFKEvxjAGZu05jIVitbmJzLw1EBctM+ObztT7YVb51b0
	MOWBX6/pXDTY1341NpmIJvPcecUcoWcf+aQPQZSHXYFAH
X-Received: by 2002:a05:693c:65c4:b0:36a:31b2:8643 with SMTP id 5a478bee46e88-37686c3b663mr5085905eec.38.1794480704809;
        Thu, 12 Nov 2026 02:51:44 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm23047232eec.9.2026.11.12.02.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:51:44 -0800 (PST)
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
Subject: [PATCH 3/5] ASoC: fsl_asrc: Fix runtime PM usage count on init failure
Date: Thu, 12 Nov 2026 17:51:14 +0700
Message-ID: <20261112105116.32274-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112105116.32274-1-phucduc.bui@gmail.com>
References: <20261112105116.32274-1-phucduc.bui@gmail.com>
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

Balance the runtime PM usage count when fsl_asrc_init() fails
after pm_runtime_get_sync() succeeds.

Fixes: 286d658477a4 ("ASoC: fsl_asrc: register m2m platform device")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index c91ffb5e0c5e..f7ac60724c6c 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1432,6 +1432,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	ret = fsl_asrc_init(asrc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init asrc %d\n", ret);
+		pm_runtime_put_noidle(&pdev->dev);
 		goto err_pm_get_sync;
 	}
 
-- 
2.43.0


