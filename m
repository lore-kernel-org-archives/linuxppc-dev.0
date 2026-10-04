Return-Path: <linuxppc-dev+bounces-28894-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC557CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 23:40:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyfCQ6k3Xz2yMD;
	Mon, 05 Oct 2026 10:40:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::29"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791157234;
	cv=none; b=UI+q4ddhlqZmUQPMaC133zQFx3se91JR3KflkHXamaZj4CPBnznzfvuGs7niF8Jz+8VidWnQQ6I0T0uXBoNEv0NM5chBFuOIbRcvW5KDGxIAGBNmX2A8ljBZ6GJFSwDfQDmQcFaHEFNEV0b+4sspXkqqSX11ndoAah1nNZrHMfwoyZhkkaFs3LT6mS4Q9XuO3HxdsP1yLmS9MLPgZ/5axC9uvN7fGBRfhQjYQSeZbnYUS/EWw09n6FqarURLcXfIDbFB6Nu1E+2/WRPr2MBLL1D6jXt4nvqtCh7/xh0+aIccxtoS1RxJfgfnEgjAfOCWzpsbfXnDWGcMPihqSBjInA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791157234; c=relaxed/relaxed;
	bh=2rXZdTZVRpXf7N+j/R0iaLaKjiIHPei8gO3MrSkIgzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aleHZsrJ7pa3uKecQfLu2lvyd1k+p0qId3n8JTaTJimtGhzaATAErpUpzVDx0upKLeeB1JNzkvyfWGtugJZAzBp56UzsexGr6mgunzdkyZqJ2Z4DJz+aYpCPWP8ooKS5nDBrqKHKdHMfYXcfyXABxGKciCDaFJGCRiR68z7EACUQACAmyqNUR2U35yTMB229W4do+H7f2LoV8plnEj5fsJ+rIC82ziWTk7ScwKUGSjaGBiIZfKcCE9Qox2B80u34tbGicznUZLj7BRHTlOj6Xef0a2TOKYVOycPa15W2nPPsm4GxYKMKaNsRHCPD4qCa3XHxKwcocHjgVbSvnyII6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KceMvoSL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::29; helo=mail-pj2-x29.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KceMvoSL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::29; helo=mail-pj2-x29.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x29.google.com (mail-pj2-x29.google.com [IPv6:2607:f8b0:4864:39::29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyfCP1zVLz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 10:40:32 +1100 (AEDT)
Received: by mail-pj2-x29.google.com with SMTP id d9443c01a7336-2e300fa474aso4530785ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791157229; x=1791762029; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2rXZdTZVRpXf7N+j/R0iaLaKjiIHPei8gO3MrSkIgzc=;
        b=KceMvoSLO2exGIZRVnOF9FRbflwpLjQb4BjLiWgUtOFTWkOM+26hGexlLchhkks7dM
         oKceIov3qKPta4jpjkkGt7cGjpBa3PFdKQNnuz3RibrQAkdoPB/9PTbKpw9sNU5tBUwp
         tRZPy81r95r/gQMJLSFnYm4UPALFQKLm8cAsyy13dP2sRQWE+3V+sfjc/HVl466hOk5O
         9RqzrivbuxNjvbCIr/fmAfQywnyMg/sgoIN1tJkv0/r7X17f4fTvs/j1Mr4ensZ004b+
         rEL5wOtyegFv9Yfd8U6llw8s7ZRxPz87TTyiix5lFMPTskqAgb6G+03Je7Hn8mYZFCYD
         on4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791157229; x=1791762029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2rXZdTZVRpXf7N+j/R0iaLaKjiIHPei8gO3MrSkIgzc=;
        b=HYC/Wh8sMSq75Es4OuAwfWZnU2HfTV9OjH35eS37GSMsnoANyWrhaa6wevLPQ53FBU
         LmMmng45S9i8j+4SJkiQ1Aa5TZsXFDfwftYRVzjxZd8e2ckAwLUram1G4BzS8XY3zTYw
         S5jiz4Bhc0U+TH/LND2s9eBfenmVvXklbrcjVn+JHjQyvQIf3kSJFrtpfK3+SMHlmcNV
         3BHBZEFxJ1X9VVLrv6CNbbaJa5ThdIo0gF4lnRisBxQyng6EEb0h4dWL7lHB+KmhSk+F
         sdwfzu2gw4dapOxNShzWdH5LbJTLKhcynr0YnLohcM48Jd4QmQSrPNwUjOZGhz0ZQTSR
         A4FA==
X-Gm-Message-State: AFq9FYJE7L+UrgZNotjJbUrWibdn6r79w4QS0jQRTDWeq5N7dyvkLzxB
	RKeM0fC/xtqC/tvv5GAoBSnzdHFAWBsZi3+uc2xhnZoMldi3HYbv/klrTR/VyPYc
X-Gm-Gg: AYBFou2CD83qv3levbG8YxGnWRCFIkfZAVqWnwZu+cLXzDTX5dcgSOjmQZrbaPpb2sm
	AIF6hHDpUDrm+gJYFW0CwhBlpZc9/oi1k9lMr8yAmQNakv8/fm9DT4OVy9TaUb1eSUcYH4PD+Q1
	G5v9ut9HDMFDZoVvHX/ysVdKukzeyTbDt8v39C8Xr4APXoTBwTQ3VuMCQxOg7rDfK3JpXCxDhNZ
	Nm3VYw8cwm50Ib9K1s7b5TtH+E8PZTd32b1OTSt7JjQlbOK86GFmXzwld5P2siKoK/uf5yguMaA
	t7CbI5oyS1YwZvXNjSvrvlajZKFhwzpjmkzU43MIeE8XlviqySiXJEhGW9jbGKK1hBQNEkUt2SL
	lUf4A5NmpE4Rnag5JUZiamwEHNAxPgMRzMrxN99Ass4uJzikNPBFqmHXe+e7t/TSzFso1IlGCnC
	ZDhipERA8Y6TM/WvqnPcEeRkerfnrjv0SOeKc0IFLmW4CTLp8rQQtSL4uFZj4Zkd84Vq7ur1EZH
	341CTYbSRPhtXfq0rl60i/Ggn1xBALm/Q/EKMnliWWnJT5KDMyv4SwB2+CwfetNlK8dEg6d3F7I
	r+8g9qE2FFdnhHIeOl07iWlSpcqncJB8DpPij7GVUkuk+LW5
X-Received: by 2002:a17:902:da91:b0:2df:83ce:724f with SMTP id d9443c01a7336-2e49b615cf2mr85031045ad.30.1791157228685;
        Sun, 04 Oct 2026 16:40:28 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm26962985ad.34.2026.10.04.16.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 16:40:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] macintosh: macio_asic: fix macio_add_one_device() kernel-doc
Date: Sun,  4 Oct 2026 16:40:25 -0700
Message-ID: <20261004234025.524281-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The kernel-doc comment for macio_add_one_device() does not describe
@parent and @parent_res or the return value, and describes @in_bay as
a flag although it is the media-bay device the new device sits in.

Document the missing parameters and the return value, and correct the
@in_bay description.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/macintosh/macio_asic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index ee3caa3d87d1..04fb0ffc2301 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -349,11 +349,15 @@ static void macio_setup_resources(struct macio_dev *dev,
 /**
  * macio_add_one_device - Add one device from OF node to the device tree
  * @chip: pointer to the macio_chip holding the device
+ * @parent: device to register the new device under
  * @np: pointer to the device node in the OF tree
- * @in_bay: set to 1 if device is part of a media-bay
+ * @in_bay: media-bay device this one sits in, or NULL
+ * @parent_res: resource to insert the device's resources under
  *
  * When media-bay is changed to hotswap drivers, this function will
  * be exposed to the bay driver some way...
+ *
+ * Return: the new macio_dev, or NULL on failure.
  */
 static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 					       struct device *parent,
-- 
2.56.0


