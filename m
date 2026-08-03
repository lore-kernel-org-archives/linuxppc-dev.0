Return-Path: <linuxppc-dev+bounces-25301-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C355C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 22:36:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDWjN6Dwqz3bwp;
	Tue, 04 Aug 2026 08:35:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785796552;
	cv=none; b=FTyUpVgqfK9GTyZdTwnom6b7UbKvYYjz4DZZ38suq6MubzCL2GRI9LNZA8nC6UpBMpFiE4EI01ZsVqn4X1p0aTocHZ4ODWNmA3ZRAavx/yGbT3e15iWvoJtyDWsAJBul8cJO4cjx/7o8TdY/mrMWWoEtT6xHDjGqv51NAsgPXH2duZlx9mQOBR/Cf1jpyJdZ8SYwJ9d8LwnMz6UMKDe2QjgU60K6J1pLUYOeYfh3zIMLpT3RmuaTj6d3hEFJd40icagJJZ5DiA9ajsYXoM9rNrnr/l9om7hHUoxIn7gUnecVkn54DlIutxGkqSYXC8N8IMQaxc/b4z6S8ghg9mlOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785796552; c=relaxed/relaxed;
	bh=0envxAJkQN4/YeFdWq4QWO2p31D3mPwUrWMJUSBwUzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUYw6eXSEJuVJy2/7eEULYBPhs5jzfDtea7J8kBwRxXR0LhtDwdq9RujkE7c2eFa5nLQVevLmGBlzG5m0pnIhB4Pa0yZ/FDReDSvM3G33cBG8WQ4jf6MuYJO08LzOXysaFO13d5rav9s/TaTkQUivN1R2S0cDfD43uqJ8++9ZfzVOBwAh39hO7/eVBJ5VOWSShWIRVF8KTtPX+6OXlUF4mRtMN9mYv1BEm0ygxY9DwwTbiVsnNScmjVKm58VTSFu7eLvcNQ8s7m4RhF9Sj0HyeZLuHviB5SLD6NpuABOekS/lu35ZQmoqUf2CtewqUeFx157+5v//ydQ4jmT/mJFmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ARHQRK2L; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ARHQRK2L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDWjN213Rz3c01
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 08:35:52 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso2166529a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796550; x=1786401350; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0envxAJkQN4/YeFdWq4QWO2p31D3mPwUrWMJUSBwUzE=;
        b=ARHQRK2LftUQuZDBZ9NiSwFg0MzDrPKCKkHjkTAsSGYA6Vb/V9dOImYPZn0uCbD5hA
         aN5euxeG4qzGSpBce7LgTgxbHXyk06mPV/2tLzp2uvHZqacxNzM9nudN55bkQ7tiPZae
         yXAZCzEiqqUhsWNBH10k6kR8tySLEyhAESW6RCaS2UtU6kHwz/VSO9JcVQAyCE++6TcP
         6EWUqwXpD62CC/0LjQ+v4LeHdSkF1XYHhb/ludmOEZBaSCrqXZcVnpXqIn/KBxwrSi2i
         J2jw8pw1uxKwl5NfDiyVId2YvnbofNtBCSD4tDWE8FQZOF/SGsCG7opyohyFnOhH7RVt
         1SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796550; x=1786401350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0envxAJkQN4/YeFdWq4QWO2p31D3mPwUrWMJUSBwUzE=;
        b=gIAoNm6yt8Q6xmmLpzazVPo3sd6xo1CdWQXynqbtCK8X5BjY4OBqvL3lpFzV9qVNqQ
         C5P49yHxKTOlpbEFvgi7JmJEoN4qG2YM2aAbiJF2SKhRc8eubn8zU6Y+78qyJLAwZbZV
         vMGDdVPMsEdBgmKrlo9ggEDQLYZR7XBJeDJV3WkYN39060Y2ZFalO+sYMPQdZYVjDqde
         93s8C7tOFaXXr1Yjtuq2WosUgM3q5/CVp7MU47Cr+mF+s5osGqLAPEYo2Qz9c8cO6qMu
         zhFusN7GUNijUrWItVOpRmacPsN8jqyPPDolNoVt5ECJTG7fSA0+IyfE6msY3V89FHeb
         gNIA==
