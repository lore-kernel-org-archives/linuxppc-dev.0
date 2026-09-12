Return-Path: <linuxppc-dev+bounces-27171-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26C7C88E53
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 08:29:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhl1s2l1Gz2ynZ;
	Sat, 12 Sep 2026 18:29:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::636" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789195364;
	cv=pass; b=ojpBXvxhhAkvEI7yS3b39qksO9/lizoQIx3lOHyAETdDeYLV2F39106p/pd45V75HA/avW4uAMNb/OencFnB3QM3efLvT0k+lZdnBnz/TJwVNky2raFB8BLWW3SctUDHtOMRBMnxoJnqQEhdSz3lRoI6Coj2N5+Rx4GwsgzFNueNVZTRPyRZUj4bmJFN98i3fxoq0wFIFz0JLd2XiwkO0E5bcfgyj4K9LNG9wGWe8B/gc36Uex+uZ5pqdHy5cpYTHCcB2AXiUAb6AzYZDdQRU20m+lXA8f5jHXpOkus2pSZvpCN+HR3hpYB/mMXRwD7VNnJ4Gn1a8jRO6qBweUhtWA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789195364; c=relaxed/relaxed;
	bh=cIueFh+gkuoIg/zyR6m8UHNu9YPuEhQan6MTb8FOTWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5MazBlPzsV7WH0oXDv3yA9cUgazCWBgP/hcapUiKfEkcdlVUrz/sh8VWkW6Ccx2/o5QXtEB4S2xZ83uYoIc/uvGQ6NbH9MWMZ+rcUo4zk9/fiQ+vd977hbJNKZ5YJ9ebju7lSwt3D0MSh37X94xJcx8sY2SSvHnhEcrsHOokbne+G+5P8t46zbIVsURyiQZAnw5ikDpq9pkGRcdA+m5mZRt3Bdp+GALXAjisoRUEzz6ed3pNLkis6IM2xU4DTHcIRu0dUO7Ngm1zKZOrgXAdzMmnurvzEgrgUrJdhBgHUr9cs9C6QjU5fn3QydeifcPzEEyit6BexSj1Dz6UvGe9Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lFS+eprr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=clamor95@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lFS+eprr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=clamor95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhhg76Gfxz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 16:42:43 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2caced6038eso17644245ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 23:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789195361; cv=none;
        d=google.com; s=arc-20260327;
        b=RyAtJOqZz5Il9lo4gFkzBly10nX63FvLFWj0AWWl2rDg2bKJ1Jo+k1GKnjDe2gPD8x
         OH9VXie+nyOj09anUAa/RM4X8z0IxOF71t5I7K93C55svU9rFsyPuyS+/R37ZMCJAwIy
         Q3q24zVsQk937VPFwlRwLvF4RwUISdTeEn6otupKpzyBk4bKOmtHRrS+yC7E2nPFXQkb
         33UQeyuzie//leoNETtKEBhS/z9bk1M6IezCQCTvgp62oENJ1w8+Qc4TR2ytKmhLUS2q
         wYxrm8H+grxTgu978mJ8k22TbdeGXDjLv1EAzU0XTLQiM6phyoQBS6as9je5LReudL+L
         m8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIueFh+gkuoIg/zyR6m8UHNu9YPuEhQan6MTb8FOTWM=;
        fh=eBNfXC8lHTHymC5wceprrpIGacm9I1cz+uu1wkbLZHg=;
        b=nsJicx7/zI+dAW3OxC/NxLM8Y6JhSsC+pQtwD+LMAb6FdGEwWbshX4m3otU7xpyZ9X
         wfEtVuitrhBGrzYdV5AX1ImOQWPfzA1H6834eNny6uIYzcR9gXR5XaEHkpSdx2xBkvcq
         7JwhklzKucCsA41sb7t7h9Yi+OINNKhBCsFJpZMU0/5EBIiKhCAKH/9oCyqKJ388vCz0
         5M/9tRWWvu0FTN9APXYCMIGvEObVD7DOJ+owt6Yunf6dbzS9sZA2VTUlaI0Lzp6e6ceI
         yHBQX7C2AlMXUNyHwjPI9yxw2cFlfj9a1QmNBIDvOXOmSaK74kRxqjRBWCnyLmYCByJC
         cDJA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789195361; x=1789800161; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIueFh+gkuoIg/zyR6m8UHNu9YPuEhQan6MTb8FOTWM=;
        b=lFS+eprrKCyqRV6uQZwXIX29qMvji8Dgar5ma4mto1NZABmTKVmFbbYDjDAQ8WvJnu
         GIxPx4bV+lncsEUCIsF4of5JZQCA6NjNc98UytDAPcVQB09l45f/IFX2TJOHI1ZwuniA
         +07pSsX7VTP/Rsgx65fCHR0TxDBJoJk/D7ovng4DpODc9XTvgPZftUjX8IRMgTisRsfW
         6N319qId5Ily1G0QlApCO13nwLqf8DGVyd5tqhEcoJDtjKAdkxHUG0QUW6cd1+SvfcgO
         2Au9LBFCpd7GLeKtgA24xExea9IiP/M/3neVA6hxCJKHbArsr7B427MK+GQ4caTfwKlC
         KBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789195361; x=1789800161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIueFh+gkuoIg/zyR6m8UHNu9YPuEhQan6MTb8FOTWM=;
        b=cm5X0OxSzyRjs+i6wkMBS00BoCD6GPj/RFjsN1XtlQ3synFKf+nK8K2uuBNrKGjSbR
         IISTTowzi0P9WdD8zIA7VO6ODq+Q6CGKzHXVhrOfxL9J1VEhz7fRDQoGUZDHCZdW9laN
         T35Y9NxImRWSgZlZZX3CMREkavd6zBdmxsHnUq5xrI2IC3JCdKyerwupwD+NiODQLQLe
         /5Cz5DVCcl4/4gjGs9ovpkIqfcPKk26fDySzM5wigSiTlRcFsvmZ2Q3uEmT1tdVpnSAf
         +vT6e5GiWKoj78qoYXV927Kmiin0YmUOt97T+J/6pOV0DZaI2Oc6N/Jjdte/VPDpnHOZ
         ri1g==
