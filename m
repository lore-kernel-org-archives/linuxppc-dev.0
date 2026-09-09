Return-Path: <linuxppc-dev+bounces-26989-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126B7C79FBD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 17:27:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg7612y3Tz2ywh;
	Thu, 10 Sep 2026 03:27:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788974825;
	cv=none; b=HOqQTsGV/UyhhR/wXVYbHylmsiGf2AYDEFkz5nyjGa/n65mOoXNHHbQmor1f9c20eYtzezNTApioZ2Sqg2ixSnTR2womM/eLH60TD3dNSt5mkTgFmAjXA4b2TdptVWQa1Z0v257MIkwVQk/E1/uWDaahGxszTFmDuRfvTk8Nex46EbJscz80TesRCopErEN7vpfWn85tEuErSLzUh041pChutYxXhINiXeooYd9Gs4GPhNw4r99dotbjv83ptd4UDBzMgjnLKdchNcAiPPm+mRb9tqjJQlT4y4LVfTxGGZ3JsXH2Sg/BnHKrx8WRTHNJ99nTfcoJ4JW4EJ8Li5QCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788974825; c=relaxed/relaxed;
	bh=BxkJmMQiuFGLIVhYvP7iekSRoJyyqxrT2LFSLJP0a4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL/JBNYJOLF0FH4UUNGJIk0wK1iRVo9yto1Hwzno5HCe4K84J/Y2NNWYWvEkLNZgPQEbuYDQrb6QZt1O2/87P5Gg/i7CwYhQUtJaxLu2izFTIf22I36yDVHYxox9gdIya0YCNeMnVnRUVtNTFq/M5nTHKBcyuFfC+iyP3RLvFFjXot9Bq1pECKS0DuK3+G0aQmA7yuIZ+9yDXSXUMzalAFLvZruPkS9UzIT39i4LJyuZiLn1vN5TSwcokKrPgtySyiqPBKBWI7qxxsxAXH4Jy/7uAAlip3f8QeyQEEJ8zZeWkryUvbk/1rjBQncmvhEzDTOziiKYsIaz3SiwrtTKEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FhAGXROn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FhAGXROn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg7600lGyz2yvv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 03:27:03 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso421035a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788974821; x=1789579621; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BxkJmMQiuFGLIVhYvP7iekSRoJyyqxrT2LFSLJP0a4Q=;
        b=FhAGXROnqaENAPU9IUW16iS4rgHVOz5urPxtPL7JsHVVhjIocl1eKw8YtSlyrsx5WZ
         XvltFh2LpWKNL30ROsjuU4uqz/3gY/NVsZcshHtbFVcBEhAeV0UBKDQ1u9YgK8I80NPz
         4iH3loTemATjT8W5bQVnjF/vRzz0FKJoDJdQ3WKfeHb2bj3pD/ZhnGQivpWPtlT3jMwW
         hzVSf/gVeFgUAtbWyRxPgj0KrSC7/vhCDP5+xnDIGrlZ/hL72jhRJHAjnr+v8y4+cQsa
         dogaUPYH7IMU/CcQUcfhozxifuvgWRUy5WF8JXIEBWZV1++wlI5Iv9bGojJWIQpWF7ke
         4k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974821; x=1789579621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BxkJmMQiuFGLIVhYvP7iekSRoJyyqxrT2LFSLJP0a4Q=;
        b=QYblqeGpWvu0lrA6QX1Q9odifmNSBepUwhGHOSGBlXW52vRHa8t7kXGIfJESlXnYaU
         MsVPaS8UIJjVAU5A0xJmNFouTGwR2HDlBhorCiNFWrjX/m53zLIwnqaAuCimFeBTNZ77
         wSkUqyCoLeiNYZdoBCfmOZWpV7fTVrd/PLZRjH4HttIQDsHnoGrxysR2zZclDQhuzC8b
         t0GnlMLHq5iSLjLoqZt9WY62IX2UvqpZDN5cz+dp0WnJWhw+ecbDi9HoYLXy4HugOLQ3
         GSxynExoRCL6bEsnH1DHnVNfuwEOQA6JnI6ckwlTCE5uLE2N0lhaj4FjRkq/Eawh9EXA
         zxIQ==
