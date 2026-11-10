Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319D606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=asQC+qHD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pjDZKFBW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPBfg11VRz2xLF;
	Wed, 11 Nov 2026 03:18:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794327531;
	cv=none; b=hrBDetZLkLLcWAZTc3ZKXdOhkCgiawpk7zGDTvaBDvAwVs5d7HydZO3hTmBxNwx7c/YrOGK/LLBIDK/I1qTUHvzpr2OX1Knr5uiZdK5xS2kNSlIrzWa9a8cBwlon8OogwpZ8Ju14/VuYq8BVOviEBYgnrR+L8/qgPzCpSelcxnPH+CZ4hOBYtWwJEyQoOi6qnUavFTKoPxlweRnNzPG2gvv3aQXCZhHZIjvqa97b364D2ON8SJen0uw89ELip0P6YrSRAz4eVK7Dc+R1g68+f6/Ns2JscUfF/mhxyxaXx0m5yoZRJuUlNj3JmMCjgO7KFdvBPF9HJJwUAZAzYLSwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794327531; c=relaxed/relaxed;
	bh=4stWdQp7BpJLS0676322fsmeG4ymFjAT9IbMRkPmpp0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YQMHk7a7t2jMXXZyi0uyJRkyPzhGSLT88o+naPhFv84i0uLsbrNKOOVlA8JyEshl2+BvSvLHFj5C/f7Aoq15gXGMwbG/mNqacA282lD0htP7O0yzLvIwXlnI3mp8waODDoWF6KJn299ut4op0ucHW1keuEOkzDldohZuOy9KWzb3I9FsKITRWuUwGfwNzaQgp7fMY90slBI+3AnEFoxKOe3ok87zDrf8pM7VA4m4THETY5x5q4FTy58cHcx0dyLIsNMlIgplh5UamqszjxnIxnqUbh90w+Fuyb+b2he/771dc7Jbg32zfNDWYn447LOdz5T+HRcqAbTEoExKeSxk1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=asQC+qHD; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pjDZKFBW; dkim-atps=neutral; spf=pass (client-ip=103.168.172.142; helo=flow-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=asQC+qHD;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pjDZKFBW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.142; helo=flow-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 332 seconds by postgrey-1.37 at boromir; Wed, 11 Nov 2026 03:18:47 AEDT
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPBfb2hpwz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 03:18:47 +1100 (AEDT)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id 65D7C13813DE
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 11:13:10 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 10 Nov 2026 11:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794327177;
	 x=1794334377; bh=4stWdQp7BpJLS0676322fsmeG4ymFjAT9IbMRkPmpp0=; b=
	asQC+qHDAv/I83EYngLJ0bkBe+uuEnPcLg0jrc2OX9kVtaPYAd/md3quox9jqmy4
	S/jELTpXjA2k1IxJWtdK3HZW4IriVAHis0xufJR256BBPAzbfZ5QsGw2eqYq1k/I
	S4qzaUtb3Ob4GAV2mxThnKp0r/zG0TfcXAK+eUmyQOHhHqtyGONG7gkgzRBQG2d0
	/gzJT11LHsGNvLKSZnn9JL3iytYjrT3V7KZt2FZsHfjjQeZHywjaesrjJhD0e7vN
	Y6/iN3Jg7w8xS8OVdYMBSUZOfxDnVhVfPJGqKe/oSxsAZXPn7y2e4GOOItdMLZ2R
	LLVckhHoSzC+MGE1iJu5eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794327177; x=
	1794334377; bh=4stWdQp7BpJLS0676322fsmeG4ymFjAT9IbMRkPmpp0=; b=p
	jDZKFBWlX484yfO06iZThedU7MnSaqyMkXKHKaXomC5/xVavgZU65SsCjokZJWML
	GjeTj8Lq4+LWeI1CWzzxuQj2m4isbVa0ssa9g7eZhXilCypVINe5kxTBiobUF6uZ
	Gtle0jaTmJtlAyGlrtNmbTTDPt9uAjbADo1dgbyzsDA47ykOoKjYt1o87LKBSqHb
	mP2YIbspjWDiF2EJOgZRHTKT7VhzsY0TtBEN2nWcPAnRSw5Q7HRlPmorpTONvfpP
	auvP37j94bGeH1y2GQ4LwX12DjFEZi+3xGQave3kINRA2PBRPI5FXxcFzbhhhvXR
	Tsc8Y3Jb1FgwsS6Y0dcjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794327177; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg==;
	s=fm2:rsa-sha256:jA9vx8+0OUi8VU6uP+j7n+QzW7pddHrfpkKIrkpC7qfZU30
	85vkWmsWZhtdi4KV7z3hAXv4Y17dln5yDjwL/KsehEbCxk5Re7H7y3X563WFPtri
	4SM6+RKhwIeZSHdka45rbGDFkc5Z8OkJedu5muiVBk7XIv5qu8nkvqWtKRLs/B6y
	MDHN1x7S9dW0PC0xUSP6dEoUtI7oxBFxmm/TTmHAgfB5z9p6mSMEpLq0eUHjWVzN
	xKpyyrn7BqG3TUCFMm6xsLeq31wekDQzOWkOHdeEyscFgewsmZPbyl6S7wDD3U6s
	fR5GWt0220Om8ms8dCWbnefDIwFU1X2gkNIr1GA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NY+qH6VFe1gb9eaYka4u3Pju9dQg6z2rB5jHAxzea+M=:YUoKa4y1cAE3r8AhMFawDzVW7orX9AEZ4cmB97mmTGA=;
X-ME-Sender: <xms:gELzat-KhdG49YOXD28knxP-wmxhvouurLuqg65ijoK_1PztTiM67w>
    <xme:gELzashOw3MORHNRaj5VZYoHPjgRatChT2__Hps4-a7QS4ExIju8qL8_9B3SiDtB2
    sGKQug7JFF_lfIFqrxv09JzfzrzZWKrRlvdLjWPWqavJafwb6XI9q0tBA>
X-ME-Proxy-Cause: dmFkZTEwJqmeu88i0D1P4NSr1o0RdeyL0ncQrpwlZpsRiyH4mGhKK76jqiY9/AURvmAyKQ
    Xh2LjT8fovpOgpIQnvH5QYWZs5UCg8lDhPsbwXo4GfEZeWp/aOvfLOYPWjqnmAFI1BwG/q
    XyZG43p0HoLIgnysLFo6MzsLlgysOWgB08DJdha5yxDuEjeXR7MU6VvvNb4tgDJLpz9WaL
    DOmlUn0Mje4CQssJm+pxYVCWPCE7uxZNBjliBSIc14Pa1+Q+euFKNdLxxVitjY9vJ+1g1T
    +rig9iVkFuoti3t+qEcHMM2vh4+G+ag1IzrG3We9+FcQnC6cOfB1bItA6vAPi6A+u1KULf
    wxoJ36bIqa+kM9OWApvgKo4MId3H8RRe0FCkMwp8Cj2i2hPzQqFijO+zALFklT7XBp4yQ4
    D0Bsmvzif3sMMCJY2OSk1bwCPIIRPEFuJI4Mi/vpw7sfUa+jfrhN159tiieQQE7aztSV43
    DlSawBFw+hJYm5oAPkD2NlBoL/gRh3vgmwf+Y/GbihlHM/o3EcsWCertLTOcD6iStWXR7G
    LAS2aVSdVtxoGSiZj2/kYUSfLhEBFCn05KpxcrFYCW/FmzT2YT72YPVx3p0wR8sMiJ3lAW
    x+8+3z8XttowLJjfinG9ew4R0xJsilSkEkmhmN5AqofFDl0uTCDo7P0ixMQQ
X-ME-Proxy: <xmx:hkLzak2BPEyGi10FxxkrY3byRVHSjq_0wLclV2jUuSmkyRE3xcj4fw>
    <xmx:hkLzakkySXPgYGwh_r1Ql-VHDAdYXcQ3p0tjVOV29OCOWQo8MbFMmw>
    <xmx:hkLzavloJp1yUj6WriMMnPneQ8pVgU9Ew-sH84r-kdZ-OdXPheHDYw>
    <xmx:hkLzarPnZB-B1EOixQtLefzjQeDp3wnHNrTbJ3SPpTKyjOvpO-EsFA>
    <xmx:iULzajThipr-UxTyuQQEJ7jWDCsE73KlfzXTf41eZRpd8Rpi4a2MNCT2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id AC32432A0097; Tue, 10 Nov 2026 11:12:48 -0500 (EST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AK-jVwBtQCQR
Date: Tue, 10 Nov 2026 17:12:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>
Cc: "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Daniel Thompson" <danielt@kernel.org>,
 "Helge Deller" <deller@gmx.de>, devicetree@vger.kernel.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, "Jingoo Han" <jingoohan1@gmail.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Linus Walleij" <linusw@kernel.org>,
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
Message-Id: <991009b6-e62b-46bd-9a0b-43c3b7a6d10a@app.fastmail.com>
In-Reply-To: <avM5EnC9yujUZcCO@nsa>
References: 
 <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
 <20260912232047.19c4cb10@jic23-hlaptop> <avM5EnC9yujUZcCO@nsa>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026, at 16:39, Nuno S=C3=A1 wrote:
> On Sat, Sep 12, 2026 at 11:20:47PM +0100, Jonathan Cameron wrote:
>> On Thu, 10 Sep 2026 20:14:15 +0200 "Arnd Bergmann" <arnd@arndb.de> wr=
ote:

>> > drivers/iio/adc/ad7793.c
>> Maybe. Analog devices ack needed.
>>=20
>> Production part but this one indeed fails to probe.  Analog
>> folk, do you want to fix this one up?
>
> Given it's production we should fix. Looking at platdata seems to nice=
ly
> fir in DT. Issue is that I don't have HW with me to test. So I'll maybe
> just remove platdata and assume some defaults.

Sounds good. I already dropped my removal patch for this one.

>> > drivers/iio/frequency/ad9523.c
>> Maybe. Analog Devices ack needed.
>>=20
>
> Hmm we definitely use this one and we have OF support out of tree with
> likely some DT abuse of what can be in DT or not. Not sure if I have
> some HW around but we'll need to fix it.
>
> In general for ADI parts, I think we can drop the ones that are not
> recommended for new designs. All the others I tempted to say we should
> keep. Naturally we need to fix all the drivers that do not compile
> without platdata. And for the ones with defaults we can also just remo=
ve
> platdata and use the plain defaults.

Ok, I'll leave it alone as well now.

I currently still have patches to remove adp8860/8870 (backlight), ad7877
(touchscreen), ad714x (touch) and adxl34x (input, not the iio one), which
are currently unusable with DT but are all listed as in production.

I assume you want to fix all of these and keep them in the kernel,
but possibly still remove the adxl34x and only keep the IIO driver for
that part?

I also have patches to remove platform_data probing from ad5761, adf4350,
ad5791, ad5421 and ad5504, these all have DT support.

See=20
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/=
?h=3Dboard-remove-7.4
for the updated series. I hope to slowly get through that. Let
me know if you want me to skip any more of those patches.

Thanks,

    Arnd

