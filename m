Return-Path: <linuxppc-dev+bounces-25302-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79786C55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 22:36:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDWjR43QKz3c2H;
	Tue, 04 Aug 2026 08:35:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785796555;
	cv=none; b=bztRT5cOaFhxr2DVVsGLfdNoDOYU2Nxyj0mdqT9LaC+jl53E+7cOtfnlvbSKwB2bRVzGQg8sLqwJ+Lz+e6papuB5LAi7YdSQGPhE4hCfkQOi5jog/DdIkt0KVBoT7yWZOVc00fu6+ANd59/dHCBU47rFoqvK0JgZ+LEZcyG+/Pih5JJL8Cyq84SbZzvh4f/qy/AONTLPf+wIe7lzAZT39Jospitu02NcvP6UT2Hv2kyqIZ8AtZx3pDkkT4xM8JaXVpO+ZjXum8LbmZLbocWy9JElEdg9QlS/HBIfYH43Dtr/fy4WX+rvrz7npu4BF3T6GPFoR3ymtCaOMdZUwFlHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785796555; c=relaxed/relaxed;
	bh=lbBGsHmjF0IK9Yh+6sVuwiAAB5BmdDbimGNjiC3VIVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSNHuBWbU7sYDXgFXMQUeskS9nOb/8mj5K9U8VZ1f4ABPBczqG3c0KAzTNpDjDKaVnvgm90zKoi8GXXjqhwfh9MBz0tMhuw+ALFLhN6lJUyVQUkYZxRBSSqo51yv2d26pYRIcXnkiUmOKmU31BtVX1mYKJDkJaGj0O3uZMNcVViBYGVpcRhYQokLbXOHhiHii434RFoCkI8rdgED2EqISf1uw7x36Kvq1EHP++ToQ/qYLcvLh+qp66u7/me1SL9PRjUNUI1BK7hHbQbwTK7Rb5FIYo/Rs69EsgmyMqOaxMsjAnWCssJMUx88xUCbg0ilEJZQtrajkZMaFCr/jKPO0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qda+sHwD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qda+sHwD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDWjQ6cx2z3c01
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 08:35:54 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso2241629a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796553; x=1786401353; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbBGsHmjF0IK9Yh+6sVuwiAAB5BmdDbimGNjiC3VIVI=;
        b=qda+sHwD1YYmD5S+tB4x/M8/AK0e61uiM4tzWe7XHJI30tcL5raoR9sOpqYi2hE8yL
         TJJFxquKV6XrjwoADusmWpM4wQ6RTLHfL67QsvR0oirw5J1yked4Nze2jLMElLMr4ym3
         o3j3ajVwMPbMUMkH4gyX3aQoBDKFyoauMOjQ4W1zq0/NfYkF93YBqGNQWvaB/5fN6+x+
         CBrI6FZX2QU40wK9y9lXJADIi59y20g2Ri1NQbWl09GbbaGfIo4QMd7vDJZW66KZmZL4
         U+X3JRLdLclJSvSohFe9zOFbHpWOBXzcEkJhKWgFeWRZWS2NCQVODooMqo4rdFPjV3Yf
         tT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796553; x=1786401353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lbBGsHmjF0IK9Yh+6sVuwiAAB5BmdDbimGNjiC3VIVI=;
        b=Z4ZR0Bpy2yLPcR6ortGw11Iu3Z88t/CtGGVHI5SBaCNuUjdoCnMnYxLuKxCgYMerzg
         bDok6NAkqQshQiolxqXKhAs8bgPa2sm42cyozGBBPKN6NLnwVNLZshqcgQmYM76WQ2pC
         Ws6/DukY4IBYDEZnTVl8oLX5znQOvbIqh5LMYs/iGU5iPnndkkThr6zST6h06aFETrlT
         Nd3zQpR6wuUwm2PvXIILPW7anvq1EnfgfYUGSEfKRgNTYB0ide2EDKm9FrEeIyr4MFsN
         eP9xgAZCQRFcKZEngeA1YflE7p7rDbBI0wqZZ6vtUE0x38nPeQ/a0Qi+snNUKRseQym0
         ovXA==
X-Forwarded-Encrypted: i=1; AHgh+RrThyB4wS7QIDPp7tFTb3RvcUQDbQZCdd9bgwQqehVUbwug83R6XXrOc1hkLvjWlDNJ3KfRjzifAxEr/5k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2aAGDpJDDOgCtTLiPIFDYWIzPVGElryYmBNtU8/Q++GGQe3+N
	ZSlDuYTXaDqpBqX4VNrmlucPDr3eJnsfjxoPYh0s4mdbrqx92Pu+A0In
