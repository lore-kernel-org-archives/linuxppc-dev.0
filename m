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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6279C4346E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 07:09:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BE62395B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 07:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRDmD9LD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BE62395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BxmQ40smWzDqgk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 17:09:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hRDmD9LD; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bxlkl6pZ8zDqZD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2020 16:39:11 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id 5so1302642pgf.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2020 23:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hs7ZyX2cBQHTsxxF5Jk2JeV8HIjhj94uAk5H9tfp1b4=;
 b=hRDmD9LDVT0RiP7Sq6QTaULd3fNcXZAYDlVbQZBTvFe9lEM+VRG5Fb4ACjFDqMxB3N
 topIIKGlr8kiZqtv0kLrkVrwXtA3pGB1xIibb0cx6q6A3PON8mHuawlFyF7np7QrCzne
 eKl5XMobFIupB2SbvDaOWxDsGNSuSiE+gIRU99yZJc4n/Q7bikjyteLoFEXHgw+lieCy
 8KxYQuRiZj6Qyz+JhYMTWQ27nN8BBbtTboz6eRV4gebRzw1W6Dd2HlZ0Og3vpGvBFJGt
 vDmxdcIXywtNVY69WUCklip9NlCIt0LRu+44n7VsWJ8+5ngE5NueBysJNgmZU9+sBYg9
 VM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hs7ZyX2cBQHTsxxF5Jk2JeV8HIjhj94uAk5H9tfp1b4=;
 b=MTNnht2+Q3vFv/hIpqKso1iHQaXkGwDFTETa24TR/XvaEEQnnGrWIUVLoQEFZJ352i
 snJKa4I/fufIq8X5PaoUcrVeS7kytTCLVAENgqcMq2gyJ9C0nWWh4CMcqsOFWTBqcWAt
 gWJZQpaTeQ2jutvqeXa1/6memCjOt9+5rjXqFrdNjPwozWOvfycUb25pflQF6e4fFNwt
 WVlMJFkaYhwP7MstY1AQNoK7MiuPRUu9cEsfqqVQkJ4rPsnYEDN4pC+Au6G0yzP6mdQO
 LOv6atvMjuCW1UFsUuiBDp5qfMht29Qox+jsz/uahhC1SwkrUG80Wr5Fqo3rV7/Hcedl
 VYTA==
X-Gm-Message-State: AOAM531NLQ7y7oExXWQsjY0IwgQ7pVoNb7ZZ4VAuDdM7lQa6HowB2AgZ
 e8K5K+buYSAK3NpqFyUNdaRkxZUGaYHydw==
X-Google-Smtp-Source: ABdhPJwkM+Rh6DMSI1tdZ+x69IZQpHjDVeC01OYPpu/kCOCIB/Krvg1VBNZod+TLpsrCqFRGbJ4P5Q==
X-Received: by 2002:a63:c20f:: with SMTP id b15mr2777101pgd.8.1600929547607;
 Wed, 23 Sep 2020 23:39:07 -0700 (PDT)
Received: from localhost.ibm.com (194-193-34-182.tpgi.com.au. [194.193.34.182])
 by smtp.gmail.com with ESMTPSA id y1sm1662930pgr.3.2020.09.23.23.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 23:39:07 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 16/18] powerpc/embedded6xx/mve5100: Move PHB discovery
Date: Thu, 24 Sep 2020 16:38:17 +1000
Message-Id: <20200924063819.262830-16-oohall@gmail.com>
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
compile tested with mvme5100_defconfig
---
 arch/powerpc/platforms/embedded6xx/mvme5100.c   | 13 ++++++++-----
 arch/powerpc/platforms/embedded6xx/storcenter.c |  8 ++++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index 1cd488daa0bf..c06a0490d157 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -154,17 +154,19 @@ static const struct of_device_id mvme5100_of_bus_ids[] __initconst = {
  */
 static void __init mvme5100_setup_arch(void)
 {
-	struct device_node *np;
-
 	if (ppc_md.progress)
 		ppc_md.progress("mvme5100_setup_arch()", 0);
 
-	for_each_compatible_node(np, "pci", "hawk-pci")
-		mvme5100_add_bridge(np);
-
 	restart = ioremap(BOARD_MODRST_REG, 4);
 }
 
+static void __init mvme5100_setup_pci(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, "pci", "hawk-pci")
+		mvme5100_add_bridge(np);
+}
 
 static void mvme5100_show_cpuinfo(struct seq_file *m)
 {
@@ -205,6 +207,7 @@ define_machine(mvme5100) {
 	.name			= "MVME5100",
 	.probe			= mvme5100_probe,
 	.setup_arch		= mvme5100_setup_arch,
+	.discover_phbs		= mvme5100_setup_pci,
 	.init_IRQ		= mvme5100_pic_init,
 	.show_cpuinfo		= mvme5100_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index ed1914dd34bb..e8c5de54b0e1 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -65,14 +65,17 @@ static int __init storcenter_add_bridge(struct device_node *dev)
 }
 
 static void __init storcenter_setup_arch(void)
+{
+	printk(KERN_INFO "IOMEGA StorCenter\n");
+}
+
+static void __init storcenter_setup_pci(void)
 {
 	struct device_node *np;
 
 	/* Lookup PCI host bridges */
 	for_each_compatible_node(np, "pci", "mpc10x-pci")
 		storcenter_add_bridge(np);
-
-	printk(KERN_INFO "IOMEGA StorCenter\n");
 }
 
 /*
@@ -116,6 +119,7 @@ define_machine(storcenter){
 	.name 			= "IOMEGA StorCenter",
 	.probe 			= storcenter_probe,
 	.setup_arch 		= storcenter_setup_arch,
+	.discover_phbs 		= storcenter_setup_pci,
 	.init_IRQ 		= storcenter_init_IRQ,
 	.get_irq 		= mpic_get_irq,
 	.restart 		= storcenter_restart,
-- 
2.26.2

