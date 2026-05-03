Return-Path: <linuxppc-dev+bounces-20386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DF9CD3423
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 May 2026 00:35:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g7QmZ1hkPz2xld;
	Sun, 03 May 2026 10:35:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::a2f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777768542;
	cv=none; b=mOq4buBg3n4VfZ9Izl3U20D9hH4XDq3k5Hxj+e3e6cC9E5HMkC/pPBNdV+JBC0ftH2n2xeo45snRnpi4FDCBFW5Q0NNqoxOFeHjUFIcnvzZDRBLK0XN5IDtxcty4H0tZnc6p1bD8bEJeO9qcLExCwzhfLgUx/0AT4M9EhyZiR9nb0CICrx62U1a/PUcc9ycdW9CJgKEtKPjkD0JSHBYOsrEz2g3He3DU1xxXbyyaKWsSENif0JqtyVv76Te4pLbtVRH1Wc8qKsgNgKlVIQ4PjOyLgRdOhxVWo+gIV65yMVPb3wdlzTfQLdrmzmTZRGQpmdN+zEd97Jsvicv7kpQrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777768542; c=relaxed/relaxed;
	bh=fbU9XP4r+Vkqdo073U4JVzbvhQhcQEwvGnAM/1xTwyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlmOtQJJ2enS7rN+kIb3gY10e5wAHug6N6qnUDOy4IkLGqCplHmXM+CqTeaDg6ZXzaws4G8KzZUsn/3ocqO6wJVCDjdpej6cVo24hqTkK7G/sxS2vPIayGlyz0NEgfa60E8yRgehICG/Ff5aPKkYHuDGoOM0q3zlTgvTr6YFmbOxayEVnzYkzh/YT8ClpcxY+j94k9yq9O+a4TJk6nUhvS9g3zKP1MQBYgoOik5sA3j5ebD1sC+8xYLvzM+ZiiLtTW1nyWA789naQAonZGEPkHeMsIB/6Z7PLzn18EyY7N+O3Fj4IoT8eyEc88bzH45/0Wl281DDlF4kaCyxzqeOBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=maestretorreblanca.com; dkim=pass (2048-bit key; secure) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.a=rsa-sha256 header.s=google header.b=PR6Gsocg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a2f; helo=mail-vk1-xa2f.google.com; envelope-from=francisco@maestretorreblanca.com; receiver=lists.ozlabs.org) smtp.mailfrom=maestretorreblanca.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=maestretorreblanca.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.a=rsa-sha256 header.s=google header.b=PR6Gsocg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=maestretorreblanca.com (client-ip=2607:f8b0:4864:20::a2f; helo=mail-vk1-xa2f.google.com; envelope-from=francisco@maestretorreblanca.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g7QmX0YHdz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2026 10:35:38 +1000 (AEST)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso2803486e0c.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 17:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maestretorreblanca.com; s=google; t=1777768535; x=1778373335; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbU9XP4r+Vkqdo073U4JVzbvhQhcQEwvGnAM/1xTwyA=;
        b=PR6GsocgF+ejZG8z86NYhFhLo1hgZwUgMSKMU0zp8kMK1HBxUQHWXyZ+kc3I6NEZYZ
         gsXybMuJly5EcsIW6N9nq9ZBvYrVJJtrRaiyJfQj2dDlYYH3SK9pcGVGHMw2ghjr8DPX
         vB/iewwHXtmKz5ujeDuVje1joivDpueEFmu/BJhkufEX355KBRP+DLRVa5Zlj807kqWt
         DjATll4YWuMZONpwOG+NwpI6mOupXkxX0L3RM+wg7xlBo5sGSWjlWEeCq+UmsfmUEoOB
         VZWp+2n/FKa7lr84Lxtme/Lq9JV6eSl4mR3xrmQqJrU/kSpM181/drzi3CTjEAMhXAf+
         l4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777768535; x=1778373335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbU9XP4r+Vkqdo073U4JVzbvhQhcQEwvGnAM/1xTwyA=;
        b=ZCx/xec4wGZH+iUJbYSd3yXI7gaQ3AqyRBHlCOdIDEV1WGuCnHrXmrCx4sXMI2p2xR
         YwQWD2Jy1+KSjwV9Mj7HiUrnmigTQzRO86fZHz+9Dr8rh4ck7XjVyFQrUIEYck3cgYhl
         QLgOiEnTIZjPj4usEKqDXEkNqTtyf+E8KcD75BdTaSDerzP+f7IYO5WciItQii05AjtU
         dKmq9SlsFu6igrRxMTBdmUSLMXJsKp07+yeo8UdpyRVuNkKw3SGOUXd9sP1nPDyLdD7U
         LpP0iu4vimcCE5wiGtgIvET9dQJYYAMlh4sfg2pIyGZJQEAJfz5tYeA6swtpNbYxsig/
         wj3Q==
X-Gm-Message-State: AOJu0YxM/sIF6At39BSH+r18thXcKIL3ZLZ/ptOm1vtgalbDMwLznN1R
	K8mW0TUjYC1Zzae6WwZE5UeI6HJFqfDpB+tMQUYdqC1+GxM1dWIjKq8aE0LAzDFVmGP0eb9sQvd
	zxqWSAEDkYQ==
X-Gm-Gg: AeBDieuo3m/w9g8Vhr4O+qr5sDDRwzKFPpXOn6JZMTJyqYmUythxudVE+lrAiUC+VbV
	/mMtERJSGCbQntUXOndx90ufbtxpmsiPaa708I/S+SteGtk0FAJclHwdg1wtaFTkfUtsE9ZpnNQ
	QfUNuNtoEPIega3UiNSK1xl2uOSs54r6GO5/3QUdWT5fAgShp9G90TkWe0oJZ8KJT9gLG+3PN/i
	+oMv8y7fP7j7vL4qc3i1fk3sXoi5BmE1GzOfTW/fbZic+bVT2FfR3mZR+AJxrY8PBWio6MuSWYu
	1UQZmT684ziI+zjHyopfPjMNAeHMQ66WS1cu8ub5HeG1fqut1w73x0wJQF3WVxwK5oZ5wajsFn0
	2WQbAxDiKpERSMEFYTfP7XZfxUfVz2MnOfS1xZza6bze6JAZ6jTykF+KjLzkCsK8BslfKGnQTxf
	rOrAf8CP6Gm8zN3MOLArxSGwaROntSgWPhRqt7WP7+RQVHGA84y33rpRA90E2ovCn9SX1FJQXVS
	nx7KOYMu1zVP1B7T82Gz1kCCQJfaY0uwFPxEQ==
X-Received: by 2002:a05:6122:e447:b0:575:2166:74c3 with SMTP id 71dfb90a1353d-57521667d16mr245207e0c.9.1777768535452;
        Sat, 02 May 2026 17:35:35 -0700 (PDT)
Received: from localhost.localdomain ([95.214.114.12])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6c6b8f1sm4316524e0c.12.2026.05.02.17.35.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 02 May 2026 17:35:34 -0700 (PDT)
From: Francisco Maestre <francisco@maestretorreblanca.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Francisco Maestre <francisco@maestretorreblanca.com>
Subject: [PATCH 2/3] macintosh: windfarm_ad7417: fix coding style issues
Date: Sat,  2 May 2026 19:35:30 -0500
Message-ID: <20260503003530.62539-1-francisco@maestretorreblanca.com>
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

Signed-off-by: Francisco Maestre <francisco@maestretorreblanca.com>
---
 drivers/macintosh/windfarm_ad7417_sensor.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/macintosh/windfarm_ad7417_sensor.c b/drivers/macintosh/windfarm_ad7417_sensor.c
index 4bae07ca6669..733dc711cdc7 100644
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


