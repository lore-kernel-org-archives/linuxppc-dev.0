Return-Path: <linuxppc-dev+bounces-24866-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99560C53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 09:47:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7tzd0PmJz2yhY;
	Mon, 27 Jul 2026 19:47:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785145628;
	cv=none; b=D0ySSGQ42Bc+fFCR0ocshhVFvafu1vyBYc+MWg8m+l0TYKSRbLBaDwJzChWLCyLH7bjEfqWYc8NvjFUpfYEKdRp/G/wjLSHRk88fkjB7SxQjhEc2QfTDMjbRR4yJ77+d+cP3oIRRJX91tketbLr7NRu7HFRRwIphZ4a+ONl8nuLue3AwfFBcAmfaSZDKDd+2PI2rtDEg+f9n+AXV+AspHAi6UkJGy5R9dva4cU7Vwl+gu9uPPk1xcOduVxhqEvPOJUFdVwYHvmXfwWzcN4hfzj/hpj2ATtOtalaVP5ulh9rROUXK2OHUSWNIsBI0ZjQc7uniarZK44eQ3coxqlhPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785145628; c=relaxed/relaxed;
	bh=aKrDYlhR6SDQbCTlfl2xuP5WP5hDrGYStieG9YKwsXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=bspIqHUnHFdhMWuxq+OM8wkl3bOW4LL/z+Uxa0oo8oyUjsgdAZjSeBfTkjiffjeppK+6fu3QonvPYOR2twYzMVfC3zirz4efdcJYMub+CH8R4iQgZT+TYFyUuSbrNVadrHS08Ah2XJK2EF9M7rqHoEdSQghGHJg5ux6WUnPGfbV1OT00vkPepozO7uMBk9/v5KyVsIvxUK3JCVChyCsZ0/Wr0SqJI+vpC+m0UCDKDnktB19C/kadCbWQBH6smPp8jKmLGlo6fHjm4VMeS73v0l2dXeMD9UYTp8iQ6/7v3P3jPOl8JsOvf6M8ic51y9XoUvWfWn7osqbjDt2pePaA4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tutd9l/S; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tutd9l/S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7tzc2lHgz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 19:47:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 878A0601DE;
	Mon, 27 Jul 2026 09:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C56B1F000E9;
	Mon, 27 Jul 2026 09:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785145625;
	bh=aKrDYlhR6SDQbCTlfl2xuP5WP5hDrGYStieG9YKwsXQ=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To;
	b=Tutd9l/SYstDt45jLYidI4LJML/z/7DIWAk99X3pJcu+O0UnOCF4SoDQ6ezkAvQs/
	 Yz+6bJOUYb0qF04ohMj++b5DGLUoYRRKlg1ri/2JyqCWvVwkLDNcRHN7LAyZvpm82o
	 Z3DHu8DRRX+TcIX68HrlYmYeuk16df7uyoXA2U+NcU163UQNJZdr2ajRGJHCmx1TXi
	 uBlYesK8lRnZdXAxKyfXPqDFoo2lSbwyGmCfeO5VnjuaaER15HKl9bwspIFmf4vq3o
	 inmk7F/7ZKrhcNblqZYB7tci4WC4fYFqdS/WYM8l+/2WGnFGNH8raUo/F86+pDwivf
	 t8RHW+hVGCoNg==
Message-ID: <877f0d7a-6eb9-4305-be24-20e97bb3edcb@kernel.org>
Date: Mon, 27 Jul 2026 11:47:02 +0200
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
Subject: Re: [PATCH] soc: fsl: dpio: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20260723024748.30105-1-panchuang@vivo.com>
Content-Language: fr-FR
Cc: Roy Pledge <Roy.Pledge@nxp.com>,
 "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
 "open list:DPAA2 DATAPATH I/O (DPIO) DRIVER" <linux-kernel@vger.kernel.org>,
 "moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260723024748.30105-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ioana,

Le 23/07/2026 à 04:47, Pan Chuang a écrit :
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

I plan to take this patch for v7.3, do you agree with this change ?

Thanks
Christophe

> ---
>   drivers/soc/fsl/dpio/dpio-driver.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index 9e3fddd8f5a9..d5198ffc4455 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -102,12 +102,8 @@ static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
>   				 0,
>   				 dev_name(&dpio_dev->dev),
>   				 &dpio_dev->dev);
> -	if (error < 0) {
> -		dev_err(&dpio_dev->dev,
> -			"devm_request_irq() failed: %d\n",
> -			error);
> +	if (error < 0)
>   		return error;
> -	}
>   
>   	/* set the affinity hint */
>   	if (irq_set_affinity_hint(irq->virq, cpumask_of(cpu)))


