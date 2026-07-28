Return-Path: <linuxppc-dev+bounces-24944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9526C54F4C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:26:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8d7934mZz2yjN;
	Wed, 29 Jul 2026 00:26:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785248773;
	cv=none; b=NtF0Uq5srT5w93C+z7hzruCiSBVz0ukSORAT9K7YUnsSGJ5WKEd2W3EJWGglrnG5iRxmWvTna+KhoqIABiJxWTh4Y15SpA6TILUdde9Z6DlBOYiDlPoAyegoVh+ogF9VqIIjjLfwXcTutuu41g1F5N237M3Mpw+uOwiLk53Zg/d/mlENXL4DKtmicnhZJWG5CRv+MAxJymzyg0vG+FQxyQpZDvsPlMcDrYfnBMjsaDcqS5rP30VubCOcP3nH6hWUIIb9wdWS3e1rbIN2OPrw6VQRItcZ7M9LYn3EvoD9HclxtRogtI5VB0YSIYUegaY6mswmALUOsD6t+d6SNZPtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785248773; c=relaxed/relaxed;
	bh=vpWtv0pYfxndfeslGolf2QwgOrAZhpu3GPmCVKvsSLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2iroKBIxpYbk8xo44EMF/JtBLs1lMK4uvPh92STKfCVi2JOnu3oHRqsXD033yseuE4BdfpSkk3BiYi3IZMuC9lu0/PQo0V6v2upgvG0SzhYIp+jEeivzzc5t8jq/feQbYohwNtt5Ij6tp6j9riv6761Uo623idZbSPnHP2Cxzq43s07kznUQGYOgBbBfGS6i5+7El+Ur4r+G+GDtXd84VK1Zp8MT1SmqXI1xWn36VfKW2casQUOirBKy0FAraiKVhJ7q3vCqmWQR7ikwhzwg7rtLIqcsFQbhPql9Vmv4asG9YsZsEgHlx8CyHHAuvcjI9vYZ4vvJbe9AA+1CEm+MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NzDCYhIy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NzDCYhIy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8d783Yhkz2yj1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 00:26:12 +1000 (AEST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so62285e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785248769; x=1785853569; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vpWtv0pYfxndfeslGolf2QwgOrAZhpu3GPmCVKvsSLo=;
        b=NzDCYhIy7ighw0tr58jkkTvDyx4q9L+Vr/2nYQAgS50thAMw6xdNHkdSHg+HFHr5n7
         dIs1s+1AiCCeE41+/swlPGw8/CDsS7wNymiarTCDsV+IVXbMFw1iHoacOdAJEgYgS8m/
         +JSOmhUI9Yc/TaAjv4a01tQFpDEvt0RfTusii1e8H5ZWkwKuxncsjB+hhlIMUG/jmRA3
         3HPneNYAVo0R6aaA+lBB5EdtZP/KCXWivjzFOpev0U/sP5DFWgsaDyCQBQZ6Yr/D7fPq
         DX/I9d46rs9BFJSED7DlCqLw/H2OLjJzSluXzBDn78uQ5U6fI2kd8qnwby8LC6/QhMFH
         cMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248769; x=1785853569;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vpWtv0pYfxndfeslGolf2QwgOrAZhpu3GPmCVKvsSLo=;
        b=U/HY77Ujc8cXMvKf1Bi3kqHjk0Wse+oIZEgFBx/gE0T2eDkdblkBHuPAmJ6RgeZgxQ
         0Ta6filYUIVizDtseRGocRb11HtBAMHrzJn8p+if6oHx4MyXGm5+OnpSfyZn7sdK5DG3
         VXTYXxGGpytGVTh2ArTRigCQXzaFhkg1nct7EXOSUCeaEz5I0re6SRxykqz8Ad95ZyIE
         PhMOsQthi4LQf9hO1cND5RbwCUM5SQj69tkkTfDTfABK5RzyjzQblsQNIZIekb7Fr03a
         tXCFAwfsSWHvGKWy1beXvml+Thrmvl7qnJLJNhc8H4QjCWsmMiDHX2O8LoUkkhAeTO7U
         IiJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJMThZcvjlWNgo4pnyyNt76QPskbxkw/Ad6crM0C7yBF0KWwmNkjmPLdXk0fmy00WEV8IqO2Mhse5UTIM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6mm7aEyB8ub5utUkvRSfsPq939T/KJp1+c7q67oSFQ5fH4nFb
	dCTVYfMnhiUfeYup/JZbLWFb1b/dGFUuzzmhuJCAqPtZ/WfmEFB21EG/d+t+6FxwbA==
X-Gm-Gg: AR+sD12uWz1stKs+8juQqlq644u7GYOsagEazTT0kaArKgEMudgkzAY5fty/NEw9OY4
	VaafL7lmTVWv0u72zTnkVITYuEVHWOXzdPDDELQVe85aK3i0KfZx0wM/vOouhG6XjIh7XaPd3nK
	cdtNj7UXus0XhYGeIpsFdylXmU0rWcZjMeldRK0+fjY7i15HiDM/OJiZZ5eDQ4TWwuAtRQ75f8x
	N+D4lrz/8Ms7BqDXiYcEpG2tkXr4XUFqSVxRqo2b9RLzkApqux20zADEjcYb8VIQebPubUXxBIk
	Rpky2hMWJ3c3CeMvcqCFL9dcrKc5CA0Uy3Ozv9MgvrhFWVO1qpYyTcik2SY38Q9IWRp3yXQ0eiB
	PTV9cp9/O2DTn7PkXXg3ILSEP4S1km3DcFLid7eqf/aeAoyC2eZBV6DcTAmbG2qLFtnveQBt2pE
	C1Bc5voqTteiYriK4RDYei5V5WLtoDhSWLCWL/BWJ6JiU=
X-Received: by 2002:a05:600c:4583:b0:493:aca0:32e2 with SMTP id 5b1f17b1804b1-496b4cf6c38mr21115e9.4.1785248768109;
        Tue, 28 Jul 2026 07:26:08 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm60556481f8f.11.2026.07.28.07.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:26:07 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:25:58 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 09/23] dma-mapping: Add internal shared allocation
 attribute
