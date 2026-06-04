Return-Path: <linuxppc-dev+bounces-21999-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96A9CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 08:24:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWHfr1jDnz2y1Y;
	Thu, 04 Jun 2026 18:24:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780561476;
	cv=none; b=eSqMNEBlC9jxlgOLexL8IjA31iYTdLuxfxk/2h5IxcGQ0Oxpsx1G6stlK9ItdHmzdBo+otgXLfPvIaQKr+bt4JGZ4q6WOJIh3Istxh1lsjx0CNtdvDCRFNXcRsxG5BuAmnQshf+IneZyVAWbJgoRsnVxa1eQLl2MUCXWDrDRKWvXJHrLJUfrw3Xac3rvQrDVJZyOa8G/F6ilPcnDY0qEdcmDHDnWLqHh0E0FIqaT72XCMgOXc2oH9yYnJDJQaPYHGWkoQhmht+khqKsOwrGLa/a/yWqW+qfBOWmJeenaQKjf645QIptH97gnxqk+8iFpAxX/VKgt43BMnKxgEuSo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780561476; c=relaxed/relaxed;
	bh=JulNNZEEG3FJVfWHiYWEV4D4RkEJCs5RPOKvt/BEQdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amSJWmrFCAn1+bPtjuiTPuQq2SoMcJ/fzjtKgN6rZ9ktdulWuF+i9aGMXb3QqS9dMfnKK9O8v6HKyhvgJT4JfdlyVUTeaWr+2ZlgCaPX/3fnpcDLn0qmWhsf2bE/5kSss/Pbs3tnLViP9+pDDUUjncRxWwtmjXmxjfZGIMrGhm4qlLZOLD50hXP7yuVr1kgNEDCsFd9U7Hv1C+p+OjbSCNWZCxyzzeuxaHKeNMOb3N68+RuIaPJM7Mkuv4h4IHakSkT7XG70QWgZk1DqxwnYE+3vWaUfw8tmL46dmO0LAWqjFYY425uND0mwlhMlXIQtsJLt8Y97sek++4iUkvzpwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/S06ixk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/S06ixk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWHfq2tDmz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 18:24:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 03C574092C;
	Thu,  4 Jun 2026 08:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57C41F00893;
	Thu,  4 Jun 2026 08:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780561472;
	bh=JulNNZEEG3FJVfWHiYWEV4D4RkEJCs5RPOKvt/BEQdw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a/S06ixk9dWQIHc+etNiH+Ckg+Uy1+kmYNwhxpL8UXxHFP7vqj5yUug4wb89eRy7E
	 GBG6SUyNby291WPZ3wohMz0vfGCTNbXLpW9LBNTKlkf+jB7sfTC/pFftlBH+FouM2i
	 3BqCd6MnISoNUXNLo7JqdKi7G6dDCyPUOImVXD/UuC8ZcvqLxCfCyDnOaIn/4tNR+W
	 QkaKEq33zvhwz/QrCaZTyzmvr5r74wHSqiRDie31jZ0Sq7d3I/dQb7Cm7cpcd/bOaB
	 VM3ZZIxS6UOxKDxmOR+R6kDMFt9drWPsF+DaXhHSXgBZaCK6NgHVBjsppxzlPR0Ht8
	 xXKPXWMVvMtfg==
Message-ID: <8a5a1bce-b841-4eff-ab3c-4f09a7ba3b60@kernel.org>
Date: Thu, 4 Jun 2026 10:24:27 +0200
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
Subject: Re: [PATCH RFT] powerpc/8xx: implement get_direction() in cpm1
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Linus Walleij <linusw@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: brgl@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260603-powerpc-8xx-cpm1-get-dir-v1-1-2ae1c9a5b992@oss.qualcomm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260603-powerpc-8xx-cpm1-get-dir-v1-1-2ae1c9a5b992@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/06/2026 à 10:26, Bartosz Golaszewski a écrit :
> The lack of get_direction() callbacks in this driver causes GPIOLIB to
> emit a warning. Implement them for 16- and 32-bit variants.
> 
> Reported-by: Christophe Leroy <chleroy@kernel.org>
> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F63487206f6e5a93eaf9f41784317fe99d394312f.1780399750.git.chleroy%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C67d2207e02454f2ecf0008dec149d67c%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639160720043016747%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=k6%2FENNl94WS7QvRdhhmx8VvDyZKMNW8sAlKEq3AtQe4%3D&reserved=0
> Fixes: ec2cceadfae7 ("gpiolib: normalize the return value of gc->get() on behalf of buggy drivers")

Isn't it e623c4303ed1 ("gpiolib: sanitize the return value of 
gpio_chip::get_direction()") ?

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Hi Christophe, please test if this works for you to silence the warning
> from GPIO core.
> ---
>   arch/powerpc/platforms/8xx/cpm1.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
> index f00734f0590cf7c7382f808dce27373d9ff3d8bc..b31376bf6778802a7f6b6b499066846b6b1f61e9 100644
> --- a/arch/powerpc/platforms/8xx/cpm1.c
> +++ b/arch/powerpc/platforms/8xx/cpm1.c
> @@ -472,6 +472,18 @@ static int cpm1_gpio16_dir_in(struct gpio_chip *gc, unsigned int gpio)
>   	return 0;
>   }
>   
> +static int cpm1_gpio16_get_direction(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
> +	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
> +	u16 pin_mask = 1 << (15 - gpio);
> +
> +	if (in_be16(&iop->dir) & pin_mask)
> +		return GPIO_LINE_DIRECTION_OUT;
> +
> +	return GPIO_LINE_DIRECTION_IN;
> +}
> +
>   int cpm1_gpiochip_add16(struct device *dev)
>   {
>   	struct device_node *np = dev->of_node;
> @@ -498,6 +510,7 @@ int cpm1_gpiochip_add16(struct device *dev)
>   	gc->ngpio = 16;
>   	gc->direction_input = cpm1_gpio16_dir_in;
>   	gc->direction_output = cpm1_gpio16_dir_out;
> +	gc->get_direction = cpm1_gpio16_get_direction;
>   	gc->get = cpm1_gpio16_get;
>   	gc->set = cpm1_gpio16_set;
>   	gc->to_irq = cpm1_gpio16_to_irq;
> @@ -604,6 +617,18 @@ static int cpm1_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
>   	return 0;
>   }
>   
> +static int cpm1_gpio32_get_direction(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(gc);
> +	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
> +	u32 pin_mask = 1 << (31 - gpio);
> +
> +	if (in_be32(&iop->dir) & pin_mask)
> +		return GPIO_LINE_DIRECTION_OUT;
> +
> +	return GPIO_LINE_DIRECTION_IN;
> +}
> +
>   int cpm1_gpiochip_add32(struct device *dev)
>   {
>   	struct device_node *np = dev->of_node;
> @@ -621,6 +646,7 @@ int cpm1_gpiochip_add32(struct device *dev)
>   	gc->ngpio = 32;
>   	gc->direction_input = cpm1_gpio32_dir_in;
>   	gc->direction_output = cpm1_gpio32_dir_out;
> +	gc->get_direction = cpm1_gpio32_get_direction;
>   	gc->get = cpm1_gpio32_get;
>   	gc->set = cpm1_gpio32_set;
>   	gc->parent = dev;
> 
> ---
> base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
> change-id: 20260603-powerpc-8xx-cpm1-get-dir-698cefe92647
> 
> Best regards,


