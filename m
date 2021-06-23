Return-Path: <SRS0=BFlh=LR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557BDC4743C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 03:29:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA966611C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 03:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA966611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8pfY3b04z3c1v
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 13:29:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=f5gMbUUY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a;
 helo=mail-pl1-x62a.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=f5gMbUUY; dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8pf52K4Zz3bsp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 13:29:17 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id u2so429890plf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 20:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kjmo5eTVmT7tWZTMNJxHfTOGVXPcI8T2d5zlGFsjRHw=;
 b=f5gMbUUYqisHuaCTaz83jkEMFkvgAc7XYuKqPbvUx8zyzKBQ8nVwlRMRHD8rmuQQH4
 0oQjIan0m6EiP8NdgXhmogjsrcVwdp91wuFkPZKqCp36olmS63sjPczTz/JjAs/MbQh+
 38OgBuRAyckJ7V6zxLfaWmpCshU6SF/CjtIwn2Z5RtImkVSVqvUR0pvsc7Mwx6aWLoUS
 6RMJyLa52x+h+x/VmkKKPeXtMSHZYrWIatzO+EH3A/XjSyOYYu5BDWb36KSAJ09Lx/S3
 /nadJBfc96pH487uI5AeOoaey5ocwqNQQlax6qBi8BERS4nTblbAsYEUwoYM0r2qaOwo
 GBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kjmo5eTVmT7tWZTMNJxHfTOGVXPcI8T2d5zlGFsjRHw=;
 b=FfBcYzyHLZI1UOkZraw1LA8L8b42quCp2o5IH+ptXxger7R6c8SOPA6MEdlDsqiVzY
 fBm7/6Bf7PBm3eHqeP9xB2v/eP7qIminwA8jNfkquzFvPkLgKz4tpzuO3lif0hy/mDQV
 5v3iatEUuCNmLXf981iCn/BNzKO/UOBzy1nrgOJMUJ8AqLvL8sDINoMc8TEAxS0peVgB
 fnG1ccanCBEndeAzEZ06Y89m0/Q4JQ1kP/XpsG8GKEJkSH5UBRtKMrpwOLV0LkmNLkCo
 +5nz7DVHlNiRjphJoSVpogbj0WZleMz9Ss3+kxLe4Zk/QqX4h8Hl4Hu8MFm+B7JXj0L+
 K7Ug==
X-Gm-Message-State: AOAM532myb9q5r7y1CRJFXnAA0MGt5tPu8SwI+1Tz/VQp9q1syP2DqzC
 67/IGSSvyNSLB9+Ei21PrEUPI7221Hk=
X-Google-Smtp-Source: ABdhPJwtuGUaqbysZGUUBZIYYCAlRsmPo8UiUwyILDVL81LxZGjawPokIJqumbZ1//2vfD+9LnmdNw==
X-Received: by 2002:a17:90a:5406:: with SMTP id
 z6mr7303129pjh.61.1624418954317; 
 Tue, 22 Jun 2021 20:29:14 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id s1sm21449506pgg.49.2021.06.22.20.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 20:29:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Make PPC_IRQ_SOFT_MASK_DEBUG depend on PPC64
Date: Wed, 23 Jun 2021 13:29:09 +1000
Message-Id: <20210623032909.826010-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

32-bit platforms don't have irq soft masking.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 6342f9da4545..45d871fb9155 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -84,6 +84,7 @@ config MSI_BITMAP_SELFTEST
 
 config PPC_IRQ_SOFT_MASK_DEBUG
 	bool "Include extra checks for powerpc irq soft masking"
+	depends on PPC64
 
 config XMON
 	bool "Include xmon kernel debugger"
-- 
2.23.0