Message-ID: <ami79lwqbqcaFpqo@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-10-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260717180442.110954-10-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:27PM +0530, Aneesh Kumar K.V (Arm) wrote:
> DMA_ATTR_CC_SHARED describes an existing DMA mapping whose backing memory
> is already shared, or decrypted, for confidential computing. It is a
> mapping attribute: callers use it to request a shared DMA address encoding
> for memory that has already been prepared for shared DMA.
> 
> Allocation paths need a related but different state. Once the DMA core
> decides that an allocation must use shared backing pages, the lower-level
> allocation helpers need to select shared pools, decrypt newly allocated
> pages, derive the DMA address with the shared-memory translation and
> restore encryption on free. That state is internal to the DMA-mapping
> implementation and should not be passed by drivers to dma_alloc_attrs().
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  Documentation/core-api/dma-attributes.rst | 29 +++++++++++++++++++++++
>  include/linux/dma-mapping.h               |  8 +++++++
>  include/trace/events/dma.h                |  3 ++-
>  3 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 123c8468d58f..eee743184acd 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -179,3 +179,32 @@ interface when building their uAPIs, when possible.
>  
>  It must never be used in an in-kernel driver that only works with
>  kernel memory.
> +
> +DMA_ATTR_CC_SHARED
> +------------------
> +
> +This attribute indicates that a DMA mapping is shared, or decrypted, for
> +confidential computing guests. For normal system memory, the caller must
> +already have marked the memory decrypted with set_memory_decrypted(). CPU
> +PTEs for the mapping must use pgprot_decrypted(), and the same shared
> +semantic may be passed to a vIOMMU when it sets up the IOPTE.
> +
> +This attribute describes an existing mapping. It does not allocate shared
> +backing pages and must not be passed to dma_alloc_attrs(). For MMIO, use
> +this together with DMA_ATTR_MMIO to indicate shared MMIO. Unless
> +DMA_ATTR_MMIO is provided, the mapping requires a struct page.
> +
> +__DMA_ATTR_ALLOC_CC_SHARED
> +--------------------------
> +
> +This is an internal DMA-mapping attribute for confidential computing guests.
> +It is used by allocation paths after the DMA core has determined that the
> +backing pages must be shared, or decrypted. For example, the direct DMA and
> +SWIOTLB allocation paths use it to select shared DMA pools, decrypt newly
> +allocated pages, derive DMA addresses using the shared-memory translation, and
> +restore encryption on free.
> +
> +__DMA_ATTR_ALLOC_CC_SHARED differs from DMA_ATTR_CC_SHARED in that it is not
> +a caller-visible DMA API attribute. DMA_ATTR_CC_SHARED describes an
> +already-shared mapping and requires the caller to have prepared normal
> +system memory before mapping it.
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index cc0823a99cfd..a3e880649fa4 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -103,6 +103,14 @@
>   */
>  #define DMA_ATTR_CC_SHARED	(1UL << 13)
>  
> +/*
> + * __DMA_ATTR_ALLOC_CC_SHARED: Internal DMA-mapping attribute used by
> + * allocation paths that create shared (decrypted) backing pages for
> + * confidential computing guests. Drivers must not pass this attribute to
> + * dma_alloc_attrs().
> + */
> +#define __DMA_ATTR_ALLOC_CC_SHARED	(1UL << 14)
> +
>  /*
>   * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
>   * be given to a device to use as a DMA source or target.  It is specific to a
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index 31c9ddf72c9d..9df02c1511de 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -35,7 +35,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
>  		{ DMA_ATTR_MMIO, "MMIO" }, \
>  		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" }, \
>  		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" }, \
> -		{ DMA_ATTR_CC_SHARED, "CC_SHARED" })
> +		{ DMA_ATTR_CC_SHARED, "CC_SHARED" }, \
> +		{ __DMA_ATTR_ALLOC_CC_SHARED, "ALLOC_CC_SHARED" })
>  
>  DECLARE_EVENT_CLASS(dma_map,
>  	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
> -- 
> 2.43.0
> 

