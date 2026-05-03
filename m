Return-Path: <linuxppc-dev+bounces-20387-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6CCCD13DA
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 May 2026 00:57:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g7RFm486xz2xld;
	Sun, 03 May 2026 10:57:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::a34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777769852;
	cv=none; b=D3iJiva1teonOET7qeJxYtBparOGoly1id3mjcOX+iq0BGcSz2oOypUJha1sjK992mNtaGmd+fG3gXnt0tmngI1PenMaBtAR8BqPdGYb8z4tP0J39SwFjcazTh9KuRLlSV4w+8Dodwbm5+punz4nAXqHklgF2PEM/JqUsjkFM2jLCc2Y1BvbYjqKcASU3nEQp1pnh1RIhhN/NXMQ4W0gEMXxysKDS5S4RjZX0ZnATXUprspvBxARFwPITdMngftfEtZGob01dRewjyWl5atp1x8HME1hNAXkWuJktam/lXSEhNEH/nd51REXQ6Fk9aGzL26Vf5fdnCOQU9i2ldzuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777769852; c=relaxed/relaxed;
	bh=jAbutDuOdCLlr5MjEhNwBJAD8Xktp0AiK9lNlrbs3WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUamNUZkCegxznwYHYsiftToyqvz3uLnDdqpeUTw2C82xe19CzSm+Dnp76TKmc/3B+jg0gJ1LIU4rPjNYyqzkENuJb40PJXmje5/zAMjckHeKSbkfGyxC1ne0oVO0PphhsEsdJlewK3CLg5KcFTCmhIl9ifVnTKS87pFkCzh3+wQyILlSkF8Laybztl5hpzTUOCz1zdzVVf5d/8fU+NAnZR+x4/tEPZYRKpG7aJmUCr711CXkcx3hibdZF1xId4KJTl5xet5epWJaOGw0/JBcr5Tqs2nB/q03lJ8mhZ6ag27ToECtGeLExNE/cdZGfnXd6ZYFeFT4rXLWWHGSyYrmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=maestretorreblanca.com; dkim=pass (2048-bit key; secure) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.a=rsa-sha256 header.s=google header.b=anNY7+R0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com; envelope-from=francisco@maestretorreblanca.com; receiver=lists.ozlabs.org) smtp.mailfrom=maestretorreblanca.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=maestretorreblanca.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.a=rsa-sha256 header.s=google header.b=anNY7+R0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=maestretorreblanca.com (client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com; envelope-from=francisco@maestretorreblanca.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g7RFl2ygqz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2026 10:57:30 +1000 (AEST)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-575212eb419so94244e0c.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 17:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maestretorreblanca.com; s=google; t=1777769847; x=1778374647; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAbutDuOdCLlr5MjEhNwBJAD8Xktp0AiK9lNlrbs3WE=;
        b=anNY7+R0amYDBI+rGNH9NpWi7Q9ZMLUqu9NjOokzlt6Q8xffzku0WS+L/Dqw2u5ij2
         Vg1Sg4cgl8aAOksYUsp+gwBEvFUie0+JmfhLHOu7s4qM8TljuDsuKS5nyl+bk6nyJDdw
         ba5ajRDRjvW1BGDPI4WTR8M2gSHgQQk6iuJElgZjFW5IphHnYuppxG74XhgcHEeqDbWt
         PQjFfRVf3df+U/Imx0v2DRUQq5ob/nR9dhRrzF+giwiOR6mRhv4LWzOiAn0sDWMEL4vC
         WgzwS90X1XSHp+64BLOOcyIGeA/85F/XMsQt0iSu1+VFwshYjLSna2s6tAEgXPLdM8SE
         jBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777769847; x=1778374647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAbutDuOdCLlr5MjEhNwBJAD8Xktp0AiK9lNlrbs3WE=;
        b=d82KbO2mylmnjMevvK3EZILznciinIiIIkrOfFaWKahwCz9zkW06oVN3d0pbpC0b34
         HVEHe9FKCl4o7BRtKUB60IH6q5CguQKmWz2cTUJ789EFsGQR7CVTl4BozWWozESkuE0Q
         sAMWWOimo7uJcnqGYNjV072Wq11TMBVWjrX9gcAjqam2GPr/dtmCMwqzgvzfPvGvq00Q
         A6VCoI0dM7K0YBf4W7AyjZYLOvfvS+ms63RB/0KIcH8fC2rLu7vDASUwFIFQ4RyDV6qq
         IHZIacpnH7wM1o9ywyD07AERcMbLH7j2fL7V/EGqFsSgt+5+PzTmAUljqPHH3bsoFCaM
         3rLw==
X-Gm-Message-State: AOJu0YwiJ/rlRUyylFkcTWrevIwKDrDkSzkye8GZWzI6091ercaKGqVv
	u1s9ywPKo8tUkxDQatGU6L/b6Q4CpHU4ckpDsUdtc7c42UU24QaEd0h9Loaqe7Stdn2LQiCkPQ6
	FQrHd1ZL0Lg==
X-Gm-Gg: AeBDietTCyhgpy9s/szPfiMr2bD3LePjTZghIs5cz3xDCSQ24RQMtQBaN55I2Rvowh9
	GlDlx/TvLN+1iJe2CBwJKmsV0IvbHOWHZL40llHi4qz/Zx95Yvnx22LUqRBvpUFuXp8CqFs9qSw
	VFfo+jxpc1oTIlFEWcMbbJOCYNS7Z5YQPuDzyRVGSpJrUX0zH51MWWowwS0x3qLMYEKgcp+A+QQ
	t/CEDtjyyHDRj0WYE8kBroZvY5gN7f6TYlBhrphJyWjz1mw9E/fz947rBelurYbZ7sGeTTGmUOP
	unJ0hjE+1RipEgk0U1oxjLAEBoa16eU2hEyKKEbgqxqAAaIVQhfWBpK36FVhIS9SpbMi0qm6L9/
	kWEVwJTbOUfhvySJPqWXLQLgdojLLhzSk8mtWagljDk9Y6Y4jt5F42EEiRIUTH/OJ2voIvYpBvE
	w105drxpQmnPk485R1doDXsn9XPmw37My/5WQihydscRy5crLcGEa/VXBI0SFrBENOuN07ZBfD0
	tYxHvYQlzLa8VMs7PvHiIFNuY/0GWfiOCZ0Zw==
X-Received: by 2002:a05:6122:328e:b0:56f:7e8a:a395 with SMTP id 71dfb90a1353d-5750c011345mr1658926e0c.1.1777769847071;
        Sat, 02 May 2026 17:57:27 -0700 (PDT)
Received: from localhost.localdomain ([95.214.114.12])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6c6c582sm4009660e0c.9.2026.05.02.17.57.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 02 May 2026 17:57:26 -0700 (PDT)
From: Francisco Maestre <francisco@maestretorreblanca.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Francisco Maestre <francisco@maestretorreblanca.com>
Subject: [PATCH v2] macintosh: windfarm_ad7417: fix coding style issues
Date: Sat,  2 May 2026 19:57:23 -0500
Message-ID: <20260503005723.68888-1-francisco@maestretorreblanca.com>
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
v2: Resend as individual patch, not part of an unrelated series.
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


