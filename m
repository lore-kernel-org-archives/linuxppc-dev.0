Return-Path: <linuxppc-dev+bounces-24982-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC943C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 09:13:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h967Y2xcCz2xnp;
	Wed, 29 Jul 2026 19:13:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785316393;
	cv=none; b=OPhWHL8rDjXB2jyzoAhCcQV40zhkU+tVZoFT9ypCQxSGRxWaAZewYPRQ4VpRDnNiMmtHLklgQQG/Px5CCOG7QTS0Eb1J2ztDQ3RPExWcQam3LEzRzWSUUdvSSYHqNj64+sTK+zDD+YHZv+S55x/WUIvtzupqSHMD8ZholUzTe3Weo/OnhYjNW1ikRMHJYmJQzfTl/T7DBhH94rGROENbAsAljbo6FPIh9jj9EG6nI7VHqLf9coUMh7neYkdOFI/OB31R/rHRiDVA+pu3qEubWt4MOOEpZUPnKsrsbzXYYLfFKflHqJhvB/2poodTrb6S/Ayv9diEq5cUr6S5919yIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785316393; c=relaxed/relaxed;
	bh=6LOzzspZUA4rNVaGF/4ILR4pTU8q5zeUbIg7i83Gjpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nNEMs2BP9GA0Ml8FMdUu8S1uA6cpgj2Q7/8aAok+8qvtEdCC+JFoBQrrapAvvhYeWDCc/Itjs5jFUsWFnQ1HZJfZOAluFOUcIePb+OfocvIjiDN/PBCoZ8PzFFzNvtRqThJxYlB8xW9hSfyaSlHm5ogZ8S0jfLW+pupPHqd9SYdz8XxAWiOFqJMcLCV6StVRulhJPzPzehdz8cH4iQRZa9qNrbVLHQen22FYH/u4IvYiruGnhmIJYtU1Orp6NdmmIvyybksCBQK/w0nzbSVUEv3rwd4GLusVvY/0jbDfmWWp25dPnzLfRtIRc5jPChZAlpdj+KLj8V+Tn3ikTBjkcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTrQYIaG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTrQYIaG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h967X3TQ7z2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 19:13:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9AB71402E1;
	Wed, 29 Jul 2026 09:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1385A1F000E9;
	Wed, 29 Jul 2026 09:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785316389;
	bh=6LOzzspZUA4rNVaGF/4ILR4pTU8q5zeUbIg7i83Gjpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NTrQYIaG/ehk3iBfKYQ4h5VsyLIi9R25YASP+VfHEeqJLRKgGBvkPSyD3Z9S8z4Mj
	 IF3b3Y7zHwM1Ki87LSJnQvxxpFux7arhN+PB36u7RYtulEQwTh6IzxDRfys1GB1PYP
	 wQB4ruCqa5tgtepcLoDAHeF9+Xnzu0Vu+PAcp95Nt1fNRZMvtXWiwCJpv5J0FxkUcN
	 Rb9r9HrCA3JCEOWqEBO0cYpVmnNO7ADrIAeTCDv5mUNlZOFS4StYS2PO33vIrkV7ae
	 H8zXXtL5Jf4+s89pxC57mJ/77Uat6XV1Wh/ahQsyAMIHiwd/azsjJ8TLnt5OedZG+Y
	 rEpctXEsvldqg==
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
In-Reply-To: <ami7DMIlYHbcEt_6@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <ami7DMIlYHbcEt_6@google.com>
Date: Wed, 29 Jul 2026 14:42:56 +0530
Message-ID: <yq5azezaf9bb.fsf@kernel.org>
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

> On Fri, Jul 17, 2026 at 11:34:18PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> This series tracks confidential-computing shared DMA state through the
>> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
>> DMA buffers are handled consistently.
>> 
>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>> shared/decrypted buffer handling. This series consolidates the
>> force_dma_unencrypted() checks in the top-level functions and ensures
>> that the remaining DMA interfaces use DMA attributes to make the correct
>> decisions.
>> 
>> The series separates mapping and allocation state:
>> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
>>   mapping. It tells the DMA mapping path that the DMA address must target
>>   shared/decrypted memory.
>> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
>>   by allocation paths after the DMA core decides that the backing pages
>>   must be allocated as shared/decrypted memory.
>> 
>> The series:
>> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
>> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
>> - teaches the atomic DMA pools to track encrypted versus decrypted
>>   state
>> - tracks swiotlb pool encryption state and enforces strict pool
>>   selection
>> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>>   DMA attributes
>> - passes DMA attributes down to dma_capable() so capability checks can
>>   validate whether the selected DMA address encoding matches
>>   DMA_ATTR_CC_SHARED
>> - makes dma_direct_map_phys() choose the DMA address encoding from
>>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>>   relying on SWIOTLB_FORCE for DMA mappings
>> - use the selected swiotlb pool state to derive the returned DMA
>>   address
>> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>>   guests, and s390 protected virtualization guests.
>> 
>
> This series has been getting bigger, going through it again, I see
> that patches (1, 2, 3, 4, 5, 16, 20, 22) are not really related to the
> shared DMA work and are either fixes for exisiting bugs or clean ups.
> Would it make sense to have those separated?
>

Some of these fixes were originally at the end of the series. However,
it was suggested that they be moved earlier to make backporting easier.
The changes are kept as a single series because of the code dependencies
and to make it easier for Sashiko to apply and review them.

One of the reasons I'm also requesting that this be picked up for -next
is to avoid continuing to add more changes to the series at this stage.

-aneesh

