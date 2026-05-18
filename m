Return-Path: <linuxppc-dev+bounces-21097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA00CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:35:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrht1pDYz3brP;
	Mon, 18 May 2026 18:35:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779093310;
	cv=none; b=H7AuNEcpVzyl1rgNJehZE7QI+cOeKI8VRx7zmIFcH4Bma+KJrUcF2ThdPIprSlGEwN02RB4W6tup6rtgVIeWFdJSebmlyhWwVT60dswp3lBuRGEcoDw2sQKTe87jyPDC0dOabcJtbmgIGZmIIlt9LTN30t0K48pZDhoLIHEF3Xh/d042uw7/OdWaSJaYLwEYZ17ZITW5F+RG7uoCd8bd9tZL+Nsiepwq/Fl7fAJFsQC6f4M/ybOP6i5m9tvEWTFLIG7d9nSKDPKttXk+xFYtZcelym7ipTixd5szVJ6fCK2LHRgcgu3qsLwM/siSIH9DwCy+NYpvZwEqtY5/t7qzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779093310; c=relaxed/relaxed;
	bh=KwzE4WvS1tturD3icBf4rnhXP8uxns5EKACf2ikgZYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiv6WstLKZILJcvbeehng5hj20SMN/cTOmOCPZWqegA3IiKP2BqAjUSNR1W3Wq7UemgGKXVafQKbskyH2sJ8EMxQwIp8q+lpaNz3i23i8xAlu8BOm5YYNgOEPLVpCzMZw64IUFEZbZcfJlmP2pO+dnDalhAO2ZpHpCjqaq0aK8+3XHi1Vl1TJJ1IAEoq56je6/AfbdNZsWmku0k6pCcLCNNBwSRFEPTN8FcIUGtarJ8wtpqGRShFJZyr1XLhqfVe+KbSzB5l+yTiZn+GwoHrKatZ7Aizg0RtP9WQ4vA3ho7mTJkDpBzA50cHfsvyaFq3/cRTPPAS5K82E83ZRGPJdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=resnulli.us; dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=i3zbbSws; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=jiri@resnulli.us; receiver=lists.ozlabs.org) smtp.mailfrom=resnulli.us
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=i3zbbSws;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=resnulli.us (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=jiri@resnulli.us; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrhp6rCnz3brL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:35:05 +1000 (AEST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so617473f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779093302; x=1779698102; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwzE4WvS1tturD3icBf4rnhXP8uxns5EKACf2ikgZYY=;
        b=i3zbbSwsQhyAE0bqoVNY98CDgzaxmhHNWZBXqT/5+9St0ffbF+KM9H/ZnFHziSd9Cm
         HHeabm8jWSB9/iPCCKtBF803ZJMweO76UFBhwYAEnMIfDMcZXBT51MNKtCl43XTB7aYc
         NGR1KOUCtkeLhrn2Vf3XIrMIyXucRklVhhkbGjmB+kRx2FASGfb11w8JAmckImRfkJUe
         GMO4j6OaoloP1f6EJiQviCeGyDc3PPs/mSgS2HNyTUlY5NpH87y1GGMg/yOEg30yi1y6
         MJ09Ka5sPgHLt+/rKez0qq7a5HCEU4hoaG8GXwXJCZuzSgXo+qyGcGHKj3Yf0xKl7cL9
         SCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779093302; x=1779698102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwzE4WvS1tturD3icBf4rnhXP8uxns5EKACf2ikgZYY=;
        b=Ein5U8TuUuh8x7GEOrj4sTNbLvtfR+alLW705VJfdS39wPnsH2NIxV78HQ+h47wvDF
         BcNntYEKOF+acPg6xcASNN0okGz+TQj8kykGXlDDX4qrpIWGIjkbcJXh8RARdfNpmX7G
         PGHl6FGHAX28fzdO4sx8oMUXIFVSVap0kvXCG/GniRtXnZIuLqKpIJ//FBojzGMhuE80
         j0iDyujADrNRX+Q3sJBHCU+pks4ZhVA32m7D2b4/KoBdAIhb9sXU671dbLOAhxIPuh7C
         6bv8YK6BSxDhKGlJzFRKk7k+X92zL93Xzhk7AmfvYoLAR+uWh/ZH8mKeO57oIXDa9w3n
         qEnQ==
X-Forwarded-Encrypted: i=1; AFNElJ90aJk4AEw33bkEtNGHTN1HkEs4h6XvZUGLOmNjjuZkeVDJP7m5HT2C5MaJHRVc6YZuf44fZJkr00c/ZGM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwUudhhGgqcneCGRuyEMegGGDFW39gC++9jHJYhLyttJNFgCdyC
	4A9/UF0wpDGgR5m9P52C83eFGQg2l4laoIqTxPMaJSKTaJhQE+ycxNOwRH+qh79pipk=
X-Gm-Gg: Acq92OHmgIjc4f+8goURUCGVPmLFodR3hTbDwW2IbhMOKh4wGZMNohXPZCKm25VUkeV
	7ydnLy/bV7GYhDk+QhwYfpS0o6OexX/17ppc8BQw8EJHsofdUWlJobgeJbtZiiZ6bTGddGEGKTQ
	A1fPhUPIKV7MN9JOLeZPZ+JL3+QxfU8xlsxSh9PxGo7HdOWbhm9vc69rm8zBdeUUoZ7DaclRh/R
	jR5+1Ld1L3kqz0tQDwTHBNtDrcrfUC8q5UK/4xIDPFM3A1XZTZdTCbiqW1NlX8hOY3IuZ0PsGk4
	VvaW6CvKlDA7/8OAdEfnDn+RrY8RnyX016PtUQ37UV0OdAUSTUCWzK9gF8O/ntrcrt2p2Z8/7k3
	Y4hTJ2MrStSefhR6u6Os0/IYA8ozScLWkgbZKIXpqlMMLxMqLXohPr5TQ3IOCap9hOcgpLoL0gM
	c8GN3nEi7o4rc5SCxDzCf0Ehpb8//BgkJ7vWCH9u+QNSa0
X-Received: by 2002:a05:6000:2083:b0:43f:ea04:dcc7 with SMTP id ffacd0b85a97d-45e5c5f277emr23023553f8f.24.1779093301850;
        Mon, 18 May 2026 01:35:01 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm35354787f8f.37.2026.05.18.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:35:01 -0700 (PDT)
Date: Mon, 18 May 2026 10:34:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Mostafa Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 00/13] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <agrPHNClrdRvzOFI@FV6GYCPJ69>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <agldl4XQLKAtyLty@FV6GYCPJ69>
 <yq5amrxxxh0h.fsf@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5amrxxxh0h.fsf@kernel.org>

Mon, May 18, 2026 at 10:23:58AM +0200, aneesh.kumar@kernel.org wrote:
>Jiri Pirko <jiri@resnulli.us> writes:
>
>> Tue, May 12, 2026 at 11:03:55AM +0200, aneesh.kumar@kernel.org wrote:
>>>This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>>>dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>>>are handled consistently.
>>>
>>>Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>>shared/decrypted buffer handling. This series consolidates the
>>>force_dma_unencrypted() checks in the top-level functions and ensures
>>>that the remaining DMA interfaces use DMA attributes to make the correct
>>>decisions.
>>
>> FWIW, the patchset in general looks good to me. I tested this with my
>> system_cc_shared dmabuf flow, works flawlessly.
>>
>> Thanks!
>>
>Thanks, Can I add
>
>Tested-by: Jiri Pirko <jiri@resnulli.us>

Tested-by: Jiri Pirko <jiri@nvidia.com>

Thanks.

