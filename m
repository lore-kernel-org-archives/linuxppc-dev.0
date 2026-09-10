Return-Path: <linuxppc-dev+bounces-27036-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83C5C79FBF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 18:15:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgm7y0fx4z2xqM;
	Fri, 11 Sep 2026 04:15:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.138
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789064158;
	cv=none; b=FnjxXb9hIxomrkAEnk5NPl6oEkXzJFQQ32bmXnv+vtnSdssAiZy0j8BbX5y5KAu1BNCm5cy0AO5dxWbYhpp+hmoYKpKUzy9YJCy4sVEvI3iT6pf2S9IfIqHeEJGZCpdskGOh4iaJWEIvrl+odppZGi7sBJlVzskcVwiVq11ls/M93bHdsqXxXTHOGpLDtsONQsYvj4p7l3HBD92ClZ7V0lLhP4ucOxlUA0mJGGy1b/oM3cgz6/93TSWOCaON+g0/O9geTOJKH1+XaozB4dtoc0Hka893U93RmyXtGi6hcdtKltQIREF8xbGs78W3ScdGdgZJje1pAs49r4e6znKqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789064158; c=relaxed/relaxed;
	bh=VtH5i260XLRsxy4HROM4Zf+emhgdsSBynbPgRNN9ky8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A6SBiuuhPZbnkdnekOjP5TZpgwPsZE6uvwweCSLzXHBRW8qd+1+WdQcyqIzafey7GcoPvBblTU6UMt8yqMM2/GpNjokzHutwQGbsiZ5Toizqsyl/iJqeQ6zwjh1K+lABik0kmxBgMrt3h6OCSbXTrGgK+cM+wYwpKoahOmAQukAerjQOsu0bix7xp1hZ6IfObnw/Cugh6gY2M+7SfmZ6I5NhwGsWQwjTaMGi0esmKACeFvTGUB2yzt1UxX7npW40pMuaunLQD3DMRoSSQm0DigVTt8XIt/bstwHxBg5oh6fMZciXEENSad4bSLaOL/xdP5/WTSeAAB/ySamG2vylAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=ijVxd0jv; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=CdXwC7Fv; dkim-atps=neutral; spf=pass (client-ip=202.12.124.138; helo=flow-b3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=ijVxd0jv;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=CdXwC7Fv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.138; helo=flow-b3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgm7s5zmgz2xJJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 04:15:53 +1000 (AEST)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id 90062130016B;
	Thu, 10 Sep 2026 14:15:45 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 10 Sep 2026 14:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789064144;
	 x=1789071344; bh=VtH5i260XLRsxy4HROM4Zf+emhgdsSBynbPgRNN9ky8=; b=
	ijVxd0jvXkU6jHQGr5fM6K6ZY5mG4P1W/ROxqWDRxQKmS7rDY2TzR/Z9bwY1LnG4
	qhxnwwW+p7mr5baW9Pijze8t8yetIb0/SyG82k6avP6YdqPRurILIhZOvJZ0jVS7
	yuZzjczGOmYe0TdR5am6uZPHFVhqzlIhndDLY5yOGCTat8lCdJWga95rLTXAcD7Y
	y2BP65oml+M4FSZGVvSVZvVc6G6xDLFdHriq9fjtNWufrpAu1Pt1pmK3n0kZsAEH
	o84Z+NQp4QEp1YixNZ9GTVri9wBYq2b5VYYrrcVt1y3W8+i2RmywBqNyjIJkXjNU
	5Dh3FQeLYs5lgwxjxgIwig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789064144; x=
	1789071344; bh=VtH5i260XLRsxy4HROM4Zf+emhgdsSBynbPgRNN9ky8=; b=C
	dXwC7FvnpzHQOwXZAZv8vR74hPfItTYyxz5967sqrsM/xTHSSi0kGNo+lFmwq+7S
	W845DpcmpYxxETQOFBsKvu0uW4SkumfFaBZJH4ObFBSVJZCx0uNpU+AB782OiT3l
	WE73oVpFO+Sd8+Xf8GF916mYCBmrtJnLUUeqLnqA3BHL1hOzrk4a4ZH3/SGiFE+E
	S/BDhjG2cwYNEXo7GP40HV9R9vY3p4B8Sb0vAYorN+uOW+5dC8M0X5XjWb7OTm9I
	tGfg2g6FnLkrLZ185tkn0yt7cX1DUB9f9VfRuTbNNSfIIqGxrGt34StI5NOSBkVH
	zSnSNYF9VkOVIcPxte8Tw==
X-ME-Sender: <xms:x_OiavVvbr2xnD9wDDhPiFU-KeJWaEabWJ3dElLfZaFitBOJpwaEBw>
    <xme:x_OiaiadBmhSw9JyA5Rfb18thN8_V3LDyZq4rXuV1Fs7T6DPuZ43-BbwDFHXBHFcN
    VaQdnxfmj_y2U34ME3lhf0xITinNd6xSzg5la84VMY9-tKZtbYANDAr>
X-ME-Proxy-Cause: dmFkZTG2zztKY4aY0N6GYcaHAoENgkA+3D96x+eHqiTNn9gGT9TiczF7nfZBC70+NZGtjG
    gOWis8vMPs43LIeXkE/30hpkkXxPPbvx8y0eJJlkwZzwpaCPsz8tw1dAuT1QWG/qmoESU9
    RSye3dODySNw+rAC8PMd3UB4nTQbLiKjSR1Xmrfl2Nk22KezpXEvPy+iofUb4YwImdfpcF
    X4lReQPYtR0S4wkI8Ox8Cju7zDDn9p7XY2AIVvARmOOleGHx265Ru16ZJD/nokaGsgDFdH
    Ej0wlnjScirCb92k5MIvpT+EIHPs5u8nWum9d/ff9WO+VYt2XYdqpD8kw7yl6DEnvCVBPC
    62fzoJfrs+rnLhl6F707QA3hIC92X/DpSQF42LmUnR/YwkQQs2yyF6tvs4ph/PyjBW9QQD
    SJcfJfvnk4TPiBJMIadgpVacsEeumhVQFh0uBN8pTzJNZY6tCkxMUyCGTVbE0wpi841Own
    QFamreyp+xUwfuIXrHssyjIQQjMU6phEtEN9eTAe9h3CF8YCpg1YJbdfSGOZR8H5CUZZwf
    HA1Eq907uoR9mlUBcEFTE9z6OB8eh9OQXEDpz0zBjk7v93TjidKKdVBlo1+n6gpZakl9lz
    IACe3ohu5UE6o48Y5bLcXtfTLRwqaRevknsM/XKoJezWWoAdutP9pLq3uecw
X-ME-Proxy: <xmx:zfOiamBNqfysXndRRgMiCY7NBQ43FZSbFLDO5__pMi3DVjuH4RJEAg>
    <xmx:zfOianeBZmje1IXxldxRji_qyPUrW_hrUuiBzdPBxrH-PduRBPfQ6w>
    <xmx:zfOiauslcdlMubignkweR-Oig-HcA94Is7ov3vgNbVXHT0vzPqCfDg>
    <xmx:zfOiapLV-rCRVSNrKaXhOzFg-AGXz8zlLD1yFZCUJp2vjVjwbS-r_A>
    <xmx:0POiarGOLRgBpdCk7akkQdCfV8pfABe6Zb6bnwPbJu0wyJHblTYq1PZn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B0D6332A007B; Thu, 10 Sep 2026 14:15:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: AK-jVwBtQCQR
Date: Thu, 10 Sep 2026 20:14:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Daniel Thompson" <danielt@kernel.org>, "Helge Deller" <deller@gmx.de>,
 devicetree@vger.kernel.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, "Jonathan Cameron" <jic23@kernel.org>,
 "Jingoo Han" <jingoohan1@gmail.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>,
 "Linus Walleij" <linusw@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fbdev@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-watchdog@vger.kernel.org,
 "Guenter Roeck" <linux@roeck-us.net>, linuxppc-dev@lists.ozlabs.org,
 llvm@lists.linux.dev, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 mfd@lists.linux.dev, "Michael Hennerich" <michael.hennerich@analog.com>,
 patches@opensource.cirrus.com, "Pavel Machek" <pavel@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Support Opensource" <support.opensource@diasemi.com>
Message-Id: <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
In-Reply-To: 
 <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
References: 
 <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 10, 2026, at 18:40, Svyatoslav Ryhel wrote:
> __ 
> Hello Arnd! May you please spare AAT2870 from being removed? I have a 
> device which uses aat2870 (LG Optimus 2X P990 Tegra 2, not upstreamed 
> yet, but in process as well) and atm I am working on converting this 
> driver to use OF. Thank you!

Sure, I have removed this patch from my series now.

> P. S. If you are planning to remove more old drivers, please CC me in 
> since I may be interested in some additional driver upgrades for 
> devices I own.

Please have a look at

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3

I tried to be careful about figuring out exactly which drivers are
unused, but I'm sure there are still a few false positive and false
negative ones in there. I've added the current list of driver files below,
let me know if you see something that shouldn't be there.

     Arnd

drivers/ata/pata_icside.c
drivers/ata/pata_pxa.c
drivers/char/ds1620.c
drivers/char/hw_random/mxc-rnga.c
drivers/char/nwbutton.c
drivers/char/nwbutton.h
drivers/char/nwflash.c
drivers/clk/clk-axm5516.c
drivers/clk/clk-stm32f4.c
drivers/clk/clk-stm32h7.c
drivers/clk/imx/clk-imx31.c
drivers/clk/imx/clk-imxrt1050.c
drivers/clk/nxp/clk-lpc18xx-ccu.c
drivers/clk/nxp/clk-lpc18xx-cgu.c
drivers/clk/nxp/clk-lpc18xx-creg.c
drivers/clk/ti/clk-2xxx.c
drivers/clocksource/armv7m_systick.c
drivers/clocksource/mps2-timer.c
drivers/cpufreq/sa1110-cpufreq.c
drivers/dma/lpc18xx-dmamux.c
drivers/dma/sa11x0-dma.c
drivers/gpio/gpio-adp5520.c
drivers/gpio/gpio-htc-egpio.c
drivers/gpio/gpio-lpc18xx.c
drivers/gpio/gpio-rc5t583.c
drivers/gpio/gpio-rdc321x.c
drivers/gpio/gpio-reg.c
drivers/gpio/gpio-sa1100.c
drivers/gpio/gpio-wm8350.c
drivers/hwmon/ds620.c
drivers/hwmon/f75375s.c
drivers/hwmon/max1111.c
drivers/hwmon/max197.c
drivers/hwmon/wm8350-hwmon.c
drivers/i2c/busses/i2c-acorn.c
drivers/i2c/busses/i2c-axxia.c
drivers/i2c/busses/i2c-lpc2k.c
drivers/i2c/busses/i2c-stm32f4.c
drivers/iio/adc/ad7266.c
drivers/iio/adc/ad7791.c
drivers/iio/adc/ad7793.c
drivers/iio/adc/ad7887.c
drivers/iio/adc/lp8788_adc.c
drivers/iio/adc/lpc18xx_adc.c
drivers/iio/dac/lpc18xx_dac.c
drivers/iio/frequency/ad9523.c
drivers/input/joystick/as5011.c
drivers/input/keyboard/adp5520-keys.c
drivers/input/keyboard/ipaq-micro-keys.c
drivers/input/keyboard/jornada720_kbd.c
drivers/input/keyboard/lm8323.c
drivers/input/keyboard/lm8333.c
drivers/input/keyboard/locomokbd.c
drivers/input/misc/88pm80x_onkey.c
drivers/input/misc/ad714x-i2c.c
drivers/input/misc/ad714x-spi.c
drivers/input/misc/ad714x.c
drivers/input/misc/ad714x.h
drivers/input/misc/adxl34x-i2c.c
drivers/input/misc/adxl34x-spi.c
drivers/input/misc/adxl34x.c
drivers/input/misc/adxl34x.h
drivers/input/misc/bma150.c
drivers/input/misc/cma3000_d0x.c
drivers/input/misc/cma3000_d0x.h
drivers/input/misc/cma3000_d0x_i2c.c
drivers/input/misc/kxtj9.c
drivers/input/misc/max8997_haptic.c
drivers/input/misc/mc13783-pwrbutton.c
drivers/input/mouse/rpcmouse.c
drivers/input/serio/rpckbd.c
drivers/input/serio/sa1111ps2.c
drivers/input/touchscreen/ad7877.c
drivers/input/touchscreen/da9034-ts.c
drivers/input/touchscreen/ipaq-micro-ts.c
drivers/input/touchscreen/jornada720_ts.c
drivers/input/touchscreen/mc13783_ts.c
drivers/input/touchscreen/tps6507x-ts.c
drivers/irqchip/irq-nvic.c
drivers/irqchip/irq-sa11x0.c
drivers/irqchip/irq-stm32-exti.c
drivers/leds/leds-adp5520.c
drivers/leds/leds-bd2802.c
drivers/leds/leds-da903x.c
drivers/leds/leds-ipaq-micro.c
drivers/leds/leds-lm3530.c
drivers/leds/leds-lm3532.c
drivers/leds/leds-lm355x.c
drivers/leds/leds-lm3642.c
drivers/leds/leds-locomo.c
drivers/leds/leds-lp3944.c
drivers/leds/leds-lp8788.c
drivers/leds/leds-wm8350.c
drivers/media/i2c/ths7303.c
drivers/media/platform/samsung/s3c-camif/Kconfig
drivers/media/platform/samsung/s3c-camif/Makefile
drivers/media/platform/samsung/s3c-camif/camif-capture.c
drivers/media/platform/samsung/s3c-camif/camif-core.c
drivers/media/platform/samsung/s3c-camif/camif-core.h
drivers/media/platform/samsung/s3c-camif/camif-regs.c
drivers/media/platform/samsung/s3c-camif/camif-regs.h
drivers/media/platform/st/stm32/dma2d/dma2d-hw.c
drivers/media/platform/st/stm32/dma2d/dma2d-regs.h
drivers/media/platform/st/stm32/dma2d/dma2d.c
drivers/media/platform/st/stm32/dma2d/dma2d.h
drivers/media/radio/radio-si476x.c
drivers/mfd/88pm800.c
drivers/mfd/88pm805.c
drivers/mfd/88pm80x.c
drivers/mfd/adp5520.c
drivers/mfd/da903x.c
drivers/mfd/ipaq-micro.c
drivers/mfd/lp8788-irq.c
drivers/mfd/lp8788.c
drivers/mfd/mcp-core.c
drivers/mfd/mcp-sa11x0.c
drivers/mfd/menelaus.c
drivers/mfd/rc5t583-irq.c
drivers/mfd/rc5t583.c
drivers/mfd/rdc321x-southbridge.c
drivers/mfd/si476x-cmd.c
drivers/mfd/si476x-i2c.c
drivers/mfd/si476x-prop.c
drivers/mfd/ucb1x00-assabet.c
drivers/mfd/ucb1x00-core.c
drivers/mfd/ucb1x00-ts.c
drivers/mfd/wm8350-core.c
drivers/mfd/wm8350-gpio.c
drivers/mfd/wm8350-i2c.c
drivers/mfd/wm8350-irq.c
drivers/mfd/wm8350-regmap.c
drivers/mfd/wm8400-core.c
drivers/misc/bh1770glc.c
drivers/mtd/maps/dc21285.c
drivers/mtd/maps/pxa2xx-flash.c
drivers/mtd/maps/sa1100-flash.c
drivers/mtd/nand/raw/sharpsl.c
drivers/mtd/parsers/sharpslpart.c
drivers/mtd/spi-nor/controllers/Kconfig
drivers/mtd/spi-nor/controllers/Makefile
drivers/mtd/spi-nor/controllers/hisi-sfc.c
drivers/mtd/spi-nor/controllers/nxp-spifi.c
drivers/net/can/bxcan.c
drivers/net/ethernet/8390/etherh.c
drivers/net/ethernet/i825xx/ether1.c
drivers/net/ethernet/i825xx/ether1.h
drivers/net/ethernet/lantiq_etop.c
drivers/net/ethernet/samsung/Kconfig
drivers/net/ethernet/samsung/Makefile
drivers/net/ethernet/samsung/sxgbe/Makefile
drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
drivers/net/ethernet/samsung/sxgbe/sxgbe_core.c
drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.h
drivers/net/ethernet/samsung/sxgbe/sxgbe_dma.c
drivers/net/ethernet/samsung/sxgbe/sxgbe_dma.h
drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c
drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.c
drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.h
drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
drivers/net/ethernet/samsung/sxgbe/sxgbe_reg.h
drivers/net/ethernet/seeq/ether3.c
drivers/net/ethernet/seeq/ether3.h
drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
drivers/net/wireless/marvell/libertas/if_spi.c
drivers/net/wireless/marvell/libertas/if_spi.h
drivers/net/wireless/st/Kconfig
drivers/net/wireless/st/Makefile
drivers/net/wireless/st/cw1200/Kconfig
drivers/net/wireless/st/cw1200/Makefile
drivers/net/wireless/st/cw1200/bh.c
drivers/net/wireless/st/cw1200/bh.h
drivers/net/wireless/st/cw1200/cw1200.h
drivers/net/wireless/st/cw1200/cw1200_sdio.c
drivers/net/wireless/st/cw1200/cw1200_spi.c
drivers/net/wireless/st/cw1200/debug.c
drivers/net/wireless/st/cw1200/debug.h
drivers/net/wireless/st/cw1200/fwio.c
drivers/net/wireless/st/cw1200/fwio.h
drivers/net/wireless/st/cw1200/hwbus.h
drivers/net/wireless/st/cw1200/hwio.c
drivers/net/wireless/st/cw1200/hwio.h
drivers/net/wireless/st/cw1200/main.c
drivers/net/wireless/st/cw1200/pm.c
drivers/net/wireless/st/cw1200/pm.h
drivers/net/wireless/st/cw1200/queue.c
drivers/net/wireless/st/cw1200/queue.h
drivers/net/wireless/st/cw1200/scan.c
drivers/net/wireless/st/cw1200/scan.h
drivers/net/wireless/st/cw1200/sta.c
drivers/net/wireless/st/cw1200/sta.h
drivers/net/wireless/st/cw1200/txrx.c
drivers/net/wireless/st/cw1200/txrx.h
drivers/net/wireless/st/cw1200/wsm.c
drivers/net/wireless/st/cw1200/wsm.h
drivers/nvmem/lpc18xx_eeprom.c
drivers/nvmem/lpc18xx_otp.c
drivers/pcmcia/max1600.c
drivers/pcmcia/max1600.h
drivers/pcmcia/pxa2xx_base.c
drivers/pcmcia/pxa2xx_base.h
drivers/pcmcia/pxa2xx_sharpsl.c
drivers/pcmcia/sa1100_generic.c
drivers/pcmcia/sa1100_generic.h
drivers/pcmcia/sa1100_h3600.c
drivers/pcmcia/sa1111_generic.c
drivers/pcmcia/sa1111_generic.h
drivers/pcmcia/sa1111_jornada720.c
drivers/pcmcia/sa1111_neponset.c
drivers/pcmcia/sa11xx_base.c
drivers/pcmcia/sa11xx_base.h
drivers/pcmcia/soc_common.c
drivers/pcmcia/soc_common.h
drivers/phy/phy-lpc18xx-usb-otg.c
drivers/pinctrl/freescale/pinctrl-imxrt1050.c
drivers/pinctrl/freescale/pinctrl-imxrt1170.c
drivers/pinctrl/pinctrl-lpc18xx.c
drivers/pinctrl/stm32/pinctrl-stm32f429.c
drivers/pinctrl/stm32/pinctrl-stm32f469.c
drivers/pinctrl/stm32/pinctrl-stm32f746.c
drivers/pinctrl/stm32/pinctrl-stm32f769.c
drivers/pinctrl/stm32/pinctrl-stm32h743.c
drivers/power/reset/axxia-reset.c
drivers/power/supply/collie_battery.c
drivers/power/supply/da9030_battery.c
drivers/power/supply/ipaq_micro_battery.c
drivers/power/supply/lp8788-charger.c
drivers/power/supply/twl4030_madc_battery.c
drivers/power/supply/wm8350_power.c
drivers/pwm/pwm-lpc18xx-sct.c
drivers/regulator/88pm800-regulator.c
drivers/regulator/da903x-regulator.c
drivers/regulator/lp3971.c
drivers/regulator/lp3972.c
drivers/regulator/lp8788-buck.c
drivers/regulator/lp8788-ldo.c
drivers/regulator/max8649.c
drivers/regulator/rc5t583-regulator.c
drivers/regulator/wm8350-regulator.c
drivers/regulator/wm8400-regulator.c
drivers/reset/reset-lpc18xx.c
drivers/rtc/rtc-88pm80x.c
drivers/rtc/rtc-lp8788.c
drivers/rtc/rtc-lpc24xx.c
drivers/rtc/rtc-rc5t583.c
drivers/rtc/rtc-wm8350.c
drivers/scsi/arm/Kconfig
drivers/scsi/arm/Makefile
drivers/scsi/arm/acornscsi-io.S
drivers/scsi/arm/acornscsi.c
drivers/scsi/arm/acornscsi.h
drivers/scsi/arm/arm_scsi.h
drivers/scsi/arm/arxescsi.c
drivers/scsi/arm/cumana_1.c
drivers/scsi/arm/cumana_2.c
drivers/scsi/arm/eesox.c
drivers/scsi/arm/fas216.c
drivers/scsi/arm/fas216.h
drivers/scsi/arm/msgqueue.c
drivers/scsi/arm/msgqueue.h
drivers/scsi/arm/oak.c
drivers/scsi/arm/powertec.c
drivers/scsi/arm/queue.c
drivers/scsi/arm/queue.h
drivers/spi/spi-tle62x0.c
drivers/tty/serial/21285.c
drivers/tty/serial/8250/8250_acorn.c
drivers/tty/serial/8250/8250_lpc18xx.c
drivers/tty/serial/mps2-uart.c
drivers/tty/serial/sa1100.c
drivers/usb/host/ohci-sa1111.c
drivers/usb/host/sl811-hcd.c
drivers/usb/host/sl811.h
drivers/usb/host/sl811_cs.c
drivers/usb/musb/tusb6010.c
drivers/usb/musb/tusb6010.h
drivers/usb/musb/tusb6010_omap.c
drivers/usb/phy/phy-mv-usb.h
drivers/video/backlight/adp5520_bl.c
drivers/video/backlight/adp8860_bl.c
drivers/video/backlight/adp8870_bl.c
drivers/video/backlight/ams369fg06.c
drivers/video/backlight/bd6107.c
drivers/video/backlight/corgi_lcd.c
drivers/video/backlight/da903x_bl.c
drivers/video/backlight/ep93xx_bl.c
drivers/video/backlight/ipaq_micro_bl.c
drivers/video/backlight/jornada720_bl.c
drivers/video/backlight/jornada720_lcd.c
drivers/video/backlight/lm3639_bl.c
drivers/video/backlight/lms501kf03.c
drivers/video/backlight/locomolcd.c
drivers/video/backlight/lp8788_bl.c
drivers/video/backlight/tdo24m.c
drivers/video/fbdev/acornfb.c
drivers/video/fbdev/acornfb.h
drivers/video/fbdev/arcfb.c
drivers/video/fbdev/broadsheetfb.c
drivers/video/fbdev/core/fb_notify.c
drivers/video/fbdev/ep93xx-fb.c
drivers/video/fbdev/hecubafb.c
drivers/video/fbdev/metronomefb.c
drivers/video/fbdev/mmp/Kconfig
drivers/video/fbdev/mmp/Makefile
drivers/video/fbdev/mmp/core.c
drivers/video/fbdev/mmp/fb/Kconfig
drivers/video/fbdev/mmp/fb/Makefile
drivers/video/fbdev/mmp/fb/mmpfb.c
drivers/video/fbdev/mmp/fb/mmpfb.h
drivers/video/fbdev/mmp/hw/Kconfig
drivers/video/fbdev/mmp/hw/Makefile
drivers/video/fbdev/mmp/hw/mmp_ctrl.c
drivers/video/fbdev/mmp/hw/mmp_ctrl.h
drivers/video/fbdev/mmp/hw/mmp_spi.c
drivers/video/fbdev/mmp/panel/Kconfig
drivers/video/fbdev/mmp/panel/Makefile
drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c
drivers/video/fbdev/n411.c
drivers/video/fbdev/pxa168fb.c
drivers/video/fbdev/pxa168fb.h
drivers/video/fbdev/s1d13xxxfb.c
drivers/video/fbdev/sa1100fb.c
drivers/video/fbdev/sa1100fb.h
drivers/watchdog/lpc18xx_wdt.c
drivers/watchdog/rdc321x_wdt.c
drivers/watchdog/wdt285.c
drivers/watchdog/wdt977.c
drivers/watchdog/wm8350_wdt.c
sound/soc/codecs/si476x.c
sound/soc/codecs/wm8350.c
sound/soc/codecs/wm8350.h
sound/soc/codecs/wm8400.c
sound/soc/codecs/wm8400.h
sound/soc/pxa/pxa2xx-i2s.c
sound/soc/pxa/pxa2xx-i2s.h
sound/soc/pxa/spitz.c
sound/soc/ti/n810.c
sound/spi/Kconfig
sound/spi/Makefile
sound/spi/at73c213.c
sound/spi/at73c213.h

