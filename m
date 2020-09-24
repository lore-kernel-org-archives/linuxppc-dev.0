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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A9CC4727F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 06:56:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2846F235F7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 06:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh2L1ibY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2846F235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bxm6L4S76zDqX9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 16:56:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f;
 helo=mail-pf1-x42f.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Xh2L1ibY; dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BxlkR1YFVzDqbX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2020 16:38:55 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id b124so1253012pfg.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2020 23:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sW/UzNztx1LJZzb4Lv8dPnaVX4ry9sbuSemrP+m6GqM=;
 b=Xh2L1ibYpDGQH3WONK7Ynk3O9fXyrsrfT4JwE7MvDPVrVEuhC0yIC1WLk72b4DwbGW
 K9J/VgiO3PSMGTloAdMtKN3j9S5zCics4yjU4332z1HqnsMmxkCDkKju0H486iyZhTB5
 NAOkLgqwFH9DlNjwjONXEZUV4vw6h/racmgZJJPPBNjbQRzEpP4ZjETampAl8CNQsUIx
 jm8QhYsFAWhbuqSvgsoVsu7LHWi4vzHCdO9hUTAK0Cgw0jWhN+92oKQ6iR9fRQWT4cd1
 0xL63LVXSRzmZ6Q8u2HDfQNARAlYNtFxCZkQyDVBfPypStDxcbwjruzUK0ELBSKhwJV5
 IgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sW/UzNztx1LJZzb4Lv8dPnaVX4ry9sbuSemrP+m6GqM=;
 b=Dl0sEgCPPBeVavvWB5KkxspYxy4MXKE3gPxk7fuHtErsE3vH6aiHuKet2I418Jcvpb
 8IwvjhcuU5F16AHATewUgZSFRDSX8F7C58vN+IyFWhgY+Anu0P6+bRovTdG25+ohOBGW
 h91cnZCvu7O7LPhVaRuoPEnMYA5JKfoSVMfqsPpehOFLFnbAsxXPQYIWAlXA4Ur4j5om
 iu8O0NJ84WuIqKLdXhZ5rUX5jy79vvVVglrA7IOUfCjz9OtHr98PVT1Vqqc7NRIsHbn3
 /x2n15HyRWhlVo9/2CMWGT46qQ6E6x5eajwMgwwQnmbSjmtp6aVacbSYmoExGJ0iLHIA
 TUCA==
X-Gm-Message-State: AOAM530+dc+z4Lfda9+AkVF0gjfUF9TA/NUD7vGgn8tlZUFiTLTSfGym
 vUrHsS2IT5N9x1cOf7joQ1E8h60QjWhREw==
X-Google-Smtp-Source: ABdhPJxCalXqy7xB+qwH7dgAmxlQ43QE1PxdwRiaFJK3m8vFHCg0q59T4IQONRRti2B2XzfnrUkeQg==
X-Received: by 2002:a62:520e:0:b029:142:2501:3979 with SMTP id
 g14-20020a62520e0000b029014225013979mr3256866pfb.62.1600929531889; 
 Wed, 23 Sep 2020 23:38:51 -0700 (PDT)
Received: from localhost.ibm.com (194-193-34-182.tpgi.com.au. [194.193.34.182])
 by smtp.gmail.com with ESMTPSA id y1sm1662930pgr.3.2020.09.23.23.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 23:38:51 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 09/18] powerpc/82xx/*: Move PHB discovery
Date: Thu, 24 Sep 2020 16:38:10 +1000
Message-Id: <20200924063819.262830-9-oohall@gmail.com>
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
compile tested with pq2fads_defconfig
---
 arch/powerpc/platforms/82xx/mpc8272_ads.c | 2 +-
 arch/powerpc/platforms/82xx/pq2fads.c     | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index 3fe1a6593280..0b5b9dec16d5 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -171,7 +171,6 @@ static void __init mpc8272_ads_setup_arch(void)
 	iounmap(bcsr);
 
 	init_ioports();
-	pq2_init_pci();
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8272_ads_setup_arch(), finish", 0);
@@ -205,6 +204,7 @@ define_machine(mpc8272_ads)
 	.name = "Freescale MPC8272 ADS",
 	.probe = mpc8272_ads_probe,
 	.setup_arch = mpc8272_ads_setup_arch,
+	.discover_phbs = pq2_init_pci,
 	.init_IRQ = mpc8272_ads_pic_init,
 	.get_irq = cpm2_get_irq,
 	.calibrate_decr = generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
index a74082140718..ac9113d524af 100644
--- a/arch/powerpc/platforms/82xx/pq2fads.c
+++ b/arch/powerpc/platforms/82xx/pq2fads.c
@@ -150,8 +150,6 @@ static void __init pq2fads_setup_arch(void)
 	/* Enable external IRQs */
 	clrbits32(&cpm2_immr->im_siu_conf.siu_82xx.sc_siumcr, 0x0c000000);
 
-	pq2_init_pci();
-
 	if (ppc_md.progress)
 		ppc_md.progress("pq2fads_setup_arch(), finish", 0);
 }
@@ -184,6 +182,7 @@ define_machine(pq2fads)
 	.name = "Freescale PQ2FADS",
 	.probe = pq2fads_probe,
 	.setup_arch = pq2fads_setup_arch,
+	.discover_phbs = pq2_init_pci,
 	.init_IRQ = pq2fads_pic_init,
 	.get_irq = cpm2_get_irq,
 	.calibrate_decr = generic_calibrate_decr,
-- 
2.26.2

