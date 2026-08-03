Return-Path: <linuxppc-dev+bounces-25298-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A76FC55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 22:36:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDWjJ5JXqz3bh4;
	Tue, 04 Aug 2026 08:35:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785796548;
	cv=none; b=BpEoLmTb2t7Jjp74d+KGPM53N8hMNhkvegkCJ8MkeK308jTIy6GI5HdCD7xuJUPSNrT3HmkmO8fgKjHF0Qg6mAXdtdGcIb8a1wIiqQkEmoACL9Me6rMM6EVHTnxyZwnbw+8758LGHIPy6YGKpI5Fr/kNGEXbiOIhBJ/TbfH4b1VDHOT64gsxFATmjkgpo3Lr6u413/WzNEXAgbkjvhInWqUH8fz0QCDAqcYLZOLZVFPXvYa/osysim1ylplKUSD5RxIhYoXPzDkx+zoPliZ8bTRxX3lzWqBlbBXkg0vqJhk74EizLZ/stIedy0GFz5DXTAE73KUrMRYwLkPa56vOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785796548; c=relaxed/relaxed;
	bh=Ss+09hjpJaeSuKJ0JJOS5roXbCAiuY8R6iPoMwWLO6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpXKij1eUL9/4vA1f9SA0OMZhfJ6StSA+4Xmz+y2W7VSbkxcghFqTEGSKwjufosKDOA1vb1aBxV+KaqYGgq6b6TBbGHogNBw3/nmMbcvh2MgeC+E8AVN19nBJdD3FBzsAlqzEfp4qEdMREv1v0epBVtc38MZaVwxF0+TtHklxUEeUunyglWRpd1VR+ubKeKI0rBCZfDHiHRBnJvipJLJ4VhtejkAjpyWmQu+Of5ydQzcvn+xtZPmxbs0CmET7zc3UQMEVWuPq1gZ6XCy38PQUEZQddPzTdUuYuRLeMJWVM3vRMq5VgwB7JVQdQFSV6utBzXIayXxOwNwPgbM2mD7CA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MU8rAA4G; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MU8rAA4G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDWjH4ksbz304x
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 08:35:47 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-8453427d3f4so4305058b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796545; x=1786401345; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ss+09hjpJaeSuKJ0JJOS5roXbCAiuY8R6iPoMwWLO6I=;
        b=MU8rAA4GcJiTmNirRiNhPzeXh/oB3ZCQ9VRZzb5vW6am6mwigQHEDI1sE49mz5SnhC
         5JtUtK9J5tJ7VWqntCDum8hkUDcmWbICPhKfs+1hdF6UXQtn3RtpbKZkamGLDoDNjWGr
         y7jQtg3SG9DAnGPv1UXcrLEscfV867jesKEeAbxjq/Ub7frJq4XBf7TXBaL7ksUcDN9R
         N4EGy0I1/i5kF7yj05jxDQf1oVjBBxoG6/XkudtmsgP6cdZv8TGR4JLvRKfin1kjZkpA
         l8Af1URbedo6Wb1oj1fagJ1m6/ie7qOh250V9CAZz/+0FClgMebqYBbVBfP2X19V4bj1
         7c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796545; x=1786401345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ss+09hjpJaeSuKJ0JJOS5roXbCAiuY8R6iPoMwWLO6I=;
        b=ijpBtDfOmTwsuNjxgG94tn5R578PtOZox9mlZAdMstdwAuHY4A1o1BPmUog8YbclDB
         gUWuBCiyUK+n9brZMOtMeKj5BncWSWBQ5V6+LAEQpIpkQZQ2cpEkwe4EH9TGqLQQQWlV
         fbn3woSAed5nR+m3o8bmwV3MGCZ+ODohgufRMnzznM3ewDG/v7HvSsde7IVHj77gxuQG
         MJFg8lcHSHdxAtM0Ly+vb5NYW0BjeJi773ACNOG5KZp00Pc9wGBgnTBle912Ek0RVsmh
         eLzhhbZF8SF3I/cuXaY0/FFsTlSMjUZTGkDq89a/PmmT3ARk+p1GCNwXYtopPO47H1C2
         WaLQ==
