Return-Path: <linuxppc-dev+bounces-19647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500E9F3ED4B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 12:28:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftCcc1fnNz2ymg;
	Sat, 11 Apr 2026 22:28:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775910105;
	cv=none; b=SSJ08ccFP/1i8TAtnEXz6jzK3zD2XdDa9aA4GKnmmIDYO7ygSxUDElim4kNZ8xhOuV1z4L44Tg0um+VtYjs//s9uQDJOe6Lw1GIKC8z0PT3zhI8ehdGeYpSp8zzED0/fBVCiq4I3TP66ku/ivHbwpvKg+3loDnrkjdi2dHCyK+XZk1Hjlz6z96VBtNtrKM5RTYhuyUND09ku+jNgrk8nNxDcNVF12yAXThfsy9f9cDOVB8uIWG2saoCVZTkpC5TaC8uZCeZRODmZJubTGQpuGVliXqYI8EnhC6bZTikgwI9vMoNF1SepN00qVLl7+1WnFd+pv51VoWIop7FD1Jbv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775910105; c=relaxed/relaxed;
	bh=iDhxS46WB9cNJon+ZSJd5o32lpx1Hn2DEDhx5qw0Ti8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lB3FFTlAsE06CHh8tARvfn3qQkGtVMrsWAXi3yaY25TJ6XR5sRGQMbDVLWvdOujPrJP2CsahQUm75kgHmphmENwRwCcY6w2Q2dLdrog0mj3tB6RBC5Ju+Tv4SvwiLJ4WRURLs/lAshc3eBmVyInEiwLhoFQMexXdUgteJj/M5mhvqlxwyBd/dEnB8yfSj6aDFHMHIkJtvMrJnkGvv6gB8g28o07fOpHVL8aNjELKLr7ySn39TLUNHgXdy/8ScF16pXMKS8qkXMvI40Lg8Ku3WD+6uXS/jBVeoQDBdUN7K4Zxl4lXaxBEpRVQkUMHoDuwLoRG2AFySl9g8/8MIJWy1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=imIozAd2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=imIozAd2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftCTM3SZvz2yl2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 22:21:42 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2aae146b604so21046435ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775910095; x=1776514895; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDhxS46WB9cNJon+ZSJd5o32lpx1Hn2DEDhx5qw0Ti8=;
        b=imIozAd2/djxSh4LCaNp3pmwcjWdoJSwJugtWxEXxOgbjcikHZnTFC0ZKQXiDtR2wV
         wZohmSpxr6G8FLSDdwRyCrvPhkhZ+SBbFGMX0xQpc2fBgu3JxXFJJvpdNKKyrnD4VxAx
         US5PD6PVoy0pZNLLpTkrlabks5E0XEbs1dV6Au7khM5mxZ8qpOC0MxzYeTcsA4qqZj67
         H5UTxjLxNeayBXe7ztIljTa7bvhhGJoeZXbTYunP0n3oKgYrYAqRTYwLeWEuQPRCyy1p
         LGsWJVSfWKcbfiC8/bjmzNEZU9OfwPlI/cuDuyXqBQuQdaCoLx0DUHzNjhKSnbgIcPLW
         HQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775910095; x=1776514895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDhxS46WB9cNJon+ZSJd5o32lpx1Hn2DEDhx5qw0Ti8=;
        b=B/N+xebtIkjDYVMc44JudgD0MkM4xniOc14zDHH2Egg3oS0vXKOgmfPj57E7ZDbk8q
         BctIG2d5D8zV2rAMQ9mfKEd8GGtFqKqAcBTOSBo5Lx7TK+CWvKdVxfA72cB07D1XzsEM
         iupxX9Lxb3z2Ll6mQ6C2+OPTs54h5PqrP9/Jm3uKcvHCae7iTtONQT0Nzu3sm2RUPk4P
         DJ8KYsNmHevi1cgK7DRlXY0XNUE64x4I2Xs5ey8F2AzC7fTg7BCf0BppuAkv01T4nHKz
         BcZCA5xGqwdi8ObW5TwmfvBxshSQsyLwQ90h8+MPTc+auOmQ4jV18wv3lQ5Q5O7kFcNo
         i4NA==
X-Forwarded-Encrypted: i=1; AJvYcCVwEtN/2MRs9qb+NV3pcU2VY13r7zwBCg9JakQBy4V6uivS9aa6gURp71oVf9oe9MU2gW0BFrLlRY8r9XY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzNxjXUhzRV9lrNg/FsIaKdz84pEr5n72ypTkZaCqfVB7THrB7e
	8WxKEqzAPoOgfDfKduLdGZ4oRqkdnm9VYOO9DNUytnFnuHAJeHYKV7eQ
X-Gm-Gg: AeBDiet673zZZ/2USi5yzLvpV7+xVUxaBOZWDyluoQtRhOHZtwTVMZY6t7S6bnC5X1j
	bVbs3HqVbnvuSQxqyZJ6IDyEzY4aQ1qAxHDlYuvaCAm4johKliEuaZUgw5oLPy+n8Zvn4ARkUg2
	p786GOKgcF28sa7qCUI0tIaRONNfFby2bP7Y7f/JpMbus/LuSEm/0jUKaOZeOtPtIOmSqtxhCTJ
	1OJ1sdUXQaxSoDZXKOzl3X4yK5utm+us24D8OInc4DxCXMm4w4GVji4444vog+Ii4uy6oW/G0lL
	Sm0TlQTweilPOYc4U0M+9xx4u7olw1UBjYHCHxmwaxglhQOd6hJ49ceLLvygvbpalTwEUJStRFI
	v6phaNhSWlrbLvSuLHX616f9vo57SUMTJVgyBuoPgwqn/OCurRfUy5yon/Aog8CSE7xSe+x7dRw
	e2nf6jFPd95E3sFZo=
X-Received: by 2002:a17:903:3b51:b0:2b2:42da:25cb with SMTP id d9443c01a7336-2b2d59aaa97mr50470925ad.19.1775910095243;
        Sat, 11 Apr 2026 05:21:35 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0a393sm60736815ad.40.2026.04.11.05.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:21:34 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	"J. German Rivera" <German.Rivera@freescale.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Alexander Graf <agraf@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bus: fsl-mc: Fix refcount leak in fsl_mc_device_add() error path
Date: Sat, 11 Apr 2026 20:21:18 +0800
Message-ID: <20260411122118.2196540-1-lgs201920130244@gmail.com>
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
unbalanced, resulting in a refcount leak and potentially leading to a
use-after-free.

Fix this by using put_device(&mc_dev->dev) in the error path and let
fsl_mc_device_release() handle the final cleanup.

Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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


