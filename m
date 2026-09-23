Return-Path: <linuxppc-dev+bounces-28026-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F3BC98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 14:16:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqfD61jtwz2yqq;
	Thu, 24 Sep 2026 00:16:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:3a::1e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790171438;
	cv=none; b=oqCXghcv443ec+64XAJUMFuGS/jQ8+oBMwqpGDv3kpqyDGU+39eEIWzr34GA3BkTkJQO/IKfKCGQG7YH3MysV5XvGyoR0XeRhEWDviPR6JTXkyCY1VxJul3m6nuX4/6nPFUoBKbb8sJtlonXWNqM5CogYO2df1qx6n+5F200sUXbw0DM+dhlGKrDI1mJgkcTgoOItvTAjzeu+RTXeIiJSoEaGTPgS1SMha/5NrKy+URrdBITmknMvdngl1cngoYOr+nqpquihd3bsR1yrwhPbMDX6WHG9KzQj7OZm0My3K+rqadfyoqA6uiZ05TADydyuJXEA8p4COzWWz6Do60S2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790171438; c=relaxed/relaxed;
	bh=2SglU6SsyzFxHFyMmhSwCTOipsWKClut0lOm4koa3sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+up3M4t8cOdxtbmqk8DZU6n2G194rMR7uoZkB/jM/W0j/RYWdw8hD0B+UHePBkHKs7fCTR4exwzlImb9LiJzbUeHHd/xKeEALBye7smGnmN1aIjEnpg8xNGzRUaUQS/G7yR9H6uHa7R01AvDGA7qNR+EYzL7JqiwiA1XTybacGJFvZoC3L0XZL97Osk2wm/m3H1PI4BLE7AOJByWBtipgeq+1nU1wucLdozkG1Jf4i/Mhhylu+yAr2L+kjGEhBPiY1UdY3CdmPY6/thsbHvl4vIq2PxrOfhwEde9d9AVJRYQ1ZQaMX3zIUe147seIiYk7OleKpBNBhQHNktOe5LnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pqFxD5Oa; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:3a::1e; helo=mail-vs2-x1e.google.com; envelope-from=qwe.aldo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pqFxD5Oa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:3a::1e; helo=mail-vs2-x1e.google.com; envelope-from=qwe.aldo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs2-x1e.google.com (mail-vs2-x1e.google.com [IPv6:2a00:1450:4864:3a::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqddm5Ctpz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 23:50:35 +1000 (AEST)
Received: by mail-vs2-x1e.google.com with SMTP id 71dfb90a1353d-5c67e529da9so377143e0c.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 06:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171432; x=1790776232; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2SglU6SsyzFxHFyMmhSwCTOipsWKClut0lOm4koa3sM=;
        b=pqFxD5OawU41RABk0riUnVFpYMaMoywJCS5w3cTULUoxHF9ZfWAk0D3bj2r6XXkUkA
         yhNaKMjTKIYyp0fhQWVkgL9h2sGBp+jWQYaGMwN8BZuS34mSCLPjzEQc7MsDVIRkDCn8
         aWEaMRjo5NsusApQbrLVWrgFWPJvXckXJRNdEnOrZ4Cl6YpfudK3ocTZ58mREYjOzESh
         G4YojD0XBYOIRec3EQyyIz9jEEPHAxstwM5bHThVi2wJUxlk24F1TwQOchtrEtyySkNU
         C0PsDJLEbFi+1PFHL1AsSWxUgHDuzpYXHZ6wMNjywrOyJaVMFYSkvrLhLq/1sr/l6MPh
         DkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171432; x=1790776232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SglU6SsyzFxHFyMmhSwCTOipsWKClut0lOm4koa3sM=;
        b=2gO59o46e+tvKB2K1IYrFrEKcykyBEE8qnOmYViaQmNLDyD6ZuggYUBgZeX9et6kK6
         WmdKGTJavGl94dI6dj6XVQ2jLfXBhMiIGWULAdht/xCpgHBBk1MhQi2SJdDBPgLvhlGS
         YpYNsW/Pm1t5g30C6Q8omWZz+pGNXCZdG2JpmkYEUGfpxAWFPDo9dfd34WBBvuyxuew1
         GPdfRAAjMn3jqBcMZPbd3izJ1138ZkVYP/PgGaOGYJVy/Qdh+KNUvqNAoA3VIP3ty0Dl
         rhSO/ZErRv4/H2JrRRdxWBGFYBORzG1fCrIAdICxxbnc1fOLmeIkLk92TSBhn9pmD6kB
         rSKQ==
X-Gm-Message-State: AFuF++l+ONxuymaPEA/MneR+G/5TaRBF99RZkvTgduczKwXa8KU5wQ0V
	jAeecYqcd2pqPlr0jrCXlMqRbTrnhr9jqbcWaXPyupjowLxS51AjvylY
X-Gm-Gg: AYBFou2g66CUiCgnjFYX11cSY03ntKwQCL5drLPnaJGDkDLKZOlLHzRQhVX7hJk0DAA
	WlIWorj1uyjR2H7fguWOwIb3pS8r9O5vxDr00NskcsO7V2j716/i0VRd1P2RWF3hClXuRCvUFe6
	RMyXy+UDNwYyyEh26iYwQBwlWe08DQqa1e+DVkv2b+Sq/eyTTpjgwGntJQY95puCFkKs6tqtz8d
	9bDIt3cT9LCgwCwzfdq0++ois03LXinSI/ixXTEXBIj3hDZkjohrfOD2YamW+zQ0EheI6tlhxJj
	s/WygZshQHMh/RNRGX5KbSqj8xfHMegd5U/JAYynNJ3Wh2u2DeVW/EoULLW7hpEOMYy3pMQNXhe
	wjzfHfsN08X1juRb9z4Te6Ls3m9mwoY977JsRmdaM2jXrzW6/kLRxf7AmBEG8xf7ZmvEjLTIwzc
	I8udFSbjUsrcoGO1xLy9DO7K4jkFca+xHxc217g688ZVmob1IfMjgYLSqXt9KyxMU=
X-Received: by 2002:a05:6122:2093:b0:5c9:a60b:e5d4 with SMTP id 71dfb90a1353d-5c9f165664amr3033636e0c.14.1790171432428;
        Wed, 23 Sep 2026 06:50:32 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9f04c2a36sm3263916e0c.5.2026.09.23.06.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:50:32 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: zw@zh-kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] dmaengine: fsldma: kill the channel tasklet on remove
Date: Wed, 23 Sep 2026 10:50:21 -0300
Message-ID: <20260923135021.1858325-1-qwe.aldo@gmail.com>
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

fsl_dma_chan_remove() frees the fsldma_chan structure without first
quiescing the channel's tasklet. If an IRQ fires just before the
remove and schedules the tasklet, dma_do_tasklet() runs against the
freed channel struct, causing a use-after-free.

Add tasklet_kill() before tearing the channel down.

Fixes: d3f620b2c4fe ("fsldma: simplify IRQ probing and handling")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d9..0e2f848 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
-- 
2.43.0