X-Forwarded-Encrypted: i=1; AKwUvByW76Y+icyzVClBCRlj7Tdf1Qdg0uMu+zwVkeVRcFw0MueryFvbhq6A3cQpbqerCalaTfdEh2SmN8Fhufs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kJVgs54+o/9B8veLlkONWWQoDxLJbKHncHNh90JnMhyP+zwu0n
	AYg0lL+XGH48RkqPt3Vb35JKCUnVseMfRlI8J48PMhDXqf22oUbfNH6j
X-Gm-Gg: AYBFou3WzwQwoR05bTXIdgnVJjhrkSjH7fwsgWCBfLJVdLCDgOEFF3tck5YmQVZI4h7
	785OhNxfbjc3qDzecjjKvPYvd7G0ZSVUIQP5kBtCtApBrka8UKE9WAfW7+kStaaANEUFHuU2JDu
	98XRoKLwWSvTWVG29bjclWuOuxZRENuhd5gdUbFhJfxcZEjWrLhwyxTxXq64h9u9YYamSUdBjBm
	RUOvngxGL338QmXtSjw8vXOkMmWMaz/ONdrAfydJ/truUhBbCvp2kM68zEUyhUqOX2VxuL+82AW
	CDQ2yzBbiu+/g8z7otbt6GHRZOcR0AMOUycnTeZwTvZ0TxR7za8tcNnvwE4yNipsj9OneQoJ0rA
	KPB8zremSnt26NdasAUjxCqatr1bihkilpyBAvYimGHWgZmiSQXPO7Fwax2jtyLwjumhV/OF2qY
	KKzTsqnnUybyaIJzcyw7R5Y9zxpZN8cLyU1hBW0Gn0aUaURxpi12ggFBzGR/hEVJdZJbF9bWq4p
	3LnYJc5wQvSFIh0S41T16gzu7N6r/ZKCKUeIaMPgS6O+bbKoPS3
X-Received: by 2002:a05:6a21:9d84:b0:3d3:af85:eb98 with SMTP id adf61e73a8af0-3da3a16a579mr57975715637.26.1788974820346;
        Wed, 09 Sep 2026 10:27:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2d43:5153:5c50:643e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm52422943eec.7.2026.09.09.10.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:26:59 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:26:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 00/14] mfd: unused driver purge
Message-ID: <aqGWjAuGXq_JHvxk@google.com>
References: <20260909132153.1596191-1-arnd@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-1-arnd@kernel.org>

On Wed, Sep 09, 2026 at 03:21:37PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As part of my cleanup of old platforms, I had a look at all drivers that
> may have become unused because the last platform_data or DT definition
> was removed, or because of unmet Kconfig dependencies.
> 
> These are all the mfd drivers I found. The first ten in the list
> actually turned out to have been unusable long before my series, and
> I have added explanations on how I determined this in each patch. The
> last four patches are still in use in linux-7.3 but become unused after
> my series [1] that I hope to get merged for 7.4.
> 
> Somewhat unorthodox, I took a shortcut here and remove both the mfd drivers
> and the corresponding subsystem drivers (gpio, hwmon, iio, input, led,
> media, power, regulator, rtc, video, watchdog, asoc) in a combined patch,
> to simplify the interdependencies: removing just the mfd driver would
> leave unselectable or broken drivers in other subsystems.  I also have
> additional patches for each of the other subsystems, currently a total
> of 300 patches, many of which still need better testing or proper
> changelog texts.
> 
> Please let me know if you all think this approach is ok, or if I should
> explode this further and turn these 14 patches into 70 individual ones
> by splitting them per subsystem.

Sounds good to me, especially if Lee makes an immutable branch from this
pull so we can all pull it in...

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry

