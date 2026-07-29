Return-Path: <linuxppc-dev+bounces-24981-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6CBC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 09:09:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h96382yPWz2yDr;
	Wed, 29 Jul 2026 19:09:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785316164;
	cv=none; b=gQKcXKxKf4aP90Zhl4DPasWL0zmK6dayuh31qgahlM185FV34fLhe/bCSy4Oz5PUGX/LtPMJ8KnaLn4Irxt+uuYi9PhODBGSTE5YVV+4Z4Vij5tz/QdvTOAx3/NBTzH8lhbV6Yehp02Tv78rfkcSxciiITwNqgkkhUmx1/+PlF/I+Lf8zmzXRULF+Wx6fr7tLXSoV1pb7qrjpJWEneqCvomIdr30QrqBFB9/+sKyZK9kX4nNWurdF5c5/dmM2KWSRLj+roQxMU11e9Ff6JMljKvdLC+rMyxPAUmsl/tOyQykUqKjRu+1FdNHGU4io3bzjukZ3Rsg3V1UY0PstryeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785316164; c=relaxed/relaxed;
	bh=3SpSxnvuNGmLHWtJ7jUwkJNoaIB6p9cDPcBNT0kYRN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iDR7xGNGxuh+DodZGcP/ZRLB5WyDMGCcPUTRA/uYcaqBkABvLwyGc/D5hg4MnzyBOrk93lf+o0X/FXL8syyQ0b3xE0iEtjo4wvpJf5/sAMBJ18e6toVGuT6xxilqiP9hHITVTQcl+O4tNGePkSNDSvvLaFCkCf6d5rcXJTKe7O3v2n/REJMzFVriJ4lR1cAzMFpMn2lwjFvpJBcsaGaQcpwTEEhU1zwwu5M9NuKb0FWIIKLr+UvqXNDu5PvQ7Y/caBw5fgTLw/7e6vsALwc9YtPMXFANE12p8Inw20OkPnGwos2lGeCPyKAv1JfruDwhWpnNHVby/1ClkclnG6AN3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2VcftX+; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2VcftX+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h96375qhTz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 19:09:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D4CB960AA1;
	Wed, 29 Jul 2026 09:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD2D1F000E9;
	Wed, 29 Jul 2026 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785316160;
	bh=3SpSxnvuNGmLHWtJ7jUwkJNoaIB6p9cDPcBNT0kYRN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=A2VcftX+szPrGFM49eBI8rgFYkmukzvFokMsd6WGe+h74xvC6CtdICs0UZ4yjOqvR
	 fdcdUi7fzgpOIuZL4RtiddkR2ScDaD1cM0BLIuDlG5jfNQnWGV0+ncs9XXY9Jex52k
	 tM0VQtKPqoomYgjwCx715PfvDmGSE4Gn1EIUcmgyqaAnRRJQaMVwm6nS/F4mOO27ja
	 qcoSXdaQMlMbY8tkdYIqHfSFfCMxIeoHQkHUsXhWW/I8Fs/VcUew2AFEtR4JR7Y19H
	 PUnnq88/Wgvhkl2D7ezzQNWPFWPputmv9S883P/cocuobYpEolgl3n/xjWk2H65qch
	 z6Y42MpMAW7YQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 15/23] dma-direct: pass attrs to dma_capable() for
 DMA_ATTR_CC_SHARED checks
In-Reply-To: <ami9CIGanuQX3lxb@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-16-aneesh.kumar@kernel.org>
 <ami9CIGanuQX3lxb@google.com>
Date: Wed, 29 Jul 2026 14:39:08 +0530
Message-ID: <yq5a33x2go23.fsf@kernel.org>
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
Content-Type: text/plain

Mostafa Saleh <smostafa@google.com> writes:

>>  static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>> -		bool is_ram)
>> +		bool is_ram, unsigned long attrs)
>>  {
>>  	dma_addr_t end = addr + size - 1;
>>  
>>  	if (addr == DMA_MAPPING_ERROR)
>>  		return false;
>> +	/*
>> +	 * The DMA address was derived from encrypted RAM, but this device
>> +	 * requires unencrypted DMA addresses. Treat it as not DMA-capable
>> +	 * so the caller can fall back to a suitable SWIOTLB pool.
>> +	 */
>> +	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
>> +		return false;
>> +
>
> I guess it does not make sense to check the other way? I'd be worried if
> some a confidential device uses shared memory which might leak info.
>

From the perspective of the dma_capable() check, this should be allowed;
that is, a trusted device is permitted to access shared memory.

-aneesh

