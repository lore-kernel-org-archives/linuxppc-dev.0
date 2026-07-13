Return-Path: <linuxppc-dev+bounces-24144-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4C1C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:41:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXqz5P3Sz2y1F;
	Tue, 14 Jul 2026 05:41:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971695;
	cv=none; b=a+Z73ONf68BFYpjDStqpxLcTMmBseg5r+oU5EmmJjQZ1OqA0lZvFTe12vs59zqW9oyDKMC3VCJZAFijMirJQTTZ92dJ7dAqnnN3nM2uerar4suzJqyCnSe9fFiEFOMQf2s2sBmNuTWMT+L2Lebl7tfqiXTpNyzALodaMH672dF0mIU0+Acx9yzeZKNoHIe+2PpS2AKnSIX+ib6Qx2Pfy7gRNJoGhCFuhraRg+GTxTuWQvH5VxHsXXykGZS/1mmfifbGV6ZPRSY9ykS+PKPpAX9zpyP3psmC2cPSxPDYhqqLIz4c7VwGTZi2vWKEWHqhI4ZDEKKuq1Ye39aNQGKMg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971695; c=relaxed/relaxed;
	bh=RaFiCRG6TDd5hbIwyaOKkhGT65gZ81YsG2fbaxJfaHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5X3TKW3biSwf2z/+MZ7/tOajkxO1mWFga1hfrgM4uuInBU8qRhNBNX0xGbHrCuUi5mCXdpICLzaefs0bPNYgqn6wjW5KhSaFqYl9uShXKPV/+/oa9wVLmzxknznTGHJaQz1lYAwxuqcEMQxrTtQvwJr1H3ApznElL10plaOeSvBEZa3OtdsdouDuAjoPNO4HDnRObceELP3GqS2Pnuq4zcp57Q9E3/RG/1HrwQNC4sMJNwv1kQLsuOMFLbOsp6aAvGJUNmZdgbiCT549MA9qPZAAiNJtcUX2ngw2hPUJmciCsjRFxbA1dF8T25goyRBBA3W2nOvZyTf+HH02yRqUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=IlcfvVYz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=IlcfvVYz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXqy73nbz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:41:34 +1000 (AEST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-51bfb91795eso29201871cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971693; x=1784576493; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RaFiCRG6TDd5hbIwyaOKkhGT65gZ81YsG2fbaxJfaHI=;
        b=IlcfvVYzAy4LKWkoPJPeBBsp9LaAJUodDLDWhjnmfS0qUL71nndhlFX98N9ZhBnCxf
         XI4bf1jDDzAhld2OCelEPs4jlhPuPEm3s1t2BV4+kBJunCAhQB1OmnyVw33DVF+dD8xU
         dWCAQsaZMn4kx4BUhkYToGXjn73sxJPZR5cmQs6LAJuSyY+r8/zWcBmuS/fJ+ijccKV1
         /z1YDrkNkIGukFLlrFv8F0o7ne1ZlXfT2yA2TfRqCuJ2Oj2T1DlSJFBQXqX10Qk2MoWV
         nYsPKn1+WR1glHi/KJTZsPLY8LLiJunQzB60YdodL3xxlftnAwEh4lX9i0hHCXx+0X1a
         00eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971693; x=1784576493;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaFiCRG6TDd5hbIwyaOKkhGT65gZ81YsG2fbaxJfaHI=;
        b=a/XyDJeCP/U8HZT565IRwwFL6ZXihRN0ZK8Bnq20FCKzZ1ZQTpDJUw00TXSqexFok+
         f+p10xAqfNIHlh/40Zr9ctFwOAGAzWBzed+WD7IsZS3p/6w84QN69ExMPfGzdMCoWcEZ
         RqXgfryF74FlSsvepdZa7v2Vf6MRDZL0tHWCYa9LNr8DssGs99ys8gBftI1UcCTkjyIq
         LoBLmZs/a3OHrPsCYB8cBNC1Sa2IQA1zhpmKkDg7ukkKCd7OuiITMl7mNHQ/Gy/Q7Ov2
         CDNpJA/XtlOfPzdnquMplWDcBrVU6Ph+Wljfe7jB1aAl4+1mPrd9LJmmoQTauct8o1+A
         GpsA==
X-Forwarded-Encrypted: i=1; AHgh+Ros1Z9kaoVLmiJHaK6yji5fXnSTQPQ1OlCFASOkrig+knwiPJDOonq/n4LGR3ksjV0RIybxchuJP4ZVWiM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxjhvfS4B5LSLWVT6ZcUVOLTwd/U2e5hvA3gMRBKfwBPhjecZEA
	fbOLPCFqQHkMxUcDZYtQ5WOinS5E5QrEJAZ8k/crYlQZlkb7XH64STAWw0kgacsVTTE=
X-Gm-Gg: AfdE7ckXemY2PlNeMWSWyfJRdKKIYCrdDkU0XbvdRyC7vzzjbNYE+CZlKl7oTN9+8lN
	oqTt1FwAg3YweabDeZDOAQDkT+TWleXt1X82td4mOsknpWzUXa6GZ2ZS8o3LAZB3pdw4j2ZZ5xT
	h5Asd///kRU7GuXcrEUyLeuD3bnmS9CK0849ZV0kTmaZpTnqdWSJKuiFTxPwwIeUtH2mgM+0WQG
	yWKRVTsPSKAyippvjDyS37mOrlG9HXUABQgThv+NIWINMNRy5bi0AvsrBC2Hh8JY+sly9zF5FaM
	2M84oTGmzrAr97W4hiJSQEazyqBCuGJBFrX6M10aE6478uoN0YXkEFzVpTf8EuqGrpukbuBAhHW
	xBzl9nFh6RN0M9b2vbBIOolcpV0fUuB2kXweVptHVEIajIgos5+fIltGplwSQ
X-Received: by 2002:ac8:5fcf:0:b0:517:8711:d46c with SMTP id d75a77b69052e-51cbf0f3fa9mr100726891cf.31.1783971692761;
        Mon, 13 Jul 2026 12:41:32 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b44sm90213801cf.30.2026.07.13.12.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:41:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMWx-0000000E6nC-2kaU;
	Mon, 13 Jul 2026 16:41:31 -0300
Date: Mon, 13 Jul 2026 16:41:31 -0300
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
Subject: Re: [PATCH v7 20/22] dma: swiotlb: free dynamic pools from process
 context
Message-ID: <20260713194131.GZ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-21-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-21-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:24AM +0530, Aneesh Kumar K.V (Arm) wrote:

> @@ -840,7 +843,7 @@ static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *pool)
>  	list_del_rcu(&pool->node);
>  	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
>  
> -	call_rcu(&pool->rcu, swiotlb_dyn_free);
> +	swiotlb_schedule_dyn_free(pool);

This knows if the pool has cc_shared memory in it since there is now a
flag tracking that? So should the work queue version be conditional on
that flag?

Jason

