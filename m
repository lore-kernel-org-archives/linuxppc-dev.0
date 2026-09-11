Return-Path: <linuxppc-dev+bounces-27163-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B44C88E4D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 22:04:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhT9T1RvBz2xLg;
	Sat, 12 Sep 2026 08:04:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789164285;
	cv=none; b=SEA8ZKjxCLJtaG9cQdGPNzdsA6f/aTmGu9rIkfkHbI5I5B10vi/oyfOF7ZFf6ZaWe0uy0A7+Q+4SzVRiUghmSfBSP8mSW+yv2VIjPSCvQdbyxC4WOLr+IXtnPoiBmfSD34iwk9pPGdcvsEHQ3FdauYUsgk927H09SDtMtfTStegrSH/F+cIbmcl/N37c4ulGi07fJZteoppptkNqXYSQh2GiVnvZsIZj7b8juwiehKPJOJqhJrtfEpxdskoWtRSIB08gCgngpv9ZmzFVQCFGiD/iTnKysQt23gnzgAnDvxt8ShBLJBgto5N2HdE1PdTm/Y8ZRNV0BQRWPLc7rWXUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789164285; c=relaxed/relaxed;
	bh=FA7/TxcROHvx3mFEUwRb/G8HDiCsuFllSkpMG3B1Mr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzS4p9Rw/h9+gKtniWMtAarO/+3yU6uid8bbb96sqNzgqOQkjG6aSmztxlFyQ4rJzxVgf813c4MSlsbM05IYep8RI9NXxfUskeLs7h2/anW1LzOr9Cjvv4UfV4oxmIr5S/afM38mdjtohQKzr4JaWjK8z3yI+k0iIL+SSquTO+KsqGYK9fd5OdFzlmNnSvJ5NzmstiN87O4J3ouy38ygEBMNdMiw56A4J30Wwf1kgHIOKtkkOVamSQLfDyq67FHk/6J19KhIaPJmEcB2EtM/BbbAd1hvMF6USHYEvSuy3bg4BtMHwFqTgiIOVMckUj2FfFd1m+jJzxRSMizxAFLKAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gi+sqh7y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gi+sqh7y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhT9S2t2Qz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 08:04:43 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4ae61629fso288619a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164281; x=1789769081; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FA7/TxcROHvx3mFEUwRb/G8HDiCsuFllSkpMG3B1Mr0=;
        b=Gi+sqh7yEER5oya43XeNltHlfvapupvXOQi1YfrF4Amd4Q81IEunvh9uNbW8gT0mER
         3TLs+r1/gsKPkqQ0bxthNGSGzrnWXsNqjPRzH7sskfXrhMV5oOWQfD6A9NMBsBJviEaK
         rzcKiHhtM+osYWImaKFXnkCbMEpQ9Z6VBUgSyVrJO4JzeN7KWcHdBnoYL9nRhL+owvJ6
         2RG4ECm67X/IWmrf+O6LJuXE2UHust5Fl9CCnJozag4iEpn4Bm3L6AlNuvWh0rNjZc9+
         8U51e55ynA/VL3+mwSHelh/kp/oA7epWt9GHCSzQv2KhNJZXNM85mM0vdqUoP3IljY68
         dl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164281; x=1789769081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FA7/TxcROHvx3mFEUwRb/G8HDiCsuFllSkpMG3B1Mr0=;
        b=ik60F6J3JjJK5yL9L9zXSVjDk4NCdCCGXmlqUSh0CPTb9y77a9jLEYC90SBG8bjzaS
         IHwHSbriUKv+tahMC+YHcjO/z9qkgCdgAw1ZTvLM9I3ufYHn5n2vkd7GmNGJm5/K72pJ
         Aq6JXFPH8m36LJ8J0CKj9OxIaBhYvkNzTGfAqJ5J6SbtMJ3eBrJkVgDMAl/yzaQRqWrz
         1LfkvxvviAkKMqoO/MI8Jv4ZuX1VGT7a67AqhLAu9QDgzztHauDtMkoqkFZh+k23/oTb
         rYd4oEzvw77pDsmhbK1rzw8+zQA0uAxiKugKWtXndXY/A13SLSyPS7cHTxa8jwV2DYX/
         +OwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyE1VP+d2HOrvn99+Vd3Zor/tFxQbm2RlXAqKO4p5EwZrb4t8J4FwdVBry5QTxvBpMTIraMAfRhvewmlQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mJV2fo0VMjLRf6tg6A8UctUYNDPWlpPwmQO4htSVXISbdw9GuF
	QyqbTUSaUkBc0TGQ4E5TW+4xlb87pjrrqpNAmySAqXn4SXlHwGa/pM6o
