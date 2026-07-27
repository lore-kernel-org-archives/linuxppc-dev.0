Return-Path: <linuxppc-dev+bounces-24885-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1CEC531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 11:32:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7xJh2zt8z2yhD;
	Mon, 27 Jul 2026 21:32:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785151924;
	cv=none; b=eX33FVwSfxwwXEXG+BebbPg6p+PyZ7sVJRLJzdpqy8igYgC7S1+gu2eOOnGd6+GF7g2Zlww84/jKZcWJEPjlaGnu3ezCD8nlxEHnJmKObO4HXaaEFniNWJLKYee7Yf+36QSfIhLXdK1Jcg2r0EFA0noVmYQICH4hQ7HK9JOO16Srj5w2ffWlBRGYo+XgMOtHUrezG4tvSOGXGhdcFfN0V5JkQt30z2daDU+1nfwUwFj/22LO7l5xdm7+yWVetlnK1TlJPK5dc1euCQIjpvLn1N/NA6S08EvcdDSCyShnymwtnRXpaoJ0mqkV2GsVAoIuyjofYKzMCArrlbxWc4+8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785151924; c=relaxed/relaxed;
	bh=QyC9mdpjeVMS9mEWtOssGaeZCvP0zDJ8dCOHi6clafA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFKVlHV8LHmKqJQp0q+NSyMl4v6yJiUHyRj+sIdpkNgZ+sd9fjV3z6DRMtoDaz6la2cZgIm4NuVRRQFOQ+J/L1NNpNPGz0Og9+puHjAQW8YoeBgAItZPr5K4cgMmPkp65IYlJ9Kxc4gb8m/FFXGGjjNrg0t03Bb2wcwuj8L+fBZDktCRa+MvgX/zBCXGRvt6MasDmXIvxCH12v88ymWFfPxYQae04Vl4T2pzoCC43C4vkbZVxmCZC+LnNarKNErIc2dCPO2FQ0EzNdiOzdZp18Jx1VLXtq1bARTRY0XrqFtLLZtcHcG5ZG387r/JSrCwRYYU+uRySIyqotXGQqDxkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sMp023WS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=error27@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sMp023WS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=error27@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7xJg0G3Nz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 21:32:01 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so2009817a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785151919; x=1785756719; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QyC9mdpjeVMS9mEWtOssGaeZCvP0zDJ8dCOHi6clafA=;
        b=sMp023WSeGw85LDeFXaDMpluJ6pG6AIqQLae/JSU71IMEANfHS8XoVo6sM5syUnRY9
         QytZNr5bg/GvCrH2SFJLpN5SZDZbxS/9g7X7J42RGQfGE2XaVzeUe5inRFJNlVvMhQc8
         n7Yqc58a2mcEtpwrOtm4HM5PlgJQmmQJVtW3zlJcs1ArRumej38Mjp0W9gH6rcjiHski
         mRNwSlf1cjwAzRFZM8XBiWu76SsD1/7ZiYtfuMQ/V+Vu3PvVD9Py9PMsDOPQ1HkfwQ19
         c2NpfGVXQxZM2S436U+z1dR1b4dnwM14Xj4pUXO9gZJiJMPhlvkFvwa564eC60Kpgxsj
         IDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785151919; x=1785756719;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QyC9mdpjeVMS9mEWtOssGaeZCvP0zDJ8dCOHi6clafA=;
        b=j/kydcjJgPpodEBa33R5wcXlhIFfM0AC5dvKfactCiBJE5qhHTFmJ0v6tPkmUXwEyK
         IzuXSmNUdyzIcXG5QBsqdZAliTfN1Pfad/d3QhBOCWLcWozI9RR4a2Ui+5AYfOqmOkvQ
         rf5pIxiS9uZtSgWYrwjUtMBos30IjEFBumm/HjK8xGCPua3Jt6C8not8vp9uBKsEvCTz
         4QMdJoQwxDbpArwLzfkHu/0JAOAzyn1uSESMiJfSHOD+2KbiZ7dSdO8bigZtMEk6eVt5
         R8+0+rN1F8ReV7dJgmG6jal4a7Iq+0ESdI0TknU1tUTsPFvlO3BfbmOg7ktZWzfvpF8+
         vE0g==
X-Forwarded-Encrypted: i=1; AHgh+RojGyIaZK814jqESaF3H/2HGFbN75FKwG2P/3kdnfD86+t42siaT1ZyhjEG0uCnB9MecfkjJpTvMSSDQ7o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyYSUmUzfURgUB7lr5nk1thVRRNxxLtkj0Z58TjvSj9XrxPBlkc
	Ai9DPvqx/9GpzPFMZigfzhoUaIT/Do1B/8SUJgTPbh8kv5CIyXTX9kYm
