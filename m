Return-Path: <linuxppc-dev+bounces-19504-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2657FD5F7A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:02:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMBX71XSz2xc8;
	Wed, 08 Apr 2026 22:02:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649748;
	cv=none; b=c6vMSAplekKfXdGlWPkssgy9sqqZUJOGfo6yonxkNdAfnvGMkLq2iFTw5dXK7CltI4hZcaguo9FaNuHBA7Rr/dAfnE/B5ZE+s2yW/dU2wC7Bt1CC9T4+OX6qNAwviDRz1Nq0xyiunlv712Cztw66NZVN9eyDa+UphEf7CJXgpIQENqzNudQkg1GDEXaE9ixkw0TYMkDcz7T2BH1Rio4z8es3z+HOKyxvA0f+gFYbqB5CFEhTNY0s2xd5qbMFw68EmzuyYU0o2xb9pZu+EXR3nQvNqXQ23Vqsp/eY8By6Drpkp9dGy0AqXeVVZkwDJwm6g1GmbAY56LSx2ykGDCvMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649748; c=relaxed/relaxed;
	bh=LvwUSoCp81ob7OZ/uiYdZqYepJJ6XzLLo7Vd69vn/eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgWfj+l4DIzQH6pSBDLy3uUIqsNIPgOHDiAlnF2DmdIBc/S6hlG4s+KYFrXVsFElETQIrDER4ExlBk5DOEKlO/M2hGrCQRnOEI8CP2mWg1f0LSkWIu2QlSuSipzRITJKleobPs7lREyuoS5RYMt1cxPVOiL0t92COd45L/RKLZFsixwIuPG3YzCHKgEbWzeoE/yBgxgB1tCCfVmT6+vXvsUDaforOQbYhsyN2dat2ot2GfThnTIdd6Gg3e02PqNj7nB7UGUM7ID36iBYR60j2G47Lq/2Sg9U6nfBKAuE4iTp4CR1aYWNQDTxRGirQ/ob7YATzrQTve0tzF9hokot7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ke0/EKhv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ke0/EKhv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMBX2Tmmz2yks
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:02:28 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-82cf976ecacso2462533b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649746; x=1776254546; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvwUSoCp81ob7OZ/uiYdZqYepJJ6XzLLo7Vd69vn/eY=;
        b=Ke0/EKhvzkn6PZUJ/GEYnyiQW4aHXVUuCmIM58vqCZT5OO/R2f2IZNR66Rt6IHeEBP
         Iw9KjIXojo/r2BWU8DAc2A/Fm6qMTPyFHnXwNAbN2ogfsnCAOeXWRrZPNvKwvSnUx9EI
         W68zQtZgOQer3o12cgxQSyWaE2aBJIIueSkiw3cUrAMGHauU80vdAOM5qTt16fXfUw4u
         SQHturyirRKzfiJ2LoX1piCuR4MPuVbEg2UOKWKkYmyYpKoAzdD6sSmlbnLBbpWjeYcQ
         4BVSPAMwarDf9/FLF0J122Hpf/3WJSkDFhOLixy3knAO0NhrhPvkGsP6TkGPSeo1d8vO
         ntvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649746; x=1776254546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LvwUSoCp81ob7OZ/uiYdZqYepJJ6XzLLo7Vd69vn/eY=;
        b=buxaazazAt+CYTT1ilsQKPIJz+WrHnXkdb4fIEAF2Popxo1Ra1NVAKDGuK/sxXUpqQ
         8U9BqOEr/R01JO1JWdEuSHIXfnrhWdARSQvR6PEDmzCkG4bEm6rqS5DJp1a7veR7xsuz
         Z0gcIfRmgc/SrD8onVfA3/Ew4PJvdwqmsJypG8XAnm6+wzm2yY+2MtMOHsF68a1TGCTY
         MEFJi7hDl9RtmFxTiMtnD05JjqVlxhKWVIZDnixnNKO2wB1Zu2RX5rSHbf6pyuaEZytq
         R5e1K8KqQBc8eWoOxWPRukeCAd98ffto6HCTbJqbVQ34vLH2Iy7Mq+l7EwsLTAUZau/f
         K2Qw==
