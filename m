Return-Path: <linuxppc-dev+bounces-21835-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56636CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 05:02:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTzG34FCpz3bsf;
	Tue, 02 Jun 2026 15:02:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780376523;
	cv=none; b=PiV0KdYfim7hijauqU8wcobjlAgS21DHALD/2Hfn8hrFHGPyWKCU/o9tknGWfd+YrBEOWRYpsX+n+KVRssMdbM3AGT2AyyrDOXBcBPHcjXw9LkxRZ/54lBVzymxWY903DfIxd1JsekBj1oCjc0wzPAZcA8j9xi6fOuNj/5pQdQLpCUAkATRONkhX8F90G5qT8US609JpXDx1k4rtnGNoEZxRCLC2KhqTLI6GggDjJhOYrrUEtwOn+0cR/mmlnSu0mlq+HD7HbgCOwBTkdj1RC/wDsd+78MO78yZvoZ301rtSAjU7ZtUILL6cHqKeMLu0DD8PHnStn114NDQIUNJ2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780376523; c=relaxed/relaxed;
	bh=OqTLkJRRJJvi006mVkaAc8E9sVbCF/KUy5AnwNp0FQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVbDA7IyJrTCHqytGy+e10/4NAD4FEEzEP/Ltq7JJmFKoQGMSAO4FvH4D92xLuLcwa51OsxvSLMwprW1/M/YW1Ho182Ry3r5rysEiwJOwcYnnGfLWsHRwK6IkuRVaJLn6BA5k6zNC65/fwAYmBsLVT8kH/DqRgmmxemjWJ+xtmxLMnXDd+6P4OU/ma4c1nJTUG6D4UfXHZ89egMhuDMNMZmeus3coIa68LAYa4aa/3QxxnXlo9u/xs57fM9ZOJc0G9OsYNVeJG8Y6jX9HckD5J3AWdVXGfPP8M3EbPUMghYYQNQCyTNyhVFfIRS0KHYyKvGdxm3uDFzMWm3UtHUL1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZM9XRE8g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZM9XRE8g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTzG25nzNz3bsP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 15:02:02 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c8532ba6c95so3182719a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 22:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376521; x=1780981321; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqTLkJRRJJvi006mVkaAc8E9sVbCF/KUy5AnwNp0FQE=;
        b=ZM9XRE8gwxojukipM3HArhf36/Qew1Svv7SU12smCJgU2w2GUHCpW5p7DtgPyYYvg/
         QQDVCB7nobmF9Hmja5UL7dYsyK7OBU2hmClIb6fANr3Y/T72JCI1E77NF/RohuVMHcyH
         IaCHOw+lpCUQrORwvhfO1H77vYO6l21i1tCS683YkK4HdUA9eQqya5n/lgwX4W9ZY+76
         c2yVIXqGM7jAyQwcWJ0PEW5u3lOQPceBePp7cyIVdkGoQUueXmY5gyXb0vXMmhLfL8yb
         ZtLlZTIKAepbaQv2M/AhqPi3EKH24Vq0NHjvitCvQUY3PiLgjHZHIpiDq2rfgerecE4e
         RwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376521; x=1780981321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqTLkJRRJJvi006mVkaAc8E9sVbCF/KUy5AnwNp0FQE=;
        b=ScuB0y9SMwVw37xj8CFDDU62QGj7wOAZUcr9jxLjd9PrKTRxfD5LuZ3zkP63UltxAL
         BHYOAFkrxU7C3mCjPdpnv1JQ/WwM6RDqaU2PdY76CAJR6PdemImZZyS7ar/00V9su8vO
         eRqZ5CGiuqbfiPcTFfxZJxJS7/71HcpjnJwwNPNACF73yxPWvZa9lWGwe+9waX/6kTsV
         4ZHgi/5KOjeIiDzBpULyrae6XJ/VIRwpNForLUsfmJGHCnpgLdYPh0jrPsPmlhP45DSm
         Y953z+t8IPJci2vrt60g8kjwi0l2eODWb+uDsz8DnXpRpJy9uJcSTh8tdz0M7hKzqVqu
         Vz+Q==
X-Forwarded-Encrypted: i=1; AFNElJ94yFSDx/ALhH5OUNwikgUeduE3bqF3dDJMYaDOkKeHhwgvUs/h7PzoMlrUHo6o73i0AeZVUS/wJ0+N+lI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzczFJB/cXTtnjYD+Wtziafw5fjZJihh73ENG23pmJK5jVhtoMn
	v/TaMRFM/TsdkuNXqAnPcsOr1rBddN5lX3HM99k62fhYSE6XcK3430nW
X-Gm-Gg: Acq92OG8K0pWKqZya15s9hJD3+q5AokjMAN/gGY3Kl8swf3ar3MBqq/3sWbP2LAVb/k
	fNnjpnvWrDQ8t8M5LaRs/IcOLxwSfl8y9OeFtd5+rJuijyX2jD9H3BuTH37mweF0+qUNI0cyaYN
	2FJeCcTNOcWNkfxT7Di2CReGR10vVNXaYqTy+gFybVEhNWC11w67YzDbzxUMexplSFQj3OrVGTb
	m8Oc50I2cbqZhuVjX+oqBhJYEnM5acM4AbLLfj5Oy5BGvEjVcT10wTicLNj4eJgESx8XAbIDHCH
	bLL6F5uGhA9+LjoqWacmejGZpAr5xFFgbDQSxTF/CxYfDIME6rsMgq8ODGX1OR/+1AGhgVp1vst
	iXijuO6KHSxXCNmwCcKycJJnKM4mIOsCWrgRa5QZNqA0YF0d55pnXksC5zEAdhPrnzSSL6lhYzy
	nHubQ3g/txOGr6jzCWIu2bNEbjsGVGXK7l4YJM2QryHPixkBk030fOkFPmyNgPCJYsE8qixevxC
	zEM5EvwjKdwGqIORLYXUI9niIJUXGsBT0EateZJBjTyMA==
X-Received: by 2002:a05:6a21:50c:b0:3a3:602d:a0d8 with SMTP id adf61e73a8af0-3b427c2a20fmr16311938637.17.1780376520969;
        Mon, 01 Jun 2026 22:02:00 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8589d055c7sm8958467a12.9.2026.06.01.22.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:02:00 -0700 (PDT)
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
Subject: [PATCH 4/7] gpio: ppc44x: Use platform resource helper for GPIO MMIO
Date: Mon,  1 Jun 2026 22:01:28 -0700
Message-ID: <20260602050131.856789-5-rosenp@gmail.com>
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

Map the PPC44x GPIO register block through the platform device
resource instead of reparsing the firmware node directly.

The GPIO node now probes as a platform device, so use the
platform helper to keep resource handling aligned with the converted
driver model and to report mapping failures with the platform device
context.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ppc44x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index 07b699cc4dd9..b30ca357ab74 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -182,7 +182,7 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
 	if (!gc->label)
 		return -ENOMEM;
 
-	chip->regs = devm_of_iomap(dev, np, 0, NULL);
+	chip->regs = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
-- 
2.54.0