X-Gm-Gg: AR+sD10g6zbxoIkI2MFsPourvB3EM/nyfFK35nXi35x7q6xTxZoy9bCcBMVhLT/cXSf
	JmEx7dgV6tx/Wk9gRVaBnG6y3dN1T6tudrPM8PbtNy+IWR6F+79/h/3hwmfnjS5SSy1BbIavB12
	XeAU6tGvt2M8eoz+d2eS3Gs73NQz6WKLIiU6GGD5Slc2RCkTzzHRDSVSXOzCN4TnLN1OcV8d+tY
	1LvGYB3G0el6+A8kWTUTqyik/Kkwrx+SqZ6qV92iLOD8YYsrn4j8suYc7b0/40zRV6u7B1QjKJ+
	ANLWj4YgnW0EXhRcZogasHAm0DJmna3PFwegF3VVZwAGj1oBIt7kq6fplMbEFpJQZibb8Fe7+Y6
	ES82xz7NcUwfNuXRjTcmqrWx9uMMuDyl/o3nvKEsQBB5U1z3vSokEkPbU76DoBN4EPX8aZ49X
X-Received: by 2002:a17:90b:5710:b0:38e:b3fd:d584 with SMTP id 98e67ed59e1d1-38f2aa99deemr5981029a91.15.1785151919217;
        Mon, 27 Jul 2026 04:31:59 -0700 (PDT)
Received: from localhost ([172.216.252.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f04175c1asm4880106a91.12.2026.07.27.04.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:31:58 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:31:53 +0300
From: Dan Carpenter <error27@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <chleroy@kernel.org>,
	Roy Pledge <Roy.Pledge@nxp.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] soc: fsl: dpio: Use scope-based resource
 management in dpaa2_io_store_create()
Message-ID: <amdBqQfIsAjxMsqX@stanley.mountain>
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
 <6607bb4e-a747-4791-b93f-f82f26e4a334@web.de>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6607bb4e-a747-4791-b93f-f82f26e4a334@web.de>

On Mon, Jul 06, 2026 at 12:38:08PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 6 Jul 2026 10:34:43 +0200
> 
> Scope-based resource management became supported for some
> programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
> See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
> Introduce __cleanup() based infrastructure").
> 
> * Thus use the attribute “__free(kfree)”.
> 
> * Reduce the scope for the local variable “ret”.
> 
> * Omit two kfree() calls accordingly.
> 
> * Omit the local variable “size” (for another memory allocation).

Why?  This seems unrelated...

> 
> * Use the macro call “return_ptr(ret)” at the end.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/soc/fsl/dpio/dpio-service.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index 317ca50b0c2b..b252c3c7fa65 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -652,23 +652,17 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_acquire);

Missing #include <linux/cleanup.h>

>  struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
>  					     struct device *dev)
>  {
> -	struct dpaa2_io_store *ret;
> -	size_t size;
> -
>  	if (!max_frames || (max_frames > 32))
>  		return NULL;
>  
> -	ret = kmalloc_obj(*ret);
> +	struct dpaa2_io_store *ret __free(kfree) = kmalloc_obj(*ret);
>  	if (!ret)
>  		return NULL;
>  
>  	ret->max = max_frames;
> -	size = max_frames * sizeof(struct dpaa2_dq) + 64;
> -	ret->alloced_addr = kzalloc(size, GFP_KERNEL);
> -	if (!ret->alloced_addr) {
> -		kfree(ret);
> +	ret->alloced_addr = kzalloc(max_frames * sizeof(struct dpaa2_dq) + 64, GFP_KERNEL);
> +	if (!ret->alloced_addr)
>  		return NULL;

Why convert the ret allocation but not the ret->alloced_addr allocation?

regards,
dan carpenter

> -	}
>  
>  	ret->vaddr = PTR_ALIGN(ret->alloced_addr, 64);
>  	ret->paddr = dma_map_single(dev, ret->vaddr,
> @@ -676,14 +670,13 @@ struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
>  				    DMA_FROM_DEVICE);
>  	if (dma_mapping_error(dev, ret->paddr)) {
>  		kfree(ret->alloced_addr);
> -		kfree(ret);
>  		return NULL;
>  	}
>  
>  	ret->idx = 0;
>  	ret->dev = dev;
>  
> -	return ret;
> +	return_ptr(ret);
>  }
>  EXPORT_SYMBOL_GPL(dpaa2_io_store_create);
>  
> -- 
> 2.54.0
> 

