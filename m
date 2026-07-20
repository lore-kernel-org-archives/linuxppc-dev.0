Return-Path: <linuxppc-dev+bounces-24443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABB1C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 05:37:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Tmp4CXHz2xm3;
	Mon, 20 Jul 2026 15:37:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784525850;
	cv=none; b=OvA+dwxLZx+2jn6MOUPBp/3TkJ/b76g3dzbEotsbOW0D9v5N2VI0xLFv74mfThmmtJ2OdQbaJE/73u3u3akY3QZG6t3w7rcmr9NPrtC6SmKtMZxEcYhtUbCIKK1eagq+n7RX5autDUKpbiA4CPWsIEbCImXoBY/xCmfAfyuPTzFwuF6rZhbdPwbaknA1Tu4tKpxmS6L1d2cF53J5S/EEHdJq8+djhf8CvfRE36d6bWjxke/x7M+nqM+NNUjyF8zJgGWic0zjQMeakziP6BEiK1BK1rob2IBGtd/gq2apYILxEWAdXACVETNEtPPGvPKYt9y5R3cboSiAc3eZ/wUpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784525850; c=relaxed/relaxed;
	bh=PZ/9YxE8f5UbeN3J0t4LKoL5GudGidDACl40NXpjpQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5UlRt4uLogK0v6Aa2qwc0L6j7sQlLI09+hb9da5Vdl1qzD/9EgGQ1LFDISmibAPKsJFqEWL2cNz3u69ahsmZdnC0Ei8xCb55tJsvWO07PpFSHtDkEwP4/jhFIo8Ts07fv8tt7TxvANDsRIskmtKdA5NvOSByp4mHwGSEHviKv1FZKUedr6bJOf4U2wn/LR3G0bEIrkz07JcASy5lP1KkA+2fvjTlyRfEODaXx5ANbO8pFNxXUYIZUKEerVQuK+jFO7xKrAW5XRzY2PLiAnCrgzZAPsEaK+6mUDUhsveaW75DosZdA/zePsfrWY8MOH7lEZLXOZiRYBEqzV0x1Dhcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VdsqR7eL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VdsqR7eL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Tmn4m7hz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 15:37:29 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so7416639a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 22:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784525847; x=1785130647; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZ/9YxE8f5UbeN3J0t4LKoL5GudGidDACl40NXpjpQ4=;
        b=VdsqR7eL+TXdwQzX4lmqwheaEWaDRkGGxayFzxJuMQqUMFlOK/ZPmM4IJ7suHsF6rM
         KFlaso3e+reUnFBkc0km01PLiWcBVrF0mbtGWZs8n5apQxAH6phDmKl9zVstQOHn1bQJ
         4oo67nzUKVouIR5VQdAYAe4n4lj5VJ6Ns42KXgIMiZouur7Vi1s7uVR/IyIGw1lSGI0t
         wkhIsXkDXhNvRhhBDi0Ip8wPxr5Jh7seUsDHkxbQeanYnjFikpqG6olVlgFET1HMMwmj
         1PQ1bJ3XB1PYYZaCbh7msO3tf1fblu5hiPQ/svoMt/OjmsSjOiVGLKRh/XuOs5XCLLMM
         vfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784525847; x=1785130647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZ/9YxE8f5UbeN3J0t4LKoL5GudGidDACl40NXpjpQ4=;
        b=QUiYDDLJ94lr2EEIErRwhx9nyhDKae5bCTTVqiUHtscpwChcsEmGHsieppBrhH7cO8
         h9D7m/JpWxP90vFCmTrhC6Jo7aHx5nHl/f3pMEKJTtz6lcDdPOEbd5mVz3TEQ2lI4qE+
         vbu25Qjylcu8vL7qEKd5ieS49/rAHQZTPSKakbxSH7odkYoUnz8jbVGOjNSw4DbgsSnm
         fT429ZiI7MG9JFac1No50ecfBb7iRPO+BHCdefrAXuFuDeZmAADTqd1Ccg2o9HgNbenZ
         L/GFuFj5jZddhpzd9z9mRDRL9yLxnnkXNjd08eBTXipxsVXax1VgLdLS7ejSZrHohoEa
         GaWA==
X-Forwarded-Encrypted: i=1; AHgh+RrVN1jIT5RBWFm03hnIvGVZ2qPDeOZ42+WlQUSq/xVur3vpLPOlZnQqVEGMudP7j7BQyQu0hVkPqY/oRDQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy09tzFNjqicyXbL5uK1jXI2STVbV8ylrzXQ152V5LsOwf+17/i
	xY16wLFbdUy2wcln3petMmqydiXo6PmrQZQ54HaaFjpPsn/nS4uj2EAq
X-Gm-Gg: AfdE7cmVdV2Oe/IDbA2/LZuePd2RGC9ROUiXIhuwOW1PzTOG/+saqJ6VXUsuqWZgo39
	ota0gO0U6vnVZ2PKc11Oz/P9Y6bvMlc+Bi0o6pzw1EkYdJbjWpNwShS89gjnmYtty1Ko0u3j47T
	J70vphwTRP1TU9z14b2kagZKEeuSomA0fMN7JLVsoNSJvCHy76tzPDfVbr/+ut9ITmevW9DRybf
	HiAstyY00aamJy8OR6fd0LxhDSlzINDYO67+y8eGMHGrZEnDm5DbNfkH1meqWNwwYFz00PXxhJ1
	NdQ1EoObKy7BikNKGC1HWwfhIpHuc9wehLSZYrhGvMtjxzxFwLyRdsdZJS/uxJG6llrWOCKhO3g
	Tccy2tmYOK7sLq72nBvLOR75+dMoFBybcZI2vwBVmW0itZPShVDFa3i/VKRkurTMLOjcAZhSrnc
	1QF55N7l51q2OXJ75c19eWLxoUQgYnANwCRL6d0+6ZskD0kI0aMjzwolc+Cm+Q/DY0dQ==
X-Received: by 2002:a05:6a20:ce4d:b0:3c0:9c19:65a3 with SMTP id adf61e73a8af0-3c3adaa8bf4mr13638856637.75.1784525847486;
        Sun, 19 Jul 2026 22:37:27 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:345f:e51b:3d0c:4546])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm34224663eec.30.2026.07.19.22.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:37:25 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 19 Jul 2026 22:37:18 -0700
Subject: [PATCH v2 3/3] powerpc/512x: Remove pdm360ng platform setup in
 favor of mpc512x_generic
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-ads7846-pdm360ng-v2-3-1198bd108502@gmail.com>
References: <20260719-ads7846-pdm360ng-v2-0-1198bd108502@gmail.com>
In-Reply-To: <20260719-ads7846-pdm360ng-v2-0-1198bd108502@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f

Now that the ADS7845 touchscreen on PDM360NG is fully described in the
device tree, custom platform setup in pdm360ng.c is no longer needed.

Add ifm,pdm360ng to the board match list in mpc512x_generic.c, update
Kconfig to select MPC512x_GENERIC for PDM360NG, and remove pdm360ng.c.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/powerpc/platforms/512x/Kconfig           |   3 +-
 arch/powerpc/platforms/512x/Makefile          |   1 -
 arch/powerpc/platforms/512x/mpc512x_generic.c |   1 +
 arch/powerpc/platforms/512x/pdm360ng.c        | 126 --------------------------
 4 files changed, 3 insertions(+), 128 deletions(-)

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index deecede78776..9d46d791af05 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -32,11 +32,12 @@ config MPC512x_GENERIC
 	  which do not need custom platform specific setup.
 
 	  Compatible boards include:  Protonic LVT base boards (ZANMCU
-	  and VICVT2), Freescale MPC5125 Tower system.
+	  and VICVT2), Freescale MPC5125 Tower system, IFM PDM360NG.
 
 config PDM360NG
 	bool "ifm PDM360NG board"
 	depends on PPC_MPC512x
+	select MPC512x_GENERIC
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the PDM360NG board.
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index 2daf22ee26a0..4da6f6923d8f 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -7,4 +7,3 @@ obj-y				+= mpc512x_shared.o
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o mpc5121_ads_cpld.o
 obj-$(CONFIG_MPC512x_GENERIC)	+= mpc512x_generic.o
 obj-$(CONFIG_MPC512x_LPBFIFO)	+= mpc512x_lpbfifo.o
-obj-$(CONFIG_PDM360NG)		+= pdm360ng.o
diff --git a/arch/powerpc/platforms/512x/mpc512x_generic.c b/arch/powerpc/platforms/512x/mpc512x_generic.c
index d4fa6c302ccf..d330d3d85887 100644
--- a/arch/powerpc/platforms/512x/mpc512x_generic.c
+++ b/arch/powerpc/platforms/512x/mpc512x_generic.c
@@ -24,6 +24,7 @@ static const char * const board[] __initconst = {
 	"prt,prtlvt",
 	"fsl,mpc5125ads",
 	"ifm,ac14xx",
+	"ifm,pdm360ng",
 	NULL
 };
 
diff --git a/arch/powerpc/platforms/512x/pdm360ng.c b/arch/powerpc/platforms/512x/pdm360ng.c
deleted file mode 100644
index 8bbbf78bb42b..000000000000
--- a/arch/powerpc/platforms/512x/pdm360ng.c
+++ /dev/null
@@ -1,126 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2010 DENX Software Engineering
- *
- * Anatolij Gustschin, <agust@denx.de>
- *
- * PDM360NG board setup
- */
-
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_fdt.h>
-
-#include <asm/machdep.h>
-#include <asm/ipic.h>
-
-#include "mpc512x.h"
-
-#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
-    defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
-#include <linux/interrupt.h>
-#include <linux/spi/ads7846.h>
-#include <linux/spi/spi.h>
-#include <linux/notifier.h>
-
-static void *pdm360ng_gpio_base;
-
-static int pdm360ng_get_pendown_state(void)
-{
-	u32 reg;
-
-	reg = in_be32(pdm360ng_gpio_base + 0xc);
-	if (reg & 0x40)
-		setbits32(pdm360ng_gpio_base + 0xc, 0x40);
-
-	reg = in_be32(pdm360ng_gpio_base + 0x8);
-
-	/* return 1 if pen is down */
-	return (reg & 0x40) == 0;
-}
-
-static struct ads7846_platform_data pdm360ng_ads7846_pdata = {
-	.model			= 7845,
-	.get_pendown_state	= pdm360ng_get_pendown_state,
-	.irq_flags		= IRQF_TRIGGER_LOW,
-};
-
-static int __init pdm360ng_penirq_init(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-gpio");
-	if (!np) {
-		pr_err("%s: Can't find 'mpc5121-gpio' node\n", __func__);
-		return -ENODEV;
-	}
-
-	pdm360ng_gpio_base = of_iomap(np, 0);
-	of_node_put(np);
-	if (!pdm360ng_gpio_base) {
-		pr_err("%s: Can't map gpio regs.\n", __func__);
-		return -ENODEV;
-	}
-	out_be32(pdm360ng_gpio_base + 0xc, 0xffffffff);
-	setbits32(pdm360ng_gpio_base + 0x18, 0x2000);
-	setbits32(pdm360ng_gpio_base + 0x10, 0x40);
-
-	return 0;
-}
-
-static int pdm360ng_touchscreen_notifier_call(struct notifier_block *nb,
-					unsigned long event, void *__dev)
-{
-	struct device *dev = __dev;
-
-	if ((event == BUS_NOTIFY_ADD_DEVICE) &&
-	    of_device_is_compatible(dev->of_node, "ti,ads7846")) {
-		dev->platform_data = &pdm360ng_ads7846_pdata;
-		return NOTIFY_OK;
-	}
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block pdm360ng_touchscreen_nb = {
-	.notifier_call = pdm360ng_touchscreen_notifier_call,
-};
-
-static void __init pdm360ng_touchscreen_init(void)
-{
-	if (pdm360ng_penirq_init())
-		return;
-
-	bus_register_notifier(&spi_bus_type, &pdm360ng_touchscreen_nb);
-}
-#else
-static inline void __init pdm360ng_touchscreen_init(void)
-{
-}
-#endif /* CONFIG_TOUCHSCREEN_ADS7846 */
-
-static void __init pdm360ng_init(void)
-{
-	mpc512x_init();
-	pdm360ng_touchscreen_init();
-}
-
-static int __init pdm360ng_probe(void)
-{
-	mpc512x_init_early();
-
-	return 1;
-}
-
-define_machine(pdm360ng) {
-	.name			= "PDM360NG",
-	.compatible		= "ifm,pdm360ng",
-	.probe			= pdm360ng_probe,
-	.setup_arch		= mpc512x_setup_arch,
-	.init			= pdm360ng_init,
-	.init_IRQ		= mpc512x_init_IRQ,
-	.get_irq		= ipic_get_irq,
-	.restart		= mpc512x_restart,
-};

-- 
2.55.0.229.g6434b31f56-goog


