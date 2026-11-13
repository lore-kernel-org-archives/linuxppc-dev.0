Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF0606A330
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nrUyMF8z
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQldF57dwz2xnn;
	Fri, 13 Nov 2026 16:08:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794546481;
	cv=none; b=mlayc1H6xHYwZEbaOjrn1amJsmmjeIH/Xz9RyEl5vpksnypC0iLq7WnsoZ1VpkbpkkWzrRUnmyUe6NhenHfsMJdk4WI+ER0glT8MZZm+IWyToW0d14mCof/wtmpg4CxVmDQ96R+K+PjcXtAN2dKzMsZdLTAZX9XGJtSREeQ5NHDm8W2VJG1Wew5y29EZfNhlhHeW8Ma4ci0JqpfdvjADwP9NlTaudObijd67OhDpH3azP6BuvOeZgWqYBDCTnc+R4ISPy8NrcXFlOOrIcBFoQlfrUcumbyDtfrSxhoqWArs/3EciRY6TmsLmJ1dtIlN9JFU0hu+lFw6W20o6v0oIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794546481; c=relaxed/relaxed;
	bh=W2Yp9Za6L9hqRc0w40QLKrtVSVZ2CNI9cglsNjGbvpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fezTcbmJFmk2eYNe5UcTNvgIP8NanREoejIWvNtOLOgpJGIUI+OA32+EQOgsPR4VZcqBj24RNLgBu5olmrmCrC7B101X63LmWoKq+ZmHDmiBSYjFUUBEzVe0mSl/DMkbhm9F5injrx61qMYrC5RCk6W4Su10lX8VdnNDiM/c2OYm0tEqqR7ZKuBMTalvWriaQOg4rN752PpIKxGM3gZP8PzPxV3GZ2DJ38sHtJNIaGStU3D405yzdgMmrd5SYEeN0XXzPZ8kTIrDVF3JNImUEjKvW8jZa1omE7exwktKu+YWWRg2hRkAfuZn5Cp7bxEeIceRFjEf/jq5HE/k+7Nnxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nrUyMF8z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nrUyMF8z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQldD6xbKz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 16:07:59 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2ede7cb02daso11982845ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546478; x=1795151278; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2Yp9Za6L9hqRc0w40QLKrtVSVZ2CNI9cglsNjGbvpA=;
        b=nrUyMF8zJjv+lgi3/1zGu98uWvVSJf+3nlOTVX0FLq5tZUuBJlw0tNImg3t3N4L2Nv
         XAw2dZK0FZGtxC0P7bUwBD43HPpohMMFIKPf9NqSpC9JczIms9CP52J2TdKw7krMH/Xk
         7JUlpsRuDab+EPYQiGuydvk9ak1bbXdBw0dRfRWxzkLAwaNn4uBEuSaVbAjLYtYImEgC
         YyNwk4CDhuOUiOJwjFceNzA1hGrlU/g/3BhzhfIXMcQP1v5WOkztAW++hPlRCXKOyCX9
         DG0hDIsDAqeZdxZa3ucQkD7I8Y88oBu5l3YooKEb9OdqdOR/zTXWcUuL/0EfSz+K9gLG
         J6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546478; x=1795151278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2Yp9Za6L9hqRc0w40QLKrtVSVZ2CNI9cglsNjGbvpA=;
        b=YbjuWTIIm90bU/dCk8YViM7O+GKrQzVGKYQGb1yiydctXhVnM/mUgp5AkoxOORYiPL
         98+3EdOcXP5TyhnexfZHKUKECv8KPHaS66Xn67qLDYp7h+fBvfb6jc441PJXsFyK/QOK
         Vmh7rhHmYetUU7BgHjfhAxwF75Dv3mtQaR0N2nrn1xwdNW1XqtGVaJhZOr17tx9vIK+L
         s8ZAWcSRBJQoiHFD+2504an11Ga27P3Ox786Sn+c8PUHGQQcCzspxV1ktlS4rLQxNNy4
         VpTNlBVmxiZAFqWk+896kz3lHWAyEnsqyg1LWM9O/RccfCwYIDSu3JPXH4NOkpJz0los
         iGTA==