X-Forwarded-Encrypted: i=1; AHgh+Roiatox3GBBBACyVbtYAx/qAEinvuImOWGuTfLTEvruLkBEgujHbZJNDjyVh0qTILXMYJgXtwtHAGPBSOk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0A7FwQNftIr7kzJDIhgMS0B+aCzhHtePivmlfRr7/bCBtt2X3
	SVnx2l+ZXwxmkYrcGKtPnexcya89i6BllCJ3JXX26NqEDPz/98TQGlez
X-Gm-Gg: AR+sD12YDzN/jt/tI3FLBOsI4u/HIhgnWcWN1ghH9/RHfSbco35qsVAVaqT+be09nXu
	issinqfRGBYSXsbypdtYFaPH1KR7o2isHsxpRdYjJ2F6brxXtKemO0UC+NkZbsk6QN72lMUPAvm
	psoekhivwxUPBqdOMRibZli/56w0UIo9M8AX4Wxg+Co9x4V40WD0zB9S4nXceJWpH7NcWhr38Fh
	sL65Q0sl85QOVjKzVjzvMJp3rZyDDOj78XR0PKeKm8wJId+WepD6xtmQ9eFMRM8bw3DyTZyuRjR
	L2bv4LybBekQ8pAjyMX21FCwqOxO7stdwmTOb+5sq/yF19G6U9cPfE6HyeGUHV4ZN4hm5oPlq/F
	qJpMCrM2yR857THuE36EpB+8+g7G0b4g6W3mFnOPHnKAITwTGCW4KAtvbxaGcbFH4xdZEL1g1+Y
	ZJxJuNySP6E2dDdPL8BV2qPEoEJbORD4fseWlRtvhM2TRiQedkCSz2G+pf8c1hC6CMU567wSkkM
	q6dC/EzddHQcxLFUesSUAsHV4bXMT1iMX3XwlGREL6x1jO2BduU0MSUOg/ACrgPNsiYEz9cpaLk
	ERyps4hjcrbpABvoQVaJVa2Rqy/3EmvKvTzAhA==
X-Received: by 2002:a05:6a00:3e2a:b0:848:42c4:d8c7 with SMTP id d2e1a72fcca58-84ee4969580mr10402690b3a.66.1785796545052;
        Mon, 03 Aug 2026 15:35:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm4186790b3a.40.2026.08.03.15.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:35:44 -0700 (PDT)
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
Subject: [PATCHv2 2/8] gpio: ppc44x: update all 4xx to 44x
Date: Mon,  3 Aug 2026 15:35:33 -0700
Message-ID: <20260803223539.86303-3-rosenp@gmail.com>
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

The kernel lost support for 4xx platforms and now only supports 44x.
Since this driver is being moved to drivers/gpio/ , take the opportunity
to modernize the name.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ppc44x.c | 68 +++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index 4413a94cf7a6..9b874ff8b124 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * PPC4xx gpio driver
+ * PPC44x gpio driver
  *
  * Copyright (c) 2008 Harris Corporation
  * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
@@ -23,7 +23,7 @@
 #define GPIO_MASK2(gpio)	(0xc0000000 >> ((gpio) * 2))
 
 /* Physical GPIO register layout */
