Return-Path: <linuxppc-dev+bounces-24983-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C0AC54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 09:57:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h976W4B6vz2xnp;
	Wed, 29 Jul 2026 19:57:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785319043;
	cv=none; b=f4HkPRKR80nz7nuBmGMf++0sOgkxp/htAv5EAp9DFPP2rzKykRR+flhIAr6sWP3zar0vgsWsG+Lac6PcnYK3TTNejbCyy6cERCsNQM0ELKOe+5iBhzNVC0qVIvvsFHb/Ao9CySNStlkUY+qshOubq7bYKCI6KbRFMIejPoQ3+5SECSFo/ZlI0JfLQRhB0CteX6Mn0D6eC0mid144W3pEYqafEZAFDPlTaHFMa/ICBjyvCDQf4tL8SbFX65g3oPEa87ArVZ6llUExj0IaS8KFgP4P/XaEkFl7lLs8qbsyw0IojIQ83JglilRyab14s8nX6wObWoRVX64f9HUDDRHAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785319043; c=relaxed/relaxed;
	bh=7lwwiIRP2jwng9cjmpEW8mwDj0gYjaoBAD8MijL5Ty4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iR1ukdKFrk2FYX/gL2Fbhpd7ZcdJPZJs85jpnyo+1atbZoanQy2+HAFCh215KNLfVofAlqeb3U0OXW040bu/ADWAZH3ajXrb9bOVXcaIZrbM4+kUYtUJDSMSKgP4CW2pESt52luoUNtwCAgM8WH3ejazv45Hrpi6+7VbC/W4iNOTNjn+SwoTCWsRCurVft9NUPWDK+cuzJYUaMaXLvhhoZIPc/0rTQTaM4QWTUDcOkiJN9h7/OcJt9vLVytliQCs7n+9aMhqzU0ShWh2xv6aipb+Uz4nXz5sSloc9IGSdhgw5/wWRCYa0qJ3O7TPGnOqZOrHPHM9SIUWgEdqF10z6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8wfuk+3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8wfuk+3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h976V4h3Rz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 19:57:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AE3E143BFD;
	Wed, 29 Jul 2026 09:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064301F00A3A;
	Wed, 29 Jul 2026 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785319038;
	bh=7lwwiIRP2jwng9cjmpEW8mwDj0gYjaoBAD8MijL5Ty4=;
	h=From:To:Cc:Subject:Date;
	b=l8wfuk+339JlTVxfHy3GEQJ2F3GIVuCsfNXVB41SJhoIHLVB5yof5n/rjuOv/Ce42
	 uAuAMZW5p3od7GZ5I6Nx3VjSY245Q2UJ54VOyRb6CERmu58oGijVaTEXGbK1ua5qv2
	 83iNVJ/TXO6TpXtrqO1JS6uptG0KYk79m5vnx5PdhioK5rwqxOYkGl2t3ut7X7F+NA
	 zzOeD+Fq56l2h1IjqMC9rm0/dfrHIvaLoiMjT4oLESQr+WVkN81+W9FcIbtGt7ozPJ
	 CzTWMFXg+egNTvROk5QU1oI27eLxBuZfSyJ8sQX7+TvhssS+aF1zGXH4Z0/eqC36jD
	 amOtyEKu06hJg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: RAGUENES Jean Noel <jean-noel.raguenes2@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] gpio: max730x: implement get_direction()
Date: Wed, 29 Jul 2026 11:56:47 +0200
Message-ID: <2565e33e629d16d9e33086570834146bb1c962db.1785318831.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; i=chleroy@kernel.org; h=from:subject:message-id; bh=tbXO2VXfcH91jor7uUwyNzWZt/ACys/Pj/NV7aQ8Cbk=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRlnis6IvWrYW3ie9cNi848uTjrzdF+/7JLLw7lhS69z bT7RtfVmR2lLAxiXAyyYoosx/9z75rR9SU1f+oufZg5rEwgQxi4OAVgIjNMGRkamxaeF2y1OnZe quzoOwubu6liib/1F4d0ds/5k7C17GEPI8OJ9KM7rm7nurEgfftVhaDCTXb7rtWLfmaeOWtSF0N 2+FxGAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

The lack of get_direction() callback in this driver causes GPIOLIB to
emit a warning. Implement it.

Fixes: e623c4303ed1 ("gpiolib: sanitize the return value of gpio_chip::get_direction()")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 drivers/gpio/gpio-max730x.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpio/gpio-max730x.c b/drivers/gpio/gpio-max730x.c
index 84c7c2dca822..117a9dbff9c0 100644
--- a/drivers/gpio/gpio-max730x.c
+++ b/drivers/gpio/gpio-max730x.c
@@ -160,6 +160,31 @@ static int max7301_set(struct gpio_chip *chip, unsigned int offset, int value)
 	return ret;
 }
 
+static int max7301_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct max7301 *ts = container_of(chip, struct max7301, chip);
+	u8 *config;
+	u8 offset_bits;
+	int ret;
+
+	/* First 4 pins are unused in the controller */
+	offset += 4;
+	offset_bits = (offset & 3) << 1;
+
+	config = &ts->port_config[offset >> 2];
+
+	mutex_lock(&ts->lock);
+
+	if (*config & (PIN_CONFIG_OUT << offset_bits))
+		ret = GPIO_LINE_DIRECTION_OUT;
+	else
+		ret = GPIO_LINE_DIRECTION_IN;
+
+	mutex_unlock(&ts->lock);
+
+	return ret;
+}
+
 int __max730x_probe(struct max7301 *ts)
 {
 	struct device *dev = ts->dev;
@@ -189,6 +214,7 @@ int __max730x_probe(struct max7301 *ts)
 	ts->chip.get = max7301_get;
 	ts->chip.direction_output = max7301_direction_output;
 	ts->chip.set = max7301_set;
+	ts->chip.get_direction = max7301_get_direction;
 
 	ts->chip.ngpio = PIN_NUMBER;
 	ts->chip.can_sleep = true;
-- 
2.54.0


