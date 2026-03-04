Return-Path: <linuxppc-dev+bounces-17710-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED00EB7EB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 09:18:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQnCW5KGrz3bt9;
	Wed, 04 Mar 2026 20:18:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772615911;
	cv=none; b=NDlUgxd5c1VrkdfgZoNMYD1cJTD7KcEQIxwjOj6qjU92ZlTgzfOp5QfyyAAV7zokxkMTSa7xR1yBgbLOfrEqfrbBh6zimPQ3IFJlbSynoIqKzLh4QUm28RjyBzzAaZbksT8R+Slbu+7nf8kibz/nNoNN6Io/8OElqVVinyTdWh7JOorILI2NEOugG1fK1Ozn8WW6K1Xk+VrmbgZsqoKz8syHcbqzyLoV8tYBfA9Zht5wkmLVW1K+LpVac0DqfK62L0MUfGxqJjHIgm+99blpn2xsXZ0UoJNGgxBQb8BycVZtwponfh5gBQpD+xjIAqKUTutMEOInbwMrc/sQK2SZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772615911; c=relaxed/relaxed;
	bh=fDaUrmo9ze6em2YN9RTB3L/43PYjryj77MJENeMWYVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJxxQnbtb5yKXh8G0TdkRkpjRC59I6qzhSvARJ5ixD+ktssLrtSkEOnFI24M4jcKXoCXBzvFsLH1nRNI9v0hmfopwzME5CHEVCWpD2UKthjNCq8/4Fu9on6nbTs6Vk4L/3XaGQkL4HYq2SmcJG1XIXunOp9QLHPAQ/zEo8B8z0hlAnY53zCHs+S8lv7aLWX0ZpkcD7h/yZoN775+hUX3L36cu9+gS3LU9PNHYCMUHEy2x0JKGX8xBB8lPVo3jlX6p1Tyw+BwylwN+sU3Df+P7vTh5wFeZE8GzSJGFrMr3pGMXYNHMWS7x7gTsIWLozCltAXyguBRCU2CKZ0y6uLt8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BnWrIXro; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BnWrIXro;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQnCV5FPvz3bp0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 20:18:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D8BDA60097;
	Wed,  4 Mar 2026 09:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D60C19425;
	Wed,  4 Mar 2026 09:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772615907;
	bh=DqQFigDJ368Z5nPS5m9Q7Nq+wqG5hNprsu/1QDUlhA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BnWrIXroRr6DGO6COgDOsecmpa7x+fF4yHx2u2k5WsZ+BLWzvzUUV7uMfNIoE+iQs
	 mdoGPSlZc5kn466gYE/XfSeyng33oXkMDsg0aemnWoU6RYpNSCTaHml0kjxL8q74MP
	 SGXt4SuWVja8WXGIX2YM+yHvI/BtWxlwFxtniqrT2FTrVITiI0mSIOQzGxB40qTb4t
	 01cuZXikRWIUb+pX7EDFNBbWVCDy1Hz6X++yupk9wfbTs0+Fa6FiLXxi0KaGhO19NR
	 DHp8BPZqYYB7ADvmkyvU/D4747R18C1Chuzd92zyNH3hQnNTSLQ8HWJskm8ahAhvXP
	 ElVD3LF0lvU+w==
Message-ID: <d9e9703f-8166-41a9-a927-5bcd7ad4a8db@kernel.org>
Date: Wed, 4 Mar 2026 10:18:16 +0100
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
Subject: Re: [PATCH 03/14] powerpc: drop unneeded dependency on OF_GPIO
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@kernel.org>,
 Scott Wood <oss@buserror.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-pm@vger.kernel.org
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
 <20260304-gpio-of-kconfig-v1-3-d597916e79e7@oss.qualcomm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260304-gpio-of-kconfig-v1-3-d597916e79e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/03/2026 à 10:02, Bartosz Golaszewski a écrit :
> OF_GPIO is automatically enabled on all OF systems. There's no need to
> select it explicitly.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/platforms/85xx/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index 604c1b4b6d45c11dc3149ee8b9adabe593882c8e..6805c19ac8a915dae1bd24b13010a56cf1948ad4 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -217,7 +217,6 @@ config GE_IMP3A
>   config SGY_CTS1000
>   	tristate "Servergy CTS-1000 support"
>   	select GPIOLIB
> -	select OF_GPIO
>   	depends on CORENET_GENERIC
>   	help
>   	  Enable this to support functionality in Servergy's CTS-1000 systems.
> 


