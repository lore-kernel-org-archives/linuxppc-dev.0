Return-Path: <linuxppc-dev+bounces-21318-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9E7CD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 11:54:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLmzQ31tQz2xSN;
	Thu, 21 May 2026 21:54:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779364466;
	cv=none; b=hQNRT14dvn6iFOkVtZ1KwWr3Q+Xfj6DArfrKPxyo3YY1nTEvmWkBofwpvCrwzvaTJxabsLqkvfpgPLuJnG0JCltr7yBiyYEGs92k907zZDYyVLEwcg3bPK+ywrx9WQ+J0cvBM+5s54AEvc6FKB6NK1kE6MqCtDVfZzXRAWSrL+QBBKvQRx0NgCTvrpIC9ZJtIeQKfYrl0UjM41pq74fzCxX47JBpBzqi7Es38f2jTsi9sZ+3Bu0DUO6B3eTD1kYbwBt5uP7gy+u+HyFKquftWPxAWI/4lyib6U0UTnXex9gk+ZKNGwg1Z99pf75CKjXIf4MJlkrjlP2F0p7xI/d8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779364466; c=relaxed/relaxed;
	bh=AfaRmOFwq9PG0Q9lB7Y5h4Js0tCrSyooaZYJ9TAjF4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DJvM3o1BTmGruYtsU2gcgj7P/v3+8e79Iy6Hp8qnC5pdqg31P94CfyLQ9wNI+e76JyIJs1Pjj5FBQFjLkHeyBJLcnjBYKBDfI5thdXyLhveraJ2Vsw2EIyBbRYD+ID/azYrRw7duJXjcOUpxp2g8pD/XQ+oxrAJnoNDxyIfd5/sQcGN2fKuae8PIGgqG3hmMSvXcpd/v9Xk/HU/njYB5AaJ7sYv0vk3dUzIbi59073BKZJqQDhE+yvBjgORvqq/vKuEL2AVGUsGyHcYRIzEeBzGEsiwDGY1o5zrnPf/7dhbZ+42R0mOBPYjzwWxSf/dWhUlqdmtFlenUwzMai4AxrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRoV8Obk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRoV8Obk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLmzN4hLYz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 21:54:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5740A437CB;
	Thu, 21 May 2026 11:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60901F000E9;
	Thu, 21 May 2026 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779364462;
	bh=AfaRmOFwq9PG0Q9lB7Y5h4Js0tCrSyooaZYJ9TAjF4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VRoV8Obk6Db2yTrA5yAdD7bmtQFvSWYfd/ZMw0E5GBL5jIdP8p2frzgVjebJ/AI8N
	 hR/ltXnLmqYytDDOSL4NfrAm8WWL6Eapslk7nKLHkiEPTsINTDc/s/wXE5nhOEOkw0
	 ocFPhIherbIJmWmA0TT9aOS8dxo5zor2QipnNUscdwsm508C2EjBqUXMBblgS8bTHy
	 VTwtO3pIzg195ryyporAX+AUffxjuJV03eR50aV96prxY5h11jwtvbWjHvTe3DepXz
	 Q2BR9ERr09ummMuYbcfqyARU4HAkb3n2S7jWp660Rin4hD/1ttPs8n0zhk15N2/FrI
	 IAG1as/hVnwgg==
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
Subject: Re: [PATCH v4 13/13] x86/amd-gart: preserve the direct DMA address
 until GART mapping succeeds
In-Reply-To: <20260512090408.794195-14-aneesh.kumar@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-14-aneesh.kumar@kernel.org>
Date: Thu, 21 May 2026 17:24:07 +0530
Message-ID: <yq5a4ik16krk.fsf@kernel.org>
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

> gart_alloc_coherent() first allocates memory through dma_direct_alloc(),
> which returns a direct-mapped DMA address in dma_addr. When force_iommu is
> enabled, the buffer is then remapped.
>
> Do not overwrite dma_addr before dma_map_area() has succeeded. Keep the
> dma_map_area result in a temporary variable so the direct DMA address
> remains available for dma_direct_free() on the error path.
>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/x86/kernel/amd_gart_64.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
> index b5f1f031d45b..a109649c5649 100644
> --- a/arch/x86/kernel/amd_gart_64.c
> +++ b/arch/x86/kernel/amd_gart_64.c
> @@ -467,18 +467,20 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
>  		    gfp_t flag, unsigned long attrs)
>  {
>  	void *vaddr;
> +	dma_addr_t dma_map_addr;
>  
>  	vaddr = dma_direct_alloc(dev, size, dma_addr, flag, attrs);
>  	if (!vaddr ||
>  	    !force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
>  		return vaddr;
>  
> -	*dma_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
> -				 DMA_BIDIRECTIONAL,
> -				 (1UL << get_order(size)) - 1, attrs);
> +	dma_map_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
> +				     DMA_BIDIRECTIONAL,
> +				     (1UL << get_order(size)) - 1, attrs);
>  	flush_gart();
> -	if (unlikely(*dma_addr == DMA_MAPPING_ERROR))
> +	if (unlikely(dma_map_addr == DMA_MAPPING_ERROR))
>  		goto out_free;
> +	*dma_addr = dma_map_addr;
>  	return vaddr;
>  out_free:
>  	dma_direct_free(dev, size, vaddr, *dma_addr, attrs);
> -- 
> 2.43.0
>

This needs corresponding changes on the gart_free_coherent() side as well.

https://sashiko.dev/#/patchset/20260512090408.794195-1-aneesh.kumar%40kernel.org?part=13

I will avoid making that change as part of this series, since I assume
it would require specific testing.

-aneesh

