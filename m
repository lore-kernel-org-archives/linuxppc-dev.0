Return-Path: <linuxppc-dev+bounces-20994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDE5CD4851
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 23:19:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHNSm6MQzz2y8F;
	Sat, 16 May 2026 09:19:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778887176;
	cv=none; b=Larvax6dPUT9iITIWz+L4uhtmZGLjf0/IsZJ0ev6MI4PrOpUiE+ztBdZ2NFecv8Zy0AkC6ccEQGHMkxLeVu8HoM9lwUEnsCuDid6nP3j4A2EpuYhmTshjDSonCeFSeIxILvO6yvEqQTADu9qVacRC8QokhhXs6HLE84HI12ISM8l8itd+KH8iir9eYiJY4nWlqKEOFqsm1gzudsbbpCGrHSHg9BC9akxfQgbam+ki0zlEi/Sr3WiK/u+bxddd7Bvg/D7r05JlV0NbdzvA4ea//sMcAJGIxtVIFNfUtXRsy6r7Rz2L72Np36CK8AJ9t4lxzpDmsaq6Lba2Q/Ft3aTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778887176; c=relaxed/relaxed;
	bh=JiIBz+on4anCIN9UYStAyVoaR0wrm4N+0pgJwwJQTvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mn8+SlbpY7PvkcR0C7rryj/oMyBcc3KhVGPCFAHq/goCKetmR518NIt+5+oVepi8VsAdTn1ANoxuT3PuIcj1RKvTu7D32nr7UKI1fjNjiKsZgqjaCIBH2ca7JB6Q4LPAXt2sO3u7Jzw3my+2hZqs7evtnc/CySNUI0JYGDN3nBAASOv8YUKu6EcS2jdgIT5fZOTGvtLrnlumMwe+Z+QbkGRfbbnzn6e+ZHl4jh3GQt9gH0jsP2JsjRxpvlAj+5ix19nVfju8/fIZ0deRwrxSXejoIPvhmOka0OQZqSDIcWOV+Hyfxh7+f+75OHkwZ13vTpXeKZGaQ5Ztv80hVYr8MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LoJwDkEq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LoJwDkEq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHNSl3YXWz2xGX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 09:19:34 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so162972a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 16:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778887172; x=1779491972; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JiIBz+on4anCIN9UYStAyVoaR0wrm4N+0pgJwwJQTvY=;
        b=LoJwDkEqHwCV/AzkgcoNnMn1jWxHAP1oMSb7eaxxIgD0Ukxm1H7DPX30d+PAYZo0of
         QnqUK3BUFj3egOD8NKjNR6u6K9I23LgEQSFa1L7X/JRjqXm6Y3VRgsw+6On5e7g3qqf0
         S+id3dCUEq3dIMbei0kQL1MyNnnscqaDoPgYqRoKfaXfK1eF+8xajX14sK/RrMFw6dCC
         hBMXWGjGBQrIRbe6uJwLhExyz+KyCBehI1E29fP1LFcJQIHPxDOf1q+dcGJcFw+5/4R9
         c7phRpJzHXqUBv0Ygjw5B8iqLSIoQtGVI4l6t/mHU5Vz+GUoEnH9kSaH5MS3QN2+wG9z
         ylnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887172; x=1779491972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiIBz+on4anCIN9UYStAyVoaR0wrm4N+0pgJwwJQTvY=;
        b=LYDG+am2yDOVYAG1WpyEIDZs9oBGE4mjuO46vYWOB65x7xn/qNXunY+WLn9Pm7V4dO
         AT6FLvx7CWQVGCMCdxfePTCxmTyfpJrOB7fs9RS6CMg1oxo0KX3rXOoblb5wDedtiG1H
         HAaTAftG1Fl0mZa7EmCVdIL3EdcIHObacF5CtOz6mnJO++UsohLzL/KE3mVmX2XC6qru
         PcyPkd9grPhLVityg3gV/5858eJOul8HiHp1dYFolhEu58cRjKHDqE6PPhtyEe7SyczU
         TGRPUOAJ+vtSGuWSgyW7ethYQQ2Ed1um6xj8ZHPY0MMKsSiu7Y7TMV3X6sw0Zb0UdLjF
         BOTQ==
X-Gm-Message-State: AOJu0YxCyRM4WSrpBNWYCAFofoYRxdLmZex8RMONff0tsUIZr+b6zebB
	YL9lQiuxj1E5lvhXwXTV30rzO9sJKCDNFtBk/3yVBD5sh0ItAhL9AwvwyCk51g==
X-Gm-Gg: Acq92OGchumhUu0lQ/U7So2ODAGPcwL6TFYc3igpfC1RhhQfFpl8945CJeDqQy2Ybpy
	UyRlE2Un41xrn1qxfQXs0YB9gwUBKKfW5jeL2OLQj5Qfj5iPatgNCyyaThe8CxUAjhENu1udN1y
	5dcEK7R6TMMK+PKW/WEIlDV/Mwg4vNC3p9B/EHDVn/uykbSwj2E2ReUnq8OsqNS+vL4KMQLKMSF
	PY9tWF1iycw64q5jBk7CTHrcvqDv/7x0qtR3Zuu7BPD/3woAuvrGIq2aErA4p0ijYFDi3B8I8nr
	TF1AVo/UHCAVFUh4lzy0LvguTjYTHP9pbMQMPt8J0tcWGSrA7Hh0cnXCTXTTj7BO6IUKq1QkAAT
	MRgmXClFjItx3o7ODqfeo25IAVxT8aSwSXb6o0ZzaKtdBrW6WVR2pOsws0f6Jh1I5eUl1uH1UZb
	DP9GCYqhw01l7w3M9LvrFd/8QJo1xfodPsQ+bDYZwhzIimHr2dYmRHfuLZDjrXOBQEr5S8R54w1
	AW9mMZk9n2xAzL9cpwdQrrXnaqJ3hV8kWU=
X-Received: by 2002:a17:90b:2e49:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-36951791eefmr6070012a91.0.1778887171761;
        Fri, 15 May 2026 16:19:31 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695155a0d7sm3664928a91.2.2026.05.15.16.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:19:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Rosen Penev <rosenp@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc/44x: Set GPIO chip firmware node
Date: Fri, 15 May 2026 16:19:13 -0700
Message-ID: <20260515231913.1154801-1-rosenp@gmail.com>
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

The PPC4xx GPIO driver stopped assigning an explicit firmware node
to the gpio_chip when it moved away from of_mm_gpiochip_add_data().

Restore that association from the platform device so OF GPIO lookup
can match phandles to the registered gpiochip.

Tested on: Cisco MX60W. No more probe deferral.

Assisted-by: Codex:GPT-5.5
Fixes: 1044dbaf2a77 ("powerpc/44x: Change GPIO driver to a proper platform driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/powerpc/platforms/44x/gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/44x/gpio.c b/arch/powerpc/platforms/44x/gpio.c
index d5824b7747b3..4d5176aa6895 100644
--- a/arch/powerpc/platforms/44x/gpio.c
+++ b/arch/powerpc/platforms/44x/gpio.c
@@ -169,6 +169,8 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
 
 	gc = &chip->gc;
 
+	gc->parent = dev;
+	gc->fwnode = dev_fwnode(dev);
 	gc->base = -1;
 	gc->ngpio = 32;
 	gc->direction_input = ppc4xx_gpio_dir_in;
-- 
2.54.0