X-Gm-Gg: AR+sD100OVl+5UFjWwe70bMns/kqrUoBfHqT4wRy9ORJf/0E0EFQJkrTgV8Rqvz1kOi
	c8+JSJ07pXzsEwk8ArDAIBzvs1v04HYDLZTRkgF79dMjpFmoly9TF0JEidPRCfWmGtwdP5E82kZ
	TKWRDDw4bNSSV5eUP1m7lhoxH0EO1JobLSaXisuW8D4PlfihvGNGOo9HbMXr9VtOtprAoeWRaJl
	pqODRo5bu8nRcqobmIhkd+8hTfU0qsBQNbbrhImzXg5h6VJPez6YR9dUJkQoS/F36hDAY4elWEU
	oxOd0tbn81d0WGg5CwutxZZpdnOJSxJ8sFBRoJyfFGrVQohbKsb26bHyDFkkhOPa4yj4XouIPB7
	jytMhC7MATzTc7SKm0ushwdiYr86+L/eF/nCT316wzntHjAo6XFKu3qojl7P/bfBAKh+PsGiq3Q
	ehg2wawmRHTI2KchUOZUpIizzMA70jxxRl1viWMQix/DDsAxdQZv3bAmyiZxp2Wv8gL8p2vZurI
	lz6yAtr6H1YrzdMn981Rd8mg8ghXhNewnedtFq3FWzLD5wkK7Q1Gtsd660IjTEU4zt+GFAXxkOT
	HxiUj3IznEAA4K4dVQnfwfErNZgO6Ur3UpfkmQ==
X-Received: by 2002:a05:6a00:2e2a:b0:848:75b5:1dd4 with SMTP id d2e1a72fcca58-84ee498e2aemr10577218b3a.59.1785796552950;
        Mon, 03 Aug 2026 15:35:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm4186790b3a.40.2026.08.03.15.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:35:52 -0700 (PDT)
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
Subject: [PATCHv2 6/8] gpio: ppc44x: drop PPC-specific IO helpers
Date: Mon,  3 Aug 2026 15:35:37 -0700
Message-ID: <20260803223539.86303-7-rosenp@gmail.com>
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

Replace PPC-specific clrbits32()/setbits32() with local helpers using
ioread32be()/iowrite32be() which are equivalent on PPC since commit
894fa235eb4c ("powerpc: inline iomap accessors").

Add COMPILE_TEST as a result to increase compile coverage.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/Kconfig       |  2 +-
 drivers/gpio/gpio-ppc44x.c | 40 ++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 15fd5874f4ea..0e021af4e81e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -595,7 +595,7 @@ config GPIO_POLARFIRE_SOC
 
 config GPIO_PPC44X
 	tristate "PPC44x GPIO support"
-	depends on 44x
+	depends on 44x || COMPILE_TEST
 	select GPIO_GENERIC
 	help
 	  Enable gpiolib support for ppc440 based boards.
diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index d9048452162a..fd543fbb959a 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -48,6 +48,22 @@ struct ppc44x_gpio_chip {
 	void __iomem *regs;
 };
 
+static inline void ppc44x_clrbits32(void __iomem *addr, u32 mask)
+{
+	u32 val = ioread32be(addr);
+
+	val &= ~mask;
+	iowrite32be(val, addr);
+}
+
+static inline void ppc44x_setbits32(void __iomem *addr, u32 mask)
+{
+	u32 val = ioread32be(addr);
+
+	val |= mask;
+	iowrite32be(val, addr);
+}
+
 /*
  * GPIO LIB API implementation for GPIOs
  *
@@ -77,19 +93,19 @@ static int ppc44x_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	guard(gpio_generic_lock_irqsave)(gen_gc);
 
 	/* Disable open-drain function */
-	clrbits32(&regs->odr, GPIO_MASK(gpio));
+	ppc44x_clrbits32(&regs->odr, GPIO_MASK(gpio));
 
 	/* Float the pin */
-	clrbits32(&regs->tcr, GPIO_MASK(gpio));
+	ppc44x_clrbits32(&regs->tcr, GPIO_MASK(gpio));
 	gen_gc->sdir &= ~GPIO_MASK(gpio);
 
 	/* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
 	if (gpio < 16) {
-		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->osrl, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
 	} else {
-		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->osrh, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
 	}
 
 	return 0;
@@ -108,19 +124,19 @@ ppc44x_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	__ppc44x_gpio_set(gc, gpio, val);
 
 	/* Disable open-drain function */
-	clrbits32(&regs->odr, GPIO_MASK(gpio));
+	ppc44x_clrbits32(&regs->odr, GPIO_MASK(gpio));
 
 	/* Drive the pin */
-	setbits32(&regs->tcr, GPIO_MASK(gpio));
+	ppc44x_setbits32(&regs->tcr, GPIO_MASK(gpio));
 	gen_gc->sdir |= GPIO_MASK(gpio);
 
 	/* Bits 0-15 use TSRL, bits 16-31 use TSRH */
 	if (gpio < 16) {
-		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->osrl, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
 	} else {
-		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
-		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->osrh, GPIO_MASK2(gpio));
+		ppc44x_clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
 	}
 
 	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
-- 
2.55.0


