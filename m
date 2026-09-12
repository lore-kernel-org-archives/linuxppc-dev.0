Return-Path: <linuxppc-dev+bounces-27170-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D345DC88E4D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 08:16:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhklT0jVZz2xft;
	Sat, 12 Sep 2026 18:16:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789200997;
	cv=none; b=NTYfboCQZg11mrIUz1Zxw8TVx2BjbSvNBUDwm8ZbjhTauF8hRixM9CJTA+B7Cez6GZ81Zx50mBG8+XnpQUv3r8+3/grBM8HJNMLEKxZXYVBBYEBLIlOzk6ORa+7En8upJIj++LWOMtpcDIVgE5FDXpQ/n6+BK+0T2vJ+8QWtUCCT0zFIctY5dWre+/7dxRTI1pEql0aOXsv3MPHwSjnHCFh/L5FN4d6LRY70hHpxpITKE3cWW1tdrxK/KHrE1LSi+L3cBwk4fsfk4Kl5aYKex99C+PCZAr+PtaJp6/3iek/SQiVcWte/xeLz+69+ylSUSm3U+qwaZzYXCwHi6B4mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789200997; c=relaxed/relaxed;
	bh=f3qwWyqi3bNUqorYQGcKxNjQwJcXGV0fC7D1AqFX08M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D9J1XmqosSPaAgRClEapGLBw0s63s3OEAP/O1vMa3EKRZ1eDZQGoFngZzKWa7C+oXTs4P7NBIyB30WIVN3YgpnIuqliHPc1HI8gF2mVUFcHWZEva40SV2uo3StVIUBnIksX/33kcI5OSLYHy4v0pPFw1GSoXtym6zFpxIy3BbiUp5lN/D+lj/vnJS46zN+zbACakX/6Da2j8qGWEIAvRRVAjUgx8Cz7sVl5cQbN11V828tKOjM2tW7TukfeAHOK9Rua/zWUb//jVT7MDVZE5cVomCpK71SuPlwfHc13m7+66NqRXSj+OU0cFBV8kMv+iPEj0fueu6Rh9UGUzJDb+FA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=Lrt/fM48; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=lxb01r0k; dkim-atps=neutral; spf=pass (client-ip=103.168.172.142; helo=flow-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=Lrt/fM48;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=lxb01r0k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.142; helo=flow-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 561 seconds by postgrey-1.37 at boromir; Sat, 12 Sep 2026 18:16:33 AEST
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhklP59KSz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 18:16:33 +1000 (AEST)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id 0C6721380082;
	Sat, 12 Sep 2026 04:07:02 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sat, 12 Sep 2026 04:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789200422;
	 x=1789207622; bh=f3qwWyqi3bNUqorYQGcKxNjQwJcXGV0fC7D1AqFX08M=; b=
	Lrt/fM48uvxyR5iY147Dg1TLUxzhC6V9WeE9G4Nf2xS4+pkFwVgvQlPsZgX1ObsY
	hxNwAbimSrgLpG19RfvyiSqHjWyUKu/DrU6GHqrd1Ny3X/qxb2V7PLMrwMTGxJ5J
	hxhHSDw6DzkOfUQoTLd/xCPLr0ZkyiUbbdsArhbOLbeDBOETI9bYaulAFEdBhhYB
	8yV92Rxc4ba4CNFpTlX1DQ8hmsjEd2RUFxoF2+d6ai2JCK/3mEz0yCBKDLCy0kT7
	MblYeZafK+CpuQ2/h4Xvl/E08vAxOSUkiRJzXlUswU1dssfWm8A/JrDq84M4L8cU
	2hzmROIQ1QhHapZ/aclkGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789200422; x=
	1789207622; bh=f3qwWyqi3bNUqorYQGcKxNjQwJcXGV0fC7D1AqFX08M=; b=l
	xb01r0kwHfIHCGkG23JDkVT0OR6WYaawzrtFN7BXJBAVCJeq1Uh+/e7Gg8JYmtXF
	1LCmYWrVh+aXxK5P/aKoegaKad7yStYYhFa5ivwWliqhk6EY7BLZYTcIbQ4z6YAP
	OgbD33qflDx3/fBJ5dTlkLlHBZs9X0dE/P17DVw8jlpi5mFAJYYwLaUHyVeXRB3f
	CdBLMEWG4iHPdsLf2rroVuXg2vYAKidKUSvaUd82yVymPftKPUW6ojD1IN5haV6W
	RHa8fD3MVF0wRBMz5082rQG2m7E0jTrMHkEZvxZ3XxwrNqgA6EB6PgmjTdxzlq1x
	xsRPvrz6z+1EwtsZYC6DQ==
