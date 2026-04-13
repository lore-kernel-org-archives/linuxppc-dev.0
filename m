Return-Path: <linuxppc-dev+bounces-19695-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8406F34C52
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 13:44:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvTCW2gmDz2ydn;
	Mon, 13 Apr 2026 23:44:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776087847;
	cv=none; b=REK5Y30GbvHaNkpLcb1yrpdv57vJ8xHSK+5KdC0vTR8NHT0Sz2KLxFyLIR9jmqmjsW+c6sWMOxSHI8KrYLlIePOkNZryEOArQCdDZOsTN6aActJlYu/GrPGUlv9tYy1FReH/6RoZI/pDry+m9ccqFyaSYbZHBBqDzVRNv9PvO9OGDKSIDm7rta5AXrHVemGGehH2LKkkkRmkhM31HUMpMoMQ+L+sd9eSnWtcLKE5ZOeVvPM0UcHla0KxlGFFXSpYk1ta45PuE2lISOe7hKOQBp79tSLYC2o2Pel3vH+Vuok577SNWTBhF7/Y3Pt+bE/9vkrlRHbIHNahYw/gFgOD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776087847; c=relaxed/relaxed;
	bh=7W9JynenGbsWsUxegkWWGHkXpA2s8st+nPT0ylLSYvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZlOMexARewB9zam84DFn8D7rTlfHxa/Usnk0FRw7SyTY9yfDUTkV0bXgWOFUK8PqoCoou9WARkB77yh83HWi5YsfNiv0glfMOv3dRRvtGMVAy017vtlOngHcEXznUvT2QN8dL3ZX6x0F1BZsynNr9Id9purM0oq1yNDbhOqN2tv3u2UufcLtn+u8cI3yKobbcNOiVCwKcUOVsFok5fRKy6PNh+PDef5mCnDf0kwVU7KcpQ2S9asQLUUyHacShaiQgCku0gerLoH2eeRESvRL1ZwJwCqyfLV4Yd+w8KyS1K/YqNpi4AcY9eSsN9ZLg5GSCiRf3CxHHrpxerToD1GBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G3B9BuKW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G3B9BuKW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvTCT5fgVz2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 23:44:04 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82d0b68837aso2385986b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 06:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087842; x=1776692642; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7W9JynenGbsWsUxegkWWGHkXpA2s8st+nPT0ylLSYvw=;
        b=G3B9BuKWOeu9lL5ex9PmD/VoUCs3VrKvPqXtw9LbAN5/dq9mkHawnLh3Q6uEAmapBX
         wbJKV/FRA6IIbVkXYl6oMgP4eEnJZ73vSUzKj4xVSMWXoiMx50oFHwu4gpAVFkAWjJDg
         bGmyb8Rgw++aGP6igQex5JQZ2QZNq2aHrQzyXdzsS4uZsREK1dcwk0WOtxST8zHdUxiA
         C6XsZFShsSXhALGT/48EBrV5e0f8+fhy0jSN6SUlxOtvrmrl7TbQqPqmc0iqqk9OyUDs
         dHen1TrzXJAitRPpQO7YdvebnhOJ74NjLh3mOdQcw5HeS/XfDvU7hPhlFckguEIP0akH
         yz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087842; x=1776692642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W9JynenGbsWsUxegkWWGHkXpA2s8st+nPT0ylLSYvw=;
        b=dLEu4DqistSV31B7mCuNCsrspHbdQ6ZWECaIdHwXmasCC2s3eE3yQksrFWo7ctnlhH
         k03suM7N+6Gb2Gd14AjtxGMu/kkSRbDrvovUBE4yroalNK7qXw65UBi47o7hSrilfELh
         RHilc6USCqzBB1Gck3fnDk70nJnyNEz4ltVySfH8F6S/j4PCAwQEoDICS/VtQizp9nvr
         v3TGapTEJfy3RyYED3PL9lzDDoJpYcozenEvKYg/589BNTn+llb1cjAl4/5WaGIAei79
         Yup3DraCWhD1z2E3ssEIVbGTlt4A7mPeUakvzDH6ww+4IlYXgcRX7px9q63PgSaTLKkp
         /0ww==
X-Forwarded-Encrypted: i=1; AFNElJ97bQE70UKtA+1ozjYpjVFrcfPaARanYJex/WwYEtrWvIxHErpVZOuxgI/LyKsPAmCFHNX5TZSOMXfNOU8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxnTMhMFod5/ZoFO9wk49kQEHbsRzixwi6QjeMaeZl51Po3/qru
	nUI+F1C4TWY9Hs7OhjmE7pu0EV79FTOtwT+QlT9bzeeSwKzQY8pULzjm
X-Gm-Gg: AeBDievBknziV2Wa7TCRLhwppZ5jkMsTWVZTbxGbGY4tHt7nXxvppViHGJpYW93Pgpx
	aK0a9TTuTqYHV1hOkN20FCuwksy6QwMWA0LxBrJV0HbRjd5nLgpJYNFLvMuDEvCVMlST4tiO5Qm
	tcDKo9JzlB3y6vFT/eFZfSMLSGSN8q/IvO6itolDhzmy73Py0w724+nzVNxhGAXON4ewRi3qJoJ
	q2CmEV+BoWtkCmAuBIuA5zl81/Pe7juVzZo05VUNl9kYq3xDMmSbN9BMFRVmnI1xPD4cixN+TAF
	AQGFO9AKg7EayjOSTw5dhabNnQftflTMB28IBZv82hHTh/0Hakd7WqN4LXN6dTAH5/EUnVW3Y9g
	XmyZCiuQbtAM98UzW2sSEsTN0oT3ZSxNQEuyh6b8OESoeSF606rMDZlC/Ly+FIVv3gjmUfNKd6i
	Hqc2Go6s+mLBzH7hFiwwXWGBv4dIAzpSA=
X-Received: by 2002:a05:6a00:aa09:b0:81e:d18a:489d with SMTP id d2e1a72fcca58-82f0c324ad0mr13936407b3a.42.1776087841672;
        Mon, 13 Apr 2026 06:44:01 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c33de57sm10951065b3a.21.2026.04.13.06.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:44:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Graf <agraf@suse.de>,
	"J. German Rivera" <German.Rivera@freescale.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] bus: fsl-mc: Fix refcount leak in fsl_mc_device_add() error path
Date: Mon, 13 Apr 2026 21:43:44 +0800
Message-ID: <20260413134345.2855417-1-lgs201920130244@gmail.com>
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

After device_initialize(), the lifetime of the embedded struct device
is expected to be managed through the device core reference counting.

In fsl_mc_device_add(), all failures after device_initialize() jump to
error_cleanup_dev, where mc_dev and its associated resources are freed
directly instead of releasing the device reference with
put_device(&mc_dev->dev). This bypasses the normal device lifetime
rules and may leave the reference count of the embedded struct device
unbalanced, resulting in a refcount leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device(&mc_dev->dev) in the error path and let
fsl_mc_device_release() handle the final cleanup.

Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 25845c04e562..6d132144ce25 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -905,11 +905,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 	return 0;
 
 error_cleanup_dev:
-	kfree(mc_dev->regions);
-	if (mc_bus)
-		kfree(mc_bus);
-	else
-		kfree(mc_dev);
+	put_device(&mc_dev->dev);
 
 	return error;
 }
-- 
2.43.0


