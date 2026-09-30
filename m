Return-Path: <linuxppc-dev+bounces-28585-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAA2CA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:38:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvzhc02b8z2y24;
	Thu, 01 Oct 2026 01:38:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790782687;
	cv=none; b=gKVUpZBqxxsnND0072CJDtmICqrLsg7EFNfmySaNlkM6s28yeHOMhLuiFKSMybGYxn+wgfpiuUT3w/CFNmu6EnxnpfufFE34wesyl/NpfjHQ9Ef/FxMmaqBQA3S81rTruY5KnzCzSRXN5jHa9//aTYL+J8MGH7vNOhoeIvQRyKaXkzRQKP1jYScGECzyksss5gwRajO/MxY6NC74VRpuH8vbMauHmPPtaAq5rg9qKVpfwzYlf+dHPwTqPbNTqcLNhcOm2foNmWXmXGIPim25HVcCDMZQ9xpDfGfmzYgtHUlW4BE1l+NL/d/t1xXmXCz+z/ZNxROZbBZ82v2tLmTCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790782687; c=relaxed/relaxed;
	bh=blz14Kryy333MwsAfcVeWnCS/9nOHGV6aMGIkIjuVtM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3cli/jjcMxQg2JZez3UL0Rubgcy5MeeSK0e2wvMOt8AIncSuPEtw0BItZUuqSCRpNDO6yQcBpD6OIT5tVaCGkOJOfdsusX2N18bheWCFygsae82YiGstNWYJ969clkUMmzitblFOqOs5/mvnr8O9yYbSZF3VsJ6Yo3weKJUiZG26I9CuKwKgbXbfW80SpMNvelOgSm2Y8nWSNFVA4LBbip5qhbouIFRp3srNefqhFblwCWgQY92IThJhsitlAzpQBnVp+Aiaznp8sxjIgkbiYCPhKQhBqF/7wewZqB42IcPxC59WkpyQUDUr+jj0rHeWt7YtubjwW1IEt+jK9e5nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c0KHYMc0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c0KHYMc0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com [IPv6:2a00:1450:4864:34::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvzhZ5RSMz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 01:38:05 +1000 (AEST)
Received: by mail-ej2-x0f.google.com with SMTP id a640c23a62f3a-c2e17e5de00so169161566b.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790782683; x=1791387483; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=blz14Kryy333MwsAfcVeWnCS/9nOHGV6aMGIkIjuVtM=;
        b=c0KHYMc0TmFY+sFMDDvChasFMgCFWzf6XTJeVYSEcT9Cyi97Sji3IY9Mx8D19Atl0g
         dDKeCvIuqoy54qKq1msvA47lbCbIS+l+uN0dM1JIS+0ROlGRvzGBYJGGaiyj80jwCxLw
         w0qSYYfX0hxP8LdWUi9FAoMHZPEA9f+ZFVe9y7gNpyafuuS0/axTvCDpj2dYqSEmDiDd
         e+zf53N5AnMDomwAxaG5k8mei+eyDUMCp3r4XoApk/VyBqodz7EAKztBfIBy9QBBCQHf
         7l7LC/Wx7PFFkuXhZWpQY4E68+lmBR5supl/ovwIwMPGLEDBhqH+r31Sp806zlGfIMtK
         hjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790782683; x=1791387483;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blz14Kryy333MwsAfcVeWnCS/9nOHGV6aMGIkIjuVtM=;
        b=FmorUqTWLwAaPs1Wvho65gTwdZZ2acFZo8TNqqyjeAXEipTsFLCjLzB4/eGCSQbDt/
         HjTulQam/BFQ9C5FpMacMSCrWaK5S332jao9ErcY/XuDNBTlcqmDR94OFUL670MHVyYy
         r5j70sIqjVqekniQOGjnyPs0E9SHJqsGp1Ez0D3gNdWS9iPqW79KC3zf1zDeHxzDaInG
         QpYI3/hXji9yDUyn/0a1N2JAndF2I/sgvSjg8W1TT1tNNIP0wruN6VUycvH/heyPzCF/
         k4+tRkcl/rrKCuD2prNj7jvVCapnIAOoqj8f5EfQvSUa5vk6BIQO+IRmPx5SuRO/RQy/
         lH9A==
X-Forwarded-Encrypted: i=1; AKwUvBxBwy9pbVIhPpjnDN0sA9c3UJ4gJQwdPC7gYlSI9bd2fHksktt8y3FKfGiOs5Pr8cUlC0Y5kcknZXCdONg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nn87JtrxIIQY65fWCF0w+wsJ8DD5soXaMvv8W9NMRjoIGplqeQ
	i7cwZTkCu5413RouEWx/Ko4rfs8V/46LbdPhQopeUOlhHZTCWoHB7MUU
X-Gm-Gg: AYBFou3TR0I9wpoBG7jLka3ZsL4+0eevgKLT2VtCmuXDdQpJYP3yislNXxQjblKzD1m
	r9tMkvqK73SZI3uVBEnPDqE2N/st6blvX9tYD3MQ6duW28JBAzhlczBBUc4an18+sEvs3TB9OwS
	YCjxRwbi3JNIeo2ftviFUuIHkl+kaY7ZE9Q5/aTEF7R+QHG9aUq6kL+mZsfZPrGwxyV7fBrLRoJ
	GdmQrN/oslc15DP1kUoeFg34aXYXRKxHsCUZb2Hw6ykmJFtuqPNw9P7f2qNFvn4rkvvo6RIun3W
	My/BkfDpr64cFiCTAmwokrmQm965vUp5yXisUij53Hm6nVyeUaFZfCp8dbyDzutjyej2Bmzmold
	0LqYrxQy5ywYyXUYCj+OpbdO6ixMOK0WiNTXM2uK/5GrFrO63XbKwibHQoeOQrTZtMXEdCebNOV
	3qumKm4hvAK0kVEfWf0Dy7bClRi2fGPK3zgFNh
X-Received: by 2002:a17:907:9628:b0:c26:24ed:39e5 with SMTP id a640c23a62f3a-c2e23cd72e3mr159226866b.18.1790782682624;
        Wed, 30 Sep 2026 08:38:02 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31a3eb32sm30808366b.3.2026.09.30.08.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:38:02 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 30 Sep 2026 17:37:59 +0200
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org,
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org,
	chleroy@kernel.org, david@kernel.org, dev.jain@arm.com,
	jiangwen6@xiaomi.com, leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v9 05/10] arm64/vmalloc: allow
 arch_vmap_pte_range_map_size() to batch multiple CONT_PTE
