Return-Path: <linuxppc-dev+bounces-21667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9DDCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 20:27:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRJ2D6Rvvz2yD6;
	Fri, 29 May 2026 06:27:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780000052;
	cv=none; b=E6jg8CJbd5dRHhJ/n+oRBHdvZ1hyQ6wBUu9GjWtk22h89NBR5CG8jZnP9Q3rcOuDo5yn9upBLZy0IDijnFaYaFp6J6X6bd/vmwuEB4+NjJJQqY4oQpr2ejjkULPj1lr2vcRa60KltpNHWGMr0iJtFrnBJxhGmaAcDlEEdvJs0um0CO7OcBqExLVhmLP+lrUi6AbaFIA5WdurJ8dlJJBvP308/m3HYL2yPcKZ6vgzW4sMZ6XhqdU50QZRNX7StCBCbOwl9/VjM5oU7ymKL7vMx8TWGK14yDXgk9Sztsf7VeSGe4vgOeLG5WJ3k0psEaN6xoEtOO5P7gFubUil0G3UAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780000052; c=relaxed/relaxed;
	bh=f5AhkoBY3piDQ6CBCQr20PDZnfU2GGjm7VvcEixBb8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMkV2HyInWDGeTKIpVh7nyktuGgDo1QfNk+N4+asoJYgvwluIj4T4g4EKF2+nD2Wco+Wa8zR9SrQ+w2lrjtKZEiFfoD1YPl8qmNZNHktdoDRZ8vuVYlM76VOs8wztMzDtnHfPoV8+3QeNGJD7Q12uvr5R/KFX8LYr/y9wyPp5vKa9Sb1Yo6svAtxeOqFYhK/snKYee1trFRhbS0gMXOfxuRfPsO+eMsfichGHssc+7IDkyyghVEUZudcm8WakRxqWimybwk3KX6501k64rLxF0VItoN/9ChaLnDH7EvCxlbXyqfDcQ4nx9LqKMrMzEowqgzBw3XZu3U5jjPoVJan+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J61GhCi6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J61GhCi6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRJ2C2CRlz2xK4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 06:27:30 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2baef9f5ecdso106221525ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 13:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780000048; x=1780604848; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5AhkoBY3piDQ6CBCQr20PDZnfU2GGjm7VvcEixBb8M=;
        b=J61GhCi6AxFd8IiGEBt2bD6yQiyU2Z+dhfh0M7P689YOOPC9VgzvjIwQi3JP3Dsclg
         J5bqo6ecvHCCK9+qqF4Kae20zN4IcGEI2FwdpNYKr85YxeRqXjyF9pdMFEpBgyCpmq7S
         xgLLjvRo8ENZHQKIyOsaZa+/ty2MOg6U4GYZJuz7l1nZqwlSigoTA95fai0vO2YxPbgt
         /dSoWY7xQTt306XZIQnX4fjD0gYeYWaFO7GcMCzdrlYua6n4IMrU/2pxWhkAUARHIULE
         Ys1Za3ib+BB76sYl8+7CXrh5S9kel1keaXz8c/hmz5uDUmpgJsgRvTZfqmQWPKXo0p8o
         Su5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000048; x=1780604848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5AhkoBY3piDQ6CBCQr20PDZnfU2GGjm7VvcEixBb8M=;
        b=q1cQ+3Mb4RALRzgtdNjKaCvGY+sl1q9//K0/yfGzI2jbAzQeakYzd8uG+0z2XtBk89
         KVruZ3GSIucH1JNW1ARldKToyDsQF2dgUpdzb+AXPdPzYD1m7issH7WW+UraHVrGe4+w
         5td5+QiIK1WWaNr3pBxz01krNuvHstDcov7SeSAbFbzlyZ1Mvl2OHplgKk4Yc0G1SvQZ
         +FVxF7uriAHJN8nSV+W8lJb8vJORLprnAcuC9G4TmC8+EyMnZDzeaeDXcGArX/aVotvX
         lzQx6dk8pXL76sCM2g/xgPU09/FoGxFUmxExdYE2QRl2CdD4ImJfXM0apnW7r6XBsfkP
         khGw==
X-Gm-Message-State: AOJu0YxWX7PDWYkWMku2rlQx476wxHenrtOq5hh/LSoc4Tt5rYkzuMLL
	gPY+NOWePaD2EeZNTxV2Q1xb71Wr7PJks6u3SkWop6EnejlKnLkxrBgH9mOdv5DT
X-Gm-Gg: Acq92OFZD0h8JhSerTNr2/9ZcrJz1cBSqLfB3KlXCXk6lWpQmLHo2GjP+jXC/21VIoy
	j5ptv4c0URugxwUbhQfI8HSbUUFrIYpX8KxT8oy6k4mNZgbZdhdL1fpYrmKBgOiYaMihc+bMiRs
	oXvrPbJE1FUqeU59iLzC9JCD+0dP3g6Yz6TjfTnUrp3Lw2DV5uKqvxczHaLKetuPIhl5+0onTGr
	ZFzHzVieoXrHeqUN1VZOPEaD1XM+LBZPBMgKCcZaWBXVnSRTaPWSi6WxQMjKHGehb/TB1faMOBq
	If+zRZwIJGVxOAHyXKayZkJgokFqo2Y3TAjBvC8MOwmHMhPXYH1fUe9zfKhHKJkrSEjBnMivYRK
	V67S8+Qj/bSfoXK6FLVK1AJOvHcWNglaYMkckBnxKX3+RZr4NWqnoQX69p3m/kD+TiEl6UxefQZ
	aExZB4wk7wx8yaRrhAXHe9fH1KwxJu74WbWVzTbFt1cJg2cm578pNo0HJFVE/KZCPP0Q7sBQlBx
	Lv/hwkrRhkJGNkYdYluvAHoxznHgTJGnwVif+ugr0Iy2Qx3LFc1nsoV
X-Received: by 2002:a17:903:4b03:b0:2bf:e42:2a94 with SMTP id d9443c01a7336-2bf1f3a59cfmr2993035ad.38.1780000048283;
        Thu, 28 May 2026 13:27:28 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1e604dbesm1748965ad.25.2026.05.28.13.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:27:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] macintosh: macio_asic: add missing kernel-doc params for macio_add_one_device
Date: Thu, 28 May 2026 13:27:10 -0700
Message-ID: <20260528202710.136904-1-rosenp@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add documentation for the @parent and @parent_res parameters that were
missing from the kernel-doc comment.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/macintosh/macio_asic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index ee3caa3d87d1..9e744c8e687d 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -349,8 +349,10 @@ static void macio_setup_resources(struct macio_dev *dev,
 /**
  * macio_add_one_device - Add one device from OF node to the device tree
  * @chip: pointer to the macio_chip holding the device
+ * @parent: parent device
  * @np: pointer to the device node in the OF tree
  * @in_bay: set to 1 if device is part of a media-bay
+ * @parent_res: parent resource
  *
  * When media-bay is changed to hotswap drivers, this function will
  * be exposed to the bay driver some way...
--
2.54.0


