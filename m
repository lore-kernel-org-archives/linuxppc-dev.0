Return-Path: <linuxppc-dev+bounces-27660-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EADC88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 06:17:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmMqg43qkz2yhP;
	Fri, 18 Sep 2026 16:17:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789712271;
	cv=none; b=C84GGbwD7HHUj+6515pW7+5OT/zC6Q4qFdGaYe0/GAKaokZFED2YDA0sg1Pi4maXqktVTKxeWbzj/aXBxzURmIVDNTaeIXnlEmTlojlOERlLGSbm2LV/lANQHfSVKfvxKM7hwp1kAWbnCQ2JqLDoj+A7CjOBaUCyH0/FifvcgQdQoFXE4CojF/WSNk17KB8nDCqH1bZvNojWqWdPjuFUBkLmfcEfsXkTYYkuuvFltrcK6tXSBqaxUQdHV3Msf7OEmeBJzrI8IrsyeHy9bBwcvEHB2VtW2U/ken7zzq94DqEXtFICaU8JHrqjZbTEF+SOvX+rqAOPZwRXqf43NuBwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789712271; c=relaxed/relaxed;
	bh=ZQuk43Brm3omuO2DAekLSRMmNspb8q1ZaXTTwle8fh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+mRHfWTwxL6psyPtGBu1NPJdxvWra/XiUS91/YLlzfVtE+1DdOiFPfbiSaef1RUVe5KNM2LGYQJX4dFuFnKI6v24eM4bAHFGrr2HV9AIVT9xTh8F88rLFJ8XrIPyG00y8B30VQ0g/bde4qInRv/p7UoCON9TVMNXFRxpv/aI2/EQUwv+tNqTApPYzIa8aYGI//bdTlZzt6mTKwK1HHn/Mxzn6uRquf1Fh7mnbDfRkhXHEw5hwTO90uR5sEPUoeqiiqcR5zhFZ77fxawEUEdRb3RkUqyfWlKuru+uLfo8y3kBKgx5FIqOr0rYxqF++NEiuLsXWb7GwAK2m64WCMzIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIymmGnM; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIymmGnM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmMqf5xFrz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 16:17:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C5DF403B9;
	Fri, 18 Sep 2026 06:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5304B1F000FF;
	Fri, 18 Sep 2026 06:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789712268;
	bh=ZQuk43Brm3omuO2DAekLSRMmNspb8q1ZaXTTwle8fh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VIymmGnMspsP0ZCZVY4PL6IoQsRGqoVMe6G9hD5c4ysDDmi8QeeDmXQPdZK8eTdyB
	 qgUXYXI82Snvu3l6r6Xrd3IT1Cm+FUDt2b3R2efOqoj5cvn1ULdyBhzwLSge4tTgWb
	 dZJXHHmNdObQOFAEvE3k6+JsVfbUMPfK7NWXSTvjTJcyhjNRJ+jdAmY3ESeAw8HJOM
	 9gdxrG0r+FrCVnE/y/dcTbbslcYQYtVRzQDU3icXkC11B5bUy2UEnZ32sY1AxsBFya
	 oMeawWzq4mHGu7JgLPbIbAvD/hpyDXAW0Yz2eJ1+AXHlmwucCuieuZETAFHd5ZFpoD
	 VXDSDi/WgJ8wg==
Message-ID: <5b086e1a-8b8c-4536-8b64-e0169826ab33@kernel.org>
Date: Fri, 18 Sep 2026 08:17:44 +0200
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
Subject: Re: [PATCHv3] dmaengine: bestcomm: use platform machinery to get irq
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>
References: <20260918001835.154305-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260918001835.154305-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/09/2026 à 02:18, Rosen Penev a écrit :
> platform_get_irq() avoids having to explicitly map and dispose of an irq
> by having the platform_device machinery take care of it.
> 
> This requires replacing the device_node with a platform_device in the
> bcom_eng struct so that platform_get_irq() can use it.
> 
> Conveniently, this also allows getting rid of of_node_get and
> of_node_put as the platform_device machinery also handles that.
> 
> Adjust the goto labels in bcom_task_alloc to match what is being freed.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v3: drop stale description
>   v2: resend
>   drivers/dma/bestcomm/bestcomm.c            | 47 ++++++++--------------
>   include/linux/fsl/bestcomm/bestcomm_priv.h |  2 +-
>   2 files changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
> index 241a91936fe8..1006030ff167 100644
> --- a/drivers/dma/bestcomm/bestcomm.c
> +++ b/drivers/dma/bestcomm/bestcomm.c
> @@ -99,17 +102,12 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
>   
>   	return tsk;
>   
> -error:
> -	if (tsk) {
> -		if (tsk->irq)
> -			irq_dispose_mapping(tsk->irq);
> -		bcom_sram_free(tsk->bd);
> -		kfree(tsk->cookie);
> -		kfree(tsk);
> -	}
> -
> +err3:
> +	kfree(tsk->cookie);
> +err2:
> +	kfree(tsk);
> +err1:
>   	bcom_eng->tdt[tasknum].stop = 0;
> -

This blank line removal is unnecessary.

>   	return NULL;
>   }
>   EXPORT_SYMBOL_GPL(bcom_task_alloc);

