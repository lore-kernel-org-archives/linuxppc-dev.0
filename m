Return-Path: <linuxppc-dev+bounces-25299-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212C9C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 22:36:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDWjK4lxKz3brH;
	Tue, 04 Aug 2026 08:35:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785796549;
	cv=none; b=SWZ7N5UWTdIlV9gGwWQJXXfUWYOeR5Eyyp4A0N+X7HqNzf8Fb2Cu9zdnkUHgr6Xyd+IaBjHV2iH69I6Vd/c1+pFBMRzEl9JmCCDHii/IzcrHkWihkjWwHPkWN6dOiqyMq1snNJv35WEIPWA6cT6tvJ0zZz46iiKP1e+sewDJvSDCmgBQQILycEdCB+mB4Kl3vKKeZaM4skhuGQD96QXrXbw++bTgDRTDzEv26LScAEdZ9J04Uksz8IxE2WUsT7/Ay0mC7+381VZfzwd1hTZWK1YJwRobPC5amVxvxOlanp0J+DNBohuOoO4FwEOZndT733d0xqYJ4dCsXm2iGISyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785796549; c=relaxed/relaxed;
	bh=+dXpnyUMT81EKJBXnNMHRmhaDilXzipQAqbMBWXRrrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cg+t7aH96CJertnXSdknFTSjX7CPqecpzAGa5+HAiEQWk/7ns04Mu5idVY4rLKNZXkGrW7CySQJCIt7F9R269OYo5E7DCcVXgPj6vx2x0sM0obxisJBr6zfEIVvyg/PWbdWoOVvuZZpkS5yOCA/2UZtMeWnEqdNaAl/Yo9+IbE3a0BmylxgOFPQ8oWw7AH+sIdYodoCMUnPoXUX6poAccKwE8NWnU3yZbk2eu1jmh5O1Raky5L4y80Aoyl4HT99Z+aOU5+0Z3aR5sPKBwF4di7qlPxVVBci6BoAPmwtZDN5rwkbUyYk44ip0+b9dUSwVyWarMqpyLozy1htwCAcUrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q+2eYDoy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q+2eYDoy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDWjJ6HGLz3bp7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 08:35:48 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8487088510aso4059857b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796547; x=1786401347; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dXpnyUMT81EKJBXnNMHRmhaDilXzipQAqbMBWXRrrs=;
        b=q+2eYDoygxNtZMbSRTVLebtUoHMCfqe+KuTA63HDn8VhMpuR9UQh8WTIMTYH5A4UP8
         HRNgjZNgfs1aG43XHepQEiIsuRD/3bpn9IoynDUurvQxhNekO1jm2ucfz8L+ebfdO51R
         EVyUAi2M9PdD3J838eTvLQhrMATJvyvWWcw0oZBthjUxz65SJfaAor8T9CUlv1UxFAkg
         0Rtu0U+oCfVYGzY9qqSYlbkyFP81VTlUHJQeB9uKArJjVLYuODdFO4sx6BKThPb3jWEq
         la9Z9mFsOYuhdaGFeiyWGI0LkskvLTNd0ofcwnBzqWSL351DNeUexZVW12XGuhANLD1G
         2Sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796547; x=1786401347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+dXpnyUMT81EKJBXnNMHRmhaDilXzipQAqbMBWXRrrs=;
        b=e2++yvoL+PIk+VyEUNZWKQBLBONKvAQ/XiIo64WkBWXPDDqvln2OMrljzXCIOA7esK
         qUyRhqOKmVfpLReHkZQtPQPe/mhKyEsV2ohP36nKOqpbaB40eAWcc9eMXd9DT5mkei+4
         JL7wc8rIXUV9CQsVYL88LVsqL1W0RXD+SZGDFJXWu7Kx7juOd1ChXXOu2NTOIAZWEbxq
         Xe6856TfSLQaQ5mhd9iviTvAfZ34WaRRRinX9Od3vzNE+yXEmeLwTcQQudIn/kxK/8pD
         h0B0luT27kGHsXmaSbKW8Yv8XaTat8spISon3lVVJPI8KWwLMLIQSuFtKaDVnu8E8Bok
         3a7w==
X-Forwarded-Encrypted: i=1; AHgh+RqQLpLhJFkxtB2YZDzevDunSVOyGFcdJd7eKBG73Im8/QbO21uOHcgTDeANmQ34oSKqkxM8aAorXvuJtg4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxa1isDU+iRpm2XLPcfw1Aofb6POU2ec87mWt3dZXRqw2gonOwh
	2HFEfjowyTzOQpgEixDFPqSZH6DEC3pZfJETi2BoG7KQlBele9FAXa/8
X-Gm-Gg: AR+sD12HycLiWsQK1HLaOXitc2qrzhXutnuHBXgflQceYIl6AcWgJYsVn/Foag18NKq
	8oxwFgiKF13rXPOnkPWWeyGOyJAJnSE8C7PAQLoj5xoBma0XoPifkcakJ54Dn6OdtdnTAqU8eXF
	CDmrAbLb/pzb/FcE6gIVWYrhNmXx2GEHFdgCOnGM0pJBDz7YlFpsFHIkbNLHOx/gKb4pKolYRxm
	2TWEQyJAWS4LzzgT9oBBeitPK6wB2Iapeu2Vv49ujfTmi5sQ6htdByVNnKD95YHJMjrw0IY793b
	cu5clyQZmT4Cyps5OoXog1XNMAhzc6lKtVn+b74ZDmYG1YWlxh78J74zTUtR/kXu7TCjwYH0+Ns
	e5OKO3Sr6hyVtj6Bf8SJs++3NJP4zv1uzMhann6/neaw/6M/ZLxHbD1pSPURHMmemBhiwSRbfPA
	mLypIwN4zPKIfoKFRvKi9J6bRdDoRN6BtTjv5PsQ1mkdMK70bRwIslTxyOSRa3xb/CPMhZftnIP
	1zqeVFIjzxS3mlnkLRZixJVC4rO+2x6ZzNKXvA4P149Ws54v/ivEJJ2ZsScrl+Sn3MnrqT92Cpq
	XpW7dc8ubnoCX130pm+5iKraPfoD2K9j+q0g5A==
X-Received: by 2002:a05:6a00:4219:b0:846:1b9:cb63 with SMTP id d2e1a72fcca58-84ee48f8ac6mr10770362b3a.62.1785796546634;
        Mon, 03 Aug 2026 15:35:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm4186790b3a.40.2026.08.03.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:35:45 -0700 (PDT)
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
Subject: [PATCHv2 3/8] gpio: ppc44x: Use module platform driver helper for GPIO
Date: Mon,  3 Aug 2026 15:35:34 -0700
Message-ID: <20260803223539.86303-4-rosenp@gmail.com>
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

Replace the open-coded arch initcall registration with
module_platform_driver(). The initcall level changes from
arch_initcall to device_initcall, which is safe since the
driver no longer needs architecture-specific ordering.

Added MODULE info as a result, otherwise these warnings appear

ERROR: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-ppc4xx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpio/gpio-ppc4xx.o

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ppc44x.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index 9b874ff8b124..99fb11cd7966 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -204,8 +204,7 @@ static struct platform_driver ppc44x_gpio_driver = {
 	},
 };
 
-static int __init ppc44x_gpio_init(void)
-{
-	return platform_driver_register(&ppc44x_gpio_driver);
-}
-arch_initcall(ppc44x_gpio_init);
+MODULE_DESCRIPTION("PPC44x gpio driver");
+MODULE_LICENSE("GPL");
+
+module_platform_driver(ppc44x_gpio_driver);
-- 
2.55.0


