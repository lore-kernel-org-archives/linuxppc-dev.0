Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18792606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=syuMhgWr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYVyc1SYGz2xf8;
	Tue, 24 Nov 2026 16:01:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795496488;
	cv=none; b=E5w3g6XTayCU548P9g0zNioEsnCd2Peq/5dWEnR6UNn+zu62fLiR8ptyUkeSM9vgdfjpdIWqe4c92r9QPsWIbga2F41rFEVRGlO6lqaLxyVnwKeHLxLjfwIf6CTVcsqAsgf2GtFEHGd24rhtRtOWl9NE07KV4m/hAY5JuhtRIfq+qVa65bwR7oxJzetuh01r4/y4XpdkRXrsn6xutwJXazLEv2lVgJ0sHUTzCRzGSNJkA8Wztc7iwvpxa0UhscCNBobyzpM93Wi7oIG6rMyjysAcmx2PWYXamHbv6YrIylqe9A/LIFkKcqjpkYb+e0XEvuY4+PoFsxKwyWImKOi6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795496488; c=relaxed/relaxed;
	bh=Vs2X3vFXBgQuWTNtNhfJh5Gfnrco9rGsYZYJIbU5LNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EU41GFKuRKQv2EGFE7tvsSxi3vL0QUcxclKkt1mF1hjBapaElaTYWypscqeF0GsJKezsfuzj2mTeEuk1bqKhTIhFWrAaTANkenz5mkMJ0GhpZ2SSSmaXLZBMbYxzf7QT4UZcBbJDLlDibB/z6jkV5+4w7rvxWWwgyISMNQZUZU86tEU6Qcro270LfMrUdFQEOOaIV9qyc24WzAMUpBRbMe7KxawQbAqErLO8DVRyYzYRYDY1JessRhEcyyFd5sdLbw8yGGpyDWjT+doUlu1egMKNok9Ik/3v/wkwNwCqpJz874P5DTDA4eY+jUJ1+j+gDHZWaEgIfx+JJ64uly+AYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=syuMhgWr; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=syuMhgWr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYVyZ5wfYz2yLF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 16:01:26 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so42602745e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 21:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795496483; x=1796101283; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vs2X3vFXBgQuWTNtNhfJh5Gfnrco9rGsYZYJIbU5LNg=;
        b=syuMhgWrp9mMa0qTrWlZIguUnRsivTxvXd/jpdF5aKr/eIMADYnL8EEGmb5WlxUWGn
         WSNlp/HYjDuJVKSScoy7HAIZa929pISiToA7HjpXosdmiwm9fKiVmfKU1kX73E0UHjD0
         Sjd4403v6VBvIT5x0k+jkuv0KrLFXwCCTm3QmFv4V8GgJJiDOwrSR05NTAAXK7EDwfHQ
         0lDH6NFX2cL59+Gy57n00/9HH4pIRY5txyPxSfhxXPcGSV84xjdSXRLcYrn3RmnVzz1I
         u0NIsGVzh7j0630OrbUKsksrqWE/QywUpeBSLZSZ/iQJtE2IKbWF2Xt0pe08xk81B/gw
         6p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795496483; x=1796101283;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vs2X3vFXBgQuWTNtNhfJh5Gfnrco9rGsYZYJIbU5LNg=;
        b=1UWR1whuGWYLfhPv0sBK8WI4ecz4qC0qUv1X9Z9BqjsZV4fk5rZBu6dVLwpay1L41U
         suhtxMT/cT4/Ff8/SZm7uW9azftfg2AjaCwQL56RQ13P8PM+u7z53AC515WTfwV0CXnv
         rYSBeCXqYn10+Tvw2aYZi5WqwlWKFByrDLKPwfHCVZhBZN4CPZtMSyhX3sMEAMHb9sAZ
         pxdHzIhSmNQKNw1Vm1sFlZ4js6LkN02F4CC03+tDkazaari0TZ85wKzbheHvR+woMrwY
         cAvM8/ezCMgRlpLzLZ2CVAjwtqAQ9ca0WGDauKD3X8HRuNI2Ct9pofdLS2gHtYJ7NaTJ
         jImg==
X-Forwarded-Encrypted: i=1; AL+hErEWKAyjz5G93Ge9CkNJdHdhtQqTNn+8Qugb8WYqF/bhY/C7+zQjATlY+i8G7fSY4niQBrhQUk8xz9n7A/g=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9gySWrYEkH6vA1gZO4YilFhmIS/6iCUtyKTGgukwIOMe+JRjNk
	wDjKl1qKeIXOLNjfbpqFzAKA1PMuK73a15oM8oj/Tl92aKQ3NdZRepg7
