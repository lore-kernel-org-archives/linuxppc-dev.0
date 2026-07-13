Return-Path: <linuxppc-dev+bounces-24145-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C178C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:42:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXrs5LKLz2y8p;
	Tue, 14 Jul 2026 05:42:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::729"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971741;
	cv=none; b=RA0v1IRkKZ4Ia1oDRK7gWQtjVNRggHbdp8JzAfkPUpXYWJzkCaW6U9d+LTMuCskgW8JCeDYx/ltnoqO5y3dRulxS5WUhhsff50944n9SMQUxMg4Z5fVu+jAVDPovU574ApnCviICj3uqBTOILpAc8bp5HtaqXRUqUixLGSeAPkhnXH/stRnvHRSRcViCUFUmZ+5maU17JKhxTbqQOhGqNm6o+73CshAZBRFOTdIsLQUVJE8Eeox0ADSi2Uhvmwu4Cj2sNdlEY464GZMh/0yDYrJiZPGrh/eivXiyxYW81UNeTn+H+4giBW0Src9zL3C3i9RWKGyh34lnD51Kya2uTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971741; c=relaxed/relaxed;
	bh=q5KluJxuBWim2YOI+gCMldEdZU/bLOQ3tr992AX6OwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcQAIxupp/8NXyQcKcvWCtcPQ+Oix0aYLreEvKT5/lLboT+ysvtR6ydB98MFFfE9kWFBMrH7CfhpI7sCbAD5cw0fUJ2Oi0bbVhB8ouyq7kEM29/mcY1M1An09tVoDeFgAdOpmfzA3KYn7kGyeOQLD7JmtvZM4Lab8/6iumGYMJEzMzbxu+dPKTenULq0jgBsuH852GIlWMRC2GdqqecaHl6jfxq4vPR9lhYQj3erpFcXn52qHLHuEnF3PvM6qqCwbPxTs2Tp/5bfM3ZkaziC/Z87qGMlihro9h5432FlC3bqID6v7XvhXvor+3BD4kXBzaCO3GA3ZJFVs6o+4pAiZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Id1gHbmc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Id1gHbmc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXrr6G0tz2y1F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:42:20 +1000 (AEST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-92e5d50b0dbso16621085a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971738; x=1784576538; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5KluJxuBWim2YOI+gCMldEdZU/bLOQ3tr992AX6OwE=;
        b=Id1gHbmcwo86DSZMNPObvHKLk8HMpNTPMcAAdmI5KIjSOrlDNhTExjrQf/2YpXY51X
         hSrnYn7mcqAfvnDKmbuWv6IQYvAtNT1z/RtIyVOIbK2Gwh0zXPP3Pil0TlEiyYVxjaWq
         SmI0SKTL+NbULJFRSW8Edtcm9gzM1QN9AYS5T1A/fvKxLFzjvCBGPm9MrCGkfF0CXxLS
         xUhW+v99xqvtG3HTClHfXNJ0YHCjJoDabMgop2A88Pe/ii911VWLq0cxGklpLXrIPN5P
         qvhbFzc4l/6r5MjQMcu1GoymerQQK4ZByDsU4eUrvFr7T0yCvjmRPegdmfNokFQ86i+G
         cNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971738; x=1784576538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5KluJxuBWim2YOI+gCMldEdZU/bLOQ3tr992AX6OwE=;
        b=Mc2fwPorE2+Q6gsjxs7OrvSx9dQY4wygBeeQSXBIIjGydax0qm3aUqe6l4V3JwczKr
         QOkDQFgAN/7CpLKW/66Ta2q/rSAw5C28NEboVghhtWxcEQX55aJOkcCMn2if5X3917Fz
         W16+vcQdTaqX/lTvXwwthfEVfpgFloNzCiyNOzwenGDvj+q/4Rr3ZVME5qRhjuZPknKS
         aJ1jK4StM+eVqz9zAWJt0g+3ZL7ed7SfeJ40m3DGLbnap+KvkzMKZSpGCS+5XIZDxCbf
         DeHIbHqEuqK+tldfoGQvBs9JhUigXNq9GJINgzzEpiVzXvQ90psQJSmrmb1QvpNGmCUa
         BEhA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/EwF2GW0wpKtEmAgDjw2xEvM3iyZ7QNHbksbOVMBjfz88YWx8Ugwuj5dhHoU19/f/rsrrBR/OJgcdEi8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIcrE3+jZ7BQ/1/VDRv/GT8KjhBJrMO4DqQY6Ut0pkjn5BqY1F
	AD/hBJAyq3Ni+uLqCSJxyRi51VP+XzaP3LGMxNTIYJq3WP3EXreRQ3W1So8XTTZ38/E=
X-Gm-Gg: AfdE7ck2O/jGimCCaAH3fd6Ra8sU+3wfdAYOHx23unqSwx7SRF0K69yzES5jYe3p5JF
	oN2cj5xEclyQoPqg8p3xaRwDj+nHRvsWC3F5V4ShQk4iVxSwoYfPlEjWAHskbk/B8Rr8N3cNcq4
	Wokihyk9Mqm7p8EpS1RKPobZAY+fRtGwgr/UjvvMHnYzM2qRmuPacV00Sb8i0hoH4PETuPt71fV
	X1z5rbtzaB5PsHsjTHtvFwulMJ4jP5gxhqneXB3rWSdGzNVvE5ciOfa+ngr5zwD2mYIqRYb4zv7
	9JzDoQ+i1KAC0Dx7YDnX6FhhL9tJrZEArizFmUq/uEK7o4CriouExrzpv9ESl2+gIUO+OtqA+XV
	m3y3YMqtSzutbLzgLEqjKhtujrqaJRCT1JnSdWbCFGCU2IPtXasKw2sI6FBB3
X-Received: by 2002:a05:620a:262a:b0:92b:d4e3:1f08 with SMTP id af79cd13be357-92ef2bcc2e9mr1042196885a.55.1783971738155;
        Mon, 13 Jul 2026 12:42:18 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm1154048285a.38.2026.07.13.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:42:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMXh-0000000E6o6-0etu;
	Mon, 13 Jul 2026 16:42:17 -0300
Date: Mon, 13 Jul 2026 16:42:17 -0300
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
Subject: Re: [PATCH v7 21/22] dma: swiotlb: handle set_memory_decrypted()
 failures
Message-ID: <20260713194217.GA3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-22-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-22-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:25AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Check the return value when converting swiotlb pools between encrypted and
> decrypted mappings. If the default pool cannot be decrypted after early
> initialization, mark the pool fully used so it cannot satisfy future bounce
> allocations.
> 
> For late initialization, return the `set_memory_decrypted()` failure. For
> restricted DMA pools, fail device initialization if the reserved pool
> cannot be decrypted.
> 
> This prevents swiotlb from using pools whose encryption attributes do not
> match their metadata, and avoids returning pages with uncertain encryption
> state back to the allocator.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 80 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 15 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

