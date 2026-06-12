Return-Path: <linuxppc-dev+bounces-22560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA04CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:48:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMpP43hrz2ytJ;
	Sat, 13 Jun 2026 00:48:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270822;
	cv=none; b=VwfxuYy6Z0ld+XcCm0kputo85ljafV7IpA7W+CFkDQ3R/1NsR6hi0QzqGMJRVtGkIU/c4dj8PC4Qrllb/qz2J65yjDyQBkVVkxslNBU3oIcFXMz3dSjGkWwCzDm5FvIWqdvZqM8S/fxGaFZFlZtar44JPMSocYBlb4zvYmFLaSy/0mPaG6VaadRgeYgICOcZWGMDXMBZFv62Sbcidnuu8CLbdgzCkt04wV2NTpxgpzLsvz75jsorROMnBm2m/v60efi+h8E4T89/ix3bVJrkeHkGY0paYKX/nPw1HpmlH/nuD6nYTOPuMpstDCOqrM9oAIlY6pK3N3RjBJrqkkBdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270822; c=relaxed/relaxed;
	bh=cVG10nqGoE52+XgCg6Cv77s0dTJbAfaitc0NFuAsjtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I664GGh/HYRb1eTPgCYIEQXW3K41A1rF372NtYDo+ftWOLZSVWa8RWeO8gPvSWkujwO0oJ7nba3kac8ejttV/Aj7VH8kVdjSucfHGUQ7Hxi5Om3F4puvGyRLRp0Tn333OvF8TRhi43cRQq2QPb9i5CBf04D6/0qxBGEEn5PEgCvkmOa9cO4iHJCGxvH9aaHtBmcjqaJpA4cCbhvWmTWB5xoaoWsx/HEO8ynPW6RbTbHKT7ekImJzkrEzwwk7byxDCAlAFjrodJC7b5w7XtABS1hfC+g5VH5khRY9ZZh8Xg9Qq7PtRDK6nIgD25UZCbrH10lGb065LAOF59lDr9atfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BncU3sQS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BncU3sQS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL052rwQz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:00 +1000 (AEST)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-3075ce9c05aso2129605eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270817; x=1781875617; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVG10nqGoE52+XgCg6Cv77s0dTJbAfaitc0NFuAsjtg=;
        b=BncU3sQSdcwZIu/LeEGrnwem8X9CV4R0jqKv7qqG+etXMUJI61FYtWVymQnaLG2/Er
         iqoc3gB2WiPr5TYe3lMysn1p0pYxv9wRPWgsoLa2hhL73J2N1dUf1LDMZrD21sfRjOBb
         Qs8QV4mneda1GjsVtki3i4rLY64gsLWcn7Eh4l8Ko+JONoD/IA4ytl5umK4D/iP83NCt
         en6bn1lfoSZQuIKlBl+CMb5V+68lI6lYYeOhuf1PArmkqGHP7mLxLIavJzw0DzHWl9tw
         x4FtUVTt3hamGX8S0vI9TKwzWVeDh+vBkI+OjbNz3s6XCTknwf3rVD4ckmlrtAf0HaEi
         Dxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270817; x=1781875617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVG10nqGoE52+XgCg6Cv77s0dTJbAfaitc0NFuAsjtg=;
        b=geTDOJr5KJApMAtI7tFamnHPrK6X20YsOalqvMxYkcQIfCQ8oKTrOR2SzQyo0ccBKa
         11Sc/d3ujP9TA63HIu374yzKGQv0l2N0E7Je5Mb1HuX4+4G9mnEL3cgw9WYT4Wp/Up1K
         MYlRTkw2nL7Mi+9otGZgnsHKqctCe8mNjVAR29l2dtJceUYODotXVH0pGAFSSAzD2Ds/
         hl7kXIEfadC2dJL/W1NW3M+rwoFLP29ZsaTDViFGlX4vDGqWpJmY8Y3+o/r8VIZ9J2M/
         RHFPShu+IIHHyZJLqcqyYeOKZvlcn9OHe5UbHTI+hAkxfUM+/AVtxOeykoAjupB7PksM
         1UaA==
X-Forwarded-Encrypted: i=1; AFNElJ/3Jx9cLOsf8iGBUHHrV5DwUCIw9pwIOROxtfK3gL+9c+gXmBgn1wQjILb90ZhMjssjMNOo5nXSpm0JjpY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yynb99vDP9h5Cw2N0cRTQZxaXiKtKI2vw23sqTCs2LCIMBD5X9d
	2X0VICidWY9CIJl/XnuXWeR5cEnzzpTUmsRMiEAvkDP5fkYB6ivbRvWl
X-Gm-Gg: Acq92OFm7PlsoFk2JExla7FQhB4n9qa1a3Xcbqm463jopwasB0OEvPaWakF5WdTzeqf
	Kv97CGZy6oHphmiIqkVyP7xV+nY8ZWujXsvSeFZtfg3OOY+sK+5jOjaHIApwuonp6nSr67UHka5
	uvMIuyad7KkM0LzJ2uKjIxRLhxWIyhV2Km9e7aWJtJJXnGGqprKFByvt0EzgHjt1UVCeAAwB67x
	9bMqPWNCc3nsmLZse3H+jBIUO86H0GTCMKbbwh9eE2T2pZeAFjJ/ezDQ7/GJLDEmK8BumU8JKA+
	jn9RqI2eK1HQ9wg+krbXG/m7s7jxmxttGqcxlhc0VqXV6vkSavCUCTjfy8LBqp+mJBmTy52fFan
	muCTbuiQPVLHFdZc2iNuwXwUPZBD4smIm8RYnnx2Ejt92uvLEIxs/VKacnor2HF/gaB/8W2oF85
	No0wUiFueM14td1Y0yzhnKbfm7xTQ6QFGZZA+Pf3p85vJg+l3qrsfgOiweMA==
X-Received: by 2002:a05:7300:8b84:b0:2d9:ad46:4a92 with SMTP id 5a478bee46e88-3081ff8525bmr1726924eec.13.1781270817309;
        Fri, 12 Jun 2026 06:26:57 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:26:56 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 00/11] ASoC: fsl: Use guard() for mutex & spin locks
Date: Fri, 12 Jun 2026 20:26:28 +0700
Message-ID: <20260612132639.78086-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series converts mutex & spinlock handling in the FSL sound drivers
to use guard() helpers.
The changes are code cleanup only and should have no functional impact.

I have compile-tested all affected files except `mpc5200_dma` and 
`mpc5200_psc_ac97`, as I have not yet found the correct configuration 
needed to enable those drivers.

Best regards,
Phuc

bui duc phuc (11):
  ASoC: fsl_asrc: Use guard() for spin locks
  ASoC: fsl_audmix: Use guard() for spin locks
  ASoC: fsl_easrc: Use guard() for spin locks
  ASoC: fsl_esai: Use guard() for spin locks
  ASoC: fsl_spdif: Use guard() for spin locks
  ASoC: fsl_ssi: Use guard() for mutex locks
  ASoC: fsl_xcvr: Use guard() for spin locks
  ASoC: imx-audio-rpmsg: Use guard() for spin locks
  ASoC: fsl_rpmsg: Use guard() for mutex & spin locks
  ASoC: fsl: mpc5200_dma: Use guard() for spin locks
  ASoC: fsl: mpc5200_psc_ac97: Use guard() for mutex locks

 sound/soc/fsl/fsl_asrc.c         | 10 +----
 sound/soc/fsl/fsl_audmix.c       | 11 ++---
 sound/soc/fsl/fsl_easrc.c        | 36 +++++------------
 sound/soc/fsl/fsl_esai.c         | 16 +++-----
 sound/soc/fsl/fsl_spdif.c        |  8 +---
 sound/soc/fsl/fsl_ssi.c          | 13 ++----
 sound/soc/fsl/fsl_xcvr.c         | 29 ++++++--------
 sound/soc/fsl/imx-audio-rpmsg.c  | 25 ++++++------
 sound/soc/fsl/imx-pcm-rpmsg.c    | 69 ++++++++++++++------------------
 sound/soc/fsl/mpc5200_dma.c      | 56 +++++++++++++-------------
 sound/soc/fsl/mpc5200_psc_ac97.c | 34 ++++++----------
 11 files changed, 121 insertions(+), 186 deletions(-)

-- 
2.43.0


