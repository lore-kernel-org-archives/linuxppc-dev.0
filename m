Return-Path: <linuxppc-dev+bounces-22469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D22CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 05:53:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbWyx4MGdz3bqs;
	Thu, 11 Jun 2026 15:53:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781157193;
	cv=none; b=oN+BMswFKai5Oxxpgce0+m48Z9WF/Cci5eP7N8jSvx3OFByt90yKDddGFSK6PK5Ky+8WGL+LYCI17KDxZ7e1iUkbalFUKCGuZw6OgCikKJbjhK7G3joniQOudiPTXlEASzL3IX2Xu0bJRNPu5qwRLTThMVGihJeE3Om/AVkpmMeKhXftxxztSHJlp4D34/9+t2csyisepgH1M90Fjhry56wetCzNAdwuOsCn6UI6KR97I/ipYgOH+gS6OkD9S5kYC4E8nvNK4FWJFWZdMgbWQtSv/XpoxhmomiCUYCO2EH1xqfB42W8JZxhYIovSy/Ghl+jBMql7Kd5lw74s7H2LyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781157193; c=relaxed/relaxed;
	bh=sEJIr+lPP3nXLw5RoJcEfwsXvE/NpV/RD/uYgu3QwbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=njxmt2CEoSOyTuHUb0t9UtF2EEhdkJ+xsFM0mECD593uLPbe+rM90LE+O/Lh0BRfSvIjN0zn4yOoz7dp2ukC5JvLf6OMHfKmyjLqmTZWSnkHcUoboY+1FHnxj+nh5llyIX0+Xqp/vnVLJ25akIsjNMqNYpRDpRKjikehv3NCFHMeh2ezMz+BUPqAjst2ixjN7OPpzzPbf/EvGKExGFxtgelVaArNRVholgeQUdavSbLXC4qoyUbklwaq7uKzFl7QGxegn/fPKWyND0g3buS+eD63yEkBhcIPolC/+leNoKMLRdpdpW/ybcBAhHAGjQT9Mf8Gc6oUrDtLDMlXK9UqiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZ9uqd0d; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZ9uqd0d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbWyw49Z5z3bpt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 15:53:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B20E843F5F;
	Thu, 11 Jun 2026 05:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26861F00893;
	Thu, 11 Jun 2026 05:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781157189;
	bh=sEJIr+lPP3nXLw5RoJcEfwsXvE/NpV/RD/uYgu3QwbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LZ9uqd0d7apZX5IQP570+CH5enEWdE4i/rnlALBpkVng1ymyhtm8Xo+CXf6k/jI/T
	 PzpwXj8C9y8lPg0EqG2BmAmqvWycVYScBZuIOoexVWPDlJk0h1k2YtyuMWTIEir5xp
	 Ac4imUykBKZf2Ir12ie18URAbLEGxAwTs9dH2Dxho0ZHxwerBlBud5rW5fw3RHgiRq
	 i/QEsYYPYoHhorZg7TrBTtbB0mfEqQbWSxRo0bNMNkbnl1n/CpGi3B/5x9taOYPW/9
	 Jlp+saSSz66Cto6HSo5gt0et9Sna0FPZZpDrNpcs8qWkQ2M2f2JHnCKYHvPpdPdNSY
	 WoypcSrVXBZRg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
In-Reply-To: <aigYbK12D8uKQvJF@arm.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
Date: Thu, 11 Jun 2026 11:22:56 +0530
Message-ID: <yq5a7bo5mxmv.fsf@kernel.org>
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
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>> are handled consistently.
>> 
>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>> shared/decrypted buffer handling. This series consolidates the
>> force_dma_unencrypted() checks in the top-level functions and ensures
>> that the remaining DMA interfaces use DMA attributes to make the correct
>> decisions.
>
> Please check Sashiko's reports, it has some good points:
>
> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
>
> I think the main one is the swiotlb_tbl_map_single() changes which break
> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
> but force_dma_unencrypted() is false. Normally you'd not end up on this
> path but you can have swiotlb=force.
>

I would consider the above similar to a trusted device requiring swiotlb
bouncing. At some point, based on real-world use cases, we may need to
add protected io_tlb_mem pools. We have not done that yet because no
such use case has come so far.

-aneesh

