Return-Path: <linuxppc-dev+bounces-26955-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F96C79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 14:56:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg3mF27VTz2ytx;
	Thu, 10 Sep 2026 00:56:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.141
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788965789;
	cv=none; b=KO8qHPre+8D3SdOQ+Nfi6FPp2zvpC+Rjwla1Na8l3v4ttmxf4HD9H2D6O9vFMSfwymyn490VupigjAkQiw+V1G/mrPdvi/+/depJEUcglfQSiNCGR9hU8n2KMz33GnvMKlUl4yi1VgDIvpynv5x9fuQ0dq+nqPrTm3cVY53tjIwuepgxRFz+BGmuJwHWM/C9L2m910I4BnU4dNCUCiRWf3fToa/tngnAPsn8zi1sGOVcL1b47qnxLkPl4HJ77SKv4UsDA8iFPQDV72f8g+GPFoRlCWeNmL8Bh66sADmvI3rgekp3nN+5YLNR7Asrak2JjZJd5Sqq49i3YSoZoUNsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788965789; c=relaxed/relaxed;
	bh=7Sf1OydxtJEVq81Rg4jscjKjaiC0B3auBQbEfBVyOBM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LiVofmcByFxs436+buq/0AocGlrZpN1IG+bHukGf4NFBcuXHjCWRpaMkuTpSgOWxF1Rt7n1dqdtZH/ia3R9UOYa3+9w3z46Skdltqq0TVd5xS2EXqqa4dyekG6Yq8oW+8ZGDZbcMUx9F59jIyLtNIbHAE0wowsPq75vwPkBmW5hBB+CdLoS9dUivensujTCnfwPjy23700se1CM5ReQMEPn2tH6jQ6oIbY/lOvV9PFQuZUk/P8vh455jZy4Ua8fYmRWPHBmgmFkRflMze69Sur1RLyyz6y0WDJPN6ixoTNdyXghGp9NTtJFV/mFhRYKuHMYzHYED3V1NuCzZg2zFZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=edOR2XRq; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=U9oCnZzC; dkim-atps=neutral; spf=pass (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=edOR2XRq;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=U9oCnZzC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 487 seconds by postgrey-1.37 at boromir; Thu, 10 Sep 2026 00:56:25 AEST
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg3m96v1yz2yth
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 00:56:25 +1000 (AEST)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id ECD971300FD5;
	Wed,  9 Sep 2026 10:48:09 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 10:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788965289;
	 x=1788972489; bh=7Sf1OydxtJEVq81Rg4jscjKjaiC0B3auBQbEfBVyOBM=; b=
	edOR2XRqt7+DfOXGudRSD6BrdL1bF5sqrn9v6EqdKgeA+/erWMgnAY42ODb+7mYO
	vj32XTPHue5DJEyR1N28xHgCZz2al3ec0dTRgSi3sLCQDxXGe2iCq04aMBPDa3vs
	FRc9njMaUqboKD+lh+FLEVNGEUUwUbDUmSxyTDF++nGLA6zUAIFCUhP5+FtH6E8y
	mTQx2XHjQn+CvQWdHYW9gDF8hOt1exL51bxu3FWdWfB/M8TljmNcIY6SDPVJ95kz
	m7qgsWILtPM7JQ60jQ6cbXC99tHUqpKMVwGW85GP8b83r76neE2Hwp0Yc8NByVsP
	qHsZovzIFQxV0KQMh5H+vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788965289; x=
	1788972489; bh=7Sf1OydxtJEVq81Rg4jscjKjaiC0B3auBQbEfBVyOBM=; b=U
	9oCnZzCRAlpf8z0iDO4Ik36vULuiCRqOlzVIoLsbMb23ctt1HzOoQCg5oEfW7xER
	KlRpgGsXuJ2/DBkTPwg7CKYo5sd3kyMzRsMYdgDTiK1IhZUNby5zt61BS0RVeI7L
	ghfFn2TzAKE4UW2slNiU4mrEbMpbqRx0pL/BKh7jMKIacYFNRdoxIbQyhqykZwJi
	CXNHr9V5jX3sMBKOBL/p0/3PqexLxdTt8mE3/xCzgZySEAXzNpC0EJ2NiyNKvWP7
	WlT08Rbbinuf3m40vqj+Gm66+pzLzi4UzIs3B/ZPbRWXhQwmex/BNheYgdKgeQZS
	xTlV7BeIZmtMDyWWIdJ3A==
X-ME-Sender: <xms:oXGhagtFCVjMuSrNINj070xWbgle3zQCA6S6ZA7B0U5neaTPPvxWWg>
    <xme:oXGhaoQbrdvXGJ6KHHH8Up4t1QabZ5lHMGI4ZS62N2jsLjDBJy47wB8OqcsIWcSi7
    H0mlJCCatwQh_BP0ekrd7MN-vavOmW_ewRGMKW6tvTZOEv5bMDOZkXa>
X-ME-Proxy-Cause: dmFkZTGRw7pJGNg9x4eyP9g2Oo1DXn7SBZCTc/fBE1J6f2Fvw8mIQviGvrfvBUF8Yz5cPc
    sTJxVd20sVrcxL8FNQouu2b/qPCmDWn8NEAsnm2qXZNER3jeufoYAEcSYO1RMcO4b6r2Tu
    zIN5rrzJeBXMlqg0gKgHNK4Po9NVJss2gjzWWwIbXYVZJW50LS3dJQkcxeJmqKm1MimBur
    AFRfPPaNDoXwXf9HpNWtsVgaop38c5pY5A5SlYGzjelRb1rayeBd+80ZTdArTJsnnJBVt6
    vfobAC6whIpyzO6D4Nj1gOXQFJD4y17okJ7Sa8hF7qAHpCVPWcHe/ueCHIcvje4CQJY/By
    CMrtaSpqZNb2Fd4fbxt5mAze5P8YGyK1gZX0xN+SZNVwIPYgnxRyu26wRrW5qrJl5u90KV
    B+KQOVgLC2bOlZgo2LvoKitv1tUnTuicSoyr5CxXbid1wctIC7ksAx/pNU6lvZULcTJVMu
    TS4GELfWLTmFaqJS0Aw7oz3Sl5+boc4+AjOdYazYXvtZivi3ZATckKc9BHy363OMxaTXEU
    b3Nu/Eky1cc1APwl+QlpPGSbmXyKNXg8xEtrMoT2/+e9vKjzEedKGnSZhcP+Eytd0wXsJc
    AZgU7GHpFzELLx2O8crKw/TWK0N0qZjtrTAxsCYDC3pBtJwaF2fPdBrI1q+g
X-ME-Proxy: <xmx:pnGhas5P8OR8G51w3IBhc_Zadvo1JjINWXdn8rSnknEOYeQmiwm8Dg>
    <xmx:pnGhak1eOby6alFdvbuvlxs1Hk7aNl4reJxLnQ3z0VUZpsoGcthJfQ>
    <xmx:pnGhaglx6SV68g1Luwe1v0x64snP-mzbZy-_PFfqwqAgLXqjK32Qkg>
    <xmx:pnGhaljFV5c4XssIDTc-MH84xjzfvx0bM2cONTuzuy0wF-yajOlFrA>
    <xmx:qXGhamkfWdroY54p64G_GajNGnPGFNQP8IgzpU369_Lv6URwwOyIorSC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DE08632A007E; Wed,  9 Sep 2026 10:48:01 -0400 (EDT)
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
X-ThreadId: APaZlxbVBos-
Date: Wed, 09 Sep 2026 16:47:41 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Johan Hovold" <johan@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Lee Jones" <lee@kernel.org>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Daniel Thompson" <danielt@kernel.org>,
 "Jingoo Han" <jingoohan1@gmail.com>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Pavel Machek" <pavel@kernel.org>,
 "Michael Hennerich" <michael.hennerich@analog.com>,
 "Support Opensource" <support.opensource@diasemi.com>,
 "Sebastian Reichel" <sre@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Helge Deller" <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 llvm@lists.linux.dev
Message-Id: <ac367ab8-e57e-4d2f-b1cf-abda8eb6e530@app.fastmail.com>
In-Reply-To: <aqFi1qGC2QMzMAq9@hovoldconsulting.com>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-10-arnd@kernel.org>
 <aqFi1qGC2QMzMAq9@hovoldconsulting.com>
Subject: Re: [PATCH 09/14] mfd: remove unused lm3533 driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 9, 2026, at 15:44, Johan Hovold wrote:
> On Wed, Sep 09, 2026 at 03:21:46PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This driver has apparently never had any users, as it does not support
>> devicetree probing, and no lm3533_platform_data definition ever
>> existed upstream.
>
> I don't believe we ever required board files to be upstreamed?

No, but there is a general requirement that code must be usable.

With my series to drop almost all Arm board files, the use
of platform_data becomes so obscure that it becomes reasonable
to assume that any driver that requires platform_data and does
not already have an upstream definition for it is fundamentally
broken.

The only platforms that still use board files now are:

arm/omap1
arm/s3c
m68k/coldfire
mips/alchemy
mips/bcm63xx
mips/rb532
mips/txx9
sh/sh77xx

All of these are now over 20 years old, so I don't expect anyone
to add new board support or maintain boards for them except for
what is already upstream.

> There's also on-going work to enable devicetree support for this one:
>
> 	https://lore.kernel.org/lkml/20260617080031.99156-1-clamor95@gmail.com/

Ok, I've dropped this patch, thanks for pointing this one out!

      Arnd