X-ME-Sender: <xms:GwilaiM9DoEGXPS-5POglj3Fs3UX9dKSgEcrGATNpDMJPGNSuR9zRA>
    <xme:GwilarxN0E-D3ujq0LTikzEohK71z4qj5L4kuPdseBnDwMgcrWtIyG72C2_JeVM5A
    FBrlFgdq3_j6q1S6Y1dTCO0Qo2bNHyHI3LXOfX-aFV8Bj-yyr6y6g>
X-ME-Proxy-Cause: dmFkZTEnMfHZeL1bdmK0cMv43Ykw4Ux5EmKrIdL01M3dqOuqJ2lE5s/Zf8fR7tEIJo0kPv
    zWtV+y0PrEAHOjaSKsxSLCyqEt7BsSvRONex+NaaPtPqORZ63NRy+Js06kSKO6B4kHMOw6
    X66YzjTgLq7T2dVQ/Wy+z0mQ4yQi6eeqwM+Ha0y0Pecb27IXKwT7AyfrUjOgPW/ax0pbxm
    431ZmN3/a8b+CFj03gZG/0GqmMDdPzw9zIGPXhsnXYuTl1E61xnGM14GRGmIYVt0/4ruFj
    bJzQHDqH1XLMGaU36Dad0/cx0LiIfSRIILMzpeOL+9wHlFYdYe8pNXSPkjqQSck9kl74XP
    aCzd84oPX17C7TH8ROIK4AlY8as07h/xF1/mi69Tj3lPRbQOBi9KqgToWBN9+IbxAFo0Bl
    O91jo3tZhjZHGmsdRT5I8CZPH49W4wppnyIMbWnJORO8mrIahMZ6pRtbPa974ykxYGKMc0
    xa2sGvHlvvuBThI5t8oyZDRmkUDZCxhbR0R3u3jVuF2XW3z+rnrLNhMoF4j2qzzk8B1zZz
    lJPY/WsxQGZwEdKj8dXZcU/q8nWTM5JBnCaWjr2cJoG1Wha/0dH3WyaH3eGu7Az0Ec7QPm
    5/9iLK7Gy3Htywzk5qwWNhjRQMpdbPa/lgeqDfBz1ZWNbrYIda+j3gvZ7Xqg
X-ME-Proxy: <xmx:IAilakYs_TJapqNKc7Bl7_t1LCTdqWksnA1ncYoY1SxGbgOkM5mR3g>
    <xmx:IAilamUNZ9SPghoBE-fNuCRW3yvOkVXSEolaLNroFm67Oxs_i5V_HA>
    <xmx:IAilakGOzLYoRVy5sbiYSRPFTKbqOoOKrzwo-FEclMQe4BRLcwxJkQ>
    <xmx:IAilajCG69PBf_6_2kGV2BfXz2ckOvpTnN8WdA2x9XjMv6PH7RVuBQ>
    <xmx:JgilasFp5Sb1z50QC1Sew28jzpy_7_aNbHZVZSIJDSN67XqZa69ERdel>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 549A532A007E; Sat, 12 Sep 2026 04:06:51 -0400 (EDT)
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
Date: Sat, 12 Sep 2026 10:05:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
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
Message-Id: <937fb2c0-e910-4ab6-8599-ff5ea67fd9c3@app.fastmail.com>
In-Reply-To: 
 <CAPVz0n0pBxP2J=5DN+k+ut0HRnTmsU64orXwxa19G0+WAxN-zg@mail.gmail.com>
References: 
 <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
 <CAPVz0n0pBxP2J=5DN+k+ut0HRnTmsU64orXwxa19G0+WAxN-zg@mail.gmail.com>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026, at 08:42, Svyatoslav Ryhel wrote:
> =D1=87=D1=82, 10 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 21:15=
 Arnd Bergmann <arnd@arndb.de> =D0=BF=D0=B8=D1=88=D0=B5:

>> drivers/leds/leds-lm3530.c
>> drivers/leds/leds-lm3532.c
>
> LM3532 has full OF support and is functional, it just does not have
> device tree users yet. I have a device using it - Motorola Atrix 4G
> (Tegra 2 based).
>
> Here is commit removing LM3532
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=
=3D46a6457870825d8b782d350fdc7e27c540734d41
> Here are my patches bringing up Motorola Atrix 4G support
> https://lore.kernel.org/lkml/20260721100245.444623-3-clamor95@gmail.co=
m/

Ah, perfect: this is actually one of two drivers that I independently
noticed as a false positive while writing the commit logs, and I
dropped the changes in the update I pushed the branch yesterday.

In fact, I saw that there are three other upstream dts files using
this driver. In general, I assumed that anything with a DT binding
has users, with the exception of the devices inside of a removed
SoC and a few PMIC chips that were tightly linked to a removed SoC
from the same manufacturer.

Thanks a lot for checking the list!

      Arnd