X-Forwarded-Encrypted: i=1; AL+hErEdcbG+N9XtPh0mHvowCxhWl/39tLFsaGWS4qlzkXqST16vjUcgbCGZP5NKUyMk0gBlaBjxJqtqGat2V9k=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9pGoVgO1HTwfk0gVnx+MYV1kzemwLK0EpuGysZ1Ax2O1yLhKXb
	qRmMgoE28Kp7hAD+yqLlZgokOAeIPZaRAqaKbRRnxqdz1I7Nh518U6eD
X-Gm-Gg: AYBFou0t6eQM1HnFnUvP4xbEjHEUh8NH2PNPjlADVoUPUvElPR1c5j/I4DFZNGxfZVo
	pnFIhTdwPy7vMKuN+bbC02gLWwLKzBrjKn24101LM/pFq9LBBoVo5bplskHZok+TC3XDK9Wb7f+
	cvtNAlPBnq/u+diiWayBmPH/UiuUJVH3v7Hmd3yJKgwKzAuFyq/j4LPcvQJng+7Wp72mHmiB6Pj
	AxumODwL2i63POdmvHtD4YU5ouqq5xFBgMpQCTfifex5WqRQxR3lCfdP+jKsQx7Sp3kWKXw6/Ak
	4NFJFgV+8ZC1YEeeZDPOd24ylHbMA6vGNQ2KJ2azyr3GNl4xi3bdLh1zaDwm8OfDE03n022F5ug
	R/zTerD9Qog+NoNE5L/GlOpVZaZsGo5HvWAvEXskVEGhHECLjspfTxdkEz8ZDyhK7VgVhFkwQxV
	ZCXq/z9PpWooXCvJsh33DbzHbKXMCdKRZhhTSxcYP1P1MpeOOiqOqmnspk/V8xzOkHloFTZ4QNz
	UGIw45SsjJd7oePoHNtvMXah4mH8nNJJcsva2FCT1F0XCn28+Ctx7DuVINiNbwg9WyI9rbG1KCK
	nF5hkL2P0R+q4GGFk70IYgZ6ofgsYXJJs2tZIxcLExxA1dACj5ssqVJqROYYKf1vUzkzLWTLThg
	kd7cuAcztGTr16f6iKzebyarU9xi7PeEt9inC94Whongq
X-Received: by 2002:a17:90a:d60e:b0:3ad:677f:567f with SMTP id 98e67ed59e1d1-3b1b0d7622bmr689241a91.40.1794546477658;
        Thu, 12 Nov 2026 21:07:57 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm7643420a91.16.2026.11.12.21.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:07:56 -0800 (PST)
From: phucduc.bui@gmail.com
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 0/6] ASoC: fsl_asrc: Fix probe and resource management issues
Date: Fri, 13 Nov 2026 12:07:21 +0700
Message-ID: <20261113050727.14053-1-phucduc.bui@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series improves error handling and resource management in
the fsl_asrc probe function. It fixes deferred clock handling and
runtime PM usage count, ensures the IRQ is requested after device
initialization, and moves runtime PM cleanup to devm.

Link v1: 
https://lore.kernel.org/all/20261112105116.32274-1-phucduc.bui@gmail.com/

Change in v2:
 - Update the commit based on Sashiko's review.
 - Add handling for CONFIG_PM being disabled.
 - Add a patch to use devm for M2M cleanup.

Compile-tested only.

Best regards,
Phuc

bui duc phuc (6):
  ASoC: fsl_asrc: Improve probe error handling
  ASoC: fsl_asrc: Fix handling of deferred spba clock
  ASoC: fsl_asrc: Fix runtime PM usage count on init failure
  ASoC: fsl_asrc: Request the IRQ after the device is initialized
  ASoC: fsl_asrc: Use devm for runtime PM cleanup
  ASoC: fsl_asrc: Use devm for m2m cleanup

 sound/soc/fsl/fsl_asrc.c | 113 +++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 51 deletions(-)

-- 
2.43.0