X-Forwarded-Encrypted: i=1; AHgh+RpCZyVt/bS2hSv0r3mRv3QdCpSl/LLU9U/vOvc0bEC8ExqnN9cEyNmp5/eB7roGptTImLxRvivAC6Ur55Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yys2eyJbKNp5UxjQrZARiJm3YM8fTJ6wDip3j8c5GKY82skE7GZ
	i/7DK2oZ/RYrDDgS1W+RJuwSA4MaOlN5ENecWnx2qtxkXSPrbJfWEEBV
X-Gm-Gg: AR+sD11qsys+HLP0BLf9c7zOjtK/jJa4E2qkuo6hV93+yNdt4pcWRs9/6h9il7Fis+8
	ukzFIkJWsxzA1kNjW4T+2b5D8Sr3NK7Td6Ql8o+XaP+V6PfpEVB3iG5+KGfHDbJlJxa9qlvZDPz
	mJKoGw15xaOIMsf12srCEeXRiNLyzi+DprzOdNhFD0ZW1FAP16Hl+EidjBUdKk4c+QvUlPh6By7
	Gxg7VoO7Bo5X/JlEncP/J9NLIGM606LUm2L1OVoHdW6LQ3cyurknE6YQhahrtdkU6c5HNi5pH50
	/TZhZTqvdRFOuPj2V06E4kpa4CnvpVIj4My9Tngnq9oA7l27vlgkPooR3899RjVWLQrXWKwSSK+
	ux9yKl8LWNxmHoVFCFUVG3Za5XcpyNRd7e5BgvOltHVC1c2KVXq8phKzizc4gGx6M9wXceVzxYd
	y2O3w8sWx1d54rx/xg5O0VdalPq4SYNvk9BED4I3hsrsiUkZ3qy23/BdMWUCtAf6S2yAZXvI9Do
	HCd4/tc4jxRzYLNPdKC4KIW8gJsBBG04U1Pxx+mGcjSok1iAubO8cOVqbvaeDcSBeiKjPOKNMDM
	yvvjOkGoSbycfgM3A1JByhiqiMui4gRn5PGSrQ==
X-Received: by 2002:a05:6a00:8d1:b0:842:2419:6c0b with SMTP id d2e1a72fcca58-84ee481474dmr9123901b3a.10.1785796549925;
        Mon, 03 Aug 2026 15:35:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm4186790b3a.40.2026.08.03.15.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:35:49 -0700 (PDT)
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
Subject: [PATCHv2 5/8] gpio: ppc44x: Convert GPIO to generic MMIO
Date: Mon,  3 Aug 2026 15:35:36 -0700
Message-ID: <20260803223539.86303-6-rosenp@gmail.com>
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

Use gpio_generic_chip_init() to set up the PPC44x GPIO chip
instead of open-coding the basic get, set, locking and state handling.

Keep the PPC44x-specific direction callbacks because they still need to
program ODR and the OSR/TSR registers around the generic data and
direction registers.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ppc44x.c | 75 +++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 46 deletions(-)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index 5db5217c0225..d9048452162a 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -11,10 +11,9 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -45,9 +44,8 @@ struct ppc44x_gpio {
 };
 
 struct ppc44x_gpio_chip {
-	struct gpio_chip gc;
+	struct gpio_generic_chip chip;
 	void __iomem *regs;
-	spinlock_t lock;
 };
 
 /*
@@ -56,55 +54,34 @@ struct ppc44x_gpio_chip {
  * There are a maximum of 32 gpios in each gpio controller.
  */
 
-static int ppc44x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
-{
-	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
-	struct ppc44x_gpio __iomem *regs = chip->regs;
-
-	return !!(in_be32(&regs->ir) & GPIO_MASK(gpio));
-}
-
 static inline void
 __ppc44x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
-	struct ppc44x_gpio __iomem *regs = chip->regs;
+	struct gpio_generic_chip *gen_gc = &chip->chip;
 
 	if (val)
