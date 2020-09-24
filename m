Return-Path: <SRS0=a6W3=DB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D875BC4346E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 06:50:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FE723772
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 06:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7BaSar6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FE723772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bxlzj4trzzDqsl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 16:50:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=m7BaSar6; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BxlkK71C7zDqZk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2020 16:38:49 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id f2so1310112pgd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2020 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D5qtslshvrhaaM1PpdIGdaX4z8+z5ZAL/vniYoBwcKc=;
 b=m7BaSar60hvoZJ0EjYFIXGhZcWl8/3p5Eb1adT2n/5OaKce8gwFxPUFprfAn8UZLaj
 HPUJSw6vVoMBuySymsChiTT8/UIwWppz2fP3ygUKR7RTBTVxU5Wnk4MUWzuW0t9Kj3lH
 7wlr1gTY5qdIr13yQk6/+vuHFmbZV/MWNtM1QzloBIoczrViztM8qAlHEJ6zUVdJ3GJo
 G4uE2n5/0RqbjFON+smU+ozj4zcB0ZPqoub8RKx5YegxqmtyO+nQPa9tDLuxci94fQtt
 rOnlU0MpldVMke6ESMkLNFV80af5xyyBeb3PeEsOpUyH22S1FAwfuiFLVyfbxB+T6rBb
 A++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D5qtslshvrhaaM1PpdIGdaX4z8+z5ZAL/vniYoBwcKc=;
 b=VCeC1ne1pLqFnvBt3VH77vXAFIDclS7cT/6b/Ekcf/UfHzDQCdGI9p6gCMrtPsiKBh
 jFV1QV9g6hHv/iTNMnM13U+M4mOJulHCZIB0b2bwJEcw5subtY3y7ZCbHpfanj1C8cI+
 cv9oB+iJduPPKCBs6LF4SMmORc33IkOhzTxxtKiNiPmLh6tkaDoxApCczZAi5+kTd9G8
 M7O1HCsdg0F6TgPnpawAxpWNwLfeQ7LvRGUKH5BqruQy3SWNI8aH5DUcD9Pvh+QG8gBz
 zEcHguSM0cHzQusmLpNFSbPh63DgT78HAR5HIoi9igpcjmYvWWTojkZ7JfzlG8EW2kns
 RCBQ==
X-Gm-Message-State: AOAM530quUMyldRysZXowg2ZU5eLsm5Sw8ux+as1U11vdD1k4gCny4PZ
 IZYxGBjytbdCQuWT5lWjqKyXkqejuYwjJQ==
X-Google-Smtp-Source: ABdhPJzrJNq/a+VvwOSKOZFatDwh8kzIs+ofl34kVUay+/MarBSVppAo7DjmJcj7xmDrfxzLxVFPJA==
X-Received: by 2002:a62:6287:0:b029:142:2501:3982 with SMTP id
 w129-20020a6262870000b029014225013982mr3121897pfb.71.1600929527481; 
 Wed, 23 Sep 2020 23:38:47 -0700 (PDT)
Received: from localhost.ibm.com (194-193-34-182.tpgi.com.au. [194.193.34.182])
 by smtp.gmail.com with ESMTPSA id y1sm1662930pgr.3.2020.09.23.23.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 23:38:46 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 07/18] powerpc/52xx/media5200: Move PHB discovery
Date: Thu, 24 Sep 2020 16:38:08 +1000
Message-Id: <20200924063819.262830-7-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924063819.262830-1-oohall@gmail.com>
References: <20200924063819.262830-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/52xx/media5200.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 07c5bc4ed0b5..efb8bdecbcc7 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -202,8 +202,6 @@ static void __init media5200_setup_arch(void)
 	/* Some mpc5200 & mpc5200b related configuration */
 	mpc5200_setup_xlb_arbiter();
 
-	mpc52xx_setup_pci();
-
 	np = of_find_matching_node(NULL, mpc5200_gpio_ids);
 	gpio = of_iomap(np, 0);
 	of_node_put(np);
@@ -244,6 +242,7 @@ define_machine(media5200_platform) {
 	.name		= "media5200-platform",
 	.probe		= media5200_probe,
 	.setup_arch	= media5200_setup_arch,
+	.discover_phbs	= mpc52xx_setup_pci,
 	.init		= mpc52xx_declare_of_platform_devices,
 	.init_IRQ	= media5200_init_irq,
 	.get_irq	= mpc52xx_get_irq,
-- 
2.26.2