Message-ID: <ar0s14p8KPgmDKmR@milan>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
 <20260923062832.479455-6-jiangwen6@xiaomi.com>
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
In-Reply-To: <20260923062832.479455-6-jiangwen6@xiaomi.com>

On Wed, Sep 23, 2026 at 02:28:27PM +0800, Wen Jiang wrote:
> From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> 
> Allow arch_vmap_pte_range_map_size to batch across multiple CONT_PTE
> blocks, reducing both PTE setup and TLB flush iterations.
> 
> For CONT_PTE_SIZE-aligned ranges, return a mapping size that may cover
> multiple CONT_PTE blocks, capped below PMD_SIZE. These sizes are vmalloc
> mapping spans, not HugeTLB hstate sizes.
> 
> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> ---
>  arch/arm64/include/asm/vmalloc.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index 4ec1acd3c1b34..4053b1ec1902e 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -23,10 +23,14 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
>  						unsigned long end, u64 pfn,
>  						unsigned int max_page_shift)
>  {
> +	unsigned long size;
> +
>  	/*
>  	 * If the block is at least CONT_PTE_SIZE in size, and is naturally
>  	 * aligned in both virtual and physical space, then we can pte-map the
>  	 * block using the PTE_CONT bit for more efficient use of the TLB.
> +	 * The returned mapping size may cover multiple CONT_PTE_SIZE blocks,
> +	 * capped below PMD_SIZE.
>  	 */
>  	if (max_page_shift < CONT_PTE_SHIFT)
>  		return PAGE_SIZE;
> @@ -40,7 +44,9 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
>  	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
>  		return PAGE_SIZE;
>  
> -	return CONT_PTE_SIZE;
> +	size = min3(end - addr, 1UL << max_page_shift, PMD_SIZE >> 1);
>
Capped below PMD_SIZE? It is half of PMD_SIZE. Where is that limitation
comes from? I think the commit message should be improved in that sense.

--
Uladzislau Rezki

