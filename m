Return-Path: <linuxppc-dev+bounces-22352-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67ABCD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:47:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZWwm0vnpz2ySf;
	Wed, 10 Jun 2026 00:47:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::736"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781016472;
	cv=none; b=DBDcY1DBOK0Pi9g9kEgHLroGhc+3T8N+P7I2c+fNEuUVWDWn29tuiXHFU0Ek57WHWgQiG8/OZCMNXE+tXhGn6lZRYuYZCZVbIbdDBINTNepAyQ5EuZYdlDUyxWOtfo16VKP/W8w0K/P+t1rtHVjrDJ5K2xP/tNlosFvGRVUZx7P+xZkdzpWn2qg4vvlnrfbaeJtzr5B0laqp3iEKe5cKpc0X6Cluz02XZJ0mnFTI5AkJ7O3oZ5FjKo6yWmRxHFCYDUfj1U9HkMzeI5wiYwvbDAfsRdQQYdENer0sYbCPovA7XsszqdMFA6CRCNsxoblW861eqcQt58JUrXu47riO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781016472; c=relaxed/relaxed;
	bh=jVABLuHAzbvMd8rLAYuqriN8lpaGXdnOhBwKXzGn2mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnMBT8IgNo05FjpZzrVg8KpySf7HmIasU5qEmAUMhuOG9pv94z7XKyoUi+CiRehVjNQGx2x0A+ZYwQFU03OgWqibW3yX7iU4JqCuInctDy9oKiUkHi7wjn16JvUypgQ2PbX49oFxRTLk3eiOWFJTv1BTYsa9iovkqT1fO0fdqBdCappG8OkOuQH68DNULVNUPvT9Wpk7BOZLbhmJFUD6OqnewSsdc8Z/YL9xOde8G+wB1yN+uFzUe0F3NHXTeZp5GSgvCOZUruqbGEiFrsAFk+kkltM3PQZ8joS6DGHz7VhTbNueoFqVU+cxK/SYzbCkONynEQB3rj7obsqYzf7fmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gPIqf/G4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gPIqf/G4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZWwk75PNz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 00:47:50 +1000 (AEST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-9157d3f2098so673000285a.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781016467; x=1781621267; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jVABLuHAzbvMd8rLAYuqriN8lpaGXdnOhBwKXzGn2mk=;
        b=gPIqf/G4zsajDzdU9DUvznRqK4JqPKWEDA38FnsbO4/XHnWQA2vMSSrNdGOMw2KUil
         PdxJ4UTlFtbOh4VJAG0WiOR8xWR2aqBkvmbkzRUIKTnnIcTu967a3T28aRGw47ibQdd9
         JlvVotk4OD86pWZ45RvAyN49N7X8CpP1HlfQsE8E4mb2mQGgzNhiRQvxCpmNwgv9/4q2
         bWbequ4K4Ep+71n97exlatp9SOIUo//vBFNawKppi553oljLvDvVeMIZwbXiaW+WPCnP
         Zg5ziCrQ4s2vpUtybF+ks7VL1I/eRGk7nxV64OMxYM5nxApou9fhaHPa0q3K3M375RCS
         zHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016467; x=1781621267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVABLuHAzbvMd8rLAYuqriN8lpaGXdnOhBwKXzGn2mk=;
        b=QYg8hJU7YaNyqaT8R8QAegsRNNbg2JGK6JL0TwRSwGhSqW9fIrxmYZHtI7SPByMfTQ
         rmcrSLpaOYn5KoaAr4if3X2QqWZ7a4bmix02Vb70LdNunon9jS89EjYVQJs1R4LHRmvj
         hu+7yoH736pm1XyIelulGFbqWyBonPbOAt/R66ObgfN/53aJKmRsSKMiAmhX1DPRfXL/
         NOZ1+41zOJHxhv/iK4zvXsffDKcegZ/cyQTijmOrEz6Ucbj73JCiT1tKxfMtKyII62OL
         d3Jc6iDHIREIFJ/Gsm9SBwQRaDtqny3dg76MoAZII0kT5Dg1N5iPMj3oGVb+fHwADwxJ
         /8NA==
X-Forwarded-Encrypted: i=1; AFNElJ8LrFDe5ESxjIqEvWZpoE0JwMJzh4ud/lneukubL95srUkklUt5zJ8GoCgQpPIEAVkP4d0IFTY5ybF0714=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YySsDRgFTfJH84ctYbZHn+JMa+qvwFjwIWZSJrHhqZWD9itXkv0
	kg+zK2NQw2VJrEgFvTLcKorFKRsNdXiH4k0rBEEneqOh6at+bHhXuv95317i5FJn8Ak=
X-Gm-Gg: Acq92OEwz48m0BLL+qKSif7qPwNajdkkzFbimMCX5lQQFDlit5nzjJClNnkaQGsd3mh
	Zb/8sPoE59T16B+eHZkL39luD111szeye/vggybC7xIBjBXf6QXttavLyNlL4wYbI+91krlDzLk
	E4A/mPk0jxWfiJn8e8mw10MofJ7jD0X7anz3XQoEQxGhOPndFTUtFQxOhmioe3GatBQWVHblVHb
	D2skicOtmpMAKOoxk6EEBM8pbmwNbF5k5jRcQAJuc74aKfc0aGRWp9hmVCK4GBy6Kd1Ofp6caH8
	RSQo+kePJos88LgMLOEC5/A2slgTELBc14NxlUWjFT3XU5Q5PSi/Ue6Wu9hDHNrEC36GvDQJafz
	KoeAcn+S4+uQ5qOH7ulXzdZ02uN/WrJXgvSa6cRQCHeojI1UBgImn89gqUbWsKovfhtUNYe9/w1
	lw+DGxFzA4B4+O+CFz7+6lgsAlz5paJ6sigFq5+GGcfm5OzFH5OkV4ix7/WoTXlCGrAROpA+RbM
	IsSMzBr9rvhwgfZ
X-Received: by 2002:a05:620a:4886:b0:915:9efe:6dd8 with SMTP id af79cd13be357-915a9db8256mr3196001885a.42.1781016467473;
        Tue, 09 Jun 2026 07:47:47 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a411333sm2254245885a.46.2026.06.09.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:47:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWxk2-000000025BT-2DH0;
	Tue, 09 Jun 2026 11:47:46 -0300
Date: Tue, 9 Jun 2026 11:47:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260609144746.GL2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
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
In-Reply-To: <aigYbK12D8uKQvJF@arm.com>

On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> > dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> > are handled consistently.
> > 
> > Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> > shared/decrypted buffer handling. This series consolidates the
> > force_dma_unencrypted() checks in the top-level functions and ensures
> > that the remaining DMA interfaces use DMA attributes to make the correct
> > decisions.
> 
> Please check Sashiko's reports, it has some good points:
> 
> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
> 
> I think the main one is the swiotlb_tbl_map_single() changes which break
> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
> but force_dma_unencrypted() is false. Normally you'd not end up on this
> path but you can have swiotlb=force.

IMHO that's an AMD issue, not with the design of this series..

The series is right, a device that is !force_dma_decrypted() must be
considerd to be a trusted device and we must never place any DMA
mappings for a trusted device into shared memory.

That AMD has done somethine insane:

bool force_dma_unencrypted(struct device *dev)
{
	/*
	 * For SEV, all DMA must be to unencrypted addresses.
	 */
	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
		return true;

	/*
	 * For SME, all DMA must be to unencrypted addresses if the
	 * device does not support DMA to addresses that include the
	 * encryption mask.
	 */
	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
						dev->bus_dma_limit);

		if (dma_dev_mask <= dma_enc_mask)
			return true;
	}

Is an AMD issue. We already have an address mask limit system built
into the DMA API, arch code should not be co-opting the CC mechanism
to create a special pool for address limited devices.

The correct thing is to ensure the DMA API is checking any address
limits on the actual true dma_addr_t, not on an intermediate like a
phys_addr before it is adjusted with any C bit. Then it is a normal
low address swiotlb bounce like any other.

I think we can ignore this Sashiko remark, in real systems the use of
swiotlb for 64 bit devices is very rare. Though it would be good to
remove this code from AMD...

Jason

