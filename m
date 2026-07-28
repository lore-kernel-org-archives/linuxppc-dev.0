Return-Path: <linuxppc-dev+bounces-24941-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB36CC54F4C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:22:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8d2l0dPlz2yj1;
	Wed, 29 Jul 2026 00:22:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785248543;
	cv=none; b=UJXKgw7gf32geFTcXnkJr9QzF1Tvr36MbsLZ+XhfPDnfTJoxvW1LJD92g1HtGzHzrF7ZvZn6mt8GJ//X6afrlyTjQS3PC3EcKUmWFjJv/Mj3i/bneJJaG0xLz/APsLbE7BvmF1s4kNDdo3jhcGxmdzQsjQak10VAcTVhkr1Pg7xXU6AKsHMkfCdY8qMzZKjojU7NrjjFNWyWVh0ZG9SB3yz2tGLEHMulPXRnxRaSMLcCGJp3pBeUlxk54KCGX0dHGRzR8yuA8EauTz3PMfFSE2p6FCvBNfWQycY/pivJqWaB13W+pSVE57vMSNeIgtUwx2us0aQI/i0AsS1KnvTjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785248543; c=relaxed/relaxed;
	bh=cjI/qIF8COGmEwdyirpRIztZNWL1yf6sjcg+eLvBxKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqDMX5Se4zsST6XqhWPgo1Cep6Yn4CrF5ZigB+os1+Ws2TSOyWch82litKvq1Xk74+qPKvZNsL18Skjp79VKB9yoitK1DuZBPmjo9btFQiIfb0EX3b4JTveEUxCCVEDaGlEGypQyPFjBPdHw/m3oFyLI5Epznkh4tO+ndXxZvL3VfHHd+0Lp/PNPz93cRumd/SMxlqgdMYpZ6ZNRHSeYDnSYLAS9hDjPUIfkeaCEsE7Dc/9u4DkWiNi5r0goKc08tEIfppKbVyG9h8Mfm1wiqFhzNWiQRA/ihs8jVFaH+ynXUUczqlalsgxSX5DZPUKzRk3wyI7WgmYk+Cns5LCV6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lUx68pXi; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lUx68pXi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8d2d3FMdz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 00:22:16 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-495509b08ebso48695e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785248533; x=1785853333; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cjI/qIF8COGmEwdyirpRIztZNWL1yf6sjcg+eLvBxKM=;
        b=lUx68pXix0wtGiYLZpTe0OLDIQXfeVZG3TVTXDJ7G/1i/hJRhS+RXQjwYfdTSTOoey
         Fj28B6UrRK/fnzusHcRa8/jNydh3OuLnanEyp/KWqBlaiTXdemc+OTxsLs24DhaJAt9r
         1ShbGB/WNuk0uCj3DvXnnDQfUOJRJ+o+2hgZwVuuiknEXSUMrJ5OcAW/FlE7Q4c7vyAw
         RIwxXMbJd8UsqcO7ugxqx8dSeMKmsS5AVsBor5nz88iKYteDQ3NS03qPADITZEj0Bjb4
         u0Cbfkzs8FtkUhQdaXTNlDG2RErg/jsY2h8AyUsGa5flxlkYB5aXZrghwSBRyIT0TCDP
         eEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248533; x=1785853333;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjI/qIF8COGmEwdyirpRIztZNWL1yf6sjcg+eLvBxKM=;
        b=DcsqadimSrB6j2Ycf9CEq3s5ykbYyHeSZ13yLm1CNnfFFJD9+83Tlr8OheGDixGMsk
         H8Aa2AXhzCJakzJCf4gvj1vMJN4G9E1gnn7LrGaxbXh5yt4Oeuk6Yhx/CIh9k/jZp6nM
         8hodrZ7G4cl2oWCpnULmJNxQLehjURnIRg5OAUlUCg11nCX30fKzUu9IR6obv2fbJyhP
         GrlTXd+InSlGw0FtyAmC9l40MHucPE8cPbbjIZJ3DpIedgCkkII3US5pb+R5MHJWiWqb
         QuG2YZCoDvIubf0hKvFeGjN4AeLSpFH/twrRiDVUnBdetjK3s4urh8u+9tTQUaP/zTII
         s2og==
X-Forwarded-Encrypted: i=1; AHgh+RpyFdrieQ67cvVDGz3O76Bim6MFsw8y4YmE2NLVlkLMp4NC8kr0SqFWXV7YIxw6mcLBqRkHfrj8mWHPMSg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywh1tDmTpAuWYh8uSa+MfucV0H2/oXwZ6nRDyco80tfIJPGxAov
	AcRGOOksIZInBxqZCHgjzwdDbzKMyOv0jggKrQEqRG0/izm5hV/ZAVCrMCZVldw7yQ==
X-Gm-Gg: AR+sD10O/KO9sYuNLLW5Za9oUE1BXy5+rZCNdSeb+o7Qar357Ah4nhfNK98ljsH/a0P
	Zao/hjZds3hp1rxUNdAkJLX+atPWa8anhbLe05DP7gxBHFuuirCnzgB8jazuLvPGQdmofL3GJ40
	uWlmSK+PDhDTnAyMO9QEUzbV8ypeaCm6sZVI+Opt0aQKEX1TuuzE7fiOWGu1mt2sQIq+S//MbB7
	9oJJsM0TPtBNwLCbliuHhrK6S+wnRoP0/GqVas5iyhhtY2kQCvJavz32rW1fDc1l/pw7c2Vqxnf
	USEdbRW1oh4jbYyXYPCb9wBum7cla0ZIYcVn2TkeWXTJ8S94UfkfMp8ZuWfLZBcMGDhvVTqMG85
	kc0A1hb1hc21Xbl99/9uVlYcUr9BWnYzYXke1Wylnocf6VL3ruEMohXZ75gKHu0uDtdClJ5ZJuX
	eY9+UORgfQeyM3lUwejPSHOmkOPr0eaRCUqhTp0Eg6DXQEPPuEBUn+9g==
X-Received: by 2002:a05:600c:528c:b0:490:ab15:b9e8 with SMTP id 5b1f17b1804b1-496b944f535mr5088815e9.2.1785248532370;
        Tue, 28 Jul 2026 07:22:12 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5a2sm64337943f8f.7.2026.07.28.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:22:11 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:22:04 +0000
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <ami7DMIlYHbcEt_6@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:18PM +0530, Aneesh Kumar K.V (Arm) wrote:
> This series tracks confidential-computing shared DMA state through the
> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
> DMA buffers are handled consistently.
> 
> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> shared/decrypted buffer handling. This series consolidates the
> force_dma_unencrypted() checks in the top-level functions and ensures
> that the remaining DMA interfaces use DMA attributes to make the correct
> decisions.
> 
> The series separates mapping and allocation state:
> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
>   mapping. It tells the DMA mapping path that the DMA address must target
>   shared/decrypted memory.
> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
>   by allocation paths after the DMA core decides that the backing pages
>   must be allocated as shared/decrypted memory.
> 
> The series:
> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
> - teaches the atomic DMA pools to track encrypted versus decrypted
>   state
> - tracks swiotlb pool encryption state and enforces strict pool
>   selection
> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>   DMA attributes
> - passes DMA attributes down to dma_capable() so capability checks can
>   validate whether the selected DMA address encoding matches
>   DMA_ATTR_CC_SHARED
> - makes dma_direct_map_phys() choose the DMA address encoding from
>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>   relying on SWIOTLB_FORCE for DMA mappings
> - use the selected swiotlb pool state to derive the returned DMA
>   address
> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>   guests, and s390 protected virtualization guests.
> 

This series has been getting bigger, going through it again, I see
that patches (1, 2, 3, 4, 5, 16, 20, 22) are not really related to the
shared DMA work and are either fixes for exisiting bugs or clean ups.
Would it make sense to have those separated?

