Return-Path: <linuxppc-dev+bounces-19260-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A34D7308A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 03:47:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn4Rg2H2yz2yVP;
	Fri, 03 Apr 2026 14:47:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::e29"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775188047;
	cv=none; b=hMTOfzzRxDG/ViBaq5PNqqsfR2WMFtJMly7bOdDTQ+9J8j84EebOx9SPu5Idl8IbKvi1oewvcpgoPu9b9O81lYMn1hDQMO+/cRJ+2VVkab0PTr3AEJ7DjbkSJV2orGaj4DoE/LszbKj6Wb3s21X5UTja8SWT/SL+qDEyn0m6BIBR5woHlGYKZs0z8sZJXRUZh3K/BizxpNrdz7QgRo34gvTRtO7EhGTHtrDyMw1GY/RlNENPtVOVjaH0fCK8dxI+jm9Q8yDSLze4xlZJeSy9UdGsruujcvkkdaw+CipoPj2a284jBjuP2Sb+T3V7QdsOVVbAv97g1uW01bdpEPrE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775188047; c=relaxed/relaxed;
	bh=mQJe7gr2NY91HuvsDinY38MzPt4uB1n6FAVnHxFtD78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OyAKH5AOSyhYQZyM895pqTQvd8sTnHQzi8VK867fqO4SmdNki2jISfuHBlHgU0+PFj9wIxnM0GpmDrF+4Et1Xx8jocQdkAUPDiaKgya88jWMEhOZzQsxpCEgNlVtcwhKXEOlkjjTokucG9LZnExe/3p5CQPlwZRt4xcCJvHGZ0tSCvLEvc+9zu10TSF+FyoO0r071Kc96pK2jo5MoYe60jO3S4wmS0p/IYugTtX1kekMdDpIlo5wXKJhekL0orOClV7J6YYpbHkMbAFZCKhky+CUjZOczaLCwwSizZ9qVsH2Od6F98VSG38RDihw+zOSxb6dH5yhUgE7TnyumNilLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RcxyHDGg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e29; helo=mail-vs1-xe29.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RcxyHDGg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e29; helo=mail-vs1-xe29.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn4Rd64F2z2xln
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 14:47:25 +1100 (AEDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-6055a0414d7so517068137.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 20:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775188043; x=1775792843; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQJe7gr2NY91HuvsDinY38MzPt4uB1n6FAVnHxFtD78=;
        b=RcxyHDGgB4w/xE8ylOOaJgvH+gdjPMwuVgING96KnL5hFP+vuVH1khelLyA6S+k6pT
         7ZB4VrkqRmrzA9Ka9wb6OBcKlutYBn1kP+VQqIZY9luLTHJ5RV7nwgnlcG09KZP/vdBd
         TMPGSU02GTHQ4J3QVm93kBksW/b7XrE2Km8xznHA8r7N+Ju/kjVtl/tGHWmSG3VJ3HEm
         MgGbPP2jpSWfPXBkH/RRgKQMIBx1rr76C4Kg01e9JL/Our5mjQfc7iyZV0N5ey0ZCwcV
         xL+eWZezSKQrjlhZbY1j8Ep4j1M7Nsz9C0bq/HI9msQpjYHiSuyJJL3f6WXrBidnbgHD
         5mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775188043; x=1775792843;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQJe7gr2NY91HuvsDinY38MzPt4uB1n6FAVnHxFtD78=;
        b=svayTnoyUYLhvMH3RTnGxVchpZubaPV4IPGdj2B/Bj+w1ojC337fTey9dB0y6OxC38
         hJmMt2n3y5YDkHctmpEtPTtTWTDGODbR1QBAcACS82bsxoKLs7oK/E96IIdvX8+0e8fM
         TJ8tX4qGHKFKfYApdNf+Ekw7fP4WeAJeHYozQb4k6FzfjSoorh0C1H+mPi7RkpRVqsEM
         LuKyygjr/H8yMjEkvCbNXzX5C7xIyZZINCCDiBp0FG72s5VF6JQV457InQwPWvD6eAiH
         6Y65BZ1yRwbsEMz0xF/AE+2T1oj5vPE8kTZGFk1C3/V/1mmfUvgBDLmkEV4wP+73xmA5
         Lb3Q==
X-Gm-Message-State: AOJu0Yyd52LIS/iToDEPABPIKj4OT3aBgXmKhTi89e+iRWOM3B4nV8+p
	YR+jDsVNu1A2bqadvMcRl4Zn5ePYCZ3NKvBEp9OdgTsI59CdEwvPmQYk
X-Gm-Gg: AeBDiev7b+FG5N+U/Et8v/1eRnpnNQWKcj4ezi55esmTChmOFSZPMMwMSgbUfedQSf5
	vWXvKXFSp/R+Gp1UJZu8EWa53PX406xCT+miNKi369+8sURprUVOYqwU5xPTx+kpLQPG6f4R6Kh
	l6HHcNB9XM+dnAx13hGccHSmra3IPcDx4BnSPN8ZTG6QsQY9y6l/nYIytVouph67Ihl0vVkySvC
	KFScYs8xzGWKP5SzrF0kM+WlzDr2UNWW9tWqiJ0J+oSCSiozH6AO4tMVPre5Csdrz9mjAGqBmk6
	EUovt67NkyNO89NGUZzyID1caNhGJ183a/1/w8oiyz5RPiVwMVCW72dHPTUBwbOfdIK3LK6SYi5
	5pYn0N9kRMFyaweumwtLS612+VNfa4R8b/Km+E1lIYpODKc18YUyTYCC5jP4N8GEHyq1A6N7KjV
	FBspRC1XxKfpsF7YtisnoLppruCBIYGw9rgh1EjXfvrR7QdZOtUkm4Pub745Kh5+ahpKUbHCcV/
	8Hm
X-Received: by 2002:a05:6102:5107:b0:5ef:2457:8015 with SMTP id ada2fe7eead31-605a5099bdbmr580390137.29.1775188042928;
        Thu, 02 Apr 2026 20:47:22 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-217.user3p.v-tal.net.br. [177.4.161.217])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60583049c1esm6652525137.8.2026.04.02.20.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:47:22 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Fri, 03 Apr 2026 00:47:13 -0300
