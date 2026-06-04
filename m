Return-Path: <linuxppc-dev+bounces-22023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21FFCD6E57
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:53:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWKdw3l0jz2y1Y;
	Thu, 04 Jun 2026 19:53:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780566836;
	cv=none; b=ZMP9H58wWjsUHfSR5FYjs6o6Oghw+1fgfH9eZrNI7bkf5vKbHz9o92wXxG+kHoiGxAwds/vk8EXMxj1R4CLzS/59lxuuqJ2AWyYkPzSXqP0htYYMmeY9jrN5Sj+G38bDUbBKIuz2sqewjYTnWTR9u6SNGUlf5kLfospXVWws8pOvmX6VptMmKXm4sq2rAVCee5cLVAJqNzrRt4rhzU2bB70sxGvwhZenpOPDrAukGVgUJTMvH3rus9GU6Z52rDt9jHjUAjr5/z92U9uVwcI84XVtAu/k4jzkThb+OBBeWBNuxKNeEmzIaqsc2nYJ1745fkkiSJRQ8LuWJVhYLijxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780566836; c=relaxed/relaxed;
	bh=2uCjD0xm1ymgL+GWw5DNnhm3VBIHO+FoDldCalZypWs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NksV8uaDHQDHhQW6b031vTYrrd3P8hLxBb3hw2ClBMZsLZQlYILWBS5kJxXyvvvwpkN2EC9Md7yoAFmUJfQ5Jz5PNC6uUNk2KtISyrYF/XJ5NJ+OqkT2y1jhN7LWlTZeRsMeI8sDg+9PAraIhdgbsfyV4qxBtwRXg284H5S9hLcXQzjqny4uW4RNvtO3I14Z1FBHFvmZngy0W2mNiGmnz8Tf61YlTPA4+cAoBWa85g3Qhzff2jBreHE0EuPCV8Ovs1iHFweABhEcxzGxa8CK/DIadkp47huZYHelWFiPEFze71WarNmk9gxg0TQZ+rOL3gGR5R7EbW7zuKSG75T6JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mArXRRw4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mArXRRw4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWKdv0TNzz2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 19:53:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E68DC60210
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2026 09:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06EA1F00893
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2026 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780566831;
	bh=2uCjD0xm1ymgL+GWw5DNnhm3VBIHO+FoDldCalZypWs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=mArXRRw4CTaqdAd/r8413dV8lfbzLiplqXqlK7Y3SkrSEP7EUjbLGEJqCo1E8zuqp
	 C4zlR8SpWv/YQPx+8/O0B7EdyBUwRsOBlw5zf4+RSLvVYFIsDnCJDtQSLF4A3DIEwt
	 hdpuymdIw2bJNgLM9sT6ueDqYDmgBTbEz6Ieuj9KIs+JPr4vaHwoicyhDGAtJ0tXRO
	 lTKYyOIn8fkBy3XaT/pUMuHlZFvna9dIRN5J+jnOcyyNDoz6bsGibJDefwJJDzggx/
	 P65YpLnjH/UVUqnmoyZT1DltyzHrgF66nOru8xrzip+HX11Nm0Ix/PfAQii8/HWLg7
	 O1S85yKVnXuQQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso4232701fa.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 02:53:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/mv0ooXu/kNAe8vdpguWSSQ/5Q3ejTjxAQ3IrHpoVvTCQfEOriiZFqDTDocpUHmlo+FbtCuQePECg7fSI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxxF7/X4hoUSoGI/ZPBvEBN2nJyo/cUTSmCJ7wo4VZZkjD+++sW
	xDBas/wXhfldH3asWO+EmdLSZDs3f1G0nNRwwoT1EDo1sCl7VqpJbP7mwC84Lx7KEZD2qbVOvVM
	DhJnm6XBp3f05TVWXx+005ZrniPlzqs7qm5HKxlXIaw==
X-Received: by 2002:a2e:bc83:0:b0:396:6b67:b53e with SMTP id
 38308e7fff4ca-396af195d1dmr24345291fa.17.1780566830309; Thu, 04 Jun 2026
 02:53:50 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 02:53:47 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 02:53:47 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <8a5a1bce-b841-4eff-ab3c-4f09a7ba3b60@kernel.org>
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
References: <20260603-powerpc-8xx-cpm1-get-dir-v1-1-2ae1c9a5b992@oss.qualcomm.com>
 <8a5a1bce-b841-4eff-ab3c-4f09a7ba3b60@kernel.org>
Date: Thu, 4 Jun 2026 02:53:47 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mf-AeKDn6hi_jM99BLPaDXd04pgkUyuncuUBb2Kn-1mMw@mail.gmail.com>
X-Gm-Features: AVHnY4KRs4rFY4_SpE3tqyam64hs_cj386wQGFeugWEgFiFcCFth-bDqR8z9Oo4
Message-ID: <CAMRc=Mf-AeKDn6hi_jM99BLPaDXd04pgkUyuncuUBb2Kn-1mMw@mail.gmail.com>
Subject: Re: [PATCH RFT] powerpc/8xx: implement get_direction() in cpm1
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: brgl@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2026 10:24:27 +0200, "Christophe Leroy (CS GROUP)"
<chleroy@kernel.org> said:
>
>
> Le 03/06/2026 =C3=A0 10:26, Bartosz Golaszewski a =C3=A9crit=C2=A0:
>> The lack of get_direction() callbacks in this driver causes GPIOLIB to
>> emit a warning. Implement them for 16- and 32-bit variants.
>>
>> Reported-by: Christophe Leroy <chleroy@kernel.org>
>> Closes: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flore.kernel.org%2Fall%2F63487206f6e5a93eaf9f41784317fe99d394312f.178039=
9750.git.chleroy%40kernel.org%2F&data=3D05%7C02%7Cchristophe.leroy%40csgrou=
p.eu%7C67d2207e02454f2ecf0008dec149d67c%7C8b87af7d86474dc78df45f69a2011bb5%=
7C0%7C0%7C639160720043016747%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydW=
UsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%=
7C%7C%7C&sdata=3Dk6%2FENNl94WS7QvRdhhmx8VvDyZKMNW8sAlKEq3AtQe4%3D&reserved=
=3D0

What happened here??

>> Fixes: ec2cceadfae7 ("gpiolib: normalize the return value of gc->get() o=
n behalf of buggy drivers")
>
> Isn't it e623c4303ed1 ("gpiolib: sanitize the return value of
> gpio_chip::get_direction()") ?
>

Sure, can be:

Fixes: e623c4303ed1 ("gpiolib: sanitize the return value of
gpio_chip::get_direction()")

Bart

