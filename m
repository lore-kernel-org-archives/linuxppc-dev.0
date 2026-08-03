Return-Path: <linuxppc-dev+bounces-25300-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D5FC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 22:36:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDWjM2Fpdz3bp7;
	Tue, 04 Aug 2026 08:35:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785796551;
	cv=none; b=UB2Jpl2uoTYX/reFKqfi6U3kZT07pyF4OPGeoHPF5/fSwNi1ymDGrrj0JKEXfSSdkMz0XzuF5zmQ8/x47nhX90h73yfhAr9O2Tuzy0xd6lKtrBhke8JvnEa6uM1c7PEhSLIGpJ9f9dj7mmRpyvUUVyjWdEt+InStw4JcWzL6f5JQT9e1TDX3GuIydlScg/9MHFfNKexGvZx75MEB8V8WFJJ3v7cs9tJzgHSywlw5kCJHEHX6B7xYaCHoKvi6AIkHTMN0juqiHSBqnTL6b1oTws3yKhv6uAiymy/aAVj+8vwEaTvoAnU6ctD3Q0d8jhbhcBqZpaAWpFRLa8ivqtsXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785796551; c=relaxed/relaxed;
	bh=2Sj4NNt2oYO7Z5j3g1ICVeFL2IOOSPdBWqDyST2yYQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daQZfZWH4lNalyagBE23KwBVkdc/oOXSz8a+7aDuMHn5tT3fbNqUpExYdsd6ommDDIRrGIlxj5DSH18RsTUy7yCobNLcOM3upMu/96ZNscNFqZgbr47SkgJiMyqZRCg4MjdaSo9nUUnBbHAIR9oSBrZgs+7m5oYehX4/WXA93m7fr9E79PRe8/wOH3/Hn+eyO81PbOhE2PyaO5jeeJLuwjVhKcCwEK5RYx8fi5Oy+iVessWcspI8x8AQs9K+qZc+3HaBRgS+pB8/F2QeVvRuVl+a/evy3fwVAMwLs2zIlaNErQzHwz7elLsVzaqZBcuwdUV/YUiTRpS2iz7NSYgvLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GyJZfW0j; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GyJZfW0j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDWjL4KBZz3bwp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 08:35:50 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so2798484b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796548; x=1786401348; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Sj4NNt2oYO7Z5j3g1ICVeFL2IOOSPdBWqDyST2yYQk=;
        b=GyJZfW0j+WoLLUvyA+yXAOJmh/PTXxx3NMgY/hVnHFjodoUHFGqljAIL6zjvVvA6vw
         /ihCNiUmzHz40Z6JoWB2xYyelPoLFEOgVU/xWgiGmzkC5qMNk/hpzjDzxsyudQ+3bmk6
         tRbJsx/tEmwe8a18di8xrFYyOCdtnIwk20VNTJsTqJ+OLoBR4pWHKceapld6TGMHRB9O
         tyLXBheFJtrBnre6BJqdEGbC/dqWuW227gmhU1/GAJ1szu04QNTHUYWyKKfCh/h1oqui
         5s10zT32LeyGBQ/nY2QXXPdBd+2ONdH6qR3e5AjgyENGsmAAlwdSHQQwKM+TSve7P3nU
         jCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796548; x=1786401348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Sj4NNt2oYO7Z5j3g1ICVeFL2IOOSPdBWqDyST2yYQk=;
        b=jTcyJ9AK133ZjpJCCZIHCLS55FUSEk1rm0CjP2zXI4YCJrSu/HkYRag6MOkavgMQET
         SrkgiLrI/qHKNQjSSV2GeJeWqwR2sPhNqZhTqrhS21j4ANfXqVy5TINaGthHo4z/Gtyv
         X2cDee710juouELpT2tJEtO0bFWJhTe5mTxCTjARxJvM+NRcQAfA/it/467m0CyNQk28
         VmcGaHU/visM/NOymUXe4ouCNyHKobkppcG3aXYPrvzjOBFCMnQA+o/PYmbgDguQQ8xT
         RqB5NnDMyJUA1L6KAEqtyf9+9IfV6evDw5nALzzuAumA+OQ8jbuIV1NJhGD0sHx/3DOR
         NxpA==