-struct ppc4xx_gpio {
+struct ppc44x_gpio {
 	__be32 or;
 	__be32 tcr;
 	__be32 osrl;
@@ -44,7 +44,7 @@ struct ppc4xx_gpio {
 	__be32 isr3h;
 };
 
-struct ppc4xx_gpio_chip {
+struct ppc44x_gpio_chip {
 	struct gpio_chip gc;
 	void __iomem *regs;
 	spinlock_t lock;
@@ -56,19 +56,19 @@ struct ppc4xx_gpio_chip {
  * There are a maximum of 32 gpios in each gpio controller.
  */
 
-static int ppc4xx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+static int ppc44x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
-	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
-	struct ppc4xx_gpio __iomem *regs = chip->regs;
+	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
+	struct ppc44x_gpio __iomem *regs = chip->regs;
 
 	return !!(in_be32(&regs->ir) & GPIO_MASK(gpio));
 }
 
 static inline void
-__ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+__ppc44x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
-	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
-	struct ppc4xx_gpio __iomem *regs = chip->regs;
+	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
+	struct ppc44x_gpio __iomem *regs = chip->regs;
 
 	if (val)
 		setbits32(&regs->or, GPIO_MASK(gpio));
@@ -76,14 +76,14 @@ __ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 		clrbits32(&regs->or, GPIO_MASK(gpio));
 }
 
-static int ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+static int ppc44x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
-	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
+	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
 
-	__ppc4xx_gpio_set(gc, gpio, val);
+	__ppc44x_gpio_set(gc, gpio, val);
 
 	spin_unlock_irqrestore(&chip->lock, flags);
 
@@ -92,10 +92,10 @@ static int ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
-static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+static int ppc44x_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
-	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
-	struct ppc4xx_gpio __iomem *regs = chip->regs;
+	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
+	struct ppc44x_gpio __iomem *regs = chip->regs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
@@ -121,16 +121,16 @@ static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 }
 
 static int
-ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+ppc44x_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
-	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
-	struct ppc4xx_gpio __iomem *regs = chip->regs;
+	struct ppc44x_gpio_chip *chip = gpiochip_get_data(gc);
+	struct ppc44x_gpio __iomem *regs = chip->regs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
 
 	/* First set initial value */
-	__ppc4xx_gpio_set(gc, gpio, val);
+	__ppc44x_gpio_set(gc, gpio, val);
 
 	/* Disable open-drain function */
 	clrbits32(&regs->odr, GPIO_MASK(gpio));
@@ -154,11 +154,11 @@ ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
-static int ppc4xx_gpio_probe(struct platform_device *ofdev)
+static int ppc44x_gpio_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = dev->of_node;
-	struct ppc4xx_gpio_chip *chip;
+	struct ppc44x_gpio_chip *chip;
 	struct gpio_chip *gc;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
@@ -172,10 +172,10 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
 	gc->parent = dev;
 	gc->base = -1;
 	gc->ngpio = 32;
-	gc->direction_input = ppc4xx_gpio_dir_in;
-	gc->direction_output = ppc4xx_gpio_dir_out;
-	gc->get = ppc4xx_gpio_get;
-	gc->set = ppc4xx_gpio_set;
+	gc->direction_input = ppc44x_gpio_dir_in;
+	gc->direction_output = ppc44x_gpio_dir_out;
+	gc->get = ppc44x_gpio_get;
+	gc->set = ppc44x_gpio_set;
 
 	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
 	if (!gc->label)
@@ -188,24 +188,24 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
 	return devm_gpiochip_add_data(dev, gc, chip);
 }
 
-static const struct of_device_id ppc4xx_gpio_match[] = {
+static const struct of_device_id ppc44x_gpio_match[] = {
 	{
 		.compatible = "ibm,ppc4xx-gpio",
 	},
 	{},
 };
-MODULE_DEVICE_TABLE(of, ppc4xx_gpio_match);
+MODULE_DEVICE_TABLE(of, ppc44x_gpio_match);
 
-static struct platform_driver ppc4xx_gpio_driver = {
-	.probe		= ppc4xx_gpio_probe,
+static struct platform_driver ppc44x_gpio_driver = {
+	.probe		= ppc44x_gpio_probe,
 	.driver		= {
-		.name	= "ppc4xx-gpio",
-		.of_match_table	= ppc4xx_gpio_match,
+		.name	= "ppc44x-gpio",
+		.of_match_table	= ppc44x_gpio_match,
 	},
 };
 
-static int __init ppc4xx_gpio_init(void)
+static int __init ppc44x_gpio_init(void)
 {
-	return platform_driver_register(&ppc4xx_gpio_driver);
+	return platform_driver_register(&ppc44x_gpio_driver);
 }
-arch_initcall(ppc4xx_gpio_init);
+arch_initcall(ppc44x_gpio_init);
-- 
2.55.0


