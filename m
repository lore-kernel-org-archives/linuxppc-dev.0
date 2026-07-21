Return-Path: <linuxppc-dev+bounces-24594-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEA8C4452F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 12:41:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4H762fzVz2xqJ;
	Tue, 21 Jul 2026 22:41:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784637666;
	cv=none; b=ZZXb06RpGFnXkLq0plxi5eqTiulbqu+5jkJ5CEnnKq8sQ4f/9SgIlgfU/VXN/uCerEJDHSm446SnsctLSeJq3Q1zcwjGTH4oM86FozAIwxcxa+KHj7AjAAdol1Dt80eUKmPlron8VlQ71SxiW5wMHR5ouGL2f+4XhvCy6DOAieRsUY/H1eu112vmXnRKRv1FdB9gYbDOtyRcVwvyyM/SGs0tXlBoudMrxWrMXrvamUd39VE2T51EKHVdMZXXjjFkq2Cny2vMvhWG8WTrGzq/P/PpRzXAROXUEPeV+XoaMgNUSzkecblWmu4cpa8sXC6cX4DkPJW4ZOBFtCMjGxQK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784637666; c=relaxed/relaxed;
	bh=hHR20QdKLO7v/A9MVkG/crlJxAvTVIREme8pDXPWdpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGLgxkQ9UQnjJAuDlgBAA12Iog8yEnOuESf5QmIjuleprd6nfoJrH+kVVLyGWNSyW954yG7QJq5YgBhRF4ge5Lh5SzlEdYEBfR2BiDXA3CmkTH0ocvuMHsIYqFIDBiiCf8kq2ODfPvVPGkZyNQbaoph1av4RxTr8XQ/nbtrrg63P4m1hr9nOXZvFDT8sCqtlj0pjDPjVDOQq4eDg3JRx2wO4lhfPeEi4Br9flpC8i47eyHBKr79PthlFl9Z2AWbv7MGYz0gfY+RHtgs4x5dOVa/TkGqCwWbQWrEE41B1tlJrriG8EaK5BbMkSYy8gHdSE6R0kmcBrrN5lgJmhrClxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAJKKs0m; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAJKKs0m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4H754nDRz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 22:41:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A5D7404B3;
	Tue, 21 Jul 2026 12:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192681F000E9;
	Tue, 21 Jul 2026 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784637662;
	bh=hHR20QdKLO7v/A9MVkG/crlJxAvTVIREme8pDXPWdpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NAJKKs0mp2HmwOSTJulMZY5zyU9KSHD4BEHyX/3KSxaa6O0e2VNfyFDvHcEQrBIUW
	 bd82xmmgnk756BP7oXclO74C3UoYQ1RpyBCIMyFCTPKScXjr6JuhakROp532PhlGii
	 7+tvviJq58faR47mZtEi7AqNFpFYy9IdeQC20flk26Vt7yInq2BpBVQ+uTWDrRFQIw
	 +FUaxo2v+2zrzcANJTXCpP90ZjjCTSjtH3May7B81OOEfG5gnjI+7xflXFP/VICNWm
	 ngwbXG7eIyqM2nFDwd/Nrju8ruvTr6mFAlwtP7QUprRc0YvAWx8z4toMr8/O9/l88w
	 etg8T2ReDZfXA==
Date: Tue, 21 Jul 2026 15:40:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
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
Message-ID: <20260721124056.GK110966@unreal>
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

<...>

> - makes dma_direct_map_phys() choose the DMA address encoding from
>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>   relying on SWIOTLB_FORCE for DMA mappings

Why don't we continue the effort to remove "struct page" entirely
from the DMA API internals?

IMHO, everything not exposed to DMA API users should use
phys_addr_t, including the DMA address pool.

Thanks