X-Forwarded-Encrypted: i=1; AHgh+RpsTCNnQ3Q6kYm1ky/MOb5p4q6o7faH0HyIe646CyGLFdk6o0+HcUgeatXa66xWPkhch5jrT6e3vYXYgEs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzC2AAzanzH14xmcwmigPc4ppGpSsmRr244lUvhZPFgz63HXJyI
	yIPAQNUPPqJT5HY8Z9D/bmCgSnmZgpLwm82tK9rcAUbC7Kzuf4sKkFji
X-Gm-Gg: AR+sD11uvnKr3hRZMAP8oLqh/xLYObsfZr+7q8+0By85OLhaTSDWEEihVycZn8gJlKI
	FWtYhVbTXDFTwUTjqZ7Idi8155ChRX5GWFfRj4h4qGISdlg/5qNK4ltO2SHvjcfKwgticYsrJgi
	No9x7rDfNJ31BccdgTah60PZobqUaZ2T9cWNy+8WxG3PM2oUxTlpPDRNACSRFoG0rCz6PlA+L8q
	Sg9O7YEImNS3V5bgUykADSDOgoQykDw0ovq15iQltQ4QRcmmSHF7sJVXwN1A+v3SKoOx02ERQdw
	vXVYGuDLPLUGZfxbjGOquHQm9X3nLMyUt6QrJItTVcJtOmTgwPaMQcbRToyw53dqIT9/QYhiorj
	Ec0CItlQ+dcRdqHQ76AkA+fvJA/rywXQmQ0IqcQMqHLacKVeP9v+6uYOd2sdsiogZdpI2KOMXVI
	FXJSomyo8klCb4/VGcnDZXzMMORbuDi0hgxAx5SGhAAqzjuMG2UXudqx9+HK8VKyP1JZEJjy+ta
	aX2x1hQ5utA4cYwBQ9UkZrvKPzQkydcN4Vg2KI0n2eBKdmF9jrkNaAKAOBrFogrFSMjUjMgbBh0
	7u4uYwXZdvsEO2sX3Mr+1TC+DugbmBnOyYlPKIwq1RstoKNr
X-Received: by 2002:a05:6a00:4518:b0:848:637a:4cb0 with SMTP id d2e1a72fcca58-84ee49ac188mr10107343b3a.60.1785796548373;
        Mon, 03 Aug 2026 15:35:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm4186790b3a.40.2026.08.03.15.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:35:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 4/8] gpio: ppc44x: Use platform resource helper for GPIO MMIO
Date: Mon,  3 Aug 2026 15:35:35 -0700
Message-ID: <20260803223539.86303-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803223539.86303-1-rosenp@gmail.com>
References: <20260803223539.86303-1-rosenp@gmail.com>
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

Map the PPC44x GPIO register block through the platform device
resource instead of reparsing the firmware node directly.

The GPIO node now probes as a platform device, so use the
platform helper to keep resource handling aligned with the converted
driver model and to report mapping failures with the platform device
context.

Move ioremap up in order to avoid doing extra work in case of
-EPROBE_DEFER.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ppc44x.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index 99fb11cd7966..5db5217c0225 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -158,13 +158,20 @@ static int ppc44x_gpio_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = dev->of_node;
+	struct ppc44x_gpio __iomem *regs;
 	struct ppc44x_gpio_chip *chip;
 	struct gpio_chip *gc;
 
+	regs = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
+	chip->regs = regs;
+
 	spin_lock_init(&chip->lock);
 
 	gc = &chip->gc;
@@ -181,10 +188,6 @@ static int ppc44x_gpio_probe(struct platform_device *ofdev)
 	if (!gc->label)
 		return -ENOMEM;
 
-	chip->regs = devm_of_iomap(dev, np, 0, NULL);
-	if (IS_ERR(chip->regs))
-		return PTR_ERR(chip->regs);
-
 	return devm_gpiochip_add_data(dev, gc, chip);
 }
 
-- 
2.55.0


