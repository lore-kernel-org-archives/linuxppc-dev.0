Return-Path: <linuxppc-dev+bounces-25095-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DE1C55160
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 11:54:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9nfq5MXxz2yYd;
	Thu, 30 Jul 2026 21:54:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785412451;
	cv=none; b=igiI8XVMBK6WTvSmXMCwmqrLOmjPslnxeQbwsIBq69ZQEDyCDquJCu6Tl23FShU8r4iXenIeXQ4ipxamyGWIhDkNf7Pu/IO9nQ4RlcYpYehwG4Y7UTTrH0p27l9GXcGqqLf7fPhUA6CO493FjcdSmUwh/AEFMiJVx/fHfI01Q23qb3VF3aHoZDgZrhfKy7Jzo8SHTAiv9hJv2/ivkILvynK/TLhaMubNSWAjy+vaqIh9Byi//7iyDW3grfuZTDoAyPDiXD5YMRGgzbd358/4LqnP8YWMvcnjqgB989bSyPj7DFw4Rz2Nt6ymulv55nt8sHKCQxwicRkCJ5XOOFPMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785412451; c=relaxed/relaxed;
	bh=PWIEEQjaHeHJ5fxTgr0YOB4InTHJrKcidKplWWfbj8A=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvSqly+GKg/ZE0R3Ecb11UTpzQjLDzHXDFCS1Y8L8o+bbQ+NfVl5o4EE97bn636RADdDz6Sfr6BaL6Ii0nXhd9RFWsW6DE2vR6a5cLZvnf60M3lXRPn6FGH5iS+r2bDmi2WL/suHu3P0LVOHekS4junybGIRdgEd2hpCRx6x6Hx3bLYP5kDfEaobkXUnoZsnxIx/agikCSd1YsUUJFqX5wqfTeI4mWTlY/3cWhBuweo//zuzAvJwxVxxT84zWAQNS2qqvEOOoHR+JR8IquZpScOl9rEkNPMIb7Kz5gbqxjS8052q4nK0dg+AYFHNLNyQju3AGkWxU0qgwSh/N5g40w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbouM69Y; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbouM69Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9nfp4r9Cz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 21:54:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C0056600C8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 11:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7755E1F00ACF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 11:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785412447;
	bh=PWIEEQjaHeHJ5fxTgr0YOB4InTHJrKcidKplWWfbj8A=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=cbouM69YhwFY7cVqNT0XzrbRgTNiiIO9oCsC3AYShqoH7eLFVreZvRWImtxQ1uQGi
	 UJqrHNEGxO6LRIRVVnWkk+fY2Ej7dOdlMFQuZunHjhkMP0ba5p3Jyr4Ub8chJtYoQi
	 SbPZrgCfl1jDJmPFMinCryZXIWpr5pM3aIrpgfyDkMxtVCPn6mJEJhxrfZOyyAhMxt
	 k0pC3ikW1cuW0DinPbGsdykwhYkPxYh5w6YG2OPdbxXMe2e93h8MDbGfftToYppNr/
	 n5H0hBBnqk9oRdYxx/QqtVRfZQdI04Plu27MkrHZxsHe5DqGrRLvYJ8aNJaXR68m+B
	 EadthDyHKAwYw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeba09900bso1259981e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 04:54:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrRkbox4vObPYrgy1tkpg1jzUp7GquVvutH1zS35/l7OnfFEnyG8Ro9dlwXcs6Y5Ujrr2QGNGw0rB11UM8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwfjK4gBdr432ghhJNIqqXKTzjLAPaAZjgz+R+CGWpkiZ6mPPvQ
	CZtseCwhO/61zmYV2HqMVnV7bZ/rhCqCThq+NmeZXCBvL5wRA2RBb925Zp4kF5LgFvZcJ7eC0qv
	fPOITrxz2+iVM83jlN2GJ4nj1MUeY6aIyxa5a0hhuBA==
X-Received: by 2002:a05:6512:6690:20b0:5b0:197b:9811 with SMTP id
 2adb3069b0e04-5b2db373c5cmr282662e87.53.1785412446192; Thu, 30 Jul 2026
 04:54:06 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 04:54:05 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 04:54:05 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <30b3f278a10b46252783458c81dc438df176f86c.1785405882.git.chleroy@kernel.org>
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
References: <30b3f278a10b46252783458c81dc438df176f86c.1785405882.git.chleroy@kernel.org>
Date: Thu, 30 Jul 2026 04:54:05 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mfmpq=Lb8yUqUAdvP29VzXO+FzF1m995Mwsh+dnnW6f6A@mail.gmail.com>
X-Gm-Features: AUfX_mzScc3M9rGBw46jkrwGJk1nYV1wT2PFySG5uBLlIaqWgjEfkCdTsW4Lf0c
Message-ID: <CAMRc=Mfmpq=Lb8yUqUAdvP29VzXO+FzF1m995Mwsh+dnnW6f6A@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: implement get_direction()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	RAGUENES Jean Noel <jean-noel.raguenes2@cs-soprasteria.com>, Qiang Zhao <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jul 2026 12:09:40 +0200, "Christophe Leroy (CS GROUP)"
<chleroy@kernel.org> said:
> The lack of get_direction() callback in this driver causes GPIOLIB to
> emit a warning. Implement it.
>
> Fixes: e623c4303ed1 ("gpiolib: sanitize the return value of gpio_chip::get_direction()")
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