X-Gm-Gg: AZFdTZcKAaWrn4h6JfRFIvIGgN863UcWZwPewPQ1bMBKi8OH0R4puEX7+rQRqhJhy16
	OGGlYsgBAUHB37QL68Qczq1F6p1PKyGfymJWgzm1Svol/ZKVYKISdCTb3AbRskgOseVesj2krBc
	AWijejdXR9Ni4V+uq8aTjYNLrbH8mov1VdPBjDNMBo+h1haJCEubkISEXgWxfodqDNqaml35IRg
	LQBLesP3frjulcmUSHFyMtmRjdmCP/zRsXMWA2f+unsvYYh74XZQ76I6nwUl4/DFWus2BczQJ2e
	WKSBD6Gmft2sG+wWTOd/vlJyUgUZXpvdavmKoxCclJNWM16V2Z+VouCkRt9DTAarLrj/T01cWtl
	OZXXnoJC8lrGZ7329mWU6ikT5MlZi2q5e0j9U3BPZ8i1SGjBP/Knbm1eldWQ8ObUKSJv7G8JMx5
	qBuDi7YfvExTboiuhIjqHITZYSLwgznKXvc3PHtNd7OtP+UUDR4h3QlBVF3yH1ybra2coFjOCou
	6vJPpAo1SLWOQJxcv5OmOZKmFWXmN0CG+RjgjKDGRs2ielbEAGKRSpWC1R7U8nyfYzhJg6rIsMc
	Zse+c+w4O2gnVKKoEGmQQEEnhJVClGtxJOSnluog9BVry6Kzvv0BozugYj9BCNj+mD4v7BvqgVg
	2WAAqS55Fkz6iE/hHAnP6ifhibF30ogbFQ/+H4G9btVsw8nCVRjJkDZ6AmE1oMjmCHF4GUnUUVr
	dm6OnrMW1UmwCU7yPQP87N6tUa2g7GBbFeRXkCXQGY/8h2X4nDHUf+
X-Received: by 2002:a05:600c:4515:b0:4bb:659c:b8db with SMTP id 5b1f17b1804b1-4bb88813b27mr278328245e9.12.1795496483167;
        Mon, 23 Nov 2026 21:01:23 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f512-85ee-fdbe-0621.ipv6.o2.cz. [2a00:1028:8388:a84e:f512:85ee:fdbe:621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm353489155e9.1.2026.11.23.21.01.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 21:01:22 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] watchdog: max63xx_wdt: Add support for specifying WDI logic via GPIO
Date: Tue, 24 Nov 2026 06:01:17 +0100
Message-ID: <20261124050118.87944-3-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
References: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pali Rohár <pali@kernel.org>

On some boards the WDI (watchdog input) pin of the chip is connected to
a GPIO, and only the SET pins are mapped to the register.

Take the GPIO from the optional wdi-gpios property. When it is present,
ping the watchdog through it instead of the register.

Signed-off-by: Pali Rohár <pali@kernel.org>
[pepe.schlehofer@gmail.com: use wdi-gpios, request the GPIO as an output
 with devm_gpiod_get_optional(), ping without the lock, include
 linux/delay.h, update the header comment]
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---

Notes:
    Changes in v4:
    - take the GPIO from wdi-gpios
    - request it with devm_gpiod_get_optional() (Tzung-Bi) and
      GPIOD_OUT_LOW. v3 passed GPIOD_FLAGS_BIT_DIR_OUT alone, which sets
      no direction
    - ping without the lock, with gpiod_set_value_cansleep() (Tzung-Bi,
      Guenter)
    - include linux/delay.h (Tzung-Bi)
    - print the error once (Tzung-Bi)
    - say in the commit message that the GPIO replaces the register for
      the ping (Tzung-Bi)
    - update the comment at the top of the file
    
    Changes in v3:
    * Use gpiod_set_value()
    Changes in v2:
    * Usage of dev_err_probe()
    * Fixing assignment of wdt->ping
    * Remove clearing of wdt->gpio_wdi
    * Move YAML change to separate patch

 drivers/watchdog/max63xx_wdt.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 9e46b86b9b20..482cf9f6bd6e 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -7,8 +7,9 @@
  * Copyright (C) 2009 Marc Zyngier <maz@misterjones.org>
  *
  * This driver assumes the watchdog pins are memory mapped (as it is
- * the case for the Arcom Zeus). Should it be connected over GPIOs or
- * another interface, some abstraction will have to be introduced.
+ * the case for the Arcom Zeus). The WDI pin can be connected to a GPIO
+ * instead. Should the other pins be connected over GPIOs or another
+ * interface, some abstraction will have to be introduced.
  */
 
 #include <linux/err.h>
@@ -18,6 +19,8 @@
 #include <linux/kernel.h>
 #include <linux/watchdog.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
@@ -50,6 +53,9 @@ struct max63xx_wdt {
 	void __iomem *base;
 	spinlock_t lock;
 
+	/* optional GPIO connected to the WDI pin */
+	struct gpio_desc *gpio_wdi;
+
 	/* WDI and WSET bits write access routines */
 	void (*ping)(struct max63xx_wdt *wdt);
 	void (*set)(struct max63xx_wdt *wdt, u8 set);
@@ -155,6 +161,13 @@ static const struct watchdog_info max63xx_wdt_info = {
 	.identity = "max63xx Watchdog",
 };
 
+static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
+{
+	gpiod_set_value_cansleep(wdt->gpio_wdi, 1);
+	udelay(1);
+	gpiod_set_value_cansleep(wdt->gpio_wdi, 0);
+}
+
 static void max63xx_mmap_ping(struct max63xx_wdt *wdt)
 {
 	u8 val;
@@ -226,6 +239,13 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	wdt->gpio_wdi = devm_gpiod_get_optional(dev, "wdi", GPIOD_OUT_LOW);
+	if (IS_ERR(wdt->gpio_wdi))
+		return dev_err_probe(dev, PTR_ERR(wdt->gpio_wdi),
+				     "failed to get the WDI GPIO\n");
+	if (wdt->gpio_wdi)
+		wdt->ping = max63xx_gpio_ping;
+
 	platform_set_drvdata(pdev, &wdt->wdd);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
-- 
2.54.0 (Apple Git-157)


