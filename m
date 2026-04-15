Return-Path: <linuxppc-dev+bounces-19777-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46651F43830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:46:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwkW14x92z2yvh;
	Thu, 16 Apr 2026 00:46:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776264413;
	cv=none; b=VKMqUFN8WIirHny/N11yTZFItEC6w6amAJ4iwhQQxpiluTiGrEqzwm0pBejfkiHasxof6JaefECIRgY1RMNJfYgXXKAYo84KqFs06Nrj+zZx42B1doJ6PTHAje9PhigoIWtgAsZI5vdP7I6tzlXcgMgcRJCG+TxsSQvDulMs2plt90h0lz+nro3mtX7CRbQg3j+lOKKSRP1Wu7HTNQjlQYLf0Ex0il3kiVNp7FtsJztQXt7qL/cNNZvjgD0LAQ+YRMnAaChvuEWv8bhrv+8Vmr8h0lavhHNx4L0Br0gIuUKvf+foct0qxgqCvkBREDXO3GDOAYZ+OW0kwyIcjWGNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776264413; c=relaxed/relaxed;
	bh=znxX/LCQa33kO599nbk2Q/Mw7o66DJJuY9IEDvMYWxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMFLvFlZq2J5+uea5J+UaQv4RXJ7u0GjHVjVcEyJrdhYU/KnqxqJLwgM4HqdAwn/RovXyqVJLVcAPDU/GudVVEZZcciWs2U1g6zjg/Aw9MrguY6CVKGfo4SncpljOLiSMPCn18ar7l3bzgS7wkeutk0fj2un9s79VJ701mwGBoK5bhnhADLsrFtpwzWRX7rGmoUwsdrH6Ra5LXhKh1IZRqWVrETrHvX45LxJPY2FMhSP6OavFys8SAZF0xYQ6sJ0LCXmJXE2x/QaqIl/CtFPwsUVvglkjZbMSQtLCmQvrDVYxUVGZInnqoNcyjPzgFCtXajtVWtvbvVkGmFZKW7eAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=coJGPwLc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=coJGPwLc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwkW04KKmz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 00:46:51 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so3236360a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264409; x=1776869209; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znxX/LCQa33kO599nbk2Q/Mw7o66DJJuY9IEDvMYWxM=;
        b=coJGPwLccmt5Bbrt6AGjM3IE7+gvBJeNk0rgQNvFpbfbM8kDXexTAv/+gMUq+n90aH
         fAiHE8aBrLzf2cDatJqBa8E/mdfEE0vz6/03hKJ9gUbaDELs3L+xluLBCDJ2LL1K/NTY
         Xw0H1ofxeiBWpDSOWzNt7OQHY3bP5ZJJl+tbPM2ZYnTyMZaXV3BPJvBscSwc+CdMu8zh
         xJHsghiZLxWo0pKZds7Zpx9uqb2aIMre1OljSn8V4ncyOSsR4y1+S6pQcwdlSYJTjsYC
         Lu60Ctdq/WB6Sb7Vw7q9KvK2eDFqEo6DQQIHelLqKNchwI4tQqILd1BmwamXEgYE0n09
         ZUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264409; x=1776869209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znxX/LCQa33kO599nbk2Q/Mw7o66DJJuY9IEDvMYWxM=;
        b=D5R8++0CLswJ6VsoRM1XHb41MEt6ayyIlNP9sCdYUsnVq9dfw4ouMZseyXyEHNNIrJ
         THapsUDL79qXzymsKf+ZDG3CRLstZgqKMudnXp8yzbQSZl34WEnjcCnrVdR/ztmnKX1a
         D6t6v8rmxMvJ90TvGMQxlJ8rRVzudiwsiDZtZWGeLffp2MPpXzFqJ0xrOoNu0Dtyc0oE
         s/ZyI0sDu/EnaQJElLp5XkQQIZGHkFuSAIsV8JlOF/47THEn6xkMjBg/Jrar8I4vrwWt
         iIvVB09mQm1Q6efoJ/NhyT9DGGS/qI16ZuLXswPxcFv/wWIchchPs30fJsfloQYQ+5Vh
         PqJg==
X-Forwarded-Encrypted: i=1; AFNElJ8Cbl3dstPx8c3Gc70dW9Z/kffVJYnblfTN8oEb8lAksH4Xl0cVWzr0p7JuxfiEqhNutLg6aSQkbPmyCzM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMFQRX3fyx3ESfeT6X6C9Z6GVSlHGi5uF+TbtfxAukMoz6h6XN
	0jQZYnqFJWyESEijxXJM+1Xs5rPyn+s6gyvqMi0OxCNqCTNTfZ0wMO3Y
X-Gm-Gg: AeBDieumryKFcXy4tMoRYIeDmN+wEg4s0bszpSP35GWJ9/uL/iKVi8PoS5oBjsUS2Q0
	ITNkTQR4/RL+Aa5CDnweXuCbSUeJxaR30z4XUSGUbg/0jrZROhHklQ6yb6QpY3kbPdoJfgIUYHy
	Zso7bytzh2/OHRR3y1/mlZc8uJPnEB49+MlJre7PeELuaOX5PIS8DFN+OXu3/c8EqHQGRdKftf4
	cGFLqrKVARtVdHMQ5wYbxR2LPESAav+lZc/J369krmXAQDWoFPTRHmrgvWJKvty+nxv4WETy7EA
	ItZ4uOkX+/cDUUH728ZqkMz2vHqCSPAXHHxR9/B9nFcouAIKSrmoSyAnAuqv1cgB2zDRo+2WQoz
	jy1IzeDJRz52iE0rg191mzEk667pFkfPhbezMQQ+a/pLOtTwRqHPoiHHlWvjF+8JsrImFUPNXa5
	QiRQMBLqsevigsYqPQNvUrY/jJZNGecrxQ
X-Received: by 2002:a17:90b:4a04:b0:35b:e550:e68a with SMTP id 98e67ed59e1d1-35e4254fb13mr21922246a91.3.1776264409084;
        Wed, 15 Apr 2026 07:46:49 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd308cf98sm2310617a91.7.2026.04.15.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:46:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] macintosh: windfarm_core: fix reference leak on failed device registration
Date: Wed, 15 Apr 2026 22:46:35 +0800
Message-ID: <20260415144635.3318697-1-lgs201920130244@gmail.com>
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

When platform_device_register() fails in windfarm_core_init(), the
embedded struct device in wf_platform_device has already been
initialized by device_initialize(), but the failure path does not drop
the device reference for the current platform device:

  windfarm_core_init()
    platform_device_register(&wf_platform_device)
      device_initialize(&wf_platform_device.dev)
      setup_pdev_dma_masks(&wf_platform_device)
      return platform_device_add(&wf_platform_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by checking the return value and calling platform_device_put().

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 75722d3992f57 ("[PATCH] ppc64: Thermal control for SMU based machines")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/macintosh/windfarm_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index 5307b1e34261..4003e72f3a57 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -436,9 +436,14 @@ EXPORT_SYMBOL_GPL(wf_clear_overtemp);
 
 static int __init windfarm_core_init(void)
 {
+	int err;
+
 	DBG("wf: core loaded\n");
 
-	platform_device_register(&wf_platform_device);
+	err = platform_device_register(&wf_platform_device);
+	if (err)
+		platform_device_put(&wf_platform_device);
+
 	return 0;
 }
 
-- 
2.43.0