X-Gm-Message-State: AOJu0Yz3bXtQUdOmUVkh4vrZQp6ANtTE+s4CG731e9BbJVUSo8NHUbRI
	iTMyT6Lqm4+Vmk1XrC5kPX9bT8zR5rojPbOwAnAU58HeRhAlo/wZ8WElYKmFwA==
X-Gm-Gg: AeBDiese1tbzJWZ1nF+dINPQQD7Buzl3/jO93JoWKk678FMYqCoAtLobdlf/nbl62RJ
	t7egZGFv7qLUH2Tc5D1KmvPYj9ted8Aw8NpV+9jH0H3elqh7zcFLV+Olm6et1iobXP91PWgvYXz
	PJjYSTYf5MBF6nkFigI6IKn4xYd1SKG46vjJqcajHVyKaylxeeoLpCS8s+hRx2d+zVaCEBLtIsU
	CQqowAcRwnYFuYv1WpM+hWr2PRnK91jdsXX22DqJ2Xq4OfQFiCnNwX5CDoEFDq5LwDdn97LBmOY
	OG0NRiLHYaOunMUTwFGwa6+evc8iqdS/6QTJqSOXreCPBdRNcPWcuTzkamAaAP2SZ3eNMPDLmhc
	IuYVhcpfqV4R9hv90GxxsjO38+ApVEQoK3ZqB8kxuJ/b0+Ah3OyHsZXwoB8rbJprFRtbCgeOG6F
	dJsQVV+nm1URDzb9Kaciaouh6MGF+0Lw0J8GNbTyYWKZdC
X-Received: by 2002:a05:6a00:6ca8:b0:82c:ae58:46ad with SMTP id d2e1a72fcca58-82d0dbc813emr20521123b3a.51.1775649745709;
        Wed, 08 Apr 2026 05:02:25 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.02.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:02:24 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 08/10] pseries/papr-hvpipe: Simplify error handling in papr_hvpipe_init()
Date: Wed,  8 Apr 2026 17:31:38 +0530
Message-ID: <82eca9775d5c66104d7499aa877841cd89d5731d.1775648406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775648406.git.ritesh.list@gmail.com>
References: <cover.1775648406.git.ritesh.list@gmail.com>
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

Remove such 3 levels of nesting patterns to check success return values
from function calls.

ret = enable_hvpipe_IRQ()
    if (!ret)
	    ret = set_hvpipe_sys_param(1)
	        if (!ret)
		    ret = misc_register()

Instead just bail out to "out*:" labels, in case of any error. This
simplifies the init flow.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 26 +++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index ac2c4b42b373..5d04d1fa4370 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -783,23 +783,27 @@ static int __init papr_hvpipe_init(void)
 	}
 
 	ret = enable_hvpipe_IRQ();
-	if (!ret) {
-		ret = set_hvpipe_sys_param(1);
-		if (!ret)
-			ret = misc_register(&papr_hvpipe_dev);
-	}
+	if (ret)
+		goto out_wq;
 
-	if (!ret) {
-		pr_info("hvpipe feature is enabled\n");
-		hvpipe_feature = true;
-		return 0;
-	}
+	ret = set_hvpipe_sys_param(1);
+	if (ret)
+		goto out_wq;
 
-	pr_err("hvpipe feature is not enabled %d\n", ret);
+	ret = misc_register(&papr_hvpipe_dev);
+	if (ret)
+		goto out_wq;
+
+	pr_info("hvpipe feature is enabled\n");
+	hvpipe_feature = true;
+	return 0;
+
+out_wq:
 	destroy_workqueue(papr_hvpipe_wq);
 out:
 	kfree(papr_hvpipe_work);
 	papr_hvpipe_work = NULL;
+	pr_err("hvpipe feature is not enabled %d\n", ret);
 	return ret;
 }
 machine_device_initcall(pseries, papr_hvpipe_init);
-- 
2.39.5


