Return-Path: <linuxppc-dev+bounces-22745-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBD5CD98E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 14:46:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggRX113Vqz2xLq;
	Thu, 18 Jun 2026 00:46:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781707617;
	cv=none; b=EM0zT9Harh7lF+j/Gy81hVRHRisLi5SwUnq8bSzBfmb9+J/Yi/FSAKcUslKWe/Z/jhEoB3U59TFocqMbe5UHGB4m/8O8GJhRhBnVUis3MchoBzSKybBEhepxLG6GAdrHqZTbIHzb3qfttCteo94anyWTAIMbFjXlGsfP645zqOTdKpmCweMkGB4mICKMF9krXbw4w09JZ6N1p/av6FwYiPyNUtFo+Vz5xI4S3vBVtcNdDr3Wgv3DznCOeYTUTwpsqZ0xesFvlm15h9+prG89rUuNC9ktXlr1v4er4NfCrq7VMYYmy9HnLOPGnEsyHsHXhaB4W6KUp0eK3AQf31NZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781707617; c=relaxed/relaxed;
	bh=erXy90F1aVhSTW8POQ0NgCMddX+dCML396UHDEIaezg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OIPSBHFCeZ5FiJkuEwt4QGP7m0AjpIgBww+npNUAskQgwWHPjuTs4EyqjnZ1bpFBgVi2wsOkJBR7k7SXj9X+IMmeVC4bf8V2IaosoTYN7mJxhLxUz5lPYAvZPhW8PDzD5Wfq43lbC60/gcGZLJRJTkzcZtnS517E9Hw1slxiXu/rK6vgK4UjGHXKxWCXmfZPnIuT11QIZBptdwlci4LvCzQS2o0YBFkbniqQuhu2KAYWjW4ZEEm51jvDL2dINk3WgReRCUpZsWFy/UJz/h0V75IovhgXVg+9ZlgPrnqA2vvKQmBcYWAgdXOvEBZrU4YWghpBcpnZ13rTooO4fOIDww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laR53S4Z; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laR53S4Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggRX00fJHz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 00:46:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A98A4408C4;
	Wed, 17 Jun 2026 14:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370791F000E9;
	Wed, 17 Jun 2026 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707613;
	bh=erXy90F1aVhSTW8POQ0NgCMddX+dCML396UHDEIaezg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=laR53S4ZEFqpK1RU2C/yjKgmXtvMoVq6Ik55ii1gAWmh3rRuIBk1UrsjhJal8Mf7Y
	 nKNxtvFmqU30GaFlFd6gJbCL6OuI9sKlymNooPjqVLA22wKu2cf7YHqk3iUzTcFnOg
	 AonnWRxxacImdlprsatSccr+it2PVoCE2farsGQZ0BWMkTXGQH9HozuVaFKisG7AwT
	 5FkwBoRfJFlzW7mX9CM093Zy2Sxh6cGHKqN/0EWAVZkIvKHcMUePMuRTEjPFcC8cMu
	 msrJ3x9CnBMTnDsAFfGnXCnBCSM+Po6oFWp3nnIuybjDCDIkSmxHIeOL5R+Ez/oZG3
	 ThZCeuyOnZbdQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>, "Cheloha,
	Scott" <Scott.Cheloha@amd.com>
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
In-Reply-To: <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
Date: Wed, 17 Jun 2026 15:46:41 +0100
Message-ID: <yq5atsr1dy26.fsf@kernel.org>
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

Alexey Kardashevskiy <aik@amd.com> writes:

> On 4/6/26 18:39, Aneesh Kumar K.V (Arm) wrote:
>> Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
>> dma-direct allocation path and use the attribute to drive the related
>> decisions.
>> 
>> This updates dma_direct_alloc(), dma_direct_free(), and
>> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
>> 
>> Tested-by: Jiri Pirko <jiri@nvidia.com>
>> Tested-by: Michael Kelley <mhklinux@outlook.com>
>> Tested-by: Mostafa Saleh <smostafa@google.com>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>   kernel/dma/direct.c | 53 +++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 44 insertions(+), 9 deletions(-)
>> 
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index a741c8a2ee66..90dc5057a0c0 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>   {
>>   	bool remap = false, set_uncached = false;
>> -	bool mark_mem_decrypt = true;
>> +	bool mark_mem_decrypt = false;
>>   	struct page *page;
>>   	void *ret;
>>   
>> +	/*
>> +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
>> +	 * attribute. The direct allocator uses it internally after it has
>> +	 * decided that the backing pages must be shared/decrypted, so the
>> +	 * rest of the allocation path can consistently select DMA addresses,
>> +	 * choose compatible pools and restore encryption on free.
>
> Why this limit?
>
> Context: I am looking for a memory pool for a few shared pages (to do
> some guest<->host communication), SWIOTLB seems like the right fit but
> swiotlb_alloc() is not exported and
> dma_direct_alloc(DMA_ATTR_CC_SHARED) is not allowed. Thanks,
>

swiotlb is not the right pool to use for that, right?
CCA had a similar requirement for ITS pages and ended up creating a genpool:
b08e2f42e86b ("irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor")

-aneesh