X-Gm-Gg: AYBFou3SOghOmN7jRUM9uI0W1tyXgLg5g05BIXXxydQ+urW3aEdSzlXbFMLzaRtsfFu
	ir4JGWm2JywgFLVhl92C++S5f0uK3iKQ7KpNi7ncDrBgl8RVG6xey3DI0LoGWAT7HXz1Qo7EQKZ
	V7gUe2RxEg9R+7qQF7chqmDFblgKTx/R332n6EAB20GiHcr+HJt0/tnuMXPvT/K/C6OxqMlHh/0
	6ufpOF1t8YM6JV3PhOsd6AAbhZITyoa7RNWddW+hmodElT3zf/5RuNiJCkzyLnyYXHc2X0vZURa
	2jDlgVZzF8x61IoKd3m9K2O7AswiUEEmL2AS7pOP22eBZmCpp6SzMsafDafRX6j/SReb0dRf7Lt
	c6T33POZuqMcc6KucFs9aogt5UWOKIpHXe/C8pNgRhnh392OM9cb8fc4mRiJu7uWE/5RCACIRG2
	ojMT1zW3EMR/Y21/lSXpNHL5pubTSwo//BsvnqmRXQw8buN76gbB9bTaFhxh4Nd9MFemT0W4+gd
	A3ushSR2higgT/fD9XzjvDO1yChGYMgfMhGSDU7R+dycP3GXRWklWD2Pj7npNWz/n4WhlW+BCkI
	dPaxt3FSukWjX91IlKAsSCDUM9OY81Nw8DnBJEwtoz7bxF/w
X-Received: by 2002:a17:90b:4fc9:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-39d9bbfc338mr10845124a91.4.1789164281193;
        Fri, 11 Sep 2026 15:04:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm6554980a91.9.2026.09.11.15.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Zhang Wei <zw@zh-kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3] dmaengine: fsldma: convert to platform_get_irq_optional()
Date: Fri, 11 Sep 2026 15:04:39 -0700
Message-ID: <20260911220439.177474-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Replace the per-controller irq_of_parse_and_map() call with
platform_get_irq_optional(). The controller IRQ is optional when absent
and the driver falls back to per-channel IRQs. The corresponding
irq_dispose_mapping() calls in the probe error path and remove function
are removed.

Moved before anything else in order to handle -EPROBE_DEFER and to avoid
doing extra work. Simplifies the if statements as well.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: fix build error from the move
 v2: move to the front of probe.
 drivers/dma/fsldma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index fb19c60540be..6db2c4d284c9 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1224,8 +1224,13 @@ static int fsldma_of_probe(struct platform_device *op)
 	struct fsldma_device *fdev;
 	struct device_node *child;
 	unsigned int i;
+	int irq;
 	int err;
 
+	irq = platform_get_irq_optional(op, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
 	fdev = kzalloc_obj(*fdev);
 	if (!fdev) {
 		err = -ENOMEM;
@@ -1246,7 +1251,9 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
-	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
+	fdev->irq = irq;
+	if (fdev->irq < 0)
+		fdev->irq = 0;
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
@@ -1308,7 +1315,6 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 	iounmap(fdev->regs);
 out_free:
 	kfree(fdev);
@@ -1330,7 +1336,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 
 	iounmap(fdev->regs);
 	kfree(fdev);
-- 
2.55.0


