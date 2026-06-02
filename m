Return-Path: <linuxppc-dev+bounces-21833-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C101CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 05:02:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTzFz5dtcz3brH;
	Tue, 02 Jun 2026 15:01:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780376519;
	cv=none; b=WCbftVDMV9Emf787Ow+mVdK2yNfb3hMa2CQmvXiXIRQ6Dfy1TMC4PdjLkwpuH14B6sclauY405slwBIHzTwWR8D1oEoLaZIEHWhRlqPo06/EYRDJcvobZEMUAb6RiMuK9XLsyzWsIbHHX9fMhTPmo8OyeoBnQdJGgrEf8v23TMXg/Yg3PrgGx66YkrI/BzcfkUPYf4XIfJApKJ5++rao/ehwnoNRC9+My1557xBo4yPyprMtx/wcvbYmya/0ugXU2ez7AZV0v8mR0VulY8IUd4lbXV04fpQzItf2Cw76vHftKMkw36qVxo8Rm7wc+sdzt4RF/7vjFtzHbzSDTDmFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780376519; c=relaxed/relaxed;
	bh=GTvG89FycszAXpYpTdeo73IhzkPmvsyhREwqWmrsBdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXDYPOKua67ltEhU2UxSe4X7A72ZrznAI0HJP6ngziSt30zjt7FvQM4yqnRXksU52ZGd17irvx3xqLqvYzyRs//a56Bw09/qvDUFrdUx6LYtfzJYg3upGbgOrhA+UvqdEUJq5RdIB3iCLmfrp1ptMyySx1Ak19ezqmRfK/xajbhanzEs4cD/UlmXydvBKm/zZJtsE/PT/2S+NYCJ2k5VS4EfbRNGGZ+lh1y+XGF1GVBq2nQOcZWsj51q08zV2W+oyYTkXv8/YEROfTs9w1ckgACVmvZhkQ7X6ZRem/2jaO22H5kjI3MudLv/AFCfYg3eTKNyiSGIXl2R9J4dk3b4fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fQSZ3EJo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fQSZ3EJo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTzFz0x4Hz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 15:01:59 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso3619010a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 22:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376516; x=1780981316; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTvG89FycszAXpYpTdeo73IhzkPmvsyhREwqWmrsBdY=;
        b=fQSZ3EJo+Ho4K9E9EKgnzBDeTI6NMnzD3NlT1xxjTyRrfLqDUVBWW290JToyIa0Vow
         LQHDgST6pRAsnaAGgPGflozayO9yGirBBTiQ58w3SHT5Dyfg5aCT6ElSPv/VlOcGPZV1
         TtfdreXN12wSEdD6XcBmDXP2Dhr4aXsCCBjN0SmPyevGEFWaL/jlkiD9T8f4b5tunFp+
         s24QazJek6P9l/zidujc+9U2JKbv+OtIGdxEUuSpOkd5SUaGinmSkTzO2XFUy90zGar4
         VfhBF1m+XxUsL3vaKLN3qSTyX5W+3wHOeLpnzJlJQRHT9grLh0gmJJ5KoDkA/EvyWsBP
         XQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376516; x=1780981316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GTvG89FycszAXpYpTdeo73IhzkPmvsyhREwqWmrsBdY=;
        b=URoh0lkodO4Or+XFeFS3l2IIBBl0z1LvkMxooAD9WWo3lJhJpeMkMeN9lTpCEveV0V
         0Yr+UdkJVbCfKjsqDOP2VzoR7V88AJ0GL0OCz3krdHJt9zaifpkx3L06CwG6G3ogQE4D
         9i06Pxr3M7uX2mIkDKY545ccYYFc9VKuEXyE7dbNshvkAet8wstgbIfQ1lyxmIAtHLnm
         MEjQDncmHH44PBJDH/EN7KjQg6AsDh595r+6pmHmrwnIQh8gRyCGNxu7AiXpZxW+L+VJ
         x+XHycdGGI4rVp8P8yiHaod4x95TWC6L8qsLrZITkMufIvRCVb/5ClRm2aobtcSRsnKD
         6G4A==
X-Forwarded-Encrypted: i=1; AFNElJ9gbjhWUr8hoX81bTs8pKsWDAcVqOIbPvoRxLz9EmLrxh48p6kNfelE4jxcBHgDivajrbn4r+i7qu6AUTg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw52U/k5e0d1Fb8rXAvVG2XoL2826LTjG4YYPnyOxK8mXaKroOT
	o+i9L0DoDBE9ufqtdMVAeBYZ4JGIvIMCwjlBLqA1UKNv/2Y4dUJjzNAB
X-Gm-Gg: Acq92OH3ynhXtYdZKhewjwYW1o23mjXS0WqVwWBSDGzlvgqr1pSKy9wsF+4EsuThjMc
	AxwhACzjgQa0L5tkr5+/TKSGb0dFvbPMg6NS7VFDNyCipGnn6OJbgx9qlhw99FeOL6G3isBW94Z
	wBoQ1EMfW/RCw5b46FOYtvIuAB0n+Dmu3Eu9/iWgubyIPN+PpHghl5oRZTKQ5L4e98/GJitKvkD
	UANJMXeo54lMWtLi9Oa4Dc+HfRSruF+KhF8FNn0jwp1YAo1sCj455+TcaruVIU1HMUG4xEnVUER
	guFrC681Xva8tMSqSPUNkkQ2+q1a96hGozyy1K5xv1HKKcoofPZh0kNG6jweepZ1RkAPE0GdfEs
	sMGsCfZcIMlLHW+4YYZ6jhEV0BlUQZqd2xGSLjZZ6KvjV7d+LCEePjBeoHYnxZ6FpFGo9GRFtUF
	YAlTAd12V5YSU0mPE8+KuOqUPsRcUAXNTHGS72zRcIdhKWUySDV183rPPuYxgtaooq1AW3s7k2L
	VnaXtkKd0k6NP/4cDr+tAdC0LSPQHY1Qomt2NaaUx0s2Q==
X-Received: by 2002:a05:6a21:7a8e:b0:3aa:f9ff:656b with SMTP id adf61e73a8af0-3b427c10895mr15671814637.7.1780376515909;
        Mon, 01 Jun 2026 22:01:55 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8589d055c7sm8958467a12.9.2026.06.01.22.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:01:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/7] gpio: ppc44x: Use module platform driver helper for GPIO
Date: Mon,  1 Jun 2026 22:01:26 -0700
Message-ID: <20260602050131.856789-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602050131.856789-1-rosenp@gmail.com>
References: <20260602050131.856789-1-rosenp@gmail.com>
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

Replace the open-coded arch initcall registration with
module_platform_driver(). The initcall level changes from
arch_initcall to device_initcall, which is safe since the
driver no longer needs architecture-specific ordering.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpio/gpio-ppc44x.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ppc44x.c b/drivers/gpio/gpio-ppc44x.c
index aea0d913b59d..0d2244272e32 100644
--- a/drivers/gpio/gpio-ppc44x.c
+++ b/drivers/gpio/gpio-ppc44x.c
@@ -203,8 +203,4 @@ static struct platform_driver ppc4xx_gpio_driver = {
 	},
 };
 
-static int __init ppc4xx_gpio_init(void)
-{
-	return platform_driver_register(&ppc4xx_gpio_driver);
-}
-arch_initcall(ppc4xx_gpio_init);
+module_platform_driver(ppc4xx_gpio_driver);
-- 
2.54.0


