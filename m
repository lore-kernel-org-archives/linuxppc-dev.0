Return-Path: <linuxppc-dev+bounces-25304-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175F1C55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 22:36:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDWjV6SL8z3c3H;
	Tue, 04 Aug 2026 08:35:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785796558;
	cv=none; b=mKH+KGfLfV7icOIMXU5gFsY/FGF76MceGNphQ78P8rnhWQig4BpqoLcx+SHz4zjbpwqXIetFrtAX8/5YoLxg8QJTEXElVpVoeNcWuzSvAX1NjWZ689IKnyVH0ZshjBUsYh20noQCfjyQQGCPbrLeuO9WCqRPCp1fZlQQyh6hpk6oDgNl/Ha5e7NB7mS6/B4UeGfyWZ/qqMuyIc15s5YWMxXYrDOSyMacynr2EvafHd37kM6My/5gZx/xtXiJWQJOPH0nuBxt3xOM5kMizOgf6LIrEtVjS4JyDBRA64yXQ0yasJdDiPj2FLX7oC9FfzPlvVuJ+5Z6afzIvGyPSewDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785796558; c=relaxed/relaxed;
	bh=dDTWVp0Ffpbf2p4etjIulMVE/egA+V8UQyvLt4BG/CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARi4UiQLwFhsbX9Cq4LjOVjNphpt1lCWoMFpnCuil7WN7gQSgVumEDO9wF0jJDe0YkhdUhIan5iQr/SFHiBJh0F07ZLIQGZErlf44ux6vT0hJR1aOmwT6Zc2TTe4w8o6Iq0aQnZRULgIPPE/YPMvUKo8+wP4ZmASOzzA1QDMM+25ehz67JhU+rkYiHcmgrEZxzL4/9dQWeSr3isWE0UONkAa3ilMXVipxR7Xq6Bsh6UOZZ7clSP6ee0cT5jtTdBiLQdkPlHdLsCrGSjxlh+lJTUg43j2InoofXuurs+C80W4mwjz0VMN1rvXO1iqZKoITXCB8o9Jtd64vkQ+2e/frQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TFvlKvAA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TFvlKvAA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDWjV1wRQz3c4V
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 08:35:58 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so2798534b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796556; x=1786401356; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDTWVp0Ffpbf2p4etjIulMVE/egA+V8UQyvLt4BG/CE=;
        b=TFvlKvAAV36ni9q0E7eptoZQqwPUszVEChzC2JOxo8+G7g88zu8hDDip5YHj2l81rd
         cz599lVM//Vu/rQmdDH7YexeL2We0MR9j0a9S1gtyePA+rUQ+STIlgpZRSETT/ON87Db
         s2R5Ia9jOjzOmMjYEPyb3r64CjlXZEKAnsk9/V5fEITrGFDhlNb9Q6YSX/ZcXm6U5/Ic
         St2Xaai2lGHDyYYKcepqaLw8K2e5laoQ3AWFrzBlC+XxLaOQ56LLd8wjMIudttatnmQD
         /5/ROu0zHb3kjd8CErgwtbhoyJq9QqchodvVEWcW24IEIsoJ5YCz1wKXr3wDQG27L/es
         dBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796556; x=1786401356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dDTWVp0Ffpbf2p4etjIulMVE/egA+V8UQyvLt4BG/CE=;
        b=WaahOKxkrOshN5rOSVMk7z9gOA9ikMQAN3+4qBJSJBIqbicSTU5OEoTpmnE29My259
         fCut2JD4KwSCoTA/Co/EBxI2mnm1OH3ENkL89JkhHzw6pxGNRKlKbwtDAaUQEkyVdTYw
         uJjD2msyl3C8vJcUCWLJrKJFYtk0sAf4XQTkx063DewLsLY0PyThYf6TJ3zRR8fPc3FL
         BMJZNkDPCRg4UA2lpW07hO4DHHBCTIaovLQ1eWHnRffpJzQtA78OUWMIfKPqr4qmnqdh
         NGzgXg3LkfRqrS/OcB+B8tuusaZuGptEk/GRlMd5L/40vBRWRwU7OYwFqUSXMkPzvz4m
         Z/Kg==
