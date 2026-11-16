Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0379606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 19:28:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSyb205SSz2xcB;
	Tue, 17 Nov 2026 06:28:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.175.24.41
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794857325;
	cv=none; b=MpKxybYnKiM43eqmVqGDcWN43lq82S0jiGETF6g7RjqwsZIhmQMgNTYSjk1qDw9vEuOoPpJIztWo9lqgcQRVx3WTecAMFfZ95uxqewdlTiHEslwyAsgVabw2DlisJi77klF2b+1mG4Z2zF4TmwiuBHz5NzH2HDMYvsUpCtIZlSnB44XJs5NLfyQRs4kAH4TeXSkzanUv2QsDVLaQp/dPWBbaeTI/SpyRSK8KiUqQuEjAmXIdnAF+8OiWLx7Old2FcCuIaYeWL9p7BAaQFMy2UEqt7QQEAVVHOd5/lMEsJstCjpH1WPz4L5UBd/L8oPlu2cgYA/uIaEM3GBhTuP1hew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794857325; c=relaxed/relaxed;
	bh=G2OFv8TROnxnOwOkrogXO7YHSz0S+Zpl86NxGZaLyck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyY9aj6H0fgHIcApGDF9v1IMe4dbahVx5/yF0Bh/IiXvoYptsg7cA/kv4FbzIViB9PDzIR8SHaOTMT4DUBHBMQxs9KnyRIBIFo0tLtPMJn4R7s5WhZTFJKV/gPE7TQQ6oQfSsBHeuQB6EODK3BNXuO5Dv6++1dRTNt1unUhJr3aGu41RpXHwR/D+uRiot65MdCT8AvQnoJ8M6qHZ5fR/N6b9bHlKjIIwEnFcIWPcSNO+lxKMIpY8XZemV84SdukhYi/FhqOldWCXC2Y4/egGFLxyTX9tJz3DcIwc1p3TqkKl6GjzXxiU2JepS6ra7oetDx3WQuV22TzG79TJW/mgCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass (client-ip=193.175.24.41; helo=elvis.franken.de; envelope-from=tsbogend@alpha.franken.de; receiver=lists.ozlabs.org) smtp.mailfrom=alpha.franken.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alpha.franken.de (client-ip=193.175.24.41; helo=elvis.franken.de; envelope-from=tsbogend@alpha.franken.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 1241 seconds by postgrey-1.37 at boromir; Tue, 17 Nov 2026 06:28:44 AEDT
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSyb01PLqz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 06:28:44 +1100 (AEDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1xT23R-00068K-00; Mon, 16 Nov 2026 20:07:49 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id E4AEFC01AA; Mon, 16 Nov 2026 20:07:39 +0100 (CET)
Date: Mon, 16 Nov 2026 20:07:39 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 3/7] MIPS: mm: handle highmem pages in
 arch_dma_prep_coherent()
Message-ID: <avtUe_ryNhYYGz4A@alpha.franken.de>
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
 <CGME20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be@eucas1p2.samsung.com>
 <20261110094830.2081847-4-m.szyprowski@samsung.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110094830.2081847-4-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 10:48:23AM +0100, Marek Szyprowski wrote:
> arch_dma_prep_coherent() performs the cache maintenance on the address
> returned by page_address(). On 32-bit MIPS with CONFIG_HIGHMEM the kernel
> uses HASHED_PAGE_VIRTUAL, so page_address() returns NULL for a highmem
> page that is not kmapped, and dma_cache_wback_inv() then operates on
> the virtual range starting at 0 instead of the buffer, leaving any dirty
> cache lines of the buffer in place.
> 
> Highmem pages do reach this function: dma_alloc_contiguous() can return
> a highmem CMA page, which dma_direct_alloc() handles by forcing the remap
> path and calling arch_dma_prep_coherent() on that page before creating
> the uncached mapping. Since commit f5ff79fddf0e ("dma-mapping: remove
> CONFIG_DMA_REMAP") this path is available on all MMU architectures,
> including MIPS, which previously rejected highmem CMA pages.
> 
> Fix this by reusing dma_sync_phys(), which already handles highmem pages
> by mapping them one page at a time with kmap_atomic(). For lowmem pages
> it does a single dma_cache_wback_inv() over the whole range, so the
> behaviour is unchanged there.
> 
> Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/mips/mm/dma-noncoherent.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

