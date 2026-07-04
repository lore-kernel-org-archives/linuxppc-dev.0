Return-Path: <linuxppc-dev+bounces-23560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA988C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Jul 2026 09:19:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gslRv4GKMz2xyh;
	Sat, 04 Jul 2026 19:19:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783156747;
	cv=none; b=RmXjyqrlVj9wAslWzZSHqWg747zxt2xfjxxEFFY43eWfZ923IZc1Qd6yprMLtTjWbg6+/O0BXHzjYIv5BWaMBa4QP6Gz2f0Ht6oYID3LlQMjPFDJs2Vl4rhP1zBNEAHe1gu+Sex8qW2Jp3gw1WSjXyfH6vo32Yab2diMxznRZd/9CqlulazIScdpYVincZTON8tefuaRBD5cSBYegKoIOTMb4hJ+F2LHYQw+8VvT8ZWjXiZTpx1br4BOJiSOy+RrYSGXx60JXw+k0k1bZS4gWVCRsm6BZWrNhkhOrdIrRKUBGU7tJC7qVqs1uZ34sT3WQfyj/+hXTt8QvU4c5TiXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783156747; c=relaxed/relaxed;
	bh=Ja37CdVukon/JrHeLqv4AFUthgRyrTWJsuQQIVUGu2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEB5LJpeUxUfuCIFWEgzzwZMbaaFI+ySnNtriiWDhE2rl7eqt4CflorfBSd3SuYe39fixVlcviG9b9XHixY3q6sP1TG+JkDjFpZzJ86m1MFKvdUEYSXliAPQDGoc7w/4TJ0rW7Pb4OKNWhpyCSw/z5dSSFQMsSP4g/c0s42+eO6NIs4LGWCiVUHOSxbS2nsCYT1VqXA3zr2yT5EbqI/Vl5QAlqZ12ujlJBJ/VAkYZjPsP/OrfEy4X6Vfv+odAHePtNPOh1We1JbRGwzCD/ZP9dIFHa9uJphyz+gh3gKgSqTwxsjZtBU+TQzTPrI1Su/LVy/vH2hQK5NVyYNOLTZz1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emSEtrMi; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emSEtrMi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gslRt4bQZz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 19:19:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0EA4C6001A;
	Sat,  4 Jul 2026 09:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC561F000E9;
	Sat,  4 Jul 2026 09:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783156743;
	bh=Ja37CdVukon/JrHeLqv4AFUthgRyrTWJsuQQIVUGu2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=emSEtrMiBTi2wSuClr1Lz9beyMkKYO6J5+NafqFwKl9Q+WMY6EPnnVjLNu1y1gFv4
	 evuoJyr3NXqR+KPt2PKo7qTh0VQlJ09zKDj6VGTbHv33kT3wv9PKhJ9SdXPchYej7A
	 912ahLVIKjSIf2tC90JFEncyRwAok641Rj9k8+gb/VeFlAfSx4fjhzX59ZiwUHsg1+
	 7idNuueBF8/w7975rUhJWwE5DtCFOM4T1xREtGN7/z1MgxqQBOlSUVI9XynXpXz4FM
	 98qgYUSVqq5UpvNXhtk8ks7CHAZPJQI27ck/x1Ps3y0rfGfepOJrzXCIN/ziotwDS2
	 JnswzJv9sIaGg==
Message-ID: <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
Date: Sat, 4 Jul 2026 11:19:00 +0200
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
Subject: Re: [PATCH] soc: fsl: dpio: Use common error handling code in two
 functions
To: Markus Elfring <Markus.Elfring@web.de>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Roy Pledge <Roy.Pledge@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/06/2026 à 12:02, Markus Elfring a écrit :
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 11 Jun 2026 11:56:18 +0200
> 
> Use additional labels so that a bit of exception handling can be better
> reused at the end of two function implementations.
> 
> This issue was detected by using the Coccinelle software.

I think it would be better to declare obj and ret as automatic free instead:

	struct dpaa2_io __free(kfree) *obj = kmalloc_obj(*obj);



> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/soc/fsl/dpio/dpio-service.c | 30 ++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index 317ca50b0c2b..025d9fb5660d 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -140,10 +140,8 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
>   		return NULL;
>   
>   	/* check if CPU is out of range (-1 means any cpu) */
> -	if (desc->cpu != DPAA2_IO_ANY_CPU && desc->cpu >= num_possible_cpus()) {
> -		kfree(obj);
> -		return NULL;
> -	}
> +	if (desc->cpu != DPAA2_IO_ANY_CPU && desc->cpu >= num_possible_cpus())
> +		goto free_obj;
>   
>   	obj->dpio_desc = *desc;
>   	obj->swp_desc.cena_bar = obj->dpio_desc.regs_cena;
> @@ -158,11 +156,8 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
>   	qman_256_cycles_per_ns = 256000 / (obj->swp_desc.qman_clk / 1000000);
>   	obj->swp_desc.qman_256_cycles_per_ns = qman_256_cycles_per_ns;
>   	obj->swp = qbman_swp_init(&obj->swp_desc);
> -
> -	if (!obj->swp) {
> -		kfree(obj);
> -		return NULL;
> -	}
> +	if (!obj->swp)
> +		goto free_obj;
>   
>   	INIT_LIST_HEAD(&obj->node);
>   	spin_lock_init(&obj->lock_mgmt_cmd);
> @@ -192,6 +187,10 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
>   	obj->frames = 0;
>   
>   	return obj;
> +
> +free_obj:
> +	kfree(obj);
> +	return NULL;
>   }
>   
>   /**
> @@ -665,10 +664,8 @@ struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
>   	ret->max = max_frames;
>   	size = max_frames * sizeof(struct dpaa2_dq) + 64;
>   	ret->alloced_addr = kzalloc(size, GFP_KERNEL);
> -	if (!ret->alloced_addr) {
> -		kfree(ret);
> -		return NULL;
> -	}
> +	if (!ret->alloced_addr)
> +		goto free_ret;
>   
>   	ret->vaddr = PTR_ALIGN(ret->alloced_addr, 64);
>   	ret->paddr = dma_map_single(dev, ret->vaddr,
> @@ -676,14 +673,17 @@ struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
>   				    DMA_FROM_DEVICE);
>   	if (dma_mapping_error(dev, ret->paddr)) {
>   		kfree(ret->alloced_addr);
> -		kfree(ret);
> -		return NULL;
> +		goto free_ret;
>   	}
>   
>   	ret->idx = 0;
>   	ret->dev = dev;
>   
>   	return ret;
> +
> +free_ret:
> +	kfree(ret);
> +	return NULL;
>   }
>   EXPORT_SYMBOL_GPL(dpaa2_io_store_create);
>   