X-Forwarded-Encrypted: i=1; AHgh+RosVZANaNe3O0//kh+ltmiq2ZJULyy3nvDBrq4FcUhWYNEg1vwo+aNCSDoOejS0SWO2bQJQ2FJpgqMKpd0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwUQWzH3R0xMFmWG2fUCSe3i9f1Jmq65y1EKsZanSz8kbyiaBFZ
	OARkfeMnlunD3RqJtEIbd/45FdOBSw91Cs4zCRLm3/0ueu3VY0c21Jsb
X-Gm-Gg: AR+sD12eYIe4pGxDHOrgY7nFX0RccqNlrPBnbuomzY3+cNsX+n5JiJ0P9SNzVzfWu+o
	cwH797divAXOnbxCErhv0UvxzNN899qwFCIvczEcgVx5VNTWmfwt7LBnaQJBGjJanrAwiR3GkDH
	jaowDCwChEyLwtofcCcJFhEAPmqVEtudcqemvCRLqNxv0sKOn5o5yKSxaX44Vschv/5Jue9Rjv3
	xxFxLzcJy4DRNFq4JZEV4e/xQMLtvUaFPVYDgkgqM3ATraeS40BAK23g1YxvODdgfMNZr5g/bUq
	X8dm42tJFT07EaJ47vjbzyoYm0aCRbVRC1HRiAhWsI6paHpeqnHkZpKLvMGuoIefAj7XCqBX6yb
	igMMO4IpvF4JEvc6WWaTflpgflyLmoBmNO+AR+JddZhF6Wjaygdb9okREgJKPrest0rUnXjgfty
	SJQiPjMSrFMcZS9F1AU9XsfjHJn4OdMgSAGMtYzokMJKN6kWJ+diF36k8UhTyIm303HpeSncC6d
	ApmwEliupuXDwjA0+ztRuvBMPCle83UT2yErSGerMamy4HBYW0T62nL+wbe4Bs1Oea5SutQKV+x
	hDXAGD5F6I2eSnkLCtDOcpZThvmZsEzH5bD1WA==
X-Received: by 2002:a05:6a00:2daa:b0:848:2a55:7110 with SMTP id d2e1a72fcca58-84ee4953b38mr10912063b3a.36.1785796556111;
        Mon, 03 Aug 2026 15:35:56 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm4186790b3a.40.2026.08.03.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:35:55 -0700 (PDT)
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
Subject: [PATCHv2 8/8] gpio: ppc44x: use dev_name() for chip label
Date: Mon,  3 Aug 2026 15:35:39 -0700
Message-ID: <20260803223539.86303-9-rosenp@gmail.com>
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

Replace devm_kasprintf() with dev_name() for the chip label. dev_name()
returns a stable pointer to the device name, so the separate allocation
and -ENOMEM check can be dropped.

Using dev_name() seems to be common for GPIO labels.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ppc44x.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index 9fdc84e922f4..189667e0e1ba 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -147,7 +147,6 @@ ppc44x_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 static int ppc44x_gpio_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
-	struct device_node *np = dev->of_node;
 	struct ppc44x_gpio __iomem *regs;
 	struct ppc44x_gpio_chip *chip;
 	struct gpio_generic_chip_config config;
@@ -179,14 +178,11 @@ static int ppc44x_gpio_probe(struct platform_device *ofdev)
 		return ret;
 
 	gc = &chip->chip.gc;
+	gc->label = dev_name(dev);
 	gc->parent = dev;
 	gc->direction_input = ppc44x_gpio_dir_in;
 	gc->direction_output = ppc44x_gpio_dir_out;
 
-	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
-	if (!gc->label)
-		return -ENOMEM;
-
 	return devm_gpiochip_add_data(dev, gc, chip);
 }
 
-- 
2.55.0


