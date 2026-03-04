Return-Path: <linuxppc-dev+bounces-17731-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74353EFCE23
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 17:35:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR0Ds6Vfkz3btw;
	Thu, 05 Mar 2026 04:35:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772645725;
	cv=none; b=nUw7+F3mkQo+EC39blXX1ri8P+f6sosHrVF1ltPnMS7MuNfejP22rdOL0Rr3ArT1blOkr+ATV25L2IbWgZ+2m+ZSG9A9tDDwxxBZ43v0kgEqZtHQr1zRBTI0WAet89aIa5+CHp7+yciKYNz5xMCvBlqKMkJWbLc0F6KtIQYaPrxM5BqFY2nIdrq7sfksGckP516zHrDU/G92QP4Hlr4JP4wQEo3vhTGXuHDATzM7+aJ656pNdqo+toXl3gBRk+bCg6sQyIVI5J8YADMYx53wpdMZJiend5qZGSvmWe1VhEt0GpRe0xbJbMMeXHxV7stGZV4inmhxHrc8SomjWfCsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772645725; c=relaxed/relaxed;
	bh=o/Mkga0srX3I0i3AgbPBUYNrkN2bA/RLtAQdn1ppl68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSpphlPxKOjbG3FtFr0zq4OsJc5vCPEQ3LtUASFsq7PaV6TKfOVtbdZKl4XEutrfKNNcmmogtKPxjp/7ntjW+2oYf0CkoIsqmYnthNjPGCFU6VX2S2d9Pfq64ZR8aXW1SoqzTTCbQIlCI3vePbq9ABhFZn/Ro39nHzefjQdukureEwUF7OFMQ+i6EYRzgBOyqYw7CnocxsoETxNL4wxCUBfTGct6wg+QLIMy/kjolt652+crUsejixbV2NuyMNEmIdmWgrAifkrJjerJtLdSNkAGVF6flFCLM3fKPHRR2jn+Luh+XKNskJnMCevtwzrqJZxI304Nc8iLAW1We95lHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p3gRyRbA; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vgupta@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p3gRyRbA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vgupta@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fR0Dr6h40z3btf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 04:35:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 488884409E;
	Wed,  4 Mar 2026 17:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829B1C4CEF7;
	Wed,  4 Mar 2026 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772645722;
	bh=G9vyc/ilKI+19PmiBHaHsKJ89Xu7vIMfI3QiSI5VErY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p3gRyRbAmt88QYW+qJdvWj5qtD8qosiS8iWmV/39WnJFzuC4DFAe3Tyh3mY5h74qn
	 7FInoYzEWeFQ7CY8OwV54MEwdqBRVWYnNQjTVdnKRUwBSziNDWA8ecqaRvzzK/Ff90
	 NfHNcwk1I3PM4D715Ch9BaVnphe1VPolSNNw/U/tzszjymiQfwM4YNdTcdbZC7y810
	 7RYshqucnV1ca7eqd5+alsDV7oBEf6j/gB6X5uQ0hYuTexFE8Xvio9sCPsXsInNbYo
	 9ZA6X79vEceTQn8vjICVOHvGoStAFiT1AZGx6edtfTQ2DKM/24xYE+6Yy8QIDT5o5s
	 kOKClwu9c5Q9w==
Message-ID: <f00b1812-a27f-49db-9277-6697af098248@kernel.org>
Date: Wed, 4 Mar 2026 09:35:19 -0800
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
Subject: Re: [PATCH 02/14] arc: axs10x: drop unneeded dependency on OF_GPIO
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@kernel.org>,
 Scott Wood <oss@buserror.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
 <20260304-gpio-of-kconfig-v1-2-d597916e79e7@oss.qualcomm.com>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <20260304-gpio-of-kconfig-v1-2-d597916e79e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/26 1:02 AM, Bartosz Golaszewski wrote:
> OF_GPIO is automatically enabled on all OF systems. There's no need to
> select it explicitly.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  arch/arc/plat-axs10x/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arc/plat-axs10x/Kconfig b/arch/arc/plat-axs10x/Kconfig
> index b9652c69d1b90e506f82b3b8c5be373c51246671..40f2a74d404ad9759ab9d6764c2496159eea045a 100644
> --- a/arch/arc/plat-axs10x/Kconfig
> +++ b/arch/arc/plat-axs10x/Kconfig
> @@ -7,7 +7,6 @@ menuconfig ARC_PLAT_AXS10X
>  	bool "Synopsys ARC AXS10x Software Development Platforms"
>  	select DW_APB_ICTL
>  	select GPIO_DWAPB
> -	select OF_GPIO
>  	select HAVE_PCI
>  	select GENERIC_IRQ_CHIP
>  	select GPIOLIB

Acked-by: Vineet Gupta <vgupta@kernel.org>

Thx and apologies for the delay in getting to it.

Cheers,
-Vineet

