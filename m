Return-Path: <linuxppc-dev+bounces-27184-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D57AC88E56
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Sep 2026 08:34:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjM5G37Nxz2xft;
	Sun, 13 Sep 2026 18:34:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.141
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789288450;
	cv=none; b=KMbizCFI07OxmAJ5MCwgnKSD4/ysFi2s9wOV/qDTgSwR9EhN2oLMbqC/8bSJ7b5JtgN4JuhfF5hQXXvKgDxtp6lNH0jfqTz+5t/d9X1CaDXTG1uR4TYm6/J6hiWrRDeV6Ba+pyw/QRu7CoMxgvgajrtNNLGLCD0dM5rr7lWaDpqy4eo/170qOi5Htp4ZlUVQu1OVpR0fidrjzwxPtUcEusuZ8QKRio53X8EjyPz0EZgfMHbmHms7A95t+h92hNetoxZozBVyQmBWRz8CSke8ts75IWgrcv5ElWvPRKe3Dl+c2HOI4UBeKUiBT0xvyY2UODFX2mvQLCWwxsQhGjySig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789288450; c=relaxed/relaxed;
	bh=FK/hgn5ztNrzJ8FzxNsGVH8sTakZzoGmnSB/QJ0ZjK4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C30JHQPtP1p+ldGdNoiSp20kFSZltCl+XyfWonm1eJy1YelxK7psuyKCllxOMJCCfQoIVLC6V4zLVxqGXWc3lo4LKFqGCKI51P9UnUO7anooEq4Z4amgHZybY9KjUJXtpDFeeh8Wswv2f1UmKeU6E3QEUPR2YaNHEneC2Ih/EY7xJ7aDqJUg2+yt6a7dFhXRWeqjyLlx5Ew34lRaanHvrs6gTxyhAONR5b8VFFhmalToQ8hF3HpPf3doc9Wcs3NboWlfrY4+QGFdJzM+kwAodycP8c/iCTBG7QlunR99VWSh9kkrktGNfOQc3gKr4hLk4prmlkc6aniAtHCMrtAxmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=hP4uSJGU; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=nvm4EGrz; dkim-atps=neutral; spf=pass (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=hP4uSJGU;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=nvm4EGrz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjM591gLQz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 18:34:02 +1000 (AEST)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id 3F049130010C;
	Sun, 13 Sep 2026 04:33:55 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 13 Sep 2026 04:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789288434;
	 x=1789295634; bh=FK/hgn5ztNrzJ8FzxNsGVH8sTakZzoGmnSB/QJ0ZjK4=; b=
	hP4uSJGU4LPNyh7tNOFYiOwyUhoJjvn+rtx/gV1jNxsXli24Yj4H9OHWbSCUCOYp
	1LmeKkR/FDUTxfeVUcR3PW6hzHXaeKbqkwhguEsHXcWXM+EqRDq6Mutivw7D6AP7
	zxcO7/7iOjRUeRDtvmwTdGVJi91XV93oTtX2lrN8t5oAK8MveTvPjOJLHdwKGLDv
	WDY18MwDH078GeQblDSx50OkW8RYXHIL1Py1DTJXQ6l5yXDv8UpvOCwggfr73muh
	tjWCnmei/4Ederp7aq+6q9XhHyjG3orbvr7iO3P4pOWy80p3tGPWWzvPjFz6Xoj/
	l/E+uRa80heywM28ZQPbng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789288434; x=
	1789295634; bh=FK/hgn5ztNrzJ8FzxNsGVH8sTakZzoGmnSB/QJ0ZjK4=; b=n
	vm4EGrz4F6jR5JXE4wigJ8Ry7JX5M0AcC921ZlsuVqc/YpoeL8SAT+tKWa33nB0T
	ZjwnZB7JaKQBbZtda19Ii6izZqboxNE1agBJILSQAvcaL8wIdNQhGx6H6fTk7CiJ
	9DNwc7XlhvV+mMoGxebUGze3s1kX5uyoEPunC4jlIgaJyiyTX4Sbb7UtBOpcgTkm
	GA9daUeYKwy5LcIt5VDo8mzbeUuePrI+JBZLjzF/J2KeYkeu+nmvT4YELvXjrCdX
	MgxF8P55rsqI0lTOj9w6JBgCin8AMz9HlCAbF/Hl/i9h5rN/siDdaojxzhTnkeU0
	a5HBpRoQJPWwTY7SPsEjQ==
X-ME-Sender: <xms:6V-mapGAWvvTCYmPsF0gHXxbEy2q1VIUbPN28RqMGUUZtzTOrnEvuA>
    <xme:6V-mapLXRXStV_91mp4cNlBE7UDv4i1YnLRZiVf3ZoCTB1V3wH1kzPlEqS463DWcH
    jBKPFdmoJWdTPPrTaq2cSmCN-or1svTLHlOTE8BeqZQDBbr6-RKxf_M>
X-ME-Proxy-Cause: dmFkZTFlVhM1xA9XUYL3SefhQrC0hRhFkTaBBJIQ3su2kNz4MfZ3F028vj/UpSaZ9vtqdo
    wovmypaSI/+/Azrkn02Yb8tOmVCj78ufH0HthXhTBRf6WeFoUXig393+d5/MfEq2pSRnyw
    LvkfDeXAZA0b/j/z/1yiQhabfROQmtQB7KcVHYhL5U/1ONNfzRfrULV/TAUFjNOKXvZqHU
    1d3D75czeqAluQHI4FwbSCqywRuOSl2dbfCEwiQwzFVuJIGYTmYp+6BhJS/cWlHc13mRMu
    JCF4bc/fUM2PhFgmF6DfLis1vMU0ddqwu1kq89fIC1RtR0wlPT1taz0+6qP2fokAV623EC
    7WvNLhWl3kVw2NxV4IcXin9Y98/yDUmwATW+ikygGBZJ6YYQmvcBkxJjwY6s1s0lBnkurW
    dgFHyjPldyFsZBx8c3uSdH5l15d1REZen5gyrGPU1HE169zMMgo3KEmBEUmtacwkM75/YY
    grwFCl6KM0Bz9faJrynux+UReF8cohlyDGeVV9rTC5y20vL4mU3p+bx1hfEaXHZ84F3XO2
    v2UOS2mSdQ64QMhfWRfWITFHODS475vwD85qi+Wj3j/4MpFov5LCO3ZCpCX0NoG23iGgHA
    cDtOhMrnZ/x93jpFr/xtrmhKYEtASmslgyDXrwp3akV21xiDzYSAeZt4Xing
X-ME-Proxy: <xmx:7l-marCsxWSQh7GyHEJQeExs04vUHwGvSpX6l3ZVDsiTwMGzIFCPpg>
    <xmx:7l-mamy6bQq8k5lrbzz61NVzb-U8lzuLCWChRPmqZFuL-W1-V1RBnA>
    <xmx:7l-mapO3Ea7pdRgQSbEG743m78cgcMsUglEvHhQP6eVdBbbYwVXaDw>
    <xmx:7l-matdXxH-1ltZbtCG0gBd_mR1zKSCO473ThhfLCbYY-V19IRKADw>
    <xmx:8l-maj_96L_YD-vKCf9QRDIxzcji6jyg1fRDZfFt7ZuAErCOtrULUMr4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DB07132A007E; Sun, 13 Sep 2026 04:33:44 -0400 (EDT)
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
Date: Sun, 13 Sep 2026 10:33:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Daniel Thompson" <danielt@kernel.org>, "Helge Deller" <deller@gmx.de>,
 devicetree@vger.kernel.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, "Jingoo Han" <jingoohan1@gmail.com>,
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
Message-Id: <e53ae695-99ed-4f14-855b-b922a938438c@app.fastmail.com>
In-Reply-To: <20260912232047.19c4cb10@jic23-hlaptop>
References: 
 <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
 <20260912232047.19c4cb10@jic23-hlaptop>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Sep 13, 2026, at 00:20, Jonathan Cameron wrote:
> On Thu, 10 Sep 2026 20:14:15 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:
>> 
>> I tried to be careful about figuring out exactly which drivers are
>> unused, but I'm sure there are still a few false positive and false
>> negative ones in there. I've added the current list of driver files below,
>> let me know if you see something that shouldn't be there.
> Hi Arnd
>
> For I2C and SPI at least, there doesn't need to be explicit
> device tree support as long as they have defaults when platform
> data isn't there. Those two buses will happily bind based on
> a dt-compatible and their i2c_device_id or spi_device_id tables
> for example.
>
> So unless they fail to probe (some might?) we don't have
> a clear signal on whether they are in use via DT or not.
>
> For vast majority of IIO drivers we don't have an upstream
> DTS as there is no clear motivation for anyone to upstream
> the dts for a random industrial control board or similar.

Right, that was my general rule, if I had tried to remove
all drivers that could plausibly probe with an external dtb
but have no internal users, that would have easily doubled
the 300 patches I already did.

>> drivers/iio/adc/ad7266.c
> No to dropping this.
>
>
>> drivers/iio/adc/ad7791.c
> No to dropping this one.
>
>> drivers/iio/adc/ad7793.c
> Maybe. Analog devices ack needed.
>
> Production part but this one indeed fails to probe.  Analog
> folk, do you want to fix this one up?
>
>> drivers/iio/adc/ad7887.c
> No to dropping this.
>
> Production part - should work fine with defaults in driver.
> Could like the others drop the platform data handling.

This was one patch that I wasn't sure about myself (all four
drivers together) since it looks like even when they do probe
from dtb, the feature set would be limited without a DT
binding, and they have been in the tree for a rather long time
without users.

