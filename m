Return-Path: <linuxppc-dev+bounces-22344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0B3CD8CAA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:44:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZVWr3Qjbz2ytV;
	Tue, 09 Jun 2026 23:44:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781012680;
	cv=none; b=ZkHYysWSIZK2NlTTvnwuAeEyhrA1QPwf/Due3bEAvMbT48plqQwFtb/LHKuiBwEY8FPryhQ2aF1v7IeC/tLS/z8CYnmZBdQjnJQbiGNZlhSaTcDPiq75HS5IL6Yc8Gwxw3t5/3PXP0whL8y3rh63pJBnwxH+Vr8QjU+kZP8qi/rr/xYOrxsjgMQspGhnzcjyLXT75eewgsivk4Wqih+W/MT8cvtcezfyYbTH56d5IgTm9NCOx1RDfaalsFmpiqahXIzCKhMc7ce4n5c77b1F0BqgSsWYgUSi6dYbSOJ3gbTUOlNAdoHwwJ5clFPtoy9L/6LD+l80XNlIWBYc6+kbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781012680; c=relaxed/relaxed;
	bh=l00W81UYsyqDsSVEFT5iHHagCSaGJS6VwfSu9rBGR+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcMpw+IgWum+HA9uu4dQ8vk/enQzD/IzEVA+os24uvQyEKaIgU7DsBedMOfOjcbs75CZBDw7Fc85SzR5k2aTULRfSC6OCsCgcUYGxuW0dtXiiMZDQIlPNiiF75n3ZFuSZf12ENwvcy5xnRuZ9XnYyzOn5A+JijIYNuVfJhZXPYIC734z6hPImMiYiOF+/5a7WViuOfuV8rhPNCyKWYiQU+1mZtx3F0cKaorhnzSunM1u/P2TDhjL+BR8p9mLjHHnMusROGQ7xvSe2Qm20lgGmRUzkfhEr7EaRziyMmcA4jYUfVcr7VHyKvNyuuc7/8OeGlNuOphn+v46XIMpIw1JSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OKBTCr2b; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OKBTCr2b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=ptesarik@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZVWq42PQz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:44:39 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-45ef14d4200so521660f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781012677; x=1781617477; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l00W81UYsyqDsSVEFT5iHHagCSaGJS6VwfSu9rBGR+c=;
        b=OKBTCr2bBHtrNllwMWnFwgDn1vBHkYKkBStBymjpgyE8bQ6eXIXJ9fMe8wWnJ4eM8j
         1Cp2HqBCJZDYCRT2mN5FnL6rHpTgR06snuGFzf/H3S+R/OUGpDuSdgUyBm2q52HZWy9A
         btNPJF1wi57Gr9og6ILPm62MaBnIGEoMn/H+fKK5L3xOhcp+uUKEr+g9L0Qpbi6xeQvg
         /+WjDjymBnoK+W2R3rpvVbxksgHH+1kSDt9w8FGrMt6hUe6znH2Rfj2txNunE86fXaRo
         DEFbh1tV5fUCpnPoYAEAtVkbMEITifMsbtZugjxk1dz1s4ODYMWFKZVObRHhG0+HkAGB
         /a+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012677; x=1781617477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l00W81UYsyqDsSVEFT5iHHagCSaGJS6VwfSu9rBGR+c=;
        b=P/SsJ/gjR7btmurW1oDKtIj0qI7AlYimMDgSU3m7iH7WYP8VryxCuneyJ9FmLcH5Pv
         N5wOPyEK9wIECw6qjTAxzktdLxiMnRZ90m2H8rfG+aUgrKVHAJtPMlLIQF+ibSEEt0E8
         HO4Fxxmj9hCQyK++MdWgewlUUL/hlxwEDJOf9MhskvO7uCdHzCWIU95q+JNfinZnCmOg
         T9w+rYqZXVz5+vFwqkaCIVa2HINj+WNOv+k4opcSgkPRR3DljYuofC7S4ID+ZcPOi+8O
         1CeUgGRKUDlvdVvKY78OxulvrOx/X2SkHps/VMcvabziUmN7bvl11c+4TIr0DNpuGSIP
         SosQ==
X-Forwarded-Encrypted: i=1; AFNElJ+h/5JG0B/oESWJMjCdBuV4BA9jSAvaAWEYR/mUHpWZQmCKx15FMpq8ZNm37BJFil6ItAk9mSbmkrsw+wk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFZzWfIvTq7XtQYaoLiwGIQC6kqEDgFp4iwVK68lYtp58lx/mk
	6XGPiOM6ufCfRIPBPuvHBjZw4+Ks5VlbVamoAKT5HongA1iYO2EhZRYW7DMP900M6fM=
X-Gm-Gg: Acq92OEMdgybuTMkHyu6itghludBoXlaSL6cRX8XdBAWVzID3IQLA/VJJc71A0ijxJY
	+KRTt6s+kCmHqBXS1zUNXYvBhj2r915WnYRkRKYYO3AZfx+VKImvkQxazc8sDtJHfYRRWPefACk
	iUiugcrkY/jAYXOWEjnzXT8xBR9gQ4U/1V8/62P00fbMMsS3CNvF7GNmQB81VYM017MyOEGROcD
	bmlprzRZe9aK/hpK8lHw3h8iY6FcwfUOqaNSPaYsQ6EapRrzkMzWXT4JDYyuCGpvxzHzJr3yiEg
	mTYkrdd+7zMTgNMiPTZoRCuV9jnmL2+J5GbE6HWfs/qU7sQ07Mb/vUH/8t0LdfxhF3/mO0oCadx
	KQSOG2AA60nW7FnLAb3FJId3ON/zJxbn5bJ6ZT3BX+25cxyF7Pvzx2+PLax1oSnAw14jqWcaKVx
	K76c9B8MhF319lDJZGGGjOtMEz9fcEJoDLDw==
X-Received: by 2002:a05:6000:715:b0:441:1c35:4b79 with SMTP id ffacd0b85a97d-4603076f62bmr12393402f8f.8.1781012676663;
        Tue, 09 Jun 2026 06:44:36 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm66805957f8f.36.2026.06.09.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:44:36 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:44:34 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 20/20] swiotlb: remove unused SWIOTLB_FORCE flag
Message-ID: <20260609154434.13dba7b9@mordecai>
In-Reply-To: <20260604083959.1265923-21-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-21-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:59 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
> controlled through the swiotlb=force command line option via
> swiotlb_force_bounce.
> 
> Remove the unused flag and simplify the force_bounce initialization.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/swiotlb.h | 1 -
>  kernel/dma/swiotlb.c    | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 526f82e9da45..af88ca7182f4 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -15,7 +15,6 @@ struct page;
>  struct scatterlist;
>  
>  #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
> -#define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
>  #define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */

These constants are kernel-internal, so let's not leave a hole in the
bitmask... I mean, what about changing SWIOTLB_ANY to (1 << 1) after
you remove SWIOTLB_FORCE?

Other than that, LGTM.

I consider this whole series a big step towards saner handling of
encrypted/decrypted memory for DMA buffers. Thank you for your effort!

Petr T

>  
>  /*
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index e4bd8c9eaeda..81cc4928e949 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -400,8 +400,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  	if (swiotlb_force_disable)
>  		return;
>  
> -	io_tlb_default_mem.force_bounce =
> -		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
> +	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
>  
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	if (!remap)


