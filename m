Return-Path: <linuxppc-dev+bounces-24130-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0408C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 18:11:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzVqY1xtmz2xPb;
	Tue, 14 Jul 2026 04:11:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783966265;
	cv=none; b=II1hpvuuDvkuirPABKbEEXXtx9q5AqhmnDWfn4W4m2wXTk8h2pobxZwJHZcBqGAgMNHEEq3Pi8f3IGDapxJvAPm6Ep7pEH5CE5a4bsNFHbfbClEkC7KQqPfZHbpKPLhvUhbRvzl5S9xzdYPSD1JsJ95abj8gb8BC5o02rLe/kekQmmZH/i6wq+MmPpKvhdhSbtc8B5NZQVfeVUaURMPwbtszzMpobgh1mycM1ipr+VQEVdXl/0kwdyhPXEDLBCwm6hD+3K5Q93i9Ll1SIz4Gn2RB5ivoTFWvOI9o4t7I0CZrk88rJX0ipTs5rixonCRfFpD413DPalelcwbrpY64lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783966265; c=relaxed/relaxed;
	bh=r3LqUwIJYp9NQ4diqGbAZyVDrYnzRQFmiULYhYdIqPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeFfIQDG94SDpGOabE4Obp6B4csFCQuISZTM0FI7KaU+M80o37Qc2RofFTwIokL74c55EMAQDfSIphwcQ8M/EeiiZdMIc7n0SV/chhT03RTlKVe51VWs8Jw8oUxwcwXXZnl4fflSfwV1a6kbPISfl5SHnkMfFNPy5bSwZUtpsQH/8jxR3tH2rGz30F+SqcsIJb6axVzshN8SCy1cUTqUBfKTEEvS3ogZCujuDcxAjX0rLp3b/gKBawqEoJenNSedvrNXOPoMQ/l/4+VgePovf5D1xOxqsCiL8ZBPwJ2Ya05HlG1fiptjQXRA6xJtgf190h4ZdAEuKWU0BvNNhaENAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LpF6/apF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LpF6/apF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzVqW6yYbz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 04:11:03 +1000 (AEST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8f29ec73064so28772876d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783966261; x=1784571061; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3LqUwIJYp9NQ4diqGbAZyVDrYnzRQFmiULYhYdIqPw=;
        b=LpF6/apF/7Fq7CZn24uowV+w0RERLPraAe4cjUX++5rvcAO6fQ6eaa14PbPPl0JCOt
         ySAUeUIGxJGPq2xxS8N7LDEgoHJion6szDC8apL1JyYz04vrrX8ct9HSPATFa1/Y7Q/P
         9KlM1jqVa8cZZRvd4Kqx/q35vvgqi5u8meCn2hd6eDC1cdOf7JgInTG+5ILPFBax7YZ4
         Kuc5Z8kBEomlEpyYbzReRUzxMiYWCnNLv5797Tk7CPYitmzlW4qGZd72vaxJnSZc4BcW
         tPgqUlFTvhkfSHZaj68EQmsExYkVNyu3JhWQI6sjASZrq0lOHv1QkpqtJsreBqS9wbOh
         HElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966261; x=1784571061;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3LqUwIJYp9NQ4diqGbAZyVDrYnzRQFmiULYhYdIqPw=;
        b=qScV4lSzQ6cE3/JwxOidJGD/ntbqApd68TV70ltU97+qX9U0JdGg1xi0hFSnuNKmk7
         75dX6oA6T6nfHBXRiIekY44pf3SgFTYJoO1PNDy02FIbEAOAkfdeSb2c3nHM7nZ1DUpr
         +p0OxAuJyqUgdGG65vSxWiIM1VMZXTL0SDuh8F1WyifoSaaRA6CQgqdydF8DkL0OfX8N
         /iUrVABwO9m0hIe5cUzGcKrlAgu/xT7mZYRiBeR+FeANewlLlZqu3EM0sxiIyE0iEbXV
         bdKBM1LlE8AT+nBdzBsK9rnx6xyF6wICrYEwe3Lm+8Rtu85l0PzcVQcu+69PYqVJNABF
         Gweg==
X-Forwarded-Encrypted: i=1; AHgh+RqBe3MSTqwaVkan+fusdQZbgrBakNpTPZNMLvpjlsomhs8+A3wRtcP9NHL7eUUUnWs23GSJ9MobREnoGKI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwobJof1ki1Jf8W4XfOWo6jPd4vAngCAk4XV7rBzEFSpNHefCwS
	mPtDF1t1iOKHa7ivm6h9zK2jMFBz0gZZh6/38xskiRzY+10Em7JyIqIdJORC59hFhPY=
X-Gm-Gg: AfdE7ckR9UZ53HtdiPSYUGpsP1qD4hubjXMoM7gIMmbqffOFEtIVhLAv29Jg6XVQrx8
	GCHXgeIlcCBURu7dMhGWtu67cM9E553IVjTx5jlvlq1R1/yyd7a5Y9lmOA5Kmpzwl5CRtDRxX+Y
	RL9/28zRoSbTt4udmQLQ9bVSC3gg+PeVzSNK2Zz7pNnWlvQxmUqYutkuZl/CelWtbzgBzsNGB9I
	TU4nhLo0gnaHZDxerdRHsKtOWlm0HFmiPS0bVJQw4OHPNoPLC1196y38yanyuXN1lizu9n75PQZ
	SrlaB6YHV89ZTfB1bhfypWIUOxBjNtw3VgpPyikofAxqpDoE6gnFHGoANCf497tNPb6VVDbo+KV
	pAqZdoxYUySTnYA8dOXW0J1KOzxi7XcMKkTKzO78yNobP06XhPemTcyH1vQPm
X-Received: by 2002:a05:6214:601a:b0:8f6:8677:7ea5 with SMTP id 6a1803df08f44-90402c68ee8mr99154096d6.37.1783966260999;
        Mon, 13 Jul 2026 11:11:00 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm135284216d6.21.2026.07.13.11.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 11:11:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjL7L-0000000DyOu-42Rk;
	Mon, 13 Jul 2026 15:10:59 -0300
Date: Mon, 13 Jul 2026 15:10:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
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
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 04/22] dma: free atomic pool pages by physical address
Message-ID: <20260713181059.GL3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-5-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-5-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:08AM +0530, Aneesh Kumar K.V (Arm) wrote:
> dma_direct_alloc_pages() may satisfy atomic allocations from the coherent
> atomic pools. The pool allocation is keyed by the virtual address stored in
> the gen_pool, but the pages API returns only the backing struct page.
> 
> On architectures with CONFIG_DMA_DIRECT_REMAP, atomic pool chunks are added
> to the gen_pool using their remapped virtual address.
> dma_direct_free_pages() reconstructs a linear-map address with
> page_address(page) and passes that to dma_free_from_pool(). That address
> does not match the gen_pool virtual range, so the pool lookup can fail and
> the code can fall through to freeing a pool-owned page through the normal
> page allocator path.
> 
> Add a page-based pool free helper that looks up the owning pool chunk by
> physical address, translates it back to the gen_pool virtual address, and
> frees that address to the pool. Use it from dma_direct_free_pages() while
> keeping the existing virtual-address helper for coherent allocation frees.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/dma-map-ops.h |  1 +
>  kernel/dma/direct.c         |  4 +--
>  kernel/dma/pool.c           | 54 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 2 deletions(-)

This seems pretty suboptimal?

If !CONFIG_DMA_DIRECT_REMAP then page_to_virt() was used to compute
the genpool's addr so dma_free_from_pool_page() can use the same
logic, which is how things must be working at all today

The CONFIG_DMA_DIRECT_REMAP scenario does look broken, so I'm
surprised there isn't a Fixes line on this commit? I don't have an
opinion on the search, but since alloc_pages() is used there is 8
bytes in the struct page that could be used to store the remapped
vaddr to avoid the search if someday someone wants to improve
this. Maybe a small comment hinting that direction would be a nice
addition.

Jason

