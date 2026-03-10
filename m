Return-Path: <linuxppc-dev+bounces-17956-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56001EB1049
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:30:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVVWZ3cYlz3bjb;
	Tue, 10 Mar 2026 21:30:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773138618;
	cv=none; b=cxrgNZQt/2plgkyCA6utGrxCuqdEMg9e+bL6h9diPPRN8aevn2aFI9WC8VIy6PE4J5dn+wmU7LiZF5ItqH1nvmUec8SgiyaMaexxGNbhOwEmaqpzYX0S4/qpKx3+DV+n3Y0eotM3Ag+aDsmEzCqMwfoNJ1sBbPDLYkGNSwu1t1yUfVjCGZELPsiT2GCsN4VEFVlzv1fq9uMHlYnN/gfgnRmdjf0Vs/2H1ykoV4SOIxJ8kiANL8IWtwfj4vN+HTAltYNzicQNLiN6UcLArcKVP1Fm9h7z299KMITvIK/Ie53dxnyjdhdwjT35pJ+EZvwLe4YImMNsVDc2aE99u0aOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773138618; c=relaxed/relaxed;
	bh=fv6YFRUsDV06wkSX3KXOKXjQRxlArAIWy+HcwNc0XJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E5MH32v2wqZOZkUai3yLD5n4/OGlBtQiai/QsNDoHIotX1Cr23MH1u2YgARXNppby+o3UZ9EC5ClqkhtqZR8gvaH74dZdnsIUMplmV40jZHuNhuK/VWx+p0GHUCNlWIPWJeCBvhCs2oF9Xvw9bnnaSprdS5g4oHwhEWZ+iUpBly4GoZAwwFtTOjc9jEcZMVnptAgpHnemCg0vSqQQv3+GXElFT2iu4LZoWnp5xThCiDEVh2DFwz2zEyN/HoyxpQqI4SE+zSjsTVgZDAgrwNPTVgJmNnk1+gJKf1K2yAaIj5h890wzT8O+qwv6OmCqJmoycuaDwr7nR9zvVukujQMZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G67fPErc; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::; helo=out-186.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G67fPErc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::; helo=out-186.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta1.migadu.com (mta1.migadu.com [IPv6:2001:41d0:203:375::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVVWW3J6Hz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:30:13 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773138594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fv6YFRUsDV06wkSX3KXOKXjQRxlArAIWy+HcwNc0XJw=;
	b=G67fPErc8ib0AE4WdSF44K3UjNKPw6x4mS5Ahgb7x/yUlKieF6tz5PY17zp9sEi9eN82yE
	njs0oxaORP/ucGUcxR2BCsYcFDE/LQRqV4gOn+qt10LhXXmuRNX3bkvkMo/Hy6C2ek2YW3
	V/Fj5d7iLSjVLChE1Shz5VLx7hh06EA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
Date: Tue, 10 Mar 2026 11:29:20 +0100
Message-ID: <20260310102921.210109-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2923; i=thorsten.blum@linux.dev; h=from:subject; bh=PnfNLx9HNmk+snC3uutNYRIvphS+pIovbD4q3xU8mag=; b=kA0DAAoWXqtxINjMdS4ByyZiAGmv8oGijncZDUbv49ULrvxeC+UDjQ1uivJ6TSMh8x4hnXgnX 4h1BAAWCgAdFiEE4Jr4mE11fHmyNFi5XqtxINjMdS4FAmmv8oEACgkQXqtxINjMdS6uTQD+Kp// FSSw7mMOZNBYb3fSW1OYnYNgf0wioNwpAZnpTcQBAIfHvYiZrfP/U8GZ8CvXQiGWGuco67cbHwV iUH3Nu/4F
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In i2sbus_resume(), skip devices with an empty codec list, which avoids
using an uninitialized 'sysclock_factor' in the 32-bit format path in
i2sbus_pcm_prepare().

In i2sbus_pcm_prepare(), replace two list_for_each_entry() loops with a
single list_first_entry() now that the codec list is guaranteed to be
non-empty by all callers.

Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Skip devices with no codecs in i2sbus_resume() and use
  list_first_entry() in i2sbus_pcm_prepare() now that the codec list is
  guaranteed to be non-empty by all callers (Takashi)
- Link to v1: https://lore.kernel.org/lkml/20260309114159.765304-3-thorsten.blum@linux.dev/
---
 sound/aoa/soundbus/i2sbus/core.c |  3 +++
 sound/aoa/soundbus/i2sbus/pcm.c  | 16 +++++-----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index f974b96e98cd..22c956267f4e 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -405,6 +405,9 @@ static int i2sbus_resume(struct macio_dev* dev)
 	int err, ret = 0;
 
 	list_for_each_entry(i2sdev, &control->list, item) {
+		if (list_empty(&i2sdev->sound.codec_list))
+			continue;
+
 		/* reset i2s bus format etc. */
 		i2sbus_pcm_prepare_both(i2sdev);
 
diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index aff99003d833..97c807e67d56 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -383,6 +383,9 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	/* set stop command */
 	command->command = cpu_to_le16(DBDMA_STOP);
 
+	cii = list_first_entry(&i2sdev->sound.codec_list,
+			       struct codec_info_item, list);
+
 	/* ok, let's set the serial format and stuff */
 	switch (runtime->format) {
 	/* 16 bit formats */
@@ -390,13 +393,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	case SNDRV_PCM_FORMAT_U16_BE:
 		/* FIXME: if we add different bus factors we need to
 		 * do more here!! */
-		bi.bus_factor = 0;
-		list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
-			bi.bus_factor = cii->codec->bus_factor;
-			break;
-		}
-		if (!bi.bus_factor)
-			return -ENODEV;
+		bi.bus_factor = cii->codec->bus_factor;
 		input_16bit = 1;
 		break;
 	case SNDRV_PCM_FORMAT_S32_BE:
@@ -410,10 +407,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		return -EINVAL;
 	}
 	/* we assume all sysclocks are the same! */
-	list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
-		bi.sysclock_factor = cii->codec->sysclock_factor;
-		break;
-	}
+	bi.sysclock_factor = cii->codec->sysclock_factor;
 
 	if (clock_and_divisors(bi.sysclock_factor,
 			       bi.bus_factor,