Thanks,
Mostafa

> Dependency:
> This series depends on the pKVM changes posted at:
> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
> 
> Please merge this series only after the pKVM changes above are merged.
> Otherwise pKVM will be broken.
> 
> Changes since v7:
> https://lore.kernel.org/all/20260701054926.825925-1-aneesh.kumar@kernel.org
> * Rebased onto dma-mapping-for-next
> * Prepared the series on top of the prerequisite pKVM changes, resolving
>   conflicts so it can be applied directly to the pKVM topic branch once ready.
>   https://git.gitlab.arm.com/linux-arm/linux-cca/-/commits/scratch/pkvm/testing
> * Added comments documenting possible follow-up improvements for CC_SHARED
>   atomic pools and physical-address-based pool freeing.
> * Retained virtual-address-based pool freeing when
>   CONFIG_DMA_DIRECT_REMAP is disabled.
> * Applied pgprot_decrypted() only when expanding a CC_SHARED atomic pool.
> 
> Changes since v6:
> https://lore.kernel.org/all/20260604083959.1265923-1-aneesh.kumar@kernel.org
> * Rebase onto the latest kernel.
> * Add __DMA_ATTR_ALLOC_CC_SHARED for allocation paths. DMA_ATTR_CC_SHARED
>   is now used to describe the requested DMA mapping address attribute,
>   while __DMA_ATTR_ALLOC_CC_SHARED is used internally when allocating
>   shared/decrypted backing pages.
> * Report CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>   guests, and s390 protected virtualization guests.
> * Add CC_ATTR_HOST_MEM_ENCRYPT and swiotlb=force fixes.
> 
> Changes since v5:
> https://lore.kernel.org/all/20260522042815.370873-1-aneesh.kumar@kernel.org
> * Add Tested-by
> * Drop the pKVM patch, which has now been posted separately:
>   https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
> * Remove the DO_NOT_MERGE tag from the s390 change.
> * Add a patch to drop the SWIOTLB_FORCE flag.
> * Rebase onto the latest kernel.
> 
> Changes since v4:
> https://lore.kernel.org/all/20260512090408.794195-1-aneesh.kumar@kernel.org
> * Add new patches based on Sashiko review:
>   swiotlb: Preserve allocation virtual address for dynamic pools
>   dma: free atomic pool pages by physical address
>   dma: swiotlb: handle set_memory_decrypted() failures
>   dma: swiotlb: free dynamic pools from process context
>   iommu/dma: Check atomic pool allocation result directly
> * Include pKVM and s390 changes as dependent patches. These are not yet
>   ready to merge and are waiting for subsystem testing feedback.
> * Drop the AMD GART patch because it requires wider testing.
> * Update swiotlb_tbl_map_single() to take attrs by reference.
> * Switch swiotlb_free() to use rcu_work.
> * Avoid calling swiotlb_find_pool() multiple times in the free path.
> * Make DMA_ATTR_MMIO imply DMA_ATTR_CC_SHARED for devices requiring unencrypted DMA.
> 
> Changes from v3:
> https://lore.kernel.org/all/20260427055509.898190-1-aneesh.kumar@kernel.org
> * Handle DMA_ATTR_MMIO correctly in dma_direct_map_phys()
> * Address most of sashiko review
> * Rebase to latest kernel
> * drop SWIOTLB_FORCE for s390 and powerpc secure guest.
> 
> Changes from v2:
> https://lore.kernel.org/all/20260420061415.3650870-1-aneesh.kumar@kernel.org
> * pass attrs to dma_capable() and update direct, swiotlb, Xen swiotlb, and
>   x86 GART paths so the capability checks see the DMA address attr value
>   DMA_ATTR_CC_SHARED.
> * rework dma_direct_map_phys() so DMA_ATTR_CC_SHARED selects
>   phys_to_dma_unencrypted() while the default path uses
>   phys_to_dma_encrypted(), with swiotlb fallback when the requested
>   shared/private state cannot be satisfied by a direct DMA address.
> * stop relying on SWIOTLB_FORCE for arm64 and x86 CC guest DMA mappings;
>   swiotlb is still enabled there, but shared mappings is now selected
>   through the generic dma_direct_map_phys()/dma_capable() decision instead
>   of a global force-bounce flag.
> 
> Changes from v1:
> https://lore.kernel.org/all/20260417085900.3062416-1-aneesh.kumar@kernel.org
> * rebased to latest kernel (change from DMA_ATTR_CC_DECRYPTED -> DMA_ATTR_CC_SHARED)
> * update the alloc path so DMA_ATTR_CC_SHARED is not a caller-visible attribute.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mostafa Saleh <smostafa@google.com>
> Cc: Petr Tesarik <ptesarik@suse.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: x86@kernel.org
> 
> Aneesh Kumar K.V (Arm) (23):
>   dma-direct: return struct page from dma_direct_alloc_from_pool()
>   dma-pool: fix page leak in atomic_pool_expand() cleanup
>   iommu/dma: Check atomic pool allocation result directly
>   dma: free atomic pool pages by physical address
>   swiotlb: Preserve allocation virtual address for dynamic pools
>   s390: Expose protected virtualization through cc_platform_has()
>   dma-direct: swiotlb: handle swiotlb alloc/free outside
>     __dma_direct_alloc_pages
>   coco: arm64: s390: powerpc: Mark secure guests with
>     CC_ATTR_GUEST_MEM_ENCRYPT
>   dma-mapping: Add internal shared allocation attribute
>   dma-direct: use __DMA_ATTR_ALLOC_CC_SHARED in alloc/free paths
>   dma-pool: track decrypted atomic pools and select them via attrs
>   dma: swiotlb: pass mapping attributes by reference
>   dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
>   dma-mapping: make dma_pgprot() honor __DMA_ATTR_ALLOC_CC_SHARED
>   dma-direct: pass attrs to dma_capable() for DMA_ATTR_CC_SHARED checks
>   dma-direct: Move dma_direct_map_phys() to dma/direct.c
>   dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
>   dma-direct: set decrypted flag for remapped DMA allocations
>   dma-direct: select DMA address encoding from
>     __DMA_ATTR_ALLOC_CC_SHARED
>   dma-direct: rename ret to cpu_addr in alloc helpers
>   dma: swiotlb: free dynamic pools from process context
>   dma: swiotlb: handle set_memory_decrypted() failures
>   swiotlb: remove unused SWIOTLB_FORCE flag
> 
>  Documentation/core-api/dma-attributes.rst    |  29 ++
>  arch/arm64/mm/init.c                         |   5 +-
>  arch/powerpc/platforms/pseries/cc_platform.c |   1 +
>  arch/powerpc/platforms/pseries/svm.c         |   2 +-
>  arch/s390/Kconfig                            |   1 +
>  arch/s390/mm/init.c                          |  17 +-
>  arch/x86/kernel/amd_gart_64.c                |  30 +-
>  arch/x86/kernel/pci-dma.c                    |   4 +-
>  drivers/iommu/dma-iommu.c                    |  20 +-
>  drivers/xen/swiotlb-xen.c                    |   8 +-
>  include/linux/dma-direct.h                   |  20 +-
>  include/linux/dma-map-ops.h                  |   3 +-
>  include/linux/dma-mapping.h                  |   8 +
>  include/linux/swiotlb.h                      |  25 +-
>  include/trace/events/dma.h                   |   3 +-
>  kernel/dma/direct.c                          | 326 ++++++++++++++-----
>  kernel/dma/direct.h                          |  56 +---
>  kernel/dma/mapping.c                         |  25 +-
>  kernel/dma/pool.c                            | 237 ++++++++++----
>  kernel/dma/swiotlb.c                         | 292 +++++++++++++----
>  20 files changed, 810 insertions(+), 302 deletions(-)
> 
> -- 
> 2.43.0
> 

