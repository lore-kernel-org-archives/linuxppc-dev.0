Return-Path: <linuxppc-dev+bounces-21836-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DDFCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 05:02:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTzG55DSkz3bsP;
	Tue, 02 Jun 2026 15:02:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780376525;
	cv=none; b=etIdNV1FT9JvHAvgcryqxarMZuT4xWd6hV+odNvzOm/9Gi7QyyXINvAGydxsnyvRyDO729dN0HVqMago//C/wdj4p16q/j51aKmQiQFu5cnGZfDTC8ZoYhvhdwEeAmZxN12bf1sY7QMnh4CIOFcS+Y/K43nbq6bUWzWIobkWWpHY8yaSMNTlbVArn4i2ESW9SZtG5qpovU5Z7fjkSch8ibMAc40h19OxrIfTtW2yuihaZcvs5/eUyhvY/Rbf1tnV6Z8UK/dqwe8UJtnctNYDPjTIq4dsykjpEPi2Se/bR6t+/XO+P19JbwGEAQPALbwULyDtSkmDmv2063jtijiY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780376525; c=relaxed/relaxed;
	bh=p3KbSzoRI/icX/VWbVUw16WYqo0/swLg71aVPGe0bc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCuvyFkd/675saMvMyE8H389NoY170kcSaUQylFRrgby8hpfsrzl3XO2B7fIxh/qQQ858sfKFXWZCPybBTpiQ92CrcN6fkVmH44uZ887xYS7wM6R++d1AkW2HOueRZ0czmv4i9eWBgOnuV4Y+hFm16f42oA8pGOx/XWUq9Q6F2c6hnzVDn8VhmvgO3aUHarwcCv79EQI8aQj+Vna3RjO7S7NLHplXHu7rJWxJjhoBLrewyL0mcVMkMyMVK7NB6g3nKdMQn8wtPZn3Xw7ECi1L+qEpCENZKuC859r9+2cq/A2/hQGBg0yvCG/Q8yPSw0UXMRjJ5VYH3jX6MWfvA1zYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sqxzVp4U; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sqxzVp4U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTzG43cT6z3btT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 15:02:04 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-36bcbd7821fso1662916a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 22:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376522; x=1780981322; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3KbSzoRI/icX/VWbVUw16WYqo0/swLg71aVPGe0bc4=;
        b=sqxzVp4UW0klUqsTkQzyCEE2n+08NYfhOwCxFFsW/gU1sBnkkueWJO4sQLMelRFQY4
         I/dorsiFbjN4uU6ZdtTXL9SJxhOYS1rQ1ebjRqHVFoebNj99hrQfIeAd6DuwTwc8zcmp
         aM6aZpLzOXKnbksjRxG/8RmAXurDfn+6IuLzViaUPYAbb4N0itYQ0Eh6/LdhPM5qOL1E
         M3TwSl8IvKO+XfTxsk0q6dMrq6B5RuRDsSPckfvF9lvkBJ7Px3nZrMyCvzW0OXMJijyq
         ivVgSY1NMGg0Y49FXmLRgsp8oliDE9Ci1n9k/hQ8PVuHftrQdCmkDpESzyDSKVodvUyv
         KNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376522; x=1780981322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3KbSzoRI/icX/VWbVUw16WYqo0/swLg71aVPGe0bc4=;
        b=cRNHMy659eflk4zDsyp+B49Tyxexfz8RHcu41HNidvF215OkTsiFrfopgdGpcdoqIY
         DPpGsWnTj+Z2bJOHL2MNPooROE0CyggC4lqOJt0XsKOErKzDkC+zk819+8D52Sz8PAqb
         HAaxFk8Ec/4LOukPQwc1k+vj0EVo/y8ejYKpiANeG0KALvSA5sknyOf3/IWVBB6Wz9+v
         h+YTq6Skm9tXurnrP5/o8PY8e39TUbhn+t3NfCu9SwytNosMJBa4CGdXQ43Q6kSQ+VGG
         aO6Krp1hnEUJdxnXILxastaKgOc+maL30uLR06U5PVM8K8wg+wF1DuY6UxW+YfPWL/JH
         lZwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HbEf+PeOHKlmZIHQMTZzsSyy+88IijLaZQE65Ed3CVRIb8ZmTeO+Ah1guVB7lJYe2j7VAk/b6BPSYinA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxVUemPRbzagB/okFMv6NucjmdwMYLxpcap/P0VXg1HTMWTVnGO
	yuzrwhyiMkrbaKutrNBVm0ou+96Fz2qCCXXy9WfNZMDXSSLoqRZX82Aq
X-Gm-Gg: Acq92OEYsdwB9PI53Nu6ts+qdLUPhoLriKvCnHLmyh5dw7dO1tgQjpetOMzrvajSF7J
	7s6D5Qzoikbj5qRNZdPBgPvKk227Nokkg0UDAZ5v2B9U7/xEz9pFGyxhLxTj9xeKtxdNpbzsl2/
	8jtofRB64ctCdZip1bW8VvmDvIpe2rjjJXKWakauRluwAFYW4LZGO/MAsp8/4CJinIbWzx+rZRS
	/ixcX3phpOLN9eManSOCvBj/zM9h/VEPDKig4SnjhGELJjxFaLOn7QIvYV2teQ6YDoC/auJNJOA
	wboWGzqXEBZpML7jUjtUD9GHcgvjAaxG3Ur5lX3oTnBhxMh0+tvhPjBGUlATv4AcWhPmXtVHR1F
	iVcOJWwt+ORU6mfxv1SvLskv20ptohhnBVDtGrlHncUW9+P+WeF1M3Key09EWnckE/2PHVCNIpS
	ntR1vQkTZKJls7TjFKuxnXbae/x6y35zhUvLt+squaL6nUHCkrtlZja8ujA3LgrqMb6fNjoHcA2
	ruaRyI9mysfOpTiYIPumltGTJyNke75y4cn/5OgP+RaFg==