-		setbits32(&regs->or, GPIO_MASK(gpio));
+		gen_gc->sdata |= GPIO_MASK(gpio);
 	else
-		clrbits32(&regs->or, GPIO_MASK(gpio));
-}
-
-static int ppc44x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
-{
-	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
-	unsigned long flags;
+		gen_gc->sdata &= ~GPIO_MASK(gpio);
 
-	spin_lock_irqsave(&chip->lock, flags);
-
-	__ppc44x_gpio_set(gc, gpio, val);
-
-	spin_unlock_irqrestore(&chip->lock, flags);
-
-	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
-
-	return 0;
+	gpio_generic_write_reg(gen_gc, gen_gc->reg_set, gen_gc->sdata);
 }
 
 static int ppc44x_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
+	struct gpio_generic_chip *gen_gc = &chip->chip;
 	struct ppc44x_gpio __iomem *regs = chip->regs;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	guard(gpio_generic_lock_irqsave)(gen_gc);
 
 	/* Disable open-drain function */
 	clrbits32(&regs->odr, GPIO_MASK(gpio));
 
 	/* Float the pin */
 	clrbits32(&regs->tcr, GPIO_MASK(gpio));
+	gen_gc->sdir &= ~GPIO_MASK(gpio);
 
 	/* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
 	if (gpio < 16) {
@@ -115,8 +92,6 @@ static int ppc44x_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
 	}
 
-	spin_unlock_irqrestore(&chip->lock, flags);
-
 	return 0;
 }
 
@@ -124,10 +99,10 @@ static int
 ppc44x_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
+	struct gpio_generic_chip *gen_gc = &chip->chip;
 	struct ppc44x_gpio __iomem *regs = chip->regs;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	guard(gpio_generic_lock_irqsave)(gen_gc);
 
 	/* First set initial value */
 	__ppc44x_gpio_set(gc, gpio, val);
@@ -137,6 +112,7 @@ ppc44x_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 
 	/* Drive the pin */
 	setbits32(&regs->tcr, GPIO_MASK(gpio));
+	gen_gc->sdir |= GPIO_MASK(gpio);
 
 	/* Bits 0-15 use TSRL, bits 16-31 use TSRH */
 	if (gpio < 16) {
@@ -147,8 +123,6 @@ ppc44x_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
 	}
 
-	spin_unlock_irqrestore(&chip->lock, flags);
-
 	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
 
 	return 0;
@@ -160,7 +134,9 @@ static int ppc44x_gpio_probe(struct platform_device *ofdev)
 	struct device_node *np = dev->of_node;
 	struct ppc44x_gpio __iomem *regs;
 	struct ppc44x_gpio_chip *chip;
+	struct gpio_generic_chip_config config;
 	struct gpio_chip *gc;
+	int ret;
 
 	regs = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(regs))
@@ -172,17 +148,24 @@ static int ppc44x_gpio_probe(struct platform_device *ofdev)
 
 	chip->regs = regs;
 
-	spin_lock_init(&chip->lock);
-
-	gc = &chip->gc;
-
+	config = (struct gpio_generic_chip_config) {
+		.dev = dev,
+		.sz = 4,
+		.dat = &regs->ir,
+		.set = &regs->or,
+		.dirout = &regs->tcr,
+		.flags = GPIO_GENERIC_BIG_ENDIAN |
+			 GPIO_GENERIC_BIG_ENDIAN_BYTE_ORDER,
+	};
+
+	ret = gpio_generic_chip_init(&chip->chip, &config);
+	if (ret)
+		return ret;
+
+	gc = &chip->chip.gc;
 	gc->parent = dev;
-	gc->base = -1;
-	gc->ngpio = 32;
 	gc->direction_input = ppc44x_gpio_dir_in;
 	gc->direction_output = ppc44x_gpio_dir_out;
-	gc->get = ppc44x_gpio_get;
-	gc->set = ppc44x_gpio_set;
 
 	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
 	if (!gc->label)
-- 
2.55.0


