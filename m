Return-Path: <linuxppc-dev+bounces-25303-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2AFC55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 22:36:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDWjT2KRZz3c01;
	Tue, 04 Aug 2026 08:35:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785796557;
	cv=none; b=m9SRro5pXHk14J6P2wLgs2/NnQwb7QMdHzAfunqEm266h8QwYMiJJS5OiJB7mqEWub7XBdu2zt0puPcZ6korETMre9448v21YxUdxaixFnbjWrPJ6ha0LDTE8g0Kwkwg9cp5YI9gysS6nOhXf+omx3uHmsuMi+XdagVZlaNG0u/xmckvTJDi3W1UrHffuc12FmUN94nvTJTrgSijzkSkvHM0aTBVzqagD7X4VqKagy/mDNbKS4veQZY3xQ/8+cx8TH4+pDx9UDA8S45RusiWXNPjB7x04B8Q0nBBvzF9Joh74OA11r4Nn8bNUW10OBAT6JdbPQpzEq+mM8awJ6h2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785796557; c=relaxed/relaxed;
	bh=RfXwqy1TgncBxC4BQibRgbXUjLq//9HNL0TAoHIeLvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDGWhzQL4+j3zhjwZJIPwVVvdgzoGEBEbKZ3G9JE7LJ+Qm2O2ZYiP61XTgLcaJANM1x6QLle4qqZFbTAjaD/IoHHOFCMch6p45o8d+rDvzRamx090fhq8+4gUh6GPSSrwZAEZao/+1dKrja2rfW+Lab1LHNGypf8h1e4yVKXsN957sTr302A6JGg3mJ91sKuUkR3zBIsoqyUb20DUXzlgfhog0AuymHzZxq3+50kLbqIwiOBol3WXyUQio+sA0mOFOXxYvaRkAnZNQ9kaPGFuC4F4IqCj8nApLKAsCh+5RxGj1YVR1IaMnZeIVLMn2r5KMy27lJApJErZyCmAfLDhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y1GisON0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y1GisON0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDWjS4KBdz3c3H
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 08:35:56 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8484f229529so3184101b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796554; x=1786401354; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RfXwqy1TgncBxC4BQibRgbXUjLq//9HNL0TAoHIeLvs=;
        b=Y1GisON0vbFdCZq8FYZnW/hflAAr6XMvFmSW4DuEo1RkTjXOeLf5fR6tO76uY85/1E
         HAiZxbWTCa1a1QAtlKoz005ehz0T0Qb3JXSNBPmu2Ri6OuESuTkcivIdkarTqgVOpJvn
         +3vT1tyOlflgrLWA6662m09G8SKYvRw7NmRzx/Xx9b4KL3eofxogF3vo34jgRUsITv2F
         oi08wTi9z7KIzjQQJad+cnx8CYHMO6qOMBxhT2MNeayp+DHK92n+K0X9ZH99OhBDF3Tz
         mBBq/ubi1Tzuo14uU3yu9jVg/VTHQ8rPnebnHvcsOYk+nCcrUJuZei3CjfpWvUtwFEab
         pVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796554; x=1786401354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RfXwqy1TgncBxC4BQibRgbXUjLq//9HNL0TAoHIeLvs=;
        b=GurNcUWtkS74fFeSpD4huqkUEmdKManOdSNnxm8Y4ngJG9fEtzdQGH+Q1BPZEhlouf
         1sDp2YbLppBhQmIT6gB/8I925K/LvtrbZINXmOqJEZ/UyGlDnAZW8FvswPoF8o5ft9MW
         5QnHsXbka2XuRFkI1atHk8Vma4vE3n6mzhgy8c4OrJ376oixaY9Bh2XpiyDYcZO5DB32
         mtuLCduyqXxzhAjiqCwEfOrMLlkjLgAgmTiiafIsoPNO/MhkMkur4VN4zJS5AromAW/F
         zNmwdxJhHjSoYD+KWd8fZOcpK0j2m+omyRUS97KIWAhA4Z/wfZ6lJqIHzbXaGgsptjO+
         tmJA==