X-Received: by 2002:a05:6a20:748d:b0:3a3:a55f:405d with SMTP id adf61e73a8af0-3b427c572e9mr15361175637.13.1780376522535;
        Mon, 01 Jun 2026 22:02:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8589d055c7sm8958467a12.9.2026.06.01.22.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:02:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/7] gpio: ppc44x: Convert GPIO to generic MMIO
Date: Mon,  1 Jun 2026 22:01:29 -0700
Message-ID: <20260602050131.856789-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602050131.856789-1-rosenp@gmail.com>
References: <20260602050131.856789-1-rosenp@gmail.com>
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
 drivers/gpio/gpio-ppc44x.c | 82 +++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 46 deletions(-)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index b30ca357ab74..6b4814ed12b5 100644
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
@@ -45,9 +44,8 @@ struct ppc4xx_gpio {
 };
 
 struct ppc4xx_gpio_chip {
-	struct gpio_chip gc;
+	struct gpio_generic_chip chip;
 	void __iomem *regs;
-	spinlock_t lock;
 };
 
 /*
@@ -56,55 +54,35 @@ struct ppc4xx_gpio_chip {
  * There are a maximum of 32 gpios in each gpio controller.
  */
 
-static int ppc4xx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
-{
-	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
-	struct ppc4xx_gpio __iomem *regs = chip->regs;
-
-	return !!(in_be32(&regs->ir) & GPIO_MASK(gpio));
-}
-
 static inline void
 __ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
-	struct ppc4xx_gpio __iomem *regs = chip->regs;
+	struct gpio_generic_chip *gen_gc = &chip->chip;
 
 	if (val)
-		setbits32(&regs->or, GPIO_MASK(gpio));
+		gen_gc->sdata |= GPIO_MASK(gpio);
 	else
-		clrbits32(&regs->or, GPIO_MASK(gpio));
-}
+		gen_gc->sdata &= ~GPIO_MASK(gpio);
 
-static int ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
-{
-	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
-	unsigned long flags;
-
-	spin_lock_irqsave(&chip->lock, flags);
-
-	__ppc4xx_gpio_set(gc, gpio, val);
-
-	spin_unlock_irqrestore(&chip->lock, flags);
-
-	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
-
-	return 0;
+	gpio_generic_write_reg(gen_gc, gen_gc->reg_set, gen_gc->sdata);
 }
 
 static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
+	struct gpio_generic_chip *gen_gc = &chip->chip;
 	struct ppc4xx_gpio __iomem *regs = chip->regs;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	gpio_generic_chip_lock_irqsave(gen_gc, flags);
 
 	/* Disable open-drain function */
 	clrbits32(&regs->odr, GPIO_MASK(gpio));
 
 	/* Float the pin */
 	clrbits32(&regs->tcr, GPIO_MASK(gpio));
+	gen_gc->sdir &= ~GPIO_MASK(gpio);
 
 	/* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
 	if (gpio < 16) {
@@ -115,7 +93,7 @@ static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
 	}
 
-	spin_unlock_irqrestore(&chip->lock, flags);
+	gpio_generic_chip_unlock_irqrestore(gen_gc, flags);
 
 	return 0;
 }
@@ -124,10 +102,11 @@ static int
 ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
+	struct gpio_generic_chip *gen_gc = &chip->chip;
 	struct ppc4xx_gpio __iomem *regs = chip->regs;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	gpio_generic_chip_lock_irqsave(gen_gc, flags);
 
 	/* First set initial value */
 	__ppc4xx_gpio_set(gc, gpio, val);
@@ -137,6 +116,7 @@ ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 
 	/* Drive the pin */
 	setbits32(&regs->tcr, GPIO_MASK(gpio));
+	gen_gc->sdir |= GPIO_MASK(gpio);
 
 	/* Bits 0-15 use TSRL, bits 16-31 use TSRH */
 	if (gpio < 16) {
@@ -147,7 +127,7 @@ ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
 	}
 
-	spin_unlock_irqrestore(&chip->lock, flags);
+	gpio_generic_chip_unlock_irqrestore(gen_gc, flags);
 
 	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
 
@@ -159,33 +139,43 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = dev->of_node;
 	struct ppc4xx_gpio_chip *chip;
+	struct gpio_generic_chip_config config;
 	struct gpio_chip *gc;
+	struct ppc4xx_gpio __iomem *regs;
+	int ret;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	spin_lock_init(&chip->lock);
-
-	gc = &chip->gc;
+	chip->regs = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(chip->regs))
+		return PTR_ERR(chip->regs);
 
-	gc->parent = dev;
+	regs = chip->regs;
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
 	gc->fwnode = dev_fwnode(dev);
-	gc->base = -1;
-	gc->ngpio = 32;
 	gc->direction_input = ppc4xx_gpio_dir_in;
 	gc->direction_output = ppc4xx_gpio_dir_out;
-	gc->get = ppc4xx_gpio_get;
-	gc->set = ppc4xx_gpio_set;
 
 	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
 	if (!gc->label)
 		return -ENOMEM;
 
-	chip->regs = devm_platform_ioremap_resource(ofdev, 0);
-	if (IS_ERR(chip->regs))
-		return PTR_ERR(chip->regs);
-
 	return devm_gpiochip_add_data(dev, gc, chip);
 }
 
-- 
2.54.0