X-Forwarded-Encrypted: i=1; AKwUvBxoC+ugcmZnecBwAriybvtwKKBDH78AHmbHhBfJHJE+sDhEqIVZYQbaPihcQzMI+QAECj+FPGJJBiox4KQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++myh6Dq4HMk8sJeTEoy8re/3/iMJSFHdBbHzX3U5+OJ+kRhL7E4
	bf5jH8+r29C/M3au4+auWj+mDRyh8YpQdWmsA3EGYyNlZzG9kXWyRTSa0TYl6GYftubqzG+gwjh
	Yv4bljl5KHb53ryyai/T//hWgdQVBnf0=
X-Gm-Gg: AYBFou3QhwofJONJ9xtHZY0Q99axPOzKaD4o7WqFpx7cW+mTAnXPHtGNNFOzcECbT6n
	H6D0kJi5VSj/kjrv7fPLQGq5Df5+MaYxsDiRGe9E53TKOvHwe6gZd/9gkvIqKwGj3oJRP5hbYM6
	YicnenisONIPscVgdWCCw0TIga4bJuL58x6sw2tqynapWwn7eYu8znqcmZ/Y/TouZ6fbFvvDxGa
	aYaUQo/vbVexSFN755XrY9j11v0oE+M75V/vp9L7EElRlJayDdNo44CWUA2XZ05npbOYWi0QRFJ
	meZTnYA9vyp/9/sL24BxHgTV35wr31WGMmOSX/EIhLjhqgF1DWktNa6V/NU9vWkd84rr5QTfxvp
	l6P6whViQotVF
