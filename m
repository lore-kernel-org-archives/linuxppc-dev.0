Return-Path: <linuxppc-dev+bounces-21241-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D994DCD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 13:15:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLBqY4BXXz2xqv;
	Wed, 20 May 2026 23:15:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779282937;
	cv=none; b=Am1ZbjsLxh8KPm/UQ5rk9yG2LZvfnYKDZAaQxGAm8kVE+z3zPkx0LrRp93JRrvyZJ1TDcwx0kMo2KG0RyVpEyjiPwvkuJWpIsS5qlgV8fN1WFcU/0ItT77ENDJThIvXsk14pe5PPGTHMJjf2n7uyKkjpK3ZnWudi4ls3J5o2ZbnncRrwbaHuz453H1Iaecd48qu370+P3b210ZXOd9iItEckDLv6ArniQx1GLv8uuwE3y4wvjXqtoqEIUE1L9T5/Upedeh+tUrvdKJom1neiywUONTt1CiNBDUu+hWN0a+kEP+0R90X4x5k952TnLcOZlyzq492XmdTPB2/j3S3BRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779282937; c=relaxed/relaxed;
	bh=vT277olcJ9OKS4+MATx3mmi6USeLxVT6fHEiUXX5X2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baASCA+lGcgbqhkhN40M8AriFjZHYiOsyrRaD/XccSwhslsrrH1YGMQi74Eq+5fs4R9M0puOjvDVQsrTFa7vhRnbBCumd5uVXP/BZp3XHwOneAx96j7B4gCPBye6nzD2N2EpelSuHmZkJuUazc7YS7JbHfcV40JU2FLSya0khnAEl+WFK0xMFiByjXiPCDABhQBcfDC7fZiIG6VyfkxkhuzXzCNZH9J+s7JyAigmNRnFiRqiROYxKqYIkXee+5kpWPqAIOFc4uDrXbvXXhFHAZPyiTT12aTv9Ez3ZvVAHkhOZ0VSmV5I/8l3Bq33//CV2NTRz2B5AVNLE2/CAs/X2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y72gpe0z; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y72gpe0z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLBqX6hh9z2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 23:15:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 21A7260120;
	Wed, 20 May 2026 13:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AA41F000E9;
	Wed, 20 May 2026 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779282934;
	bh=vT277olcJ9OKS4+MATx3mmi6USeLxVT6fHEiUXX5X2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y72gpe0zXK455SHxQ9u24VUk+h9yDGQrivN5G6i5J5ryWkevEuRALOKaFoTXbupb1
	 lTNI9Rl46QJJc4ebXpV7yEoNI6Y7eyvVgh2+vDNIJMIDFx1yqNZy4Okmo3DPAsWCz/
	 qh7PTRteBpd0bGENrtIXS+da12hhTyQc5WjLY0cyFVAKIGy+68/cAlpe66fxFEMmly
	 Ch4qngA1diFEbd74JBb4pu/5ALNelpdoa2GT4eZDCetCUyaYUGoQOcXIXWB+wRzFJV
	 +hUQrvn3Pj6nZUu2eZUsOUMEPbeM5RLshOdFn0EnK8kODjieSNBGE+nhh/c0RY5zNh
	 Gv0PRWK5EU5/g==
Message-ID: <f58abe7e-acf3-44f5-bdc3-3b60a37126c0@kernel.org>
Date: Wed, 20 May 2026 15:15:31 +0200
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
Subject: Re: [PATCHv2] powerpc/44x: Set GPIO chip parent
To: Rosen Penev <rosenp@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Linus Walleij <linusw@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260517063754.21819-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260517063754.21819-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/05/2026 à 08:37, Rosen Penev a écrit :
> The PPC4xx GPIO driver stopped assigning an explicit parent
> to the gpio_chip when it moved away from of_mm_gpiochip_add_data().
> 
> Restore that association from the platform device so OF GPIO lookup
> can match phandles to the registered gpiochip.
> 
> Tested on: Cisco MX60W. No more probe deferral.
> 
> Assisted-by: Codex:GPT-5.5
> Fixes: 1044dbaf2a77 ("powerpc/44x: Change GPIO driver to a proper platform driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/platforms/44x/gpio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/44x/gpio.c b/arch/powerpc/platforms/44x/gpio.c
> index aea0d913b59d..4413a94cf7a6 100644
> --- a/arch/powerpc/platforms/44x/gpio.c
> +++ b/arch/powerpc/platforms/44x/gpio.c
> @@ -169,6 +169,7 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
>   
>   	gc = &chip->gc;
>   
> +	gc->parent = dev;
>   	gc->base = -1;
>   	gc->ngpio = 32;
>   	gc->direction_input = ppc4xx_gpio_dir_in;