I've dropped the patch now. I looked at dropping the platform_data
handling, but I think that only makes sense if we get a
proper DT binding first.

>> drivers/iio/adc/lp8788_adc.c
> Probably
>
> Sub driver of an MFD.  I'm fine with that going if we know
> the mfd is no longer in use.

Ok, I posted that one as
https://lore.kernel.org/all/20260909132153.1596191-8-arnd@kernel.org/

and so far, everyone agreed on removing it.

>> drivers/iio/adc/lpc18xx_adc.c
>> drivers/iio/dac/lpc18xx_dac.c
> Probably
>
> Likewise these two.

Right, this one of course should follow the removal of
CONFIG_ARCH_LPC18XX in arch/arm/

>> drivers/iio/frequency/ad9523.c
> Maybe. Analog Devices ack needed.
>
> Fails to probe without platform data and marked not recomended
> for new designs. If we get an Ack from Analog devices folk
> I'm fine with this one going away.

This matches what I wrote in 
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=20c1515b0caec2769c0916d087326f640bfb8aab

I'll keep the patch in the series and we'll see what the
maintainers think when I post it.

Thanks a lot for taking a look!

I wonder if some of the older Analog drivers were only ever used
on Blackfin. My series still removes a few more drivers outside
of iio list that had platform_data in arch/blackfin/ until we
removed that in 2018. These all fail to probe without
platform_data, which means they also wouldn't work with the
downstream adsp-sc5xx/sc8xx port or any other upstream Arm
platform:

a4bdf847e0e1 backlight: remove unused adp8860/8870 drivers
c71829e110e9 Input: touchscreen: remove unused ad7877 driver
b4d4ca64500b Input: misc: remove unused ad714x driver
978426a3fe1a usb: remove unused sl811 driver
0860c9f297c3 mfd: remove unused adp5520 driver

       Arnd