Subject: [PATCH] ALSA: aoa: onyx: Update IEC958 sample-rate status for PCM
 playback
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-onyx-spdif-pcm-rate-v1-1-dcfaf931cf83@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJKcUQr2Jc1PKDQ2JpOmAwh
 Ltbdfkt3ttJkQVKl2qnjJeozLGgPlUUHj6OYOmLyRp7Ns7UPMf3xpp6GTiFJ2e/gBFca13j0fm
 GSpkyBtl+1+vtb13vE8LyXdFxfADCTi1WdwAAAA==
X-Change-ID: 20260401-onyx-spdif-pcm-rate-ec45243ae8a3
To: Johannes Berg <johannes@sipsolutions.net>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=i+jTnj9uWTVTpk/43LHEyjWkuxe1ecxKHb3ofhIcLBI=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJnnLdxF6urnCQd4eJhyftXVm5b8Lezv0c8Pn02ZpLFI/
 Ulvq7BDRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAExEy5CR4fdqDs7wG8KzRU1O
 7Xx6u1swOOzY4ZlpJ9ZuN/s3LVlE7xHD//CqMGO1YHGna4In6nzfJXNfagrYclny1+Q07Zgteia
 /eQA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

onyx_prepare() accepts 32/44.1/48 kHz PCM playback, but it leaves the
Onyx IEC958 sample-rate status bits at the driver's initial 44.1 kHz
setting in DIG_INFO3. As a result, 32 kHz and 48 kHz PCM streams
advertise a stale IEC958 sample rate unless userspace rewrites IEC958
Playback Default first.

Update only the consumer sample-frequency bits in DIG_INFO3 from the PCM
runtime during prepare, resolving the long-standing FIXME in the PCM
playback path while leaving the other user-controlled IEC958 status bits
unchanged.

Mark IEC958 Playback Default as volatile as well, since prepare() now
changes the exposed register contents outside the control put callback.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/aoa/codecs/onyx.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 04961c456d2c..6e2da2aca2ab 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <sound/asoundef.h>
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("pcm3052 (onyx) codec driver for snd-aoa");
@@ -514,8 +515,36 @@ static int onyx_spdif_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static int onyx_set_spdif_pcm_rate(struct onyx *onyx, unsigned int rate)
+{
+	u8 dig_info3, fs;
+
+	switch (rate) {
+	case 32000:
+		fs = IEC958_AES3_CON_FS_32000;
+		break;
+	case 44100:
+		fs = IEC958_AES3_CON_FS_44100;
+		break;
+	case 48000:
+		fs = IEC958_AES3_CON_FS_48000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (onyx_read_register(onyx, ONYX_REG_DIG_INFO3, &dig_info3))
+		return -EBUSY;
+	dig_info3 = (dig_info3 & ~IEC958_AES3_CON_FS) | fs;
+	if (onyx_write_register(onyx, ONYX_REG_DIG_INFO3, dig_info3))
+		return -EBUSY;
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new onyx_spdif_ctrl = {
-	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
 	.info =		onyx_spdif_info,
@@ -695,9 +724,9 @@ static int onyx_prepare(struct codec_info_item *cii,
 	case 32000:
 	case 44100:
 	case 48000:
-		/* these rates are ok for all outputs */
-		/* FIXME: program spdif channel control bits here so that
-		 *	  userspace doesn't have to if it only plays pcm! */
+		if (onyx->codec.connected & 2)
+			return onyx_set_spdif_pcm_rate(onyx,
+						       substream->runtime->rate);
 		return 0;
 	default:
 		/* got some rate that the digital output can't do,

---
base-commit: f16695c0dc9db64f0a5a9871a10b70daee2653e3
change-id: 20260401-onyx-spdif-pcm-rate-ec45243ae8a3

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


