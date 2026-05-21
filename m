Return-Path: <linuxppc-dev+bounces-21337-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2EBCD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 15:38:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLsxW39y9z2y7Y;
	Fri, 22 May 2026 01:38:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779377887;
	cv=none; b=KNX8XDBvRlbjkLKtEmboi3/tN5v3u8/mYaoXddTZyyK+yE7WUxFqC2CHqPx9cOKOPVbmjtjF+hH0CmYv0HwxO43yPIjdcgr8lD5Kmgfyzm0f79r6yVkKKzFqs7XjUeQtYbpUw+gcSqScFhTTcgF6yL+a2OdvLfIhUh9Ng78uACMPx9R9/6z5nPAMyA28rf5pjVR3Leiq4OrKUIVMvylkasUhx0DRcYVxcaRXVHs4zZX3CrEZ4V2/9y9wTuCKczxpMvC4YeQFwDlCY9FhaqSuyH0iSJPIMFCNpOcD8uDw8eqUlKDnwKja3NN5zttY9wPLfYoYkiKNUFQUuQFTpu0Vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779377887; c=relaxed/relaxed;
	bh=Qomyt6SRN6loAiKuzG+mnZMN+9NDAav5uB2vD7COXYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n5YztT2NBUg8Nl2GHpTv8CAKyxwYP5Dtprx6PDubqlXMR1SPIfQWJqymR5nGc9/Zi8P6kpcxXB2haMBoDBaiEfNkLLLtKktpQY3tZ+TGZwYaUYQ4Sc414ZtiR838/CjuvRsmeS8Loj9SV03sYOaZE77fflQwoYIy6Qow9cY3BuYbPjbSaSs7q05On+4Iw04xMKR2kV0guMB1fQgN8nVkzRyfh0z8Pt9BrFVK0Us0cwf9/tU8TJjx8LtQJq/WxUjbqFk+XbeSfCL+nUIcU901fCgOjnwgI1o4c/vmflKflUkM8VnXWwDoSOUT1vMLFFoh76cGrkKuu70QaBgmiOBbwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SKjGQCP1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SKjGQCP1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLsxV2H1Cz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 01:38:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FFBF44148;
	Thu, 21 May 2026 15:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055241F000E9;
	Thu, 21 May 2026 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377883;
	bh=Qomyt6SRN6loAiKuzG+mnZMN+9NDAav5uB2vD7COXYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SKjGQCP1jUHZn8lGcvNb16fhytEsPovJvUrNUllKBoXBnYhKzZyiWFp5SXoR00qSh
	 4Yi1RUq4BpLuoEGXd/ZfpfHeWAgR0+SKGaVyCv/OICsvCL8QuRGyjiXEjI5giDln+y
	 nPHP27gGY79//Ncb34+zHprzV63ewWoOHLFrps3BSWb2kqL1XebtXJJN3TVZe3EV/k
	 urWUK7qq4xQ19I8ijQAMN6p1ereVXTWRx1/nsAg3dl09jZhyb9oK04vIX/Z5RdNTgn
	 97oMJkfi8HsdKYrcl3kj4rpuwHeCO8ecnTXfnja7vDYtRCrTlYPo8c5gdohMtv0jZ2
	 UZTZ7iyYKVbCg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
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
Subject: Re: [PATCH v4 07/13] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
In-Reply-To: <20260512090408.794195-8-aneesh.kumar@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-8-aneesh.kumar@kernel.org>
Date: Thu, 21 May 2026 21:07:49 +0530
Message-ID: <yq5awlww6aeq.fsf@kernel.org>
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

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e05dc7649366..4e35264ab6f8 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -89,36 +89,32 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  	dma_addr_t dma_addr;
>  
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -				return DMA_MAPPING_ERROR;
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +			return DMA_MAPPING_ERROR;
>  
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -		}
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> -		return DMA_MAPPING_ERROR;
> +		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>  
> -	if (attrs & DMA_ATTR_MMIO) {
> -		dma_addr = phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> -			goto err_overflow;
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +	if (attrs & DMA_ATTR_CC_SHARED)
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
> +	else
> +		dma_addr = phys_to_dma_encrypted(dev, phys);
> +
> +	if (attrs & DMA_ATTR_MMIO) {
>  		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>  			goto err_overflow;
> -	} else {
> -		dma_addr = phys_to_dma(dev, phys);
> -		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
> -		    dma_kmalloc_needs_bounce(dev, size, dir)) {
> -			if (is_swiotlb_active(dev) &&
> -			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> -				return swiotlb_map(dev, phys, size, dir, attrs);
> +		goto dma_mapped;
> +	}
>  
> -			goto err_overflow;
> -		}
> +	if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
> +	    dma_kmalloc_needs_bounce(dev, size, dir)) {
> +		if (is_swiotlb_active(dev) &&
> +		    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> +			return swiotlb_map(dev, phys, size, dir, attrs);
> +		goto err_overflow;
>  	}
>  
> +dma_mapped:
>  	if (!dev_is_dma_coherent(dev) &&
>  	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
>  		arch_sync_dma_for_device(phys, size, dir);
> -- 
> 2.43.0

I guess we need this change on top of the above

modified   kernel/dma/direct.h
@@ -88,6 +88,13 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 {
 	dma_addr_t dma_addr;
 
+	/*
+	 * For a device requiring unencrypted DMA, MMIO memory is treated
+	 * as shared by default.
+	 */
+	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
+		attrs |= DMA_ATTR_CC_SHARED;
+
 	if (is_swiotlb_force_bounce(dev)) {
 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;

