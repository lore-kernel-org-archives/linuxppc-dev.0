Return-Path: <linuxppc-dev+bounces-27037-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79C8C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 18:38:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgmdb1j2yz2yYY;
	Fri, 11 Sep 2026 04:38:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789065491;
	cv=none; b=EceFkOxrr3FrBhEkYGmc/10q1DrHA7LIJ3HwHjYq1kMbPCrtMZwZenNg9gsTMnQ/8Si+ziZvV/KFy7dYqs2nZJcBFwl6Ciy2JA99GXdo8uRzHrhK/wNT+hgy9mPz5mG29PUYWHHD5vqvqPP5J3gnVperVbEM8CMwr278tD2vtjLi3lVLtSij/gbZNQ/86KhukjHRbZtDisxVNnY51kr7WPj4H21uBjpN91QY/L57Ogj2Jhsg1ZTdltenPhOaLJFfqU/qJ48ExKCqe5pJIxe/6aI3mq1qphsS504mUBe+p2Vnuhv5qH/08N8OgxGBccA6S51/Wzry9Achht3b63LEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789065491; c=relaxed/relaxed;
	bh=9u7TJ9tgwm2KnuZFSYIca8LwnX5gbxqDtxG2LPSH6i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIqlEAVtplypaFrFX17YXqFI15bAq5zgyFCPkkAgkteGNElFKsGFurgKcFCe25YPiDyP1Gac+yANiV24uNfVYwi+qne3YRWX7+Onztu7Ald/BvjPlD4WhLN9EnVShMmX0C2M1+dYovtV39RerKfK4MmNBdG66bhkAfIolH594nAj4EuWxvIDrA0XNBa0JiO27SK5ANBFWDHUnE1hgDtTHgsyl30PZEkMClAWy3nCIQf41P3jzS4bHbdQ7mz6ALjPlTXjMH6EF6lkCouw1m5wf2XWJ+ncg5f03OaiHMXAvUbsREYFzyATi+oGMSehU4PWh5DhQSo5nZJzgX1XP5YYJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nUDTSBnm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nUDTSBnm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgmdY3xYcz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 04:38:08 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso55557a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065487; x=1789670287; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9u7TJ9tgwm2KnuZFSYIca8LwnX5gbxqDtxG2LPSH6i0=;
        b=nUDTSBnm7ue3/HVvm/pWqDaYA5GmeaQq1wJKhQAEeftCFZmmu+bq14W+bIxbM+tHLL
         4EscSElQ1NebNEzUij9ar1rbkp7w7Myp6rBN4cBfz/Bl3St5rddz7noK49g38PUEZVrs
         T8CKEG+Y528ZHOZ/ug5IGnFjZoHTMhIx8BpWx8QiogJP7L11hcMJZbkW46/cKXQT+GsY
         6coZ/tKwAzz88b/hk9dyByBY1kddgkL1S6BtciNZVdmbbfsTqS/wfychPooCylyi98jR
         s/3jJ0hoLZLZM++UJY3UnRTe3Kmq/mmWbIlvtbpgsuAKc8NTY3Hq0FjYShO7E7F8gJOx
         33aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065487; x=1789670287;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9u7TJ9tgwm2KnuZFSYIca8LwnX5gbxqDtxG2LPSH6i0=;
        b=cyKME23LjxeyL6VtBT0JDvmUwGWH/+cFZCPprE4qNOy+pTfm73+MMzT+hdO8JsiQpk
         EOqiCFk59S5p8Qtq6Z0E3rumYzBwO/MN8ukkNdSuTKamJDVFdX+zefMI1CBZmKcjWF5a
         YCjxSBhZQ1qBNKrXDJD1vtzVawjvFyYCOnVfJr2hzf6zxGrh1kyiGmmbH1hBSNMuAvwB
         p/Gq+8wgqAtbofYjGsBWH7L4w9rogiv3zqO8JBSqcPcVDwnFJlAGikCQrfp9mG78AFST
         gdxUrHYzC/OBMz1fcKPREl64GyRPmlozd1dEvIJDM49EuIyrelUv5tgfULCEybFgM3kQ
         MCAw==
