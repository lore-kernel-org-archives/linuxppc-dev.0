Return-Path: <linuxppc-dev+bounces-22466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5908ACD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 05:26:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbWMc5wqTz2yv2;
	Thu, 11 Jun 2026 15:26:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781155564;
	cv=none; b=ilNLCDc3LbAYYropzALqo0T66BzBse9yV35VFCWtamD13Gh5hYISEaD0FbWvKTvGbhVauFLKH+v2/qvX5rptvMDAN4hhlxpw7Iw9jAzDiITs/s2EY2E9dlN0rvEBhj/EIOY+lAaWCxBoolYV+vuJOVCAv5OQn6XVlGFu2GkK6zUeOZr5y5rKnr/Pw4esw6pd7bVjdREpc71NbYDs9gI2zkzfqzvmL7aH10I1WxOwrNoDB8INg4D9Bot052w0rfR6aOMM+X4bJ/gFDhYbedxb6G9nGPn+2H+gEi+mu791zWrP+iqfEVUrp+06Nh2a37ktZVgRNvRzW+WPpUcvuvXVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781155564; c=relaxed/relaxed;
	bh=XDuIn3y/rCO4r9DXHWsg+1RIZVo9GqzNtV1PP4apQRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZ7vapvYBJ+oxUHxeajYfTUABDRZNYrzm3f25PCkcL7eO3JuV0fu7+heX0FGv1pRUlgfNfN5D3u7eySXIlxFe+JyLbVw7MnWHM6PufhUza9g9+qZ0Z7ZEjyN8taB+l0GHNFfr3r0V73sgUbE5+WnlYA5h2c7ZV//yUBgJ32PNJHZ1DDwAsn9SkhWp9Oh2taAOSlEPeb/n/rLWYh4YP4LQGc5s8DtUqE//5VCotihZ7uSP9xhNvIdxkMFZAIDHvch0+pGUrSB1FGUTIwE8eeMlwkHnk7ImOF8EI+2M40onOo4DJJJ7H9CYRPtpOj2c2fvX9Rm6z9AUSXBt7lpfLiuAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3lWXQ1e; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3lWXQ1e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbWMb6zRFz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 15:26:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B3DFF60209;
	Thu, 11 Jun 2026 05:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A794D1F00893;
	Thu, 11 Jun 2026 05:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781155561;
	bh=XDuIn3y/rCO4r9DXHWsg+1RIZVo9GqzNtV1PP4apQRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=G3lWXQ1eDa81mBrJCkA/PCQooKDKZDvbt48avgp0O6fw29Xx6sKxbhO5qZnkxZ4u9
	 OxKbgbkMquVdngJ8SPiyWyre/tflzFPwaxG9vTOH79OGqlciuGssBF34DWyso1CHZw
	 aDVLXDoti3JcbI9D0Oi2cQfQuhj+pJ3kbX4EYy4Xe2MEKUwpaADT61w7nEgRm3kwLM
	 tSP+LAKWvEyh/ut0Dg4osfZsHaat6KgXBk/q1moX91KKeOfFQmsmWMabYftzxu7D6x
	 6RhvniODTNH6y39Z5sFE58ao01nIDFW6k3pW4yaiik4r+mgNv+m7xs7Nex2pRFVN0z
	 TxODrAxyW9DsA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <20260609143242.GK2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
Date: Thu, 11 Jun 2026 10:55:47 +0530
Message-ID: <yq5aa4t1myw4.fsf@kernel.org>
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

Jason Gunthorpe <jgg@ziepe.ca> writes:

> The sashiko note does look legit though:
>
> 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> 	    !gfpflags_allow_blocking(gfp) && !coherent) {
> 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> 					   gfp, attrs, NULL);
> 		if (!page)
> 			return NULL;
>
> I don't see anything doing the force_dma_unencrypted test along this
> callchain..
>
> I guess it should be done one step up in dma_alloc_attrs() instead of
> in dma_direct_alloc()?
>

I think we should do something similar to what dma_map_phys() does here,
considering that we only support DMA direct with DMA_ATTR_CC_SHARED/DMA_ATTR_ALLOC_CC_SHARED.

@@ -637,6 +637,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
+	bool is_cc_shared;
 
 	WARN_ON_ONCE(!dev->coherent_dma_mask);
 
@@ -657,8 +658,17 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
+	if (force_dma_unencrypted(dev))
+		attrs |= DMA_ATTR_ALLOC_CC_SHARED;
+
+	is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
+
 	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
+	} else if (is_cc_shared) {
+		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
+				attrs);
+		return NULL;
 	} else if (use_dma_iommu(dev)) {
 		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
 	} else if (ops->alloc) {

-aneesh