X-Received: by 2002:a17:902:f092:b0:2dd:4438:4290 with SMTP id
 d9443c01a7336-2dd443843aamr24758605ad.3.1789195361107; Fri, 11 Sep 2026
 23:42:41 -0700 (PDT)
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
References: <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
In-Reply-To: <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 12 Sep 2026 09:42:29 +0300
X-Gm-Features: AcwNN1UU9hydFOGImBeWBO5hjkcNCRQ2PnPzv9Tt-xAUH4b_sUlrCRdkTJ4wt_0
Message-ID: <CAPVz0n0pBxP2J=5DN+k+ut0HRnTmsU64orXwxa19G0+WAxN-zg@mail.gmail.com>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jonathan Cameron <jic23@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-hwmon@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, mfd@lists.linux.dev, 
	Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Support Opensource <support.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 10 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 21:15 Arnd=
 Bergmann <arnd@arndb.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Sep 10, 2026, at 18:40, Svyatoslav Ryhel wrote:
> > __
> > Hello Arnd! May you please spare AAT2870 from being removed? I have a
> > device which uses aat2870 (LG Optimus 2X P990 Tegra 2, not upstreamed
> > yet, but in process as well) and atm I am working on converting this
> > driver to use OF. Thank you!
>
> Sure, I have removed this patch from my series now.
>

Thank you!

> > P. S. If you are planning to remove more old drivers, please CC me in
> > since I may be interested in some additional driver upgrades for
> > devices I own.
>
> Please have a look at
>
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=3Dboar=
d-remove-7.3
>

Thanks, I will keep my eye on this branch.

> I tried to be careful about figuring out exactly which drivers are
> unused, but I'm sure there are still a few false positive and false
> negative ones in there. I've added the current list of driver files below=
,
> let me know if you see something that shouldn't be there.
>
>      Arnd
>
> drivers/ata/pata_icside.c
> drivers/ata/pata_pxa.c
> drivers/char/ds1620.c
> drivers/char/hw_random/mxc-rnga.c
> drivers/char/nwbutton.c
> drivers/char/nwbutton.h
> drivers/char/nwflash.c
> drivers/clk/clk-axm5516.c
> drivers/clk/clk-stm32f4.c
> drivers/clk/clk-stm32h7.c
> drivers/clk/imx/clk-imx31.c
> drivers/clk/imx/clk-imxrt1050.c
> drivers/clk/nxp/clk-lpc18xx-ccu.c
> drivers/clk/nxp/clk-lpc18xx-cgu.c
> drivers/clk/nxp/clk-lpc18xx-creg.c
> drivers/clk/ti/clk-2xxx.c
> drivers/clocksource/armv7m_systick.c
> drivers/clocksource/mps2-timer.c
> drivers/cpufreq/sa1110-cpufreq.c
> drivers/dma/lpc18xx-dmamux.c
> drivers/dma/sa11x0-dma.c
> drivers/gpio/gpio-adp5520.c
> drivers/gpio/gpio-htc-egpio.c
> drivers/gpio/gpio-lpc18xx.c
> drivers/gpio/gpio-rc5t583.c
> drivers/gpio/gpio-rdc321x.c
> drivers/gpio/gpio-reg.c
> drivers/gpio/gpio-sa1100.c
> drivers/gpio/gpio-wm8350.c
> drivers/hwmon/ds620.c
> drivers/hwmon/f75375s.c
> drivers/hwmon/max1111.c
> drivers/hwmon/max197.c
> drivers/hwmon/wm8350-hwmon.c
> drivers/i2c/busses/i2c-acorn.c
> drivers/i2c/busses/i2c-axxia.c
> drivers/i2c/busses/i2c-lpc2k.c
> drivers/i2c/busses/i2c-stm32f4.c
> drivers/iio/adc/ad7266.c
> drivers/iio/adc/ad7791.c
> drivers/iio/adc/ad7793.c
> drivers/iio/adc/ad7887.c
> drivers/iio/adc/lp8788_adc.c
> drivers/iio/adc/lpc18xx_adc.c
> drivers/iio/dac/lpc18xx_dac.c
> drivers/iio/frequency/ad9523.c
> drivers/input/joystick/as5011.c
> drivers/input/keyboard/adp5520-keys.c
> drivers/input/keyboard/ipaq-micro-keys.c
> drivers/input/keyboard/jornada720_kbd.c
> drivers/input/keyboard/lm8323.c
> drivers/input/keyboard/lm8333.c
> drivers/input/keyboard/locomokbd.c
> drivers/input/misc/88pm80x_onkey.c
> drivers/input/misc/ad714x-i2c.c
> drivers/input/misc/ad714x-spi.c
> drivers/input/misc/ad714x.c
> drivers/input/misc/ad714x.h
> drivers/input/misc/adxl34x-i2c.c
> drivers/input/misc/adxl34x-spi.c
> drivers/input/misc/adxl34x.c
> drivers/input/misc/adxl34x.h
> drivers/input/misc/bma150.c
> drivers/input/misc/cma3000_d0x.c
> drivers/input/misc/cma3000_d0x.h
> drivers/input/misc/cma3000_d0x_i2c.c
> drivers/input/misc/kxtj9.c
> drivers/input/misc/max8997_haptic.c
> drivers/input/misc/mc13783-pwrbutton.c
> drivers/input/mouse/rpcmouse.c
> drivers/input/serio/rpckbd.c
> drivers/input/serio/sa1111ps2.c
> drivers/input/touchscreen/ad7877.c
> drivers/input/touchscreen/da9034-ts.c
> drivers/input/touchscreen/ipaq-micro-ts.c
> drivers/input/touchscreen/jornada720_ts.c
> drivers/input/touchscreen/mc13783_ts.c
> drivers/input/touchscreen/tps6507x-ts.c
> drivers/irqchip/irq-nvic.c
> drivers/irqchip/irq-sa11x0.c
> drivers/irqchip/irq-stm32-exti.c
> drivers/leds/leds-adp5520.c
> drivers/leds/leds-bd2802.c
> drivers/leds/leds-da903x.c
> drivers/leds/leds-ipaq-micro.c
> drivers/leds/leds-lm3530.c
> drivers/leds/leds-lm3532.c

