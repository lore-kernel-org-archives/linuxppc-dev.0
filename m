Return-Path: <linuxppc-dev+bounces-19529-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44072F36B96
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2026 23:29:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsGNN3bZxz2ydQ;
	Fri, 10 Apr 2026 09:29:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::e29"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775772360;
	cv=none; b=EQ5Q8CQzfvflJaACobyQ1sg80e4hN197llGlf6sumqpoBGD8ZdESK6fF2ZiaP8xXfGFvDnHIlRsnGA5TK+CjxCrMv5yCWAbbao3V/fl+UDlDfl3zk8a7kaPQR8XjrZYSpsAJDYBWym/Z1tEirttfqcRZhwaGvlLMOOSKCUB1x+LzP4W6a6j++HEb4hOp6oi5Q1EyQXXSLhVu0GbOdT0uCUqtdDnoAHRG1YGUewBcSgED+OS4qwBmxpgKcqVgqMc+GSKXWDD8UYIr8KXLJ1tSNs9nuismuqVuCYxhkz71VwsdeKJ0J4K9f9VT+p+4tDhSQA+axSdxfltCzhFNhbE6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775772360; c=relaxed/relaxed;
	bh=a4OMZB2a7xCPpbigXykeThDkTesHby2EnBTmJsd83Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJls6ZAXRTjrW3SsU1x7qplrGDDf2g9rfMYCaCxqDHcagJea9ZmrGixiKEZbsBCuh7gIQjdKzKIxOSisoKjB7sDS5Yahki8XJp6pXyeXy/sMZz/LDTzsObd3qWJHQVq/Haox1ERau06XGyvhGqW1r3H/+T1sEdxh4yB4fN2vGtQnPGgKbYOTNEtUY0kgm7BmAx4xLPkZRT4GG+4nl7Rn+g2jtUp4OMAAOF0MCbCeOXWd6TZvsry/FG89uU7E16fQPE1bIUA9MGb+sDjeN88I1WY76M3BxW5nZ3viUEbir2nKyy6x/nVX7enN0G6oHguEwBdM4TYSrZqMY8EpPK9pQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=maestretorreblanca.com; dkim=pass (2048-bit key; secure) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.a=rsa-sha256 header.s=google header.b=IfEhJqqY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e29; helo=mail-vs1-xe29.google.com; envelope-from=francisco@maestretorreblanca.com; receiver=lists.ozlabs.org) smtp.mailfrom=maestretorreblanca.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=maestretorreblanca.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.a=rsa-sha256 header.s=google header.b=IfEhJqqY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=maestretorreblanca.com (client-ip=2607:f8b0:4864:20::e29; helo=mail-vs1-xe29.google.com; envelope-from=francisco@maestretorreblanca.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsDXR0mLfz2x9W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 08:05:57 +1000 (AEST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-60580b17793so435787137.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maestretorreblanca.com; s=google; t=1775772354; x=1776377154; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4OMZB2a7xCPpbigXykeThDkTesHby2EnBTmJsd83Nw=;
        b=IfEhJqqYXfBKSdbz0Jqtbz5yCbm+RZbYHIFXqhWVbEV9LPLEZSBpgMkxyp7eUzWkSn
         Tk3yv2jN2kdAbD6epHlXUJjApttAGNmabwZEovMm0P766HKNFaWD70mZk5mnSzYEH3Aa
         m2XLH7Rg22bfbZw/k8Uu5fn192rKvXfMEWZw1VEnVuTA/B5626ivuVDUUQVrIK6M8kMW
         fXcajmoyfeGxW+nIFmf7isyloBFEkYHyXAQHIEi2U96g5J6268Z2c6Cmz5ZfTLWtj1yh
         jGnpJRJreMicFFydD/y91WW6XwNcuLTDcUqiajz7wkeFkA27VRSCXjlYI5fToDRvNzuG
         knVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772354; x=1776377154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4OMZB2a7xCPpbigXykeThDkTesHby2EnBTmJsd83Nw=;
        b=GkGJ5vtpxn5A3J9RyX4NLIwyJ8rWkrAGjX6xRfoZwQsM4qMM3P5SSxp7rnagVt8HBS
         n/VVCYUoKVuPRBGy7JIfSdTtHQmH4bGZFktlKARkfJIXfnjhOwgM66LTm+65RdMXr9gf
         CLvnzeX6sJeKC/3dFyS4gqxUz8XCz5pBRTq+eAJBfYOR/NwNHWR/TsvdVRJY3L/qoO2+
         W2wmQ/RCZWyvbjfkc8ehXfIwuKM48zJaa8JcOxRvjPrTEV2DuNuHgcIJQ9v4YH5TPkYs
         woZID6Ms2gGX8Xv/vdPe1NQ2zEi3OGJ5fxloW880Gx+I8z5+1rtsyqjIrkVHsMGry3Gv
         tl2Q==
X-Gm-Message-State: AOJu0YyPuscYlW9mOYmAG6wGZMRrIh/r1pFDoN9MBnB7Jk0P2Sh2v9w5
	9nnG7z1sh6FG3bbY/agEIhah7qRvWbkrrsqoPiDZoUKnmIRFQY+zFOLDoM1kf2RB/ex2PVDEDdX
	XAFkROAz1Fw==
X-Gm-Gg: AeBDiesAS9MI8pN158M5fiZTAB7iR6wQpDkwMBIxOWUrPFbEpN3haaOVgjAT6rdJ/me
	rkGKbFK8oQCu3VU3fYbrM0yv2GtRXpI04PbgiPawO0lg8ig9ObpmMC8xjQ6KZON/BH98V37SN5d
	1aKBTAmyTk4Y2i1H1Xbb0e0E2CCjhT3csyu6gEegWx8yTK3WfaQJcPTbYDX0Y201BP/0W6vnWEZ
	9kZbNKi/O/v8Z4FF90bJ4b0Isi2Cju+2VAwO9e6z6nq5aP0QuNhr62OE79jcEXSYI0ZFtLMaNds
	GCZxdwOBPF9scPgbTEAH3f3pP4k7ofa4TTC1Pl+hnN9fIAM3+XsWBiQ9MdEvFI/9WLSUzCSVJ0l
	dO6+it2TXrFed+lFg96HqufM7OJ37OyouzXRFid0ecw/9R90BPYyM6tihwi/bO1257v5PdDz+jG
	Vv12eJvmb/m7ASkR0ZxOdFvYmkn+lR9Ee4hMFtNHWNZRYxOLVIeFNVGFvIyUCMblN/R9kUi9fma
	OIXGXZlqz0d
X-Received: by 2002:a05:6102:304b:b0:5ff:fbe4:8a4 with SMTP id ada2fe7eead31-60a00629e26mr283413137.21.1775772353725;
        Thu, 09 Apr 2026 15:05:53 -0700 (PDT)
Received: from localhost.localdomain ([181.199.46.166])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-609d9285e3csm601039137.6.2026.04.09.15.05.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Apr 2026 15:05:53 -0700 (PDT)
From: Francisco Maestre <francisco@maestretorreblanca.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Francisco Maestre <francisco@maestretorreblanca.com>
Subject: [PATCH 2/4] macintosh: windfarm_ad7417: fix coding style issues
Date: Thu,  9 Apr 2026 17:05:47 -0500
Message-ID: <20260409220547.98528-1-francisco@maestretorreblanca.com>
X-Mailer: git-send-email 2.50.1
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

Fix several coding style issues detected by checkpatch.pl:

- Add missing space before open parenthesis in switch statement
- Fix duplicated word 'a' in two comments ('a a' -> 'a')
- Replace bare -1 return values with proper -EIO error code
- Fix alignment of dev_dbg() argument continuation line
- Use !ptr instead of ptr == NULL for NULL pointer check

Assisted-by: Claude:claude-opus-4-5
Signed-off-by: Francisco Maestre <francisco@maestretorreblanca.com>
---
 drivers/macintosh/windfarm_ad7417_sensor.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/macintosh/windfarm_ad7417_sensor.c b/drivers/macintosh/windfarm_ad7417_sensor.c
index 4bae07ca6..733dc711c 100644
--- a/drivers/macintosh/windfarm_ad7417_sensor.c
+++ b/drivers/macintosh/windfarm_ad7417_sensor.c
@@ -52,7 +52,7 @@ static int wf_ad7417_temp_get(struct wf_sensor *sr, s32 *value)
 	if (rc < 0)
 		goto error;
 
-	/* Read a a 16-bit signed value */
+	/* Read a 16-bit signed value */
 	raw = be16_to_cpup((__le16 *)buf);
 
 	/* Convert 8.8-bit to 16.16 fixed point */
@@ -63,7 +63,7 @@ static int wf_ad7417_temp_get(struct wf_sensor *sr, s32 *value)
 
 error:
 	mutex_unlock(&pv->lock);
-	return -1;
+	return -EIO;
 }
 
 /*
@@ -79,7 +79,7 @@ static int wf_ad7417_temp_get(struct wf_sensor *sr, s32 *value)
 static void wf_ad7417_adc_convert(struct wf_ad7417_priv *pv,
 				  int chan, s32 raw, s32 *value)
 {
-	switch(chan) {
+	switch (chan) {
 	case 1: /* Diode */
 		*value = (raw * (s32)pv->mpu->mdiode +
 			((s32)pv->mpu->bdiode << 12)) >> 2;
@@ -128,7 +128,7 @@ static int wf_ad7417_adc_get(struct wf_sensor *sr, s32 *value)
 		if (rc < 0)
 			goto error;
 
-		/* Read a a 16-bit signed value */
+		/* Read a 16-bit signed value */
 		raw = be16_to_cpup((__le16 *)buf) >> 6;
 		wf_ad7417_adc_convert(pv, chan, raw, value);
 
@@ -141,12 +141,12 @@ static int wf_ad7417_adc_get(struct wf_sensor *sr, s32 *value)
 
 	error:
 		dev_dbg(&pv->i2c->dev,
-			  "Error reading ADC, try %d...\n", i);
+			"Error reading ADC, try %d...\n", i);
 		if (i < 9)
 			msleep(10);
 	}
 	mutex_unlock(&pv->lock);
-	return -1;
+	return -EIO;
 }
 
 static void wf_ad7417_release(struct kref *ref)
@@ -261,7 +261,7 @@ static int wf_ad7417_probe(struct i2c_client *client)
 	}
 
 	pv = kzalloc_obj(struct wf_ad7417_priv);
-	if (pv == NULL)
+	if (!pv)
 		return -ENODEV;
 
 	kref_init(&pv->ref);
-- 
2.50.1 (Apple Git-155)