X-Forwarded-Encrypted: i=1; AHgh+RpSTKc74mia1AqnnoH4ZhTpZ5O8g8Gy2LuUU3ITRSKuTTFFHj2o6sLPWs6R0+3iIDFUARFr9g+7YBHSzHE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMQrQ44OMBWR6F1XouquhxpXBRUdCm+6BaxKYrSRlJeIKqjixi
	X0+lLzN7tgM9gr0i3BHNbwQWJX2JYPI3k5qKyEgCgvr9BR5Sm0YJUubO
X-Gm-Gg: AR+sD117/fVZq0uIXndieKcZccb3LeV6s2rImtoVXEoNs+d3T5lHV4wlJOdaimdks7G
	E26OgU9+t//REjCTPt456/0Ikl7psuFTqnXAh9cW1kgiv7Fwo/Q22hn4Te1gyEOxRIOMwuN5qKf
	nggTQEKbxiQ3ugReVgbu59lFi14U6ovf/8cbyUJdwQaqQc0KHg1lAY8S5J1wILL8DTDKyHwSKi/
	JBteJ0rtSbQl5G5VWIVdwVpbzIF7tlPL+CGpyjDHfA86tAOnyOn8N6V8TGgPvFIM6WZt879x4fO
	WDwBnQQtUWJmFcTpE88eDzhuFkH7zIPKCCgrKhf7FnglfAg0S/Cc8VnkG/SzTTSRS7+ZGdiyb0K
	H+jwe4NgwJqEOXvv38kdmAbqUGhCTLsfboSKL4E0o64/Zx+qyk+was5rhbr5bz87SkJgVdFrIIS
	cslUgsz7LOjC8iA158PNXYgPOXynq+Ol1acV3v3qUuLPLs/P7wjYlBH6rtOtBR3Ktv0QhGZDIft
	J2RtJICB8rYpghCFu+7FpHJwv+ibt0mpsB257G2JEnPv9KMws+M++7zgTWE74z5ar2g0U6Aovcn
	1tpcQtst7uclrO1prr1Zhi5XiJTUcHNaBKXmK/CowXgvQ0v/
X-Received: by 2002:a05:6a00:1d87:b0:848:6537:580b with SMTP id d2e1a72fcca58-84ee48ef506mr9925893b3a.51.1785796554374;
        Mon, 03 Aug 2026 15:35:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm4186790b3a.40.2026.08.03.15.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:35:53 -0700 (PDT)
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
Subject: [PATCHv2 7/8] gpio: ppc44x: fix undefined behavior in GPIO_MASK2 macro
Date: Mon,  3 Aug 2026 15:35:38 -0700
Message-ID: <20260803223539.86303-8-rosenp@gmail.com>
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

Shifting a 32-bit unsigned integer by 32 or more places is undefined
behavior in C. GPIO_MASK2 computes its shift amount as (gpio) * 2, and
for pins 16-31 in the OSRH/TSRH bank this yields shifts of 32-62.
While this happens to work on PowerPC because slw masks the shift count
to the low 5 bits, compilers performing value-range propagation may
assume the else branch is unreachable and optimize it away, or may
evaluate the shift as zero on other architectures via COMPILE_TEST.

Mask gpio to the 16-pin bank index so the shift stays within [0, 30].
The registers are banked (OSRL/TSRL for gpio 0-15, OSRH/TSRH for
gpio 16-31) with an identical 2-bit-per-pin layout from MSB to LSB,
so masking to the within-bank index preserves the intended behavior.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ppc44x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index fd543fbb959a..9fdc84e922f4 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 
 #define GPIO_MASK(gpio)		(0x80000000 >> (gpio))
-#define GPIO_MASK2(gpio)	(0xc0000000 >> ((gpio) * 2))
+#define GPIO_MASK2(gpio)	(0xc0000000 >> (((gpio) % 16) * 2))
 
 /* Physical GPIO register layout */
 struct ppc44x_gpio {
-- 
2.55.0


