Return-Path: <linuxppc-dev+bounces-22774-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3113BCD98F6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:37:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gh4bd4Bfhz2yRF;
	Fri, 19 Jun 2026 01:37:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781797037;
	cv=none; b=baXv6+HnWxmswEYPn/PCbMs2FBeFBu7sTvrNmqcQQLuMwiiJsqdvehro3VpomyzYkhdK3hf7HrjFi/WS2A3sA9HenznD5dL3XpfaQxb1rAGc4/RdudMIQZcfd2WDXp5/+V8j+JvVcygQgrD9pOGlioH84cvW8P+CdUtiKkQEfvZHjly3mU7p39KcYGstkifn48wX6aRCXJyOVzC7fIi9AZYvbUyboQZ3G5skk2EpaeydP5v52lKsByY3FuZOldYr5WfoM+V6IO212NCFHrI1YJCRN+v1QKCP6jZLjtCZPDa5YrSejhwF4kuNqTbWGYpLYPBY8ZywmTV4CBN+76K5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781797037; c=relaxed/relaxed;
	bh=Tm+jP+3WfoLtXaL6gn2l0sQY+Wj2XqJdxBBXikZyHQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP0qBS688f3pbCY2Mpfq97VoqdKQKhRK4urs+hbFN2heqpMIiOlQ21UUUQXH5is4f6lUy4tFNwkVR+18LyeW306Gs8/n4ess9IwJupOi7+n3wZqu3+UMRKuuM+3PULLRh+oGE1q2rZVG7CpR1ZaJ8V+45sykyuTFV035OX51jRdRwMUhstvhBWTdDyOUpPKpgfnUOY/D1/tbQauACFFs92uLDelBqvPQPSXS+/yaxjkO9yVJzd8ObziNzC/dJrQGlHn5k+VqM1tGuYIH2lXDCdu2WLTO4ALk27UTWVXNeHEw1cejzO5/2tlfGtgcPE/8Egj68ZDj62bmGKU7RGqxZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ReymBpap; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ReymBpap;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gh4bc0krQz2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 01:37:15 +1000 (AEST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-915aa0a9293so241747185a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781797027; x=1782401827; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tm+jP+3WfoLtXaL6gn2l0sQY+Wj2XqJdxBBXikZyHQE=;
        b=ReymBpap+rJj7dw+e83ov91tYjdVuGwIQ9RwbG1Wjs+QMIW3IurZJsbdXSX5oAxm9t
         AFyXLx21W/OyFFsj6spS+dAoQ8imC4oKR+XXRw7jfTaIev1iGb2AteC9elnQmfzvke5/
         T2Guxk8T3p53Ga5YMSDpte66rFAWIhoPf3xCY4cpUfyVsxA3HtLsW+qw7wtI/rz+hlW9
         tG9zj0SVh3NLZFYAQ5FUToY9nksDa1A4g6Z7Cof/2K8vaEAwdN9FFQzaJUHdShs/wJeR
         D37XaTprZ9W01SAW+w7gwAtEmwp3jb4VtaAgueRUzj8CDZEuDuYqiEg38qkKclBN27Mw
         Bagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781797027; x=1782401827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm+jP+3WfoLtXaL6gn2l0sQY+Wj2XqJdxBBXikZyHQE=;
        b=X+zIvIVfgaORwGepzcvOb8C7G6kCBFNfB09bj1gIhu4MIz+NqMN/nwZTXLKhggRWpF
         K1QPEDg7//2VqSl+wpyWA+JA8dh1ur7VWfsN6J51JlxD0MpHUR+IieaMz+E0WNwTQ3e4
         a59Z9A0u/kmPVyJLX645w7TWzzeUp9zdxGBg4GDEkp04aLi0r0+MyFKEVQwHUGeLJz6q
         LSHIXLr+PB/O0GTkEXKyPq8z5NYHxV+M5se4nXy3kZxnc+JeQ4WGDEdiBV4USGxlbeW0
         +JtU5XFwfudqKxaxTBFSvUVzA421rCDeT3aGXNI5202TW7NszUYPDdPy/1lezWha7ha8
         TCGg==
X-Forwarded-Encrypted: i=1; AFNElJ8aHCSlH+pQebKZ8n9XNlYM2ULa0HEZzg1TcUzERs+hunLClOIYUiB96gAEqLigamKHprwGRN6VNmQ0wDI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXzU0Hf3iylUd2BU5STKsa2bVhsJnXLHkSw8rVLiUDW9JUjDw0
	rdtAoXVK/UfSJsE6h4WPmYewhl5ABg6to7g1jZKOqJFH11tafYix7SrnKaWZMXZfXZk=
X-Gm-Gg: AfdE7cknO7VJ8qXxxuV7zo80NX2d3/RSNCQoXu5S+4BVnwO2Dr6nhc/ca6zhl+Jt+IK
	et8mrkl75N8s7xk6g16PEpBJfGvRQ7GOt+3MHB+zt0OGKaZqLVoVUfGKGVDWp/4TS1iiD5SWHf7
	FEnooDWPpzdHQxtvf47pCGr2SMkQp/4/msCYZFCk0bQe2DSEZImZyUt5kiVb2dL9+qfvCVW2j0v
	esChh93+JDmOWmtwTJeIpDQtCiIsgCpU+pIYsindfZpAkhwxAcszhhjKKx9kj/n6U7JBDn4uiaZ
	y0UWIOf73wiZpKqs3Xf0Ya+sGNIrZS390mCQYg7099vpn1nEIU+NqorEaEf4SCdSofZir+PpISv
	RxYh89lBn+xeIeiuKSBjseUvPRoCzLGPnU2n+QfD4Ny4k+IMAMGKq+fXmXsPGbqAWh+Hks0g0KM
	Q74vJm619GM46YAd2+6o2KuzyChKnUvfFmVVwhvtIotw2L3z2yHKLR8Mykt3elc0EAQzo=
X-Received: by 2002:a05:620a:469e:b0:915:8f64:604c with SMTP id af79cd13be357-91f082ff425mr678605385a.15.1781797026718;
        Thu, 18 Jun 2026 08:37:06 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm2104263685a.21.2026.06.18.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:37:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waEnh-00000002tSw-24HO;
	Thu, 18 Jun 2026 12:37:05 -0300
Date: Thu, 18 Jun 2026 12:37:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260618153705.GH231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
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
In-Reply-To: <yq5aqzm4dz25.fsf@kernel.org>

On Thu, Jun 18, 2026 at 09:37:22AM +0100, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
> > On 10/6/26 00:47, Jason Gunthorpe wrote:
> >> On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
> >>> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >>>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> >>>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> >>>> are handled consistently.
> >>>>
> >>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> >>>> shared/decrypted buffer handling. This series consolidates the
> >>>> force_dma_unencrypted() checks in the top-level functions and ensures
> >>>> that the remaining DMA interfaces use DMA attributes to make the correct
> >>>> decisions.
> >>>
> >>> Please check Sashiko's reports, it has some good points:
> >>>
> >>> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
> >>>
> >>> I think the main one is the swiotlb_tbl_map_single() changes which break
> >>> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
> >>> but force_dma_unencrypted() is false. Normally you'd not end up on this
> >>> path but you can have swiotlb=force.
> >> 
> >> IMHO that's an AMD issue, not with the design of this series..
> >> 
> >> The series is right, a device that is !force_dma_decrypted() must be
> >> considerd to be a trusted device and we must never place any DMA
> >> mappings for a trusted device into shared memory.
> >
> > swiotlb=force forces swiotlb, not decryption.

If force_dma_decrypted() == true then swiotlb must allocate from a
decrypted memory pool. It is right there in the name!

The hypervisor environment should *never* set force_dma_decrypted()
because all devices can access all hypervisor memory, up to their IOVA
limits.

> > So when I try "mem_encrypt=on iommu=pt swiotlb=force" with this
> > patchset, it fails to boot. But it boots with a hack like this:

On the host side I expect this to cause swiotlb to allocate encrypted
memory and bounce to it.

>  		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>  		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>  						dev->bus_dma_limit);
> +		/*
> +		 * With memory encryption enabled, SWIOTLB is marked decrypted.
> +		 * If SWIOTLB bouncing is forced, treat the device as requiring
> +		 * decrypted DMA.
> +		 */

And this is more insane logic. The right fix is to allocate the
swiotlb bounce from the *encrypted* pools when running on the
hypervisor which requires undoing this abuse of force_dma_decrypted().

Jason