X-Forwarded-Encrypted: i=1; AKwUvBydKFdRrUpZooyPpJRmfbDmEYjVcvZa0UkusHSh7WJn/8lOc7PYrCkdMn5m1ZuVTW38NmA2IymSb13CvyM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n1ommlOa/Z7PLw6KBvct2JSGXLgKmQgzi4JBjARWqUHp2chd6D
	nviJzUPpnLvhk2XoOeIiyVj43y/Bn8y9b2xPu5EP1jYWp4etk9bjDfN5
X-Gm-Gg: AYBFou3Gch/W/+AUf385aHQSkwf8wu2f2bo+Y1StNH+n0j9O/S/fj+HOfhnTyUZj9ND
	DGzH6cURrWM/r06uQVvErN1aikukvMMpS3+qCMEbliMiJ4+dhf/DJgs2SSfuKKyBBWO8EDnyMu+
	3BmsTUVPGFHQpcoqc8s5OMl13oqvxpYQN8hgA4wTcoNQ0cFAbN6XFd3+vjzzvPM076t+sGGm0Z7
	mFYupjmDTHSQ6azvEt4m9rplzVnrAu7zvW/ywmnFmenNfWW6qd6Urzv58bUkmxDdcetrNU0uP+E
	X743gcfOphPSPdM8+OFLxhwMwdCmxvAKfMzy+FTbTuNGzPN+hU5ahryT0s4YwRnWOOsT+gaUdyt
	LP/LDBiv8TZ9Vk6LaGO2dlw/6CTPocc16OnkUxa4DI7f+AFFW9unWUlmShe300K7qWoThLseAh+
	HKcQv9jobkLdWPaot1OtKyRmatLFV6nkpvJP/a89VjwDNnOOeevHzvuj1RPnRrWkBOHlCkO3Xlc
	yT2QQsLF26vd/XlV/mp2PAkHfqqz4D3PDZtryM1P4WQxIr7
X-Received: by 2002:a17:90b:35d2:b0:39d:8d38:8b04 with SMTP id 98e67ed59e1d1-39d9bbea1d3mr52593a91.1.1789065486698;
        Thu, 10 Sep 2026 11:38:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95752809sm851731a91.13.2026.09.10.11.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 11:38:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7a92a79e-e22a-4e34-9f11-4086b88f62cc@roeck-us.net>
Date: Thu, 10 Sep 2026 11:38:03 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
To: Arnd Bergmann <arnd@arndb.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Mark Brown <broonie@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, Jonathan Cameron <jic23@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev,
 Mauro Carvalho Chehab <mchehab@kernel.org>, mfd@lists.linux.dev,
 Michael Hennerich <michael.hennerich@analog.com>,
 patches@opensource.cirrus.com, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Support Opensource <support.opensource@diasemi.com>
References: <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/26 11:14, Arnd Bergmann wrote:
> On Thu, Sep 10, 2026, at 18:40, Svyatoslav Ryhel wrote:
>> __
>> Hello Arnd! May you please spare AAT2870 from being removed? I have a
>> device which uses aat2870 (LG Optimus 2X P990 Tegra 2, not upstreamed
>> yet, but in process as well) and atm I am working on converting this
>> driver to use OF. Thank you!
> 
> Sure, I have removed this patch from my series now.
> 
>> P. S. If you are planning to remove more old drivers, please CC me in
>> since I may be interested in some additional driver upgrades for
>> devices I own.
> 
> Please have a look at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3
> 
> I tried to be careful about figuring out exactly which drivers are
> unused, but I'm sure there are still a few false positive and false
> negative ones in there. I've added the current list of driver files below,
> let me know if you see something that shouldn't be there.
> 
>       Arnd
> 
...
> drivers/hwmon/ds620.c
> drivers/hwmon/f75375s.c
> drivers/hwmon/max1111.c
> drivers/hwmon/max197.c

I missed the rationale for removing those, but then I don't really
mind either. I guess we'll hear if someone still uses any of those
drivers/chips.

Guenter