LM3532 has full OF support and is functional, it just does not have
device tree users yet. I have a device using it - Motorola Atrix 4G
(Tegra 2 based).

Here is commit removing LM3532
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=3D46=
a6457870825d8b782d350fdc7e27c540734d41
Here are my patches bringing up Motorola Atrix 4G support
https://lore.kernel.org/lkml/20260721100245.444623-3-clamor95@gmail.com/

> drivers/leds/leds-lm355x.c
> drivers/leds/leds-lm3642.c
> drivers/leds/leds-locomo.c
> drivers/leds/leds-lp3944.c
> drivers/leds/leds-lp8788.c
> drivers/leds/leds-wm8350.c
> drivers/media/i2c/ths7303.c
> drivers/media/platform/samsung/s3c-camif/Kconfig
> drivers/media/platform/samsung/s3c-camif/Makefile
> drivers/media/platform/samsung/s3c-camif/camif-capture.c
> drivers/media/platform/samsung/s3c-camif/camif-core.c
> drivers/media/platform/samsung/s3c-camif/camif-core.h
> drivers/media/platform/samsung/s3c-camif/camif-regs.c
> drivers/media/platform/samsung/s3c-camif/camif-regs.h
> drivers/media/platform/st/stm32/dma2d/dma2d-hw.c
> drivers/media/platform/st/stm32/dma2d/dma2d-regs.h
> drivers/media/platform/st/stm32/dma2d/dma2d.c
> drivers/media/platform/st/stm32/dma2d/dma2d.h
> drivers/media/radio/radio-si476x.c
> drivers/mfd/88pm800.c
> drivers/mfd/88pm805.c
> drivers/mfd/88pm80x.c
> drivers/mfd/adp5520.c
> drivers/mfd/da903x.c
> drivers/mfd/ipaq-micro.c
> drivers/mfd/lp8788-irq.c
> drivers/mfd/lp8788.c
> drivers/mfd/mcp-core.c
> drivers/mfd/mcp-sa11x0.c
> drivers/mfd/menelaus.c
> drivers/mfd/rc5t583-irq.c
> drivers/mfd/rc5t583.c
> drivers/mfd/rdc321x-southbridge.c
> drivers/mfd/si476x-cmd.c
> drivers/mfd/si476x-i2c.c
> drivers/mfd/si476x-prop.c
> drivers/mfd/ucb1x00-assabet.c
> drivers/mfd/ucb1x00-core.c
> drivers/mfd/ucb1x00-ts.c
> drivers/mfd/wm8350-core.c
> drivers/mfd/wm8350-gpio.c
> drivers/mfd/wm8350-i2c.c
> drivers/mfd/wm8350-irq.c
> drivers/mfd/wm8350-regmap.c
> drivers/mfd/wm8400-core.c
> drivers/misc/bh1770glc.c
> drivers/mtd/maps/dc21285.c
> drivers/mtd/maps/pxa2xx-flash.c
> drivers/mtd/maps/sa1100-flash.c
> drivers/mtd/nand/raw/sharpsl.c
> drivers/mtd/parsers/sharpslpart.c
> drivers/mtd/spi-nor/controllers/Kconfig
> drivers/mtd/spi-nor/controllers/Makefile
> drivers/mtd/spi-nor/controllers/hisi-sfc.c
> drivers/mtd/spi-nor/controllers/nxp-spifi.c
> drivers/net/can/bxcan.c
> drivers/net/ethernet/8390/etherh.c
> drivers/net/ethernet/i825xx/ether1.c
> drivers/net/ethernet/i825xx/ether1.h
> drivers/net/ethernet/lantiq_etop.c
> drivers/net/ethernet/samsung/Kconfig
> drivers/net/ethernet/samsung/Makefile
> drivers/net/ethernet/samsung/sxgbe/Makefile
> drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
> drivers/net/ethernet/samsung/sxgbe/sxgbe_core.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.h
> drivers/net/ethernet/samsung/sxgbe/sxgbe_dma.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_dma.h
> drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.h
> drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_reg.h
> drivers/net/ethernet/seeq/ether3.c
> drivers/net/ethernet/seeq/ether3.h
> drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
> drivers/net/wireless/marvell/libertas/if_spi.c
> drivers/net/wireless/marvell/libertas/if_spi.h
> drivers/net/wireless/st/Kconfig
> drivers/net/wireless/st/Makefile
> drivers/net/wireless/st/cw1200/Kconfig
> drivers/net/wireless/st/cw1200/Makefile
> drivers/net/wireless/st/cw1200/bh.c
> drivers/net/wireless/st/cw1200/bh.h
> drivers/net/wireless/st/cw1200/cw1200.h
> drivers/net/wireless/st/cw1200/cw1200_sdio.c
> drivers/net/wireless/st/cw1200/cw1200_spi.c
> drivers/net/wireless/st/cw1200/debug.c
> drivers/net/wireless/st/cw1200/debug.h
> drivers/net/wireless/st/cw1200/fwio.c
> drivers/net/wireless/st/cw1200/fwio.h
> drivers/net/wireless/st/cw1200/hwbus.h
> drivers/net/wireless/st/cw1200/hwio.c
> drivers/net/wireless/st/cw1200/hwio.h
> drivers/net/wireless/st/cw1200/main.c
> drivers/net/wireless/st/cw1200/pm.c
> drivers/net/wireless/st/cw1200/pm.h
> drivers/net/wireless/st/cw1200/queue.c
> drivers/net/wireless/st/cw1200/queue.h
> drivers/net/wireless/st/cw1200/scan.c
> drivers/net/wireless/st/cw1200/scan.h
> drivers/net/wireless/st/cw1200/sta.c
> drivers/net/wireless/st/cw1200/sta.h
> drivers/net/wireless/st/cw1200/txrx.c
> drivers/net/wireless/st/cw1200/txrx.h
> drivers/net/wireless/st/cw1200/wsm.c
> drivers/net/wireless/st/cw1200/wsm.h
> drivers/nvmem/lpc18xx_eeprom.c
> drivers/nvmem/lpc18xx_otp.c
> drivers/pcmcia/max1600.c
> drivers/pcmcia/max1600.h
> drivers/pcmcia/pxa2xx_base.c
> drivers/pcmcia/pxa2xx_base.h
> drivers/pcmcia/pxa2xx_sharpsl.c
> drivers/pcmcia/sa1100_generic.c
> drivers/pcmcia/sa1100_generic.h
> drivers/pcmcia/sa1100_h3600.c
> drivers/pcmcia/sa1111_generic.c
> drivers/pcmcia/sa1111_generic.h
> drivers/pcmcia/sa1111_jornada720.c
> drivers/pcmcia/sa1111_neponset.c
> drivers/pcmcia/sa11xx_base.c
> drivers/pcmcia/sa11xx_base.h
> drivers/pcmcia/soc_common.c
> drivers/pcmcia/soc_common.h
> drivers/phy/phy-lpc18xx-usb-otg.c
> drivers/pinctrl/freescale/pinctrl-imxrt1050.c
> drivers/pinctrl/freescale/pinctrl-imxrt1170.c
> drivers/pinctrl/pinctrl-lpc18xx.c
> drivers/pinctrl/stm32/pinctrl-stm32f429.c
> drivers/pinctrl/stm32/pinctrl-stm32f469.c
> drivers/pinctrl/stm32/pinctrl-stm32f746.c
> drivers/pinctrl/stm32/pinctrl-stm32f769.c
> drivers/pinctrl/stm32/pinctrl-stm32h743.c
> drivers/power/reset/axxia-reset.c
> drivers/power/supply/collie_battery.c
> drivers/power/supply/da9030_battery.c
> drivers/power/supply/ipaq_micro_battery.c
> drivers/power/supply/lp8788-charger.c
> drivers/power/supply/twl4030_madc_battery.c
> drivers/power/supply/wm8350_power.c
> drivers/pwm/pwm-lpc18xx-sct.c
> drivers/regulator/88pm800-regulator.c
> drivers/regulator/da903x-regulator.c
> drivers/regulator/lp3971.c
> drivers/regulator/lp3972.c
> drivers/regulator/lp8788-buck.c
> drivers/regulator/lp8788-ldo.c
> drivers/regulator/max8649.c
> drivers/regulator/rc5t583-regulator.c
> drivers/regulator/wm8350-regulator.c
> drivers/regulator/wm8400-regulator.c
> drivers/reset/reset-lpc18xx.c
> drivers/rtc/rtc-88pm80x.c
> drivers/rtc/rtc-lp8788.c
> drivers/rtc/rtc-lpc24xx.c
> drivers/rtc/rtc-rc5t583.c
> drivers/rtc/rtc-wm8350.c
> drivers/scsi/arm/Kconfig
> drivers/scsi/arm/Makefile
> drivers/scsi/arm/acornscsi-io.S
> drivers/scsi/arm/acornscsi.c
> drivers/scsi/arm/acornscsi.h
> drivers/scsi/arm/arm_scsi.h
> drivers/scsi/arm/arxescsi.c
> drivers/scsi/arm/cumana_1.c
> drivers/scsi/arm/cumana_2.c
> drivers/scsi/arm/eesox.c
> drivers/scsi/arm/fas216.c
> drivers/scsi/arm/fas216.h
> drivers/scsi/arm/msgqueue.c
> drivers/scsi/arm/msgqueue.h
> drivers/scsi/arm/oak.c
> drivers/scsi/arm/powertec.c
> drivers/scsi/arm/queue.c
> drivers/scsi/arm/queue.h
> drivers/spi/spi-tle62x0.c
> drivers/tty/serial/21285.c
> drivers/tty/serial/8250/8250_acorn.c
> drivers/tty/serial/8250/8250_lpc18xx.c
> drivers/tty/serial/mps2-uart.c
> drivers/tty/serial/sa1100.c
> drivers/usb/host/ohci-sa1111.c
> drivers/usb/host/sl811-hcd.c
> drivers/usb/host/sl811.h
> drivers/usb/host/sl811_cs.c
> drivers/usb/musb/tusb6010.c
> drivers/usb/musb/tusb6010.h
> drivers/usb/musb/tusb6010_omap.c
> drivers/usb/phy/phy-mv-usb.h
> drivers/video/backlight/adp5520_bl.c
> drivers/video/backlight/adp8860_bl.c
> drivers/video/backlight/adp8870_bl.c
> drivers/video/backlight/ams369fg06.c
> drivers/video/backlight/bd6107.c
> drivers/video/backlight/corgi_lcd.c
> drivers/video/backlight/da903x_bl.c
> drivers/video/backlight/ep93xx_bl.c
> drivers/video/backlight/ipaq_micro_bl.c
> drivers/video/backlight/jornada720_bl.c
> drivers/video/backlight/jornada720_lcd.c
> drivers/video/backlight/lm3639_bl.c
> drivers/video/backlight/lms501kf03.c
> drivers/video/backlight/locomolcd.c
> drivers/video/backlight/lp8788_bl.c
> drivers/video/backlight/tdo24m.c
> drivers/video/fbdev/acornfb.c
> drivers/video/fbdev/acornfb.h
> drivers/video/fbdev/arcfb.c
> drivers/video/fbdev/broadsheetfb.c
> drivers/video/fbdev/core/fb_notify.c
> drivers/video/fbdev/ep93xx-fb.c
> drivers/video/fbdev/hecubafb.c
> drivers/video/fbdev/metronomefb.c
> drivers/video/fbdev/mmp/Kconfig
> drivers/video/fbdev/mmp/Makefile
> drivers/video/fbdev/mmp/core.c
> drivers/video/fbdev/mmp/fb/Kconfig
> drivers/video/fbdev/mmp/fb/Makefile
> drivers/video/fbdev/mmp/fb/mmpfb.c
> drivers/video/fbdev/mmp/fb/mmpfb.h
> drivers/video/fbdev/mmp/hw/Kconfig
> drivers/video/fbdev/mmp/hw/Makefile
> drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> drivers/video/fbdev/mmp/hw/mmp_spi.c
> drivers/video/fbdev/mmp/panel/Kconfig
> drivers/video/fbdev/mmp/panel/Makefile
> drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c
> drivers/video/fbdev/n411.c
> drivers/video/fbdev/pxa168fb.c
> drivers/video/fbdev/pxa168fb.h
> drivers/video/fbdev/s1d13xxxfb.c
> drivers/video/fbdev/sa1100fb.c
> drivers/video/fbdev/sa1100fb.h
> drivers/watchdog/lpc18xx_wdt.c
> drivers/watchdog/rdc321x_wdt.c
> drivers/watchdog/wdt285.c
> drivers/watchdog/wdt977.c
> drivers/watchdog/wm8350_wdt.c
> sound/soc/codecs/si476x.c
> sound/soc/codecs/wm8350.c
> sound/soc/codecs/wm8350.h
> sound/soc/codecs/wm8400.c
> sound/soc/codecs/wm8400.h
> sound/soc/pxa/pxa2xx-i2s.c
> sound/soc/pxa/pxa2xx-i2s.h
> sound/soc/pxa/spitz.c
> sound/soc/ti/n810.c
> sound/spi/Kconfig
> sound/spi/Makefile
> sound/spi/at73c213.c
> sound/spi/at73c213.h

Other drivers from this list seem to not be used in any of my devices.

Best regards,
Svyatoslav R.

