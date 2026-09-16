Return-Path: <linuxppc-dev+bounces-27502-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39AAC982C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:54:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlQ2q19qQz2yGT;
	Thu, 17 Sep 2026 02:54:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789577651;
	cv=none; b=DhZHvj50YoKXHxIpZl2ShtO2NdfeA7A6uRzpAxPTSUpw01H0wxmDATNfqUMcM5XQ0PprF5OoHIu2DR/9JqQAQNgloY9k8LAJ9COrZ62rZ6NRYyjJZbhwKX6+0NJYkqGYBC1Ual9vfmZ0Hxd465g6oDiqdKiBCBuJKOQip1E3OmbX/5XaWAHZTr+geaP8bbow+VmLClh4fquSFZeJJE1rJ6/raA35aZqYGKPqZ2Yf3QP+Vy6acH7ex79JCuz6hG0TGjyjGho1C9ibl6GdaLDNDQ2qOqTnbEE6zgyJBC8sTATxx/op8dxtXdK294uefNNB4gR9Y+VLYZYrC78nuQl4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789577651; c=relaxed/relaxed;
	bh=+Cs3VDVugIjX3MNVr9btCbWNjreSEbxnWC6UpAzcikY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKPTZHPwqWSDiTXy1m4lr+sNxAQwTaPlQ7A+8rbg6+pFFiNUuUzpWO24x8Uq4/oaFwxPahYw4pCarr0VFvzquVK88WojXrj8H4DT7Q1XkfNo7ocZ9CNYhj6gHmiAvFsJHVhEKpjEsDWWyd5twfO2Q4jm/+8zevDNql5tmVeswdMmsp8XA/D4wVG9buwQlP/FfpghOrPDboHbK8VW8+rtPibgquB6G0v9iwFUqAQAtCN7HWfAIYlhouRDDrwxwwFZCBdnEj9w3NTi8dMZpbr1c27q6u4uXouKfEbLyhCDY/6qf8R8gUDHikiFDC0LlvnyFzb2lxPZ9655jQyH5fdjTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjbO+wUK; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjbO+wUK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlQ2p0zr1z2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 02:54:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8823943C93
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4461F00903
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577648;
	bh=+Cs3VDVugIjX3MNVr9btCbWNjreSEbxnWC6UpAzcikY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GjbO+wUK8PFGJDHTykoLXmuHDqj5Q7HLnMpLEGqYG36NblxMPUNwQLqNuP7FzEtT4
	 JtNiFzZ/1GJdhAx3cf2d/F6lgfSLCGCB6qOb6ixqEY8owR8DlGvYXsSTeAdY2dHNf4
	 um0RvShJEozxLwpw/Um8fJ9MSJePrMWS+n9P+W2MJEQKKTtNV/ybCuERrp5NU/6B95
	 lZj0/o+SBlzX8Ebb7rn+q5ig4whFnumLJBwY77N7myjOW9XvPxgXpgFzYNCbq1Hw4n
	 xV3s0FQA2HKc/MFPuqF6apfb/pYnlhD4tXsFKK4J8z0/eokzzdgWXGC3jEzMW515N9
	 BQQxBTOl+bhjQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1744fso1788744e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 09:54:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx847mNUFbUjV4S4TNsuFqqCNWsqSV1FHxS1ul8xcGbCXXTeYLVYgmycADULlKKZzoQ5foVRwYv2R9cSNQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lqn1MiSrNBYvYGq25jRZbEEnJorfRxy9T6hjWCM2KFmqv8SH5I
	dWC2RVhSiIF338McmzD5DxiF0YXfSCGJIhvhB2F05jhnj0hATWF2iZiYU+xozXLMt+mkVhp6zno
	pYAjK7QFEOgTzLJ57HmjKRePpN8CAcC0=
X-Received: by 2002:a05:6512:b83:b0:5b6:183c:5ca3 with SMTP id
 2adb3069b0e04-5b8b665fbb5mr1072085e87.65.1789577646856; Wed, 16 Sep 2026
 09:54:06 -0700 (PDT)
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
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-5-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-5-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:53:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLk6wQ=GOzRODdd+D2GQg1=GoP5UN7ZJpPPBQJxZcMQy+w@mail.gmail.com>
X-Gm-Features: AcwNN1VTSOwI-aMkaQ5X6FNcYlrB3vHQ8mD-kiafJFD8muXAXYKzzuAMRSbPmhw
Message-ID: <CAD++jLk6wQ=GOzRODdd+D2GQg1=GoP5UN7ZJpPPBQJxZcMQy+w@mail.gmail.com>
Subject: Re: [PATCH 04/14] mfd: remove unused wm8400 driver
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:22=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver requires a platform_data definition, which does not exist
> in the kernel.
>
> According to Mark Brown, the hardware supported by this driver was never
> shipped in production.
>
> Since this is clearly unused, remove it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

