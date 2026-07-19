Return-Path: <linuxppc-dev+bounces-24411-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695D1C4450A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 05:23:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2sVz4Cgvz2yQL;
	Sun, 19 Jul 2026 15:23:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784438603;
	cv=none; b=JHDcNuMu5QbUVQ0lo105livJLHWYeZ2enl6Xu7up8e91PHbBvuHFn43y66fZ4L/VqdleQFiQEErxQYBJCSils6OGaQwPLb4CyIt/f4xHrTQg1r9MVXPPQJ581a8uATa1rCeFnAQdmUoRMQCz7Gre0miy/je8gXix87jIXKDIe3oKJXwDQNQ8+if+jrnqv440RnqY3HYxfgNxiuVthjT94V+GWtCCupNtRlOqLeSWd9q4F96vGxEs4Fb2FASNont9uMNXup6vhC+U8u+TciLQFsJ6i3TYrm0Gq5Ee0ck3NXVSSLHX66lbNKUDrNyEQein37rPH1BmNVkkDZVlAlP+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784438603; c=relaxed/relaxed;
	bh=PZ/9YxE8f5UbeN3J0t4LKoL5GudGidDACl40NXpjpQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ah5vpsGyQ1E4OAG4tvCSvKFP8+/37XuCfRv9fxEqtRmtvr4JB6dMZMefrQlbLHfWbm4nuNdDtv9+U7csRVS4DcNOmNV41IARXC++QTOL9B8jqbtSC3wlkrCa+b7DnAIIq6c5TkyIOxlgjCtpyvB1+hXnV+5o/gS/JRwQD/bmktVQ8DmtmKmyaC6hSDkHesynqiOIp2CivOcyPAt8ohhx2od8uK3sOLrjmWXwwDyN/qGWDFgtTfZSy6Birqz3TVwvIFSbbjEpbWCAFL/JQD8jzpq54+7UlOBNDrJYnfRrevMgH1g9L7MeY8kjGeowRL19ASgwZoodrKausaQ8nX37KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GhhgrKpy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GhhgrKpy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2sVy5wP4z2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 15:23:22 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso5969741a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 22:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784438601; x=1785043401; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZ/9YxE8f5UbeN3J0t4LKoL5GudGidDACl40NXpjpQ4=;
        b=GhhgrKpymErxpIi4LqLkjq/lKQ1vCGG7poOeAjSK7luf/+guzO8PRotWiHwuBr3Z37
         C3wPeefYu949+imPYcSBlIRSrGgHg+fd969Kq8aY+Eo4QAgkN3S+qgA8+YdupjQt9CQ6
         ZEqArKajQUiJjJdHL5N8O/buWrPQUuS27vzUO6Af6vzRi3WfAHAQJHn2HFKCS65o1qsm
         7Qk8hJ30cBpHc8pePnACzPWXFFvfWPgnxXXEpiQjU0Weo+eUp7HpGFo7G3j9GLdZEWk9
         0orv5ktex3MWQFyyirIn3viflA3frwwZQ3s4JS7F2IT7Y7LMSiGsBOs8EK4uh7UCFoAj
         dXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784438601; x=1785043401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZ/9YxE8f5UbeN3J0t4LKoL5GudGidDACl40NXpjpQ4=;
        b=RAdfpgansSzgKd4LimGR893xaVvK5m8dmh6OaPD2LScRuaA0UoYIPxCcQxaw/QtrWf
         b5SlhKlGthEQ81l3ybjZuUCzHy2NU8VUW/A83TN4bsbnH+aEVeN64GYv4kBkHX4hY8tc
         +U8Hce7ri8Kz3ZhOvTzBcsMQygfNdLguiahn8aeNz4csYmnpk99TS5n2jlBSjnAnY+fv
         r6WYUNAriLS5YAdk39FsjYa6E+67YRQN/3nlC8G5N6dJtbQXVhBM8fprSBZ5Q1JQ+gtZ
         nGxy7XlwArb0hjko+pttLIvz/qIse0DOQdPps4ikDNccrM4xqpHWy6tAeEBSjeuQ2PQA
         1vLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1ZVfsz3qcOkopBaaTvT9LtKjkG2Ilor6IjiUqkRHvACzzM4SlexNkfK/zkugzrp9fY3kFBPka6KPcGBo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwiRedn1Y2QSvtyyDWS67z8BucIc1a3wzO/4OG+hLDZHzxLvNOF
	6U0G2YQrIz8fCCqTLlZf7qofTARW7QDITWwfLs02APptLqBPnblZmkBb
X-Gm-Gg: AfdE7ckmzTM5g+qupl9iPtuVDHCrQO067DmO9j4pyNY9GYN6o0c4LbZJFa16mfJBAFV
	x2CR4lfM6ZxpJeZ/qYZyEBaBfZlH5wOk+toArKnaXIQxm2wwucSHVvyL7/vM2qQSIORZWceEEiL
	UfGwcfxNp+qEqwD8YNc6U2T3zGPLGvtmhGLcRvO9Xpx5k6Qk7gAqxQvd1Qyw9feE4hPZzsiEy0b
	tkl7pvJuQ4AFhaQvlTfierGrbyv/THwIhVuY+pESB/r1PE6mpujWOS0qfcpJOQLnRcDiEUGTq5m
	NHe5RYPaDcXFu7uvKuiBfrdf+FPQ5JhHyAYrsrjjt4tnHuuqH93oJKrUdYL7MhQRDJu/K4L2Wx8
	5Go5WioQu1R8mzI8po/4khVbVW4YpZJ/idrgD/wTBJh3Soq+2/Cn9ZCu4ZJyK6jESBSgyf23FPs
	dtQtbJyUPAisQBTx3+1zDWi1ExIlnmY1PjUZCZ19ZUDdk6LWRoEvwNWwipEV8v6/90cQ==
X-Received: by 2002:a05:6a21:1404:b0:3bf:6c08:fb83 with SMTP id adf61e73a8af0-3c3ad9bc105mr9522329637.51.1784438600773;
        Sat, 18 Jul 2026 22:23:20 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:431d:c6bc:133f:2959])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbab9sm25950461eec.15.2026.07.18.22.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 22:23:16 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 18 Jul 2026 22:22:55 -0700
Subject: [PATCH 3/3] powerpc/512x: Remove pdm360ng platform setup in favor
 of mpc512x_generic
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
Message-Id: <20260718-ads7846-pdm360ng-v1-3-f318f85cda57@gmail.com>
References: <20260718-ads7846-pdm360ng-v1-0-f318f85cda57@gmail.com>
In-Reply-To: <20260718-ads7846-pdm360ng-v1-0-f318f85cda57@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Anatolij Gustschin <agust@denx.de>
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


