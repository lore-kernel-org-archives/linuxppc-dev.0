Return-Path: <linuxppc-dev+bounces-21960-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087DDCD6E64
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 08:15:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVgVs42YFz2ybQ;
	Wed, 03 Jun 2026 18:15:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780474533;
	cv=none; b=HtaIgPFL8gdv4VrL05yJ4/jvZg2vs37WedGQnwBCRF+D5exjjhovWEgo91bQGL1YEfFvvPcCBrD5a0/fUolYNejvYZExyntS5Mzw/Ac3QeoKQaRc7lzkfjH7qy9+GOXXk9tFeH2pWyaufaWjLLHzoDCSTTvmjqhx4LWz9J3oBuDtoss1Da3wrPnc+9C8a1nZkVxsgRx427BUxaxtoruz2v96j4SwFwlA0zDLxJEiJmXjfY1972TSkEMw3N8FjM7nM6ot9tgNZqFHOqTJ3X25SxQKkhZ+e4muY/liRQcCQhXMw6yfcvs0CEZ/CV2G7O6+sAjH4nkTfvrT/Ad+nBnNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780474533; c=relaxed/relaxed;
	bh=lTFK3xrb6w+CvNIaXMSpk6JN3iYDcj4BnaLUm3TXqfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbjFWE8qIpdln8PwI7GoDJKhoPuoMuOaz4e6FsIfrgemvqQsoowgHMdpiVSF6Db/9Fl2kv1St7MMh8M6Rdq8DhO02Z7ZUOS8nOXRxth+4UUkwj6NPCU0TAyEke8BfGPql+ohGvjyanv7Uu9GRebOMr7Vl0UeUYF75I8P7vNH7/ejhw3+x4W1zyG74eP20Dkx/v/XYtP2Q5qRiN8hpHU5+rq9nTSb+g5r2YAKwQ0+kwVSKLw2EoNvXXpRkF1IQcLFpsQV0Rl6jMTVAjcHjWHDjmaOuPcBRYwmFMwTxh9q+l15WLxoWgG+q0lrKqPJpd79dj9/SXelT3O0NcnCUvjXsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEQsHp3Y; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEQsHp3Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVgVr5Sjmz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 18:15:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 920DB6022F;
	Wed,  3 Jun 2026 08:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50991F00893;
	Wed,  3 Jun 2026 08:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780474530;
	bh=lTFK3xrb6w+CvNIaXMSpk6JN3iYDcj4BnaLUm3TXqfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MEQsHp3YWYuieNCwCStPEzDNHh4TczfpHBEsh5j9K/U9keE7tcPuiYwQPAuCa1ybn
	 8oBrvz/mS4idxb/1kN18x1pFZ/lQDcI8QeV1p/9kC8iGyQPWweyESdU1PkCzTeLXCP
	 Rmc24B5mXEIqn4qOwyShNkNZlW6fkwciyrI0U2GsbGoqXPrKcBcE8PpiG5I0/hU/Ul
	 316DiBVfz9nXE8WMwhyEIEpSkck2rihWqiF/996L7VGXsOks6xnmjxtMbihPe7LXDE
	 vWro23+6XSwJZfeQnhGrWWQPPulUZfu4C/pGlNrI4eXxXEx8X6aoqR0+wm7am0iUgM
	 Dt+P0YagdZ0bQ==
Message-ID: <63476872-b3be-4564-a748-74757130c50a@kernel.org>
Date: Wed, 3 Jun 2026 10:15:27 +0200
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
Subject: Re: [PATCH] i2c: cpm: Use platform_get_irq() to retrieve interrupt
To: Rosen Penev <rosenp@gmail.com>, linux-i2c@vger.kernel.org
Cc: Jochen Friedrich <jochen@scram.de>, Andi Shyti <andi.shyti@kernel.org>,
 "open list:FREESCALE I2C CPM DRIVER" <linuxppc-dev@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260603005455.226882-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260603005455.226882-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/06/2026 à 02:54, Rosen Penev a écrit :
> Replace irq_of_parse_and_map() with platform_get_irq() as recommended
> for device-managed IRQ lookup. Properly propagate any errors returned
> from platform_get_irq(). irq_of_parse_and_map() requires
> ire_dispose_mapping(), which is missing.

irq_of_parse_and_map() and platform_get_irq() look pretty different, can 
you give more details on how one can replace the other ? (I don't mean 
this is wrong, just I don't have enough details).

> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/i2c/busses/i2c-cpm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> index 2cb6a233d313..23679c192edc 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -434,9 +434,9 @@ static int cpm_i2c_setup(struct cpm_i2c *cpm)
>   
>   	init_waitqueue_head(&cpm->i2c_wait);
>   
> -	cpm->irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> -	if (!cpm->irq)
> -		return -EINVAL;
> +	cpm->irq = platform_get_irq(ofdev, 0);
> +	if (cpm->irq < 0)
> +		return cpm->irq;
>   
>   	/* Install interrupt handler. */
>   	ret = request_irq(cpm->irq, cpm_i2c_interrupt, 0, "cpm_i2c",


