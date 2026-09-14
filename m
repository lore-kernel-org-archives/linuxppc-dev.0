Return-Path: <linuxppc-dev+bounces-27221-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA5DC88E73
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:21:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hk6lM6DQYz2yd7;
	Tue, 15 Sep 2026 00:21:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789395679;
	cv=none; b=FqiYpYs/V0uYIudlfIQ/Fq+Oc9mQJrNIk9sAkAngb04P4UsviuQ+KIEUhNgEvLo8wvq0qBn5saDcr+nlh3NgA1eLoM5ORsfhP7FdcBwqacfubnLb1J69DTXLqeCNdsNSf3PNol5QVGBCFHicm3rObPjYwvzUr4Q1WgMa2RAZq+eQNfFrM6Q0eGkQjHUeqZyw5vE3moTvRhkw7Yhh6HdSat7Se6cSd9fuFYjADNKS6OB7iw3CnsalVWfiXPyjzyf3s5/a2HZLL4MKIebP9ch9z1hJK+TTr2IeczZPWXCT0gfvkKkn58oaZy6j+Lf0U+MNpp2POeffILyQOxydUGKQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789395679; c=relaxed/relaxed;
	bh=rbbbFtydZ6bg5SO9oGIYuQ91SLS9B9Wc4jISmGe2uxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mzoj02oyIykCbdb4+La7MBHqZFuqnQx0J64w1QUEzJkVvOxUAy1mXc6jq3Hi2KjbV0Bh75Uh3BgbcYNyXDI3Dk+Cd30+oarCSgUDANeV8KSUud8XZ8ZsycgxveOoJrChR5OpSBVOq/PTiiy2xYCKkC12aWwSYs/JSlHwNa4AR7pal/G/6hNBxxtncHIOo97fys6nzIO0jlwXS4H9meVEpW8RA21+bHysvrvDX9n9IJgKYwlIZDtwxZaKOI3yLRjEXsadlO/8xlYzR34joQWEIdVXJd4SL2eyCfOlrpUKh/CQi18Gjgoi1YFbCNy/cfHbbXmh9ulXtcqqec24nZZwmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ihCbLt6s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ihCbLt6s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hk6lL5lxfz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 00:21:17 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-cc4d64bcea5so1918552a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395675; x=1790000475; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbbbFtydZ6bg5SO9oGIYuQ91SLS9B9Wc4jISmGe2uxQ=;
        b=ihCbLt6sy+EXY8+p9QaJ5p60aUbCMRx30ypetgtYZgLjL/sVIwJj3dqDzZNNI59JZG
         QjQxI5cnxoMNMDBI4z3MFwlxz7x92TDbLW/AuNailZh4mSHZLFWrBOZdbu+XGblCD7SM
         Ac2h+0xkpTUd6jXk4NrgzLVJiC5eGPR4tzrRRCJWYD7xqMxtABn+NHhgiGEkdjY/AA86
         lqfIhZd+IpgPkKT2YGqnAfQXva1iR0dtmegSOBKeRUzJcwRyrAh2kFWFCX3vJ2wymZ4g
         dRjQpzx10UZuUKEQBz+qqbko9AkH+8gjfdFEG0Uad2JL6nJjHfAx8EE1zDFCKW8yfAKm
         7itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395675; x=1790000475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbbbFtydZ6bg5SO9oGIYuQ91SLS9B9Wc4jISmGe2uxQ=;
        b=hHpIzF1dUbq6xb67Ek4V3kEAEPgHO6hMyjf0kaERAdj+BGv2VT9CejkcAfU40qspyo
         4NMB+b0TSaDPIkhEdiPHnnXsfrzhz4ML+fksIU1qMf02e/YkAhRopqyhHCNI2ymOtM4k
         h13eOs/hjZ/53khccINDD0+joZC6zENZ67V3IvQMhzjgs/q+C0TCbOHqTiYN7+mF3tkA
         1IIV84AplgT4lIMkC47z62gKEPAJKqsDfwkTtwKOeJIcn9jaX9QN9Oyir6R0qZecn3OH
         U91tfmrF7+CapKDERoWMa35Wz3L1T9dv/WUMLrX7wFcKrox8+q9bZRyj68e1URTrPFU1
         89TQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJSulIDucPz3DuWP9s4ffVc9fQY1VlyAxQ77sGIEEZmd5zTCdYsJlNt1mn2FMOr9FJOyPGJ9M3bIcbehk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kGJGE02B+MRcxYHtkuQg3m+wWZYzyX3UDopgF6/eAlkdjbzxz6
	QAqscTE3u7GFMbzvMhyXYx0pma5SaZlie5seEWvXdK94Gi+/ZK2o+Sal
X-Gm-Gg: AYBFou3ek6Iwjgal/m5tahDy2X61bxuMo0YzUppoV+IBYApGK8tDsDAw6rWaungGjzy
	9OD2ZhspnInMpm6h0t/AQHm4L72ITvQl12Dd5DpPkvz3a0ZCIDJrifUz5ZGRv40HJHjQFviwbtu
	6xA193ksQCYUYYrjdnlly/B5vl+HlsMKf3URHIW/1grGI81CbmJ94HTXxuaFbmQyrABXk7qPKA+
	tY3vuylEiIJ9h0C3C7CEaFVBKuJ/EMCvNfGTqntZJvvANrVObl7bCIhqYyjNY8Oer1ro0e7FG4d
	8APUtjZW2zYOFiyWMVHamPX2eAEaXwvz6MoHChxekjlqKQJUj/4i9/Lbl2K2ztZBRcJQlTq+7nr
	VB9Pizhqgw1jdWDgYuEyePN9bZ0tz24t7ubB5+WnIlAZXeCDEWfsfaiTWenvfVypK2FoU02BJIy
	BVb7nI/+L46OlPqZlFVo8OVWujWTHGJR96sOZ4N/FOHIR/TnyavLqHqA==
X-Received: by 2002:a17:90a:10d6:b0:39d:ec1f:b40a with SMTP id 98e67ed59e1d1-39dec1fe435mr4017399a91.11.1789395675068;
        Mon, 14 Sep 2026 07:21:15 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94744dfdsm22113164a91.0.2026.09.14.07.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:21:14 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Colin Leroy <colin@colino.net>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] macintosh: therm_adt746x: fix memory leak on kthread failure
Date: Mon, 14 Sep 2026 22:21:06 +0800
Message-ID: <20260914142106.1747229-1-lgs201920130244@gmail.com>
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

probe_thermostat() allocates the thermostat state before creating the
monitoring kthread. If kthread_run() fails with -ENOMEM, the function
returns immediately without freeing the allocated state.

Since probe fails, remove_thermostat() will not be called, so the
allocation is leaked.

Free the thermostat state before returning from the kthread creation
failure path.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/macintosh/therm_adt746x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 1ac29a5cd324..60f292a5aa3b 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -557,6 +557,7 @@ static int probe_thermostat(struct i2c_client *client)
 	if (th->thread == ERR_PTR(-ENOMEM)) {
 		printk(KERN_INFO "adt746x: Kthread creation failed\n");
 		th->thread = NULL;
+		kfree(th);
 		return -ENOMEM;
 	}
 
-- 
2.43.0


