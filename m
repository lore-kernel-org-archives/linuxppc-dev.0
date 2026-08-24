Return-Path: <linuxppc-dev+bounces-26065-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E504BC5DF94
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 10:07:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hT66Y05gcz2y2c;
	Mon, 24 Aug 2026 20:07:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787566068;
	cv=none; b=a1N7OTNhDcOMfXo3UMWv+UleNlIuMMknUwkow76wvNiTpuuypAe0m67ilu/qENi6fxP0cahcd8r51g5FJqUYr9noNpI6NMWR3HRShcXg4xzgx0w7EdoLYuQHAidFbO3w9EFi3IzlE6NYa8UlJpIJCyBCXQuu9YOqHYVr8ZNN0iMd6S3CMpm70noaDG1VA9ltsuM461dlz8mxlPaH44Fx9wG6LgSr0QPCXNXlmMq53EcLhiVPWEICHPydFmTXS+AR3p53CO1iFtCGuqDllJpLXHtRuLrSHCraisQ5v26FoHMgoZ4TQgYOI52yRf2fPS5LSd+zY4LJyZozANDvT7UDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787566068; c=relaxed/relaxed;
	bh=I0etaik6WYExchhy19XEVUSW7e1ryrbbO6lOF0t7pQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnKFDVRmdyVgHAOtPDQrjwIJMIywb7dBStbK6sfEDlHD0yqWCJhSZ50vunW2fT2kOll2qKUJGifakeTGO2lR2GuAxXQZM3c3TZBJvQQmUiv79TQhm/LRd8V2MbtNJXxYz0Smi15OvDph2p0ZUNI18ZwuTBbntY49jANzg8VfdWP2m72lHbUaviQLnkEglAFFqDBINYZYL5qhpSvtVm3i7Pa5EkTo96qRHC43O0wq1QQk66G0g4mEhrcc8g2KqmsbsqfjpqXbTillpSSUpqp6wJJjIcCFza6aCEgJ9drwXxYPH4iu/lTNjOrcXNVVgl8w5kLAYbu/VIjZ3vz1hKgqmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NdHaNVhA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NdHaNVhA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hT66W1yVZz2y06
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 20:07:46 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so3365039b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566063; x=1788170863; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I0etaik6WYExchhy19XEVUSW7e1ryrbbO6lOF0t7pQM=;
        b=NdHaNVhAYMaV3rmnU5EUkC9sISdlGAdiscgbzKNIGQTGvn76T4rU1aP06eIzA9UUsg
         xAick5HQVR638J1h6toEpD+Jd9phVWE8bwoleqXGBmMe3ESnaZFfwdSvm/WnpLyVflsB
         v13cNBeORJ2JxgfajQjEj6aSUczNH58/ESI3d/Vl26U1I/JAKX68Fg3+02F/jzgVyx6m
         EdH1DH/hAToeqEFhz7imBUQFgPuIbl+yzJLxAFfdcOIRWpYnYcjiGRUU2mu215QJJA9W
         dtxfvXuH6RZLI/tHTblP2AcdqUjm5sZHYGHr9VmBqNibHEUwYSUtJssQSzXwcC5+bN0T
         OsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566063; x=1788170863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I0etaik6WYExchhy19XEVUSW7e1ryrbbO6lOF0t7pQM=;
        b=LV5Wr60rhuaKxJmjiq4djLB6OWj3Jl004O5mY7V+5mAiGBx5po4L0dgR+ccPGzU7yQ
         9dxt/ire1IEXcCA1YKthlL0Yrq1Tyt9DWor3oy80JQ1hM5rWWqhyUtZ92Gea2E0fqM26
         bomSy9ddYJUA+4xg0P6M+4jkJJVCg/tyo/tH4HjrTDLA37wpnrbturID/sQ6+NvuImE+
         50QDC4n4UFeaM6/ePH2vaXRfSaT0jUOB6VR4wVhwsKr/BtgYGWmbc+U5Ym0CohQqi6Im
         RFshoZUkNAcuWr56paT/M8xqvkT6Q22ZXIwYt4OdqnuZddw274LWUY965nv82L00YpC0
         09yA==
X-Forwarded-Encrypted: i=1; AHgh+Rq62iqv3uNE8NeOI4olyM8QihynSGAfLPtreHIEln21UY9dKUKMEdFr69ZuWnre0Zycv+Gu8EO+0trxzQU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lYucIixdrmQio2RffUgmHoCix1I/QR/hpDqshNctnuPnyyymCc
	qlfXPnXSysXNlgwtrAlbDznW5bSq56IvHjwh7VcqqIKhJXpLHGEze8Pj
X-Gm-Gg: AR+sD13nW1ihWGKEmzQAVXHKVwMzZim6lzeNBUGtMKHwIh7a/I5FJV/aaigkHvtaPs5
	HCWIR6ly6JnjeRji6Ox2v85zW3lJmTnBkoWIXvKmqGG0RCC16XUFfHTYt+dxtC3MNLjiHZmbLQF
	szCasvdLW/QA8X4lPtsvmNuUXgDQATOMSMV44CmNTWpgg/RwQVjiOo9ZYOFcLW0Xcm9E9hUkzQU
	x03vYhLHS4gtBhGs8t5RwjQviQRv1WUp06oUcbLsCa1xGbH2hQTpOHdLuhLUZnf2jsPmp/cu00W
	FD2JBWOXzJ3Fe86n6FlbYXaejJ/b5q3k6KUj8AIYxV1J8z5aYvj7gDMBBJWWito/8MJuncKD1mO
	sYDB31rArNJZNumkHNJsxAw2skp/LVJVfoGFSxKUlRznm00eQEEgL33XQgYnbKXneToi9mPNH8S
	9vejLVNqDY2m1H7MtH2TXFTJAYb8L1DpuIWvDm5lDj2rQ0ULy+nf6Iik1fM2AoMT9QdQU2BqTGi
	I62qSQ0ARdDI4PwjLoC6TOPBgSfU/RJFJxvrtNueF+MelvQN6Dp0f8QNatpx2JIf/FiNKJS/Hob
	00Kl
X-Received: by 2002:a05:6a00:4f94:b0:84e:2f2e:8def with SMTP id d2e1a72fcca58-851f9aafc0emr39369376b3a.6.1787566063324;
        Mon, 24 Aug 2026 03:07:43 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed8b22sm1777275b3a.4.2026.08.24.03.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:07:42 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	cassiogabrielcontato@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] ALSA: aoa: i2sbus: Check IRQ before requesting it
Date: Mon, 24 Aug 2026 17:07:30 +0700
Message-ID: <20260824100730.31601-1-phucduc.bui@gmail.com>
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

irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails.
The return value was passed to request_irq() without checking for
failure.

Check the return value before passing it to request_irq().

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/aoa/soundbus/i2sbus/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 833c44c0a950..adf123dd79a2 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -240,6 +240,8 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 	}
 	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++) {
 		int irq = irq_of_parse_and_map(np, i);
+		if (!irq)
+			goto err;
 		if (request_irq(irq, ints[i], 0, dev->rnames[i], dev))
 			goto err;
 		dev->interrupts[i] = irq;
-- 
2.43.0


